Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8B1B3929
	for <selinux@vger.kernel.org>; Mon,  4 Nov 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730306; cv=none; b=oAKRt93PF8Py090IIfpjiqJcNo8kVhxC4m/aSBby0hW4uRKEmnCX+6Jsk9pWSBg0PZQb4N/Baga/gugXZXj3a8jdHNmF1vOjvocF+8sv507nbMue+8g78JZsXEw4jcQvZXEUqkWslw4LFmAL6MLD7cPDfpLKY/izbF7ArWGMO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730306; c=relaxed/simple;
	bh=76hhXpdXHmBs5G/PXJviwhjZ2sbOlXh40F3/HV2UEp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjB+xs+nitLXoIa2RZskX10CI2C8lP6l7OtiFIAn+WtvE+khsLZTQIKrcltjyi2MeDryuqTgL4hYNjjOh2HPjD7zQ7F01EqO6AGFxoEv8YjkEENqll6TtcSF16eBdEEE1IO4V+1BIBUwEmVRLdeOG39ma6paJ6NAzQwI0U4atBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrKxOzE9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrKxOzE9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so34170456d6.2
        for <selinux@vger.kernel.org>; Mon, 04 Nov 2024 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730730303; x=1731335103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jd3GUXp1f2Qcu1vhJw8oqGKULheSxj5abFjp3yvnLu4=;
        b=NrKxOzE92PlvXNxuygHwIZtw9z5KxRnzaey+J6pZp0wMHbAbfOcgAvIyx8II9yjp/o
         y+SJUiliRfn7pk8reiNZGB1RNfllOPvFFT/uSe7B271ok/j4cQY9mrTiRlzarjAQBy6g
         oA4oq+M7woH4WWhJhnI7ZXOW6VQDIM6XqNIJpP53SdP3KSOj/iC7h9P6tXAxGqZg+l+5
         5ABXadsT9S1cIMSLHkD0fLZM0ZntYYG7Fl3RN/x0d3FXjnHpP7t5nvdlYbMceADxG/b0
         +cuIGIfgpoNP8yk4HWN99oB2g49V7ToI9HkCDVarK93NTXq7WJjQKlU1DAuf+35azCvk
         Rr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730730303; x=1731335103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jd3GUXp1f2Qcu1vhJw8oqGKULheSxj5abFjp3yvnLu4=;
        b=ZkXZR3qWwKDGOBGyU0+tuW2nVtW0u/UdHC1RU5dHqixCYaseVaWhQ4DEs4zS7LGZmh
         bFzAmeL2g7aAbQEdhvyoCBJiQW6CPzF/7GrCgfm82kmUZ6MpplCz9+6u6HkE47gwkpDE
         TgObacdNidtdgczRRri+Ok8dlaGEU+SeldFVpngUUiOUQOem6DRZWfEwcZGSjZAj+hbb
         QyNGJdvSfXIXxkn2OzrO0DXxv3tL4MimnbKJekWdGrO7RgX/osp7Sq7SZyRUj2CP/9Nw
         zNRMm9orPFpaT5oV3yvUENKsOUHms5jkf0AbIW8iT9cIIG5ZKsSByLMtoGE5w8hKR/S4
         zayA==
X-Gm-Message-State: AOJu0YxjySUJdxgT+z8X8TKy3py7WLOjQRxfglIX755tAlkWBcgHyOy3
	owXhE4pxkRsHLDd84rxk1oifLvmeGrZHsD+9YOxj0ktBZEFqoFJlf0W17g==
X-Google-Smtp-Source: AGHT+IEryZKcck8Vc8zixaHzn+DJvSDM6JfTl9gsUkMOoZR94lf/NFJ60D2ndvLHyAnVTZqd6INfxA==
X-Received: by 2002:a05:6214:5d0d:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6d35c0a41b6mr207308456d6.4.1730730303348;
        Mon, 04 Nov 2024 06:25:03 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a703sm48572386d6.85.2024.11.04.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:25:02 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgoettsche@seltendoof.de,
	pebenito@ieee.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Optionally allow duplicate role declarations
Date: Mon,  4 Nov 2024 09:24:58 -0500
Message-ID: <20241104142500.20055-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow duplicate role declarations (along with duplicate type and
type attribute declarations and context rules) if the multiple_decls
field in the CIL db has been set. This field can be set by a call to
cil_set_multiple_decls().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 19fbb04e..80e9c679 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -137,6 +137,7 @@ static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, en
 	switch (f_new) {
 	case CIL_TYPE:
 	case CIL_TYPEATTRIBUTE:
+	case CIL_ROLE:
 		if (db->multiple_decls) {
 			return CIL_TRUE;
 		}
@@ -1744,7 +1745,12 @@ int cil_gen_role(struct cil_db *db, struct cil_tree_node *parse_current, struct
 
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)role, (hashtab_key_t)key, CIL_SYM_ROLES, CIL_ROLE);
 	if (rc != SEPOL_OK) {
-		goto exit;
+		if (rc == SEPOL_EEXIST) {
+			cil_destroy_role(role);
+			role = NULL;
+		} else {
+			goto exit;
+		}
 	}
 
 	return SEPOL_OK;
-- 
2.47.0

