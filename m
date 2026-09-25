Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905F38E8C9
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356727; cv=none; b=U89yKf93DGDKmZ5IO2uLoXB6rhEs6hjCsbrnUOfJiEQB7My0se3ZlTIZ5c8wbF9JOfrQUk8AqoWd6GZs6mWv4YUWgg0hYGPGw5VYMmrQo4+Ks72O/qOTZ5+x4MPs+wquN0++VcZKHBzMuiCfh9CQIT/Rj4HL/FmhIUgO3GGQ+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356727; c=relaxed/simple;
	bh=a0XAYYlHuoPYPoqff29ODN3iQ/Ru3VO/DDDxH/qB7ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tu6jSgNikWH4mUpQIj8iMJq4jn86Rirn36afUiqjb6ZNcf8q3AxUIpgn9PVgnMumZz4SzRU+zLAd5RIDxnhRa2uecluWTrQu1ZFbwhCidEXg6MOksQ7QpCWvqHIIBQIDQ8qCP232BFBo7yHi4ojdEEwmNKoNQpVDZdbQzKG6alI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=o29FKCip; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="o29FKCip"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356710;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hFlGHvAcjvEtc+A/wORFTL/wEtzpvUx187TUbj/K0Q=;
	b=o29FKCipZ3cItTzrdBzqsQXUfHsnTlaLcFcQlzdCmC8s+dKhP8Yl7vMUmvmOUuxAno+ERX
	qLE9NtZ6PjylG8/URv1JHS/81O153B/RvV3saRyy0DFTMUCShZdyGdUXJ2b+KkcZWvtiSD
	Vb69FFtxTsNPj+e8xhRoAUtNelp87FDEqfnzU0w9gUe6QZaaVCnDAZq3n69pCF6vvQbiRV
	7wSsD3ZW/3z+LB5ai6Vg/HgmOuQQnzUkD01LXxI/8Q6JKIKOH3CoEc6g8ovdXO50RYRzci
	zveiTRwoOndOsbVC8fXmf/dyRethCbsXnbckJypBvFEPoRmxpWaELM/8VQOz8A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/21] defconfig: update for current kernels
Date: Fri, 25 Sep 2026 19:17:37 +0200
Message-ID: <20260925171755.2029271-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Several options have been removed from the kernel or no longer take
effect, so parts of the testsuite silently end up not being configured:

* Drop options that no longer exist: INET_XFRM_MODE_TRANSPORT,
  INET6_XFRM_MODE_TRANSPORT, EXT3_FS_SECURITY, XFS_SECURITY, ANDROID,
  KEYS_COMPAT and NFS_V4_1.
* SMC now depends on DIBS, and SMC_LO has been replaced by DIBS_LO.
  Without DIBS the SMC socket tests are not configured at all.
* CRYPTO_USER_API cannot be selected directly; enable it via
  CRYPTO_USER_API_HASH for the AF_ALG socket tests.
* IP_NF_SECURITY and NETFILTER_XT_MATCH_MULTIPORT need
  NETFILTER_ADVANCED, and the iptables security tables need the legacy
  xtables options.  Also add NFT_COMPAT for iptables with the nf_tables
  backend, and the nf_tables options used by nftables-load.

Also add options required by existing tests that were missing: MPTCP,
vsock loopback, user namespaces and checkpoint/restore, fanotify
permission events, userfaultfd and the function tracer.

Checked by merging into x86_64_defconfig: apart from the filesystem
specific *_FS_SECURITY options, all requested options now end up in the
resulting configuration.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 defconfig | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/defconfig b/defconfig
index 3dcf710..8199efc 100644
--- a/defconfig
+++ b/defconfig
@@ -11,11 +11,16 @@ CONFIG_SECURITY_SELINUX=y
 # Not strictly required for basic SELinux operation.
 CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_NETLABEL=y
