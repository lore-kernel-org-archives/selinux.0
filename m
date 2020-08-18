Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7FDC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B5E207DA
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHRQJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgHRQJx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 18 Aug 2020 12:09:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE2C2076E;
        Tue, 18 Aug 2020 16:09:50 +0000 (UTC)
Date:   Tue, 18 Aug 2020 12:09:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
Message-ID: <20200818120948.1a428da9@oasis.local.home>
In-Reply-To: <20200817162933.79f69c66@oasis.local.home>
References: <20200817170729.2605279-1-tweek@google.com>
        <20200817170729.2605279-4-tweek@google.com>
        <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
        <20200817162933.79f69c66@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 17 Aug 2020 16:29:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 17 Aug 2020 16:13:29 -0400
> Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> > Does this require a corresponding patch to userspace?  Otherwise, I get 
> > the following:
> > 
> > libtraceevent: No such file or directory
> >    [avc:selinux_audited] function avc_trace_perm_to_name not defined  
> 
> Yes, we need to add a plugin to libtraceevent that will add that
> function.
> 
> I could possibly write one up real quick.

Something like this (this is patched on top of trace-cmd, but will work
for tools/lib/traceevent too).

With CONFIG_TRACE_EVENT_INJECT enabled (to test events), I did the following:

 # echo 'utclass=1 audited=1 denied=0' > /sys/kernel/tracing/events/avc/selinux_audited/inject
 # trace-cmd extract
 # trace-cmd report
cpus=8
           <...>-1685  [005]  1607.612032: selinux_audited:      requested=0x0 denied=0x0 audited=0x1 result=0 scontext= tcontext= tclass= permissions={ compute_av }

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
diff --git a/lib/traceevent/plugins/Makefile b/lib/traceevent/plugins/Makefile
index 21e933af..13cbcb92 100644
--- a/lib/traceevent/plugins/Makefile
+++ b/lib/traceevent/plugins/Makefile
@@ -16,6 +16,7 @@ PLUGIN_OBJS += plugin_scsi.o
 PLUGIN_OBJS += plugin_cfg80211.o
 PLUGIN_OBJS += plugin_blk.o
 PLUGIN_OBJS += plugin_tlb.o
+PLUGIN_OBJS += plugin_avc.o
 
 PLUGIN_OBJS := $(PLUGIN_OBJS:%.o=$(bdir)/%.o)
 PLUGIN_BUILD := $(PLUGIN_OBJS:$(bdir)/%.o=$(bdir)/%.so)
