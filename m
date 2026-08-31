Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E66446074
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185832; cv=none; b=MH+cEjQC4eLJTXUmJN8zS4a4i1sW7ZU3gwZBy7qdU6HV8wy4Q64UyicgLvYY06XQrHTZNV9aB80MZbPdNT4PqyUg+rJiWmW6YvFePkbf4hfJJwrc06vAdu+rAe5TlzU18SdfNaSWP5G/49FzUQz93SeiAjUbXk6aikXwJTfS5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185832; c=relaxed/simple;
	bh=vGtHAnoL4Ss3ta6V4gRN1Jt7a/iscm6fMyjgaFpHaIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtbXYl2LHiK5PXdW0yfHzZb8W0NsZAlkQ8hKDLiIRQisNob6jyLD53O5bKa2k9XnHB5VFx+e1s9kfKMNZUcLFwaQ3yrJd4uEWJ+zOkqQmkvmSx775eGLRuJTDQgYtaQcPUsQAebC7l44q906KsQ85nEyZq9uQj5q3tJBuJyZrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf4ftCRl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf4ftCRl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90e8535619bso15140656d6.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788185829; x=1788790629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=An/4YCXfxyeO0CsmDH+AgMFOd5Wvf5czWl14ac+IIV4=;
        b=Wf4ftCRlwcVpGP1fDYd2hHKNjNuNSEcmE8F9rGgCNCKmMUCeuAYvRAElXOI4AppXhc
         Ciwv8ynAFA8sJSxKWGQ+N/o+eptaJeaxiOxziKJeCwJooS81gj1uCwPT4rkwUU17Zyx3
         f4W5BBqFK+TJZas381NCF19ZaNwASfeb4HrZVXxTNBkr6VHduApe/ohmwJ+O/GIRwi5o
         0qalbGP1593p7cCJRPnmQRnELD7X+lC97MPkyErx8PWL9GmZaggV7MgudJ7HcBXc6+rQ
         hfZRIV6+4/Hj261nxMNBsRZz9fErNtR3aVaZ+tTsGGOKrdtLa4HUhiN4nOaeRK5uDqog
         ht8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788185829; x=1788790629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=An/4YCXfxyeO0CsmDH+AgMFOd5Wvf5czWl14ac+IIV4=;
        b=kDzspZMVeru/+ZVXbKQtQsPJRWP8djMvkrS4e9S+GSszJKjcckyYryUCab5L9gHZGw
         CStbU63AzxP0hr2jc/A2kLszo3EkQGMhCK805ZhK/YoTkQCVpna8evvpB2wWRBDhp6Ae
         G0iF+jrNk7v5yG0AFEEYGJLK0dW9z9vPC339tRLMkA1wcvjKzA0TCB0HVsz2JO2tqwqA
         LbHmBz0PfkibTk8w4+yOKuMFN1d0MxgMTac6AdEji7ARbzxkDZf6YbZAdO7Ck+sMrfkh
         19I/kPSAiJ18iGhMIWMmpYXgy8SX2YiYuLkU0B/UrkSJg/Rr+rpp22V0wNRc0WpDlGNu
         QxWg==
X-Gm-Message-State: AFuF++mujelDfePdbfc1XHZZBPquWxXqYUaFCv0wAoqTyFf6Y9aWiqse
	w4hvJ/PnrzaV8xsH61uxD6un+bTzF73y9PqJXpUHp+zd11QgVoQcfpCt94Sf0A==
X-Gm-Gg: AR+sD108mriKf5PXhMUY4BoZO4gqkEdYUqzzyu8XOCDg5Ktd0Cwm3ErYo1C0AoUj2rZ
	aURq4bqTPPzv4ha99oqzEUaDjblwtvZTLmghZ/smk+jSJ276JgootThxKN4ekUCoTMI08KPaobv
	jHL3+doZZDOkkyEbd5AjrBl3O2Ne4nsXYu3WQN57Vi3n8Z4LCFpSecUitMgCFfs/u8RDggoKDjh
	Y3TYyGwoBA/ISEKj8wktlljx0AEUL0P5w0P4imOKe2f+HTYgZ7nhkxy5GtwTb7NZjK55C11Xn79
	NRtWRYWC6ATm9YDn3qEIihVYcQeS06i6CVomnWhXMeLLAfTBdu4NCYDhX0C25KUmyxAnU1reAO/
	hDEG9H2hl5apOecSWhXec5HPv31hpkWp9az1+4iPdbNeVM1I4q/Kh7/PQedSBlOHNM35lnfqRi5
	NO7lrdrvJgraWTZb5kjILYNhdmqDJR4B25pdFe+PqU8cJGQ7dCtJuALzglDjmovC6kJYkIsIvom
	dRo3jXNGs9qJ4elKsCKzw==
X-Received: by 2002:ad4:576b:0:b0:90c:b5f9:7229 with SMTP id 6a1803df08f44-90e929a95fcmr18098496d6.28.1788185824056;
        Mon, 31 Aug 2026 07:17:04 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4512dcasm84835586d6.34.2026.08.31.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:17:03 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Tighten validation of scope index class_perm_map array
Date: Mon, 31 Aug 2026 10:16:49 -0400
Message-ID: <20260831141649.39561-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 94e9e7cf ("libsepol: Validate scope index class_perm_map array")
verified that for each class in the array either the permission bitmap
was empty or that it contained at least one valid permission. This was
based on the belief that older compilers would set bits higher than
than the highest valid permission bit when "*" or "~" was used. But
this is only true for AV and constraint rules and does not apply to
declarations or requires. This means that stricter validation can be
done.

Fail validation if any invalid (junk) permissions are set.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d27f88..1a32456f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1755,21 +1755,16 @@ static int validate_scope_index(sepol_handle_t *handle,
 		for (i = 0; i < scope_index->class_perms_len; i++) {
 			const ebitmap_t *map;
 			class_datum_t *class;
-			ebitmap_node_t *node;
-			unsigned int bit = 0;
 			if (validate_value(i + 1, &flavors[SYM_CLASSES]))
 				goto bad;
 			map = &scope_index->class_perms_map[i];
 			class = p->class_val_to_struct[i];
-			/* Either there are no perms */
+			/* Having no perms is allowed */
 			if (ebitmap_is_empty(map))
 				continue;
-			/* Or at least one valid perm */
-			ebitmap_for_each_positive_bit(map, node, bit) {
-				if (bit < class->permissions.nprim)
-					break;
-			}
-			if (bit >= class->permissions.nprim)
+			/* Having junk perms is not */
+			if (ebitmap_highest_set_bit(map) >=
+			    class->permissions.nprim)
 				goto bad;
 		}
 	} else {
-- 
2.55.0

