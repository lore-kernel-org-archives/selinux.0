Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4958C433FE
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386507AbiAYNwh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbiAYNub (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 08:50:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F82C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 05:50:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u24so16842618eds.11
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OoR0IOos3xsC5CaIP24iBhcAphTFekl09VqzdqWU8Q=;
        b=jDpYJPc7IhCvjpTog2oMmpvqCkK1LBhCD5oitJkHz6nGGuaEQIPJb313VQzU8QzFcR
         THdIzTyWRCBokWJCzT9EmlRaAtTJvzgO5/EZeW9G4pUq8WZJ+5WvWsCzUrfK8yTazNkv
         Fcyeg1LbyiYWUxcROtrhSUlwpIWAdVpY7kZne+xEyAPHZDqx7fOo+I6UYqk/+UBWINvB
         pc+2z/kUGuz8L4JKR2wDSrCNGUUhwTSgW53b8PalHRDqi8vONN6/CMRMs2Z0657JM+z5
         8uAjruWsuUNrsgKZgpxxaU/Nq5yUmhLmn+b7/DuUrcIaLxj7rJzTKeW2TzXGLOESv1NO
         ilWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OoR0IOos3xsC5CaIP24iBhcAphTFekl09VqzdqWU8Q=;
        b=7sj3Rqk8GgPpXBsP4GTohaAWkm39Ml7B5pJYjnaAkvQsgFjBZdLknQad21QOnktGUP
         j920KNpDPjmR4B9sRZPrleF1JR4JC1h1E0sMXo8hUvtC15CcHbbQ2n/O25vdGrHKVwJx
         y72uGjm91H3DN5NVWxjKLh2OXhTbVGGpYYCDnpdBDdu6RxEWsW8xK7dKIq7wVhglYfTV
         L3UWRa2URLKj4Lx+Qj2xTsauJziv2CGEABkh3Yzv4Lgi878BnI2W0avK8w0S5GKDegqk
         Tu9AqsIaUL+8VFvyUu5cwmt+84m/6/XE/pDY48wSH/DsVWodw+UJ5AcFdtcvZAvlnw58
         R1RQ==
X-Gm-Message-State: AOAM533QNo9jjm3qkTNQSg5ayS5/2lu748Q29J5L1bd3P26vd0jdQjmk
        z+0HMzoPh35taIE2rdbYQFOXbC4H5aA=
X-Google-Smtp-Source: ABdhPJy0Lff6YrbJoKES+rqN3ZkK6Dh2pgMcXvIeekzoIlu+Gwm3YWI5zgbnEidyaXfTqHx6p2TVKg==
X-Received: by 2002:a17:907:3f11:: with SMTP id hq17mr15019413ejc.643.1643118628113;
        Tue, 25 Jan 2022 05:50:28 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id w18sm5557168edr.59.2022.01.25.05.50.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:50:27 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: invert only valid range of role bitmap
Date:   Tue, 25 Jan 2022 14:50:22 +0100
Message-Id: <20220125135022.25513-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The length of an ebitmap is the current highest allocated (not set) bit
and always a multiple of MAPTYPE (= 64). The role ebitmap should only
have valid role bits set, even after inverting. The length might be
smaller than the maximum number of defined roles leading to non defined
role bits set afterwards.
Only invert up to the number of roles defined instead the full ebitmap
length, similar to type_set_expand().

This also avoids timeouts on an invalid huge highbit set, since the
ebitmap has not been validated yet, on which inverting will take
excessive amount of memory and time, found by oss-fuzz (#43709).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This patch supersedes "libsepol: reject invalid roles before inverting"
https://patchwork.kernel.org/project/selinux/patch/20220117150200.24953-1-cgzones@googlemail.com/
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 898e6b87..df8683ef 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2481,7 +2481,7 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 
 	/* if role is to be complimented, invert the entire bitmap here */
 	if (x->flags & ROLE_COMP) {
-		for (i = 0; i < ebitmap_length(r); i++) {
+		for (i = 0; i < p->p_roles.nprim; i++) {
 			if (ebitmap_get_bit(r, i)) {
 				if (ebitmap_set_bit(r, i, 0))
 					return -1;
-- 
2.34.1

