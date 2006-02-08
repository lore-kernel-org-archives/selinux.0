Message-ID: <20060208130613.7417.qmail@web51501.mail.yahoo.com>
Date: Wed, 8 Feb 2006 05:06:13 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] add version option to newrole
To: Glauber de Oliveira Costa <glommer@br.ibm.com>, Selinux@tycho.nsa.gov
In-Reply-To: <200602080934.33613.glommer@br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>@@ -10,7 +10,7 @@
>  *
>  * USAGE:
>  *
>- * newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]
>+ * newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]
>  *
>  * BUILD OPTIONS:
>  *

Args doesn't sound descriptive to me.

>diff -upNr policycoreutils-1.29.18/newrole/version.h 
>policycoreutils-1.29.18.mine/newrole/version.h
>--- policycoreutils-1.29.18/newrole/version.h	1969-12-31 21:00:00.000000000
>-0300
>+++ policycoreutils-1.29.18.mine/newrole/version.h	2006-02-07
>16:15:47.000000000 
>-0200
>@@ -0,0 +1,4 @@
>+
>+#ifndef VERSION
>+#define VERSION "1.29.18"
>+#endif

Version is traditionally kept in config.h or the makefiles. The version isn't
unique to newrole. there are other apps in the same package that have the same
version number. If we do one, we should do them all and put the definition in a
central location like the toplevel Makefile.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
