Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TG98gA013564
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 12:09:09 -0400 (EDT)
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TG7ddE005732
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 16:07:39 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j5TG8FvN303984
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 12:08:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j5TG8Fdi284544
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 10:08:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j5TG8FHL016529
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 10:08:15 -0600
Date: Wed, 29 Jun 2005 11:14:09 -0500
From: serue@us.ibm.com
To: linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
Subject: RFC: jail functionality
Message-ID: <20050629161409.GB16233@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9zSXsLTf0vkW971A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'd still like to see bsdjail/vserver/zone functionality in linux.  It
seems to me the following pieces are needed:

	filesystem namespaces (mostly there, probably want shared
					subtrees)
	read-only bind mounts (not there yet)
	task separation (ie ptrace, etc: can be done by selinux)
	task-hiding ability (see attached patches)
	network jails (see below)
	hostname/domainname per jail?  (is this necessary?)
	resource management - can be done by selinux, ckrm, etc
	filesystem controls - can be done by selinux, using a simple
			policy (attached) provided jails get their own
			(loopback is fine) filesystem;  else read-only
			bind mounts would also help.
	more?
	Some intuitive script(s) to use all of the above.

Attached are the old task_lookup patch which was used by the bsdjail lsm,
a patch for selinux to utilize this hook, and a sample jail policy and
.fc, which presumably would eventually be changed to a jail_domain()
policy macro.  Does this seem at all useful by itself, or should this
wait until it were actually needed for a complete linux jails
implementation?  (Note that access_vectors.diff patches
/etc/selinux/targeted/src/policy/flask/access_vectors, jail2.fc can go
in /etc/selinux/targeted/src/policy/file_contexts/misc/, and jail2.te
can go into /etc/selinux/targeted/src/policy/domains/misc/)

It seems to me the greatest challenge is network jails.  I don't think
this can be done right with selinux.  I believe you can restrict a
domain's access to remote addresses by IP, but not to local addresses
during bind.  Am I wrong in assuming jails would be useless without
this?  (I suppose they could at least be useful for sandboxes of some
sort)  Does anyone have ideas on a good way to implement these?

Some time ago I sent out an RFC for network namespaces, which allowed a
process to essentially give up its access to a network device.  The
patch only allowed a process to give up access to real network devices,
not ip aliases (ie eth0:0).  But this seems much less useful for
allowing admins to provide multiple jails.

The linux-vserver team is working on virtual networking which (IIUC)
creates a virtual network device which is then associated with a
virtual address, a real network device, and a jail.  This appears to
be a way to make the simple version of network namespaces I describe
in the paragraph above more useful, since we would not need to deal
with ip aliases.

Is there any interest in seeing the virtual network devices and
network namespaces pushed upstream?

Read-only bind mounts?

The attached task-lookup patches?

thanks,
-serge

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="access_vectors.diff"

--- access_vectors	2005-06-29 15:28:23.000000000 -0500
+++ access_vectors.new	2005-06-29 15:28:20.000000000 -0500
@@ -245,6 +245,7 @@ class process
 	dyntransition
 	setcurrent
 	execmem
+	tasklookup
 }
 
 

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jail2.fc"

/mnt/jail2 -d user_u:object_r:jail2_file_t
/mnt/jail2/.* user_u:object_r:jail2_file_t
/bin/chroot_ns user_u:object_r:chrootns_t

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jail2.te"

type jail2_file_t, file_type;
type jail2_t, domain;
type chrootns_t, file_type;
role user_r types jail2_t;
role system_r types jail2_t;

domain_auto_trans(unconfined_t,jail2_file_t,jail2_t);

#rw_dir_create_file(jail2_t,jail2_file_t);
file_type_auto_trans(jail2_t,jail2_file_t,jail2_file_t)

allow jail2_t jail2_file_t:{ fd blk_file chr_file lnk_file fifo_file sock_file file dir } *;

allow jail2_t jail2_file_t:{ socket tcp_socket udp_socket rawip_socket node netif netlink_socket packet_socket } *;

