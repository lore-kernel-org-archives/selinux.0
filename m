Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AF392C42
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077420; cv=none; b=b8CBl/X24QLKdzMl1T+85794wCIQ0nATZ3XntmHCRYY7rRNNJaenqXj1DA8eEKT2eNSrvraTMraH+KNeKG/gy/WANEdv6QiCxIeoIX4XoqvwAzWzCK6jvgyrWAg6bqeeSGPJBYCpFUZ/94c+T++ZIZtIM9S35mEtXBHSYvepb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077420; c=relaxed/simple;
	bh=m7hVa6Kv8LrjI0yee13wL4T0X2Hp/2IePOfyJ9ZwTks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFYXsXmbY0GFMH9LdfS5CeiNGDnANtoPh+/Gw4O8E85XxmK9s1tP0xNeSPxP7QkDa788Tcl2+rdM4pB4HVuiCz2mQN3iOMfUe0DSQekwI5g9mO2pJPB8WlOI1OcxfGEHbQ/4+22ko7ugwP8+y6nlrjZY5agYAveFVy/ZN5DTwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocPHsf5r; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocPHsf5r"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516cc597842so45334521cf.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780077417; x=1780682217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrhBgQJ760UrSN0YUHA3DmQZMfYmC5Qnnv5DfAptiMo=;
        b=ocPHsf5reDMeLeKTKHB+7otTd6PWDKGABMiunhjdeWZyx0fPtH3smiVAo2gbu/WXap
         T7qWPeGeH7LTQKBTtRchy9qAZ8F+HCHIcMLLxQOclmbI+h9bJbzqFYfAu4KlywJpDi62
         yGhU8pMeqjZZ6xg7UzLujo4OElB/o/g7VarKQfoK93xcFDSfSZjNXm0McVOCqNf8FPX/
         Eq/9pYki1wlhp/VjOqLNl8iRmoZ0CinRJroSMEJbicI06Q0NyWCUjZbu7agNp37jBFoe
         UlY02SfxmuI+RqYpyuJ3I3A8lylwLUQ/z+x923G8cHkiymRxtDJFIdxPP1rRfYSQ0KPZ
         yleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077417; x=1780682217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrhBgQJ760UrSN0YUHA3DmQZMfYmC5Qnnv5DfAptiMo=;
        b=AT71bsBZ8HyKu9ORexzLgRMdw72N23HGXhfVRqoxwP+7deYYMmBnZqytNcWndcKJNr
         /gZpRB3L83WKLmm3kXjuzQD0HhFEy0p78hV7dLXtlYlLDCf1d4x/o1MOul8t9Qa+R/XA
         h/h0bimkaEIpPioxnsxKrVP0ji7VIMiV2Q3f6YiSosN8lvu/L5IR09U5Tz4FmsuTx7uh
         gVx9Du7NaxKzKKnO6J4+sVlTJCsSiFcSjuu5H7U6PIRGL1x5I4o0YwndYXvxWPhpSZbW
         d1KX/TX9ATywXQSp+IV4wcItSsCqoSaWz2bpJtIrZSGTrwfc4ioU0ncGZ32pl2vxNvhL
         01dw==
X-Gm-Message-State: AOJu0YxqE2EtbnFhQZkzxW9BLxE7kJSEc2ZoKdmJYnbssmxy1MLqXXyD
	0aQisI8vAZjm1ukwmpbAvvm4lnsUyA6h5tnivVM9oqxheEgpscUO5JYZzTN7fw==
X-Gm-Gg: Acq92OGxA0qKr04R7y7pdw8dgCqG0QuWe1P0NiFBxwqIKfUnId7wCH2yXgFpY4dcU3h
	aY9TylRf5V46qBI72aXqrmUHj5GaSdb6twOD34ygxJ8L9WabpV7og5347QEBockfxdRYiyM+YKM
	6mwhCbPmgpzKXzwo0fplPKnfIBpRhJF+XIw89IZ6HpJQbIr57nLZJrrSl1JcIJcL++Gkklz/1o0
	7bCVblC0HxXB7OGuV27NkakQfJVlnDNG8/UIAcC8d7BF9u7tZque2pQZiLoA0yil2sPk86C90Hn
	3RJG/UpYjgRDHPDnzUrYuy3xQDj09YWBT5mC6nuEHZVkvBgU8vlgHVVjTI2DCAIrqT3r4l69HU0
	cIv5RnhZlDr4qUzSp3IFXA9etm6MwKD2hUMyUACMMWBDpDiYrQ+5QvxG7jaVcQeR0/SWxJzpQAO
	BjM1lCdxNa0nfASUM5ac1XS8e/NPcXHrUnII7NE1gYY7jVrCc3gzzi0TzhyN1UDTJWbTaiaZcyc
	gksNlMAS0jLRrjWZiZ182v9MJ9t7uVYQ0viFw==
X-Received: by 2002:a05:620a:8088:b0:914:ca7f:6a02 with SMTP id af79cd13be357-9153db742d0mr116072785a.58.1780077416648;
        Fri, 29 May 2026 10:56:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532626961sm278838885a.32.2026.05.29.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:56:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: check and handle NULL returns from create_*()
Date: Fri, 29 May 2026 13:56:40 -0400
Message-ID: <20260529175640.151814-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several instances where the return value of create_*()
wasn't being checked.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index ff33621c..733eed18 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -803,6 +803,8 @@ process_trans(char *buffer) {
 
 	if (!strcmp(raw, "Domain")) {
 		domain = create_domain(tok);
+		if (!domain)
+			return -1;
 		group = NULL;
 		return 0;
 	}
@@ -1479,6 +1481,8 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 
 				if (! *t) {
 					word_group_t *wg = create_group(&groups, g->name);
+					if (!wg)
+						goto err;
 					if (g->prefixes)
 						if (append(&wg->prefixes, g->prefixes->text) < 0)
 							goto err;
@@ -1551,7 +1555,8 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 					for (t = &groups; *t; t = &(*t)->next)
 						if (!strcmp(currentGroup->name, (*t)->name))
 							break;
-					create_word(&(*t)->words, currentWord->text);
+					if (!create_word(&(*t)->words, currentWord->text))
+						goto err;
 					change++;
 				}
 			}
-- 
2.54.0

