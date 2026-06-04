Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5F47CC83
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590483; cv=none; b=Z0LnvO4Ym7rpxOWZEcJH/NMX4sAq1e4nO5tVS0gJ39ekG5Dba9qHyHS5AivvsDbRin/kMw0ul9A5gWwb9X7PC/MsgVNVMRfx831UlU7faHJTwChX8XLx4ndqXcq68yql4zA49ULSGAC7AE9XmOfPHUJ6tmW8gJ9+cEGIkZXI41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590483; c=relaxed/simple;
	bh=ytxS7/LDBhO2aJvtSt3pE6w15jjk2CBzffEDxJptHeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxcOQlQZE+iZbkM+5dE+zswx5Z5l/Bc97uWpxCF5pB+Imjv+Eg1bKUwdLbcyRJpdSNIXtSl/u1u46bY+RidP+8P6MszqMLG/TJAOBCGeKkYk75T0S5SbQ+KuYxuzPLXE5Ozf9y9Y2ep3QckgMoFtGDVm3f5bxnLvZygM1El70fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDINz3+K; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDINz3+K"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157b895c57so91368885a.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590481; x=1781195281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJj/AivXNmwQ/ZE80I0j6NEkIcHXHxfFPFZiZ5j+mqA=;
        b=GDINz3+KXZu+pz850HDdvpyGYPyxCIGW1elPotvRws0YRReW5GNnXmqKcxwYwEg6kL
         wm2BbhrRA6tI0FCKo87DwhuckNMg7Sp5AUn3MLWn5PkdqtQiqLRgzgPsYJP+H6HoREE/
         sIyCxzjeB8a9EVN/QaW4XF6eMhUyEM4e8EBZ+mkxGfK1pfYbp/C08kvOiheGq7GbxAmp
         W/Y1qREb/H4qk39xlF8AYs12R+Fd2ombZi3dSopq6KmeF+XaB6xQwP59LuIdvThq4DwX
         lldoTH7i+AJiVw6M51KKZqst9hExlLPwCTJ2ZVINX/6U0ALQH9Ky2RvUj5ckuJWnYpF+
         xi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590481; x=1781195281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJj/AivXNmwQ/ZE80I0j6NEkIcHXHxfFPFZiZ5j+mqA=;
        b=Qa3jcbfz1vQJj1k6vK8/p3WVA6uT8x8pvGC/GqRweIw+RuDAaG5ujsHEyYTQNAeD3o
         umqMA0jneK2aOPBxIMLBba0LmxeOkRWJsDEPNKhRGpljjhqvgCYUip4LJ450Aw77vuqz
         gBmKDi7HurRK88yCYZ4G6zEEUYdtYMTsv8aSVJ5/oUn9Zv+isFTXHnjXlrLfDxeCnJqB
         s+1rG6f5UisvSZZVFmb5K5pOLOuga/jQYk2R3P3a8jsDvxnq8zQ2J545fgWNVsdiyoUa
         YvZebcYg5s5D2kciZ2rNyCeij/18LrMzA+oBv+XEg9rR8SMHE5W+pZpAhu6V+yI+FTKe
         3fMg==
X-Gm-Message-State: AOJu0YzqjAZrUCHHbRmlBiOxwOrHVH9OCuBl02vxfWKr3Nz34gtndW++
	owSa4Xx92D9SrN2R2lSYBa1ZpFAFOcvnZXSBuRtcYzcJ1J+mMuzWwfl53dikaA==
X-Gm-Gg: Acq92OEtWekjCgdAtQqkkR/t3TiXFhp/pc95DHqs21ShnbnzLm3Hjw0EOwjfqZnQlQy
	k/c+hI+HWcLfuvvJ0aV0uI8f80+7CyGCH8rK+REYJk4XRkaLxmYiblr2M8mv4W8dVMGTrVf9UrP
	KJvqWjAmzCCVCeVzJtNUm81aNzam0QhWqu+ZO5ZgjZmtz6mM9bkDtEwR1piWJtCFjc9my2twwxf
	wFpaOXOO7zQNASUuaUxRQuSHX4bCEukz+VTP4CFXdP8xgs1cSWTylJnk21jsjBX4+M6W6RVJuFX
	1p3Js0/i0xciB1j5IIusd9gA0SyW+2vwMK4bVrXYAufn+f5TiiGG0NrHYeq8U6CnacFGLgpW2rq
	munbOnD/pGDnbSVMyqNmXJqx6h1hBT2pIXknklpMyMaIyXPaQLQMtQ4no450lN5JSEGjg3rSbfg
	MdmZAf5NbhwyjK9l86wNAwvLSN0ti9KzD50UPinO6NpZ5IO3gTZudh6EcW
X-Received: by 2002:a05:620a:a109:b0:915:89d4:df0e with SMTP id af79cd13be357-9158a7aa7e2mr1123741385a.39.1780590480957;
        Thu, 04 Jun 2026 09:28:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381febsm607170585a.23.2026.06.04.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:28:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix type confusion when writing policy.conf from CIL
Date: Thu,  4 Jun 2026 12:27:48 -0400
Message-ID: <20260604162748.37719-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions __cil_cons_leaf_operand_len() and
__cil_cons_leaf_operand_to_string() use the list pointer instead of
the item pointer when writing out a list of names in a constraint
expression.

Fix both to use the item pointer when processing a list of names.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_policy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index b56fbc81..7f20b7b7 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -382,12 +382,11 @@ static size_t __cil_cons_leaf_operand_len(struct cil_db *db,
 	} else if (flavor == CIL_LIST) {
 		len = 1; /* "{" */
 		cil_list_for_each(i1, (struct cil_list *)operand->data) {
-			struct cil_tree_node *node = NODE(operand->data);
+			struct cil_tree_node *node = NODE(i1->data);
 			if (node->flavor == CIL_USERATTRIBUTE) {
-				len = __cil_userattribute_len(db,
-							      operand->data);
+				len = __cil_userattribute_len(db, node->data);
 			} else {
-				len += strlen(DATUM(operand->data)->fqn);
+				len += strlen(DATUM(node->data)->fqn);
 				len++; /* " " or "}" */
 			}
 		}
@@ -554,12 +553,12 @@ static char *__cil_cons_leaf_operand_to_string(struct cil_db *db,
 	} else if (flavor == CIL_LIST) {
 		*new++ = '{';
 		cil_list_for_each(i1, (struct cil_list *)operand->data) {
-			struct cil_tree_node *node = NODE(operand->data);
+			struct cil_tree_node *node = NODE(i1->data);
 			if (node->flavor == CIL_USERATTRIBUTE) {
 				new = __cil_userattribute_to_string(
-					db, operand->data, new);
+					db, node->data, new);
 			} else {
-				o_str = DATUM(operand->data)->fqn;
+				o_str = DATUM(node->data)->fqn;
 				o_len = strlen(o_str);
 				memcpy(new, o_str, o_len);
 				new += o_len;
-- 
2.54.0

