Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1004E7815
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611111; cv=none; b=JuSm7AqiKfAEiZpZ1phBRlcHQkMr+f/8fXDjnPjfrjTHjnbXIZCWECUjp8A9+9LaYrRtri1VIGZ/bxbOsEVHvSsQJvqzCQXXckmyqKxH6kizuSYhmpDAq5GULjH5tg925NdqGHKCcqTR0gIbkm71VfW/hMTkwHGoIYW7G/pKImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611111; c=relaxed/simple;
	bh=HgWANVqU054GTyIHeMedhkjYZ5zYe2M+CxdBx08DrtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGNWozDxYDwxH/O8sh798xfGrm1wH4JyevW90RNbwiQOojaZrXaMQ3Bqjvo0BEk70MfT2hBkEO92jeYBM8RjCvWYOENNfZ0pNOGc5MxBxVw1GFysdO9vGk7WrLKP5zmwrROVWlFCjunm+O/RQCJK0t76qe6d0ttnNi44+glgY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rpFp5DKA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rpFp5DKA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611100;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08bt7VQJTVt1aC5+4PGgiehcAC5ZyNNTs60gLlKYx6M=;
	b=rpFp5DKA7viIhtVQ5YwNYAjjvyzH4NWoGTnLkTLgw4iySTkh869/Kw2+InnNXA55brBfHQ
	3Et3rTMqPD1SWqJJCcQo3OPENIhFK6ow9rDvttoibxLYUBRwQtTdgfms0N69YIp4yqUeLe
	e6ay/bZ2wK3mekOU4LQc+WBMhhOYEQmhs5nAp5TNiyGcbXnEtRzotEQ+oiDb4s8X+82Q55
	XSzgxNT0PeNr7j1LmOLh7UkqCkWvlNgT9UR65oz/aEBGD2b9Lz6N3mTE/spL7i8pru+TQY
	XJ8DdmoUuIwSqIYWmwzRqF2HXm3YbKExq7ywlARYkxwTvJhJL2rW5zZqYY/7Ng==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 05/21] defconfig: update for current kernels
Date: Mon, 28 Sep 2026 17:57:36 +0200
Message-ID: <20260928155753.2259807-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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
v2: avoid trailing comments, move them to the prior line
---
 defconfig | 61 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/defconfig b/defconfig
index 3dcf710..6ce3dc0 100644
--- a/defconfig
+++ b/defconfig
@@ -11,27 +11,40 @@ CONFIG_SECURITY_SELINUX=y
 # Not strictly required for basic SELinux operation.
 CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_NETLABEL=y
+# required for IP_NF_SECURITY and XT_MATCH_MULTIPORT
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_NETFILTER_XTABLES_LEGACY=y
+CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP_NF_SECURITY=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_IP6_NF_IPTABLES_LEGACY=m
+CONFIG_IP6_NF_SECURITY=m
+# used by iptables with the nf_tables backend
+CONFIG_NFT_COMPAT=m
 CONFIG_INET_AH=m
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
 CONFIG_INET6_AH=m
-CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
+# used for testing, configured via ip xfrm
+CONFIG_XFRM_USER=m
+# used for testing, could be updated if desired
+CONFIG_CRYPTO_SHA1=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 CONFIG_NETFILTER_XT_TARGET_SECMARK=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
+# used for testing sctp
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
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
@@ -43,6 +56,8 @@ CONFIG_F2FS_FS_SECURITY=y
 CONFIG_IP_SCTP=m
 CONFIG_BT=m
 CONFIG_CRYPTO_USER_API=m
+# selects CRYPTO_USER_API
+CONFIG_CRYPTO_USER_API_HASH=m
 
 # Network protocol implementations.
 # These are enabled to run sctp ASCONF tests using a GRE tunnel
@@ -67,7 +82,6 @@ CONFIG_OVERLAY_FS=m
 # Android binder implementations.
 # These are enabled to test the binder controls in
 # tests/binder; they are not required for SELinux operation itself.
-CONFIG_ANDROID=y
 CONFIG_ANDROID_BINDER_DEVICES="binder"
 CONFIG_ANDROID_BINDER_IPC=y
 # This will configure the Dynamically Allocated Binder Devices added
@@ -83,7 +97,6 @@ CONFIG_BPF_SYSCALL=y
 # These are enabled to test the key controls in tests/keys; they are
 # not required for SELinux operation itself.
 CONFIG_KEYS=y
-CONFIG_KEYS_COMPAT=y
 CONFIG_KEY_DH_OPERATIONS=y
 
 # Test key management socket.
@@ -99,6 +112,9 @@ CONFIG_TUN=m
 CONFIG_HAVE_PERF_EVENTS=y
 CONFIG_PERF_EVENTS=y
 CONFIG_TRACEPOINTS=y
+CONFIG_FTRACE=y
+# provides the ftrace function event
+CONFIG_FUNCTION_TRACER=y
 
 # Test filesystem permissions.
 # This is not required for SELinux operation itself.
@@ -110,7 +126,6 @@ CONFIG_QFMT_V2=y
 # This is not required for SELinux operation itself.
 CONFIG_NFS_FS=m
 CONFIG_NFS_V4=m
-CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_NFS_V4_SECURITY_LABEL=y
 CONFIG_NFSD=m
@@ -141,5 +156,31 @@ CONFIG_DEBUG_FS=y
 
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
+# provides /proc/sys/kernel/ns_last_pid
+CONFIG_CHECKPOINT_RESTORE=y
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

