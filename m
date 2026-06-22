Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E51E834B
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132059; cv=none; b=pqRreqOTBFiqkO5vQcUdO16WPT3UCLyihTBv7BVqPu7VaExCl9n4JmqQXKq7wzl+ARhzqWXCIGN5degEiNbgSFyPPUsMG43rbmgwxRgklJsejf0j4BrrxHQcpgGmvh3420QFPxzPDx6tw/0IrmJ9vmKk9oOmfpAZG2sRk9Axt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132059; c=relaxed/simple;
	bh=G6btSSCdy0xu6ZK+ow66I+yFPCQ9WokxEY6av2wp9Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfAfQ4LItBSfjl+NhEV+Ptlj/cayV4BeQbKrMGlh6S+M6MAqzOAOCXL2tJI4iYX28t2Wmst99gE9uoc0bWX2K7J1bltHNa6Za0ExjphsAmmFSBZ0dU0PMEgW3CUavVS+NdrOzjXuohxXW1wur+qAafveuVLKe2NdZ3SG27G+K4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcarPp/6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcarPp/6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91591f19c30so639852485a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132057; x=1782736857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=az0wt065G7+KSg2c7fHMvKniuI5HjpRpf0LNQhfPleQ=;
        b=mcarPp/6wIF1Ua632chJ6j2LhN8rO1wSBmu79h43aX8S9GpsSCVkJwoAEplYE7l1xA
         D6k3GYRywkgNoTvcQ0qwpGWPQDIM1tKpDokWUBMkLBBYF3AIN6bTfZbCtGu+93IEmhuu
         m7Bc5Nj+hQY4meEk6+KVoULfgrKTQ+GSiALI+IxK/aUaDcZPVVfG1Y1OKZOuzI8TsZRd
         TG1jXkeFQTwxmTxOMJiMbVH9dmGe1aSWAGLdGvA8wlwpqf1QITXk7qOUQjjTKN/A525w
         NET4FO8GZBJdEJmoWuYBtekxWDdIlIc8/sHYmCxIEIvllwUBbn/Z7OmVQ862yHzvUjvO
         Kztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132057; x=1782736857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az0wt065G7+KSg2c7fHMvKniuI5HjpRpf0LNQhfPleQ=;
        b=gjIjCY3/qrRIe344Qsoa+OwWPRUyr6d35zEa0q6/4A2dnKsDx8Z6c3dsN+sNGXWs07
         WPRplcpGRq6NuwvGVhmjp+aQ5M/uV5pPM647cPrIrwp3MvlHzYvkCtHoyLOqb45GfYeH
         woZXK3Lc3N0K5JQtbInG8LIh3Hb0ml9z60zKuqDkdANdpewRD4ArIiwmoPWxEpfXbkzK
         99JzWKV+Hnif5dU0BFe71aUumNA4nt0dC3L9XL9ZlbOecFGhmMmLuf5x54wwy8rTcdfJ
         s1H6uJWVGT2w7YgPTE4FZeDBDAGkQ4tVedz1Qkgt7DiDFrNKEbL/o+Xim0J6GUjoHaQJ
         MlBg==
X-Gm-Message-State: AOJu0YwIOjv0VpRXyI1lMBtvKFkkgwbvyfLGrCaZeI3D5tPP2TWsZgRK
	kLd42tFi89P089UMtuUP+D5Jc+Wq31etodTCEv4x64YbyTGHTwi/xeDE0MVbwQ==
X-Gm-Gg: AfdE7ckZRGgvUY8SNLz2pTq6mq59migMp57CQnBJQJqa645wYbR3CAnPt7tbu8JCEcr
	qgaGv/jS56R7fpOQgSdL60Qp+d2Ml+wYV3wII4aZUC4IlxglVp+lck1KHTVwI81gNOJn0llnmq8
	cUYmfmtrW/318G5KP5v3VhqzNUHOh5ssBN+VdLpDI2VaIIFmoMAUzO1wYu80hteabEXQnN1xAZ2
	4HNSUHl2CUdtFVRpuGjCs8R6DadwhJoIBeXoU5063ATUoOL16CshAqNqJcjko0Ip4LAyoyXWFW9
	Detlj9Wfqrm+iCxtnx41qZneZZ0HdWLRtnSXSaU7Ps4OxLoYz8W9t3Z/BTjKQIDe5pohJ2OOVMQ
	MeeFW/SRh5nHxwPSB4bHx3j4iPNqknksiVg9lwtjpuY9n1EJCVxhL/QANlI4PUiZmUiFlVMIPG8
	/xoYroDI1sPRXDiZyti25FXhQXUhcGVNQvVICXbjgYBrZ4bJ8fNjfbtBShvs/efymaUGdKlNB1F
	xNfXyPATz3PWUtYhh7LkPN8ctA=
X-Received: by 2002:a05:620a:408c:b0:915:9ffb:1f67 with SMTP id af79cd13be357-92091490334mr2184406285a.30.1782132056757;
        Mon, 22 Jun 2026 05:40:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d79652d1sm887217885a.1.2026.06.22.05.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:40:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] checkpolicy: fix xperm complement at range boundaries
