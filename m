Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D4C433E0
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A32078C
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdAp9hZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405874AbgE1SlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405873AbgE1SlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 14:41:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230CC08C5C6
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 11:41:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b6so4062193qkh.11
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/vg1Ka088Eej0L8T18EB9xo4usQTKbKCJ3uhx0/2js=;
        b=hdAp9hZTObveAiRlqsVI3/ZwyzwhMm8AKm4+9TDV0vIEya2q1Hp/4UxPbxScX7xUQC
         dh+0FdV6rpWWGOX03qd8qLuzh/DG0tXH9NpLXqgI3bd2hcMSwbi4w3IKY4JxIUgGy6Zz
         wqymdyjegD6F6lFiko87107nPGu/QzUK6x6z0ufpsLjwGuQU3UOB2u0FVaZu3AyWRl5B
         tSbCW6b0wy7R+FRn/LFY6mE6PxOQD7oK52/TEqz+wPufKt0ofE+h/fPqlrWBqgZkNr9F
         46DAUitXAO+bJNpBq35NtObVeGt4pp83ORB9n0BwspyAaJvnhKvRJZFiPH5e5HfnvUKW
         GEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/vg1Ka088Eej0L8T18EB9xo4usQTKbKCJ3uhx0/2js=;
        b=MO1Rm/0/dapOQJWU42EtII8urZ8a7SL7KiR7Mzd0THlJrcuRiJIq0kDaw2Ct2EcZj5
         pQOGEc/S+kjLZKNdXy+8AI1tYrcZY5PEoReIFNBz2NiT36aREe777ZMqp+993i2/nXhQ
         b0ktW4uFYSTIYq3pZSI0RPU9KgnLdgQM9aDlKrXm11S9VFBMw2dDh6psPN16nNFjsBsh
         chKkw2HWMC5OHR+7/TCj71+LuwayLIgu+6T3ibTE66szT16evEuu0gtMgeCNxzKqGi8a
         /8rq9DlJmewR1kmxOSE5PxpLp7B7rqSirnmPRb0ZygI2zdijAIn4GhNMEB4CMd7XDLgJ
         J3hA==
X-Gm-Message-State: AOAM530a2FftECKPFG4z95c2anZLs+5etOAmTnETOMB/Ii2dciMtsjQO
        MzUMPJtNJAi2SSoC84F4Fh1U/y//
X-Google-Smtp-Source: ABdhPJwzHQk2DJicA5/RBr4p9BO3gchC8Zzqk2/e8Gh+hfqm8RgDLqiFv2RWF0nOKhc8nc0kzEeH+w==
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr4260997qkg.347.1590691279937;
        Thu, 28 May 2020 11:41:19 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-97-86.bltmmd.east.verizon.net. [71.166.97.86])
        by smtp.gmail.com with ESMTPSA id k43sm6601834qtk.67.2020.05.28.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:41:19 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselpol: Sort portcon rules consistently
Date:   Thu, 28 May 2020 14:40:56 -0400
Message-Id: <20200528184056.105774-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The comparison function, portcon_data_cmp(), only made use of the
protocol to put tcp before udp, dccp, and sctp. Rules that have
the same port range, but with different protocols would be considered
equal unless one of the protocols was tcp. When generating a CIL or
conf source policy from a binary or using the "-S" option in
checkpolicy the non-tcp portcon rules with the same port range would
not be consistently sorted.

Changed portcon_data_cmp() to sort portcon rules like the CIL function
cil_post_portcon_compare().

Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 7b53c92f..a7453d3c 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -470,11 +470,9 @@ static int portcon_data_cmp(const void *a, const void *b)
 	rc = compare_ranges((*aa)->u.port.low_port, (*aa)->u.port.high_port,
 			    (*bb)->u.port.low_port, (*bb)->u.port.high_port);
 	if (rc == 0) {
-		if ((*aa)->u.port.protocol == (*bb)->u.port.protocol) {
-			rc = 0;
-		} else if ((*aa)->u.port.protocol == IPPROTO_TCP) {
+		if ((*aa)->u.port.protocol < (*bb)->u.port.protocol) {
 			rc = -1;
-		} else {
+		} else if ((*aa)->u.port.protocol > (*bb)->u.port.protocol) {
 			rc = 1;
 		}
 	}
-- 
2.25.4

