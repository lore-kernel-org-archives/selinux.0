Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBOHX8Ii009006
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 12:33:14 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBOHVIbn014217
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 17:31:20 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 23E8961AFD
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:32:58 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26389-06 for <selinux@tycho.nsa.gov>;
	Sat, 25 Dec 2004 04:32:57 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9CA5761AF9
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:32:57 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9F212A4
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:32:56 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: howl and modutil
Date: Sat, 25 Dec 2004 04:32:52 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HLFzBCS4N66njoa"
Message-Id: <200412250432.55521.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_HLFzBCS4N66njoa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached are patches for howl and modutil.

The howl patch allows the latest version of howl in rawhide to work correctly.

The modutil patch allows insmod_t to do everything it wants to do on my system 
including access to memory_device_t.  insmod_t has ultimate access anyway so 
this doesn't seem to be a problem.

One thing I have been idly considering regarding modprobe is to re-write it to 
not use system(3) so it doesn't need access to shell_exec_t and thus can have 
assert_execute().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HLFzBCS4N66njoa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="howl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="howl.diff"

--- /usr/src/se/policy/domains/program/unused/howl.te	2004-12-03 19:49:23.000000000 +1100
+++ domains/program/unused/howl.te	2004-12-25 04:01:00.000000000 +1100
@@ -4,8 +4,8 @@
 #
 
 daemon_domain(howl)
-allow howl_t proc_net_t:dir search;
-allow howl_t proc_net_t:file {getattr read };
+allow howl_t proc_net_t:dir r_dir_perms;
+allow howl_t proc_net_t:file { getattr read };
 can_network_server(howl_t)
 can_ypbind(howl_t)
 allow howl_t self:capability { kill net_admin };
@@ -15,6 +15,8 @@
 type howl_port_t, port_type;
 allow howl_t howl_port_t:{ udp_socket tcp_socket } name_bind;
 
+allow howl_t self:unix_dgram_socket create_socket_perms;
+
 allow howl_t etc_t:file { getattr read };
 allow howl_t initrc_var_run_t:file rw_file_perms;
 

--Boundary-00=_HLFzBCS4N66njoa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="modutil.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modutil.diff"

--- /tmp/u/etc/selinux/strict/src/policy/domains/program/modutil.te	2004-12-25 04:27:33.262487680 +1100
+++ domains/program/modutil.te	2004-12-25 04:28:20.093511057 +1100
@@ -69,7 +69,7 @@
 # Rules for the insmod_t domain.
 #
 
-type insmod_t, domain, privlog, sysctl_kernel_writer ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, unrestricted' )
+type insmod_t, domain, privlog, sysctl_kernel_writer, privmem ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule, unrestricted' )
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
@@ -99,7 +99,9 @@
 
 allow insmod_t { agp_device_t apm_bios_t }:chr_file { read write };
 
-allow insmod_t sound_device_t:chr_file { ioctl write };
+allow insmod_t sound_device_t:chr_file { read ioctl write };
+allow insmod_t zero_device_t:chr_file read;
+allow insmod_t memory_device_t:chr_file rw_file_perms;
 
 # Read module config and dependency information
 allow insmod_t { modules_conf_t modules_dep_t }:file { getattr read };
@@ -149,7 +151,6 @@
 
 allow insmod_t device_t:dir read;
 allow insmod_t devpts_t:dir { getattr search };
-dontaudit insmod_t sound_device_t:chr_file read;
 
 type insmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans(privmodule, insmod_exec_t, insmod_t)

--Boundary-00=_HLFzBCS4N66njoa--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
