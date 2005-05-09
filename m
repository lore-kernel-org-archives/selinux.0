From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: kudzu policy patch
Date: Mon, 9 May 2005 19:04:44 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_weyfC5RtpA+ns85"
Message-Id: <200505091904.48227.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_weyfC5RtpA+ns85
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to compile the kudzu policy when cups.te is not 
being used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_weyfC5RtpA+ns85
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/kudzu.te.orig	2005-05-09 19:01:16.000000000 +1000
+++ domains/program/kudzu.te	2005-05-09 19:01:25.000000000 +1000
@@ -95,7 +95,9 @@
 ifdef(`lpd.te', `
 allow kudzu_t printconf_t:file { getattr read };
 ')
+ifdef(`cups.te', `
 allow kudzu_t cupsd_rw_etc_t:dir r_dir_perms;
+')
 dontaudit kudzu_t src_t:dir search;
 ifdef(`xserver.te', `
 allow kudzu_t xserver_exec_t:file getattr;

--Boundary-00=_weyfC5RtpA+ns85--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
