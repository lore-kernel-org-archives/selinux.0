Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1254324319.30591.59.camel@moss-pluto.epoch.ncsc.mil>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC2C32D.3010405@ak.jp.nec.com>
	 <1254324319.30591.59.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Sep 2009 12:40:02 -0400
Message-Id: <1254328802.30591.69.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-30 at 11:25 -0400, Stephen Smalley wrote:
> On Wed, 2009-09-30 at 11:32 +0900, KaiGai Kohei wrote:
> > Stephen Smalley wrote:
> > > There are several legacy permissions that are no longer used by SELinux.
> > > We could remove these from the kernel's classmap.h definitions without
> > > breaking anything (subsequent permissions would get mapped to policy
> > > values appropriately by the new logic), but removing them from the
> > > policy would be harder as it would break all kernels that predate these
> > > patches.  Thus, I'm not sure we benefit from removing them from
> > > classmap.h.
> > > 
> > > The unused permissions include:
> > > # LSM hook never merged to mainline
> > > file swapon
> > > # compat_net=1 checks
> > > socket { recv_msg send_msg }
> > > # Only added so that subsequent permissions (execmod) would get the same value as class file
> > > chr_file { execute_no_trans entrypoint }
> > > # Original socket controls; never merged to mainline
> > > tcp_socket { connectto newconn acceptfrom }
> > > # legacy network or compat_net=1 checks
> > > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send }
> > > # legacy network or compat_net=1 checks
> > > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
> > > # Original socket controls; never merged to mainline - only connectto is used
> > > unix_stream_socket { newconn acceptfrom }
> > > # Patches merged prematurely by Fedora, never merged to mainline
> > > packet { flow_in flow_out }
> > 
> > It is just a report. I could not reach origin of the matter yet.
> > 
> > When I applies your patch as is, build, install and reboot,
> > I could not find any *obvious* matter (such as boot failed). Good.
> > 
> > Then, I modified the classmap.h for the test purpose.
> > The object classes and access vectors are ramdomized as the
> > attached claasmap.h.
> > This patch enables to map value of them using text identifier,
> > so we can expect it works fine independent from the order of
> > classes and access vectors.
> 
> Your classmap.h file violates the requirement that the kernel
> definitions for the common file perms and common sock perms line up with
> each other for the set of permissions checked by file hooks that can be
> applied to either files or sockets.  I noted that as a caveat in one of
> my messages.

I'll make that more explicit by separating the shared permissions into
separate #define.  Also I'll go ahead and split out the common ipc
perms.

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5d30fd0..8b32e95 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -1,14 +1,15 @@
-/* These definitions must match the definitions in av_permissions.h. */
+#define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
+    "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
 
-#define COMMON_FILE_PERMS "ioctl", "read", "write", "create", "getattr", \
-	    "setattr", "lock", "relabelfrom", "relabelto", "append", "unlink", \
-	    "link", "rename", "execute", "swapon", "quotaon", "mounton"
+#define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
+    "rename", "execute", "swapon", "quotaon", "mounton"
 
-#define COMMON_SOCK_PERMS "ioctl", "read", "write", "create", "getattr", \
-	    "setattr", "lock", "relabelfrom", "relabelto", \
-	    "append", "bind", "connect", "listen", "accept", \
-	    "getopt", "setopt", "shutdown", "recvfrom", \
-	    "sendto", "recv_msg", "send_msg", "name_bind"
+#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
+    "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
+    "sendto", "recv_msg", "send_msg", "name_bind"
+
+#define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
+	    "write", "associate", "unix_read", "unix_write"
 
 struct security_class_mapping secclass_map[] = {
 	{ "security",
@@ -91,20 +92,14 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL
 	  } },
 	{ "sem",
-	  { "create", "destroy", "getattr", "setattr", "read",
-	    "write", "associate", "unix_read", "unix_write", NULL } },
+	  { COMMON_IPC_PERMS, NULL } },
 	{ "msg", { "send", "receive", NULL } },
 	{ "msgq",
-	  { "create", "destroy", "getattr", "setattr", "read",
-	    "write", "associate", "unix_read", "unix_write",
-	    "enqueue", NULL } },
+	  { COMMON_IPC_PERMS, "enqueue", NULL } },
 	{ "shm",
-	  { "create", "destroy", "getattr", "setattr", "read",
-	    "write", "associate", "unix_read", "unix_write", "lock",
-	    NULL } },
+	  { COMMON_IPC_PERMS, "lock", NULL } },
 	{ "ipc",
-	  { "create", "destroy", "getattr", "setattr", "read",
-	    "write", "associate", "unix_read", "unix_write", NULL } },
+	  { COMMON_IPC_PERMS, NULL } },
 	{ "netlink_route_socket",
 	  { COMMON_SOCK_PERMS,
 	    "nlmsg_read", "nlmsg_write", NULL } },


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
