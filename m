Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B245C433EF
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiAKVzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiAKVzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:07 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA7C06175E
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:06 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kc16so825196qvb.3
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4jP2ewQcNQ4DhsgIwnpCS2JpHQRPnKkJFPN3R9sR9A=;
        b=h20HlJrkECD6ei1m8sKXvOSPDrCwmGghT2M+Uu+hlDgupWOp4uj6+OTe0IonOP4a3p
         z/4mB/1URXFQRpa8AhQa6rhkIefRFoXJfmjRIpzU+KQV0rqzYysGYqKPvTnf/aPWuc8C
         ZGmF1iy6GJYo1Roj9MDVNuNJe0P+2W9cOEYXr63mQxvV7FZCiPoBThbjEJoC/fbaga8Q
         zmGRApn7kHy8YGKA6KYEnIQAMjmjstViCZxXGdlEOzbffrx41OlgezSZEdK8HN6yANl4
         Wp0SNVGJkX5xvfLTBfb0AKOkBV+0a9TEbP9L/L66AT8Tqng1LUISb7dHZMzabHosFHT2
         1UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4jP2ewQcNQ4DhsgIwnpCS2JpHQRPnKkJFPN3R9sR9A=;
        b=aiHDZm0SJxXdCPD9WSm9qh3Vo8iR/wrjHuojsHdSW+RI6Dhf++mDkbNbMC6lsE4tKI
         aELGxoqyLIWn7+mS8jkJgmba47YFj+x2OrylZ23w93Bg7Xx/KnjVxMwpsOuBbLjlauOI
         moThOiX1Tyl+R3ptUTNV5MmcmgrJNQWcgiqU+8GDgywbv2gm31OtqRDcjlfWoQEs8gSf
         m7pZMZ9izn2wU3Z7JPoeHRSZb9Ezs+rWv//5Sos9fvHkfKxYuPztcgHaPRfOG3VuE5nu
         pWY9cTA2Jgwsm6sgdEyzDyj1MjTqerL7ziiXT5Wf8RuMSCy4iAXcbp6kdDr+gSzFzkwU
         LITQ==
X-Gm-Message-State: AOAM533M1V46zdLd5AN3WOKkjoOZkkYKI8uFXCrpwv7dPfs1zYBcC0ZS
        CkPjzhFYcQEQIJ3bepkVgqbtkZ9oksY=
X-Google-Smtp-Source: ABdhPJwsBuKzxOZc1I3A81jHdLHBYXYzz8RWLifDsB2ha6QbZ5geRu6PNyVVd4D9eD/n3AzGNzsAbQ==
X-Received: by 2002:a05:6214:27c6:: with SMTP id ge6mr5859509qvb.83.1641938105164;
        Tue, 11 Jan 2022 13:55:05 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:04 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 16/16 v2] libsepol: Fix two problems with neverallowxperm reporting
Date:   Tue, 11 Jan 2022 16:54:46 -0500
Message-Id: <20220111215446.595516-17-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Not all violations of neverallowxperm rules were being reported.
In check_assertion_extended_permissions_avtab(), a break was
performed after finding a match rather than just returning right
away. This means that if other src and tgt pairs were checked
afterward that did not match, then no match would be reported.

Example:
 allow attr attr:CLASS ioctl;
 allowxperm attr attr:CLASS ioctl 0x9401;
 allowxperm t1 self:CLASS ioctl 0x9421;
 neverallowxperm attr self:CLASS ioctl 0x9421;
Would result in no assertion violations being found.

Another problem was that the reporting function did not properly
recognize when there was a valid allowxperm rule and falsely
reported additional violations that did not exist. (There had
to be at least one legitimate violation.)

Using the same example as above (and assuming t1 and t2 both have
attribute attr), the following would be reported as:
  neverallowxperm on line 4 of policy.conf (or line 4 of policy.conf)
  violated by
  allowxperm t1 t1:CLASS ioctl { 0x9421 };

  neverallowxperm on line 4 of policy.conf (or line 4 of policy.conf)
  violated by
  allow t2 t2:CLASS4 { ioctl };

There is no violation for t2 because there is a valid allowxperm
rule for it.

With this patch, only the first error message (which is the correct
one) is printed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index b21c83ba..44c20362 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -149,6 +149,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	int rc;
+	int found_xperm = 0;
 	int errors = 0;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
@@ -165,7 +166,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
 						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
 					continue;
-
+				found_xperm = 1;
 				rc = check_extended_permissions(avrule->xperms, xperms);
 				/* failure on the extended permission check_extended_permissions */
 				if (rc) {
@@ -185,7 +186,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	}
 
 	/* failure on the regular permissions */
-	if (!errors) {
+	if (!found_xperm) {
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
 				"allow %s %s:%s {%s };",
 				avrule->source_line, avrule->source_filename, avrule->line,
@@ -343,7 +344,7 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 					continue;
 				rc = check_extended_permissions(neverallow_xperms, xperms);
 				if (rc)
-					break;
+					return rc;
 			}
 		}
 	}
-- 
2.31.1

