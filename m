Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DB4E80BD
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611118; cv=none; b=UHdV32yrhpbifFnxYChuCAejtGe6TguIR33bnMy8YsYCvjLW9XonhhQLf7CvLmV5maDcGuAx9rmnAgfMyI8OFVRhyzQwaYHqYOBLln+2dOUJx1xY9O5VSTGigHe6EvjJkQ0ljoYJGvYQnY+zVSYUerhWT9V3B6xtpNmRk0pjqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611118; c=relaxed/simple;
	bh=CFbZNvdiyGRs4fC4ImXW6SDoU5pxLqgidTxwzH2YPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cv2wdtc5tmXYbyH7RYXFmB5fwIydJg/U3GibbADijDbK3meGtJ44KS7LlceCUJXrcCajeie/rcnZXDRovV0G1cdVpQBIC+DGEqZsNTDOJn7clGr6AOnCZLMLpYWb7ZC0dNYv0PhfupK2HMJI0F3P9oOF9sKDr01a73Ikp6DeBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=d6xCDapk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="d6xCDapk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611105;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPwUHaBlRuHopWWilgHS/7QqOBPEXVZ59y0Ac+Ptf00=;
	b=d6xCDapk7nQcfanO/3RShbayagz9WZdn0j0V+NHH8sLxDpMY14ZHUR6ltWCZ+3t2OL0eAN
	IVG8Yjp0GykMMrtWPElPc4zR0mTZTAU8mAoOSPs/h+1LmANAuGTKjQLH4NnmyZIg5WYK7R
	L5il5+mXNYSs/G6lZwWMzE04mrPuQSenDaKZtLkkvFngEyUH5s9I/FKazc4iRrVNvS7NPp
	0RsLoRTLspCT+4pmkTPv0ZveMTTxFrVWmUW/RraQpR+CcPJ3FxbM8UKFMrPYTywKnX51Fc
	wUtnHzizwHCoqvyDaKxH9HNMtou7lKUapeo3GrgHxykgwJOmZZRAFqXuDmGXhg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 21/21] tests: drop headers from Makefile dependencies
Date: Mon, 28 Sep 2026 17:57:52 +0200
Message-ID: <20260928155753.2259807-20-cgoettsche@seltendoof.de>
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

