From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policy change needed for screen
Date: Sun, 15 May 2005 22:51:10 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200505082354.10951.russell@coker.com.au>
In-Reply-To: <200505082354.10951.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CX0hCHHxoQ/aty6"
Message-Id: <200505152251.14468.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CX0hCHHxoQ/aty6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 08 May 2005 23:54, Russell Coker <russell@coker.com.au> wrote:
> The attached policy patch allows init scripts to remove directories whos
> type has the pidfile attribute.  This permits the screen directories to be
> removed and will also allow init scripts to clean up other directories
> created by daemons.

Attached is an updated patch.  The change is necessary to allow init scripts 
to create /var/log/dmesg when the machine is in the most strict 
configuration.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_CX0hCHHxoQ/aty6
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/initrc.te.orig	2005-05-08 22:39:11.000000000 +1000
+++ domains/program/initrc.te	2005-05-15 22:48:45.000000000 +1000
@@ -131,7 +131,7 @@
 # Update /var/log/wtmp and /var/log/dmesg.
 allow initrc_t wtmp_t:file { setattr rw_file_perms };
 allow initrc_t var_log_t:dir rw_dir_perms;
-allow initrc_t var_log_t:file { setattr rw_file_perms };
+allow initrc_t var_log_t:file create_file_perms;
 allow initrc_t lastlog_t:file { setattr rw_file_perms };
 allow initrc_t logfile:file { read append };
 
@@ -230,7 +230,7 @@
 allow initrc_t home_type:file r_file_perms;
 
 # for system start scripts
-allow initrc_t pidfile:dir rw_dir_perms;
+allow initrc_t pidfile:dir { rmdir rw_dir_perms };
 allow initrc_t pidfile:sock_file unlink;
 rw_dir_create_file(initrc_t, var_lib_t)
 

--Boundary-00=_CX0hCHHxoQ/aty6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
