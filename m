Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AF46A602
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548534; cv=none; b=fOp0bXj83z9J1ZPgLW/91n/W3+dKqEpcu4B7Mr7k49AbLavzsJbMhSnjH5k4Kpa4TaKsRi3DcMxWMFmRiuCbM9fbBY3l1u+Awgdcb1IbhZeBUVRvhr9H/yzAdmGymeXCOKo/Mpejj9BowJrwNR/RMmDqs2ixFX2U+AWIo5E5Rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548534; c=relaxed/simple;
	bh=UIS+8Vok3DBQlL7MgdCPjFvQD5qDYa2P/O/V1YhDTSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbOCvAdPUpHJz6jWRQm6pFbHGVRtUEh/+iLyZDksfz9G8dDbYxfmaTmKl2Ozpwl3RF5HhfXaUYJLXMQR0L5IZI6m+EPAijsMomuTodjBfjrNq2Sz/R+MBhvVxTB6chrBBT8Efi3pmGNPTEguLXg1WGt/7M8R4aNH7LDAKRW15NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSQdCvzX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSQdCvzX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so9366666d6.1
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548525; x=1787153325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=slXdZtHFmjNe5NPFY9C4hZDlbb8erFUHmXHr9aJ/iw4=;
        b=PSQdCvzXbS6574LFIDd119ra3KaBLUOZzViJe1v0w1H8zdGPH5OiUoEDCqwYHZtlc5
         P2lr6IxFBV+AnCz6GdY8/g/EUOvh8U1FtXZl8LCISrrW3vKwR54qR4wDVsPTmT5IGItA
         hIBC7TgrIF1RDW1o8ItJKb7Lq9EiYZxpyPFSNfYFwjHoxa1H0YBgm52uVDXEio/M8mvG
         kmrf/H30SJK+PjEsuJ8JUoBg1Gy+N5PMwfhbH4uhP7u5feUeO12tKI3cKPk7Kb5xCzQS
         wv/gLFun6tC0TdB9u6jf272G04Rz3v5Xf/ylBAe+mQ5Hp/wRVZjO4iZQtQhlLbnXWkWh
         qXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548525; x=1787153325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slXdZtHFmjNe5NPFY9C4hZDlbb8erFUHmXHr9aJ/iw4=;
        b=UlbTSDdaVpnY2zBPaWmC2EDFVNmJwEibbYAn+GTKPcJ/k3KS5HlkS2mOsanxifVA0E
         D7VvwR7j8SRZnvIszlOzdJbS1k+hbaprdkZdgPCUpnoUbectFwDFPa5iUJ8ZfY65PLqt
         6uxRig73L0vUUCzyLfaC0b6CvkxDP0kZwo4n/mMVcOmY/lh5KyxC0jQnNYXKubKuGslW
         xMufm9dONfKraL4GzWGzp6NMYpX4ht3ZQmmQbUH/K0obUQqDhUpYIPijkAFnyKeeqpdj
         mRFuqBMoXsU5tmi+X4Wk5GpHgwpJ+T2Bg2sMgAfoJCUVQrbqqtmnj1VbgQkFWPbSck3A
         LNTQ==
X-Gm-Message-State: AOJu0Yzd5czjEplUpJgG480vSfrpI7oKPRi1XUEtUUFaaluL/tCSK+uc
	wVg3dyDIc6LAphrZRHwwS0pOJx7h3RowfDaC38Vu6iuh4LBfeFCKt1pr3Lo9wA==
X-Gm-Gg: AR+sD11oJMvrIWKvDGpdp+ISrdU0blNbESfT+xXlPyVsx5p9wRBjuhfQjY/478PTLgl
	K+c/CsbR0SKbt51zvUbePC8qqt9QsbCzUFtlsGywpNosFlBN04s7YYIDjkMWxZ3oApW0V9Py4vQ
	UZ1mTd9s6mHVQGA3FS8AS4i2wPTw4bobPcesuqRIl7RGp/WwJGQj4NEL9crlU3GfQgmESYVfE7/
	gJVQEL1tx8GhYLnRiAwI41KAmxjyCEhjRAKI9h1snNqAtZRfT7PUbAdNP62w2IS1vG5BMTGSipW
	7KGHC7ZsD9tRCi44hmEO41wv8buDFQ+AHzqqXiyBId8VpSyEgkGZahb7sR1Pu+asQPikDxBn+FP
	+6H4/z0gjCx39KCO8cTffWNolix3wiAJz1aN4/rQxEJMwIlKAResuqZhzbd8t+nQawKBpLcN8hZ
	/PsK/sQtA+MAAlaCkZy1nKITMHS9N7ViyChRfAjmkc305Raa6aXe/i9mAm5BYwdLUJFr90kdJgS
	HOmKbXIZI0=
X-Received: by 2002:a05:6214:570d:b0:8fd:d5a7:f970 with SMTP id 6a1803df08f44-90a6ff9cbf3mr53419466d6.11.1786548525393;
        Wed, 12 Aug 2026 08:28:45 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3ec565sm23680406d6.43.2026.08.12.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:28:44 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Skip aliases when creating the type_attr_map
Date: Wed, 12 Aug 2026 11:28:36 -0400
Message-ID: <20260812152836.11250-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aliases that have primary == 0 share the same value as their
primary, so there is no need to process them when creating the
type_attr_map.

Skip aliases with primary == 0 when creating the type_attr_map.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 3d5bae83..18718973 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2646,6 +2646,10 @@ static int type_attr_map(hashtab_key_t key __attribute__((unused)),
 	type = (type_datum_t *)datum;
 	value = type->s.value;
 
+	/* Skip aliases since they have the same value as their primary */
+	if (!type->primary)
+		return 0;
+
 	if (type->flavor == TYPE_ATTRIB) {
 		if (!(type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE)) {
 			if (ebitmap_cpy(&p->attr_type_map[value - 1],
-- 
2.55.0

