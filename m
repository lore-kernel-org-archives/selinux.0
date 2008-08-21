Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7LGwuQG012232
	for <selinux@tycho.nsa.gov>; Thu, 21 Aug 2008 12:58:56 -0400
Subject: Re: Make Dummy Policy
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov, "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1219327226.13542.45.camel@moss-terrapins.epoch.ncsc.mil>
References: <1219262296.2609.148.camel@moss-terrapins.epoch.ncsc.mil>
	 <48AC9124.1000109@schaufler-ca.com>
	 <1219268728.13542.5.camel@moss-terrapins.epoch.ncsc.mil>
	 <1219327226.13542.45.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-qdkwbKl2SUIbuf+0lFh6"
Date: Thu, 21 Aug 2008 12:41:05 -0400
Message-Id: <1219336865.13542.62.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qdkwbKl2SUIbuf+0lFh6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

[snip]

Ok so this seems like the final version of this patch. The policy
compiles and installs properly and the system boots. This policy does
not provide you any protection with respect to SELinux since it allows
everything and every program runs under the same domain. So do not use
it with the expectation of it providing any security. Now that the
disclaimer is out of the way here are some stats on the policy.

The new policy is 587 lines (stripped of blank lines) with 476 of those
lines being the boilerplate that I mentioned last time. The remaining
111 lines have the 3 lines for type, user, and role, 70 lines for the
allow rules (one for each object class including user space object
classes), 27 lines to assign types to the initial sids, and 11 lines for
file system labeling. The policy binary is 9194 bytes.

One issue I ran into was that dbus wants a dbus_contexts file if it
detects if SELinux is enabled and it won't fall back on an empty rule
set. This is weird since the dbus file_context file in the fedora policy
is an empty rule set as it is. I have included this file in the patch
just in case dbus wants it.

Dave

--=-qdkwbKl2SUIbuf+0lFh6
Content-Disposition: attachment; filename=dbus_contexts
Content-Type: text/plain; name=dbus_contexts; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <selinux>
  </selinux>
</busconfig>

--=-qdkwbKl2SUIbuf+0lFh6
Content-Disposition: attachment; filename=file_contexts
Content-Type: text/plain; name=file_contexts; charset=utf-8
Content-Transfer-Encoding: 7bit

/ user_u:base_r:base_t
/.* user_u:base_r:base_t

--=-qdkwbKl2SUIbuf+0lFh6
Content-Disposition: attachment; filename=policy.conf
Content-Type: text/plain; name=policy.conf; charset=utf-8
Content-Transfer-Encoding: 7bit

class security
class process
class system
class capability
class filesystem
class file
class dir
class fd
class lnk_file
class chr_file
class blk_file
class sock_file
class fifo_file
class socket
class tcp_socket
class udp_socket
class rawip_socket
class node
class netif
class netlink_socket
class packet_socket
class key_socket
class unix_stream_socket
class unix_dgram_socket
class sem
class msg
class msgq
class shm
class ipc
class user30
class user31
class user32
class user33
class user34
class user35
class user36
class user37
class user38
class user39
class user40
class user41
class user42
class netlink_route_socket
class netlink_firewall_socket
class netlink_tcpdiag_socket
class netlink_nflog_socket
class netlink_xfrm_socket
class netlink_selinux_socket
class netlink_audit_socket
class netlink_ip6fw_socket
class netlink_dnrt_socket
class user52
class user53
class association
class netlink_kobject_uevent_socket
class appletalk_socket
class packet
class key
class user59
class dccp_socket
class memprotect
class user62
class user63
class user64
class user65
class user66
class user67
class peer
class capability2
class user70

sid kernel
sid security
sid unlabeled
sid fs
sid file
sid file_labels
sid init
sid any_socket
sid port
sid netif
sid netmsg
sid node
sid igmp_packet
sid icmp_socket
sid tcp_socket
sid sysctl_modprobe
sid sysctl
sid sysctl_fs
sid sysctl_kernel
sid sysctl_net
sid sysctl_net_unix
sid sysctl_vm
sid sysctl_dev
sid kmod
sid policy
sid scmp_packet
sid devnull

common file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
}

common socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

