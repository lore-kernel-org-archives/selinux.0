Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9D2EC0A2
	for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243787; cv=none; b=EKY3QGD/KILwXrJldPIseGqa6sicVqIhn90K+Ju5iirHWM4DGldRwR20K209F9A/B1ubOsWSuaxl9jHVioULQSdwLKNTND+P81wQL1nwlniS6F55hNjgwKxbdz9W9qFfW1clhNT+OoAQX4Hxr+h0Vw4NagdAAA/yU8mw29qUj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243787; c=relaxed/simple;
	bh=uiDJFuJBVltuANrR9vg9XY+jK1n0fUtc/XcfGcshQYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrEi1GO27iTNHxb9FolC+jfIRWzXqRgvjt85IHvua7PqVleQqg67MtqKaXXst34LwIowaZkdFBwpPFoaVHHw08/03EbCxfUETmgRDzEXXuTxn0FhnZqdOgNEft4hmreJnWnUcubVCYSULMo17Pail6X0BY7Iw7Eq2a+fv/9S+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6132PfS; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6132PfS"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso454397185a.0
        for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 10:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768243785; x=1768848585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTEFr32Kb9qcBoO29kL0sNFUN3F6hfFHR7ssfT1hFic=;
        b=G6132PfSs+RD2VIov3L+v1eNTDI093xyqTxzBtihb5NSMRmnZHt5C2QjH8Eh6Lu6tb
         3TgPakzYxmSDaudUPh1GN5dtj1wZtcxZmcSmI86D+ZsEgBWTmEQNrJ9P0wTRiFJLSKVr
         yp15/LKT2s67VHOThmDyXTNkJD8x7WefouWQY226CXtjf2W7ULZ4z3Zf8qHjT/fS5BtS
         es8HxthMIhuXeSN1M9QPAZ7H3cl/+Wa4hkbINzNw6c357ui6CY+o2n6ddvUTp6lIIwdU
         +7w72QEsG7kEVv2TQLwOifm80/6uvVUygnd/lSgM8p/sDocJXc6v6r1S9zawKBoNCjP2
         crNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768243785; x=1768848585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTEFr32Kb9qcBoO29kL0sNFUN3F6hfFHR7ssfT1hFic=;
        b=EoxhMr0kTzgKKgGQLF4OkUsoor5ziFwEs/FUd5mhe5CJ2Fyvd37RtN2oJMdspvrWze
         c7RAe7nXxKgUAYQaTlZcKjdrzMCNA0TOdhPX6jn+B4jQlOiOSGUCJ2KvexK0wSsIuK6H
         re5eFyXZcQs5k9xeVFlYQwCCeNn6vtOAWs13daJk5SOujx201vtDR1BxflPuGH7Kw6O9
         tnALkNbf04nliEd0El1wOg/xyaJ3TReLg1eSQF2/gBU3hxIobP0MemdLxM+laAMypK6E
         bfdN+BibiVu9s8M6lFjx49USEtl0cWYcrz8eACbK++fqNUOZFxvOm5BE4HOY4MD5hqOH
         vlVw==
X-Gm-Message-State: AOJu0Yw3TmtYHEa7mUepDPXFkK+hVVeP1+rcNYb4A0WA4aOaB2VlUZ1K
	J0F4/ZLTwetsQdlF5ZNmvYcyItDje/Po/asw8qKQx96SSBLdtJZUQqfou0RP7g==
X-Gm-Gg: AY/fxX7FBt+Fxsn4z5ZayDJkvHH86gIJnjlk4YJkzVsB72YCTB2yWTqpPLEoKwDpfXz
	Zn6/ojjb1Yx338gmSp9lM+FNWgGD9SThucPSFze2Z4LWbukkth/pY+ml/xDMLJ4VypJeCMnltuy
	xIyfha1LPdDH5ingB6YG9l9Q6BusWu8t/O9mJhTEu3RMSMC6QSUhxYEkFpQ0YMxZv6WrPZoKmaw
	Sbs9L5LhUWsA7+doApGiKy8sIWvttkrg8rfMgq2Q3xg97Ca+cHVRyjHdxwkJ9Fb+sYT9ySvKQCY
	b9OdxybbzDuMCjegLVJ3Li9nmHIe4Qn72YheUq60+CS/IjPm3VjBSMHgVfWkD9twdckTAkl8eXr
	8KkIdqG1tUtnY5ssg5RRYQN3+GptMOEG/qEBAaWhxbJyZ+7etGnTG4ieSO9cKrg3wwAihxheLkB
	FdVicdAGQpHhCtEN2W433xT4ZBkup6RA==
