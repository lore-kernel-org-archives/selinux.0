Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE377F2C
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NG6o0Xf7"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f962cf6c9so273656d6.0
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197566; x=1703802366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NqH0m8Lzov8DaUvinc3Sj5g5DyzAjPb/29ODXhPSE0=;
        b=NG6o0Xf76pXgMPE+QvrrjgljpSIKC8XfKn+kBszLvaxl/M33tU2AJR/nW6rv6VEDVO
         w4kYiuZLpXlz2KG92izxb8tx619c1RIt+zH4iyJStcgoOTK67RBuX+Mbm9M2tRw8M2aB
         jBDrIDO2A2HJ7hZJ9HwfxDhirGnUmw8gIqCGUXn0uOPpJWtMew274BL8t817QssLvT1x
         kOhteztUEl5fclypNu4G1Qd/MgLOSxhBEx6e3l/wC1V961V3KbLW2e4F2uAzCKYpE9DK
         RJ4kG07ejCCRmf7W6CwiEp7ayEgr50r9yJ7L2RG2UCl63yirXUSfU39A0Y8iR9Ep6iHn
         ARhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197566; x=1703802366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NqH0m8Lzov8DaUvinc3Sj5g5DyzAjPb/29ODXhPSE0=;
        b=QreBxodXmOuNhEmhUsd1kJtHgTeFSaTI4ZF4mkoNszd8ZxZkj/+1/AJE1zaEn8c0wn
         MHT+k9dP15+uIPLtcZEe/S6Dhhu2KhSeY9soA5quVvh7mZMOQnDBCrSNpODPBpsWzXsH
         3UxB4lDK8e+NcQfmZR72edd1K50QNlUtpBnYRPylDnlHoHdal/o3rJud3ZV0NLX7ksbY
         Mh1CkFZiKnS3VfDg1MovLvZtHOQ5ixvEO9DMMKHxBRPyPrnsUWshhgWWQU3yo0zI7xGe
         IpsITecu6SX7USNO5QgX0A5zeSF8aZ8CkKuJZ6+ZmV/FO8vi2uN5ofqO1wOZrz98+rSa
         Gsaw==
X-Gm-Message-State: AOJu0Yz6zgLoYhxRYs3pFvRRwvLZsXHPELM80cPwrnD533fLSupNypHF
	HSMDTo9u65S0yXDhMcfZRTry1qzETHBf4cCXtAWNzdW/8g==
X-Google-Smtp-Source: AGHT+IEbaId43t4gLTv3+S0bL0mSCTaztM4YpWpyXaosWaX2r273ppTixU5tEZTPu1pD+6sLIlKHSQ==
X-Received: by 2002:a05:6214:2a4f:b0:67f:398f:b6d9 with SMTP id jf15-20020a0562142a4f00b0067f398fb6d9mr1923724qvb.10.1703197566260;
        Thu, 21 Dec 2023 14:26:06 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bu6-20020ad455e6000000b0067f2a72f68bsm897644qvb.146.2023.12.21.14.26.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:05 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 05/15] selinux: fix style issues in security/selinux/include/classmap.h
Date: Thu, 21 Dec 2023 17:18:48 -0500
Message-ID: <20231221222342.334026-22-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17232; i=paul@paul-moore.com; h=from:subject; bh=dAgPYfKun//1jRdjWx7YCp5u4QhamCb86SvpIj1hitY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLsJsiGR0YID9pcpK/0QhEb2vSDZpj6Nb927T UO9qgR0v0SJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7CQAKCRDqIPLalzeJ c+OiD/0eyhids9KQ4Vd/KyvV86DpmWWwrQ8NRdoNvV3zzMpO+XkM9RAGvv80PX88/RsCDKxOwzu 4Nv0fJbWZnsb428CrjR4F4X7HJUJ61vBqlOQKa+Vxxu1NSqSHAnxDxVm8rZ8fSfeEQQCIBhbAzO su+sdCDM3V51ROEBexOTluSX0SCqxQx+Xoj7Yx1T+PFMN+eSANAkKuBrp65t3tIxyj1sfVINsqq a+HIZKiwPWQwYji77O1d3TW/kUWnhSllM2lz0Vi9jRjhWJp29hY+T7+mrwMMpxz8Qzfqim+Ht+M EnonocgSsary3pbVyMqw1QbdWzB42vLt1GG8NftBJRrU6Ksjet6H6Nw0Qms5FNeHYZAPy57AKNo mXJW2mRW+jzRf1byp+PheD9ZomnYgSeIPWrr0amDSxag+IF/wtHkCK1175vddCppp2ERZkGes+V aBjV0p+enaMRNk4XDNLoqPfU5GWheIYnbCNuiwQ/WAycNF4L7PLW3efC25mq78Zd4RekIQswv6X X8TLYJ7nKvh86bM8kCMPXdzslWiq68+t3RW+9x90hcSkWJx/ltTHGTsuDo725nMrCgY/J1cteUn 5iPLjDaSZSsYBOkHAFoaTMUjeTPlFOk4QT6lXhQIU5BckK3UDkAFi7M2VajCb1ODJEZbUIasrQf Y8GzoMo99GTvvyw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/classmap.h | 342 +++++++++++-----------------
 1 file changed, 132 insertions(+), 210 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..7229c9bf6c27 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -1,34 +1,40 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #include <linux/capability.h>
 #include <linux/socket.h>
 