common ipc
{
	create
	destroy
	getattr
	setattr
	read
	write
	associate
	unix_read
	unix_write
}


class security
{
	compute_av
	compute_create
	compute_member
	check_context
	load_policy
	compute_relabel
	compute_user
	setenforce
	setbool
	setsecparam
	setcheckreqprot
}

class process
{
	fork
	transition
	sigchld
	sigkill
	sigstop
	signull
	signal
	ptrace
	getsched
	setsched
	getsession
	getpgid
	setpgid
	getcap
	setcap
	share
	getattr
	setexec
	setfscreate
	noatsecure
	siginh
	setrlimit
	rlimitinh
	dyntransition
	setcurrent
	execmem
	execstack
	execheap
	setkeycreate
	setsockcreate
}

class system
{
	ipc_info
	syslog_read
	syslog_mod
	syslog_console
}

class capability
{
	chown
	dac_override
	dac_read_search
	fowner
	fsetid
	kill
	setgid
	setuid
	setpcap
	linux_immutable
	net_bind_service
	net_broadcast
	net_admin
	net_raw
	ipc_lock
	ipc_owner
	sys_module
	sys_rawio
	sys_chroot
	sys_ptrace
	sys_pacct
	sys_admin
	sys_boot
	sys_nice
	sys_resource
	sys_time
	sys_tty_config
	mknod
	lease
	audit_write
	audit_control
	setfcap
}

class filesystem
{
	mount
	remount
	unmount
	getattr
	relabelfrom
	relabelto
	transition
	associate
	quotamod
	quotaget
}

class file
inherits file
{
	execute_no_trans
	entrypoint
	execmod
	open
}

class dir
inherits file
{
	add_name
	remove_name
	reparent
	search
	rmdir
	open
}

class fd
{
	use
}

class lnk_file
inherits file

class chr_file
inherits file
{
	execute_no_trans
	entrypoint
	execmod
	open
}

class blk_file
inherits file
{
	open
}

class sock_file
inherits file

class fifo_file
inherits file
{
	open
}

class socket
inherits socket

class tcp_socket
inherits socket
{
	connectto
	newconn
	acceptfrom
	node_bind
	name_connect
}

class udp_socket
inherits socket
{
	node_bind
}

class rawip_socket
inherits socket
{
	node_bind
}

class node
{
	tcp_recv
	tcp_send
	udp_recv
	udp_send
	rawip_recv
	rawip_send
	enforce_dest
	dccp_recv
	dccp_send
	recvfrom
	sendto
}

class netif
{
	tcp_recv
	tcp_send
	udp_recv
	udp_send
	rawip_recv
	rawip_send
	dccp_recv
	dccp_send
	ingress
	egress
}

class netlink_socket
inherits socket

class packet_socket
inherits socket

class key_socket
inherits socket

class unix_stream_socket
inherits socket
{
	connectto
	newconn
	acceptfrom
}

class unix_dgram_socket
inherits socket

class sem
inherits ipc

class msg
{
	send
	receive
}

class msgq
inherits ipc
{
	enqueue
}

class shm
inherits ipc
{
	lock
}

class ipc
inherits ipc

class netlink_route_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}

class netlink_firewall_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}

class netlink_tcpdiag_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}

class netlink_nflog_socket
inherits socket

class netlink_xfrm_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}

class netlink_selinux_socket
inherits socket

class netlink_audit_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
	nlmsg_relay
	nlmsg_readpriv
}

class netlink_ip6fw_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}

class netlink_dnrt_socket
inherits socket

class association
{
	sendto
	recvfrom
	setcontext
	polmatch
}

class netlink_kobject_uevent_socket
inherits socket

class appletalk_socket
inherits socket

class packet
{
	send
	recv
	relabelto
	flow_in
	flow_out
	forward_in
	forward_out
}

class key
{
	view
	read
	write
	search
	link
	setattr
	create
}

class dccp_socket
inherits socket
{
	node_bind
	name_connect
}

class memprotect
{
	mmap_zero
}

class peer
{
	recv
}

class capability2
{
	mac_override
	mac_admin
}


