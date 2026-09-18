Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23233F8CA
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745495; cv=none; b=GRovJTlr5R0uAvvTB8xw1oAyn97m4IUVfO5QrcjD7CANpu11tY17k8gfyFMaRTBgHIvial21i14Q9UqabtN/XlsttzQYPvQPddlxirg8p2BPN5/VNkAqdIJKuZkuqJoJfhhOLrjbRomaGbRb9H3o3oAaQ5zrIQzKloY6YtZgnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745495; c=relaxed/simple;
	bh=5W6k7FIPTyj3IZaUoZsHZPFsN26osd8sFKwW/UIUE7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rvex6eJSenx7V/zS2YTuv6A55xTNDwatj18aBINI/0eEVu08QxAC062OjiD4Ciw8QNf4duoCZxA0H9/LWaOnJcC0TzMefW51jtrpxx9auO6vUDZROya6b4ywXeHxSnofgGrxc+5x71Qcd59Obupn8MSsV1th1DF3qRJkrVnozno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXg9DDEQ; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXg9DDEQ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f943b286fso859119d50.2
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745493; x=1790350293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8Ju7O1RIdZXgcYNcfQZVpLQPvL+6I7hgPAFEv9aBIQ=;
        b=oXg9DDEQz5EspUjhsN8kovFamkkYCpg+Zy2UnqgcrIl9w/OGYDoQ2DEXlkV6OigdXH
         oAR82BTsqDZLe8l2yjUB8Gb5nqqcvnYgAMp8QzLdPYOlm2DepskgQFCgy24c0MpaHxFy
         sztRYVHy6xHy1VdKHPwyr26ya92Lo8BOlno8th0LMbhVchLVmbR9fk/BjmFFiUK+Pe4X
         cIwUhWiXYIkf621tTyo1RZsjLnuPdx6Pig81aSvK6D9Q6Z5H5NAixdqNJDFO54QvPEoC
         0yHJ8GZSBiAKiaYhQRJCweaHIRQcK6QkIvByqUAFiGA1Tqrf8TLxHuc3jsLshYy9eIfY
         l2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745493; x=1790350293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8Ju7O1RIdZXgcYNcfQZVpLQPvL+6I7hgPAFEv9aBIQ=;
        b=c5PjglNXBle2wKDlInpDvGBakI9AyXRbbKxWjTxXrvVudMYBEJGAlILViAB26O49nr
         piRAJD1h1l3JAgI+DoNxyrTl7s2ounR5lTAeh1MqWSY6LNwhYOHljRUjJVtBOSxXRKcO
         FSu7QPadjhdvdd2D2kCArlu8d0790su4TgoX3JiKmIsIGPnkCXZR6CLNgJ4Jh674Jky2
         ocVcVvqUPsRcyMNS2/qOi8Fqey5E4glHQXU8KBF+/I6cdEZ4mpsSFWuR8BgIp4WsG5EM
         p3aVGHR6lvaNxlpjaSzCmpxOmjv7/LQK8WIBJvyQMMDgDRXK1zMv9BUshsKBOc8qom+Q
         hIxA==
X-Gm-Message-State: AFuF++mw8VKE1/C1L1M5WdZ/+qjRnWR8/TMlHKnIAKafRjGzuFpJ6S7w
	9qq4ki+3Da509XnqJzkY1cAtTUywTASLlsLAh4XcPdgQW5Ov3qxtACSUK7ZsiQ==
X-Gm-Gg: AYBFou1eC4QDDwACdDzzESRS5Tc7RDQXkM4JO1G3RgQ1/s0dDqa8+sHvHDNDLmfmGs8
	mq4DCj7wVn1SC0njTISGjZ9BEzJ601FTsXX0SKhLWkug0/hPIgjdTeYw2qoevDA2L76rBvbTMuE
	t+MCBEhNj67PzeMogE/6rgs/yeT4j6kXmhkoGI4LITfjEOZwQlqGJH2oN8S3hMErpjGOvH6yHQN
	+9tq3rnC2vrgx6Hm2HsVc5k0hZRyix+EkBpVtTAdpDdCKlM4pE7S8xYEvfolIDWI4gy5SddWvC1
	C/AKrNfdjA+xbEImyPYucLY06OO/1v/ZToAC/3a0jHTlTclnYRX3Yw7g/Yj/BoMTLEYDmK5IVFy
	dvNnHeOpHgPI1a7TK5Laq1glzGIMrrsRrnaxq4RQvNe74S1P0+IlgNtw6BpeldqiCa1I+8o3KeZ
	zRcZI8JScwX7JqjsbvlX+VeW31eYpQtf1P6P1FQLmJTP7kVsQXtMZ37fo1Rl0Y3JkvkUBSt5UUn
	+tzIC2V1fwrQaAhOM+ACNLv3HJPUF8WK2HB5KdCu9+g6/L46mjrGCng/eY7Mn8NWgniSJmLMKum
	jLN5Ln33Mw==
X-Received: by 2002:a05:690e:e88:b0:670:ff3d:e71a with SMTP id 956f58d0204a3-6717fdf0ccdmr1007534d50.76.1789745492723;
        Fri, 18 Sep 2026 08:31:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125800e368sm15410776d6.8.2026.09.18.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:31:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: skip unrequired class slots in is_decl_requires_met()
Date: Fri, 18 Sep 2026 11:31:18 -0400
Message-ID: <20260918153118.20298-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_scope_index() sets a linked-in decl's required.class_perms_len to
the largest mapped class value seen in that decl's required class
scope, and allocates class_perms_map[] out to that length; the
intermediate slots not present in required.scope[SYM_CLASSES] are left
as empty ebitmaps. is_decl_requires_met() then iterates every slot
0..len-1 and looks up p_class_val_to_name[i] / class_val_to_struct[i]
for each.

If the base has undefined class values below that high-water mark
(which policydb_validate() permits via the gaps bitmap, and which
arises when a module requires a class not in the base so
class_copy_callback() creates it at ++nprim), those array entries are
NULL and is_id_enabled() derefs a NULL key in symhash().

Only examine slots the decl actually requires. For decls that came
from the base itself, validate already guarantees every i <
class_perms_len is a defined class, so this changes nothing there; for
linked-in decls it skips the padding.

Reported-by: oss-fuzz (issue 562655132)
Fixes: https://issues.oss-fuzz.com/issues/562655132
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/link.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 868e0a7a..ac9a4f2c 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2007,9 +2007,13 @@ static int is_decl_requires_met(link_state_t *state, const avrule_decl_t *decl,
 	}
 	/* check that all classes and permissions have been satisfied */
 	for (i = 0; i < decl->required.class_perms_len; i++) {
-		const class_datum_t *cladatum = pol->class_val_to_struct[i];
+		const class_datum_t *cladatum;
 		const scope_datum_t *scope;
 
+		if (!ebitmap_get_bit(&decl->required.scope[SYM_CLASSES], i))
+			continue;
+
+		cladatum = pol->class_val_to_struct[i];
 		bitmap = &decl->required.class_perms_map[i];
 		id = pol->p_class_val_to_name[i];
 
-- 
2.55.0

