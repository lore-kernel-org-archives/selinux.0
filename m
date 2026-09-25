Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69B3921DB
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356747; cv=none; b=DLQXGThBtCE28w7gH9GOqZm3nh2rQ+Meb18f2cW86Jbf5U0M6nOVAq454p9nBx9UfEtZZeCYJU454HkTrueKKrV1l95H0FoB4tReSCL1Ew51h0KrWI8BD9ifVI1kRTHqOQM6DyMfGsJKCE88pgtTRzsgjYzjtnWnWMEgq42muLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356747; c=relaxed/simple;
	bh=CFbZNvdiyGRs4fC4ImXW6SDoU5pxLqgidTxwzH2YPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVDPLsFlnpliChbIuAjUokFxIgC/7Ik3oX19uE9sNrRQLHzB8YuB8z4zo0QX9IIdOQffoUZVCK+KNcnvslinxV6tuvCzX1XyCyAQyGdIlIFibirs9K4XAzodWw6vkuHyBqteBfbxbPO27ndHwwOjYV5Zai2M9SV0u30g6H0lCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BxXa2h3M; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BxXa2h3M"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356715;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPwUHaBlRuHopWWilgHS/7QqOBPEXVZ59y0Ac+Ptf00=;
	b=BxXa2h3MnETzXb2TbgaaUsFYBOrEffMnwB9aZ3RYOiajS64X8Gf5hyuHRuknXxbOwTG4U1
	7dGiAhTrKogMsN+cP3brauO6b4AyuDsLgBjsoUdsIfRkHsrsoJEk0wYVQvL++V4+TTYwH8
	CkosIoDVb61/ECDY6//VVbP6kuhc8VAlvoCJvBOG7bgUpRLM1upz7OxHfd6zTJFOPvxVIp
	iksCFM/XU7tOiWIhJvxc/dniv8mC3fd/ZjCgl/GC/dMDTXrrN0h7Csm3qrEN/uTJU29xu+
	XFIx6pT5fKZ0W7uVdbOMiRDxfFQ0n5LGsqWWWKm3+fE5nwJQntBNqrszROMGjg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 21/21] tests: drop headers from Makefile dependencies
Date: Fri, 25 Sep 2026 19:17:53 +0200
Message-ID: <20260925171755.2029271-20-cgoettsche@seltendoof.de>
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

Clang does not support header files included in the compile command:

    clang -g -O2 -Werror -Wall -Wextra -Wno-error=unused-parameter -D_GNU_SOURCE -DHAVE_BPF -DHAVE_FS_WATCH_PERM -DHAVE_BPF    bpf_test.c bpf_common.c bpf_common.h  -lselinux -lbpf -o bpf_test
    clang: error: cannot specify -o when generating multiple output files

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/binder/Makefile        | 4 ++--
 tests/fdreceive/Makefile     | 2 +-
 tests/fs_filesystem/Makefile | 2 +-
 tests/keys/Makefile          | 2 --
 tests/sctp/Makefile          | 2 +-
 tests/tun_tap/Makefile       | 2 +-
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index b89d4db..5c3a589 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -3,7 +3,7 @@ INCLUDEDIR ?= /usr/include
 
 TARGETS = check_binder client manager service_provider
 LDLIBS += -lselinux -lrt
-DEPS = binder_common.c binder_common.h
+DEPS = binder_common.c
 
 ifeq ($(shell test -e $(INCLUDEDIR)/linux/android/binderfs.h && echo true),true)
 CFLAGS += -DHAVE_BINDERFS
@@ -11,7 +11,7 @@ TARGETS += check_binderfs
 endif
 
 ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
-	DEPS += ../bpf/bpf_common.c ../bpf/bpf_common.h
+	DEPS += ../bpf/bpf_common.c
 	LDLIBS += -lbpf
 endif
 
diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
index d9f8927..4b1fb8c 100644
--- a/tests/fdreceive/Makefile
+++ b/tests/fdreceive/Makefile
@@ -1,7 +1,7 @@
 TARGETS = client server
 
 ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
-	DEPS = ../bpf/bpf_common.c ../bpf/bpf_common.h
+	DEPS = ../bpf/bpf_common.c
 	LDLIBS += -lbpf
 endif
 
diff --git a/tests/fs_filesystem/Makefile b/tests/fs_filesystem/Makefile
index 9224860..3293a91 100644
--- a/tests/fs_filesystem/Makefile
+++ b/tests/fs_filesystem/Makefile
@@ -1,5 +1,5 @@
 TARGETS = fsmount fspick move_mount
-DEPS = fs_common.c fs_common.h
+DEPS = fs_common.c
 LDLIBS += -lselinux
 USE_FS = ../filesystem
 
diff --git a/tests/keys/Makefile b/tests/keys/Makefile
index d9f36ff..d3793db 100644
--- a/tests/keys/Makefile
+++ b/tests/keys/Makefile
@@ -1,8 +1,6 @@
 TARGETS = keyctl keyctl_relabel keyring_service request_keys
 LDLIBS += -lselinux -lkeyutils
 
-$(TARGETS): keys_common.h
-
 all: $(TARGETS)
 
 clean:
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index c77b919..62254c2 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -2,7 +2,7 @@ TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx \
 	sctp_asconf_params_client sctp_asconf_params_server \
 	sctp_peeloff_client sctp_peeloff_server
 
-DEPS = sctp_common.c sctp_common.h
+DEPS = sctp_common.c
 CFLAGS ?= -Wall
 
 LDLIBS += -lselinux -lsctp
diff --git a/tests/tun_tap/Makefile b/tests/tun_tap/Makefile
index 11f5b03..f4b69d5 100644
--- a/tests/tun_tap/Makefile
+++ b/tests/tun_tap/Makefile
@@ -1,5 +1,5 @@
 TARGETS = tun_tap tun_relabel
-DEPS = tun_common.c tun_common.h
+DEPS = tun_common.c
 LDLIBS += -lselinux
 
 all: $(TARGETS)
-- 
2.55.0

