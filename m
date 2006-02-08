From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] add version option to newrole
Date: Wed, 8 Feb 2006 11:32:53 -0200
Cc: Selinux@tycho.nsa.gov
References: <20060208130613.7417.qmail@web51501.mail.yahoo.com>
In-Reply-To: <20060208130613.7417.qmail@web51501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602081132.53649.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve, thanks a lot for your comments,

Em Quarta 08 Fevereiro 2006 11:06, Steve G escreveu:
> >@@ -10,7 +10,7 @@
> >  *
> >  * USAGE:
> >  *
> >- * newrole [ -r role ] [ -t type ] [ -l level ] [ -- args ]
> >+ * newrole [ -r role ] [ -t type ] [ -l level ] [ -v ] [ -- args ]
> >  *
> >  * BUILD OPTIONS:
> >  *
>
> Args doesn't sound descriptive to me.

What do you suggest instead? -v is what is commonly associated with version 
options in most programs.

> >diff -upNr policycoreutils-1.29.18/newrole/version.h
> >policycoreutils-1.29.18.mine/newrole/version.h
> >--- policycoreutils-1.29.18/newrole/version.h	1969-12-31
> > 21:00:00.000000000 -0300
> >+++ policycoreutils-1.29.18.mine/newrole/version.h	2006-02-07
> >16:15:47.000000000
> >-0200
> >@@ -0,0 +1,4 @@
> >+
> >+#ifndef VERSION
> >+#define VERSION "1.29.18"
> >+#endif
>
> Version is traditionally kept in config.h or the makefiles. The version
> isn't unique to newrole. there are other apps in the same package that have
> the same version number. If we do one, we should do them all and put the
> definition in a central location like the toplevel Makefile.

See my mail. I stated that if the option is of interest, I may implement it in 
these other packages. This first patch was just an initial attempt. A 
version.h (though auto-generated as Stephen suggested) is still my choice. 
But I'll take a look about putting it in the Makefile. My main concern is 
being able to compile it from newrole (or whatever) directory, not from the 
top level one.
 
> -Steve

Thanks again,

glauber.

> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
