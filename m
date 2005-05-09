From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: xdm/gpg policy patch
Date: Mon, 9 May 2005 17:57:50 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CgxfCoRYsYJiP1a"
Message-Id: <200505091757.54287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CgxfCoRYsYJiP1a
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes the policy compile when xdm.te is not used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_CgxfCoRYsYJiP1a
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/program/gpg_agent_macros.te.orig	2005-05-09 17:56:10.000000000 +1000
+++ macros/program/gpg_agent_macros.te	2005-05-09 17:56:52.000000000 +1000
@@ -22,7 +22,6 @@
 role $1_r types $1_gpg_agent_t;
 
 allow $1_gpg_agent_t privfd:fd use;
-allow $1_gpg_agent_t xdm_t:fd use;
 
 # Write to the user domain tty.
 access_terminal($1_gpg_agent_t, $1)
@@ -86,7 +85,7 @@
 allow $1_gpg_pinentry_t xdm_xserver_tmp_t:dir search;
 allow $1_gpg_pinentry_t xdm_xserver_tmp_t:sock_file { read write };
 can_unix_connect($1_gpg_pinentry_t, xdm_xserver_t)
-allow $1_gpg_pinentry_t xdm_t:fd use;
+allow { $1_gpg_agent_t $1_gpg_pinentry_t } xdm_t:fd use;
 ')dnl end ig xdm.te
 
 r_dir_file($1_gpg_pinentry_t, fonts_t)

--Boundary-00=_CgxfCoRYsYJiP1a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