-#define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
-    "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
+#define COMMON_FILE_SOCK_PERMS                                            \
+	"ioctl", "read", "write", "create", "getattr", "setattr", "lock", \
+		"relabelfrom", "relabelto", "append", "map"
 
-#define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
-    "rename", "execute", "quotaon", "mounton", "audit_access", \
-	"open", "execmod", "watch", "watch_mount", "watch_sb", \
-	"watch_with_perm", "watch_reads"
+#define COMMON_FILE_PERMS                                                \
+	COMMON_FILE_SOCK_PERMS, "unlink", "link", "rename", "execute",   \
+		"quotaon", "mounton", "audit_access", "open", "execmod", \
+		"watch", "watch_mount", "watch_sb", "watch_with_perm",   \
+		"watch_reads"
 
-#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
-    "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
-    "sendto", "name_bind"
+#define COMMON_SOCK_PERMS                                              \
+	COMMON_FILE_SOCK_PERMS, "bind", "connect", "listen", "accept", \
+		"getopt", "setopt", "shutdown", "recvfrom", "sendto",  \
+		"name_bind"
 
-#define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
-	    "write", "associate", "unix_read", "unix_write"
+#define COMMON_IPC_PERMS                                            \
+	"create", "destroy", "getattr", "setattr", "read", "write", \
+		"associate", "unix_read", "unix_write"
 
-#define COMMON_CAP_PERMS  "chown", "dac_override", "dac_read_search", \
-	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap", \
-	    "linux_immutable", "net_bind_service", "net_broadcast", \
-	    "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module", \
-	    "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin", \
-	    "sys_boot", "sys_nice", "sys_resource", "sys_time", \
-	    "sys_tty_config", "mknod", "lease", "audit_write", \
-	    "audit_control", "setfcap"
+#define COMMON_CAP_PERMS                                                     \
+	"chown", "dac_override", "dac_read_search", "fowner", "fsetid",      \
+		"kill", "setgid", "setuid", "setpcap", "linux_immutable",    \
+		"net_bind_service", "net_broadcast", "net_admin", "net_raw", \
+		"ipc_lock", "ipc_owner", "sys_module", "sys_rawio",          \
+		"sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin",        \
+		"sys_boot", "sys_nice", "sys_resource", "sys_time",          \
+		"sys_tty_config", "mknod", "lease", "audit_write",           \
+		"audit_control", "setfcap"
 
-#define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
-		"checkpoint_restore"
+#define COMMON_CAP2_PERMS                                                     \
+	"mac_override", "mac_admin", "syslog", "wake_alarm", "block_suspend", \
+		"audit_read", "perfmon", "bpf", "checkpoint_restore"
 
 #if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
 #error New capability defined, please update COMMON_CAP2_PERMS.
