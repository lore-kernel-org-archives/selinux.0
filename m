Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9UGbPv7023399
 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2014 12:37:25 -0400
Message-ID: <54526941.3090208@sonymobile.com>
Date: Thu, 30 Oct 2014 17:37:21 +0100
From: peter enderborg <peter.enderborg@sonymobile.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Missing security labels for socket objects?
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi! Im trying to see where the access control for some socket objects occurs.
And it seems not to be very detailed resolution for sockets. For some
protocols there is NOTHING. I did a test. I created a own protocol. AF_PEG_IPC.
This can be accessed without specific type definition or contexts. It
need socket access. In my system there is about 20 different protocols.
They are "all or nothing".

The question is how do I select which root task that can access
AF_PEG_IPC and who can not.  In selinux root is supposed to be
in locked container.


The kernel test patch is for 3.4-ish. (ala android)
----------------------

Test program:

/* test program
  * writen by peter.enderborg@sonymobie.com
  * Open and write to a local defined IPC.
  */

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <errno.h>
#include <string.h>

#define AF_PEG_IPC 39

struct sockaddr_peg_ipc {
   unsigned short family;
   unsigned char reserved;
};

int main()
{
   int fd,res;
   char dummy_data[256];
   struct sockaddr_peg_ipc dest_addr;

   fd = socket(AF_PEG_IPC, SOCK_DGRAM, 0);
   printf("Socket %d\n",fd);
   if (fd > 0) {
     dest_addr.family = AF_PEG_IPC;
     res = sendto(fd, dummy_data, 256, MSG_DONTWAIT, (struct sockaddr *)&dest_addr, sizeof(struct sockaddr_peg_ipc));
     printf("res: %d\n",res);
     if (res < 0) {
       printf("Error: %s %d\n", strerror(errno),errno);
     }
   } else {
       printf("Error: %s %d\n", strerror(errno),errno);
   }
   return 0;
}


And the patch

 From 77fea03d7c4cee8ef7f5ec21451206074d270b3d Mon Sep 17 00:00:00 2001
From: Peter Enderborg <peter.enderborg@sonymobile.com>
Date: Thu, 30 Oct 2014 16:28:23 +0100
Subject: [PATCH] Test of local defined IPC

Change-Id: Iaba1e7419fbae716424a042a47fb6abb704e814e
---
  drivers/net/Makefile |   1 +
  drivers/net/peg.c    | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 161 insertions(+)
  create mode 100644 drivers/net/peg.c

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index a6b8ce1..ad836d21 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -7,6 +7,7 @@
  #
  obj-$(CONFIG_BONDING) += bonding/
  obj-$(CONFIG_DUMMY) += dummy.o
+obj-$(CONFIG_DUMMY) += peg.o
  obj-$(CONFIG_EQUALIZER) += eql.o
  obj-$(CONFIG_IFB) += ifb.o
  obj-$(CONFIG_MACVLAN) += macvlan.o
