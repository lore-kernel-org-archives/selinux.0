From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: policy change needed for screen
Date: Sun, 8 May 2005 23:54:05 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CohfC8EGZwRSjOS"
Message-Id: <200505082354.10951.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CohfC8EGZwRSjOS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached policy patch allows init scripts to remove directories whos type 
has the pidfile attribute.  This permits the screen directories to be removed 
and will also allow init scripts to clean up other directories created by 
daemons.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_CohfC8EGZwRSjOS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/initrc.te.orig	2005-05-08 22:39:11.000000000 +1000
+++ domains/program/initrc.te	2005-05-08 22:39:34.000000000 +1000
@@ -230,7 +230,7 @@
 allow initrc_t home_type:file r_file_perms;
 
 # for system start scripts
-allow initrc_t pidfile:dir rw_dir_perms;
+allow initrc_t pidfile:dir { rmdir rw_dir_perms };
 allow initrc_t pidfile:sock_file unlink;
 rw_dir_create_file(initrc_t, var_lib_t)
 

--Boundary-00=_CohfC8EGZwRSjOS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
