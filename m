Message-ID: <53BD8DBF.7070305@tycho.nsa.gov>
Date: Wed, 09 Jul 2014 14:45:19 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: secilc: is anyone able to confirm that type_change ...
References: <1404563967.9852.42.camel@x220.localdomain>
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>
 <1404743060.9852.50.camel@x220.localdomain>
 <1404744312.9852.55.camel@x220.localdomain> <53BC44BB.6000708@tresys.com>
 <1404920279.19090.12.camel@x220.localdomain> <53BD675E.2090407@tycho.nsa.gov>
 <1404922440.19090.15.camel@x220.localdomain>
In-Reply-To: <1404922440.19090.15.camel@x220.localdomain>
Content-Type: multipart/mixed; boundary="------------030509060708030302080801"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------030509060708030302080801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/09/2014 12:14 PM, Dominick Grift wrote:
> On Wed, 2014-07-09 at 12:01 -0400, Stephen Smalley wrote:
>> On 07/09/2014 11:37 AM, Dominick Grift wrote:
>>> On Tue, 2014-07-08 at 15:21 -0400, Steve Lawrence wrote:
>>>> On 07/07/2014 10:45 AM, Dominick Grift wrote:
>>>>> On Mon, 2014-07-07 at 16:24 +0200, Dominick Grift wrote:
>>>>>> On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:
>>>>>>
>>>>>>> I can't reproduce the problem with my test policies. The typechange
>>>>>>> statements look like they are correctly inserted into the binary and I
>>>>>>> am seeing the expected type changes at runtime.
>>>>>>>
>>>>>>> Is this with your monogam policy?
>>>>>>>
>>>>>>
>>>>>> No, that one is no longer maintained.
>>>>>>
>>>>>> It is this very small base policy:
>>>>>>
>>>>>> https://github.com/doverride/e145
>>>>>>
>>>>>
>>>>> Note though, with that version, that there is no type_change rule from
>>>>> devpts_t to device_session_pts_t currently (so if you were to test this
>>>>> with sshd then it would be lacking the type change rule)
>>>>>
>>>>> Either insert that type_change rule manually or test it with the (local)
>>>>> login program since there is a type_change session_t
>>>>> device_tty_t:chr_file device_session_tty_t rule present.
>>>>>
>>>>> There is also a conditional type change rule for console_device_t to
>>>>> device_session_tty_t.
>>>>>
>>>>> I cannot imagine me having overlooked anything. Since there are only two
>>>>> domains (system_t and session_t), and both are virtually unconfined.
>>>>>
>>>>>
>>>>
>>>> Ok, finally managed to track down this issue. Turns out to be an
>>>> ordering problem. You have your classes listed in alphabetical order.
>>>> Order shouldn't matter with CIL and everything should work correctly,
>>>> and in most cases is does. However, we assign integer values to each
>>>> class based on the order we see them. So the first one we see gets value
>>>> 1, second gets 2, etc. If these values don't match up with what
>>>> userspace and the kernel expect them to be, things break.
>>>>
>>>> So the temporary solution is to reorder your class statements so that
>>>> they are in the order defined in flask.h [1] so they get the right values.
>>>>
>>>> The long term solution is to add a new statement to CIL (classorder,
>>>> similar to sidorder) that defines this order, allowing the class
>>>> definitions to appear in any order.
>>>>
>>>> Thanks,
>>>> - Steve
>>>>
>>>> [1]
>>>> https://github.com/SELinuxProject/selinux/blob/master/libselinux/include/selinux/flask.h
>>>>
>>>>
>>>>
>>>
>>> That flask.h file in your url seems to be missing the kernel_service
>>> class? (is it outdated?)
>>>
>>> I suspect that today's cilpolicy commit is also based on that
>>> (outdated?) flask.h file, so cilpolicy may fail to build due to missing
>>> kernel_service from classorder statement
>>
>> We stopped updating flask.h and av_permissions.h in libselinux once the
>> dynamic class/perm mapping support was merged, only leaving the old
>> definitions intact for legacy code.
>>
>> The kernel no longer cares about fixed values for the classes/perms; it
>> looks them up by name on policy load.
>>
>>
> 
> Yes, Okay thanks. This is basically a heads-up to the cilpolicy
> maintainer. Just to let him know that cilpolicy *may* fail to build
> currently due to this issue (there are more AV's missing in that flask.h
> BTW)
> 
> Maybe better to get rid of that file if possible. It is pretty
> confusing. I did a find /usr/lib -name flask.h and it returned two
> entries both outdated and also both different with one even older than
> the other.

Re-posting with the list included.


--------------030509060708030302080801
Content-Type: text/x-patch;
 name="0001-Deprecate-use-of-flask.h-and-av_permissions.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Deprecate-use-of-flask.h-and-av_permissions.h.patch"

>From b6d73c2d1731e623ce7cb443935973f6a756b84c Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 9 Jul 2014 13:25:56 -0400
Subject: [PATCH] Deprecate use of flask.h and av_permissions.h.

Also remove all internal uses by libselinux.
This requires deleting the old class/perm string lookup tables
and compatibility code for kernels that predate the /sys/fs/selinux/class
tree, i.e. Linux < 2.6.23.

This also fixes a longstanding bug in the stringrep code; it was allocating
NVECTORS (number of vectors in the legacy av_perm_to_string table, i.e.
the total number of legacy permissions) entries in the per-class perms array
rather than MAXVECTORS (the maximum number of permissions in any
access vector).  Ho hum.  I already fixed this in Android but forgot it
here.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/include/selinux/av_permissions.h |   3 +
 libselinux/include/selinux/flask.h          |   3 +
 libselinux/src/av_inherit.h                 |  38 ----
 libselinux/src/av_perm_to_string.h          | 325 ----------------------------
 libselinux/src/checkAccess.c                |   2 -
 libselinux/src/class_to_string.h            |  78 -------
 libselinux/src/common_perm_to_string.h      |  67 ------
 libselinux/src/selinuxswig.i                |   2 -
 libselinux/src/setexecfilecon.c             |   3 +-
 libselinux/src/stringrep.c                  | 292 +------------------------
 libselinux/utils/selinuxexeccon.c           |   3 +-
 policycoreutils/mcstrans/src/mcscolor.c     |   4 +-
 policycoreutils/newrole/newrole.c           |   3 +-
 13 files changed, 15 insertions(+), 808 deletions(-)
 delete mode 100644 libselinux/src/av_inherit.h
 delete mode 100644 libselinux/src/av_perm_to_string.h
 delete mode 100644 libselinux/src/class_to_string.h
 delete mode 100644 libselinux/src/common_perm_to_string.h