@@ -40,224 +46,140 @@
  */
 const struct security_class_mapping secclass_map[] = {
 	{ "security",
-	  { "compute_av", "compute_create", "compute_member",
-	    "check_context", "load_policy", "compute_relabel",
-	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
+	  { "compute_av", "compute_create", "compute_member", "check_context",
+	    "load_policy", "compute_relabel", "compute_user", "setenforce",
+	    "setbool", "setsecparam", "setcheckreqprot", "read_policy",
+	    "validate_trans", NULL } },
 	{ "process",
-	  { "fork", "transition", "sigchld", "sigkill",
-	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
-	    "getsession", "getpgid", "setpgid", "getcap", "setcap", "share",
-	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
-	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
-	    "execmem", "execstack", "execheap", "setkeycreate",
-	    "setsockcreate", "getrlimit", NULL } },
-	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "fork",	    "transition",    "sigchld",	    "sigkill",
+	    "sigstop",	    "signull",	     "signal",	    "ptrace",
+	    "getsched",	    "setsched",	     "getsession",  "getpgid",
+	    "setpgid",	    "getcap",	     "setcap",	    "share",
+	    "getattr",	    "setexec",	     "setfscreate", "noatsecure",
+	    "siginh",	    "setrlimit",     "rlimitinh",   "dyntransition",
+	    "setcurrent",   "execmem",	     "execstack",   "execheap",
+	    "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
+	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
 	{ "system",
-	  { "ipc_info", "syslog_read", "syslog_mod",
-	    "syslog_console", "module_request", "module_load", NULL } },
-	{ "capability",
-	  { COMMON_CAP_PERMS, NULL } },
+	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
+	    "module_request", "module_load", NULL } },
+	{ "capability", { COMMON_CAP_PERMS, NULL } },
 	{ "filesystem",
-	  { "mount", "remount", "unmount", "getattr",
-	    "relabelfrom", "relabelto", "associate", "quotamod",
-	    "quotaget", "watch", NULL } },
+	  { "mount", "remount", "unmount", "getattr", "relabelfrom",
+	    "relabelto", "associate", "quotamod", "quotaget", "watch", NULL } },
 	{ "file",
-	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", NULL } },
+	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
 	{ "dir",
-	  { COMMON_FILE_PERMS, "add_name", "remove_name",
-	    "reparent", "search", "rmdir", NULL } },
+	  { COMMON_FILE_PERMS, "add_name", "remove_name", "reparent", "search",
+	    "rmdir", NULL } },
 	{ "fd", { "use", NULL } },
