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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F9C4724C
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDC221974
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwxYu8Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEHPm0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgEHPmY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D32C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g16so822315qtp.11
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCQhPOYk0XIuwAlcRegLvjccFa+OyAaLY54ehgKIGUI=;
        b=SwxYu8GgxS8wqG4H6dR9sD/XKuiGADdFv+HnQwTCBD9rNIuqF4rhvWkvntvS0xUH6C
         I+89jsGY457G3NhAKsSOkAhnGnSOtNQD1l9siPFRQV0VJutmEMMWFEw7VOejdCPT1kXO
         zUwv8lN2K7eCQ6tu6zrCq1bgWdH3IG33j22sBmRYqR+ACc6HGkzQ4jMzUIggSGcl/kzi
         gAzYtzu49rJKMLOE0u3A+smbFZUQrIMHQIn9q0TcxH5XlhAf7p9aXGZyLBTGqOl/Ql+e
         e0vYEfX9OWT73ZrrQOoWBCzpYM1OJuQKaeoBsa9+s4SvQJ/Z1afzSUiG2HLM9CTgxvjd
         7IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCQhPOYk0XIuwAlcRegLvjccFa+OyAaLY54ehgKIGUI=;
        b=qH7TWRoxxohErwXzbR7Ux+Nx4WemZtQwfPXqZHbjVHgASR4JgcNG5jSzSYk8cYXENp
         j6jtTzZYbhWAfsj0RGf8EHvfFVdl3iv8WjUfPMnFjQqH2GWwgRdJLUKeUlAMvk66hcPu
         NnbyASdSAUaBO96PfZGfBtfUCHeGXk/KOjWqueF2mlRSHc7uTBNVjX6k2eVH6P9DSvZJ
         wTy4OerV/ZLpeUYZL/kwXpKqYWV6l8riGJXXi5CCnRFv+wFrqGSH/j/Rf2+Wie+sdDhS
         dVFzULHvJT3ObNpkANVwAlqCV8n/2KuZfC45AXgzIMb/8+51BuBKpU7sfhHQuMJSBqHp
         8T6g==
X-Gm-Message-State: AGi0Pub2Q2uHZYdC+fjQgSpP9Ur+sADk47ml4VXpzvgQZmjmZ4pub9/r
        +CH52sqSOh8WelTgfRSAAPUQVcd6
X-Google-Smtp-Source: APiQypL/KXCLjSUQOwxCOOwa9qxU8b/vC6N/rOR+6aCk1mcqXyDc/J0vOmv/PoBNR8Goi+0mpcfbiw==
X-Received: by 2002:ac8:3f19:: with SMTP id c25mr3390206qtk.96.1588952542979;
        Fri, 08 May 2020 08:42:22 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:22 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 07/15] test_policy.if: use ptynode instead of unconfined_devpts_t
Date:   Fri,  8 May 2020 11:41:30 -0400
Message-Id: <20200508154138.24217-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

refpolicy does not define an unconfined_devpts_t type instead
assigning user_devpts_t to unconfined ptys. Switch to using ptynode
in the test policy to provide compatibility across both refpolicy and
Fedora.  ptynode is an attribute that includes all pty types.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_policy.if | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index cefc8fb..f0400f5 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -29,7 +29,7 @@
 interface(`unconfined_runs_test',`
 	gen_require(`
 		type unconfined_t;
-               type unconfined_devpts_t;
+               attribute ptynode;
 		role unconfined_r;
 	')
 
@@ -38,7 +38,7 @@ interface(`unconfined_runs_test',`
 	role unconfined_r types $1;
       # Report back from the test domain to the caller.
       allow $1 unconfined_t:fd use;
-      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
+      allow $1 ptynode:chr_file { read write ioctl getattr };
       allow $1 unconfined_t:fifo_file { read write ioctl getattr };
       allow $1 unconfined_t:process { sigchld };
 
-- 
2.23.1