X-Google-Smtp-Source: AGHT+IGdb0fj3EMUfYqyCXeeRIFWbOzhBlmqt4/EITv+/aqBFTadDmnagMG+2xZOBR2vOxKpxc2vYw==
X-Received: by 2002:a05:620a:2942:b0:8b2:9b48:605b with SMTP id af79cd13be357-8c52083f73emr60785285a.6.1768243785034;
        Mon, 12 Jan 2026 10:49:45 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51bf8csm1546077785a.28.2026.01.12.10.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:49:44 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix possible use-after-free when expanding attributes
Date: Mon, 12 Jan 2026 13:49:28 -0500
Message-ID: <20260112184928.58593-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both expand_attributes_in_attributes() and
expand_role_attritbutes_in_attributes() have a potential use-after-
free bug. The function ebitmap_set_bit(), when used to clear a bit
will free an ebitmap node if no other bits are set on that node.
This can result in a use-after-free in
ebitmap_for_each_positive_bit() which keeps a pointer to the current
node.

Instead, use a temporary ebitmap and update the types or roles after
the loop is done. Also move the check for a loop earlier to avoid
uneccessary work.

Reported-by: oss-fuzz (issue 474561491)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 6e0c038e..ed912b57 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -245,19 +245,22 @@ static int expand_attributes_in_attributes(sepol_handle_t *handle, policydb_t *p
 				done = 0;
 				ebitmap_init(&types);
 				ebitmap_for_each_positive_bit(&td->types, nj, j) {
+					if (i == j) {
+						ERR(handle, "Found loop in type attributes involving: %s", p->p_type_val_to_name[i]);
+						ebitmap_destroy(&attrs);
+						ebitmap_destroy(&types);
+						return -1;
+					}
 					if (ebitmap_get_bit(&attrs, j)) {
 						ad = p->type_val_to_struct[j];
 						ebitmap_union(&types, &ad->types);
-						ebitmap_set_bit(&td->types, j, 0);
+					} else {
+						ebitmap_set_bit(&types, j, 1);
 					}
 				}
-				ebitmap_union(&td->types, &types);
+				ebitmap_destroy(&td->types);
+				ebitmap_cpy(&td->types, &types);
 				ebitmap_destroy(&types);
-				if (ebitmap_get_bit(&td->types, i)) {
-					ERR(handle, "Found loop in type attributes involving: %s", p->p_type_val_to_name[i]);
-					ebitmap_destroy(&attrs);
-					return -1;
-				}
 			}
 		}
 	}
@@ -925,9 +928,8 @@ static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb
 	ebitmap_init(&attrs);
 	for (i=0; i < p->p_roles.nprim; i++) {
 		rd = p->role_val_to_struct[i];
-		if (rd && rd->flavor == ROLE_ATTRIB) {
+		if (rd && rd->flavor == ROLE_ATTRIB)
 			ebitmap_set_bit(&attrs, i, 1);
-		}
 	}
 
 	while (!done && reps < p->p_roles.nprim) {
@@ -939,19 +941,22 @@ static int expand_role_attributes_in_attributes(sepol_handle_t *handle, policydb
 				done = 0;
 				ebitmap_init(&roles);
 				ebitmap_for_each_positive_bit(&rd->roles, nj, j) {
+					if (i == j) {
+						ERR(handle, "Found loop in role attributes involving: %s", p->p_role_val_to_name[i]);
+						ebitmap_destroy(&attrs);
+						ebitmap_destroy(&roles);
+						return -1;
+					}
 					if (ebitmap_get_bit(&attrs, j)) {
 						ad = p->role_val_to_struct[j];
 						ebitmap_union(&roles, &ad->roles);
-						ebitmap_set_bit(&rd->roles, j, 0);
+					} else {
+						ebitmap_set_bit(&roles, j, 1);
 					}
 				}
-				ebitmap_union(&rd->roles, &roles);
+				ebitmap_destroy(&rd->roles);
+				ebitmap_cpy(&rd->roles, &roles);
 				ebitmap_destroy(&roles);
-				if (ebitmap_get_bit(&rd->roles, i)) {
-					ERR(handle, "Found loop in role attributes involving: %s", p->p_role_val_to_name[i]);
-					ebitmap_destroy(&attrs);
-					return -1;
-				}
 			}
 		}
 	}
-- 
2.50.0

