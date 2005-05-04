Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j44MdVgA007585
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 18:39:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j44MUXWY018667
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 22:31:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 317D961AE3
	for <selinux@tycho.nsa.gov>; Thu,  5 May 2005 06:27:50 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30318-01 for <selinux@tycho.nsa.gov>;
	Thu, 5 May 2005 06:27:49 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3503761AE1
	for <selinux@tycho.nsa.gov>; Thu,  5 May 2005 06:27:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: policy for games
Date: Thu, 5 May 2005 02:57:59 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b8PeCLNKkFnpbZc"
Message-Id: <200505050258.03291.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_b8PeCLNKkFnpbZc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow playing FreeCiv in enforcing mode with 
the strict policy.  It's also needed for other games that use network 
operations.

Freeciv starts an Xterm for the server (in the default Fedora setup) and does 
lots of other interesting things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_b8PeCLNKkFnpbZc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/program/games_domain.te.orig	2005-05-04 20:43:37.000000000 +1000
+++ macros/program/games_domain.te	2005-05-04 21:11:03.000000000 +1000
@@ -17,11 +17,14 @@
 if (! disable_games_trans) {
 domain_auto_trans($1_t, games_exec_t, $1_games_t)
 }
+can_exec($1_games_t, games_exec_t)
 role $1_r types $1_games_t;
 
+can_create_pty($1_games)
+
 # X access, /tmp files
 x_client_domain($1_games, $1)
-tmp_domain($1_games)
+tmp_domain($1_games, `', { dir notdevfile_class_set })
 
 uses_shlib($1_games_t)
 read_locale($1_games_t)
@@ -36,6 +39,10 @@
 allow $1_games_t self:process execmem;
 }
 
+if (allow_execmod) {
+allow $1_games_t texrel_shlib_t:file execmod;
+}
+
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
@@ -65,8 +72,8 @@
 
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
-allow $1_games_t proc_t:dir search;
-allow $1_games_t proc_t:file { read getattr };
+allow $1_games_t { proc_t self }:dir search;
+allow $1_games_t { proc_t self }:{ file lnk_file } { read getattr };
 ifdef(`mozilla.te', ` 
 dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
 ')
@@ -75,15 +82,23 @@
 allow $1_games_t self:file { getattr read };
 allow $1_games_t self:fifo_file rw_file_perms;
 
-# kpat spews errors
-dontaudit $1_games_t bin_t:dir getattr;
+allow $1_games_t self:sem create_sem_perms;
+
+allow $1_games_t { bin_t sbin_t }:dir { getattr search };
+can_exec($1_games_t, { shell_exec_t bin_t utempter_exec_t })
+allow $1_games_t bin_t:lnk_file read;
+
 dontaudit $1_games_t var_run_t:dir search;
+dontaudit $1_games_t initrc_var_run_t:file { read write };
+dontaudit $1_games_t var_log_t:dir search;
 
 # Allow games to read /etc/mtab and /etc/nsswitch.conf
 allow $1_games_t etc_t:file { getattr read };
 allow $1_games_t etc_runtime_t:file { getattr read };
 
-# 
+can_network($1_games_t)
+allow $1_games_t port_t:tcp_socket name_bind;
+allow $1_games_t port_t:tcp_socket name_connect;
 
 ')dnl end macro definition
 

--Boundary-00=_b8PeCLNKkFnpbZc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