diff --git a/libselinux/include/selinux/av_permissions.h b/libselinux/include/selinux/av_permissions.h
index b1e7860..c1269af 100644
--- a/libselinux/include/selinux/av_permissions.h
+++ b/libselinux/include/selinux/av_permissions.h
@@ -1,3 +1,6 @@
+#warning "Please remove any #include of this header in your source code."
+#warning "Instead, use string_to_av_perm() to map the permission name to a value."
+
 /* This file is automatically generated.  Do not edit. */
 #define COMMON_FILE__IOCTL                               0x00000001UL
 #define COMMON_FILE__READ                                0x00000002UL
diff --git a/libselinux/include/selinux/flask.h b/libselinux/include/selinux/flask.h
index 08e8085..8128223 100644
--- a/libselinux/include/selinux/flask.h
+++ b/libselinux/include/selinux/flask.h
@@ -2,6 +2,9 @@
 #ifndef _SELINUX_FLASK_H_
 #define _SELINUX_FLASK_H_
 
+#warning "Please remove any #include's of this header in your source code."
+#warning "Instead, use string_to_security_class() to map the class name to a value."
+
 /*
  * Security object class definitions
  */
diff --git a/libselinux/src/av_inherit.h b/libselinux/src/av_inherit.h
deleted file mode 100644
index 21effa7..0000000
--- a/libselinux/src/av_inherit.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* This file is automatically generated.  Do not edit. */
-   S_(SECCLASS_DIR, file, 0x00020000UL)
-   S_(SECCLASS_FILE, file, 0x00020000UL)
-   S_(SECCLASS_LNK_FILE, file, 0x00020000UL)
-   S_(SECCLASS_CHR_FILE, file, 0x00020000UL)
-   S_(SECCLASS_BLK_FILE, file, 0x00020000UL)
-   S_(SECCLASS_SOCK_FILE, file, 0x00020000UL)
-   S_(SECCLASS_FIFO_FILE, file, 0x00020000UL)
-   S_(SECCLASS_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_TCP_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_UDP_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_RAWIP_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_PACKET_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_KEY_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_UNIX_STREAM_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_UNIX_DGRAM_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_IPC, ipc, 0x00000200UL)
-   S_(SECCLASS_SEM, ipc, 0x00000200UL)
-   S_(SECCLASS_MSGQ, ipc, 0x00000200UL)
-   S_(SECCLASS_SHM, ipc, 0x00000200UL)
-   S_(SECCLASS_NETLINK_ROUTE_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_FIREWALL_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_TCPDIAG_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_NFLOG_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_XFRM_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_SELINUX_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_IP6FW_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_DNRT_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_APPLETALK_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_DCCP_SOCKET, socket, 0x00400000UL)
-   S_(SECCLASS_DB_DATABASE, database, 0x00000040UL)
-   S_(SECCLASS_DB_TABLE, database, 0x00000040UL)
-   S_(SECCLASS_DB_PROCEDURE, database, 0x00000040UL)
-   S_(SECCLASS_DB_COLUMN, database, 0x00000040UL)
-   S_(SECCLASS_DB_BLOB, database, 0x00000040UL)
diff --git a/libselinux/src/av_perm_to_string.h b/libselinux/src/av_perm_to_string.h
deleted file mode 100644
index 59407e0..0000000
--- a/libselinux/src/av_perm_to_string.h
+++ /dev/null
@@ -1,325 +0,0 @@
-/* This file is automatically generated.  Do not edit. */
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__MOUNT, "mount")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__REMOUNT, "remount")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__UNMOUNT, "unmount")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__GETATTR, "getattr")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__RELABELFROM, "relabelfrom")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__RELABELTO, "relabelto")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__TRANSITION, "transition")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__ASSOCIATE, "associate")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__QUOTAMOD, "quotamod")
-   S_(SECCLASS_FILESYSTEM, FILESYSTEM__QUOTAGET, "quotaget")
-   S_(SECCLASS_DIR, DIR__ADD_NAME, "add_name")
-   S_(SECCLASS_DIR, DIR__REMOVE_NAME, "remove_name")
-   S_(SECCLASS_DIR, DIR__REPARENT, "reparent")
-   S_(SECCLASS_DIR, DIR__SEARCH, "search")
-   S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
-   S_(SECCLASS_DIR, DIR__OPEN, "open")
-   S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
-   S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
-   S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
-   S_(SECCLASS_FILE, FILE__OPEN, "open")
-   S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
-   S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
-   S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
-   S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
-   S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
-   S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
-   S_(SECCLASS_FD, FD__USE, "use")
-   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
-   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
-   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__ACCEPTFROM, "acceptfrom")
-   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NODE_BIND, "node_bind")
-   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NAME_CONNECT, "name_connect")
-   S_(SECCLASS_UDP_SOCKET, UDP_SOCKET__NODE_BIND, "node_bind")
-   S_(SECCLASS_RAWIP_SOCKET, RAWIP_SOCKET__NODE_BIND, "node_bind")
-   S_(SECCLASS_NODE, NODE__TCP_RECV, "tcp_recv")
-   S_(SECCLASS_NODE, NODE__TCP_SEND, "tcp_send")
-   S_(SECCLASS_NODE, NODE__UDP_RECV, "udp_recv")
-   S_(SECCLASS_NODE, NODE__UDP_SEND, "udp_send")
-   S_(SECCLASS_NODE, NODE__RAWIP_RECV, "rawip_recv")
-   S_(SECCLASS_NODE, NODE__RAWIP_SEND, "rawip_send")
-   S_(SECCLASS_NODE, NODE__ENFORCE_DEST, "enforce_dest")
-   S_(SECCLASS_NODE, NODE__DCCP_RECV, "dccp_recv")
-   S_(SECCLASS_NODE, NODE__DCCP_SEND, "dccp_send")
-   S_(SECCLASS_NODE, NODE__RECVFROM, "recvfrom")
-   S_(SECCLASS_NODE, NODE__SENDTO, "sendto")
-   S_(SECCLASS_NETIF, NETIF__TCP_RECV, "tcp_recv")
-   S_(SECCLASS_NETIF, NETIF__TCP_SEND, "tcp_send")
-   S_(SECCLASS_NETIF, NETIF__UDP_RECV, "udp_recv")
-   S_(SECCLASS_NETIF, NETIF__UDP_SEND, "udp_send")
-   S_(SECCLASS_NETIF, NETIF__RAWIP_RECV, "rawip_recv")
-   S_(SECCLASS_NETIF, NETIF__RAWIP_SEND, "rawip_send")
-   S_(SECCLASS_NETIF, NETIF__DCCP_RECV, "dccp_recv")
-   S_(SECCLASS_NETIF, NETIF__DCCP_SEND, "dccp_send")
-   S_(SECCLASS_NETIF, NETIF__INGRESS, "ingress")
-   S_(SECCLASS_NETIF, NETIF__EGRESS, "egress")
-   S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto")
-   S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn")
-   S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom")
-   S_(SECCLASS_PROCESS, PROCESS__FORK, "fork")
-   S_(SECCLASS_PROCESS, PROCESS__TRANSITION, "transition")
-   S_(SECCLASS_PROCESS, PROCESS__SIGCHLD, "sigchld")
-   S_(SECCLASS_PROCESS, PROCESS__SIGKILL, "sigkill")
-   S_(SECCLASS_PROCESS, PROCESS__SIGSTOP, "sigstop")
-   S_(SECCLASS_PROCESS, PROCESS__SIGNULL, "signull")
-   S_(SECCLASS_PROCESS, PROCESS__SIGNAL, "signal")
-   S_(SECCLASS_PROCESS, PROCESS__PTRACE, "ptrace")
-   S_(SECCLASS_PROCESS, PROCESS__GETSCHED, "getsched")
-   S_(SECCLASS_PROCESS, PROCESS__SETSCHED, "setsched")
-   S_(SECCLASS_PROCESS, PROCESS__GETSESSION, "getsession")
-   S_(SECCLASS_PROCESS, PROCESS__GETPGID, "getpgid")
-   S_(SECCLASS_PROCESS, PROCESS__SETPGID, "setpgid")
-   S_(SECCLASS_PROCESS, PROCESS__GETCAP, "getcap")
-   S_(SECCLASS_PROCESS, PROCESS__SETCAP, "setcap")
-   S_(SECCLASS_PROCESS, PROCESS__SHARE, "share")
-   S_(SECCLASS_PROCESS, PROCESS__GETATTR, "getattr")
-   S_(SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec")
-   S_(SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate")
-   S_(SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure")
-   S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
-   S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
-   S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
-   S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
-   S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
-   S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
-   S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
-   S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
-   S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
-   S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")
-   S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
-   S_(SECCLASS_MSG, MSG__SEND, "send")
-   S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
-   S_(SECCLASS_SHM, SHM__LOCK, "lock")
-   S_(SECCLASS_SECURITY, SECURITY__COMPUTE_AV, "compute_av")
-   S_(SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE, "compute_create")
-   S_(SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER, "compute_member")
-   S_(SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, "check_context")
-   S_(SECCLASS_SECURITY, SECURITY__LOAD_POLICY, "load_policy")
-   S_(SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL, "compute_relabel")
-   S_(SECCLASS_SECURITY, SECURITY__COMPUTE_USER, "compute_user")
-   S_(SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce")
-   S_(SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool")
-   S_(SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam")
-   S_(SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT, "setcheckreqprot")
-   S_(SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info")
-   S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read")
-   S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod")
-   S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE, "syslog_console")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__CHOWN, "chown")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__DAC_OVERRIDE, "dac_override")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__DAC_READ_SEARCH, "dac_read_search")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__FOWNER, "fowner")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__FSETID, "fsetid")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__KILL, "kill")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SETGID, "setgid")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SETUID, "setuid")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SETPCAP, "setpcap")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__LINUX_IMMUTABLE, "linux_immutable")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__NET_BIND_SERVICE, "net_bind_service")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__NET_BROADCAST, "net_broadcast")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__NET_ADMIN, "net_admin")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__NET_RAW, "net_raw")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__IPC_LOCK, "ipc_lock")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__IPC_OWNER, "ipc_owner")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_MODULE, "sys_module")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_RAWIO, "sys_rawio")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_CHROOT, "sys_chroot")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_PTRACE, "sys_ptrace")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_PACCT, "sys_pacct")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_ADMIN, "sys_admin")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_BOOT, "sys_boot")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_NICE, "sys_nice")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_RESOURCE, "sys_resource")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_TIME, "sys_time")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SYS_TTY_CONFIG, "sys_tty_config")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__MKNOD, "mknod")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__LEASE, "lease")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_WRITE, "audit_write")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_CONTROL, "audit_control")
-   S_(SECCLASS_CAPABILITY, CAPABILITY__SETFCAP, "setfcap")
-   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_OVERRIDE, "mac_override")
-   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_ADMIN, "mac_admin")
-   S_(SECCLASS_PASSWD, PASSWD__PASSWD, "passwd")
-   S_(SECCLASS_PASSWD, PASSWD__CHFN, "chfn")
-   S_(SECCLASS_PASSWD, PASSWD__CHSH, "chsh")
-   S_(SECCLASS_PASSWD, PASSWD__ROOTOK, "rootok")
-   S_(SECCLASS_PASSWD, PASSWD__CRONTAB, "crontab")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__CREATE, "create")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__DESTROY, "destroy")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__READ, "read")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__WRITE, "write")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__BLEND, "blend")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__GETATTR, "getattr")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SETATTR, "setattr")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__LIST_CHILD, "list_child")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__ADD_CHILD, "add_child")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__REMOVE_CHILD, "remove_child")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__LIST_PROPERTY, "list_property")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__GET_PROPERTY, "get_property")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SET_PROPERTY, "set_property")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__MANAGE, "manage")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__OVERRIDE, "override")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SHOW, "show")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__HIDE, "hide")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SEND, "send")
-   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__RECEIVE, "receive")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__GETATTR, "getattr")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SETATTR, "setattr")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__HIDE_CURSOR, "hide_cursor")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SHOW_CURSOR, "show_cursor")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_GETATTR, "saver_getattr")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_SETATTR, "saver_setattr")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_HIDE, "saver_hide")
-   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_SHOW, "saver_show")
-   S_(SECCLASS_X_GC, X_GC__CREATE, "create")
-   S_(SECCLASS_X_GC, X_GC__DESTROY, "destroy")
-   S_(SECCLASS_X_GC, X_GC__GETATTR, "getattr")
-   S_(SECCLASS_X_GC, X_GC__SETATTR, "setattr")
-   S_(SECCLASS_X_GC, X_GC__USE, "use")
-   S_(SECCLASS_X_FONT, X_FONT__CREATE, "create")
-   S_(SECCLASS_X_FONT, X_FONT__DESTROY, "destroy")
-   S_(SECCLASS_X_FONT, X_FONT__GETATTR, "getattr")
-   S_(SECCLASS_X_FONT, X_FONT__ADD_GLYPH, "add_glyph")
-   S_(SECCLASS_X_FONT, X_FONT__REMOVE_GLYPH, "remove_glyph")
-   S_(SECCLASS_X_FONT, X_FONT__USE, "use")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__CREATE, "create")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__DESTROY, "destroy")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__READ, "read")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__WRITE, "write")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__GETATTR, "getattr")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__ADD_COLOR, "add_color")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__REMOVE_COLOR, "remove_color")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__INSTALL, "install")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__UNINSTALL, "uninstall")
-   S_(SECCLASS_X_COLORMAP, X_COLORMAP__USE, "use")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__CREATE, "create")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__DESTROY, "destroy")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__READ, "read")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__WRITE, "write")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__APPEND, "append")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__GETATTR, "getattr")
-   S_(SECCLASS_X_PROPERTY, X_PROPERTY__SETATTR, "setattr")
-   S_(SECCLASS_X_SELECTION, X_SELECTION__READ, "read")
-   S_(SECCLASS_X_SELECTION, X_SELECTION__WRITE, "write")
-   S_(SECCLASS_X_SELECTION, X_SELECTION__GETATTR, "getattr")
-   S_(SECCLASS_X_SELECTION, X_SELECTION__SETATTR, "setattr")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__CREATE, "create")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__DESTROY, "destroy")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__READ, "read")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__WRITE, "write")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__GETATTR, "getattr")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__SETATTR, "setattr")
-   S_(SECCLASS_X_CURSOR, X_CURSOR__USE, "use")
-   S_(SECCLASS_X_CLIENT, X_CLIENT__DESTROY, "destroy")
-   S_(SECCLASS_X_CLIENT, X_CLIENT__GETATTR, "getattr")
-   S_(SECCLASS_X_CLIENT, X_CLIENT__SETATTR, "setattr")
-   S_(SECCLASS_X_CLIENT, X_CLIENT__MANAGE, "manage")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__GETATTR, "getattr")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__SETATTR, "setattr")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__USE, "use")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__READ, "read")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__WRITE, "write")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__GETFOCUS, "getfocus")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__SETFOCUS, "setfocus")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__BELL, "bell")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__FORCE_CURSOR, "force_cursor")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__FREEZE, "freeze")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__GRAB, "grab")
-   S_(SECCLASS_X_DEVICE, X_DEVICE__MANAGE, "manage")
-   S_(SECCLASS_X_SERVER, X_SERVER__GETATTR, "getattr")
-   S_(SECCLASS_X_SERVER, X_SERVER__SETATTR, "setattr")
-   S_(SECCLASS_X_SERVER, X_SERVER__RECORD, "record")
-   S_(SECCLASS_X_SERVER, X_SERVER__DEBUG, "debug")
-   S_(SECCLASS_X_SERVER, X_SERVER__GRAB, "grab")
-   S_(SECCLASS_X_SERVER, X_SERVER__MANAGE, "manage")
-   S_(SECCLASS_X_EXTENSION, X_EXTENSION__QUERY, "query")
-   S_(SECCLASS_X_EXTENSION, X_EXTENSION__USE, "use")
-   S_(SECCLASS_X_RESOURCE, X_RESOURCE__READ, "read")
-   S_(SECCLASS_X_RESOURCE, X_RESOURCE__WRITE, "write")
-   S_(SECCLASS_X_EVENT, X_EVENT__SEND, "send")
-   S_(SECCLASS_X_EVENT, X_EVENT__RECEIVE, "receive")
-   S_(SECCLASS_X_SYNTHETIC_EVENT, X_SYNTHETIC_EVENT__SEND, "send")
-   S_(SECCLASS_X_SYNTHETIC_EVENT, X_SYNTHETIC_EVENT__RECEIVE, "receive")
-   S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_NETLINK_TCPDIAG_SOCKET, NETLINK_TCPDIAG_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_TCPDIAG_SOCKET, NETLINK_TCPDIAG_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_NETLINK_XFRM_SOCKET, NETLINK_XFRM_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_XFRM_SOCKET, NETLINK_XFRM_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
-   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")
-   S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read")
-   S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write")
-   S_(SECCLASS_DBUS, DBUS__ACQUIRE_SVC, "acquire_svc")
-   S_(SECCLASS_DBUS, DBUS__SEND_MSG, "send_msg")
-   S_(SECCLASS_NSCD, NSCD__GETPWD, "getpwd")
-   S_(SECCLASS_NSCD, NSCD__GETGRP, "getgrp")
-   S_(SECCLASS_NSCD, NSCD__GETHOST, "gethost")
-   S_(SECCLASS_NSCD, NSCD__GETSTAT, "getstat")
-   S_(SECCLASS_NSCD, NSCD__ADMIN, "admin")
-   S_(SECCLASS_NSCD, NSCD__SHMEMPWD, "shmempwd")
-   S_(SECCLASS_NSCD, NSCD__SHMEMGRP, "shmemgrp")
-   S_(SECCLASS_NSCD, NSCD__SHMEMHOST, "shmemhost")
-   S_(SECCLASS_NSCD, NSCD__GETSERV, "getserv")
-   S_(SECCLASS_NSCD, NSCD__SHMEMSERV, "shmemserv")
-   S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
-   S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
-   S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
-   S_(SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, "polmatch")
-   S_(SECCLASS_PACKET, PACKET__SEND, "send")
-   S_(SECCLASS_PACKET, PACKET__RECV, "recv")
-   S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
-   S_(SECCLASS_PACKET, PACKET__FLOW_IN, "flow_in")
-   S_(SECCLASS_PACKET, PACKET__FLOW_OUT, "flow_out")
-   S_(SECCLASS_PACKET, PACKET__FORWARD_IN, "forward_in")
-   S_(SECCLASS_PACKET, PACKET__FORWARD_OUT, "forward_out")
-   S_(SECCLASS_KEY, KEY__VIEW, "view")
-   S_(SECCLASS_KEY, KEY__READ, "read")
-   S_(SECCLASS_KEY, KEY__WRITE, "write")
-   S_(SECCLASS_KEY, KEY__SEARCH, "search")
-   S_(SECCLASS_KEY, KEY__LINK, "link")
-   S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
-   S_(SECCLASS_KEY, KEY__CREATE, "create")
-   S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
-   S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
-   S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
-   S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
-   S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
-   S_(SECCLASS_DB_DATABASE, DB_DATABASE__ACCESS, "access")
-   S_(SECCLASS_DB_DATABASE, DB_DATABASE__INSTALL_MODULE, "install_module")
-   S_(SECCLASS_DB_DATABASE, DB_DATABASE__LOAD_MODULE, "load_module")
-   S_(SECCLASS_DB_DATABASE, DB_DATABASE__GET_PARAM, "get_param")
-   S_(SECCLASS_DB_DATABASE, DB_DATABASE__SET_PARAM, "set_param")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__USE, "use")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__SELECT, "select")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__UPDATE, "update")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__INSERT, "insert")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__DELETE, "delete")
-   S_(SECCLASS_DB_TABLE, DB_TABLE__LOCK, "lock")
-   S_(SECCLASS_DB_PROCEDURE, DB_PROCEDURE__EXECUTE, "execute")
-   S_(SECCLASS_DB_PROCEDURE, DB_PROCEDURE__ENTRYPOINT, "entrypoint")
-   S_(SECCLASS_DB_COLUMN, DB_COLUMN__USE, "use")
-   S_(SECCLASS_DB_COLUMN, DB_COLUMN__SELECT, "select")
-   S_(SECCLASS_DB_COLUMN, DB_COLUMN__UPDATE, "update")
-   S_(SECCLASS_DB_COLUMN, DB_COLUMN__INSERT, "insert")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__RELABELFROM, "relabelfrom")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__RELABELTO, "relabelto")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__USE, "use")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__SELECT, "select")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__UPDATE, "update")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__INSERT, "insert")
-   S_(SECCLASS_DB_TUPLE, DB_TUPLE__DELETE, "delete")
-   S_(SECCLASS_DB_BLOB, DB_BLOB__READ, "read")
-   S_(SECCLASS_DB_BLOB, DB_BLOB__WRITE, "write")
-   S_(SECCLASS_DB_BLOB, DB_BLOB__IMPORT, "import")
-   S_(SECCLASS_DB_BLOB, DB_BLOB__EXPORT, "export")
-   S_(SECCLASS_PEER, PEER__RECV, "recv")
-   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__PASTE, "paste")
-   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__PASTE_AFTER_CONFIRM, "paste_after_confirm")
-   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__COPY, "copy")
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index cd2a817..ee85ebc 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -4,9 +4,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include "selinux_internal.h"
-#include <selinux/flask.h>
 #include <selinux/avc.h>