type base_t;
role base_r types { base_t };
allow base_t base_t:security *;
allow base_t base_t:process *;
allow base_t base_t:system *;
allow base_t base_t:capability *;
allow base_t base_t:filesystem *;
allow base_t base_t:file *;
allow base_t base_t:dir *;
allow base_t base_t:fd *;
allow base_t base_t:lnk_file *;
allow base_t base_t:chr_file *;
allow base_t base_t:blk_file *;
allow base_t base_t:sock_file *;
allow base_t base_t:fifo_file *;
allow base_t base_t:socket *;
allow base_t base_t:tcp_socket *;
allow base_t base_t:udp_socket *;
allow base_t base_t:rawip_socket *;
allow base_t base_t:node *;
allow base_t base_t:netif *;
allow base_t base_t:netlink_socket *;
allow base_t base_t:packet_socket *;
allow base_t base_t:key_socket *;
allow base_t base_t:unix_stream_socket *;
allow base_t base_t:unix_dgram_socket *;
allow base_t base_t:sem *;
allow base_t base_t:msg *;
allow base_t base_t:msgq *;
allow base_t base_t:shm *;
allow base_t base_t:ipc *;
allow base_t base_t:user30 *;
allow base_t base_t:user31 *;
allow base_t base_t:user32 *;
allow base_t base_t:user33 *;
allow base_t base_t:user34 *;
allow base_t base_t:user35 *;
allow base_t base_t:user36 *;
allow base_t base_t:user37 *;
allow base_t base_t:user38 *;
allow base_t base_t:user39 *;
allow base_t base_t:user40 *;
allow base_t base_t:user41 *;
allow base_t base_t:user42 *;
allow base_t base_t:netlink_route_socket *;
allow base_t base_t:netlink_firewall_socket *;
allow base_t base_t:netlink_tcpdiag_socket *;
allow base_t base_t:netlink_nflog_socket *;
allow base_t base_t:netlink_xfrm_socket *;
allow base_t base_t:netlink_selinux_socket *;
allow base_t base_t:netlink_audit_socket *;
allow base_t base_t:netlink_ip6fw_socket *;
allow base_t base_t:netlink_dnrt_socket *;
allow base_t base_t:user52 *;
allow base_t base_t:user53 *;
allow base_t base_t:association *;
allow base_t base_t:netlink_kobject_uevent_socket *;
allow base_t base_t:appletalk_socket *;
allow base_t base_t:packet *;
allow base_t base_t:key *;
allow base_t base_t:user59 *;
allow base_t base_t:dccp_socket *;
allow base_t base_t:memprotect *;
allow base_t base_t:user62 *;
allow base_t base_t:user63 *;
allow base_t base_t:user64 *;
allow base_t base_t:user65 *;
allow base_t base_t:user66 *;
allow base_t base_t:user67 *;
allow base_t base_t:peer *;
allow base_t base_t:capability2 *;
allow base_t base_t:user70 *;
user user_u roles { base_r };

sid kernel user_u:base_r:base_t
sid security user_u:base_r:base_t
sid unlabeled user_u:base_r:base_t
sid fs user_u:base_r:base_t
sid file user_u:base_r:base_t
sid file_labels user_u:base_r:base_t
sid init user_u:base_r:base_t
sid any_socket user_u:base_r:base_t
sid port user_u:base_r:base_t
sid netif user_u:base_r:base_t
sid netmsg user_u:base_r:base_t
sid node user_u:base_r:base_t
sid igmp_packet user_u:base_r:base_t
sid icmp_socket user_u:base_r:base_t
sid tcp_socket user_u:base_r:base_t
sid sysctl_modprobe user_u:base_r:base_t
sid sysctl user_u:base_r:base_t
sid sysctl_fs user_u:base_r:base_t
sid sysctl_kernel user_u:base_r:base_t
sid sysctl_net user_u:base_r:base_t
sid sysctl_net_unix user_u:base_r:base_t
sid sysctl_vm user_u:base_r:base_t
sid sysctl_dev user_u:base_r:base_t
sid kmod user_u:base_r:base_t
sid policy user_u:base_r:base_t
sid scmp_packet user_u:base_r:base_t
sid devnull user_u:base_r:base_t

