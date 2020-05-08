Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A6C54E4A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1361A24955
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaWUOJrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgEHPm1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgEHPmZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875EC061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di6so824616qvb.10
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gihP7LPL0o6QJD0dI9kI5bx1Ch9nWO3WbsL6195LayM=;
        b=RaWUOJrNpNQR2U5EcB+Mr81NKdBLMBgJixrHynQAAGEyZY1lKXFija8iucBDDCIupy
         YmmK9P8YNjU8Dz6ZfeWVLZS2G8v8uVUR2JJ3YHO1jGUuUMCupejDku+DeTjH7uA2mv4z
         UuNUpTM8cg87YW8OR4ZjQxs60stnYXMV8TJ9kSMSzziFXO1WlzCYfzHkDoap5ZLIBLZl
         dr4dQlb8GTdi5xNeoYsIe7HRNiOcy5idUz7gg1bjGmr0JIpMZQzB2e8KF9CUNGSAlpcD
         6+wApchaElLA4JVktUln+NtdxLCZNVnFfob/4TepkEnqoaB5KU8tFAj4etFvQMqMBPjg
         RiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gihP7LPL0o6QJD0dI9kI5bx1Ch9nWO3WbsL6195LayM=;
        b=f73QViXWcOYw1wJV/xIQNEDMKHvFrPShh6bG5RHySv6pIWBVV3yo/6CigKQ6/jPjbK
         dk5Dnv05mYPkB0hx1SJY/jfY6SlyD8OdY59nJHsXxCZ0MQUZBE2fxzPEqCT4uIKMBfhY
         Bk6L9ZpuxmdDWSWMlB4sQ3uGOAFpL63TmJslpnR8DIiORpfBLcuhsTTarBJ6t1R/EDlr
         6L0J6SfT3MKizoCxFKjqofILAD9G6NfN4s5gh8ogLLQGN/BlAS6y351RqIy/pj0zvc1I
         bh/Mezzyv/NQXWlF1qj6p3QFXGCkxl4jyHCa6jf/V2RbuT/iW4A+KqvLtTpJ0ap59OUv
         9NZQ==
X-Gm-Message-State: AGi0PuY5zcxeggqGEJSb8GvJ8M/QSJjIplzAilLoKbs3JnfbllzO3gUm
        Xudy1bDAkbSNYwju9JdLSMUTJHKU
X-Google-Smtp-Source: APiQypLL4qS0Foxihnxkav1PH9ZNoVqAp+Et6iVdCnlycMzGBhhyELlw5PjAguvPycbH5EgmqTuDxg==
X-Received: by 2002:ad4:5843:: with SMTP id de3mr3394829qvb.92.1588952544667;
        Fri, 08 May 2020 08:42:24 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:24 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 09/15] policy: Add MCS constraint on peer recv
Date:   Fri,  8 May 2020 11:41:32 -0400
Message-Id: <20200508154138.24217-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some of the inet_socket and sctp tests rely on a MCS constraint on
the peer recv permission that exists in Fedora policy but not
refpolicy and hence not Debian.  Add the constraint to the test policy
to provide consistent behavior.  On Fedora this is merely redundant.
The constraint is defined via a CIL module since constraints are not
supported in .te files for binary modules.  Introduce a SUPPORTS_CIL
variable in the Makefile and disable it automatically on older RHEL
releases that lack CIL support to avoid breaking policy load on them.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/Makefile              | 15 +++++++++++----
 policy/test_mlsconstrain.cil |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 policy/test_mlsconstrain.cil

diff --git a/policy/Makefile b/policy/Makefile
index dfe601b..8f43427 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -7,6 +7,7 @@ SELINUXFS ?= /sys/fs/selinux
 SEMODULE = $(SBINDIR)/semodule
 CHECKPOLICY = $(BINDIR)/checkpolicy
 CHECKMODULE = $(BINDIR)/checkmodule
+SUPPORTS_CIL ?= y
 
 DISTRO=$(shell ../tests/os_detect)
 
@@ -30,15 +31,21 @@ TARGETS = \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
 	test_ibpkey.te test_atsecure.te test_cgroupfs.te
 
+ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
+SUPPORTS_CIL = n
+endif
 
+ifeq ($(SUPPORTS_CIL),y)
+CIL_TARGETS = test_mlsconstrain.cil
 ifeq ($(shell [[ $(MAX_KERNEL_POLICY) -ge 32 && $(POL_VERS) -ge 32 ]] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
 ifeq ($(POL_TYPE), MLS)
-CIL_TARGETS = test_glblub.cil
+CIL_TARGETS += test_glblub.cil
 else ifeq ($(POL_TYPE), MCS)
-CIL_TARGETS = test_add_levels.cil test_glblub.cil
-endif
-endif # GLBLUB
+CIL_TARGETS += test_add_levels.cil test_glblub.cil
+endif # POL_TYPE
+endif # MAX_KERNEL_POLICY
+endif # SUPPORTS_CIL
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te test_nnp_nosuid.te
diff --git a/policy/test_mlsconstrain.cil b/policy/test_mlsconstrain.cil
new file mode 100644
index 0000000..1412f91
--- /dev/null
+++ b/policy/test_mlsconstrain.cil
@@ -0,0 +1,2 @@
+(mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1 mcs_constrained_type) (neq t2 mcs_constrained_type))))
+(mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1 mcs_constrained_type) (neq t2 mcs_constrained_type))))
-- 
2.23.1

