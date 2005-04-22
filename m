Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M0vU7C013225
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 20:57:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M0ncVU008092
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 00:49:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: Cleanup of chkpwd and su macros
Date: Fri, 22 Apr 2005 10:52:35 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil> <200504211349.05832.russell@coker.com.au> <1114090175.8132.40.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1114090175.8132.40.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221052.39248.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 21 April 2005 23:29, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > > Index: macros/program/chkpwd_macros.te
> > > -can_kerberos(auth_chkpwd)
> > > -can_ldap(auth_chkpwd)
> > > -can_resolve(auth_chkpwd)
> >
> > Why do you remove those?  I expect that any daemon that needs access to
> > run unix_chkpwd will need to check account data by LDAP and other means.
> >
> > I don't have a test network for this at the moment though.
>
> They were removed because the system_chkpwd_t domain (the auth_chkpwd
> attribute is only for system domains) already has the permissions.  The
> can_getcon, can_ypbind, can_kerberos, can_ldap, and can_resolve macros
> are already used for $1_chkpwd_t earlier in the chkpwd_domain macro.
>
> Now it may be true that the caller needs these permissions, but if they
> do, I don't think that the permissions should be buried in the
> auth_chkpwd attribute.

system_chkpwd_t is only used when the application calls pam_unix.so which 
executes unix_chkpwd if it can't open /etc/shadow.  For sources of password 
data other than /etc/shadow system_chkpwd_t will not be used.

Where do you think that the permissions should be if not the auth_chkpwd 
attribute?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
