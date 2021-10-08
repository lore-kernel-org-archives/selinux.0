Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEDC433EF
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A16160F9E
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbhJHVMf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVMe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 17:12:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B10C061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 14:10:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m13so6202660qvk.1
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNWN4bh0vU2L/RKLTa1BdYrCKf3+K6EHZ5sn2PkLyn4=;
        b=gj28KluYa3GVUN/d9dcxWyYk6PvobvVZJhrgRXKNhpKiEgaak2vv9oeYVl5SdZGGAv
         pRm7A8IpI2D4aR4tQ7yxoRGGjKMnGvCV2SxmV6xWHHaDfyV8k/rHLY4OHykAYXRaB60+
         I2jU4UE8epqoA7/yhC0UowhBHiMwBqiJSkvpHhntcVEhJyVJVR0mnZMBBppmprcQLWu+
         7zZLLhK3bQKWM6/mhFPSinXlFsJWMx40nMY5Kg2jSRT9McQijLuGgYGPRNY8+8cYTtDc
         TVQTCyfF9qKbKWdvTA6PXc2m9fCAZ/T4/z111etYb3EENkdH4w07kl36PJu69NeA9Q4j
         8dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNWN4bh0vU2L/RKLTa1BdYrCKf3+K6EHZ5sn2PkLyn4=;
        b=tSHVKTRa2pL5DhvWivv18d708W7/SShp4kq+I19X2QumfpWcyqDKJKBBwTWrlGo/Nk
         b9vkg8mvF9iq1zZD3ZtgBApxF20R1HYVB12f4+gqZV72Pi5Uim5T0V+/Cu0Maj6tE3er
         xn7CN4ed5MMmM3td8lAVpmOjMV3voFF+TJKkVxpJ9zRJM3ywj97FcYo8OfRcOW0dxr5T
         q3TrRE74/sNw09j+wgarPmhgpuVGqopdGNZjAKwYCPD2rK+yn8hWOflEnPsrcqIBjN5j
         24pCvKzF8/wyKK3GPMIrPY+i6HaP7c1yKLx9ee1KMukYOjU2lRyz0nE/QpZAVy2Z0TG4
         V8RA==
X-Gm-Message-State: AOAM532JiCmZHynsAF4yRoinc2vWK5Kfmx+S9XimJ6vwg6XR9g1aqNHc
        57s00kcuwXOW5hM0tCYKg9m1HBR4cHk=
X-Google-Smtp-Source: ABdhPJwK9pG3lVneaOtzUBOKivjKIkuzcDzeHGnFNZ8UgHONgWxwC506DSXkGnvJFIkmxJB9Cd/bhA==
X-Received: by 2002:a0c:b30f:: with SMTP id s15mr12003011qve.23.1633727438127;
        Fri, 08 Oct 2021 14:10:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u9sm332453qta.90.2021.10.08.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:10:37 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4] checkpolicy: Fix potential undefined shifts
Date:   Fri,  8 Oct 2021 17:10:30 -0400
Message-Id: <20211008211031.393884-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008211031.393884-1-jwcart2@gmail.com>
References: <20211008211031.393884-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An expression of the form "1 << x" is undefined if x == 31 because
the "1" is an int and cannot be left shifted by 31.

Instead, use "UINT32_C(1) << x" which will be an unsigned int of
at least 32 bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/checkpolicy.c   | 2 +-
 checkpolicy/policy_define.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 6740c6d4..926ce72c 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -794,7 +794,7 @@ int main(int argc, char **argv)
 			case 0:
 				printf("\nallowed {");
 				for (i = 1; i <= sizeof(avd.allowed) * 8; i++) {
-					if (avd.allowed & (1 << (i - 1))) {
+					if (avd.allowed & (UINT32_C(1) << (i - 1))) {
 						v.val = i;
 						ret =
 						    hashtab_map(cladatum->
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index cda3337b..d3eb6111 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2126,7 +2126,7 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 			     policydbp->p_class_val_to_name[i]);
 			continue;
 		} else {
-			cur_perms->data |= 1U << (perdatum->s.value - 1);
+			cur_perms->data |= UINT32_C(1) << (perdatum->s.value - 1);
 		}
 	}
 
@@ -2142,7 +2142,7 @@ out:
 /* index of the u32 containing the permission */
 #define XPERM_IDX(x) ((x) >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define XPERM_SETBITS(x) ((1U << ((x) & 0x1f)) - 1)
+#define XPERM_SETBITS(x) ((UINT32_C(1) << ((x) & 0x1f)) - 1)
 /* low value for this u32 */
 #define XPERM_LOW(x) ((x) << 5)
 /* high value for this u32 */
@@ -2612,7 +2612,7 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 				}
 				continue;
 			} else {
-				cur_perms->data |= 1U << (perdatum->s.value - 1);
+				cur_perms->data |= UINT32_C(1) << (perdatum->s.value - 1);
 			}
 		      next:
 			cur_perms = cur_perms->next;
@@ -3615,7 +3615,7 @@ int define_constraint(constraint_expr_t * expr)
 					return -1;
 				}
 			}
-			node->permissions |= (1 << (perdatum->s.value - 1));
+			node->permissions |= (UINT32_C(1) << (perdatum->s.value - 1));
 		}
 		free(id);
 	}
-- 
2.31.1

