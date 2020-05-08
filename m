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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C332CC54E7E
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A258721841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikY03yPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHPmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgEHPm2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F04C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so1937974qke.13
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FX//iYGmVjDYI77WwacIatMpaEG+MdxVWLMXm8STdGM=;
        b=ikY03yPHcD6QoKR8kqQKWJRcnePOlQOlpkcI6mkDW7B1oYbppNeeZy97NjMFx/n2i8
         zDX6LrYaGhvODuj0CRgHICFvvD61dkBKPuah4T3tZmcRzgcaJTfmVhcDGCosCksiE0PJ
         czNxDWliN+WgVQnDHBJPJSPVVq34ArhaIrlVrzWiB+Dvht6E9ACUhYl/x2sRweuwvqmW
         HDKGj5dvJ2btdQSU3phE4NSb81VQECLjXGbrShsvj1DnXKdlrZ/VVtpXty34Mn25qlPk
         NPJl+BdJm6vVilA4NzBndQY0jZMz4NNi0KPLuPjMa3qItkf6jzoEWQNWqrwFHKdWdsbr
         AmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FX//iYGmVjDYI77WwacIatMpaEG+MdxVWLMXm8STdGM=;
        b=sJ5MzVXoKPN8k5I/4pTxUEMYqyxjZclWuosSaD1+6kS/1GYg2EVGYVZwOkzM4tawNm
         7upRm6VlfYA31fafH63Q0i8CrK40Q4VUixOPu7SLE9s/tE++Ve2cTIzW05hsyOISc6m8
         u6+8doLiSGrgwI2w2bs8Cuayd3AYV3UtVtcbqjrzvBS6nH8nM22/lBjNMEuZasIDJ+Gy
         31Od6MphyaMfHiG76PDLaMbQV/2eSPCf6ZrpMtng1YDb1+hBqzgvBRDmbvXuJR/jVnuf
         7hoLA6Eiw/rjqdNDU+0ou9Ro7utC44rdZq9KOe1sr2UyUQNmJXEy8xqewTMIqDNlOUsH
         9ZZQ==
X-Gm-Message-State: AGi0PubGWcnQ4HJVxW+eBPzoErXg6/gaq+2pIQysPn1HtaKoWf3vg+S/
        lDglHnhaF89w4KxwvafACca7XPt1
X-Google-Smtp-Source: APiQypLiTgvLQWj5AZv4sdPb1KpS5MJbU0uBDfjMektbEXsfhDn3DyvVomQjbUJhynfuOCBfoenyEQ==
X-Received: by 2002:a05:620a:490:: with SMTP id 16mr3292880qkr.203.1588952547230;
        Fri, 08 May 2020 08:42:27 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:26 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 12/15] policy/Makefile: conditionalize setting of allow_domain_fd_use
Date:   Fri,  8 May 2020 11:41:35 -0400
Message-Id: <20200508154138.24217-13-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

allow_domain_fd_use is Fedora-specific so conditionalize the setting
of it to avoid noise on Debian or other distributions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 17e9da3..386bbce 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -168,12 +168,16 @@ build: $(TARGETS)
 
 load: expand_check all
 	# General policy load
-	@-/usr/sbin/setsebool allow_domain_fd_use=0
+	@if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
+		/usr/sbin/setsebool allow_domain_fd_use=0; \
+	fi
 	$(SEMODULE) -i test_policy/test_policy.pp $(CIL_TARGETS)
 
 unload:
 	# General policy unload
-	@-/usr/sbin/setsebool allow_domain_fd_use=1
+	@if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
+		/usr/sbin/setsebool allow_domain_fd_use=1; \
+	fi
 	$(SEMODULE) -r test_policy $(subst .cil,,$(CIL_TARGETS))
 
 clean:
-- 
2.23.1