+CONFIG_NETFILTER_ADVANCED=y # required for IP_NF_SECURITY and XT_MATCH_MULTIPORT
+CONFIG_NETFILTER_XTABLES_LEGACY=y
+CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP_NF_SECURITY=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_IP6_NF_IPTABLES_LEGACY=m
+CONFIG_IP6_NF_SECURITY=m
+CONFIG_NFT_COMPAT=m # used by iptables with the nf_tables backend
 CONFIG_INET_AH=m
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
 CONFIG_INET6_AH=m
+CONFIG_XFRM_USER=m # used for testing, configured via ip xfrm
 CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
@@ -23,15 +28,18 @@ CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 CONFIG_NETFILTER_XT_TARGET_SECMARK=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NFT_CT=m
 
 # Filesystem security labeling support.
 # Only need to enable the ones for the filesystems on which you are testing.
 # reiserfs is not supported.
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_SECURITY=y
-CONFIG_XFS_SECURITY=y
 CONFIG_JFFS2_FS_SECURITY=y
 CONFIG_F2FS_FS=m
 CONFIG_F2FS_FS_SECURITY=y
@@ -43,6 +51,7 @@ CONFIG_F2FS_FS_SECURITY=y
 CONFIG_IP_SCTP=m
 CONFIG_BT=m
 CONFIG_CRYPTO_USER_API=m
+CONFIG_CRYPTO_USER_API_HASH=m # selects CRYPTO_USER_API
 
 # Network protocol implementations.
 # These are enabled to run sctp ASCONF tests using a GRE tunnel
@@ -67,7 +76,6 @@ CONFIG_OVERLAY_FS=m
 # Android binder implementations.
 # These are enabled to test the binder controls in
 # tests/binder; they are not required for SELinux operation itself.
-CONFIG_ANDROID=y
 CONFIG_ANDROID_BINDER_DEVICES="binder"
 CONFIG_ANDROID_BINDER_IPC=y
 # This will configure the Dynamically Allocated Binder Devices added
@@ -83,7 +91,6 @@ CONFIG_BPF_SYSCALL=y
 # These are enabled to test the key controls in tests/keys; they are
 # not required for SELinux operation itself.
 CONFIG_KEYS=y
-CONFIG_KEYS_COMPAT=y
 CONFIG_KEY_DH_OPERATIONS=y
 
 # Test key management socket.
@@ -99,6 +106,8 @@ CONFIG_TUN=m
 CONFIG_HAVE_PERF_EVENTS=y
 CONFIG_PERF_EVENTS=y
 CONFIG_TRACEPOINTS=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y # provides the ftrace function event
 
 # Test filesystem permissions.
 # This is not required for SELinux operation itself.
@@ -110,7 +119,6 @@ CONFIG_QFMT_V2=y
 # This is not required for SELinux operation itself.
 CONFIG_NFS_FS=m
 CONFIG_NFS_V4=m
-CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_NFS_V4_SECURITY_LABEL=y
 CONFIG_NFSD=m
@@ -141,5 +149,30 @@ CONFIG_DEBUG_FS=y
 
 # Test SMC sockets
 CONFIG_INFINIBAND=m
+CONFIG_DIBS=m
+CONFIG_DIBS_LO=y
 CONFIG_SMC=m
-CONFIG_SMC_LO=y
+
+# Test MPTCP sockets.
+# This is not required for SELinux operation itself.
+CONFIG_MPTCP=y
+CONFIG_MPTCP_IPV6=y
+
+# Test vsock sockets over the loopback transport.
+# This is not required for SELinux operation itself.
+CONFIG_VSOCKETS=m
+CONFIG_VSOCKETS_LOOPBACK=m
+
+# Test capabilities in user namespaces and BPF tokens.
+# This is not required for SELinux operation itself.
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y # provides /proc/sys/kernel/ns_last_pid
+
+# Test fanotify permission events.
+# This is not required for SELinux operation itself.
+CONFIG_FANOTIFY=y
+CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
+
+# Test userfaultfd.
+# This is not required for SELinux operation itself.
+CONFIG_USERFAULTFD=y
-- 
2.55.0

