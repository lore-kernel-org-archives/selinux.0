Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3LDXU7C008725
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 09:33:31 -0400 (EDT)
Subject: Re: Cleanup of chkpwd and su macros
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200504211349.05832.russell@coker.com.au>
References: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil>
	 <200504211349.05832.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 09:29:35 -0400
Message-Id: <1114090175.8132.40.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-21 at 13:49 +1000, Russell Coker wrote:
> On Wednesday 20 April 2005 23:30, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > Index: macros/program/chkpwd_macros.te
> > -can_kerberos(auth_chkpwd)
> > -can_ldap(auth_chkpwd)
> > -can_resolve(auth_chkpwd)
> 
> Why do you remove those?  I expect that any daemon that needs access to run 
> unix_chkpwd will need to check account data by LDAP and other means.
> 
> I don't have a test network for this at the moment though.
> 
> > Here are the changes to the su macros.  user_su_t definitely needs the
> > "allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;"
> > rule, but now that I look at it again I don't know why I put it in the
> > ifdef.  The ifdef is not really needed anyway since chkpwd.te is in
> > domains/program, not domains/program/unused.
> 
> I think it's a good procedure to have the ifdef's.  It'll make things easier 
> if we need to make unexpected changes later on.
> 

They were removed because the system_chkpwd_t domain (the auth_chkpwd
attribute is only for system domains) already has the permissions.  The
can_getcon, can_ypbind, can_kerberos, can_ldap, and can_resolve macros
are already used for $1_chkpwd_t earlier in the chkpwd_domain macro.

Now it may be true that the caller needs these permissions, but if they
do, I don't think that the permissions should be buried in the
auth_chkpwd attribute.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
