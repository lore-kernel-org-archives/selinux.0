Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8J81KrT011321
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 04:01:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8J80J2w018048
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 08:00:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [PATCH] Gentoo-specific initrc
Date: Sun, 19 Sep 2004 18:01:05 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1095381586.735.30.camel@gorn.pebenito.net>
In-Reply-To: <1095381586.735.30.camel@gorn.pebenito.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BzTTBFGebuzrDw4"
Message-Id: <200409191801.05094.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_BzTTBFGebuzrDw4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 17 Sep 2004 10:39, Chris PeBenito <pebenito@gentoo.org> wrote:
> Here's a patch for Gentoo-specific initrc, against sourceforge CVS.

+allow initrc_t initrc_state_t:lnk_file { create read unlink setattr };
+allow initrc_t initrc_state_t:file create_file_perms;
+allow initrc_t initrc_state_t:dir { add_name remove_name read write rmdir 
create rename setattr };

Why not create_dir_file(initrc_t, initrc_state_t)?  It does the same things 
and is easier to read.


+allow initrc_t etc_runtime_t:dir read;

Your patch doesn't include any .fc entries to label a directory as 
etc_runtime_t.  Also the only reference to etc_runtime_t:dir in the CVS seems 
to be in macros/program/rssh_macros.te (a bug in rssh_macros.te, I've 
attached a patch to fix it).

It seems that your patch is incomplete in this regard.

+domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)

This isn't something I expected, I'm not sure if it's desirable to do it like 
that but I can't think of any better way.  Steve, what do you think about 
this?


The initrc_state_t stuff is something that will get more general use I think.  
In both Debian and Fedora there is work on making machines boot from CD-ROM 
which needs such things.  Is that what it's being used for in Gentoo?


Your patch is good, but I think we need to think about making it more generic 
before putting it in CVS.  Probably making the CVS policy more like what you 
are doing in Gentoo in some ways will be better for everyone.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_BzTTBFGebuzrDw4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/macros/program/rssh_macros.te	2004-08-24 05:46:55.000000000 +1000
+++ macros/program/rssh_macros.te	2004-09-19 17:51:46.000000000 +1000
@@ -27,7 +27,7 @@
 base_file_read_access(rssh_$1_t);
 allow rssh_$1_t var_t:dir r_dir_perms;
 r_dir_file(rssh_$1_t, etc_t);
-r_dir_file(rssh_$1_t, etc_runtime_t);
+allow rssh_$1_t etc_runtime_t:file { getattr read };
 r_dir_file(rssh_$1_t, locale_t);
 can_exec(rssh_$1_t, bin_t);
 

--Boundary-00=_BzTTBFGebuzrDw4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
