Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA01194
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 22:30:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA24105
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 02:29:03 GMT
Received: from web40008.mail.yahoo.com (web40008.mail.yahoo.com [66.218.78.26])
        by jazzband.ncsc.mil  with SMTP id CAA24101 for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 02:29:02 GMT
Message-ID: <20020714023026.27880.qmail@web40008.mail.yahoo.com>
Date: Sat, 13 Jul 2002 19:30:26 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: selinux-policy
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020714000613.9BB86784C@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Sun, 14 Jul 2002 01:29, you wrote:
> > Also, some suggested new attributes (or appropriate macros)
> > for domains:
> >
> > pam_auth     domain needs to use pam authenticate service
> > pam_account  domain needs to use pam account service
> > pam_session  domain needs to use pam session service
> > pam_password domain needs to use pam change password service
> >
> > and/or
> >
> > pam		domain needs to use one/or more PAM services
> >
> > as well as
> >
> > nss		domain needs to use NSS service
> >
> > As this would mean if the user changes NSS or PAM configuration, for
> > instance to go from /etc/shadow authentication to LDAP authentication
> > or kerberos authentication, they don't need to change every service
> > that requires these services.
> 
> I think that having that many attributes is unnecessary and unweildy.  How 
> about having one attribute to take the place of the nss, pam_account, and 
> pam_session attributes you suggest, as well as having pam_auth and 
> pam_password.

        How about just 'auth'? Or 'auth', 'pam' and 'nss'?

        So far I haven't had to change my policy for authentication, so I
haven't had to take a look at any of this.

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! Autos - Get free new car price quotes
http://autos.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
