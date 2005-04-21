Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3L3s67C006353
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 23:54:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3L3kNJK023901
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 03:46:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: Cleanup of chkpwd and su macros
Date: Thu, 21 Apr 2005 13:49:02 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1114003815.31519.24.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504211349.05832.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 20 April 2005 23:30, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> Index: macros/program/chkpwd_macros.te
> -can_kerberos(auth_chkpwd)
> -can_ldap(auth_chkpwd)
> -can_resolve(auth_chkpwd)

Why do you remove those?  I expect that any daemon that needs access to run 
unix_chkpwd will need to check account data by LDAP and other means.

I don't have a test network for this at the moment though.

> Here are the changes to the su macros.  user_su_t definitely needs the
> "allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;"
> rule, but now that I look at it again I don't know why I put it in the
> ifdef.  The ifdef is not really needed anyway since chkpwd.te is in
> domains/program, not domains/program/unused.

I think it's a good procedure to have the ifdef's.  It'll make things easier 
if we need to make unexpected changes later on.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