diff --git a/lib/traceevent/plugins/plugin_avc.c b/lib/traceevent/plugins/plugin_avc.c
new file mode 100644
index 00000000..76af23b9
--- /dev/null
+++ b/lib/traceevent/plugins/plugin_avc.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include "event-parse.h"
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+typedef unsigned short u16;
+
+/* Class/perm mapping support */
+struct security_class_mapping {
+	const char *name;
+	const char *perms[sizeof(unsigned) * 8 + 1];
+};
+
+#define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
+    "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
+
+#define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
+    "rename", "execute", "quotaon", "mounton", "audit_access", \
+	"open", "execmod", "watch", "watch_mount", "watch_sb", \
+	"watch_with_perm", "watch_reads"
+
+#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
+    "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
+    "sendto", "name_bind"
+
+#define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
+	    "write", "associate", "unix_read", "unix_write"
+
+#define COMMON_CAP_PERMS  "chown", "dac_override", "dac_read_search", \
+	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap", \
+	    "linux_immutable", "net_bind_service", "net_broadcast", \
+	    "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module", \
+	    "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin", \
+	    "sys_boot", "sys_nice", "sys_resource", "sys_time", \
+	    "sys_tty_config", "mknod", "lease", "audit_write", \
+	    "audit_control", "setfcap"
+
+#define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
+		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
+
+/*
+ * Note: The name for any socket class should be suffixed by "socket",
+ *	 and doesn't contain more than one substr of "socket".
+ */
+struct security_class_mapping secclass_map[] = {
+	{ "security",
+	  { "compute_av", "compute_create", "compute_member",
+	    "check_context", "load_policy", "compute_relabel",
+	    "compute_user", "setenforce", "setbool", "setsecparam",
+	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
+	{ "process",
+	  { "fork", "transition", "sigchld", "sigkill",
+	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
+	    "getsession", "getpgid", "setpgid", "getcap", "setcap", "share",
+	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
+	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
+	    "execmem", "execstack", "execheap", "setkeycreate",
+	    "setsockcreate", "getrlimit", NULL } },
+	{ "process2",
+	  { "nnp_transition", "nosuid_transition", NULL } },
+	{ "system",
+	  { "ipc_info", "syslog_read", "syslog_mod",
+	    "syslog_console", "module_request", "module_load", NULL } },
+	{ "capability",
+	  { COMMON_CAP_PERMS, NULL } },
+	{ "filesystem",
+	  { "mount", "remount", "unmount", "getattr",
+	    "relabelfrom", "relabelto", "associate", "quotamod",
+	    "quotaget", "watch", NULL } },
+	{ "file",
+	  { COMMON_FILE_PERMS,
+	    "execute_no_trans", "entrypoint", NULL } },
+	{ "dir",
+	  { COMMON_FILE_PERMS, "add_name", "remove_name",
+	    "reparent", "search", "rmdir", NULL } },
+	{ "fd", { "use", NULL } },
+	{ "lnk_file",
+	  { COMMON_FILE_PERMS, NULL } },
+	{ "chr_file",
+	  { COMMON_FILE_PERMS, NULL } },
+	{ "blk_file",
+	  { COMMON_FILE_PERMS, NULL } },
+	{ "sock_file",
+	  { COMMON_FILE_PERMS, NULL } },
+	{ "fifo_file",
+	  { COMMON_FILE_PERMS, NULL } },
+	{ "socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "tcp_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", "name_connect",
+	    NULL } },
+	{ "udp_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", NULL } },
+	{ "rawip_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", NULL } },
+	{ "node",
+	  { "recvfrom", "sendto", NULL } },
+	{ "netif",
+	  { "ingress", "egress", NULL } },
+	{ "netlink_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "packet_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "key_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "unix_stream_socket",
+	  { COMMON_SOCK_PERMS, "connectto", NULL } },
+	{ "unix_dgram_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "sem",
+	  { COMMON_IPC_PERMS, NULL } },
+	{ "msg", { "send", "receive", NULL } },
+	{ "msgq",
+	  { COMMON_IPC_PERMS, "enqueue", NULL } },
+	{ "shm",
+	  { COMMON_IPC_PERMS, "lock", NULL } },
+	{ "ipc",
+	  { COMMON_IPC_PERMS, NULL } },
+	{ "netlink_route_socket",
+	  { COMMON_SOCK_PERMS,
+	    "nlmsg_read", "nlmsg_write", NULL } },
+	{ "netlink_tcpdiag_socket",
+	  { COMMON_SOCK_PERMS,
+	    "nlmsg_read", "nlmsg_write", NULL } },
+	{ "netlink_nflog_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_xfrm_socket",
+	  { COMMON_SOCK_PERMS,
+	    "nlmsg_read", "nlmsg_write", NULL } },
+	{ "netlink_selinux_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_iscsi_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_audit_socket",
+	  { COMMON_SOCK_PERMS,
+	    "nlmsg_read", "nlmsg_write", "nlmsg_relay", "nlmsg_readpriv",
+	    "nlmsg_tty_audit", NULL } },
+	{ "netlink_fib_lookup_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_connector_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_netfilter_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_dnrt_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "association",
+	  { "sendto", "recvfrom", "setcontext", "polmatch", NULL } },
+	{ "netlink_kobject_uevent_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_generic_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_scsitransport_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_rdma_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_crypto_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "appletalk_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "packet",
+	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
+	{ "key",
+	  { "view", "read", "write", "search", "link", "setattr", "create",
+	    NULL } },
+	{ "dccp_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", "name_connect", NULL } },
+	{ "memprotect", { "mmap_zero", NULL } },
+	{ "peer", { "recv", NULL } },
+	{ "capability2",
+	  { COMMON_CAP2_PERMS, NULL } },
+	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
+	{ "tun_socket",
+	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
+	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
+		      NULL } },
+	{ "cap_userns",
+	  { COMMON_CAP_PERMS, NULL } },
+	{ "cap2_userns",
+	  { COMMON_CAP2_PERMS, NULL } },
+	{ "sctp_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", "name_connect", "association", NULL } },
+	{ "icmp_socket",
+	  { COMMON_SOCK_PERMS,
+	    "node_bind", NULL } },
+	{ "ax25_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "ipx_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netrom_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "atmpvc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "x25_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "rose_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "decnet_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "atmsvc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "rds_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "irda_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "pppox_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "llc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "can_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "tipc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "bluetooth_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "iucv_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "rxrpc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "isdn_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "phonet_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "ieee802154_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "caif_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "alg_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "nfc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "vsock_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "kcm_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "qipcrtr_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "smc_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "infiniband_pkey",
+	  { "access", NULL } },
+	{ "infiniband_endport",
+	  { "manage_subnet", NULL } },
+	{ "bpf",
+	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
+	{ "xdp_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
+	{ "perf_event",
+	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
+	{ "lockdown",
+	  { "integrity", "confidentiality", NULL } },
+	{ NULL }
+  };
+
+
+static unsigned long long
+avc_trace_perm_to_name(struct trace_seq *p, unsigned long long *args)
+{
+	u16 tclass = args[1];
+	int av = args[2];
+	int avdenied = args[3];
+	int i, perm;
+	const char **perms;
+
+	if (!tclass || tclass >= ARRAY_SIZE(secclass_map))
+		return 0;
+
+	perms = secclass_map[tclass-1].perms;
+
+	i = 0;
+	perm = 1;
+	while (i < (sizeof(av) * 8)) {
+		if ((perm & av)  && perms[i]) {
+			if (!(perm & avdenied))
+				trace_seq_printf(p, " %s", perms[i]);
+			else
+				trace_seq_printf(p, " !%s", perms[i]);
+			av &= ~perm;
+		}
+		i++;
+		perm <<= 1;
+	}
+
+	return 0;
+}
+
+int TEP_PLUGIN_LOADER(struct tep_handle *tep)
+{
+	tep_register_print_function(tep,
+				    avc_trace_perm_to_name,
+				    TEP_FUNC_ARG_STRING,
+				    "avc_trace_perm_to_name",
+				    TEP_FUNC_ARG_PTR,
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_VOID);
+
+	return 0;
+}
+
+void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
+{
+	tep_unregister_print_function(tep, avc_trace_perm_to_name,
+				    "avc_trace_perm_to_name");
+}
