Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A82EDD78
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939034; cv=none; b=YDs9nRefkiAb2FYAmbc4xw6ihACM3Jq6WfSz1RseBg7mb1vS/CDVzcP4VXw09I5xEbhWI/8ayUkZYg2CrIhTqbRtx+ajgFf36VoB42yG2PiNXt+O0eQXvyKKKVJq4KiwCO6ycvZpsWDfZvfNo/7e5pmSi6/9gwjGfiUuwJRAkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939034; c=relaxed/simple;
	bh=Ve/JcIp/HoSebfOBOQHMKnJ/US8JUZVY219ew1o1iTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6+rl8iw8vgwL/9HnwB5q4UMCee27R04GbiiltScG7DZFGdm4ZD8o7uEpOSjOx69Nu56fqVHs9dNKMz0VWloEcOOkwJY6zTm4bnhGvcrYxu/fdB4d1qqHKjc4qAKdzHbPARF7VSQIsIrIjRAd6FFNuH0eTZnOShWjL+e9xvQlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1lb63sH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1lb63sH"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915ab38ac14so490522685a.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780939032; x=1781543832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ED+zW71m32ZJdKdep24uMfVg8fGoDEF9o0mFa6qk7E=;
        b=O1lb63sH1ovAZkivcMNR9+wG2z5YtT9tWDKwkOImrQtHpX4qKk0N5TzrSzWviJkgpy
         3dKo8Q2C8x/SaqyTyDOmMGZMY1OYWJ2LO1ZOWkP/OWeUt6IYofggjfcKG6zMOxDfLfJm
         sgfABA1wOIuLz2ObUESKnOmCeQLyB/KRl0KQNaMrMDR9IKYeuadtO4JBPzABlB00hrro
         JBsG8i89S8sgPDQUXOYD2I3uztBEqxi8MaeCn7vqMmMhyAjZVfW3GSIbDQlg6fThXCXH
         pdcjkowz1vB/lW0LOLbCkpS26QMSfdSFVvlieuJ/8knmzWLjLRZNThkuj2nh83pZGgt2
         uYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939032; x=1781543832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ED+zW71m32ZJdKdep24uMfVg8fGoDEF9o0mFa6qk7E=;
        b=Be3Dpw8oi8WZHN8fYTolWyGrFunSVTwrVUAjWxBzzj1MPXzcOxb04ES6WTqvK8U0eZ
         TevYAKfwcQlTlQ9mJn4w399aWJLEWixh/GG6T+6OPnALgGuSi0lsEsih0Iyui9NmLK2F
         Zf3+LD8O6+GBGCy//Cgw3RnPkGcqaMCOmSpugvftqg9FwaHHI6xnSE5SqziAbJlBK9j/
         T9x5d3DGYCUQfBBfRGX9npbcHcXDJi7go91LGlncGada8Xfh7dFmCq2o5+2gdtC2gdPh
         g0qal7wRpye9YOdSOahh2rK1BVvZ0/XxqADtoQ3/f58PetFsunEL/aVyy2A1MwLjKM6u
         RzqA==
X-Gm-Message-State: AOJu0YyOZdYiCN2J3jhYRsYFO7Mg+6/6pYJBGcMYvEWLebpPhC3uQYvS
	7kdHeZFEisXJ5rI+bBQQqY/VTRxnbtkRsNO77vYaVHrbPcWPoS9ltmcSE2yRDA==
X-Gm-Gg: Acq92OHMb/Monw6q2uuH+20AahMMbqT+oHIQ9c9m8ZOdocHuNUyt/AeURtB+MGi/DEn
	qUOmVZ/TJ1yLPbTqXvk38ZYtSQYWQ/CHZHflG2070nwxOemPYsnBTbUsiIjX66BqDSQGfjsE8xY
	BYbhoCuJ7kNyBHhCUu4wCubMwrwSJzif74kwB6mRvmuJdJEv1hR4dhJu4JbhAdg6aU6c8KCbyaE
	xbWuIkkeB8qacCQcPmXwDT9hvAOGweJ9S+BG37afCfQs3cRU9BHVKlYBMCQgXfnyeVJr3hdv3FG
	haNEqNICXwTHwvIChcmFklJcpgV6w7CKZqgfEI9Xjfw3uBy5cL0RS7CKk8fYyicSHiQLp2+3jaj
	h9lcNsiuJ5QeiflnYYhAlNKtJgzllYvyIfGBtjJ1iCZ94iolKsnRABfnFU9vc8BKIRXXtjaYSrP
	1iVLCiDbEqvK5WtlnIUW7BCBuQbmClwv57ybcVbQvEUhV/leU40Ge/ts1hY6AaccTkMuVN7bpcd
	H4X1SQSMhrlmXBgnJxndeEnuVXVlHn2TQUkKg==
X-Received: by 2002:a05:620a:46a6:b0:915:9efe:6de8 with SMTP id af79cd13be357-915a9e25e93mr2568188885a.58.1780939032233;
        Mon, 08 Jun 2026 10:17:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d7280sm1796640785a.41.2026.06.08.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:17:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: sha1: prevent overflow in Sha1Update()
Date: Mon,  8 Jun 2026 13:16:52 -0400
Message-ID: <20260608171652.314902-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 32-bit i/j and a BufferSize == UINT32_MAX (passed by
digest_gen_hash() if the specfile buffer exceeds UINT32_MAX),
the (j + BufferSize) > 63 and (i + 63) < BufferSize) can both
wrap. Extend them to be 64-bit to avoid such overflows.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/sha1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 279625ee..02e05811 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -226,8 +226,8 @@ void Sha1Initialise(Sha1Context *Context)
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 void Sha1Update(Sha1Context *Context, const void *Buffer, uint32_t BufferSize)
 {
-	uint32_t i;
-	uint32_t j;
+	uint64_t i;
+	uint64_t j;
 
 	j = (Context->Count[0] >> 3) & 63;
 	if ((Context->Count[0] += BufferSize << 3) < (BufferSize << 3)) {
-- 
2.54.0

