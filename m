Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9A49E5E3
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356770; cv=none; b=DMgEBnLolnJlU0dg4wx/bEbqaFtTZFydiVkriNENxXoNpipyyDElUJW82VEdXG2kJQXW4vyRPgjBKNPBa0T/trRkYQ7gNjELnAqCiMQIuHWIkpXfqNQHTo34zTt7Vfda9o8sdhLjqQatTZYbnrcTSFTue2Iwa6RYQ5FaqRR5po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356770; c=relaxed/simple;
	bh=oAqTLZL83/ztEnHgKRh+s9wTv8qAtFzf/rrMrgsQOAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH0XpvFOg/5ZLMb4FwzDfQLzEYDBIubkdVjBqUtpifqn4tbp8qQ9977Ra79nrmV5xz3DpCz5onUVadKpfEfrPhPTJEGuYOBytTdEHxlUekIHI1I3sjzbxLMoYDmWjzgQhkAhSc4bssbU7pBpDZHM2wrveh8RPmrZiTx6S2cYPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwjIP/ON; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwjIP/ON"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52d8748cde5so9691061cf.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356768; x=1788961568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFqxF0INJ1caMDYY/09ZYdFPzicCl9IE3svYDjTLmn4=;
        b=cwjIP/ONBBptlKmHvQrI6DpIfWNWJ++Y6JE7/kKIOHMahzdqPMv78kZHiAHgHQbry7
         lHU5BnTAEDgug5+EH/ertT9mJUmMw2jb/Whx+reo3rbDAXg8n9t2m62c40xah6Z0GC82
         RMs2QEmL1cLVXnRX627zroeYgSE3sutzuI249mnXug6DyEQyabnoVjqEggyVtjCR68kx
         bxD2bMp4QoU5H8BFPZJ15guwW/s00yb1pcf6KM4cQmr69p3e+D8pAf61LyjIdKkk7erk
         O+TPvoGGf17PvuiL2RqgnLDnpd4cS+R0FyzavxDlP+Xg0VyYWAO5u9IExsoTVU7xSDOf
         +cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356768; x=1788961568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pFqxF0INJ1caMDYY/09ZYdFPzicCl9IE3svYDjTLmn4=;
        b=cLhG9WOdkpfwullqdD+6y0hpnDvbeLRAUCq8QKPVu4ht9LFb6SVzEFWRUwqvxYjluZ
         9D1d1T0yi/zSp4h6/Lph/VjKzuzKCsW4tl7dLhsGiiJJT6bORj2zj0DIxCcKJtLOu77E
         XKrewGOAXlaSTjKmo4pRRmxvczHHkkS7qLCY9o1QNL+ny4G88ZEit55wD/fM0OpC7l8e
         b58m6Q9Ay/HRwUKs7uH22vtQIAMrdUQJCvTkM5OIW88HrN+qDVG3ph0IBVvEyaU+YPnp
         HboJjWWjHnUN61/VxKJYqA9MSXbqVk9hicEplNrgrGxv6Wr9eR9uZNCgccwt4xnBdgR8
         uqxg==
X-Gm-Message-State: AFuF++n1Npp3JXZB/0+tgoYHnrVRxiDfgKjgXzl5WCxUmJEdauHJuby4
	sLf/9lAwY+gVSoDRLTHWUWKMnLdR83e2Pintm1gNxvUizMtGKV4MGwOz61sEEg==
X-Gm-Gg: AR+sD10MYdn6YJGOYGBP0dVkLiuxLLUqs8bIe7s35mqWHWMLA0jCRdwE4mAqcaOrtvc
	gqZqc+kE1f8k+MT/iMWAtZiy83kLaMWM2DI5TDK1H1HWeSELNrpaOPVncwMC7qG8rcE3i2ov4da
	HNgavEzFg9rjKtbhe5akVPecMtDOPIjGs6HSOhNMAdoZY60xN17xzPp+iw7qGM+rrJ6cV/m+h0J
	uKy2BHYKcxezmgu+F2+T9JTYTw/CKcOvQxwilCJsqw2ouIbV9F2LTVp8nlsiZ7T0RJ5BvGkUp73
	BaSPVeQfigB6xF+ohtqlQjrl/csoxGv6YJI2EgfW24RfjGxpKpzca2yud3GQE84mmHa+Dy5gfti
	PChQcB1DJrIw1LXSFe73/VhvJ2ryZEGGfZioXT7cFZstG+6RllcyXLcPLJplDdiERRZwNA9nD23
	sYoqxG8YlcHzgsoBPSePjTzKdRzKMidWHaIvM3pF+dOMk50senMy56YKHwpOXoQqervmi4Q/rJc
	F+y3csWFc6NSqm3/M3Ch6vIHa8JiZrIuQaSCzu03IW1MAGSgGm6APCp5lTMQyo1
X-Received: by 2002:a05:622a:e11b:10b0:530:39f3:6c97 with SMTP id d75a77b69052e-53039f36f7amr25997641cf.23.1788356762565;
        Wed, 02 Sep 2026 06:46:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5/9] libsemanage: create the writable store skeleton on first transaction
Date: Wed,  2 Sep 2026 09:33:13 -0400
Message-ID: <20260902133316.51981-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule calls semanage_set_create_store(1) so the writable store is
populated at connect time, but semanage does not, so a fresh system
with only a ro-store-root the first 'semanage <object> -a' fails at
the transaction-lock or the sandbox copy.

Any transaction needs the writable skeleton so create it at the top of
semanage_direct_begintrans() rather than depending on the caller.
semanage_create_store() is idempotent so semodule is unaffected.

After this the sandbox copies an empty active/ (just modules/) the
missing computed-file check in semanage_direct_commit() forces a full
rebuild, list_all()/get_cil_paths() draw the module set from the
read-only roots, and commit_sandbox() renames the freshly-created
active/ to previous/ before installing the new one.

Read-only callers that never begin a transaction still need the
read lock; that is handled separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index fce571c2..c856aa0b 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -405,6 +405,19 @@ static int semanage_direct_disconnect(semanage_handle_t *sh)
 
 static int semanage_direct_begintrans(semanage_handle_t *sh)
 {
+	/*
+	 * A caller that never calls semanage_set_create_store()
+	 * may be running against a fresh writable store that has
+	 * no active/ tree yet. Any transaction needs a writable
+	 * skeleton - <root>/type>/, active/, active/modules/ and
+	 * the read lock- so create it here rather than failing at
+	 * the trans-lock open or the sandbox copy.
+	 * semanage_create_store() is idempotent.
+	 */
+	if (semanage_create_store(sh, 1) < 0) {
+		return -1;
+	}
+
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
-- 
2.55.0

