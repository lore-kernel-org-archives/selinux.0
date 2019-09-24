Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B0C432C2
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 22:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11D720872
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 22:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tjrc9a4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405403AbfIXW6W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 18:58:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34312 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404431AbfIXW6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 18:58:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so3590207qke.1
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GOBwWk7OSdm0vP7yEMdVhMaSDU0DyXMO+s464CCNCy4=;
        b=tjrc9a4hquGakBaQHQNKIJx6dTE6KMdGDWk54sqo5mBGFJjnhINGd8nsPXixoJI5Qg
         Aq93gITbSBYliepXnXq06xFxCdN5FiO0e8tOnjBNtEcGeQONxDipJf05DagWpCEVS1M9
         TeSdboKi8CD3Q+HM3Y29DSsFV2ODjeNRhOzBL3uYtC5AnQ05MMKZZecKZL+hiTEf2eyk
         Zok416V+39jguo4qu2KgvMOyQgYjctH4KbLjgYgJPaEFWsPxiBlznVfwYV/96Uf02ZR3
         ce4I7yV/KduwzUFkDaxs7JK2FBe9x5BUuZBSssV7RGqoRvzAca4pgUBJyIsRcjdaj6ly
         QURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=GOBwWk7OSdm0vP7yEMdVhMaSDU0DyXMO+s464CCNCy4=;
        b=LrMfF+hnzty5h/0NbFo/Vfw9ehkzOiPfIe+WvDFlqZuyo5KxJlcyASsi9C1lVflrhR
         UV8yPTZ2swcKnFA1lDeeRqqFYjWYGpPvdkxXGJirF9RPNOKL+KHx4kDqUNbgGG8/ydYe
         N4p7jXY/2KI8RL+3GEHQZ8+/wTey7209I/0kVveAhEYNSdfV1xd9uuuN+llUNO2kgSFh
         nGiZMd9BmdTfPygXEw0BsNY7kOUIJ5UsnS5PNnWdOQ+C06Omyha1KXeGRpvU7MuyW+Vw
         mi9EpKxudxTpH85whYNwdGmYxHzTMmOo/vmtdBxN+95FhLebubxq7lHg+qrt/hR2zi69
         arcg==
X-Gm-Message-State: APjAAAWd6YqNcnT7QnnVbrv4AF63Qepee64pbV/cJYUgQOBsXdK7N/hX
        VrK6ma4ZzV5MWusBiHh9Dkhrdljwgw==
X-Google-Smtp-Source: APXvYqycPlcCnUu6cx7DALokztFrIzGcr7gaDuXXfSkssQVH3N5gly9cnDMZSN9/8GEzadbKY8URsw==
X-Received: by 2002:a37:743:: with SMTP id 64mr612144qkh.190.1569365900078;
        Tue, 24 Sep 2019 15:58:20 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id z12sm2123711qkg.97.2019.09.24.15.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 15:58:19 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     selinux@vger.kernel.org
Date:   Tue, 24 Sep 2019 18:58:18 -0400
Message-ID: <156936589827.661145.16998799838921887816.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

On a modern Rawhide system builds that include libbpf require libelf
as well to avoid the following linker errors:

 # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
    client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o client
 /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getshdr'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_rawdata'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getscn'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_begin'
 /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getrel'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_memory'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_end'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_strptr'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_nextscn'
 /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getehdr'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_version'
 /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getdata'
 /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getsym'

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/binder/Makefile    |    2 +-
 tests/bpf/Makefile       |    2 +-
 tests/fdreceive/Makefile |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index e78ad16..8f3cc28 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -12,7 +12,7 @@ endif
 
 ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
 	DEPS += ../bpf/bpf_common.c ../bpf/bpf_common.h
-	LDLIBS += -lbpf
+	LDLIBS += -lelf -lbpf
 endif
 
 all: $(TARGETS)
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 6fb230d..7b00b41 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -1,6 +1,6 @@
 TARGETS = bpf_test
 DEPS = bpf_common.c bpf_common.h
-LDLIBS += -lselinux -lbpf
+LDLIBS += -lselinux -lelf -lbpf
 
 # export so that BPF_ENABLED entries get built correctly on local build
 export CFLAGS += -DHAVE_BPF
diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
index 895f91c..cf57327 100644
--- a/tests/fdreceive/Makefile
+++ b/tests/fdreceive/Makefile
@@ -2,7 +2,7 @@ TARGETS = client server
 
 ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
 	DEPS = ../bpf/bpf_common.c ../bpf/bpf_common.h
-	LDLIBS += -lbpf
+	LDLIBS += -lelf -lbpf
 endif
 
 all: $(TARGETS)

