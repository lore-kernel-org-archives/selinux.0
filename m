Subject: selinux_check_passwd_access() behaviour when passwd class does not
 exist
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 02 Nov 2009 23:43:58 +0100
Message-Id: <1257201838.24413.20.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello !

The current behaviour of selinux_check_passwd_access() is to succeed
even if the "passwd" class does not exist (see checkAccess.c:21). Is
this really the intended behaviour ??

It would make more sense if it failed in such case (as in
mapping.c:66)... Or am I wrong ?

Guido Trentalancia



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
