Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF1C43459
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B67F2083B
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxPHrXXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQRo3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGQRnQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 13:43:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D04C0619D5
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so7045930pgf.0
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gESCYHdeEc18WmSHoFiRlcOM8qkMy02/gtCzbZTAqQ=;
        b=WxPHrXXFANimi0wbvfcJ6Cfo6RILGM8zrzptr/i4wicbfpzxjVf9s2PSObmLwcn9aq
         SbUDJlkCbpwtWAmmR9A2NZpribK1YDkwqAQ5TTgN4F0z1JKluyrZrKxbZBHXSmRh0PPQ
         ei15QxSWG1ELter/xoH0l0moiUBAi1WUPtXtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gESCYHdeEc18WmSHoFiRlcOM8qkMy02/gtCzbZTAqQ=;
        b=iVLK+THcFM9kvmFdsqI3OY6kGCwOn3pHlMVn/LiGDrptm9oApBO7byFSIAzVz6dY6G
         YL4AYkS87xRJgK+iTYr2Vzl1GrwxexWa84gm0OVEi+zdKRJb8Ive0rI3G5wpMPS9QqJA
         /gU+aJUWH350Y/tKs+E3xZbskXY9fMD+zOMu7zmRKWnxS8WpdqCYdZDhdXWmY+q3zzpL
         wQ87ieLmBrLYjCvQFvUWaeIcn9MCtebElzpaMpOeWKBFUgpT4lDoxG5j0Y/mUG9guNvz
         adunkyOFR49oMJoJk4rbpdU20A3PfhCK2GP1HtDyyIXUbyF0kKfXpYXtdf6WDPzFT7YT
         QX0Q==
X-Gm-Message-State: AOAM5327M47VHsj6BuV++IMQ9gFC6VizP+U23s5ClL6foNBu6pnO1r7c
        dSRmEbfx2l0o8kfpFguWNi4ivQ==
X-Google-Smtp-Source: ABdhPJysbKI9KHmH4JZipg0ZRO74vc0Q1f/poXmDdT5wVjf46XMdV4SEDnNnhl9+P92e4T6IX1H7yg==
X-Received: by 2002:a63:338c:: with SMTP id z134mr9360703pgz.245.1595007796077;
        Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c139sm8072372pfb.65.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
Date:   Fri, 17 Jul 2020 10:42:58 -0700
Message-Id: <20200717174309.1164575-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
should not be distinguished separately from just "FIRMWARE", as this
confuses the LSMs about what is being loaded. Additionally, there was
no actual validation of the firmware contents happening.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/fallback_platform.c | 2 +-
 include/linux/fs.h                               | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 685edb7dd05a..6958ab1a8059 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	rc = security_kernel_load_data(LOADING_FIRMWARE);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95fc775ed937..f50a35d54a61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,11 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how*. */
+/* This is a list of *what* is being read, not *how* nor *where*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.25.1

