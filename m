Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KK51rT020606
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 16:05:01 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KK50T2012602
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 20:05:00 GMT
Subject: Re: Policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409172207.21788.russell@coker.com.au>
References: <200409162151.44819.russell@coker.com.au>
	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
	 <414A0454.2060304@redhat.com>  <200409172207.21788.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095710635.3225.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 16:03:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, except for the userhelper_macros.te chunk.

The attribute privuser is always needed by userhelper since the current code always switches to
"root".

diff -ru /usr/src/se/policy/macros/program/userhelper_macros.te macros/program/userhelper_macros.te
--- /usr/src/se/policy/macros/program/userhelper_macros.te      2004-09-11 16:21:48.000000000 +1000
+++ macros/program/userhelper_macros.te 2004-09-11 19:24:48.000000000 +1000
@@ -17,7 +17,7 @@
 ifdef(`single_userdomain', `
 typealias $1_t alias $1_userhelper_t;
 ', `
-type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser;
+type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
 
 in_user_role($1_userhelper_t)
 role sysadm_r types $1_userhelper_t;

On Fri, 2004-09-17 at 08:07, Russell Coker wrote:
> +dontaudit updfstab_t home_root_t:dir { getattr search };
> +dontaudit updfstab_t { home_dir_type home_type }:dir { search };
> 
> Why is fstab-sync trying to access home directories?
> 
> +allow ttyfile tmpfs_t:filesystem { associate };
> 
> Better to just use the dev_fs attribute.  I have attached a patch to do this 
> as well as clean up a few other minor issues with the macros directory.
> 
> The patch is against the latest CVS.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