fs_use_xattr ext2 user_u:base_r:base_t;
fs_use_xattr ext3 user_u:base_r:base_t;
fs_use_xattr jfs user_u:base_r:base_t;
fs_use_xattr xfs user_u:base_r:base_t;
fs_use_xattr reiserfs user_u:base_r:base_t;
fs_use_task pipefs user_u:base_r:base_t;
fs_use_task sockfs user_u:base_r:base_t;
fs_use_trans devpts user_u:base_r:base_t;
fs_use_trans tmpfs user_u:base_r:base_t;
fs_use_trans shm user_u:base_r:base_t;
genfscon proc / user_u:base_r:base_t

--=-qdkwbKl2SUIbuf+0lFh6
Content-Disposition: attachment; filename=mdp.patch
Content-Type: text/x-patch; name=mdp.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/Makefile b/Makefile
index 53bf6ec..2a23083 100644
--- a/Makefile
+++ b/Makefile
@@ -1655,6 +1655,13 @@ clean := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.clean obj
 
 endif	# skip-makefile
 
+selinux_policy:
+	cd $(srctree)/scripts/selinux; sh ./compile_policy.sh
+
+selinux_install: selinux_policy
+	cd $(srctree)/scripts/selinux; sh ./install_policy.sh
+
+
 PHONY += FORCE
 FORCE:
 
