Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809711EE7B7
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257590; cv=none; b=WsxIGGsjMzHuuPmuVBPs/LZWxNFxGNGp45T6AIBBjHNmI9MbX9m9b3+y6STWWv9CA1jseD2Kx/EohA4mWxI5MPhQQrGhf/PJ92dy7s5/iJiZO/IXBPa+Wc2YuJJ3XCL0Iax4nZGO3rftbwlGHGAZ8r9lrEzW6h0OwPVxW+URknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257590; c=relaxed/simple;
	bh=7oezcl/Bo2psRCMGInV4m9bfwL73Bk3ns/eyxKdQPQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4LoDcUgwj90GTXrbc4f6DSuGes6t/3H5QaOfruFfPujsJO3qfFryngwKdGRG0y2OvDP4xAO56hrJGCbPyqbbmVsQHfsG90f+IrSAvDLGTcvSTAAoQpVNDeXKb20ohkXJpH293rpHsTWbqODPf0QyVBAt0PlSh8wUJh4iRgozAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=oRQjdEdn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="oRQjdEdn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257576;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXQaCbOJELuQrxOB1Xnp7TwhfTVJar55uWLDJQf77iI=;
	b=oRQjdEdn5mLCSYU61d6Xrn4JoFQoFwHKQ1M17wY1q0zvz/iZXxuV/HaeOGknS3/ZYLBHL1
	grn6hVjWNR7EcRnC2D55K+0DOXffH9PqUOFwkJA3lDJ4P2ZS0dd7pdhamJwGMRIeqLvujx
	HckW57Q2YXR5P/JtlQ1O/qu8HtsYi86ru3iPshD/onGwaw1bCp9vyG4ewzZXwvMXeigRcg
	xO+AKjQBsssD8geSPvcXbKdyNLy/tPaCQ8Ig192khkaWAQ+Bc8TdDftxDtKWz+Y0n7Jm2N
	aLM6JF0snLEeZTstPfJnw6/ufLM7JLEQxGWA31VQj1NEtgopB/O+u8fZ3BhUjw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 17/17] tests: drop headers from Makefile dependencies
Date: Tue,  7 Jan 2025 14:46:05 +0100
Message-ID: <20250107134606.37260-17-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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
 tests/binder/Makefile    | 4 ++--
 tests/bpf/Makefile       | 2 +-
 tests/fdreceive/Makefile | 2 +-
 tests/keys/Makefile      | 2 --
 tests/tun_tap/Makefile   | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

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
 
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 1ae8ce9..6b26ff9 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -1,5 +1,5 @@
 TARGETS = bpf_test
-DEPS = bpf_common.c bpf_common.h
+DEPS = bpf_common.c
 LDLIBS += -lselinux -lbpf
 
 # export so that BPF_ENABLED entries get built correctly on local build
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
2.47.1

