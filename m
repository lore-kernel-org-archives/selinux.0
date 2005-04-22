Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3N03JgA020201
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 20:03:19 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MNtGrf005711
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 23:55:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: Cleanup of chkpwd and su macros
Date: Sat, 23 Apr 2005 09:57:56 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil> <200504221052.39248.russell@coker.com.au> <1114197615.10476.47.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1114197615.10476.47.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504230957.58583.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 23 April 2005 05:20, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > > They were removed because the system_chkpwd_t domain (the auth_chkpwd
> > > attribute is only for system domains) already has the permissions.  The
> > > can_getcon, can_ypbind, can_kerberos, can_ldap, and can_resolve macros
> > > are already used for $1_chkpwd_t earlier in the chkpwd_domain macro.
> > >
> > > Now it may be true that the caller needs these permissions, but if they
> > > do, I don't think that the permissions should be buried in the
> > > auth_chkpwd attribute.
> >
> > system_chkpwd_t is only used when the application calls pam_unix.so which
> > executes unix_chkpwd if it can't open /etc/shadow.  For sources of
> > password data other than /etc/shadow system_chkpwd_t will not be used.
>
> If the permissions are only needed when unix_chkpwd is not executed and
> system_chkpwd_t is not used, then why grant them in the chkpwd_domain
> macro in an ifelse statement where permissions specific to
> system_chkpwd_t are granted?

That sounds correct, system_chkpwd_t shouldn't need access to kerberos, ldap, 
etc.  I suspect that there may be more to it than this, so we'll want to do 
some tests, but for the moment I think removing such rules is the right thing 
to do.

> > Where do you think that the permissions should be if not the auth_chkpwd
> > attribute?
>
> How about a can_authenticate macro?

I agree, we should have two attributes, can_authenticate would do auth_chkpwd 
plus the LDAP stuff.

> Another option would be to add the permissions directly to the domains.

No, that will be a pain to manage.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
