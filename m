Message-ID: <40399A7F.5080909@snu.edu>
Date: Mon, 23 Feb 2004 00:15:27 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [Patch] avc ipaddr patches
Content-Type: multipart/mixed;
 boundary="------------010203090900000600050706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010203090900000600050706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached are 2 patches, the first adds curr_ip to the task_struct and 
sets it in socket.c, and makes the info available in /proc/pid/ipaddr, 
and the second is selinux specific to add ipaddr= to avc messages.

These patches will show the ip of the client who ran an app (in /proc) 
and who got an denial.

Since these modify task_struct and socket.c I doubt there is a way for 
them to go upstream but they might be of interest to people here.

Here is the expected output:

# cat /proc/1632/ipaddr
192.168.1.100

and

avc:  denied  { add_name } for  pid=1638 exe=/bin/mv 
name=linux-2.6.3-proc_pid_ipaddr.diff ipaddr=192.168.1.100 
scontext=root:staff_r:staff_t tcontext=system_u:object_r:src_t tclass=dir

Let me know if you are interested in these..

Joshua Brindle

--------------010203090900000600050706
Content-Type: text/plain;
 name="linux-2.6.3-selinux-ipaddr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-selinux-ipaddr.patch"

diff -u linux-2.6.3/security/selinux/avc.c linux-2.6.3-openpax/security/selinux/avc.c
--- linux-2.6.3/security/selinux/avc.c	2004-02-10 11:28:19.000000000 -0600
+++ linux-2.6.3-openpax/security/selinux/avc.c	2004-02-10 13:05:07.000000000 -0600
@@ -143,6 +143,11 @@
 	char *scontext;
 	u32 scontext_len;
 
+#ifdef CONFIG_PROC_PID_IPADDR
+	if (current->curr_ip)
+		printk("ipaddr=%u.%u.%u.%u ", NIPQUAD(current->curr_ip));
+#endif /* CONFIG_PROC_PID_IPADDR */
+
  	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
 	if (rc)
 		printk("ssid=%d", ssid);

--------------010203090900000600050706
Content-Type: text/x-patch;
 name="linux-2.6.3-proc_pid_ipaddr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-proc_pid_ipaddr.diff"

diff -ur linux-2.6.2/fs/proc/array.c linux-2.6.2-pax/fs/proc/array.c
--- linux-2.6.2/fs/proc/array.c	2004-01-09 00:59:44.000000000 -0600
+++ linux-2.6.2-pax/fs/proc/array.c	2004-02-10 11:04:25.000000000 -0600
@@ -414,3 +414,13 @@
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+#ifdef CONFIG_PROC_PID_IPADDR
+int proc_pid_ipaddr(struct task_struct *task, char * buffer)    
+{       
+       int len;         
+
+       len = sprintf(buffer, "%u.%u.%u.%u\n", NIPQUAD(task->curr_ip));  
+       return len;      
+}       
+#endif /* CONFIG_PROC_PID_IPADDR */
diff -ur linux-2.6.2/fs/proc/base.c linux-2.6.2-pax/fs/proc/base.c
--- linux-2.6.2/fs/proc/base.c	2004-02-08 02:41:47.000000000 -0600
+++ linux-2.6.2-pax/fs/proc/base.c	2004-02-10 11:09:41.000000000 -0600
@@ -57,6 +57,9 @@
 	PROC_TGID_CMDLINE,
 	PROC_TGID_STAT,
 	PROC_TGID_STATM,
+#ifdef CONFIG_PROC_PID_IPADDR
+	PROC_TGID_IPADDR,
+#endif /* CONFIG_PROC_PID_IPADDR */
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
@@ -80,6 +83,9 @@
 	PROC_TID_CMDLINE,
 	PROC_TID_STAT,
 	PROC_TID_STATM,
+#ifdef CONFIG_PROC_PID_IPADDR
+        PROC_TID_IPADDR,
+#endif /* CONFIG_PROC_PID_IPADDR */
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
@@ -111,6 +117,9 @@
 	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
