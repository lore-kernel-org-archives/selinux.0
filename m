Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I0bLHa009575
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 20:37:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7I0bKj6026102
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 00:37:20 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7I0bHNN026099 for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 00:37:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2EFA992719
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 10:37:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B98357F06F
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 10:37:04 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: first policy patch for 2.6
Date: Mon, 18 Aug 2003 10:37:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w+BQ/0jgS1wD6S1"
Message-Id: <200308181037.04160.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_w+BQ/0jgS1wD6S1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch against the 2.6 policy splits out the macros into core-macros as 
previously described.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_w+BQ/0jgS1wD6S1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ruN ./macros/core_macros.te /usr/src/se/policy/macros/core_macros.te
--- ./macros/core_macros.te	2003-08-18 10:32:38.000000000 +1000
+++ /usr/src/se/policy/macros/core_macros.te	1970-01-01 10:00:00.000000000 +1000
@@ -1,487 +0,0 @@
-##############################
-#
-# core macros for the type enforcement (TE) configuration.
-#
-
-#
-# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
-# Modified: Howard Holm (NSA), <hdholm@epoch.ncsc.mil>
-#           System V IPC added
-#
-
-#################################
-# 
-# Macros for groups of classes and 
-# groups of permissions.
-#
-
-#
-# All directory and file classes
-#
-define(`dir_file_class_set', `{ dir file lnk_file sock_file fifo_file chr_file blk_file }')
-
-#
-# All non-directory file classes.
-#
-define(`file_class_set', `{ file lnk_file sock_file fifo_file chr_file blk_file }')
-
-#
-# Non-device file classes.
-#
-define(`notdevfile_class_set', `{ file lnk_file sock_file fifo_file }')
-
-#
-# Device file classes.
-#
-define(`devfile_class_set', `{ chr_file blk_file }')
-
-#
-# All socket classes.
-#
-define(`socket_class_set', `{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket }')
-
-#
-# Datagram socket classes.
-# 
-define(`dgram_socket_class_set', `{ udp_socket unix_dgram_socket }')
-
-#
-# Stream socket classes.
-#
-define(`stream_socket_class_set', `{ tcp_socket unix_stream_socket }')
-
-#
-# Unprivileged socket classes (exclude rawip, netlink, packet).
-#
-define(`unpriv_socket_class_set', `{ tcp_socket udp_socket unix_stream_socket unix_dgram_socket }')
-
-
-# 
-# Permissions for getting file attributes.
-#
-define(`stat_file_perms', `{ getattr }')
-
-# 
-# Permissions for executing files.
-#
-define(`x_file_perms', `{ getattr execute }')
-
-# 
-# Permissions for reading files and their attributes.
-#
-define(`r_file_perms', `{ read getattr lock ioctl }')
-
-# 
-# Permissions for reading and executing files.
-#
-define(`rx_file_perms', `{ read getattr lock execute ioctl }')
-
-# 
-# Permissions for reading and writing files and their attributes.
-#
-define(`rw_file_perms', `{ ioctl read getattr lock write append }')
-
-# 
-# Permissions for reading and appending to files.
-#
-define(`ra_file_perms', `{ ioctl read getattr lock append }')
-
-#
-# Permissions for linking, unlinking and renaming files.
-# 
-define(`link_file_perms', `{ getattr link unlink rename }')
-
-#
-# Permissions for creating and using files.
-# 
-define(`create_file_perms', `{ create ioctl read getattr lock write setattr append link unlink rename }')
-
-# 
-# Permissions for reading directories and their attributes.
-#
-define(`r_dir_perms', `{ read getattr lock search ioctl }')
-
-# 
-# Permissions for reading and writing directories and their attributes.
-#
-define(`rw_dir_perms', `{ read getattr lock search ioctl add_name remove_name write }')
-
-# 
-# Permissions for reading and adding names to directories.
-#
-define(`ra_dir_perms', `{ read getattr lock search ioctl add_name write }')
-
-
-#
-# Permissions for creating and using directories.
-# 
-define(`create_dir_perms', `{ create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir }')
-
-#
-# Permissions to mount and unmount file systems.
-#
-define(`mount_fs_perms', `{ mount remount unmount getattr }')
-
-#
-# Permissions for using sockets.
-# 
-define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
-
-#
-# Permissions for creating and using sockets.
-# 
-define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
-
-#
-# Permissions for using stream sockets.
-# 
-define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
-
-#
-# Permissions for creating and using stream sockets.
-# 
-define(`create_stream_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
-
-
-#
-# Permissions for sending all signals.
-#
-define(`signal_perms', `{ sigchld sigkill sigstop signull signal }')
-
-#
-# Permissions for sending and receiving network packets.
-#
-define(`packet_perms', `{ tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send }')
-
-#
-# Permissions for using System V IPC
-#
-define(`r_sem_perms', `{ associate getattr read unix_read }')
-define(`rw_sem_perms', `{ associate getattr read write unix_read unix_write }')
-define(`create_sem_perms', `{ associate getattr setattr create destroy read write unix_read unix_write }')
-define(`r_msgq_perms', `{ associate getattr read unix_read }')
-define(`rw_msgq_perms', `{ associate getattr read write enqueue unix_read unix_write }')
-define(`create_msgq_perms', `{ associate getattr setattr create destroy read write enqueue unix_read unix_write }')
-define(`r_shm_perms', `{ associate getattr read unix_read }')
-define(`rw_shm_perms', `{ associate getattr read write lock unix_read unix_write }')
-define(`create_shm_perms', `{ associate getattr setattr create destroy read write lock unix_read unix_write }')
-
-#################################
-# 
-# Macros for type transition rules and
-# access vector rules.
-#
-
-#
-# Simple combinations for reading and writing both
-# directories and files.
-# 
-define(`r_dir_file', `
-allow $1 $2:dir r_dir_perms;
-allow $1 $2:{ file lnk_file } r_file_perms;
-')
-
-define(`rw_dir_file', `
-allow $1 $2:dir rw_dir_perms;
-allow $1 $2:{ file lnk_file } rw_file_perms;
-')
-
-define(`ra_dir_file', `
-allow $1 $2:dir ra_dir_perms;
-allow $1 $2:{ file lnk_file } ra_file_perms;
-')
-
-define(`rw_dir_create_file', `
-allow $1 $2:dir rw_dir_perms;
-allow $1 $2:{ file lnk_file } create_file_perms;
-')
-
-define(`create_dir_file', `
-allow $1 $2:dir create_dir_perms;
-allow $1 $2:{ file lnk_file } create_file_perms;
-')
-
-define(`create_dir_notdevfile', `
-allow $1 $2:dir create_dir_perms;
-allow $1 $2:notdevfile_class_set create_file_perms;
-')
-
-define(`create_append_log_file', `
-allow $1 $2:dir { read getattr search add_name write };
-allow $1 $2:file { create ioctl getattr setattr append link };
-')
-
-##################################
-#
-# can_getsecurity(domain)
-#
-# Authorize a domain to get security policy decisions.
-#
-define(`can_getsecurity',`
-allow $1 security_t:dir { read search getattr };
-allow $1 security_t:file { getattr read write };
-allow $1 security_t:security { check_context compute_av compute_create compute_relabel compute_user };
-')
-
-##################################
-#
-# can_setenforce(domain)
-#
-# Authorize a domain to set the enforcing flag.
-# Due to its sensitivity, always audit this permission.
-#
-define(`can_setenforce',`
-allow $1 security_t:dir { read search getattr };
-allow $1 security_t:file { getattr read write };
-allow $1 security_t:security setenforce;
-auditallow $1 security_t:security setenforce;
-')
-
-##################################
-#
-# can_loadpol(domain)
-#
-# Authorize a domain to load a policy configuration.
-# Due to its sensitivity, always audit this permission.
-#
-define(`can_loadpol',`
-allow $1 security_t:dir { read search getattr };
-allow $1 security_t:file { getattr read write };
-allow $1 security_t:security load_policy;
-auditallow $1 security_t:security load_policy;
-')
-
-#################################
-#
-# domain_trans(parent_domain, program_type, child_domain)
-#
-# Permissions for transitioning to a new domain.
-#
-
-define(`domain_trans',`
-
-#
-# Allow the process to transition to the new domain.
-#
-allow $1 $3:process transition;
-
-#
-# Do not audit when glibc secure mode is enabled upon the transition.
-#
-dontaudit $1 $3:process noatsecure;
-
-#
-# Allow the process to execute the program.
-# 
-allow $1 $2:file { read x_file_perms };
-
-#
-# Allow the process to reap the new domain.
-#
-allow $3 $1:process sigchld;
-
-#
-# Allow the new domain to inherit and use file 
-# descriptions from the creating process and vice versa.
-#
-allow $3 $1:fd use;
-allow $1 $3:fd use;
-
-#
-# Allow the new domain to write back to the old domain via a pipe.
-#
-allow $3 $1:fifo_file rw_file_perms;
-
-#
-# Allow the new domain to read and execute the program.
-#
-allow $3 $2:file rx_file_perms;
-
-#
-# Allow the new domain to be entered via the program.
-#
-allow $3 $2:file entrypoint;
-')
-
-#################################
-#
-# domain_auto_trans(parent_domain, program_type, child_domain)
-#
-# Define a default domain transition and allow it.
-#
-define(`domain_auto_trans',`
-domain_trans($1,$2,$3)
-type_transition $1 $2:process $3;
-')
-
-#################################
-#
-# can_ptrace(domain, domain)
-#
-# Permissions for running ptrace (strace or gdb) on another domain
-#
-define(`can_ptrace',`
-allow $1 $2:process ptrace;
-')
-
-#################################
-#
-# can_exec(domain, type)
-#
-# Permissions for executing programs with
-# a specified type without changing domains.
-#
-define(`can_exec',`
-allow $1 $2:file { rx_file_perms execute_no_trans };
-')
-
-#################################
-#
-# file_type_trans(domain, dir_type, file_type)
-#
-# Permissions for transitioning to a new file type.
-#
-
-define(`file_type_trans',`
-
-#
-# Allow the process to modify the directory.
-#
-allow $1 $2:dir rw_dir_perms;
-
-#
-# Allow the process to create the file.
-#
-ifelse(`$4', `', `
-allow $1 $3:notdevfile_class_set create_file_perms;
-allow $1 $3:dir create_dir_perms;
-', `
-ifelse(`$4', `dir', `
-allow $1 $3:$4 create_dir_perms;
-', `
-allow $1 $3:$4 create_file_perms;
-')dnl end if dir
-')dnl end if param 4 specified
-
-')
-
-#################################
-#
-# file_type_auto_trans(creator_domain, parent_directory_type, file_type, object_class)
-#
-# the object class will default to notdevfile_class_set if not specified as
-# the fourth parameter
-#
-# Define a default file type transition and allow it.
-#
-define(`file_type_auto_trans',`
-ifelse(`$4', `', `
-file_type_trans($1,$2,$3)
-type_transition $1 $2:dir $3;
-type_transition $1 $2:notdevfile_class_set $3;
-', `
-file_type_trans($1,$2,$3,$4)
-type_transition $1 $2:$4 $3;
-')dnl end ifelse
-
-')
-
-#################################
-#
-# can_unix_connect(client, server)
-#
-# Permissions for establishing a Unix stream connection.
-#
-define(`can_unix_connect',`
-allow $1 $2:unix_stream_socket connectto;
-')
-
-#################################
-#
-# can_unix_send(sender, receiver)
-#
-# Permissions for sending Unix datagrams.
-#
-define(`can_unix_send',`
-allow $1 $2:unix_dgram_socket sendto;
-')
-
-#################################
-#
-# can_tcp_connect(client, server)
-#
-# Permissions for establishing a TCP connection.
-#
-define(`can_tcp_connect',`
-allow $1 $2:tcp_socket { connectto recvfrom };
-allow $2 $1:tcp_socket { acceptfrom recvfrom };
-allow $2 tcp_socket_t:tcp_socket { recvfrom };
-allow $1 tcp_socket_t:tcp_socket { recvfrom };
-')
-
-#################################
-#
-# can_udp_send(sender, receiver)
-#
-# Permissions for sending/receiving UDP datagrams.
-#
-define(`can_udp_send',`
-allow $1 $2:udp_socket { sendto };
-allow $2 $1:udp_socket { recvfrom };
-')
-
-##################################
-#
-# base_pty_perms(domain_prefix)
-#
-# Base permissions used for can_create_pty() and can_create_other_pty()
-#
-define(`base_pty_perms', `
-# Access the pty master multiplexer.
-allow $1_t ptmx_t:chr_file rw_file_perms;
-
-ifdef(`devfsd.te', `
-allow $1_t device_t:filesystem getattr;
-')
-allow $1_t devpts_t:filesystem getattr;
-
-# allow searching /dev/pts
-allow $1_t devpts_t:dir { getattr read search };
-')
-
-##################################
-#
-# can_create_pty(domain_prefix, attributes)
-#
-# Permissions for creating ptys.
-#
-define(`can_create_pty',`
-base_pty_perms($1)
-type $1_devpts_t, file_type, sysadmfile, ptyfile $2;
-
-# Allow the pty to be associated with the file system.
-allow $1_devpts_t devpts_t:filesystem associate;
-
-# Label pty files with a derived type.
-type_transition $1_t devpts_t:chr_file $1_devpts_t;
-
-# Read and write my pty files.
-allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
-')
-
-
-##################################
-#
-# can_create_other_pty(domain_prefix,other_domain)
-#
-# Permissions for creating ptys for another domain.
-#
-define(`can_create_other_pty',`
-base_pty_perms($1)
-# Label pty files with a derived type.
-type_transition $1_t devpts_t:chr_file $2_devpts_t;
-
-# Read and write pty files.
-allow $1_t $2_devpts_t:chr_file { setattr rw_file_perms };
-')
-
diff -ruN ./macros/global_macros.te /usr/src/se/policy/macros/global_macros.te
--- ./macros/global_macros.te	2003-08-18 10:32:35.000000000 +1000
+++ /usr/src/se/policy/macros/global_macros.te	2003-08-14 22:37:36.000000000 +1000
@@ -15,6 +15,305 @@
 # groups of permissions.
 #
 
+#
+# All directory and file classes
+#
+define(`dir_file_class_set', `{ dir file lnk_file sock_file fifo_file chr_file blk_file }')
+
+#
+# All non-directory file classes.
+#
+define(`file_class_set', `{ file lnk_file sock_file fifo_file chr_file blk_file }')
+
+#
+# Non-device file classes.
+#
+define(`notdevfile_class_set', `{ file lnk_file sock_file fifo_file }')
+
+#
+# Device file classes.
+#
+define(`devfile_class_set', `{ chr_file blk_file }')
+
+#
+# All socket classes.
+#
+define(`socket_class_set', `{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket }')
+
+#
+# Datagram socket classes.
+# 
+define(`dgram_socket_class_set', `{ udp_socket unix_dgram_socket }')
+
+#
+# Stream socket classes.
+#
+define(`stream_socket_class_set', `{ tcp_socket unix_stream_socket }')
+
+#
+# Unprivileged socket classes (exclude rawip, netlink, packet).
+#
+define(`unpriv_socket_class_set', `{ tcp_socket udp_socket unix_stream_socket unix_dgram_socket }')
+
+
+# 
+# Permissions for getting file attributes.
+#
+define(`stat_file_perms', `{ getattr }')
+
+# 
+# Permissions for executing files.
+#
+define(`x_file_perms', `{ getattr execute }')
+
+# 
+# Permissions for reading files and their attributes.
+#
+define(`r_file_perms', `{ read getattr lock ioctl }')
+
+# 
+# Permissions for reading and executing files.
+#
+define(`rx_file_perms', `{ read getattr lock execute ioctl }')
+
+# 
+# Permissions for reading and writing files and their attributes.
+#
+define(`rw_file_perms', `{ ioctl read getattr lock write append }')
+
+# 
+# Permissions for reading and appending to files.
+#
+define(`ra_file_perms', `{ ioctl read getattr lock append }')
+
+#
+# Permissions for linking, unlinking and renaming files.
+# 
+define(`link_file_perms', `{ getattr link unlink rename }')
+
+#
+# Permissions for creating and using files.
+# 
+define(`create_file_perms', `{ create ioctl read getattr lock write setattr append link unlink rename }')
+
+# 
+# Permissions for reading directories and their attributes.
+#
+define(`r_dir_perms', `{ read getattr lock search ioctl }')
+
+# 
+# Permissions for reading and writing directories and their attributes.
+#
+define(`rw_dir_perms', `{ read getattr lock search ioctl add_name remove_name write }')
+
+# 
+# Permissions for reading and adding names to directories.
+#
+define(`ra_dir_perms', `{ read getattr lock search ioctl add_name write }')
+
+
+#
+# Permissions for creating and using directories.
+# 
+define(`create_dir_perms', `{ create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir }')
+
+#
+# Permissions to mount and unmount file systems.
+#
+define(`mount_fs_perms', `{ mount remount unmount getattr }')
+
+#
+# Permissions for using sockets.
+# 
+define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
+
+#
+# Permissions for creating and using sockets.
+# 
+define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
+
+#
+# Permissions for using stream sockets.
+# 
+define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+
+#
+# Permissions for creating and using stream sockets.
+# 
+define(`create_stream_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+
+
+#
+# Permissions for sending all signals.
+#
+define(`signal_perms', `{ sigchld sigkill sigstop signull signal }')
+
+#
+# Permissions for sending and receiving network packets.
+#
+define(`packet_perms', `{ tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send }')
+
+#
+# Permissions for using System V IPC
+#
+define(`r_sem_perms', `{ associate getattr read unix_read }')
+define(`rw_sem_perms', `{ associate getattr read write unix_read unix_write }')
+define(`create_sem_perms', `{ associate getattr setattr create destroy read write unix_read unix_write }')
+define(`r_msgq_perms', `{ associate getattr read unix_read }')
+define(`rw_msgq_perms', `{ associate getattr read write enqueue unix_read unix_write }')
+define(`create_msgq_perms', `{ associate getattr setattr create destroy read write enqueue unix_read unix_write }')
+define(`r_shm_perms', `{ associate getattr read unix_read }')
+define(`rw_shm_perms', `{ associate getattr read write lock unix_read unix_write }')
+define(`create_shm_perms', `{ associate getattr setattr create destroy read write lock unix_read unix_write }')
+
+#################################
+# 
+# Macros for type transition rules and
+# access vector rules.
+#
+
+#
+# Simple combinations for reading and writing both
+# directories and files.
+# 
+define(`r_dir_file', `
+allow $1 $2:dir r_dir_perms;
+allow $1 $2:{ file lnk_file } r_file_perms;
+')
+
+define(`rw_dir_file', `
+allow $1 $2:dir rw_dir_perms;
+allow $1 $2:{ file lnk_file } rw_file_perms;
+')
+
+define(`ra_dir_file', `
+allow $1 $2:dir ra_dir_perms;
+allow $1 $2:{ file lnk_file } ra_file_perms;
+')
+
+define(`rw_dir_create_file', `
+allow $1 $2:dir rw_dir_perms;
+allow $1 $2:{ file lnk_file } create_file_perms;
+')
+
+define(`create_dir_file', `
+allow $1 $2:dir create_dir_perms;
+allow $1 $2:{ file lnk_file } create_file_perms;
+')
+
+define(`create_dir_notdevfile', `
+allow $1 $2:dir create_dir_perms;
+allow $1 $2:notdevfile_class_set create_file_perms;
+')
+
+define(`create_append_log_file', `
+allow $1 $2:dir { read getattr search add_name write };
+allow $1 $2:file { create ioctl getattr setattr append link };
+')
+
+##################################
+#
+# can_getsecurity(domain)
+#
+# Authorize a domain to get security policy decisions.
+#
+define(`can_getsecurity',`
+allow $1 security_t:dir { read search getattr };
+allow $1 security_t:file { getattr read write };
+allow $1 security_t:security { check_context compute_av compute_create compute_relabel compute_user };
+')
+
+##################################
+#
+# can_setenforce(domain)
+#
+# Authorize a domain to set the enforcing flag.
+# Due to its sensitivity, always audit this permission.
+#
+define(`can_setenforce',`
+allow $1 security_t:dir { read search getattr };
+allow $1 security_t:file { getattr read write };
+allow $1 security_t:security setenforce;
+auditallow $1 security_t:security setenforce;
+')
+
+##################################
+#
+# can_loadpol(domain)
+#
+# Authorize a domain to load a policy configuration.
+# Due to its sensitivity, always audit this permission.
+#
+define(`can_loadpol',`
+allow $1 security_t:dir { read search getattr };
+allow $1 security_t:file { getattr read write };
+allow $1 security_t:security load_policy;
+auditallow $1 security_t:security load_policy;
+')
+
+#################################
+#
+# domain_trans(parent_domain, program_type, child_domain)
+#
+# Permissions for transitioning to a new domain.
+#
+
+define(`domain_trans',`
+
+#
+# Allow the process to transition to the new domain.
+#
+allow $1 $3:process transition;
+
+#
+# Do not audit when glibc secure mode is enabled upon the transition.
+#
+dontaudit $1 $3:process noatsecure;
+
+#
+# Allow the process to execute the program.
+# 
+allow $1 $2:file { read x_file_perms };
+
+#
+# Allow the process to reap the new domain.
+#
+allow $3 $1:process sigchld;
+
+#
+# Allow the new domain to inherit and use file 
+# descriptions from the creating process and vice versa.
+#
+allow $3 $1:fd use;
+allow $1 $3:fd use;
+
+#
+# Allow the new domain to write back to the old domain via a pipe.
+#
+allow $3 $1:fifo_file rw_file_perms;
+
+#
+# Allow the new domain to read and execute the program.
+#
+allow $3 $2:file rx_file_perms;
+
+#
+# Allow the new domain to be entered via the program.
+#
+allow $3 $2:file entrypoint;
+')
+
+#################################
+#
+# domain_auto_trans(parent_domain, program_type, child_domain)
+#
+# Define a default domain transition and allow it.
+#
+define(`domain_auto_trans',`
+domain_trans($1,$2,$3)
+type_transition $1 $2:process $3;
+')
+
 ##################################
 #
 # can_setexec(domain)
@@ -66,6 +365,27 @@
 
 #################################
 #
+# can_ptrace(domain, domain)
+#
+# Permissions for running ptrace (strace or gdb) on another domain
+#
+define(`can_ptrace',`
+allow $1 $2:process ptrace;
+')
+
+#################################
+#
+# can_exec(domain, type)
+#
+# Permissions for executing programs with
+# a specified type without changing domains.
+#
+define(`can_exec',`
+allow $1 $2:file { rx_file_perms execute_no_trans };
+')
+
+#################################
+#
 # can_exec_any(domain)
 #
 # Permissions for executing a variety
@@ -82,6 +402,58 @@
 can_exec($1, exec_type)
 ')
 
+
+#################################
+#
+# file_type_trans(domain, dir_type, file_type)
+#
+# Permissions for transitioning to a new file type.
+#
+
+define(`file_type_trans',`
+
+#
+# Allow the process to modify the directory.
+#
+allow $1 $2:dir rw_dir_perms;
+
+#
+# Allow the process to create the file.
+#
+ifelse(`$4', `', `
+allow $1 $3:notdevfile_class_set create_file_perms;
+allow $1 $3:dir create_dir_perms;
+', `
+ifelse(`$4', `dir', `
+allow $1 $3:$4 create_dir_perms;
+', `
+allow $1 $3:$4 create_file_perms;
+')dnl end if dir
+')dnl end if param 4 specified
+
+')
+
+#################################
+#
+# file_type_auto_trans(creator_domain, parent_directory_type, file_type, object_class)
+#
+# the object class will default to notdevfile_class_set if not specified as
+# the fourth parameter
+#
+# Define a default file type transition and allow it.
+#
+define(`file_type_auto_trans',`
+ifelse(`$4', `', `
+file_type_trans($1,$2,$3)
+type_transition $1 $2:dir $3;
+type_transition $1 $2:notdevfile_class_set $3;
+', `
+file_type_trans($1,$2,$3,$4)
+type_transition $1 $2:$4 $3;
+')
+
+')
+
 #################################
 #
 # can_network(domain)
@@ -162,6 +534,50 @@
 
 #################################
 #
+# can_unix_connect(client, server)
+#
+# Permissions for establishing a Unix stream connection.
+#
+define(`can_unix_connect',`
+allow $1 $2:unix_stream_socket connectto;
+')
+
+#################################
+#
+# can_unix_send(sender, receiver)
+#
+# Permissions for sending Unix datagrams.
+#
+define(`can_unix_send',`
+allow $1 $2:unix_dgram_socket sendto;
+')
+
+#################################
+#
+# can_tcp_connect(client, server)
+#
+# Permissions for establishing a TCP connection.
+#
+define(`can_tcp_connect',`
+allow $1 $2:tcp_socket { connectto recvfrom };
+allow $2 $1:tcp_socket { acceptfrom recvfrom };
+allow $2 tcp_socket_t:tcp_socket { recvfrom };
+allow $1 tcp_socket_t:tcp_socket { recvfrom };
+')
+
+#################################
+#
+# can_udp_send(sender, receiver)
+#
+# Permissions for sending/receiving UDP datagrams.
+#
+define(`can_udp_send',`
+allow $1 $2:udp_socket { sendto };
+allow $2 $1:udp_socket { recvfrom };
+')
+
+#################################
+#
 # can_sysctl(domain)
 #
 # Permissions for modifying sysctl parameters.
@@ -187,6 +603,61 @@
 
 ##################################
 #
+# base_pty_perms(domain_prefix)
+#
+# Base permissions used for can_create_pty() and can_create_other_pty()
+#
+define(`base_pty_perms', `
+# Access the pty master multiplexer.
+allow $1_t ptmx_t:chr_file rw_file_perms;
+
+ifdef(`devfsd.te', `
+allow $1_t device_t:filesystem getattr;
+')
+allow $1_t devpts_t:filesystem getattr;
+
+# allow searching /dev/pts
+allow $1_t devpts_t:dir { getattr read search };
+')
+
+##################################
+#
+# can_create_pty(domain_prefix, attributes)
+#
+# Permissions for creating ptys.
+#
+define(`can_create_pty',`
+base_pty_perms($1)
+type $1_devpts_t, file_type, sysadmfile, ptyfile $2;
+
+# Allow the pty to be associated with the file system.
+allow $1_devpts_t devpts_t:filesystem associate;
+
+# Label pty files with a derived type.
+type_transition $1_t devpts_t:chr_file $1_devpts_t;
+
+# Read and write my pty files.
+allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
+')
+
+
+##################################
+#
+# can_create_other_pty(domain_prefix,other_domain)
+#
+# Permissions for creating ptys for another domain.
+#
+define(`can_create_other_pty',`
+base_pty_perms($1)
+# Label pty files with a derived type.
+type_transition $1_t devpts_t:chr_file $2_devpts_t;
+
+# Read and write pty files.
+allow $1_t $2_devpts_t:chr_file { setattr rw_file_perms };
+')
+
+##################################
+#
 # read_locale(domain)
 #
 # Permissions for reading the locale data,

--Boundary-00=_w+BQ/0jgS1wD6S1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
