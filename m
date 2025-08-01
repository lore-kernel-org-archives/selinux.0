Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49A21ABAD
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058792; cv=none; b=n9aqBAnaX++deyYr+zIfK9HBnxMKsQENmmHIlCJW9gy1FcIDfhPBoHb8WG8aizHjrfreKH4MG/0B6L8pfXfHvYr6o+ZfD2iiQ059RSrakGnUCRAWp0hQKIV0ov1NZsopC2WBrtiYeOZtEycXqKG/WqF314e39qKPkCOPkNKILwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058792; c=relaxed/simple;
	bh=rqG76n9ombPwhb0O1o9vUQ68mAx2NF3aMh3W5truSLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4Nq8og2tyUz0pNfRaCs6HJGmp3YPzRMiiYsegs5BvA4GcEMAz8BtjOnbffFjGmOqeg01ShqXeyDRDQk2qxTF97DvhA6IPQpUryMlxml25bAVzANiKpFMWSsw6CBWwLEWgPO0QegMC+Po4EuMM+1ouI0UpovEVodbkNKqlEpJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDtsIQPD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDtsIQPD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b79bddd604so1288459f8f.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754058789; x=1754663589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+/BogaydoqYYjfmBy4X2fz2xqxt28O5Ne0sp9KpCxw=;
        b=MDtsIQPDg6QEAbVfKl7WluMFOfy9D4CR4pezQl2dwf18V5d4mPnZ6ipbauDUxEUv+X
         dZlxLHFUTE0O5AYsZbGAix0CHHfqtHZbQA/D3qTMhpBR9VPhzsShxCouEW547kgLHhN7
         TkB5s0L9KljFikET+/OiQjK/1rSiz6d6HRA6QaI3HsZnh49tlfnGxUaHB/f01O8vTKjx
         rwfMsvYU8uwlvAMpNBkgAwH8LAzfrZdRoCxYg1i94HKfJmSQB8/LJ/Itc1mLuzBiWhdp
         CEkicxNLB+wpETXLn+rCOtE0FK/4/iJh4rbQ7B24lSArPdYJOqK3y+hNglVtQ/9rZtTb
         TWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754058789; x=1754663589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+/BogaydoqYYjfmBy4X2fz2xqxt28O5Ne0sp9KpCxw=;
        b=JBZrhTjPglRoNNYLynH7x1jk+371kudiLzF0WMNUvhDt5mZImG0s0c2AA/LDIcbSj6
         9Zq3BRJ2c6YzBBsJjmxZJAZ821xcCstfvscfDf0aiZYopHEmTzfWzgxlNiVcFQhTXJlN
         ual61vSENtP1SFgfbdBNhkcMJ+KukuuQXpvZZ9TWN7QmYp7rodQzkGYRgjc3IcWy00+t
         Q/53Z7V0gGVjb9tIYxAzKBP9MKlYZBTyvG+EvUIIVIv50f9oakH2mUucPhFDT5ThNWpW
         mSluQngPBEOISXWL8ID98NoDI9yYW7PqwJtwOZUgmWCxnhGl1dSkzfzU7Bt8LfrNOYjh
         oTnA==
X-Gm-Message-State: AOJu0YzPNZFMlk9JVmGHLjFU8GacOXyV0aQC8aBeikvfxFs/YYMR45BB
	1CKocBGNFk1xI0PdljWJBKJNpFnhUnBnU9dFIsyguwXv2wIwxVMnW2r0/BgynA==
