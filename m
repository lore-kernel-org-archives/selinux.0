Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D67C433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A3960F14
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 17:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhIGSA0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239840AbhIGSA0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 14:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631037558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6etvgvsQuueZz79Q15OrEoj09jXhUgI7cQ+vzFeoAYc=;
        b=SEOfPo67T7u/j5BKyXcj5VjqSl7/U5PYdLUGt0O3lB8WwxrUBaa8J63xCSrg38/eZWt+Bm
        MUSq6bQlk1GCfzyVgScsAdkX/RSB5TdA2tO7wtj+9p+2GGvJccDMknXJy4rlWreOwIMc/v
        7k3syhv0VY6HV54oW9+IPFqdNz9zbso=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-hNPDvD5XPhur4ItLpcAc_A-1; Tue, 07 Sep 2021 13:59:17 -0400
X-MC-Unique: hNPDvD5XPhur4ItLpcAc_A-1
Received: by mail-ej1-f69.google.com with SMTP id cf17-20020a170906b2d100b005d42490f86bso4104380ejb.3
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 10:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6etvgvsQuueZz79Q15OrEoj09jXhUgI7cQ+vzFeoAYc=;
        b=fv5JRcQ7114kdq95KfCIaeQ9uBvmrpvXJLgERjp539skARR0FZRxKpvD2XlTHDaaYa
         Rorwm8uWBSOzDzfPGCrBd5IkvGA7+BTlpTq9mSSBO1cIke3nrLrDPm5qxg/ghjhWshfX
         /aJoxadMIhZWHz2wk28Dk3jS+w4dNDoB/fyr1T6+K1JtGJj8qSisB8xNWGOhwnifm+1R
         uHIKjjfs+BPAfSjhLgsFc00NbA7rkvj3zeWI81CxP0q3VXsFXCTZ0K64l9jjG5F0YnG2
         0AL8fFBmhAPzFmf82xS1JjTmT9oLA8He5FsNz68PHyQNBVRal2qIhz9K1Y/9gV2lczlX
         I3ZQ==
X-Gm-Message-State: AOAM531fjpEM44wzU5bRZcuNsSCWVm9P/XSi99LskUu7CCHgZ3WOCASa
        T+kHi5orRfFuQlHzMGsirGyL2rs+aEmD747g6a0NT4cXkamLaRNMMhSp7h2YSQ6oyMz0tNPNB4l
        jxUQzlW2kiTzSx4MZMHsLf+VHLxRZ3AAH1HozG4AkslDXRf4jTVFPgHmuEH0Sy8jzK65c9g==
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr757440eds.27.1631037556383;
        Tue, 07 Sep 2021 10:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXKpyL62l7Uzhvhp/kYVb10/9UVIGWTbUzTxlU35NjmOJevyAGpDuXYiGMb+9/wmLjHMOh/w==
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr757415eds.27.1631037556137;
        Tue, 07 Sep 2021 10:59:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id i6sm5714847ejd.57.2021.09.07.10.59.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:59:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests: exclude vsock_socket test where it wouldn't build
Date:   Tue,  7 Sep 2021 19:59:13 +0200
Message-Id: <20210907175913.222919-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The test requires the <linux/vm_sockets.h> header to be available and
contain th definition for VMADDR_CID_LOCAL, so wrap it under a check for
these preconditions.

Without this patch the testsuite wouldn't build on RHEL-7 and earlier.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index e59ddc0..725d208 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure vsock_socket
+	inet_socket overlay checkreqprot mqueue mac_admin atsecure
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
@@ -141,6 +141,10 @@ SUBDIRS += userfaultfd
 endif
 endif
 
+ifeq ($(shell grep -qs VMADDR_CID_LOCAL $(INCLUDEDIR)/linux/vm_sockets.h && echo true),true)
+SUBDIRS += vsock_socket
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
-- 
2.31.1

