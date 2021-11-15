Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D275C433F5
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3543460FBF
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbhKOUhs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbhKOTUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 14:20:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F712C061220
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:16:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z187-20020a6233c4000000b0047c2090f1abso10343067pfz.23
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FwJDATwzjGtvu7NR7Shvf/aZ67V95VELoUfFC2/GuTA=;
        b=nmdQlF+e5rttD5iwDgkE1MUxn19ManaNMDrW+ry0SsYxN0le/eMgPM8c63170AFHnv
         fvElydaowIs56AAMPyRB+panPcsFZd5+JI8Jsh+CFMEM76+hjoLKwp1JXuXNHeGgUKtw
         sFmI70OePIveC3XtgJg8K0ZaxBWRTkSbBNJaOMjrs3iRm5HFAvyUHhkKc7LixppiBWZU
         4+hWLqpoSJ+iMvcDFfcz4X0hc8p5lO1Jrh5Z7invhv9lUjDRHU7sN3LfG/lHh2AgmB1A
         hyBN5FUIaTU8CPWkCQIvjAgJsHjJWpBM6Tnz9318HLZvO3CXoegifROsq2bShNPGNveA
         5svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FwJDATwzjGtvu7NR7Shvf/aZ67V95VELoUfFC2/GuTA=;
        b=0ryeGudBdDzt89Vy6Ab4PdNS0/ZFcxFtKvwYHUJGauc7Z0XSqCnJtc+oJBIsxrC4jW
         VdisR/WQ+SFyPZCsfbT5zlapkvqrDnC/Rdip6hg0zwBIgRG3o0+PooW/485kSJ7C/qUv
         7MQFy+SbER/L/CTCEvfNPqtB3h5HAHLhdc7qhT65fs6UF2jc7LEdelDoYAHW4by4bMkN
         gofs0uOZvoKrUCppwcZzDPPjPhXwVqi/NTFuJv/JLWLDY4ek5ekTSRzcJd7XrcJIbJ7v
         ZVGxXxYOIKKXSikMfJj4lGgYLiicHWscV56mHe5CoGoDwGsPPnjcICtL3d6DPxt+tq0n
         965w==
X-Gm-Message-State: AOAM530HShTZMOylKXpMT2d4O68svI13JzOMS1JHdBIN6PoIMkHQvkiB
        eGFeaQWtvV2vpCyXSb+LDKf0wL7vJDQ=
X-Google-Smtp-Source: ABdhPJy1pQPDXJRd+FI7EQeQ2PNWdyQ8KKfOWRM3xN7JeY3y1F6RP5Su6cd8vNrhVoUwwXOY7mJxYAQq2y8=
X-Received: from adelva.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b2b])
 (user=adelva job=sendgmr) by 2002:a17:902:8d8a:b0:143:bb4a:d1a with SMTP id
 v10-20020a1709028d8a00b00143bb4a0d1amr21891956plo.1.1637000217085; Mon, 15
 Nov 2021 10:16:57 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:16:55 +0000
Message-Id: <20211115181655.3608659-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
From:   Alistair Delva <adelva@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Booting to Android userspace on 5.14 or newer triggers the following
SELinux denial:

avc: denied { sys_nice } for comm="init" capability=23
     scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
     permissive=0

Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
better compatibility with older SEPolicy, check ADMIN before NICE.

Fixes: 9d3a39a5f1e4 ("block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE")
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # v5.14+
---
v2: added comment requested by Jens
 block/ioprio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 0e4ff245f2bf..313c14a70bbd 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,14 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
+			/*
+			 * Originally this only checked for CAP_SYS_ADMIN,
+			 * which was implicitly allowed for pid 0 by security
+			 * modules such as SELinux. Make sure we check
+			 * CAP_SYS_ADMIN first to avoid a denial/avc for
+			 * possibly missing CAP_SYS_NICE permission.
+			 */
+			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.34.0.rc1.387.gb447b232ab-goog

