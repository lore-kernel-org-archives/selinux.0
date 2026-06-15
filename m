Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2C3F99F2
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540435; cv=none; b=ZKfaZBOvn/65d/sVLsbNbDyNOR7zy2Y1mXutQI3Ixn8VjpohGQ2Lm1NeNHgnCMPpjixZaWGF+QCmw8Y5aLegO9LJJZuk0rAfzCTc9TEs7AntAsGiGjd031V1kVJkm8phEt5QXMVkiLhvhvSX6Ur2qGDjUqXsDUJ2REbdPPWtlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540435; c=relaxed/simple;
	bh=exzSIfHOTxnAFWrsIxDasFLVx4hnRWk/CtqviYBjmPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYhtWOZwGJG488mPktaeOZVJHgwWeJDyG+ohF5pBLyPpRp85heygpRWl91JuTeUbnOY8RdHqKOEtVKRT2mCk9m1ZL1FVN8T5O1PvBvWhFSLzGOb42ocNtYiYAuP21jFFEsTOD7H7odbtBfMkm5K1VDm3lvC4bK5XvFEMPc+Zqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOjoXF9H; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOjoXF9H"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91587626ae1so408664285a.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540433; x=1782145233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXZiaUXlF/MrpT3R3p0/vToJ221HxeZKi1Oxqxg3sVE=;
        b=NOjoXF9HMFrUOnmIVTvwLlblxlXD8R5UQQ6KOA4oA8ABL6u76MKS5U2LhQ93oDNES/
         DT+V0B6qBjEVNE6ILjvlkGaszDfg6O5pvX7LKlxw0It1T5DYpOv+bWNhXY0jrI5qI2qE
         5Ize4TtOBnbtQflFvcMVSa0BUGJgUS2j1io+f3HLXVsQkBh3H058qlfOqZGOC6HQtez9
         tG47HoNHM8FuMWz63YAmVa/MwpLZs7x0kDU6Tp5TK4qQxjvHrADDEWvYo6TQ02/FrZ3m
         YLEOiuaR4G6E51Vrm5+YLsvChoVg+igz/lftY9uhRd9uJ/id/H/t057bhgZ0cEZHAjvI
         U7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540433; x=1782145233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXZiaUXlF/MrpT3R3p0/vToJ221HxeZKi1Oxqxg3sVE=;
        b=JfozbYVqP9Nq6AieKu7UM4jKsglYCpchiefc9kZjk0ovFU+GRQpbM8YsLTb/2BjIbW
         Jh42MntA3c56cyDW2hbrQ7N+aFAihUlyBqCwAqaVPrG5YjKB4aCLfJvsdSvhlw/qIauu
         t5kI3srYUTNEaRHMPfSZCCVXjvIJ4Z9qIq3B4SmnxKupaUbrGiSIlHWco/cQrXzzYSus
         C22KVnkj9/tz/YuXlf6PSPI+vz1VRsWdj7sA4I8qQ7+N+h+kTu8KLOhcR/3t9luC3xzH
         JU+LNhSw6I3PyVaN01R8VFBJyBwx36tFJ2zKxMusDkE+QKBwEgJ8JNmmJ5ItC761gIQ/
         aX0Q==
X-Gm-Message-State: AOJu0YxNNMfVVVxqUsVg2p7U6C7p8FKnNu74r5V30htxuUxwX7I1rRQE
	oJ08Jnr6p0CZyCNEgnhart2Ns4Ti2LmnWlobs+phwUfCYrVMGeYbLa6t/yRfwA==
X-Gm-Gg: Acq92OHBmKBrugcRh9TKKYkkgLi/utUEc7Wd4akfdRE2dpAG1coPslE800xA1zW9UOg
	o/QkF44I86b+62FXo/Kh2Oz6/Ck1zCUFiwEQ9FdL414GHMlSVkaZ9ISb3MQNWEFAa7SemHsHZTW
	6lnuqzqctxdwR9CyLpMu4doaGk+Uqt21ILwRZI+D3VxlMzyNrBgfp/xPMbsQGm3iHagsjQZf0fg
	BWNy5gfiS0kH3D7Nu6v8c8m7oHoDXNPqyvQKzrcHBXdpiFtc+2o5Ndn27HhAm6wFqXF5XhVUuO+
	nwrZJiqDbKCmQSLppccvhRM5JYcu4OLcjztX+NrT/RXPZGqgvhgxrHTdc0uOedusACjx8HbAX75
	pFrGFxaObgvuTBWo7dzLes8/jbCGeUViXtGLwdT5T68eHVGpY+AwVkutw9laPktgb+NHszDUszx
	+uxO4c9phFnuT2EMPE5wYzboZs+Azp69yLhpSkwh6lBRaUZaeQ91GSJ1jRFYQGRG9hovDCwHIHW
	iRPSoyd1DS7UdXT9yfZRA1dajc=
X-Received: by 2002:a05:622a:8d16:b0:517:7b6c:4459 with SMTP id d75a77b69052e-517fe56fd35mr205453031cf.24.1781540433033;
        Mon, 15 Jun 2026 09:20:33 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a3c4asm112484421cf.14.2026.06.15.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:20:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol: fix out-of-bounds typealias_lists access in module_to_cil
Date: Mon, 15 Jun 2026 12:20:18 -0400
Message-ID: <20260615162018.44076-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

typealias_list_create() sizes typealias_lists from max_decl_id, but
the loop only looks at block->branch_list (the first decl of each
block), so the decl ids of else branches in optional blocks are never
counted.

typealiases_gather_map() then indexes typealias_lists with
scope->decl_ids[len - 1]; for a type alias declared inside an
optional's else branch that id is one of the uncounted ones, so both
the read at typealias_lists[scope_id] and the list_init write run past
the end of the array. Walking the full branch_list when computing
max_decl_id sizes the array for every declaration id.

Reproduced by converting a base module that declares a typealias in an
optional else branch through sepol_module_package_to_cil(); placing
the array end on a guard page makes the access fault, and the fault is
gone after the change.

Fixes: https://github.com/SELinuxProject/selinux/pull/526
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/src/module_to_cil.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 9e61754f..f3dd8f1e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -377,9 +377,11 @@ static int typealias_list_create(struct policydb *pdb)
 	uint32_t rc = -1;
 
 	for (block = pdb->global; block != NULL; block = block->next) {
-		decl = block->branch_list;
-		if (decl != NULL && decl->decl_id > max_decl_id) {
-			max_decl_id = decl->decl_id;
+		for (decl = block->branch_list; decl != NULL;
+		     decl = decl->next) {
+			if (decl->decl_id > max_decl_id) {
+				max_decl_id = decl->decl_id;
+			}
 		}
 	}
 
-- 
2.54.0

