/*
 * get email template from keycloak selected theme files
 */
package com.ubs;

import org.keycloak.email.EmailException;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.theme.FreeMarkerException;
import org.keycloak.theme.FreeMarkerUtil;
import org.keycloak.theme.Theme;
import org.keycloak.theme.beans.MessageFormatterMethod;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

public class EmailTemplateHandler {
    protected KeycloakSession session;
    protected FreeMarkerUtil freeMarker;
    protected UserModel user;
    protected RealmModel realm;

    /**
     *
     * @param session
     * @param freeMarker
     * @param user
     * @param realm
     */
    public EmailTemplateHandler(KeycloakSession session, FreeMarkerUtil freeMarker, UserModel user, RealmModel realm) {
        this.session = session;
        this.freeMarker = freeMarker;
        this.user = user;
        this.realm = realm;
    }
    
    /**
     *
     * @param subjectKey
     * @param subjectAttributes
     * @param template
     * @param attributes
     * @return
     * @throws EmailException
     */
    public EmailTemplate processTemplate(String subjectKey, List<Object> subjectAttributes, String template, Map<String, Object> attributes) throws EmailException {
        try {
            Theme theme = getTheme();
            Locale locale = session.getContext().resolveLocale(user);
            attributes.put("locale", locale);
            Properties rb = theme.getMessages(locale);
            Map<String, String> localizationTexts = realm.getRealmLocalizationTextsByLocale(locale.toLanguageTag());
            rb.putAll(localizationTexts);
            attributes.put("msg", new MessageFormatterMethod(locale, rb));
            attributes.put("properties", theme.getProperties());
            String subject = new MessageFormat(rb.getProperty(subjectKey, subjectKey), locale).format(subjectAttributes.toArray());
            String textTemplate = String.format("text/%s", template);
            String textBody;
            try {
                textBody = freeMarker.processTemplate(attributes, textTemplate, theme);
            } catch (final FreeMarkerException e) {
                throw new EmailException("Failed to template plain text email.", e);
            }
            String htmlTemplate = String.format("html/%s", template);
            String htmlBody;
            try {
                htmlBody = freeMarker.processTemplate(attributes, htmlTemplate, theme);
            } catch (final FreeMarkerException e) {
                throw new EmailException("Failed to template html email.", e);
            }

            return new EmailTemplate(subject, textBody, htmlBody);
        } catch (Exception e) {
            throw new EmailException("Failed to template email", e);
        }
    }

    /**
     *
     * @return
     * @throws IOException
     */
    protected Theme getTheme() throws IOException {
        return session.theme().getTheme(Theme.Type.EMAIL);
    }
}
