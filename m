Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64D289802
	for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062760; cv=none; b=dhUMNx7nc0vrdzP2MSzpjipljaRq5r8wvBbYbyOrTmzN7Ildff0tRe7fdJT6eKIJgRFDuTbzTdbCAVREzlR/SnSo2tg2ob+B7ADS/Injh5ahyCyRA/sF3ACIBdpIO37DXNsOvd8UwMr1PjAsTOVyWWnq9yDRAbtnVEWPZRKdhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062760; c=relaxed/simple;
	bh=zcAurlllLcyWxo8eSURssUTmlF7lyrlzBS8c81T7sqU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GWr+MPEOw+pvkQY79RkpNJZ4pDYNsvnSbwdZdrKQKv/QcqELDvD3geNtEoy/8u79XdIsoFZ7cEazG6N3BHZ4513sBa5UZfCObs3qheW5osjh/+zUQbmCM4kudK/igpQxffiDLbwpg4JWrGC4f3LtocEpmmnDDMnQp440kP7zNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Es6jS/vb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Es6jS/vb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-240b9c0bddcso59601085ad.2
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755062759; x=1755667559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvLzSJD8tzzRDEC0waJEIyC45UXreLdotdqJqS21pYk=;
        b=Es6jS/vb8m2mBktiSiNiHQcsoSr1S6PD/Ee8L6h+rgPCCnRoylMvCL5TBkU5PeLaWb
         pCMS1i/33LCcYEoatraAnuOjSqCwjjMsRBspMucgXraS/cttaIAHoEUYk1pjQMQxNNBp
         YaDaf7twla2X4hYZFP5LNIet0s9vFQbIrHrijBGbv9x06xGmVHEIKwnzSaEkftJwu1E5
         Gi7vA1N4wSnU3swytvP9AZveqGWqcsqo5isL8iYNmOlZUyKdBuuzhUN5FesESOhQGHrA
         QEvI46ZrwlZAG4krmvsPXzZUwPgRUYaqVIR6of2hJ49DSM+pCeQGjVEQxewx8YY1X3LR
         STrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755062759; x=1755667559;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvLzSJD8tzzRDEC0waJEIyC45UXreLdotdqJqS21pYk=;
        b=YdvzKTwbd+z6blGMHvSZm26aE/1yZeVeMaAeuWN1WU6v86phrUTo2C02jmeEBNsCEQ
         izkPTo1nbHRuYjJbxx7d+TCcP5uc94j5NbogZ6PylXktpPTk/3Z+dvW1/ZJVY1FOOsEr
         RiiWFCiAx0xWjdcXYDJIo7CXK9a/JYVDoLb6MM1jM31pBujkH09STtI43+Le4nq54f74
         sOKjuzB6CY1GPEUqcmJDteTT9RlWFjJ6en50Qc6MsA1vpqnYMrL0mklJJlYwhk1WM/iz
         0koOl1A12V/B5/rGZ5F1Ni26fgQpvP2t+ghvnz8t6UF1N/86XwDfhde89pCRXLPbBqE3
         Lkyg==
X-Gm-Message-State: AOJu0YzgJpLEUET3YhE+bvbS8uan0fO1WwCP5kTapEZ0oKmj82TeWTA7
	weLTxF1kyObqfz+IS5jDNIn0PU6f+3nB8aLwr8MCuVadiLP+8e0WmyQ9a6slPiuE1smrIjfnEm9
	eKIDifxmypSD/lQDI1trSvb1TvgiyrhJOZKcf/TqYW5azbev9lnzd0DgEcRu3CwXSmWfD9fTYLs
	wCx8t+P3W0Cd+cFlsa2lG9oozHg8qD6N+m92d6TA==
X-Google-Smtp-Source: AGHT+IG+aBx5MvhNix6jUb/pNwl6cmYYzPqUJUlso77xJCqQDkEIqmbl8aZDLkbyef+tR9SoFuwr5JMP+KI=
X-Received: from plgy7.prod.google.com ([2002:a17:903:22c7:b0:23f:ecf6:4649])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aac:b0:240:3e73:6df
 with SMTP id d9443c01a7336-2430d107ccdmr20696585ad.14.1755062758735; Tue, 12
 Aug 2025 22:25:58 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:25:52 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813052552.3636318-1-inseob@google.com>
Subject: [PATCH] libsepol: Fix erroneous genfscon asterisks
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

When genfs_seclabel_wildcard is on, extra asterisks are added to keep
semantics of genfscon entries. That needs to be removed when converting
the policy to CIL or conf, but genfscon_to_cil is missing it.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/src/module_to_cil.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b4439b27..8647d928 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2987,10 +2987,22 @@ static int genfscon_to_cil(struct policydb *pdb)
 	struct genfs *genfs;
 	struct ocontext *ocon;
 	uint32_t sclass;
+	char *name;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
+	size_t name_len;
 
 	for (genfs = pdb->genfs; genfs != NULL; genfs = genfs->next) {
 		for (ocon = genfs->head; ocon != NULL; ocon = ocon->next) {
 			sclass = ocon->v.sclass;
+			name = ocon->u.name;
+			name_len = strlen(name);
+			if (wildcard) {
+				if (name_len == 0 || name[name_len - 1] != '*') {
+					ERR(NULL, "genfscon path must end with '*' when genfs_seclabel_wildcard");
+					return -1;
+				}
+				--name_len;
+			}
 			if (sclass) {
 				const char *file_type;
 				const char *class_name = pdb->p_class_val_to_name[sclass-1];
@@ -3011,9 +3023,10 @@ static int genfscon_to_cil(struct policydb *pdb)
 				} else {
 					return -1;
 				}
-				cil_printf("(genfscon %s \"%s\" %s ", genfs->fstype, ocon->u.name, file_type);
+				cil_printf("(genfscon %s \"%.*s\" %s ", genfs->fstype, (int)name_len, name,
+				           file_type);
 			} else {
-				cil_printf("(genfscon %s \"%s\" ", genfs->fstype, ocon->u.name);
+				cil_printf("(genfscon %s \"%.*s\" ", genfs->fstype, (int)name_len, name);
 			}
 			context_to_cil(pdb, &ocon->context[0]);
 			cil_printf(")\n");
-- 
2.51.0.rc0.205.g4a044479a3-goog