diff --git a/drivers/net/peg.c b/drivers/net/peg.c
new file mode 100644
index 0000000..8f9085e
--- /dev/null
+++ b/drivers/net/peg.c
@@ -0,0 +1,160 @@
+/* test module for a new "unknown" IPC.
+ * It does not do anything else than
+ * print on kernel log when something
+ * has been sent on the IPC.
+ * writen by peter.enderborg@sonymobile.com
+*/
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+
+#include <net/sock.h>
+
+/* some uniq value... */
+#define AF_PEG_IPC              39
+
+struct sockaddr_peg_ipc {
+        unsigned short family;
+};
+
+struct peg_ipc_sock {
+        struct sock sk;
+};
+
+static struct proto peg_ipc_proto;
+static const struct proto_ops peg_ipc_proto_ops;
+
+static struct proto peg_ipc_proto = {
+        .name           = "PEG_IPC",
+        .owner          = THIS_MODULE,
+        .obj_size       = sizeof(struct peg_ipc_sock),
+};
+
+static int peg_ipc_create(struct net *net,
+                          struct socket *sock,
+                          int protocol,
+                          int kern)
+{
+        struct sock *sk;
+
+        pr_err("peg ipc create\n");
+
+        if (unlikely(protocol != 0)) {
+                pr_err("%s: Protocol not supported\n", __func__);
+                return -EPROTONOSUPPORT;
+        }
+
+        switch (sock->type) {
+        case SOCK_DGRAM:
+                break;
+        default:
+                pr_err("%s: Protocol type not supported\n", __func__);
+                return -EPROTOTYPE;
+        }
+
+        sk = sk_alloc(net, AF_PEG_IPC, GFP_KERNEL, &peg_ipc_proto);
+        if (!sk) {
+                pr_err("%s: sk_alloc failed\n", __func__);
+                return -ENOMEM;
+        }
+        sock->ops = &peg_ipc_proto_ops;
+        sock_init_data(sock, sk);
+        return 0;
+}
+
+static int peg_ipc_sendmsg(struct kiocb *iocb, struct socket *sock,
+                                  struct msghdr *m, size_t total_len)
+{
+        struct sock *sk = sock->sk;
+        struct sockaddr_peg_ipc *dest = (struct sockaddr_peg_ipc *)m->msg_name;
+
+        if (!dest)
+                return -EDESTADDRREQ;
+
+        if (m->msg_namelen < sizeof(*dest) || dest->family != AF_PEG_IPC)
+                return -EINVAL;
+
+        lock_sock(sk);
+        pr_err("Sendmsg\n");
+        release_sock(sk);
+        return 1;
+}
+
+static int peg_ipc_release(struct socket *sock)
+{
+        struct sock *sk = sock->sk;
+
+        lock_sock(sk);
+        pr_err("peg_icp release\n");
+        release_sock(sk);
+        sock_put(sk);
+        sock->sk = NULL;
+
+        return 0;
+}
+
+static const struct net_proto_family peg_ipc_family_ops = {
+        .owner          = THIS_MODULE,
+        .family         = AF_PEG_IPC,
+        .create         = peg_ipc_create
+};
+
+static const struct proto_ops peg_ipc_proto_ops = {
+        .family         = AF_PEG_IPC,
+        .owner          = THIS_MODULE,
+        .release        = peg_ipc_release,
+        .sendmsg        = peg_ipc_sendmsg,
+
+        .accept         = sock_no_accept,
+        .bind           = sock_no_bind,
+        .connect        = sock_no_connect,
+        .socketpair     = sock_no_socketpair,
+        .getname        = sock_no_getname,
+        .poll           = sock_no_poll,
+        .ioctl          = sock_no_ioctl,
+        .listen         = sock_no_listen,
+        .shutdown       = sock_no_shutdown,
+        .setsockopt     = sock_no_setsockopt,
+        .getsockopt     = sock_no_getsockopt,
+        .recvmsg        = sock_no_recvmsg,
+        .mmap           = sock_no_mmap,
+        .sendpage       = sock_no_sendpage,
+};
+
+static int __init peg_init_module(void)
+{
+        int ret;
+        pr_err("peg_init_module\n");
+
+        ret = proto_register(&peg_ipc_proto, 1);
+        if (ret) {
+                pr_err("Failed to register PEG_IPC\n");
+                goto out;
+        }
+
+        ret = sock_register(&peg_ipc_family_ops);
+        if (ret) {
+                pr_err("Failed to register PEG_IPC\n");
+                proto_unregister(&peg_ipc_proto);
+                goto out;
+        }
+        pr_err("Registed PEG_IPC\n");
+ out:
+
+  return 0;
+}
+
+static void __exit peg_cleanup_module(void)
+{
+        pr_err("peg_cleanup_module\n");
+}
+
+module_init(peg_init_module);
+module_exit(peg_cleanup_module);
+MODULE_LICENSE("GPL");
-- 
1.8.2.2
