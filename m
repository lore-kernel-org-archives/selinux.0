Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A1442FA0
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141380; cv=none; b=Hh3XbyGIK+4q2S0VCj6uQPbNfvwN/afbzEpBfvKLTb6zrN9siwfRlFgR2Exf4jXwrXGFhixIfgZPy0tpeWr67mZQYtzd/ZO6OH1kdc2Huxn1fS9W7BoXQZr/SVjk/O5k7R1KxopfxwxJ2fnqVymSgs2MI4Y8S7fOI/xPpMKcfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141380; c=relaxed/simple;
	bh=Q2YES34MFH9I/DNPJtbVUy4raTfYysqIaCJNk0/jQ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1VC0hPea4EOzkkt/aqOt2+774k0w8uHA+tUKdUTjPUb3TSL/4PKuhKHFki4PvJ5YCC9ZbIlhOUbCXkDL1HtOZoHnxDihsTSaTGHnO7pG9d/bXEqAbfjl6fvTbJwRUxSGaDUaHyd38j7cF+c/sePC6myv4j6Vw+gS8IgB1p/bAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZRUl5ov; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZRUl5ov"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8efef6533aaso24357136d6.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141375; x=1784746175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tmI5ydUsPAsnBp3JJrjpg+DoGEpUWDBbx4+wk7PNaI=;
        b=lZRUl5ovm48XByHdl/QjS87EnS1/xU1ZsINaPvmyiAh5Tzlode/Xe4eZ3Wrmh5SWJy
         EHKzCLwoeO/NF+X3mefhQZT3RBTIVCQSzasuW1zD4yrOasPn6BdUGUAIZniCCVrUdSWu
         7xc+7pb+0989xBMKJYPeJ+591X68gHOvgoNnK82vb5oSzUm3HhEMZUwgA2dElawwPahM
         YMlskE7kh/I8edbPL4+7L7j13kLS6pTCoSWzYlga7yGKnzWH1fJ0AKPJ5e1cpw7gE5rP
         nkjtdGgydxMcM3hM1XPd47Wy6Z5YxUXCHgHxPVTK64toFG12OY+PDvZANmmq0INvU3jZ
         nQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141375; x=1784746175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8tmI5ydUsPAsnBp3JJrjpg+DoGEpUWDBbx4+wk7PNaI=;
        b=O6RHrxvqARQlqOYbPtP6tvvfRHCHe0Mpidn6zPoTCv8u52xHKP0/uLidHfxQHfwR0J
         fwzCIWFAUrSoCcapZemPprjySx0OvWRsZ1rjNnPAWWMW+4vjDIIo1L4uaLDgSpgREDqW
         1QTKfF4ZGvfdW4gb1M3vDw8yEBs34tlNbh49ilTjyKqFRAC+sxo7qP5zp7qSyPcmJrqJ
         Z4VHlFxg0tlqmRAu0irmCngCG9DPnhSYD/r7ivwuNzokWjRuv83RwiWGn1WbLH/swKz4
         ZamZsAdIRWC/JjqBrRuZ0cwgZ+iPlbSR4Tf4Dq9o7f7W0/hEdzVjzQr6KhHKO6jcj638
         zIgg==
X-Gm-Message-State: AOJu0Yzq4RKgkOpflrV0ErMmwtyDHWuD7vHgW3vf1qiT8LSqeLfTbUie
	ZkE5ne+43LNYG/CGd6fH/yGkHMqZgLBHUk2uzMejnqLaleSDLmipE2rRRyLCuA==
X-Gm-Gg: AfdE7cmwxa4c4DadmcaGqqG4HSuVvn4k8/R+36rg9Y21SueSS6RvBTo15vFk55e6Ck2
	RYe1VXWlNRHGF/p5nYZxYpAuGW88iP3q5ATRGImEteo07+/R/CI5juzTGIjKrQzz04qJQSr9nif
	g6w0p2lcKRNmZ+4s66C+R+b8iNtIEYuJH6mpspjzOwHGNuRl9eYK5XmvyARu8uBj+G+gDQxICuS
	Vw4PN76LDJ935f/avT/DIZy2evbejrJV4b4apOon/bC3f2hEk2v4kP2oVByDtBPbVpL98RR2ghv
	fZVIaA2RM6RrD4Q/7DrWaccq54xazNZ0pr9DYfkY9oSvXThA927TbKAEcXF5Pw+5n6qh2U1rQLl
	4AJJxYH2RYuc7a4LH+B5bjnexh2QhygAkGbKOCumt0SpUCsMR7OvAMSsPcO6r2Y+48ERcCP9iYg
	TwsSJbe/FwQm2mpIgZHWpvlItbjw8qlYGwCkoxyaj6o6TS0GnzM44XFq5ocGfJRQ52Mo7bwm6fc
	jLo8BYim6xbTNE1
X-Received: by 2002:a05:6214:40d:b0:8a0:d08c:a720 with SMTP id 6a1803df08f44-903ffd6300dmr201411376d6.17.1784141375245;
        Wed, 15 Jul 2026 11:49:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm198015696d6.42.2026.07.15.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/5] libselinux: matchpathcon: make filespec table per thread and bound specind
Date: Wed, 15 Jul 2026 14:49:12 -0400
Message-ID: <20260715184914.45524-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
References: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The context array (con_array) that specind indexes is per-thread but
the inode association table (fl_head) is process-wide. Give
each thread its own fl_head to match con_array. There are no in-tree
callers of this deprecated interface and single-threaded callers
will see no change.

Also bounds check specind in matchpathcon_filespec_add() to ensure it
is a valid index previously returned by matchpathcon_index().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/matchpathcon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 80de61a0..9a45dbd5 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -212,7 +212,7 @@ typedef struct file_spec {
 #define HASH_BITS 16
 #define HASH_BUCKETS (1 << HASH_BITS)
 #define HASH_MASK (HASH_BUCKETS - 1)
-static file_spec_t *fl_head;
+static __thread file_spec_t *fl_head;
 
 /*
  * Try to add an association between an inode and
@@ -227,6 +227,11 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 	int h, ret;
 	struct stat sb;
 
+	if (specind < 0 || specind >= con_array_used) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	if (!fl_head) {
 		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
-- 
2.55.0

