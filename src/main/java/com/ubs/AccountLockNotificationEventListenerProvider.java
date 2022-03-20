/*
 * listener to send email notifications when there is brute force login happened
 */
package com.ubs;

import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationProcessor;
import org.keycloak.authentication.actiontoken.resetcred.ResetCredentialsActionToken;
import org.keycloak.common.util.Time;
import org.keycloak.email.DefaultEmailSenderProvider;
import org.keycloak.email.EmailException;
import org.keycloak.email.freemarker.beans.ProfileBean;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.*;
import org.keycloak.services.managers.BruteForceProtector;
import org.keycloak.sessions.AuthenticationSessionCompoundId;
import org.keycloak.sessions.AuthenticationSessionModel;
import org.keycloak.theme.FreeMarkerUtil;

import javax.ws.rs.core.UriBuilder;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

//                    really we don't need this listener we can set this inside SISBruteForceProtector in service class
public class AccountLockNotificationEventListenerProvider implements EventListenerProvider {
    private static final Logger logger = Logger.getLogger(AccountLockNotificationEventListenerProvider.class);
    private final KeycloakSession session;
    private final RealmProvider model;

    public AccountLockNotificationEventListenerProvider(KeycloakSession session) {
        this.session = session;
        this.model = session.realms();
    }

    @Override
    public void onEvent(Event event) {
        if (EventType.LOGIN_ERROR.equals(event.getType())) {
            logger.info("logging event");
            if (event.getError().equals("invalid_user_credentials") ||
                    event.getError().equals("user_disabled")) {
                logger.info("invalid_user_credentials event or user_disabled event triggered.....");
                RealmModel realm = session.realms().getRealm(event.getRealmId());

                UserModel user = session.users().getUserById(realm, event.getUserId());
                boolean isTempDisabled = session.getProvider(BruteForceProtector.class).isPermanentlyLockedOut(
                        session, realm, user);
                logger.info(isTempDisabled);

                UserLoginFailureModel userLoginFailure = getUserModel(session, event);
                if ( userLoginFailure != null && (userLoginFailure.getNumFailures() == 2) ) {
                    logger.info("failure count is 3 setting verify email action");
//                    really we don't need this listener we can set this inside SISBruteForceProtector in service class
                    user.setEmailVerified(false);// without this verify email action not working
                    user.addRequiredAction(UserModel.RequiredAction.VERIFY_EMAIL);
//                    user.addRequiredAction(UserModel.RequiredAction.UPDATE_PASSWORD);



//                    AuthenticationFlowContext context = session.getContext();
//                    AuthenticationSessionModel authenticationSession = session.getAuthenticationSession();
//                    int validityInSecs = session.getContext().getRealm().getActionTokenGeneratedByUserLifespan(ResetCredentialsActionToken.TOKEN_TYPE);
//                    int absoluteExpirationInSecs = Time.currentTime() + validityInSecs;

                    // We send the secret in the email in a link as a query param.
//                    session.authenticationSessions().getRootAuthenticationSession().getId()
//                    String authSessionEncodedId = AuthenticationSessionCompoundId.fromAuthSession(authenticationSession).getEncodedId();
//                    ResetCredentialsActionToken token = new ResetCredentialsActionToken(user.getId(), user.getEmail(), absoluteExpirationInSecs, null, session.getContext().getClient().getClientId());
//                    String link = UriBuilder
//                            .fromUri(context.getActionTokenUrl(token.serialize( session, session.getContext().getRealm(), null)))
//                            .build()
//                            .toString();
//                    String link = UriBuilder
//                            .fromUri(context.getActionTokenUrl(token.serialize( context.getSession(), context.getRealm(), context.getUriInfo())))
//                            .build()
//                            .toString();






                    try {
                        Map<String, Object> attributes = new HashMap<>();
                        attributes.put("user", new ProfileBean(user));

                        EmailTemplateHandler emailTemplateHandler = new EmailTemplateHandler(session,
                                new FreeMarkerUtil(), user, realm);
                        EmailTemplate email = emailTemplateHandler.processTemplate(
                                "accountLockNotificationSubject", Collections.emptyList(),
                                "account-lock-notification.ftl", attributes);
                        DefaultEmailSenderProvider senderProvider = new DefaultEmailSenderProvider(session);
                        senderProvider.send(session.getContext().getRealm().getSmtpConfig(), user, email.getSubject(),
                                email.getTextBody(), email.getHtmlBody());
                    } catch (EmailException ex) {
                        java.util.logging.Logger.getLogger(AccountLockNotificationEventListenerProvider.class.getName())
                                .log(Level.SEVERE, null, ex);
                    }
                }
            }

        }
    }

    protected UserLoginFailureModel getUserModel(KeycloakSession session, Event event) {
        RealmModel realm = getRealmModel(session, event);
        if (realm == null) return null;
        UserLoginFailureModel user = session.loginFailures().getUserLoginFailure(realm, event.getUserId());
        if (user == null) return null;
        return user;
    }

    protected RealmModel getRealmModel(KeycloakSession session, Event event) {
        RealmModel realm = session.realms().getRealm(event.getRealmId());
        if (realm == null) return null;
        return realm;
    }

    @Override
    public void onEvent(AdminEvent arg0, boolean arg1) {

    }

    @Override
    public void close() {

    }
}
