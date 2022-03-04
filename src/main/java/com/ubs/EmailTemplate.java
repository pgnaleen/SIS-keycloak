/*
 * email template used for sending email when account is locked
 */
package com.ubs;

public class EmailTemplate {

    private final String subject;
    private final String textBody;
    private final String htmlBody;

    /**
     *
     * @param subject
     * @param textBody
     * @param htmlBody
     */
    public EmailTemplate(String subject, String textBody, String htmlBody) {
        this.subject = subject;
        this.textBody = textBody;
        this.htmlBody = htmlBody;
    }

    public String getSubject() {
        return subject;
    }

    public String getTextBody() {
        return textBody;
    }

    public String getHtmlBody() {
        return htmlBody;
    }
}
