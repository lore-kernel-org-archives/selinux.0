Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MJOUgA018726
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 15:24:30 -0400 (EDT)
Subject: Re: Cleanup of chkpwd and su macros
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200504221052.39248.russell@coker.com.au>
References: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil>
	 <200504211349.05832.russell@coker.com.au>
	 <1114090175.8132.40.camel@moss-lions.epoch.ncsc.mil>
	 <200504221052.39248.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 15:20:15 -0400
Message-Id: <1114197615.10476.47.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-22 at 10:52 +1000, Russell Coker wrote:
> On Thursday 21 April 2005 23:29, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > > > Index: macros/program/chkpwd_macros.te
> > > > -can_kerberos(auth_chkpwd)
> > > > -can_ldap(auth_chkpwd)
> > > > -can_resolve(auth_chkpwd)
> > >
> > > Why do you remove those?  I expect that any daemon that needs access to
> > > run unix_chkpwd will need to check account data by LDAP and other means.
> > >
> > > I don't have a test network for this at the moment though.
> >
> > They were removed because the system_chkpwd_t domain (the auth_chkpwd
> > attribute is only for system domains) already has the permissions.  The
> > can_getcon, can_ypbind, can_kerberos, can_ldap, and can_resolve macros
> > are already used for $1_chkpwd_t earlier in the chkpwd_domain macro.
> >
> > Now it may be true that the caller needs these permissions, but if they
> > do, I don't think that the permissions should be buried in the
> > auth_chkpwd attribute.
> 
> system_chkpwd_t is only used when the application calls pam_unix.so which 
> executes unix_chkpwd if it can't open /etc/shadow.  For sources of password 
> data other than /etc/shadow system_chkpwd_t will not be used.
> 

If the permissions are only needed when unix_chkpwd is not executed and
system_chkpwd_t is not used, then why grant them in the chkpwd_domain
macro in an ifelse statement where permissions specific to
system_chkpwd_t are granted?

> Where do you think that the permissions should be if not the auth_chkpwd 
> attribute?
> 

How about a can_authenticate macro?

Another option would be to add the permissions directly to the domains.

Here is the list of domains that have the auth_chkpwd attribute:
(* - already uses can_ypbind, + - already uses can_kerberos)
sysadm_userhelper_t *
sysadm_sudo_t *
user_userhelper_t *
user_sudo_t *
staff_userhelper_t *
staff_sudo_t *
courier_authdaemon_t
crond_t *
cupsd_t
dovecot_auth_t
ftpd_t
local_login_t *
remote_login_t
mailman_queue_t *
newrole_t *
chfn_t
portslave_t *
rlogind_t * +
rshd_t * +
smbd_t *
saslauthd_t
sshd_t +
sshd_extern_t +
imapd_t
winbind_t +
xdm_t

If it seems like the best answer is to keep these permissions with
chkpwd, then at least they should be pulled out of the macro so it is
clear that they are not needed for system_chkpwd_t (which already has
them), but for the calling domains.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