+#ifdef CONFIG_PROC_PID_IPADDR
+	E(PROC_TGID_IPADDR,    "ipaddr",  S_IFREG|S_IRUSR),
+#endif /* CONFIG_PROC_PID_IPADDR */
 	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
@@ -181,6 +190,9 @@
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
+#ifdef CONFIG_PROC_PID_IPADDR
+int proc_pid_ipaddr(struct task_struct*,char*);
+#endif /* CONFIG_PROC_PID_IPADDR */
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
@@ -1350,6 +1362,13 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_statm;
 			break;
+#ifdef CONFIG_PROC_PID_IPADDR
+		case PROC_TID_IPADDR:
+		case PROC_TGID_IPADDR:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_ipaddr;
+			break;
+#endif /* CONFIG_PROC_PID_IPADDR */
 		case PROC_TID_MAPS:
 		case PROC_TGID_MAPS:
 			inode->i_fop = &proc_maps_operations;
diff -ur linux-2.6.2/include/linux/sched.h linux-2.6.2-pax/include/linux/sched.h
--- linux-2.6.2/include/linux/sched.h	2004-02-08 02:48:07.000000000 -0600
+++ linux-2.6.2-pax/include/linux/sched.h	2004-02-10 10:43:41.000000000 -0600
@@ -373,6 +373,11 @@
 
 	struct mm_struct *mm, *active_mm;
 
+#ifdef CONFIG_PROC_PID_IPADDR
+	u32 curr_ip;
+	u8 used_accept:1; 
+#endif /* CONFIG_PROC_PID_IPADDR */
+
 /* task state */
 	struct linux_binfmt *binfmt;
 	int exit_code, exit_signal;
diff -ur linux-2.6.2/net/socket.c linux-2.6.2-pax/net/socket.c
--- linux-2.6.2/net/socket.c	2004-02-10 10:50:22.000000000 -0600
+++ linux-2.6.2-pax/net/socket.c	2004-02-10 10:43:21.000000000 -0600
@@ -80,6 +80,8 @@
 #include <linux/security.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
+#include <linux/in.h>
+#include <linux/ip.h>
 
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -267,6 +268,17 @@
 	return __put_user(klen, ulen);
 }
 
+#ifdef CONFIG_PROC_PID_IPADDR
+void op_attach_curr_ip(const struct sock *sk)
+{
+        if (unlikely(sk->sk_protocol != IPPROTO_TCP))
+                return;
+        current->curr_ip = inet_sk(sk)->daddr;
+        current->used_accept = 1;
+        return;
+}
+#endif /* CONFIG_PROC_PID_IPADDR */
+
 #define SOCKFS_MAGIC 0x534F434B
 
 static kmem_cache_t * sock_inode_cachep;
@@ -1293,8 +1307,12 @@
 	if ((err = sock_map_fd(newsock)) < 0)
 		goto out_release;
 
 	security_socket_post_accept(sock, newsock);
 
+#ifdef CONFIG_PROC_PID_IPADDR
+	op_attach_curr_ip(newsock->sk);
+#endif /* CONFIG_PROC_PID_IPADDR */
+
 out_put:
 	sockfd_put(sock);
 out:
diff -ur linux-2.6.2/net/unix/af_unix.c linux-2.6.2-pax/net/unix/af_unix.c
--- linux-2.6.2/net/unix/af_unix.c	2004-02-08 02:41:59.000000000 -0600
+++ linux-2.6.2-pax/net/unix/af_unix.c	2004-02-10 10:43:30.000000000 -0600
@@ -1003,6 +1005,16 @@
 	/* Set credentials */
 	sk->sk_peercred = other->sk_peercred;
 
+#ifdef CONFIG_PROC_PID_IPADDR
+	//I'm not even sure if this is required, but grsec had it --Method
+        struct pid *pid = find_pid(PIDTYPE_PID, other->sk_peercred.pid);
+
+        if (pid) {
+		pid->task->curr_ip = current->curr_ip;
+		pid->task->used_accept = 1;
+	}
+#endif /* CONFIG_PROC_PID_IPADDR */
+
 	sock_hold(newsk);
 	unix_peer(sk)	= newsk;
 	sock->state	= SS_CONNECTED;

--------------010203090900000600050706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