diff --git a/scripts/selinux/compile_policy.sh b/scripts/selinux/compile_policy.sh
new file mode 100644
index 0000000..ab385cb
--- /dev/null
+++ b/scripts/selinux/compile_policy.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+CP=`which checkpolicy`
+POLICYVERS=`cat /selinux/policyvers`
+if [ $? -eq 1 ]; then
+	echo "no selinux tools installed"
+	exit 1
+fi
+
+cd mdp
+sh ./build.sh -k ../../..
+if [ $? -ne 0 ]; then
+	echo "Failure building dummy policy."
+	exit 1
+fi
+$CP -o policy.`checkpolicy -V | awk '{print $1}'` policy.conf
diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
new file mode 100644
index 0000000..3c8fbfa
--- /dev/null
+++ b/scripts/selinux/install_policy.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+if [ `id -u` -ne 0 ]; then
+	echo "$0: must be root to install the selinux policy"
+	exit 1
+fi
+SF=`which setfiles`
+if [ $? -eq 1 ]; then
+	if [ -f /usr/sbin/setfiles ]; then
+		SF="/usr/sbin/setfiles"
+	else
+		echo "no selinux tools installed: setfiles"
+		exit 1
+	fi
+fi
+
+cd mdp
+
+mkdir -p /etc/selinux/dummy/policy
+mkdir -p /etc/selinux/dummy/contexts/files
+
+cp file_contexts /etc/selinux/dummy/contexts/files
+cp dbus_contexts /etc/selinux/dummy/contexts
+cp policy.`checkpolicy -V | awk '{print $1}'` /etc/selinux/dummy/policy
+FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
+if [ ! -f $FC_FILE ]; then
+	echo "no file contests file.  Please run"
+	echo "make selinux_policy_install"
+	exit 1
+fi
+
+cd /etc/selinux/dummy/contexts/files
+$SF file_contexts /
+
+mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs" | awk '{ print $2 '}`
+for line in $mounts; do
+	$SF file_contexts $line
+done
+
+dodev=`cat /proc/$$/mounts | grep "/dev "`
+if [ "eq$dodev" != "eq" ]; then
+	mount --move /dev /mnt
+	$SF file_contexts /dev
+	mount --move /mnt /dev
+fi
+
diff --git a/scripts/selinux/mdp/build.sh b/scripts/selinux/mdp/build.sh
new file mode 100644
index 0000000..8c82961
--- /dev/null
+++ b/scripts/selinux/mdp/build.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+usage() {
+	echo "Usage: mdp -k <kernel_dir> [-m]"
+	exit 1
+}
+
+polf="policy.conf"
+ctxf="file_contexts"
+mls=0
+kerneldir=""
+while [ 1 ]; do
+	getopts k:m name
+	if [ $? -gt 0 ]; then
+		break 2
+	fi
+	if [ $name == "m" ]; then
+		mls=1;
+		echo "Making mls policy"
+	elif [ $name == "k" ]; then
+		kerneldir=$OPTARG
+		echo "Using kernel under $kerneldir"
+	else
+		echo "bogus argument \"$name\""
+		usage
+	fi
+done
+
+if [ -z $kerneldir ]; then
+	if [ ! -d "../linux" ]; then
+		echo "No kernel directory specified and ../linux does not exist."
+		usage
+	fi
+	$kerneldir="../linux"
+fi
+
+secd="$kerneldir/security"
+seld="$secd/selinux"
+incd="$seld/include"
+if [ ! -d "$kerneldir" -o ! -d "$secd" -o ! -d "$seld" -o ! -d "$incd" ]; then
+	echo "$incd does not exist"
+	usage
+fi
+
+#echo "char *classlist[] = {" > classlist.h
+#cat $incd/class_to_string.h | sed -e 's/S_(//g' | sed -e 's/)/,/g' >> classlist.h
+#echo "};" >> classlist.h
+
+gcc -I$incd -o mdp mdp.c > makeout 2>&1
+if [ $? -ne 0 ]; then
+	echo "Error compiling mdp.  Please see file \"makeout\" for errors"
+	usage
+fi
+
+if [ $mls -eq 1 ]; then
+	./mdp -m $polf $ctxf > mdpout 2>&1
+else
+	./mdp $polf $ctxf > mdpout 2>&1
+fi
+
+if [ $? -ne 0 ]; then
+	echo "Error running mdp.  Please see \"mdpout\" for errors"
+	usage
+fi
+
+echo "Policy is in $polf and file contexts are in $ctxf."
+echo "Have a nice day."
diff --git a/scripts/selinux/mdp/dbus_contexts b/scripts/selinux/mdp/dbus_contexts
new file mode 100644
index 0000000..116e684
--- /dev/null
+++ b/scripts/selinux/mdp/dbus_contexts
@@ -0,0 +1,6 @@
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+  <selinux>
+  </selinux>
+</busconfig>
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
new file mode 100644
index 0000000..5d2bf14
--- /dev/null
+++ b/scripts/selinux/mdp/mdp.c
@@ -0,0 +1,240 @@
+/*
+ *
+ * mdp - make dummy policy
+ *
+ * When pointed at a kernel tree, builds a dummy policy for that kernel
+ * with exactly one type with full rights to itself.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Authors: Serge E. Hallyn <serue@us.ibm.com>
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+#include "flask.h"
+
+void usage(char *name)
+{
+	printf("usage: %s [-m] policy_file context_file\n", name);
+	exit(1);
+}
+
+void find_common_name(char *cname, char *dest, int len)
+{
+	char *start, *end;
+	
+	start = strchr(cname, '_')+1;
+	end = strchr(start, '_');
+	if (!start || !end || start-cname > len || end-start > len) {
+		printf("Error with commons defines\n");
+		exit(1);
+	}
+	strncpy(dest, start, end-start);
+	dest[end-start] = '\0';
+}
+
+#define S_(x) x,
+static char *classlist[] = {
+#include "class_to_string.h"
+	NULL
+};
+#undef S_
+
+#include "initial_sid_to_string.h"
+
+#define TB_(x) char *x[] = {
+#define TE_(x) NULL };
+#define S_(x) x,
+#include "common_perm_to_string.h"
+#undef TB_
+#undef TE_
+#undef S_
+
+struct common {
+	char *cname;
+	char **perms;
+};
+struct common common[] = {
+#define TB_(x) { #x, x },
+#define S_(x) 
+#define TE_(x)
+#include "common_perm_to_string.h"
+#undef TB_
+#undef TE_
+#undef S_
+};
+
+#define S_(x, y, z) {x, #y},
+struct av_inherit {
+	int class;
+	char *common;
+};
+struct av_inherit av_inherit[] = {
+#include "av_inherit.h"
+};
+#undef S_
+
+#include "av_permissions.h"
+#define S_(x, y, z) {x, y, z},
+struct av_perms {
+	int class;
+	int perm_i;
+	char *perm_s;
+};
+struct av_perms av_perms[] = {
+#include "av_perm_to_string.h"
+};
+#undef S_
+
+int main(int argc, char *argv[])
+{
+	int i, j, mls = 0;
+	char **arg, *polout, *ctxout;
+	int classlist_len, initial_sid_to_string_len;
+	FILE *fout;
+
+	if (argc < 3)
+		usage(argv[0]);
+	arg = argv+1;
+	if (argc==4 && strcmp(argv[1], "-m") == 0) {
+		mls = 1;
+		arg++;
+	}
+	polout = *arg++;
+	ctxout = *arg;
+
+	fout = fopen(polout, "w");
+	if (!fout) {
+		printf("Could not open %s for writing\n", polout);
+		usage(argv[0]);
+	}
+
+	classlist_len = sizeof(classlist) / sizeof(char *);
+	/* print out the classes */
+	for (i=1; i < classlist_len; i++) {
+		if(classlist[i])
+			fprintf(fout, "class %s\n", classlist[i]);
+		else
+			fprintf(fout, "class user%d\n", i);
+	}
+	fprintf(fout, "\n");
+
+	initial_sid_to_string_len = sizeof(initial_sid_to_string) / sizeof (char *);
+	/* print out the sids */
+	for (i=1; i < initial_sid_to_string_len; i++) 
+		fprintf(fout, "sid %s\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+	/* print out the commons */
+	for (i=0; i< sizeof(common)/sizeof(struct common); i++) {
+		char cname[101];
+		find_common_name(common[i].cname, cname, 100);
+		cname[100] = '\0';
+		fprintf(fout, "common %s\n{\n", cname);
+		for (j=0; common[i].perms[j]; j++)
+			fprintf(fout, "\t%s\n", common[i].perms[j]);
+		fprintf(fout, "}\n\n");
+	}
+	fprintf(fout, "\n");
+
+	/* print out the class permissions */
+	for (i=1; i < classlist_len; i++) {
+		if (classlist[i]) {
+			int firstperm = -1, numperms = 0;
+
+			fprintf(fout, "class %s\n", classlist[i]);
+			/* does it inherit from a common? */
+			for (j=0; j < sizeof(av_inherit)/sizeof(struct av_inherit); j++)
+				if (av_inherit[j].class == i)
+					fprintf(fout, "inherits %s\n", av_inherit[j].common);
+
+			for (j=0; j < sizeof(av_perms)/sizeof(struct av_perms); j++) {
+				if (av_perms[j].class == i) {
+					if (firstperm == -1)
+						firstperm = j;
+					numperms++;
+				}
+			}
+			if (!numperms) {
+				fprintf(fout, "\n");
+				continue;
+			}
+
+			fprintf(fout, "{\n");
+			/* print out the av_perms */
+			for (j=0; j < numperms; j++) {
+				fprintf(fout, "\t%s\n", av_perms[firstperm+j].perm_s);
+			}
+			fprintf(fout, "}\n\n");
+		}
+	}
+	fprintf(fout, "\n");
+
+	/* NOW PRINT OUT MLS STUFF */
+	if (mls) {
+		printf("MLS not yet implemented\n");
+		exit(1);
+	}
+
+	/* types, roles, and allows */
+	fprintf(fout, "type base_t;\n");
+	fprintf(fout, "role base_r types { base_t };\n");
+	for (i=1; i < classlist_len; i++) {
+		if (classlist[i])
+			fprintf(fout, "allow base_t base_t:%s *;\n", classlist[i]);
+		else
+			fprintf(fout, "allow base_t base_t:user%d *;\n", i);
+	}
+	fprintf(fout, "user user_u roles { base_r };\n");
+	fprintf(fout, "\n");
+
+	/* default sids */
+	for (i=1; i < initial_sid_to_string_len; i++)
+		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+
+	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
+
+	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
+
+	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
+
+	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+
+	fclose(fout);
+
+	fout = fopen(ctxout, "w");
+	if (!fout) {
+		printf("Wrote policy, but cannot open %s for writing\n");
+		usage(argv[0]);
+	}
+	fprintf(fout, "/ user_u:base_r:base_t\n");
+	fprintf(fout, "/.* user_u:base_r:base_t\n");
+	fclose(fout);
+
+	return 0;
+}

--=-qdkwbKl2SUIbuf+0lFh6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