allow jail2_t devpts_t:chr_file *;
allow jail2_t tty_device_t:chr_file *;
can_create_pty(jail2, `, userpty_type, user_tty_type')

allow jail2_t jail2_t:dir { read getattr lock search ioctl };
allow jail2_t jail2_t:{file fifo_file} { ioctl read getattr lock write append };

r_dir_file(jail2_t,proc_t);

allow jail2_t netif_eth1_t:netif *;

allow jail2_t jail2_t:{ socket udp_socket tcp_socket rawip_socket packet_socket } *;
allow jail2_t jail2_t:{netlink_socket key_socket unix_stream_socket unix_dgram_socket } *;

allow jail2_t jail2_t:{ sem msg msgq shm ipc } *;

allow jail2_t netif_lo_t:netif *;
allow jail2_t node_lo_t:node *;
allow jail2_t node_t:node *;

#allow jail2_t jail2_t:security { };
allow jail2_t jail2_t:process ~{ setsched setexec setfscreate dyntransition setcurrent setrlimit rlimitinh };
#allow jail2_t jail2_t:system { };
#allow jail2_t jail2_t:capability ~{ sys_module sys_chroot sys_resource sys_time mknod net_admin };
allow jail2_t jail2_t:capability ~{ sys_module sys_resource sys_time mknod net_admin };

allow jail2_t dns_port_t:udp_socket { send_msg recv_msg };
allow jail2_t reserved_port_t:tcp_socket ~{ relabelfrom relabelto };
allow jail2_t reserved_port_t:udp_socket ~{ relabelfrom relabelto };

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tasklookup.diff"

Index: linux-2.6.12-jail/fs/proc/base.c
===================================================================
--- linux-2.6.12-jail.orig/fs/proc/base.c	2005-06-29 15:33:50.000000000 -0500
+++ linux-2.6.12-jail/fs/proc/base.c	2005-06-29 15:34:17.000000000 -0500
@@ -1911,6 +1911,8 @@ static int get_tgid_list(int index, unsi
 		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
+		if (security_task_lookup(p))
+			continue;
 		if (--index >= 0)
 			continue;
 		tgids[nr_tgids] = tgid;
Index: linux-2.6.12-jail/include/linux/security.h
===================================================================
--- linux-2.6.12-jail.orig/include/linux/security.h	2005-06-29 15:33:51.000000000 -0500
+++ linux-2.6.12-jail/include/linux/security.h	2005-06-29 15:34:17.000000000 -0500
@@ -632,6 +632,11 @@ struct swap_info_struct;
  * 	Set the security attributes in @p->security for a kernel thread that
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
+ * @task_lookup:
+ *	Check permission to see the /proc/<pid> entry for process @p.
+ *	@p contains the task_struct for task <pid> which is being looked
+ *	up under /proc
+ *	return 0 if permission is granted.
  * @task_to_inode:
  * 	Set the security attributes for an inode based on an associated task's
  * 	security attributes, e.g. for /proc/pid inodes.
@@ -1167,6 +1172,7 @@ struct security_operations {
 			   unsigned long arg3, unsigned long arg4,
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
+	int (*task_lookup)(struct task_struct *p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
@@ -1840,6 +1846,11 @@ static inline void security_task_reparen
 	security_ops->task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return security_ops->task_lookup(p);
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	security_ops->task_to_inode(p, inode);
@@ -2489,6 +2500,11 @@ static inline void security_task_reparen
 	cap_task_reparent_to_init (p);
 }
 
+static inline int security_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
Index: linux-2.6.12-jail/security/dummy.c
===================================================================
--- linux-2.6.12-jail.orig/security/dummy.c	2005-06-29 15:33:52.000000000 -0500
+++ linux-2.6.12-jail/security/dummy.c	2005-06-29 15:34:17.000000000 -0500
@@ -582,6 +582,11 @@ static void dummy_task_reparent_to_init 
 	return;
 }
 
+static int dummy_task_lookup(struct task_struct *p)
+{
+	return 0;
+}
+
 static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
@@ -943,6 +948,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_kill);
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
+ 	set_to_dummy_if_null(ops, task_lookup);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="selinux-tasklookup.diff"

Index: linux-2.6.12-jail/security/selinux/include/av_perm_to_string.h
===================================================================
--- linux-2.6.12-jail.orig/security/selinux/include/av_perm_to_string.h	2005-06-29 15:34:29.000000000 -0500
+++ linux-2.6.12-jail/security/selinux/include/av_perm_to_string.h	2005-06-29 15:34:34.000000000 -0500
@@ -70,6 +70,7 @@
    S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
+   S_(SECCLASS_PROCESS, PROCESS__TASKLOOKUP, "tasklookup")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
Index: linux-2.6.12-jail/security/selinux/hooks.c
===================================================================
--- linux-2.6.12-jail.orig/security/selinux/hooks.c	2005-06-29 15:34:29.000000000 -0500
+++ linux-2.6.12-jail/security/selinux/hooks.c	2005-06-29 15:34:34.000000000 -0500
@@ -2774,6 +2774,11 @@ static void selinux_task_to_inode(struct
 	return;
 }
 
+static int selinux_task_lookup(struct task_struct *p)
+{
+	return task_has_perm(current, p, PROCESS__TASKLOOKUP);
+}
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 /* Returns error only if unable to parse addresses */
@@ -4334,6 +4339,7 @@ static struct security_operations selinu
 	.task_prctl =			selinux_task_prctl,
 	.task_reparent_to_init =	selinux_task_reparent_to_init,
 	.task_to_inode =                selinux_task_to_inode,
+	.task_lookup =			selinux_task_lookup,
 
 	.ipc_permission =		selinux_ipc_permission,
 
Index: linux-2.6.12-jail/security/selinux/include/av_permissions.h
===================================================================
--- linux-2.6.12-jail.orig/security/selinux/include/av_permissions.h	2005-06-29 15:34:29.000000000 -0500
+++ linux-2.6.12-jail/security/selinux/include/av_permissions.h	2005-06-29 15:34:34.000000000 -0500
@@ -465,6 +465,7 @@
 #define PROCESS__DYNTRANSITION                    0x00800000UL
 #define PROCESS__SETCURRENT                       0x01000000UL
 #define PROCESS__EXECMEM                          0x02000000UL
+#define PROCESS__TASKLOOKUP                       0x04000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL

--9zSXsLTf0vkW971A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
