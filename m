Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h367owI4012080
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 03:50:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h367ovxH008190
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 07:50:57 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h367opDl008187 for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 07:50:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Kurt Roeckx <Q@ping.be>, selinux@tycho.nsa.gov
Subject: Re: screen problem.
Date: Sun, 6 Apr 2003 17:50:33 +1000
References: <20030405234354.GA14856@ping.be>
In-Reply-To: <20030405234354.GA14856@ping.be>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jx9j+fSHqm+zFwK"
Message-Id: <200304061750.33400.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Jx9j+fSHqm+zFwK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 6 Apr 2003 09:43, Kurt Roeckx wrote:
> screen doesn't seem to work for me.

I wrote the policy for it quite a while ago and haven't used it since.  It's a 
little bit out of date, I'll fix it now.

> avc:  denied  { use } for  pid=3909 exe=/usr/bin/screen path=/1
> dev=00:07 ino=3
> scontext=kurt:user_r:user_screen_t
> tcontext=system_u:system_r:sshd_t tclass=fd

In the macros/program/screen_macros.te file add:
allow $1_screen_t privfd:fd use;

> avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
> path=/home dev=03:02
> ino=1015809 scontext=kurt:user_r:user_screen_t
> tcontext=system_u:object_r:home_root_t tclass=dir
>
> avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
> path=/home/kurt dev=03:02 ino=131074
> scontext=kurt:user_r:user_screen_t
> tcontext=system_u:object_r:user_home_dir_t tclass=dir

Add:
allow $1_screen_t { home_root_t $1_home_dir_t }:dir search;
(and remove the current line about "$1_home_t:dir search")

> avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
> path=/dev dev=03:02 ino=966657 scontext=kurt:user_r:user_screen_t
> tcontext=system_u:object_r:device_t tclass=dir

Add:
allow $1_screen_t device_t:dir search;

> avc:  denied  { search } for  pid=3910 exe=/usr/bin/screen
> path=/bin dev=03:02 ino=950273 scontext=kurt:user_r:user_screen_t
> tcontext=system_u:object_r:bin_t tclass=dir

Add:
allow $1_screen_t bin_t:dir search;

> avc:  denied  { getattr } for  pid=3910 exe=/usr/bin/screen
> scontext=kurt:user_r:user_screen_t
> tcontext=system_u:object_r:devpts_t tclass=filesystem

Add:
allow $1_screen_t devpts_t:filesystem getattr;
Actually this should be in the can_create_pty() macro.

> avc:  denied  { read write } for  pid=3911 exe=/bin/bash path=/2
> dev=00:07 ino=4 scontext=kurt:user_r:user_t
> tcontext=kurt:object_r:user_screen_devpts_t tclass=chr_file
>
> avc:  denied  { ioctl } for  pid=3911 exe=/bin/bash path=/2
> dev=00:07 ino=4 scontext=kurt:user_r:user_t
> tcontext=kurt:object_r:user_screen_devpts_t tclass=chr_file

Have to use can_create_other_pty() for this.

> avc:  denied  { signull } for  pid=3909 exe=/usr/bin/screen
> scontext=kurt:user_r:user_screen_t
> tcontext=kurt:user_r:user_screen_t tclass=process

The following amended policy rule does this.
allow $1_screen_t self:process { fork signal_perms };

I have attached modified versions of screen_macros.te and global_macros.te to 
address these issues.  They make screen work for a quick test for me.

I'll submit patches for this to the NSA people when they are ready.  I'll 
release a policy tree with these patches soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Jx9j+fSHqm+zFwK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="global_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="global_macros.te"

##############################
#
# Global macros for the type enforcement (TE) configuration.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# Modified: Howard Holm (NSA), <hdholm@epoch.ncsc.mil>
#           System V IPC added
#

#################################
# 
# Macros for groups of classes and 
# groups of permissions.
#