Date: Mon, 22 Jun 2026 08:40:42 -0400
Message-ID: <20260622124042.31385-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

1. avrule_omit_xperms() builds the complement of an omitted ("~")
   extended permission range set and advanced the next allowed range
   start with r->range.high + 1 kept in a uint16_t.
2. when an omitted range ended at 0xffff the increment wrapped to 0, so
   a spurious [0,0xffff] range was appended and the omitted value was
   granted; an omit range starting at 0 with no successor left the
   trailing range high unset, producing a malformed low > high range.
3. reworked it to walk the sorted, merged ranges with a uint32_t cursor
   and emit each gap, so the 0 and 0xffff boundaries are handled.

Added a roundtrip regression in tests/policy_allonce.conf covering
~0xffff and ~0x0.

Fixes: https://github.com/SELinuxProject/selinux/pull/530
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 checkpolicy/policy_define.c                   | 63 +++++++++++--------
 checkpolicy/tests/policy_allonce.conf         |  2 +
 .../tests/policy_allonce.expected.conf        |  4 ++
 .../tests/policy_allonce.expected_opt.conf    |  4 ++
 4 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 63bf5245..d7576dd4 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2092,48 +2092,59 @@ error:
 /* flip to included ranges */
 static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_xperm_range_list *rnew, *r, *newhead, *r2;
+	struct av_xperm_range_list *rnew, *r, *newhead = NULL, *tail = NULL;
+	uint32_t next_low = 0;
 
-	rnew = calloc(1, sizeof(struct av_xperm_range_list));
-	if (!rnew)
-		goto error;
-
-	newhead = rnew;
-
-	r = *rangehead;
-	r2 = newhead;
-
-	if (r->range.low == 0) {
-		r2->range.low = r->range.high + 1;
-		r = r->next;
-	} else {
-		r2->range.low = 0;
+	/*
+	 * The input ranges are sorted and merged. Emit the gaps between them
+	 * as the complement. next_low is the first value not yet covered by an
+	 * emitted (allowed) range; promote it to uint32_t so that high + 1 does
+	 * not wrap when a range ends at 0xffff.
+	 */
+	for (r = *rangehead; r != NULL; r = r->next) {
+		if (r->range.low > next_low) {
+			rnew = calloc(1, sizeof(struct av_xperm_range_list));
+			if (!rnew)
+				goto error;
+			rnew->range.low = next_low;
+			rnew->range.high = r->range.low - 1;
+			if (tail)
+				tail->next = rnew;
+			else
+				newhead = rnew;
+			tail = rnew;
+		}
+		next_low = (uint32_t)r->range.high + 1;
 	}
 
-	while (r) {
-		r2->range.high = r->range.low - 1;
+	if (next_low <= UINT16_MAX) {
 		rnew = calloc(1, sizeof(struct av_xperm_range_list));
 		if (!rnew)
 			goto error;
-		r2->next = rnew;
-		r2 = r2->next;
-
-		r2->range.low = r->range.high + 1;
-		if (!r->next)
-			r2->range.high = 0xffff;
-		r = r->next;
+		rnew->range.low = next_low;
+		rnew->range.high = UINT16_MAX;
+		if (tail)
+			tail->next = rnew;
+		else
+			newhead = rnew;
+		tail = rnew;
 	}
 
 	r = *rangehead;
 	while (r != NULL) {
-		r2 = r;
+		rnew = r;
 		r = r->next;
-		free(r2);
+		free(rnew);
 	}
 	*rangehead = newhead;
 	return 0;
 
 error:
+	while (newhead != NULL) {
+		rnew = newhead;
+		newhead = newhead->next;
+		free(rnew);
+	}
 	yyerror("out of memory");
 	return -1;
 }
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 4115dea2..263237fa 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -43,6 +43,8 @@ dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
 neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
 allowxperm TYPE1 TYPE2 : CLASS1 ioctl { 0x456-0x5678 };
 allowxperm TYPE2 TYPE1 : CLASS4 nlmsg { 0x1 0x12 };
+allowxperm TYPE3 TYPE4 : CLASS1 ioctl ~0xffff;
+allowxperm TYPE4 TYPE3 : CLASS1 ioctl ~0x0;
 auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
 dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
 neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index a88d8785..c1100992 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -44,6 +44,10 @@ allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
 allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
 allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
 allowxperm TYPE2 TYPE1:CLASS4 nlmsg { 0x1 0x12 };
+allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0x0-0xfeff };
+allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0xff00-0xfffe };
+allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x1-0xff };
+allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x100-0xffff };
 auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
 dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 3d21c310..2510c91a 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -44,6 +44,10 @@ allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
 allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
 allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
 allowxperm TYPE2 TYPE1:CLASS4 nlmsg { 0x1 0x12 };
+allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0x0-0xfeff };
+allowxperm TYPE3 TYPE4:CLASS1 ioctl { 0xff00-0xfffe };
+allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x1-0xff };
+allowxperm TYPE4 TYPE3:CLASS1 ioctl { 0x100-0xffff };
 auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
 dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
-- 
2.54.0