-	{ "lnk_file",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "chr_file",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "blk_file",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "sock_file",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "fifo_file",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lnk_file", { COMMON_FILE_PERMS, NULL } },
+	{ "chr_file", { COMMON_FILE_PERMS, NULL } },
+	{ "blk_file", { COMMON_FILE_PERMS, NULL } },
+	{ "sock_file", { COMMON_FILE_PERMS, NULL } },
+	{ "fifo_file", { COMMON_FILE_PERMS, NULL } },
+	{ "socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "tcp_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", "name_connect",
-	    NULL } },
-	{ "udp_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", NULL } },
-	{ "rawip_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", NULL } },
-	{ "node",
-	  { "recvfrom", "sendto", NULL } },
-	{ "netif",
-	  { "ingress", "egress", NULL } },
-	{ "netlink_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "packet_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "key_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "unix_stream_socket",
-	  { COMMON_SOCK_PERMS, "connectto", NULL } },
-	{ "unix_dgram_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "sem",
-	  { COMMON_IPC_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "node_bind", "name_connect", NULL } },
+	{ "udp_socket", { COMMON_SOCK_PERMS, "node_bind", NULL } },
+	{ "rawip_socket", { COMMON_SOCK_PERMS, "node_bind", NULL } },
+	{ "node", { "recvfrom", "sendto", NULL } },
+	{ "netif", { "ingress", "egress", NULL } },
+	{ "netlink_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "packet_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "key_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "unix_stream_socket", { COMMON_SOCK_PERMS, "connectto", NULL } },
+	{ "unix_dgram_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "sem", { COMMON_IPC_PERMS, NULL } },
 	{ "msg", { "send", "receive", NULL } },
-	{ "msgq",
-	  { COMMON_IPC_PERMS, "enqueue", NULL } },
-	{ "shm",
-	  { COMMON_IPC_PERMS, "lock", NULL } },
-	{ "ipc",
-	  { COMMON_IPC_PERMS, NULL } },
+	{ "msgq", { COMMON_IPC_PERMS, "enqueue", NULL } },
+	{ "shm", { COMMON_IPC_PERMS, "lock", NULL } },
+	{ "ipc", { COMMON_IPC_PERMS, NULL } },
 	{ "netlink_route_socket",
-	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
 	{ "netlink_tcpdiag_socket",
-	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", NULL } },
-	{ "netlink_nflog_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
+	{ "netlink_nflog_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_xfrm_socket",
-	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", NULL } },
-	{ "netlink_selinux_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_iscsi_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
+	{ "netlink_selinux_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_iscsi_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_audit_socket",
-	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", "nlmsg_relay", "nlmsg_readpriv",
-	    "nlmsg_tty_audit", NULL } },
-	{ "netlink_fib_lookup_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_connector_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_netfilter_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_dnrt_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg_relay",
+	    "nlmsg_readpriv", "nlmsg_tty_audit", NULL } },
+	{ "netlink_fib_lookup_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_connector_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_netfilter_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_dnrt_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "association",
 	  { "sendto", "recvfrom", "setcontext", "polmatch", NULL } },
-	{ "netlink_kobject_uevent_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_generic_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_scsitransport_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_rdma_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netlink_crypto_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "appletalk_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_kobject_uevent_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_generic_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_scsitransport_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_rdma_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netlink_crypto_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "appletalk_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "packet",
 	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
 	{ "key",
 	  { "view", "read", "write", "search", "link", "setattr", "create",
 	    NULL } },
 	{ "dccp_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", "name_connect", NULL } },
+	  { COMMON_SOCK_PERMS, "node_bind", "name_connect", NULL } },
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
-	{ "capability2",
-	  { COMMON_CAP2_PERMS, NULL } },
+	{ "capability2", { COMMON_CAP2_PERMS, NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
-	{ "tun_socket",
-	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
-	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
-		      NULL } },
-	{ "cap_userns",
-	  { COMMON_CAP_PERMS, NULL } },
-	{ "cap2_userns",
-	  { COMMON_CAP2_PERMS, NULL } },
+	{ "tun_socket", { COMMON_SOCK_PERMS, "attach_queue", NULL } },
+	{ "binder",
+	  { "impersonate", "call", "set_context_mgr", "transfer", NULL } },
+	{ "cap_userns", { COMMON_CAP_PERMS, NULL } },
+	{ "cap2_userns", { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", "name_connect", "association", NULL } },
-	{ "icmp_socket",
-	  { COMMON_SOCK_PERMS,
-	    "node_bind", NULL } },
-	{ "ax25_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "ipx_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "netrom_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "atmpvc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "x25_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "rose_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "decnet_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "atmsvc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "rds_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "irda_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "pppox_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "llc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "can_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "tipc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "bluetooth_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "iucv_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "rxrpc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "isdn_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "phonet_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "ieee802154_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "caif_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "alg_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "nfc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "vsock_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "kcm_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "qipcrtr_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "smc_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "infiniband_pkey",
-	  { "access", NULL } },
-	{ "infiniband_endport",
-	  { "manage_subnet", NULL } },
+	  { COMMON_SOCK_PERMS, "node_bind", "name_connect", "association",
+	    NULL } },
+	{ "icmp_socket", { COMMON_SOCK_PERMS, "node_bind", NULL } },
+	{ "ax25_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "ipx_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "netrom_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "atmpvc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "x25_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "rose_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "decnet_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "atmsvc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "rds_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "irda_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "pppox_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "llc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "can_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "tipc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "bluetooth_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "iucv_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "rxrpc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "isdn_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "phonet_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "ieee802154_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "caif_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "alg_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "nfc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "vsock_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "kcm_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "qipcrtr_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "smc_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "infiniband_pkey", { "access", NULL } },
+	{ "infiniband_endport", { "manage_subnet", NULL } },
 	{ "bpf",
 	  { "map_create", "map_read", "map_write", "prog_load", "prog_run",
 	    NULL } },
-	{ "xdp_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "mctp_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	{ "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
+	{ "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
 	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
-	{ "anon_inode",
-	  { COMMON_FILE_PERMS, NULL } },
-	{ "io_uring",
-	  { "override_creds", "sqpoll", "cmd", NULL } },
-	{ "user_namespace",
-	  { "create", NULL } },
+	{ "anon_inode", { COMMON_FILE_PERMS, NULL } },
+	{ "io_uring", { "override_creds", "sqpoll", "cmd", NULL } },
+	{ "user_namespace", { "create", NULL } },
 	{ NULL }
-  };
+};
 
 #if PF_MAX > 46
 #error New address family defined, please update secclass_map.
-- 
2.43.0

