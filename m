Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A68C433ED
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246CE6135D
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 11:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhDFLKh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhDFLKg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Apr 2021 07:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617707428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c0lWZiwe3AIZOYHOavx+7ToNsqtt4uoDYbw5ACFhO7U=;
        b=YlBMLLAnrCc/mI7fcJxpcfhPjKtNBHFDmUzumu0mQqxVsqPtHUZRU5Wmv6kVJXtgDWWAKX
        ZKnh4TkPvzzYb9YkiEOEbVn0Y+E2jNqgXaXwjmCHOpC8TIeGflnof14S88t27ApwRAztKt
        j6S68lGS6HrPBF7BKA0VTyinNbR8ur8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-ndxN8sWLODa26sqL_Cvzag-1; Tue, 06 Apr 2021 07:10:27 -0400
X-MC-Unique: ndxN8sWLODa26sqL_Cvzag-1
Received: by mail-ed1-f72.google.com with SMTP id q12so10220929edv.9
        for <selinux@vger.kernel.org>; Tue, 06 Apr 2021 04:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0lWZiwe3AIZOYHOavx+7ToNsqtt4uoDYbw5ACFhO7U=;
        b=khWGd2Zdl+u8xNB/eKtGQk8100F4QpZ8ddvQ5eDoRjW6KtFK9NmwO83esHM3KAE+72
         3fehLXnddmYeMQC7uJnEM2CJuX8dpLPrtmitbNc3P0U+z2DUO7YYttwp87qyjbeMMExE
         FxRVRMOg3SyRUuJevQt+o2M1r+tOQmOXQs05d5SMBPX0M00kQuDxhyYjd63tYC64GVdp
         Ymt9go6JGImVfjADOcAcJVvm2Kq5psD78xCj6KZPgC+j3ZP9nRtwiz+0gIlu44DTKfQ6
         n7Ey3KetzLxKb+PE74GNBsBZuioipfb6GjCeTnqiB25yF+PIQKi2xrXmx+s0/+VTVgam
         DJ/A==
X-Gm-Message-State: AOAM5332fXG+KMBjEI2QfqlAzkI6u2SjuR4iygQxEm6kv9ClnNZh8TIZ
        4oJD/QvYXLc1tjA5GhZp87vhsVXmxw3EHCMiiHfV4PpRgBsplRD+veEe5jE03aMHapOJunyjK/i
        2HjVY/7iVEHmVxgkHhWnIyaDWyiqAb8z6bLZKJgM5AmuY88tVICcXenaKYTpF1h9mHqPVZA==
X-Received: by 2002:a17:906:8410:: with SMTP id n16mr4655574ejx.378.1617707425532;
        Tue, 06 Apr 2021 04:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPU15x+Moa8yWOlVzSFrMXjiaZdOk8DZYJN0hNHyMzisZbDQfTLHmrCajinIaPCYnDaSK1/Q==
X-Received: by 2002:a17:906:8410:: with SMTP id n16mr4655556ejx.378.1617707425339;
        Tue, 06 Apr 2021 04:10:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id p22sm3115581eju.85.2021.04.06.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:10:24 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH testsuite] Deactivate userfaultfd test policy if no xperm support
Date:   Tue,  6 Apr 2021 13:10:22 +0200
Message-Id: <20210406111022.2472280-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The userfaultfd test policy uses also extended permissions, so only
enable the test or its policy if these are supported. This makes the
testsuite runnable on certain old distros again.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile | 9 +++++++--
 tests/Makefile  | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index b092bb3..91364d5 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -29,14 +29,19 @@ TARGETS = \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
-	test_ibpkey.te test_atsecure.te test_cgroupfs.te test_userfaultfd.te
+	test_ibpkey.te test_atsecure.te test_cgroupfs.te
 
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 SUPPORTS_CIL = n
 endif
 
 ifeq ($(SUPPORTS_CIL),y)
-CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil test_userfaultfd.cil
+CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
+# userfaultfd test policy uses also xperms
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
+CIL_TARGETS += test_userfaultfd.cil
+TARGETS += test_userfaultfd.te
+endif
 ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
 ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
diff --git a/tests/Makefile b/tests/Makefile
index c19fcd7..7d4e39b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -135,9 +135,11 @@ SUBDIRS += watchkey
 endif
 endif
 
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
 ifeq ($(shell test -e $(INCLUDEDIR)/linux/userfaultfd.h && echo true),true)
 SUBDIRS += userfaultfd
 endif
+endif
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
-- 
2.30.2