X-Gm-Gg: ASbGncs7IUMfbREGM6nJ3nkzyZXpJz+oBdgvB+Z7aeOL7GBXwpHnvHcB0lpnYHtMPb4
	JqK+S/6mr12CBpN4Qty+0hkOc3aDrXZIS6oha/ukFAM9Eo/ZMFegLbuQJ8untuzCFxFHpPJmC6+
	yY7KytmRdlZRvJNF2njgYdPAtxAkVfFuxPrIhdQjGFu5GGyoL+RH+b2Psibth8yXAim1MaisZnY
	aao7M5kyRMtLG+RzSfeRL2zKKjFZW8epWFoPfHEbsU4/Pp32MHnDpYJ3+4tATrNjI/nGsaY8+cV
	8lfmUNUE0DGcPufSX/YrxnsmuwTS/NcVxP1VjM4n5qHlHKG/GoMx5cmQfpg/ooBjTbE1RT81CwK
	HbM/XMMsk2OPk
X-Google-Smtp-Source: AGHT+IHexzvaimq8lGzYIOLGclQ2x8jOAt3ElykE1gBfyUlhbIb2N3m/MRu0PYzbJH+dUA6Mi2TFmQ==
X-Received: by 2002:a05:6000:2511:b0:3b7:9c79:32a6 with SMTP id ffacd0b85a97d-3b79c793525mr4761749f8f.47.1754058789161;
        Fri, 01 Aug 2025 07:33:09 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b55b4b4bsm161275e9.1.2025.08.01.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:33:08 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libsemanage: refactor semanage_user_roles
Date: Fri,  1 Aug 2025 15:33:00 +0100
Message-ID: <20250801143300.1189741-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the levels of nesting by early returning on errors.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/seusers_local.c | 76 +++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index eb3f82bc..282d56fa 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -18,39 +18,53 @@ typedef struct semanage_seuser record_t;
 #include "string.h"
 #include <stdlib.h>
 
-static char *semanage_user_roles(semanage_handle_t * handle, const char *sename) {
+static char *semanage_user_roles(semanage_handle_t * handle, const char * sename) {
 	char *roles = NULL;
-	unsigned int num_roles;
-	size_t i;
-	size_t size = 0;
-	const char **roles_arr;
+	const char **roles_arr = NULL;
 	semanage_user_key_t *key = NULL;
-	semanage_user_t * user;
-	if (semanage_user_key_create(handle, sename, &key) >= 0) {
-		if (semanage_user_query(handle, key, &user) >= 0) {
-			if (semanage_user_get_roles(handle,
-						    user,
-						    &roles_arr,
-						    &num_roles) >= 0) {
-				for (i = 0; i<num_roles; i++) {
-					size += (strlen(roles_arr[i]) + 1);
-				}
-				if (num_roles == 0) {
-					roles = strdup("");
-				} else {
-					roles = malloc(size);
-					if (roles) {
-						strcpy(roles,roles_arr[0]);
-						for (i = 1; i<num_roles; i++) {
-							strcat(roles,",");
-							strcat(roles,roles_arr[i]);
-						}
-					}
-				}
-				free(roles_arr);
-			}
-			semanage_user_free(user);
-		}
+	semanage_user_t *user = NULL;
+
+	if (semanage_user_key_create(handle, sename, &key) < 0) {
+		goto cleanup;
+	}
+
+	if (semanage_user_query(handle, key, &user) < 0) {
+		goto cleanup;
+	}
+
+	unsigned int num_roles = 0;
+	if (semanage_user_get_roles(handle, user, &roles_arr, &num_roles) < 0) {
+		goto cleanup;
+	}
+
+	if (num_roles == 0) {
+		roles = strdup("");
+		goto cleanup;
+	}
+
+	size_t size = 0;
+	for (size_t i = 0; i < num_roles; i++) {
+		size += (strlen(roles_arr[i]) + 1);
+	}
+
+	roles = malloc(size);
+	if (!roles) {
+		goto cleanup;
+	}
+
+	strcpy(roles, roles_arr[0]);
+
+	for (size_t i = 1; i < num_roles; i++) {
+		strcat(roles, ",");
+		strcat(roles, roles_arr[i]);
+	}
+
+cleanup:
+	free(roles_arr);
+	if (user) {
+		semanage_user_free(user);
+	}
+	if (key) {
 		semanage_user_key_free(key);
 	}
 	return roles;
-- 
2.50.1

