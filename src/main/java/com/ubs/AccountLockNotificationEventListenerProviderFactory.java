/*
 * create AccountLockNotificationEventListenerProvider class for send emails when account is locked
 * when wrong password attempts. When brute force detection of keycloak is enabled.
 */
package com.ubs;

import org.keycloak.Config;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventListenerProviderFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;

public class AccountLockNotificationEventListenerProviderFactory implements EventListenerProviderFactory {

    public static final String ID = "account_lock_notification_event_listener";

    @Override
    public EventListenerProvider create(KeycloakSession keycloakSession) {
        return new AccountLockNotificationEventListenerProvider(keycloakSession);
    }

    @Override
    public void init(Config.Scope arg0) {

    }

    @Override
    public void postInit(KeycloakSessionFactory arg0) {

    }

    @Override
    public void close() {

    }

    @Override
    public String getId() {
        return ID;
    }

}