#
# All directory and file classes
#
define(`dir_file_class_set', `{ dir file lnk_file sock_file fifo_file chr_file blk_file }')

#
# All non-directory file classes.
#
define(`file_class_set', `{ file lnk_file sock_file fifo_file chr_file blk_file }')

#
# Non-device file classes.
#
define(`notdevfile_class_set', `{ file lnk_file sock_file fifo_file }')

#
# Device file classes.
#
define(`devfile_class_set', `{ chr_file blk_file }')

#
# All socket classes.
#
define(`socket_class_set', `{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket }')

#
# Datagram socket classes.
# 
define(`dgram_socket_class_set', `{ udp_socket unix_dgram_socket }')

#
# Stream socket classes.
#
define(`stream_socket_class_set', `{ tcp_socket unix_stream_socket }')

#
# Unprivileged socket classes (exclude rawip, netlink, packet).
#
define(`unpriv_socket_class_set', `{ tcp_socket udp_socket unix_stream_socket unix_dgram_socket }')


# 
# Permissions for getting file attributes.
#
define(`stat_file_perms', `{ getattr }')

# 
# Permissions for executing files.
#
define(`x_file_perms', `{ getattr execute }')

# 
# Permissions for reading files and their attributes.
#
define(`r_file_perms', `{ read getattr lock ioctl }')

# 
# Permissions for reading and executing files.
#
define(`rx_file_perms', `{ read getattr lock execute ioctl }')

# 
# Permissions for reading and writing files and their attributes.
#
define(`rw_file_perms', `{ ioctl read getattr lock write append }')

# 
# Permissions for reading and appending to files.
#
define(`ra_file_perms', `{ ioctl read getattr lock append }')

#
# Permissions for linking, unlinking and renaming files.
# 
define(`link_file_perms', `{ getattr link unlink rename }')

#
# Permissions for creating and using files.
# 
define(`create_file_perms', `{ create ioctl read getattr lock write setattr append link unlink rename }')

# 
# Permissions for reading directories and their attributes.
#
define(`r_dir_perms', `{ read getattr lock search ioctl }')

# 
# Permissions for reading and writing directories and their attributes.
#
define(`rw_dir_perms', `{ read getattr lock search ioctl add_name remove_name write }')

# 
# Permissions for reading and adding names to directories.
#
define(`ra_dir_perms', `{ read getattr lock search ioctl add_name write }')


#
# Permissions for creating and using directories.
# 
define(`create_dir_perms', `{ create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir }')

#
# Permissions to mount and unmount file systems.
#
define(`mount_fs_perms', `{ mount remount unmount getattr }')

#
# Permissions for using sockets.
# 
define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')

#
# Permissions for creating and using sockets.
# 
define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')

#
# Permissions for using stream sockets.
# 
define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')

#
# Permissions for creating and using stream sockets.
# 
define(`create_stream_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')


#
# Permissions for sending all signals.
#
define(`signal_perms', `{ sigchld sigkill sigstop signull signal }')

#
# Permissions for sending and receiving network packets.
#
define(`packet_perms', `{ tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send }')

#
# Permissions for using System V IPC
#
define(`r_sem_perms', `{ associate getattr read unix_read }')
define(`rw_sem_perms', `{ associate getattr setattr create destroy read write unix_read unix_write }')
define(`r_msgq_perms', `{ associate getattr read unix_read }')
define(`rw_msgq_perms', `{ associate getattr setattr create destroy read write enqueue unix_read unix_write }')
define(`r_shm_perms', `{ associate getattr read unix_read }')
define(`rw_shm_perms', `{ associate getattr setattr create destroy read write lock unix_read unix_write }')

#################################
# 
# Macros for type transition rules and
# access vector rules.
#

#
# Simple combinations for reading and writing both
# directories and files.
# 
define(`r_dir_file', `
allow $1 $2:dir r_dir_perms;
allow $1 $2:{ file lnk_file } r_file_perms;
')

define(`rw_dir_file', `
allow $1 $2:dir rw_dir_perms;
allow $1 $2:{ file lnk_file } rw_file_perms;
')

define(`ra_dir_file', `
allow $1 $2:dir ra_dir_perms;
allow $1 $2:{ file lnk_file } ra_file_perms;
')

define(`rw_dir_create_file', `
allow $1 $2:dir rw_dir_perms;
allow $1 $2:{ file lnk_file } create_file_perms;
')

define(`create_dir_file', `
allow $1 $2:dir create_dir_perms;
allow $1 $2:{ file lnk_file } create_file_perms;
')

define(`create_dir_notdevfile', `
allow $1 $2:dir create_dir_perms;
allow $1 $2:notdevfile_class_set create_file_perms;
')

define(`create_append_log_file', `
allow $1 $2:dir { read getattr search add_name write };
allow $1 $2:file { create ioctl getattr setattr append link };
')

#################################
#
# domain_trans(parent_domain, program_type, child_domain)
#
# Permissions for transitioning to a new domain.
#

define(`domain_trans',`

#
# Allow the process to transition to the new domain.
#
allow $1 $3:process transition;

#
# Allow the process to execute the program.
# 
allow $1 $2:file x_file_perms;

#
# Allow the process to reap the new domain.
#
allow $3 $1:process sigchld;

#
# Allow the new domain to inherit and use file 
# descriptions from the creating process and vice versa.
#
allow $3 $1:fd use;
allow $1 $3:fd use;

#
# Allow the new domain to write back to the old domain via a pipe.
#
allow $3 $1:fifo_file rw_file_perms;

#
# Allow the new domain to read and execute the program.
#
allow $3 $2:file rx_file_perms;

#
# Allow the new domain to be entered via the program.
#
allow $3 $2:file entrypoint;
')

#################################
#
# domain_auto_trans(parent_domain, program_type, child_domain)
#
# Define a default domain transition and allow it.
#
define(`domain_auto_trans',`
domain_trans($1,$2,$3)
type_transition $1 $2:process $3;
')

define(`domain_auto_trans_read',`
domain_auto_trans($1, $2, $3)
allow $1 $2:file read;
')

#################################
#
# uses_shlib(domain)
#
# Permissions for using shared libraries.
#
define(`uses_shlib',`
allow $1 { root_t usr_t lib_t etc_t }:dir r_dir_perms;
allow $1 ld_so_t:file rx_file_perms;
allow $1 ld_so_t:file execute_no_trans;
allow $1 ld_so_t:lnk_file r_file_perms;
allow $1 shlib_t:file rx_file_perms;
allow $1 shlib_t:lnk_file r_file_perms;
allow $1 ld_so_cache_t:file r_file_perms;
allow $1 lib_t:{ file lnk_file } r_file_perms;
allow $1 usr_t:{ file lnk_file } r_file_perms;
allow $1 null_device_t:chr_file rw_file_perms;
')

#################################
#
# can_ptrace(domain, domain)
#
# Permissions for running ptrace (strace or gdb) on another domain
#
define(`can_ptrace',`
allow $1 $2:process ptrace;
')

#################################
#
# can_exec(domain, type)
#
# Permissions for executing programs with
# a specified type without changing domains.
#
define(`can_exec',`
allow $1 $2:file { rx_file_perms execute_no_trans };
')

#################################
#
# can_exec_any(domain)
#
# Permissions for executing a variety
# of executable types.
#
define(`can_exec_any',`
allow $1 { bin_t sbin_t lib_t etc_t }:dir r_dir_perms;
allow $1 { bin_t sbin_t }:lnk_file read;
uses_shlib($1)
can_exec($1, etc_t)
can_exec($1, lib_t)
can_exec($1, bin_t)
can_exec($1, sbin_t)
can_exec($1, exec_type)
')


#################################
#
# file_type_trans(domain, dir_type, file_type)
#
# Permissions for transitioning to a new file type.
#

define(`file_type_trans',`

#
# Allow the process to modify the directory.
#
allow $1 $2:dir rw_dir_perms;

#
# Allow the process to create the file.
#
ifelse(`$4', `', `
allow $1 $3:notdevfile_class_set create_file_perms;
allow $1 $3:dir create_dir_perms;
', `
ifelse(`$4', `dir', `
allow $1 $3:$4 create_dir_perms;
', `
allow $1 $3:$4 create_file_perms;
')dnl end if dir
')dnl end if param 4 specified

')

#################################
#
# file_type_auto_trans(creator_domain, parent_directory_type, file_type, object_class)
#
# the object class will default to notdevfile_class_set if not specified as
# the fourth parameter
#
# Define a default file type transition and allow it.
#
define(`file_type_auto_trans',`
ifelse(`$4', `', `
file_type_trans($1,$2,$3)
type_transition $1 $2:dir $3;
type_transition $1 $2:notdevfile_class_set $3;
', `
file_type_trans($1,$2,$3,$4)
type_transition $1 $2:$4 $3;
')

')

#################################
#
# can_network(domain)
#
# Permissions for accessing the network.
# See types/network.te for the network types.
# See net_contexts for security contexts for network entities.
#
define(`can_network',`
#
# Allow the domain to create and use UDP and TCP sockets.
# Other kinds of sockets must be separately authorized for use.
allow $1 self:udp_socket create_socket_perms;
allow $1 self:tcp_socket create_stream_socket_perms;

#
# Allow the domain to send UDP packets.
# Since the destination sockets type is unknown, the generic
# any_socket_t type is used as a placeholder.
#
allow $1 any_socket_t:udp_socket sendto;

#
# Allow the domain to send using any network interface.
# netif_type is a type attribute for all network interface types.
#
allow $1 netif_type:netif { tcp_send udp_send rawip_send };

#
# Allow packets sent by the domain to be received on any network interface.
#
allow $1 netif_type:netif { tcp_recv udp_recv rawip_recv };

#
# Allow the domain to receive packets from any network interface.
# netmsg_type is a type attribute for all default message types.
#
allow $1 netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;

#
# Allow the domain to initiate or accept TCP connections 
# on any network interface.
#
allow $1 netmsg_type:tcp_socket { connectto acceptfrom };

#
# Receive resets from the TCP reset socket.
# The TCP reset socket is labeled with the tcp_socket_t type.
#
allow $1 tcp_socket_t:tcp_socket recvfrom;

dontaudit $1 tcp_socket_t:tcp_socket connectto;

#
# Allow the domain to send to any node.
# node_type is a type attribute for all node types.
#
allow $1 node_type:node { tcp_send udp_send rawip_send };

#
# Allow packets sent by the domain to be received from any node.
#
allow $1 node_type:node { tcp_recv udp_recv rawip_recv };

#
# Allow the domain to send NFS client requests via the socket
# created by mount.
#
allow $1 mount_t:udp_socket rw_socket_perms;

#
# Bind to the default port type.
# Other port types must be separately authorized.
#
allow $1 port_t:udp_socket name_bind;
allow $1 port_t:tcp_socket name_bind;
')

#################################
#
# can_unix_connect(client, server)
#
# Permissions for establishing a Unix stream connection.
#
define(`can_unix_connect',`
allow $1 $2:unix_stream_socket connectto;
')

#################################
#
# can_unix_send(sender, receiver)
#
# Permissions for sending Unix datagrams.
#
define(`can_unix_send',`
allow $1 $2:unix_dgram_socket sendto;
')

#################################
#
# can_tcp_connect(client, server)
#
# Permissions for establishing a TCP connection.
#
define(`can_tcp_connect',`
allow $1 $2:tcp_socket { connectto recvfrom };
allow $2 $1:tcp_socket { acceptfrom recvfrom };
allow $2 tcp_socket_t:tcp_socket { recvfrom };
allow $1 tcp_socket_t:tcp_socket { recvfrom };
')

#################################
#
# can_udp_send(sender, receiver)
#
# Permissions for sending/receiving UDP datagrams.
#
define(`can_udp_send',`
allow $1 $2:udp_socket { sendto };
allow $2 $1:udp_socket { recvfrom };
')

#################################
#
# can_sysctl(domain)
#
# Permissions for modifying sysctl parameters.
#
define(`can_sysctl',`
allow $1 sysctl_t:dir r_dir_perms;
allow $1 sysctl_t:file { setattr rw_file_perms };
allow $1 sysctl_fs_t:dir r_dir_perms;
allow $1 sysctl_fs_t:file { setattr rw_file_perms };
allow $1 sysctl_kernel_t:dir r_dir_perms;
allow $1 sysctl_kernel_t:file { setattr rw_file_perms };
allow $1 sysctl_net_t:dir r_dir_perms;
allow $1 sysctl_net_t:file { setattr rw_file_perms };
allow $1 sysctl_net_unix_t:dir r_dir_perms;
allow $1 sysctl_net_unix_t:file { setattr rw_file_perms };
allow $1 sysctl_vm_t:dir r_dir_perms;
allow $1 sysctl_vm_t:file { setattr rw_file_perms };
allow $1 sysctl_dev_t:dir r_dir_perms;
allow $1 sysctl_dev_t:file { setattr rw_file_perms };
allow $1 sysctl_modprobe_t:file { setattr rw_file_perms };
')


##################################
#
# base_pty_perms(domain_prefix)
#
# Base permissions used for can_create_pty() and can_create_other_pty()
#
define(`base_pty_perms', `
# Access the pty master multiplexer.
allow $1_t ptmx_t:chr_file rw_file_perms;

ifdef(`devfsd.te', `
allow $1_t device_t:filesystem getattr;
')
allow $1_t devpts_t:filesystem getattr;

# allow searching /dev/pts
allow $1_t devpts_t:dir search;
')

##################################
#
# can_create_pty(domain_prefix, attributes)
#
# Permissions for creating ptys.
#
define(`can_create_pty',`
base_pty_perms($1)
type $1_devpts_t, file_type, sysadmfile, ptyfile $2;

# Allow the pty to be associated with the file system.
allow $1_devpts_t devpts_t:filesystem associate;

# Label pty files with a derived type.
type_transition $1_t devpts_t:chr_file $1_devpts_t;

# Read and write my pty files.
allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
')


##################################
#
# can_create_other_pty(domain_prefix,other_domain)
#
# Permissions for creating ptys for another domain.
#
define(`can_create_other_pty',`
base_pty_perms($1)
# Label pty files with a derived type.
type_transition $1_t devpts_t:chr_file $2_devpts_t;

# Read and write pty files.
allow $1_t $2_devpts_t:chr_file { setattr rw_file_perms };
')



################################################
#
# The following macros are an attempt to start
# partitioning every_domain into finer-grained subsets
# that can be used by individual domains.
#

#
# general_domain_access(domain)
#
# Grant permissions within the domain.
# This includes permissions to processes, /proc/PID files,
# file descriptors, pipes, Unix sockets, and System V IPC objects
# labeled with the domain.  It also includes permissions to
# send SIGCHLD to init and to use descriptors created by certain
# domains.
#
define(`general_domain_access',`
# Access other processes in the same domain.
allow $1 self:process *;

# Access /proc/PID files for processes in the same domain.
allow $1 self:dir r_dir_perms;
allow $1 self:notdevfile_class_set r_file_perms;

# Access file descriptions, pipes, and sockets
# created by processes in the same domain.
allow $1 self:fd *;
allow $1 self:fifo_file rw_file_perms;
allow $1 self:unix_dgram_socket create_socket_perms;
allow $1 self:unix_stream_socket create_stream_socket_perms;

# Allow the domain to communicate with other processes in the same domain.
allow $1 self:unix_dgram_socket sendto;
allow $1 self:unix_stream_socket connectto;

# Access System V IPC objects created by processes in the same domain.
allow $1 self:sem  rw_sem_perms;
allow $1 self:msg  { send receive };
allow $1 self:msgq rw_msgq_perms;
allow $1 self:shm  rw_shm_perms;

# Use descriptors created by login, sshd, or newrole.
allow $1 privfd:fd use;

# Use descriptors created by mount (e.g. NFS).
allow $1 mount_t:fd use;
')

#
# general_proc_read_access(domain)
#
# Grant read/search permissions to most of /proc, excluding
# the /proc/PID directories and the /proc/kmsg and /proc/kcore files.
# The general_domain_access macro grants access to the domain /proc/PID
# directories, but not to other domains.  Only permissions to stat
# are granted for /proc/kmsg and /proc/kcore, since these files are more
# sensitive.
# 
define(`general_proc_read_access',`
# Read system information files in /proc.
allow $1 proc_t:dir r_dir_perms;
allow $1 proc_t:notdevfile_class_set r_file_perms;

# Stat /proc/kmsg and /proc/kcore.
allow $1 proc_kmsg_t:file stat_file_perms;
allow $1 proc_kcore_t:file stat_file_perms;

# Read system variables in /proc/sys.
allow $1 sysctl_modprobe_t:file r_file_perms;
allow $1 sysctl_t:file r_file_perms;
allow $1 sysctl_t:dir r_dir_perms;
allow $1 sysctl_fs_t:file r_file_perms;
allow $1 sysctl_fs_t:dir r_dir_perms;
allow $1 sysctl_kernel_t:file r_file_perms;
allow $1 sysctl_kernel_t:dir r_dir_perms;
allow $1 sysctl_net_t:file r_file_perms;
allow $1 sysctl_net_t:dir r_dir_perms;
allow $1 sysctl_vm_t:file r_file_perms;
allow $1 sysctl_vm_t:dir r_dir_perms;
allow $1 sysctl_dev_t:file r_file_perms;
allow $1 sysctl_dev_t:dir r_dir_perms;
')

#
# base_file_read_access(domain)
#
# Grant read/search permissions to a few system file types.
#
define(`base_file_read_access',`
# Read /.
allow $1 root_t:dir r_dir_perms;
allow $1 root_t:notdevfile_class_set r_file_perms;

# Read /home.
allow $1 home_root_t:dir r_dir_perms;

# Read /usr.
allow $1 usr_t:dir r_dir_perms;
allow $1 usr_t:notdevfile_class_set r_file_perms;

# Read bin and sbin directories.
allow $1 bin_t:dir r_dir_perms;
allow $1 bin_t:notdevfile_class_set r_file_perms;
allow $1 sbin_t:dir r_dir_perms;
allow $1 sbin_t:notdevfile_class_set r_file_perms;
')

#
# general_file_read_access(domain)
#
# Grant read/search permissions to many system file types.
#
define(`general_file_read_access',`
# Get attributes of file systems.
allow $1 fs_type:filesystem getattr;

base_file_read_access($1)

# Read directories and files with the readable_t type.
# This type is a general type for "world"-readable files.
allow $1 readable_t:dir r_dir_perms;
allow $1 readable_t:notdevfile_class_set r_file_perms;

# Stat /...security and lost+found.
allow $1 file_labels_t:dir getattr;
allow $1 lost_found_t:dir getattr;

# Read the devpts root directory.  
allow $1 devpts_t:dir r_dir_perms;
ifdef(`sshd.te',
`allow $1 sshd_devpts_t:dir r_dir_perms;')

# Read the /tmp directory and any /tmp files with the base type.
# Temporary files created at runtime will typically use derived types.
allow $1 tmp_t:dir r_dir_perms;
allow $1 tmp_t:{ file lnk_file } r_file_perms;

# Read /var.
allow $1 var_t:dir r_dir_perms;
allow $1 var_t:notdevfile_class_set r_file_perms;

# Read /var/catman.
allow $1 catman_t:dir r_dir_perms;
allow $1 catman_t:{ file lnk_file } r_file_perms;

# Read /var/lib.
allow $1 var_lib_t:dir r_dir_perms;
allow $1 var_lib_t:notdevfile_class_set r_file_perms;
allow $1 var_lib_nfs_t:dir r_dir_perms;
allow $1 var_lib_nfs_t:notdevfile_class_set r_file_perms;
ifdef(`rpm.te',
`allow $1 var_lib_rpm_t:dir r_dir_perms;
allow $1 var_lib_rpm_t:{ file lnk_file} r_file_perms;')
r_dir_file($1, tetex_data_t)

# Read /var/yp.
allow $1 var_yp_t:dir r_dir_perms;
allow $1 var_yp_t:notdevfile_class_set r_file_perms;

# Read /var/spool.
allow $1 var_spool_t:dir r_dir_perms;
allow $1 var_spool_t:notdevfile_class_set r_file_perms;

# Read /var/run, /var/lock, /var/log.
allow $1 var_run_t:dir r_dir_perms;
allow $1 var_run_t:{ file lnk_file } r_file_perms;
allow $1 var_log_t:dir r_dir_perms;
#allow $1 var_log_t:{ file lnk_file } r_file_perms;
allow $1 var_log_sa_t:dir r_dir_perms;
allow $1 var_log_sa_t:{ file lnk_file } r_file_perms;
allow $1 var_log_ksyms_t:{ file lnk_file } r_file_perms;
ifdef(`rpm.te', `allow $1 var_log_rpm_t:{ file lnk_file } r_file_perms;')
allow $1 var_lock_t:dir r_dir_perms;
allow $1 var_lock_t:{ file lnk_file } r_file_perms;

# Read /var/run/utmp and /var/log/wtmp.
allow $1 initrc_var_run_t:file r_file_perms;
allow $1 wtmp_t:file r_file_perms;

# Read /boot, /boot/System.map*, and /vmlinuz*
allow $1 boot_t:dir { search getattr };
allow $1 boot_t:file getattr;
allow $1 system_map_t:{ file lnk_file } r_file_perms;
ifdef(`rpm.te', `
allow $1 boot_runtime_t:{ file lnk_file } r_file_perms;
')
allow $1 boot_t:lnk_file read;

# Read /etc.
allow $1 etc_t:dir r_dir_perms;
allow $1 etc_t:notdevfile_class_set r_file_perms;
allow $1 etc_runtime_t:{ file lnk_file } r_file_perms;
allow $1 etc_aliases_t:{ file lnk_file } r_file_perms;
allow $1 etc_mail_t:dir r_dir_perms;
allow $1 etc_mail_t:{ file lnk_file } r_file_perms;
allow $1 resolv_conf_t:{ file lnk_file } r_file_perms;
allow $1 ld_so_cache_t:file r_file_perms;

# Read /lib.
allow $1 lib_t:dir r_dir_perms;
allow $1 lib_t:notdevfile_class_set r_file_perms;

# Read the linker, shared library, and executable types.
allow $1 ld_so_t:{ file lnk_file } r_file_perms;
allow $1 shlib_t:{ file lnk_file } r_file_perms;
allow $1 exec_type:{ file lnk_file } r_file_perms;

# Read man directories and files.
allow $1 man_t:dir r_dir_perms;
allow $1 man_t:notdevfile_class_set r_file_perms;

# Read /usr/src.
allow $1 src_t:dir r_dir_perms;
allow $1 src_t:notdevfile_class_set r_file_perms;

# Read module-related files.
allow $1 modules_object_t:dir r_dir_perms;
allow $1 modules_object_t:{ file lnk_file } r_file_perms;
allow $1 modules_dep_t:{ file lnk_file } r_file_perms;
allow $1 modules_conf_t:{ file lnk_file} r_file_perms;

# Read /dev directories and any symbolic links.
allow $1 device_t:dir r_dir_perms;
allow $1 device_t:lnk_file r_file_perms;

# Read /dev/random and /dev/zero.
allow $1 random_device_t:chr_file r_file_perms;
allow $1 zero_device_t:chr_file r_file_perms;

# Read the root directory of a tmpfs filesytem and any symbolic links.
allow $1 tmpfs_t:dir r_dir_perms;
allow $1 tmpfs_t:lnk_file r_file_perms;

# Read any symbolic links on a devfs file system.
allow $1 device_t:lnk_file r_file_perms;

# Read the root directory of a usbdevfs filesystem, and
# the devices and drivers files.  Permit stating of the
# device nodes, but nothing else.
allow $1 usbdevfs_t:dir r_dir_perms;
allow $1 usbdevfs_t:{ file lnk_file } r_file_perms;
allow $1 usbdevfs_device_t:file getattr;

# Read PID files in /var/run.  pidfile is a type attribute for 
# all types used for such files.
allow $1 pidfile:file r_file_perms;
')

#
# general_file_write_access(domain)
#
# Grant write permissions to a small set of system file types, e.g. /tmp,
# /dev/tty, /dev/null, etc.
#
# For shared directories like /tmp, each domain should have its own derived
# type (with a file_type_auto_trans rule) for files created in the shared
# directory.  Hence, while this macro grants write permissions to certain
# directories, it typically will not grant create permissions to files - those
# should be handled separately via the file_type_auto_trans rules for the
# derived type.
#
define(`general_file_write_access',`
# Read and write the /tmp directory and any /tmp files with the base type.
# Temporary files created at runtime will typically use derived types.
allow $1 tmp_t:dir rw_dir_perms;
allow $1 tmp_t:file rw_file_perms;

# Read and write to the root directory of a tmpfs filesytem.
# Derived types should be defined for the files created in the filesystem.
allow $1 tmpfs_t:dir rw_dir_perms;

# Read and write /dev/tty and /dev/null.
allow $1 devtty_t:chr_file rw_file_perms;
allow $1 { null_device_t zero_device_t }:chr_file rw_file_perms;

# Do not audit write denials to /etc/ld.so.cache.
dontaudit $1 ld_so_cache_t:file write;
')

#
# every_test_domain(domain)
#
# Grant permissions common to the test domains.
#
define(`every_test_domain',`
# Grant permissions within the domain.
general_domain_access($1)

# Grant read/search permissions to most of /proc.
general_proc_read_access($1)

# Grant read/search permissions to many system file types.
general_file_read_access($1)

# Grant write permissions to a small set of system file types, e.g. /tmp.
# No permission to create files is granted here.  Use allow rules to grant 
# create permissions to a type or use file_type_auto_trans rules to set up
# new types for files.
general_file_write_access($1)

# Execute from the system shared libraries.
# No permission to execute anything else is granted here.
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
# Use domain_auto_trans for executing and changing domains.
uses_shlib($1)

# read localization information
allow $1 locale_t:dir r_dir_perms;
allow $1 locale_t:{file lnk_file} r_file_perms;

# Obtain the context of any SID, the SID for any context, 
# and the list of active SIDs.
allow $1 security_t:security { sid_to_context context_to_sid get_sids };

')

################################
#
# every_domain(domain)
#
# Grant permissions common to most domains.
#
# This macro replaces the rules formerly located in domains/every.te.
# An every_domain macro has been inserted into each domain .te file
# for each domain defined within that file.  If you want a new domain
# to inherit these rules, then you can likewise use this macro in
# your new domain .te file.  However, for least privilege purposes, you 
# may want to consider using macros or individual rules that only include 
# a subset of these permissions for your new domain.  This macro has already 
# been partitioned into a few subsets, with corresponding macros defined 
# above and used in defining this macro.  
#
define(`every_domain',`
# Grant the permissions common to the test domains.
every_test_domain($1)

# Grant permissions needed to create TCP and UDP sockets and 
# to access the network.
can_network($1)
')

#######################
# daemon_base_domain(domain_prefix, attribs)
#
# Define a daemon domain with a base set of type declarations
# and permissions that are common to most daemons.
# attribs is the list of attributes which must start with `,' if it is not empty
#
# Author:  Russell Coker <russell@coker.com.au>
#
define(`daemon_base_domain', `
type $1_t, domain, privlog $2;
type $1_exec_t, file_type, sysadmfile, exec_type;

role system_r types $1_t;

domain_auto_trans(initrc_t, $1_exec_t, $1_t)

# Inherit and use descriptors from init.
allow $1_t init_t:fd use;
allow $1_t init_t:process sigchld;
allow $1_t privfd:fd use;
ifdef(`newrole.te', `allow $1_t newrole_t:process sigchld;')
allow $1_t self:process { signal_perms fork };

uses_shlib($1_t)

allow $1_t { self proc_t }:dir r_dir_perms;
allow $1_t { self proc_t }:lnk_file read;

allow $1_t device_t:dir { getattr search };
allow $1_t null_device_t:chr_file rw_file_perms;
allow $1_t console_device_t:chr_file rw_file_perms;
allow $1_t initrc_devpts_t:chr_file rw_file_perms;
')dnl

define(`daemon_domain', `
daemon_base_domain($1, `$2')
# Create pid file.
allow $1_t var_t:dir { getattr search };
type var_run_$1_t, file_type, sysadmfile, pidfile;
file_type_auto_trans($1_t, var_run_t, var_run_$1_t)

allow $1_t devtty_t:chr_file rw_file_perms;

# for daemons that look at /root on startup
dontaudit $1_t sysadm_home_dir_t:dir search;

# for df
allow $1_t fs_type:filesystem getattr;

r_dir_file($1_t, locale_t)
')dnl

define(`uses_authbind',
`domain_auto_trans_read($1, authbind_exec_t, authbind_t)
allow authbind_t $1:process sigchld;
allow authbind_t $1:fd use;
allow authbind_t $1:{ tcp_socket udp_socket } rw_socket_perms;
')

# define a sub-domain, $1_t is the parent domain, $2 is the name
# of the sub-domain.
#
define(`daemon_sub_domain', `
# $1 is the parent domain (or domains), $2_t is the child domain,
# and $3 is any attributes to apply to the child
type $2_t, domain, privlog $3;
type $2_exec_t, file_type, sysadmfile, exec_type;

role system_r types $2_t;

domain_auto_trans($1, $2_exec_t, $2_t)

# Inherit and use descriptors from parent.
allow $2_t $1:fd use;
allow $2_t $1:process sigchld;

allow $2_t self:process signal_perms;

uses_shlib($2_t)

allow $2_t { self proc_t }:dir r_dir_perms;
allow $2_t { self proc_t }:lnk_file read;

allow $2_t device_t:dir { getattr search };
allow $2_t null_device_t:chr_file rw_file_perms;
')


define(`tmp_domain', `
type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
')

define(`var_lib_domain', `
type var_lib_$1_t, file_type, sysadmfile;
file_type_auto_trans($1_t, var_lib_t, var_lib_$1_t)
')

define(`log_domain', `
type $1_log_t, file_type, sysadmfile, logfile;
file_type_auto_trans($1_t, var_log_t, $1_log_t)
')

define(`lock_domain', `
type $1_lock_t, file_type, sysadmfile, lockfile;
file_type_auto_trans($1_t, var_lock_t, $1_lock_t)
')

#######################
# application_domain(domain_prefix)
#
# Define a domain with a base set of type declarations
# and permissions that are common to simple applications.
#
# Author:  Russell Coker <russell@coker.com.au>
#
define(`application_domain', `
type $1_t, domain, privlog;
type $1_exec_t, file_type, sysadmfile, exec_type;
role sysadm_r types $1_t;
domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
uses_shlib($1_t)
')

define(`user_application_domain', `
application_domain($1)
in_user_role($1_t)
domain_auto_trans(userdomain, $1_exec_t, $1_t)
')

define(`system_domain', `
type $1_t, domain, privlog $2;
type $1_exec_t, file_type, sysadmfile, exec_type;
role system_r types $1_t;
uses_shlib($1_t)
allow $1_t etc_t:dir r_dir_perms;
')


--Boundary-00=_Jx9j+fSHqm+zFwK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="screen_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="screen_macros.te"

#
# Macros for screen domains.
#

#
# Author: Russell Coker <russell@coker.com.au>
# Based on the work of Stephen Smalley <sds@epoch.ncsc.mil>
# and Timothy Fraser
#

#
# screen_domain(domain_prefix)
#
# Define a derived domain for the screen program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/screen.te. 
#
undefine(`screen_domain')
ifdef(`screen.te', `
define(`screen_domain',`
# Derived domain based on the calling user domain and the program.
type $1_screen_t, domain, privlog, auth, privfd;

allow $1_screen_t shadow_t:file { read getattr };

# Transition from the user domain to this domain.
domain_auto_trans($1_t, screen_exec_t, $1_screen_t)

# The user role is authorized for this domain.
role $1_r types $1_screen_t;

uses_shlib($1_screen_t)

# Revert to the user domain when a shell is executed.
domain_auto_trans($1_screen_t, shell_exec_t, $1_t)

# Inherit and use descriptors from gnome-pty-helper.
ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')

allow $1_screen_t privfd:fd use;

# Write to utmp.
allow $1_screen_t initrc_var_run_t:file rw_file_perms;

# create pty devices
can_create_other_pty($1_screen, $1)
allow $1_screen_t { device_t devpts_t }:dir { getattr read };

allow $1_screen_t fs_t:filesystem getattr;

# Create pid file.
allow $1_screen_t var_t:dir search;
type var_run_$1_screen_t, file_type, sysadmfile, pidfile;
file_type_auto_trans($1_screen_t, var_run_t, var_run_$1_screen_t)

allow $1_screen_t self:process { fork signal_perms };
allow $1_t $1_screen_t:process signal;
allow $1_screen_t self:capability { setuid setgid fsetid };

# get stats
allow $1_screen_t proc_t:dir search;
allow $1_screen_t proc_t:lnk_file read;
dontaudit $1_screen_t device_t:chr_file { getattr };
allow $1_screen_t etc_t:file { read getattr };
allow $1_screen_t self:dir { search read };
allow $1_screen_t self:lnk_file { read };
allow $1_screen_t device_t:dir search;
allow $1_screen_t { home_root_t $1_home_dir_t }:dir search;

allow $1_screen_t self:unix_stream_socket create_socket_perms;
can_exec($1_screen_t, shell_exec_t)
allow $1_screen_t bin_t:dir search;

dontaudit $1_screen_t file_type:{ chr_file blk_file } getattr;
')

', `

define(`screen_domain',`')

')

--Boundary-00=_Jx9j+fSHqm+zFwK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
