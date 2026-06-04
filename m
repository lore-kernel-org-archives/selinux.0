Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA31397691
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577952; cv=none; b=RKfCsabUMggd4fRZjVPVIfd3jq9ghw3apQUBJKv68lf4HCipq/M2BQa7MIlXHaUZg45YFGqPll5omso89iG3OqJBtMuKf2Q5QBldl6GfGpa4pfwsjjNUMkwvAmA4fB3ISrWm6DdbPWcX9Q0CylGiOIBAUiznQkcX289eo+GuKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577952; c=relaxed/simple;
	bh=xE4ylCSri/PZlwSKKRSWGEmLADXWH1u4PCHfy+ShpsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr25oTmOchxBSU5I2+T5zBB0uPFpxicfgkKXU+1ZbyyASWXDxcdHpbStgfKCB/PNNm3577AZ03H3zuPv3jbMDgio5Ln2bFdLKKFmpFMPpMC6Nup0y0or0LYHhwWxNfl8s+IWoTOC/hd4XhuTCDAe2qd6p3II2Vm1iQIlm7p2z7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBwXpfdR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBwXpfdR"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51790c0a692so1565001cf.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577950; x=1781182750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YuGczBYT+ikKlF/zOOY0LMz12aAy2Ai/p1jUrzz46M=;
        b=jBwXpfdRDTpL0gh3vChoPUUdr/bIP22Ge4o+aTV8mnppS9m5Zp3dlNVgnkmmpw90nc
         vtfAEZEgbwxtaukfy/ZfvpiFtA0DzRH7i5UDkH9SJJSm0wF3vFEfLXXCJXGYL9n27mD2
         jSOn9vfpLP61y9XzaJ+lBstY8iF/p6zet+qtvZTnxqiYUJ8q2h0ld64CziH2bWD65lBW
         31Y8wzfQAshpW3RLEYHEkS/i3MpwxBvfYNjZegkE7CJft9acJzyCI9zJwyi8YTYevKmM
         16KZHdIhFP0eIRy//JKGwLVjDepL8YlRsWLT59hpQAW+I1n5HBfluGsEPbiIKdiRftXD
         +kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577950; x=1781182750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YuGczBYT+ikKlF/zOOY0LMz12aAy2Ai/p1jUrzz46M=;
        b=Hw0FJJVlXzxJ7pqEP5NXBLlwixGBOD1f265FGX2DLNPZM6A2p3F1dKfOVZCZ8Y3kvh
         8bsQXFLxVQFUURi/uPFqeAf+4s9wqZoiivJqXxFs1U7stgdWlpplDeaE0nRby9GKBswo
         JxA4EAeqfXQcHJncwqj8RAf7J9tbZmdk4K7EAidjhrdqZ8MoBRLTBeNuWf1Dk+puKYMx
         7u7MzaSi3vn22cYePqPs1aRkCHPKKfcOO0dqb1sxxo0bqvYHBU4QtRXsvb/SidgABqU1
         KAnZM6N8MF4eUqdwrgVqZb+skc7ZU02B++4mRE3rgi448o6xMGBxpUIGdCPPO1JowAfv
         RDMA==
X-Gm-Message-State: AOJu0Yz73pcUngMCwQgOpMOXS783adC7FOF1/Cwm18LnI7vuuU6WnVVk
	98S+Bb5Tea7f4vGnPs4YhBu9azRCYh5COIr6M1uWGUpYnJrlchpAG+ZAbKYFNg==
X-Gm-Gg: Acq92OEKktEbtFvG02idO9Tx9TmWMFnIu4Cy1FHhvt0Fuv4pK8ay7UMeXHVsoN7gflF
	17dtX4EHQUG4S2Z6U7B5ehAFn0fDi9g9o1Jrz7++dsIyyh+2gGmuO9eMgXLvlysyxtDs8tU8yqH
	IcBs9r2FB5OC6RwjpXpeA+7ZNBGsxCVB5Rz1wW+oUWb3u0Lt5Kpub0J1SjSolMHA70T6MGnsRWv
	vW5iTSVPMvriUsrEthqc7wlKvTbFVARjFSEV7uOyN3ouLlsN2F0DV2KQ0o7oTDRD+nioSep3+pn
	8YKPPfKpyf7TFUAowtrXhgJpfVEuSa0GWIaKrqv8ZW5F/dwZUgSTMTCThzYMK1g39ECHE9q91R7
	R6cvujiDGRXuSNK0+wl5j+tH3iJvJWoDbUt6poSUKURx3l3vobnC0m8HSeCM2lHtN+GkpHwOrIa
	7CEiMtooWSNZdS+92PdLQjI3fZsUQWpTxxDO7sA2TNwGMIn9XJdilXTTdR0/2ynZvBJBlsS04bW
	k3sgz9cyN5ALgh/dRDjLabeGYo+vcjEWqDDPQ==
X-Received: by 2002:a05:622a:1f86:b0:517:7ed5:b56a with SMTP id d75a77b69052e-5177ed5bb8fmr94167091cf.15.1780577949982;
        Thu, 04 Jun 2026 05:59:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm18426281cf.19.2026.06.04.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:59:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: fix OOB cleanup in semanage_direct_list()
Date: Thu,  4 Jun 2026 08:58:54 -0400
Message-ID: <20260604125854.255679-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the error path semanage_direct_list() indexes modinfo rather than
(*modinfo), thereby reading and writing the wrong pointers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 6426ab14..9572dbf0 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2006,12 +2006,11 @@ static int semanage_direct_list(semanage_handle_t *sh,
 
 cleanup:
 	if (retval < 0) {
-		for (i = 0; i < *num_modules; i++) {
-			semanage_module_info_destroy(sh, &(*modinfo[i]));
-			modinfo[i] = NULL;
-		}
+		for (i = 0; i < *num_modules; i++)
+			semanage_module_info_destroy(sh, &(*modinfo)[i]);
 		free(*modinfo);
 		*modinfo = NULL;
+		*num_modules = 0;
 	}
 
 	if (!sh->is_in_transaction) {
-- 
2.54.0