-#include <selinux/av_permissions.h>
 #include "avc_internal.h"
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
diff --git a/libselinux/src/class_to_string.h b/libselinux/src/class_to_string.h
deleted file mode 100644
index 552ce79..0000000
--- a/libselinux/src/class_to_string.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/* This file is automatically generated.  Do not edit. */
-/*
- * Security object class definitions
- */
-    S_("null")
-    S_("security")
-    S_("process")
-    S_("system")
-    S_("capability")
-    S_("filesystem")
-    S_("file")
-    S_("dir")
-    S_("fd")
-    S_("lnk_file")
-    S_("chr_file")
-    S_("blk_file")
-    S_("sock_file")
-    S_("fifo_file")
-    S_("socket")
-    S_("tcp_socket")
-    S_("udp_socket")
-    S_("rawip_socket")
-    S_("node")
-    S_("netif")
-    S_("netlink_socket")
-    S_("packet_socket")
-    S_("key_socket")
-    S_("unix_stream_socket")
-    S_("unix_dgram_socket")
-    S_("sem")
-    S_("msg")
-    S_("msgq")
-    S_("shm")
-    S_("ipc")
-    S_("passwd")
-    S_("x_drawable")
-    S_("x_screen")
-    S_("x_gc")
-    S_("x_font")
-    S_("x_colormap")
-    S_("x_property")
-    S_("x_selection")
-    S_("x_cursor")
-    S_("x_client")
-    S_("x_device")
-    S_("x_server")
-    S_("x_extension")
-    S_("netlink_route_socket")
-    S_("netlink_firewall_socket")
-    S_("netlink_tcpdiag_socket")
-    S_("netlink_nflog_socket")
-    S_("netlink_xfrm_socket")
-    S_("netlink_selinux_socket")
-    S_("netlink_audit_socket")
-    S_("netlink_ip6fw_socket")
-    S_("netlink_dnrt_socket")
-    S_("dbus")
-    S_("nscd")
-    S_("association")
-    S_("netlink_kobject_uevent_socket")
-    S_("appletalk_socket")
-    S_("packet")
-    S_("key")
-    S_("context")
-    S_("dccp_socket")
-    S_("memprotect")
-    S_("db_database")
-    S_("db_table")
-    S_("db_procedure")
-    S_("db_column")
-    S_("db_tuple")
-    S_("db_blob")
-    S_("peer")
-    S_("capability2")
-    S_("x_resource")
-    S_("x_event")
-    S_("x_synthetic_event")
-    S_("x_application_data")
diff --git a/libselinux/src/common_perm_to_string.h b/libselinux/src/common_perm_to_string.h
deleted file mode 100644
index f52d1f5..0000000
--- a/libselinux/src/common_perm_to_string.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* This file is automatically generated.  Do not edit. */
-TB_(common_file_perm_to_string)
-    S_("ioctl")
-    S_("read")
-    S_("write")
-    S_("create")
-    S_("getattr")
-    S_("setattr")
-    S_("lock")
-    S_("relabelfrom")
-    S_("relabelto")
-    S_("append")
-    S_("unlink")
-    S_("link")
-    S_("rename")
-    S_("execute")
-    S_("swapon")
-    S_("quotaon")
-    S_("mounton")
-TE_(common_file_perm_to_string)
-
-TB_(common_socket_perm_to_string)
-    S_("ioctl")
-    S_("read")
-    S_("write")
-    S_("create")
-    S_("getattr")
-    S_("setattr")
-    S_("lock")
-    S_("relabelfrom")
-    S_("relabelto")
-    S_("append")
-    S_("bind")
-    S_("connect")
-    S_("listen")
-    S_("accept")
-    S_("getopt")
-    S_("setopt")
-    S_("shutdown")
-    S_("recvfrom")
-    S_("sendto")
-    S_("recv_msg")
-    S_("send_msg")
-    S_("name_bind")
-TE_(common_socket_perm_to_string)
-
-TB_(common_ipc_perm_to_string)
-    S_("create")
-    S_("destroy")
-    S_("getattr")
-    S_("setattr")
-    S_("read")
-    S_("write")
-    S_("associate")
-    S_("unix_read")
-    S_("unix_write")
-TE_(common_ipc_perm_to_string)
-
-TB_(common_database_perm_to_string)
-    S_("create")
-    S_("drop")
-    S_("getattr")
-    S_("setattr")
-    S_("relabelfrom")
-    S_("relabelto")
-TE_(common_database_perm_to_string)
-
diff --git a/libselinux/src/selinuxswig.i b/libselinux/src/selinuxswig.i
index 969863a..c72b818 100644
--- a/libselinux/src/selinuxswig.i
+++ b/libselinux/src/selinuxswig.i
@@ -5,9 +5,7 @@
 %module selinux
 %{
 	#include "../include/selinux/avc.h"
-	#include "../include/selinux/av_permissions.h"
 	#include "../include/selinux/context.h"
-	#include "../include/selinux/flask.h"
 	#include "../include/selinux/get_context_list.h"
 	#include "../include/selinux/get_default_type.h"
 	#include "../include/selinux/label.h"
diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfilecon.c
index e574de1..e72ba0d 100644
--- a/libselinux/src/setexecfilecon.c
+++ b/libselinux/src/setexecfilecon.c
@@ -1,7 +1,6 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/flask.h>
 #include "selinux_internal.h"
 #include "context_internal.h"
 
@@ -22,7 +21,7 @@ int setexecfilecon(const char *filename, const char *fallback_type)
 	if (rc < 0)
 		goto out;
 
-	rc = security_compute_create(mycon, fcon, SECCLASS_PROCESS, &newcon);
+	rc = security_compute_create(mycon, fcon, string_to_security_class("process"), &newcon);
 	if (rc < 0)
 		goto out;
 
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index ba75ccd..9ae8248 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -13,165 +13,12 @@
 #include <string.h>
 #include <stdint.h>
 #include <ctype.h>
-#include <selinux/flask.h>
-#include <selinux/av_permissions.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include "mapping.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
-/* The following code looks complicated, but it really is not.  What it
-   does is to generate two variables.  The first is basically a struct
-   of arrays.  The second is the real array of structures which would
-   have used string pointers.  But instead it now uses an offset value
-   into the first structure.  Strings are accessed indirectly by an
-   explicit addition of the string index and the base address of the
-   structure with the strings (all type safe).  The advantage is that
-   there are no relocations necessary in the array with the data as it
-   would be the case with string pointers.  This has advantages at
-   load time, the data section is smaller, and it is read-only.  */
-#define L1(line) L2(line)
-#define L2(line) str##line
-static const union av_perm_to_string_data {
-	struct {
-#define S_(c, v, s) char L1(__LINE__)[sizeof(s)];
-#include "av_perm_to_string.h"
-#undef  S_
-	};
-	char str[0];
-} av_perm_to_string_data = {
-	{
-#define S_(c, v, s) s,
-#include "av_perm_to_string.h"
-#undef  S_
-	}
-};
-static const struct av_perm_to_string {
-	uint16_t tclass;
-	uint16_t nameidx;
-	uint32_t value;
-} av_perm_to_string[] = {
-#define S_(c, v, s) { c, offsetof(union av_perm_to_string_data, L1(__LINE__)), v },
-#include "av_perm_to_string.h"
-#undef  S_
-};
-
-#undef L1
-#undef L2
-
-#define L1(line) L2(line)
-#define L2(line) str##line
-static const union class_to_string_data {
-	struct {
-#define S_(s) char L1(__LINE__)[sizeof(s)];
-#include "class_to_string.h"
-#undef  S_
-	};
-	char str[0];
-} class_to_string_data = {
-	{
-#define S_(s) s,
-#include "class_to_string.h"
-#undef  S_
-	}
-};
-static const uint16_t class_to_string[] = {
-#define S_(s) offsetof(union class_to_string_data, L1(__LINE__)),
-#include "class_to_string.h"
-#undef  S_
-};
-
-#undef L1
-#undef L2
-
-static const union common_perm_to_string_data {
-	struct {
-#define L1(line) L2(line)
-#define L2(line) str##line
-#define S_(s) char L1(__LINE__)[sizeof(s)];
-#define TB_(s)
-#define TE_(s)
-#include "common_perm_to_string.h"
-#undef  S_
-#undef L1
-#undef L2
-	};
-	char str[0];
-} common_perm_to_string_data = {
-	{
-#define S_(s) s,
-#include "common_perm_to_string.h"
-#undef  S_
-#undef TB_
-#undef TE_
-	}
-};
-static const union common_perm_to_string {
-	struct {
-#define TB_(s) struct {
-#define TE_(s) } s##_part;
-#define S_(s) uint16_t L1(__LINE__)
-#define L1(l) L2(l)
-#define L2(l) field_##l;
-#include "common_perm_to_string.h"
-#undef TB_
-#undef TE_
-#undef S_
-#undef L1
-#undef L2
-	};
-	uint16_t data[0];
-} common_perm_to_string = {
-	{
-#define TB_(s) {
-#define TE_(s) },
-#define S_(s) offsetof(union common_perm_to_string_data, L1(__LINE__)),
-#define L1(line) L2(line)
-#define L2(line) str##line
-#include "common_perm_to_string.h"
-#undef TB_
-#undef TE_
-#undef S_
-#undef L1
-#undef L2
-	}
-};
-
-static const struct av_inherit {
-	uint16_t tclass;
-	uint16_t common_pts_idx;
-	uint32_t common_base;
-} av_inherit[] = {
-#define S_(c, i, b) { c, offsetof(union common_perm_to_string, common_##i##_perm_to_string_part)/sizeof(uint16_t), b },
-#include "av_inherit.h"
-#undef S_
-};
-
-#define NCLASSES ARRAY_SIZE(class_to_string)
-#define NVECTORS ARRAY_SIZE(av_perm_to_string)
 #define MAXVECTORS 8*sizeof(access_vector_t)
 
-static pthread_once_t once = PTHREAD_ONCE_INIT;
-
-static int obj_class_compat;
-
-static void init_obj_class_compat(void)
-{
-	char path[PATH_MAX];
-	struct stat s;
-
-	if (!selinux_mnt)
-		return;
-
-	snprintf(path,PATH_MAX,"%s/class",selinux_mnt);
-	if (stat(path,&s) < 0)
-		return;
-
-	if (S_ISDIR(s.st_mode))
-		obj_class_compat = 0;
-}
-
 struct discover_class_node {
 	char *name;
 	security_class_t value;
@@ -222,7 +69,7 @@ static struct discover_class_node * discover_class(const char *s)
 		return NULL;
 
 	/* allocate array for perms */
-	node->perms = calloc(NVECTORS,sizeof(char*));
+	node->perms = calloc(MAXVECTORS,sizeof(char*));
 	if (node->perms == NULL)
 		goto err1;
 
@@ -282,7 +129,7 @@ static struct discover_class_node * discover_class(const char *s)
 		if (sscanf(buf, "%u", &value) != 1)
 			goto err4;
 
-		if (value == 0 || value > NVECTORS)
+		if (value == 0 || value > MAXVECTORS)
 			goto err4;
 
 		node->perms[value-1] = strdup(dentry->d_name);
@@ -300,7 +147,7 @@ static struct discover_class_node * discover_class(const char *s)
 
 err4:
 	closedir(dir);
-	for (i=0; i<NVECTORS; i++)
+	for (i=0; i<MAXVECTORS; i++)
 		free(node->perms[i]);
 err3:
 	free(node->name);
@@ -311,124 +158,10 @@ err1:
 	return NULL;
 }
 
-static security_class_t string_to_security_class_compat(const char *s)
-{
-	unsigned int val;
-
-	if (isdigit(s[0])) {
-		val = atoi(s);
-		if (val > 0 && val < NCLASSES)
-			return map_class(val);
-	} else {
-		for (val = 0; val < NCLASSES; val++) {
-			if (strcmp(s, (class_to_string_data.str
-				       + class_to_string[val])) == 0)
-				return map_class(val);
-		}
-	}
-
-	errno = EINVAL;
-	return 0;
-}
-
-static access_vector_t string_to_av_perm_compat(security_class_t kclass, const char *s)
-{
-	const uint16_t *common_pts_idx = 0;
-	access_vector_t perm, common_base = 0;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
-		if (av_inherit[i].tclass == kclass) {
-			common_pts_idx =
-			    &common_perm_to_string.data[av_inherit[i].
-							common_pts_idx];
-			common_base = av_inherit[i].common_base;
-			break;
-		}
-	}
-
-	i = 0;
-	perm = 1;
-	while (perm < common_base) {
-		if (strcmp
-		    (s,
-		     common_perm_to_string_data.str + common_pts_idx[i]) == 0)
-			return perm;
-		perm <<= 1;
-		i++;
-	}
-
-	for (i = 0; i < NVECTORS; i++) {
-		if ((av_perm_to_string[i].tclass == kclass) &&
-		    (strcmp(s, (av_perm_to_string_data.str
-				+ av_perm_to_string[i].nameidx)) == 0))
-			return av_perm_to_string[i].value;
-	}
-
-	errno = EINVAL;
-	return 0;
-}
-
-static const char *security_class_to_string_compat(security_class_t tclass)
-{
-	if (tclass > 0 && tclass < NCLASSES)
-		return class_to_string_data.str + class_to_string[tclass];
-
-	errno = EINVAL;
-	return NULL;
-}
-
-static const char *security_av_perm_to_string_compat(security_class_t tclass,
-				       access_vector_t av)
-{
-	const uint16_t *common_pts_idx = 0;
-	access_vector_t common_base = 0;
-	unsigned int i;
-
-	if (!av) {
-		errno = EINVAL;
-		return NULL;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
-		if (av_inherit[i].tclass == tclass) {
-			common_pts_idx =
-			    &common_perm_to_string.data[av_inherit[i].
-							common_pts_idx];
-			common_base = av_inherit[i].common_base;
-			break;
-		}
-	}
-
-	if (av < common_base) {
-		i = 0;
-		while (!(av & 1)) {
-			av >>= 1;
-			i++;
-		}
-		return common_perm_to_string_data.str + common_pts_idx[i];
-	}
-
-	for (i = 0; i < NVECTORS; i++) {
-		if (av_perm_to_string[i].tclass == tclass &&
-		    av_perm_to_string[i].value == av)
-			return av_perm_to_string_data.str
-				+ av_perm_to_string[i].nameidx;
-	}
-
-	errno = EINVAL;
-	return NULL;
-}
-
 security_class_t string_to_security_class(const char *s)
 {
 	struct discover_class_node *node;
 
-	__selinux_once(once, init_obj_class_compat);
-
-	if (obj_class_compat)
-		return string_to_security_class_compat(s);
-
 	node = get_class_cache_entry_name(s);
 	if (node == NULL) {
 		node = discover_class(s);
@@ -468,11 +201,6 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	struct discover_class_node *node;
 	security_class_t kclass = unmap_class(tclass);
 
-	__selinux_once(once, init_obj_class_compat);
-
-	if (obj_class_compat)
-		return map_perm(tclass, string_to_av_perm_compat(kclass, s));
-
 	node = get_class_cache_entry_value(kclass);
 	if (node != NULL) {
 		size_t i;
@@ -491,14 +219,9 @@ const char *security_class_to_string(security_class_t tclass)
 
 	tclass = unmap_class(tclass);
 
-	__selinux_once(once, init_obj_class_compat);
-
-	if (obj_class_compat)
-		return security_class_to_string_compat(tclass);
-
 	node = get_class_cache_entry_value(tclass);
 	if (node == NULL)
-		return security_class_to_string_compat(tclass);
+		return NULL;
 	else
 		return node->name;
 }
@@ -512,18 +235,13 @@ const char *security_av_perm_to_string(security_class_t tclass,
 	av = unmap_perm(tclass, av);
 	tclass = unmap_class(tclass);
 
-	__selinux_once(once, init_obj_class_compat);
-
-	if (obj_class_compat)
-		return security_av_perm_to_string_compat(tclass,av);
-
 	node = get_class_cache_entry_value(tclass);
 	if (av && node)
 		for (i = 0; i<MAXVECTORS; i++)
 			if ((1<<i) & av)
 				return node->perms[i];
 
-	return security_av_perm_to_string_compat(tclass,av);
+	return NULL;
 }
 
 int security_av_string(security_class_t tclass, access_vector_t av, char **res)
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index 4ac7e86..e0212e4 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <string.h>
 #include <ctype.h>
-#include <selinux/flask.h>
 #include <selinux/selinux.h>
 
 static void usage(const char *name, const char *detail, int rc)
@@ -22,7 +21,7 @@ static char * get_selinux_proc_context(const char *command, char * execcon) {
 
 	int ret = getfilecon(command, &fcon);
 	if (ret < 0) goto err;
-	ret = security_compute_create(execcon, fcon, SECCLASS_PROCESS, &newcon);
+	ret = security_compute_create(execcon, fcon, string_to_security_class("process"), &newcon);
 	if (ret < 0) goto err;
 
 err:
diff --git a/policycoreutils/mcstrans/src/mcscolor.c b/policycoreutils/mcstrans/src/mcscolor.c
index 90c4321..fdb7048 100644
--- a/policycoreutils/mcstrans/src/mcscolor.c
+++ b/policycoreutils/mcstrans/src/mcscolor.c
@@ -9,8 +9,6 @@
 #include <alloca.h>
 #include <fnmatch.h>
 #include <syslog.h>
-#include <selinux/flask.h>
-#include <selinux/av_permissions.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include "mcstrans.h"
@@ -110,7 +108,7 @@ static int check_dominance(const char *pattern, const char *raw) {
 	if (!raw)
 		goto out;
 
-	rc = security_compute_av_raw(ctx, (security_context_t)raw, SECCLASS_CONTEXT, bit, &avd);
+	rc = security_compute_av_raw(ctx, (security_context_t)raw, string_to_security_class("context"), bit, &avd);
 	if (rc)
 		goto out;
 
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index dfb8c7f..495cf2e 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -66,7 +66,6 @@
 #include <string.h>
 #include <errno.h>
 #include <selinux/selinux.h>	/* for is_selinux_enabled() */
-#include <selinux/flask.h>	/* for SECCLASS_CHR_FILE */
 #include <selinux/context.h>	/* for context-mangling functions */
 #include <selinux/get_default_type.h>
 #include <selinux/get_context_list.h>	/* for SELINUX_DEFAULTUSER */
@@ -711,7 +710,7 @@ static int relabel_tty(const char *ttyn, security_context_t new_context,
 
 	if (tty_con &&
 	    (security_compute_relabel(new_context, tty_con,
-				      SECCLASS_CHR_FILE, &new_tty_con) < 0)) {
+				      string_to_security_class("chr_file"), &new_tty_con) < 0)) {
 		fprintf(stderr, _("%s!  Could not get new context for %s, "
 				  "not relabeling tty.\n"),
 			enforcing ? "Error" : "Warning", ttyn);
-- 
1.9.3


--------------030509060708030302080801--
