Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9541D7995
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622453; cv=none; b=mjeEcza+ZE8uhHspBnNk8BmzTeJs1wn54cTD/A6mBViVZtA6rcMkZCrkfQRddaW7/PgZcDNGVeqoS7+q9l2gFdUzqwm3OwtcfgATOWR6E1buLenoP6MWoh1EUlJqKjZWn1aZCEs0gMb85p+rNj/ZZq6V92fecGOp2vY/Z5HyYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622453; c=relaxed/simple;
	bh=y8pn0it1KV1F3fUiFTUsSQN1GXghYTo8kWwJsYfwnCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktfeadKmYvNPgBMKjpVEoc/YVLdrz001N56iQrwfD7oLuNUy82d2UAlmRzwSf+60M46+tbXwRmzpF3E5baJCwGuLzwgYbkon4PUuS6aYdvMGVdWho5xazv0LUzJGlljpl6lFAm3ygfJ+nhlnEvNwP5FEfxEgpMyvZE0SQ55M0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grRERUl+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grRERUl+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9159da9bba5so347982985a.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781622451; x=1782227251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2070R/lV8KOpsvUqolSDs/IHNJNmPQWqIbT6uLb6nN8=;
        b=grRERUl+X49WdGLnHayw0y6cuy35yeVeK66DUAhnJKJDc1fxsEnHlGzIhyDpJCdbFu
         LZ5fHEnjwyeo2ClrAlFXyFijpJcXz3r8WqbNczTtbz2K1bFn23LncKNP1f34ljxRYP+F
         J5BVUiR0uh6f7n8PIychdc/0KH2+uEYblMOPTbRZO49NaaIlxRZWEVtCnpFVMeft7GiK
         oh/Ru1vntPY0FDtuvm/4zSOIRcQqu1Hwfz2bEmi4To6Plo+OTFVnXydQ/bELT4oZV2N1
         Q41NLS7OWtyC30C5uU6V2kgQemkyNPgL995yoPtCgbE/cibNGVxyRW2aQz8f4KekVgB/
         +oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622451; x=1782227251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2070R/lV8KOpsvUqolSDs/IHNJNmPQWqIbT6uLb6nN8=;
        b=ftyvGUgdAAz7jcI7OLPA2TL3bX0RvHEdzqCgL98EdqP8zFVQDi+nQGCUVYRK45c0U6
         KY+i+8Ip4vfCSIDSKEm01WNY8mUck/JuIm+csz9X9mt6iD+NFyHa04BzoOfPEpy6LksS
         GiGQ57bZZlel3UuOgZRl6q9RYyOfwI+S/wiKGkm45Mb2KJfaVf7c7rN1bYgs/Hu0EJcO
         58z0+woiuXyPcP8FBbvgPO7LCRFWyFZsZvMVOz3X70FCy0doqYNE/zt7dx2z2FdR3+U8
         DXWbWhcjd6W5EwN/VApn9sGquimLYnC6+3LGKQH7kwi/Uq5wwt0SJ+Q7VyZYJy6YezW+
         zAdg==
X-Gm-Message-State: AOJu0Yy69oq2guW6fpPvlmT9r3got1e3+hvcVLZBXmNlZAF6hwbOSuSx
	y5dfQjnDDcgZDGHSKMczVr050RRIItosuifTfSfi9NUB7wJZzV1g+cw0IQ3MzA==
X-Gm-Gg: Acq92OEpEWOAyNRCA4RC4WYy2GIvdB4TrSzZBuqnoOeWCl8HMvIQqF3p9MWAAkNCJw9
	Vz1IudBxEr6I8flun0lw4jDCwCyXoP8HFJ0EBZGn0pLNnAj/tW+6IODDdX2Cjpeh/eyFdHxSTgs
	SPJDTr3i074AmQrhoGxMXtC6k5bxmG8WKGQBlVaVDa2jZ9FbYEQ2zZprcviqrQ73zKCgHtZf9yF
	RMvlFQEZbOSN4TPcdUSnQP78qwktFuprGZ8wFgFiDKniQkaLlgczSZGnpRYJpn+04RQsnURPAZw
	shBKpLCuHBVGrpiPf6wRa3z8H/yNiTc+IxLwQQhI8bcQ7SG9svXcvi8mWOcfkETpBVQGyc31CQq
	1V1keq3aFUUGC6lgHmzjcfpOq514LD4LZhfPENQJyFB9aNJ3FHMTOV3Gh0VB52F4VJ1doGWBaG/
	fs80QOQQ2tGPgNMlCLm+sb4atGhCgfdJk1I8YAtMU1vsrq0w==
X-Received: by 2002:a05:620a:179f:b0:915:bf79:3e0c with SMTP id af79cd13be357-91d8a7f1a9dmr8184185a.4.1781622451112;
        Tue, 16 Jun 2026 08:07:31 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a0080a7sm1498910685a.26.2026.06.16.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:07:30 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3] libsepol: Check for proper length of addr and mask buffers
Date: Tue, 16 Jun 2026 11:07:16 -0400
Message-ID: <20260616150716.42470-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating an ocontext node the addr and mask buffers lengths
are not being checked that they are the correct value for the
protocol.

Verify that the addr and mask buffer lengths are the correct vaalue
for the protocol and output an error if they are not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Use sizeof(tmp_node->u.node.mask) and sizeof(tmp_node->u.node6.mask)
v2: Use sizeof instead of 4 or 16

 libsepol/src/nodes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index e3ad36a8..5471d701 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, const policydb_t *policydb,
 
 	switch (proto) {
 	case SEPOL_PROTO_IP4:
+		if (addr_bsize != sizeof(tmp_node->u.node.addr)) {
+			ERR(handle, "Wrong address size for IPv4 address");
+			goto err;
+		}
+		if (mask_bsize != sizeof(tmp_node->u.node.mask)) {
+			ERR(handle, "Wrong address size for IPv4 mask");
+			goto err;
+		}
 		memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
 		memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
 		break;
 	case SEPOL_PROTO_IP6:
+		if (addr_bsize != sizeof(tmp_node->u.node6.addr)) {
+			ERR(handle, "Wrong address size for IPv6 address");
+			goto err;
+		}
+		if (mask_bsize != sizeof(tmp_node->u.node6.mask)) {
+			ERR(handle, "Wrong address size for IPv6 mask");
+			goto err;
+		}
 		memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
 		memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
 		break;
-- 
2.54.0

