Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128441;
	b=lPw37HgB6r1h1qCnOvGjVf5s1HbROJAmcjrr1PacEb9nXeG92nevDKqQvCGj85ct0cn5
	 I/3BA2mQ4VW5v1pSc785W6bxhQoDgmXuJeOcYGVfDNqVLeEyOvhMBYdPX1c7pvQTCH/Y/
	 MuTseB4LHv2YstabA0rqRlEFfiLfYZ0L5B1oU/FyiGofA3qcbAzcoKz9IYNmu6nPpaVMy
	 K5OglX7/FgZSPIWjzDDZdvDQilROi+Z0JEn0KgiHkcTk9BpYiBkNaohszYtLo2LP1gjzD
	 HieQAleMvc/TyDy8CKavShfe8ZyYjmBUSb3G67je8mK0kMXhI9DmH00Pj8L7f19dK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=usSkbCGttkT+Py0pUuej3kU6UM2y+V8P1vd7m6BHpII=;
	b=cA6R+VnVZChyk26yjwllownfqFdvrG8nqdXqv3u0NcreQzOupL8F13lQqxqINBqf2ziR
	 VOhZvxJPP/AHeVOsY9CMf6iDnzNskY9t4tCxwNw/9+GdUtuWAmeMEWb5gL0oKfwzWDk8e
	 O1c17qjFxawDjDZ/HwNMl6eZtJPXbny2M5ngYN1Vp39b0XdemBLZtOODWu9Svn6t0Lj2m
	 KfXl8YamlAwDt1CC/DnVcVAJSa4hOOomNms+vEcZbFJrk/7lbwKqp5EVWT+IjhnXpjlEh
	 fjw7RdVOnJDptLdr3EpgHo+naGAw94Xd3kufkMpSwb8p6SWwX0NU/QG3MSypY1kG5OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SJHg03D/";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD47606A31A
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 19:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD47606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJHg03D/
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c7b00a75fso2780356d6.2
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793128440; x=1793733240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=usSkbCGttkT+Py0pUuej3kU6UM2y+V8P1vd7m6BHpII=;
        b=SJHg03D/C5NfrPXOJ+cNnDQb6c18iHwsyodFMN0+oFKPt91BQKgfK2Uwc86lrGipeV
         z2epMEjuxcFAeGvs5m9rfY59LthGfYsa/CQ2BlC1ePbMf9ZQcE9u5ZkRcAF00S1P343E
         iIkO5l4ojq/YYGNCXiAgc3o+3ZxsqQlqL29Y9BTm5YV3CT+0nRH94RthOKY9ki3qmI6L
         rLn2NJQzf5cofheJfAgnOMvUtOYNJ6l3RgVL7YIenRlDao2co9hiWB5iydPsR+XMVmjn
         +NgNxDj95lpp+BzdIkDVKzmjP5LlTlh7UzHCd/xjWMgi/tg3XC7v9hSqTVNwPf02Xxww
         xWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128440; x=1793733240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usSkbCGttkT+Py0pUuej3kU6UM2y+V8P1vd7m6BHpII=;
        b=iafAuPXEcY1qU61p4NcrK9aOIuqaHGkdlV8l8O8WQXWnX/8Ql3jZcPj+I6eqw+0zOe
         Y9ZEZcdf1Ge9wVcR8JtcYSTgjGqxWPxh8I4mvO2BD54W9OuG0tySHGZnsuL2jOk0WLdO
         7IOjvBPz9bUCULQ8PC8AlYDikRqAf/irEwDDMH/pP38JSi2zDswdtqjp0TAqSTBYT6cm
         RiQJI8rXpaCwCs1UaqAAxrDLFUr9tmIE5D2oL/jPkhvnasf3ZMO86zrn0MzAYAxAW17V
         UVefu3AHP1MkZZXkz/bZ7owiGEZWSxE1VHwkAIZ3He5Vc3XgvwF/Cj964DD3CYzFVwbP
         oCmw==
X-Gm-Message-State: AFq9FYLN1oTAqN8QGyFk9DxilchbpAKOo44h9mX1JKsUeVHnD0P7KSD6
	aqDsOkSPQn7FhQz1IUi8/jubrgODM/zmD6/qCFLyXBXkVTG+sHw41jbCTuXxSDkl
X-Gm-Gg: AYBFou3T3fXxqSFJcnQMSlGUd8moC6CjLtXiJH6FacKKhgp+6sIW/3dg+XeHYBobhaO
	6gJtPHMCuvoClBx5PLM+RULw/bJ2kQX6d1TituVJ4pXh0adMe0S8tmRIQq805Pupyg8ZtlL8D/f
	31SZozg2rUHvmne70XhSPNRoOiYUnVcEjwyfxIcPVXTilFvwb6MrTJJtGhl1qjk73rgG0mcRtlG
	I4CHQsW6GgL3nioh6cV+c6Qbi/NfIF2vZmuitj8InRf9OHWpXhKGMpKjlh46u1T7Bz0wfyPDySc
	VlbnABD7IvphqzsfcDWx6smupSGwoSaEL9SopKNYIlqEFMuT2SIwIROQalLi/D6A/Ik7jI/aqpP
	jdYJvoK+3WultBemeBb4Bj+4QVV/3buVCX60RCXf0wI4pyWrMA7cJgxDOdQrtPSFUa6V5n0To4D
	TJfrERee716ZgBwE/dqjztjaCcXxxizo7pKGbRyxCDq1mkNZQ/CssloXl39d9kuvWH1Uvjn0fMx
	UShJFDus5Yz8BgvTLyGjhNut/JkaUiqe9V7Cd56gcca1myvmRVfBdrDvrJY+LvUivtRAAibIpn1
	uJUGKQyX/fgvEISJhMQMpZplP0AjD1GsQUwTZyZIN2ilRSU7yVthwVfY2KENdFHFD6Jse7DKyh+
	Pr2p6Zy0uJObGrNphdyA8IH2UqIvjtJcfqf0DjOOiuQ==
X-Received: by 2002:a05:620a:45a1:b0:93e:c12c:f124 with SMTP id af79cd13be357-940ef96bc00mr1607004285a.80.1793128439983;
        Tue, 27 Oct 2026 12:13:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a8164asm1048272285a.38.2026.10.27.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:13:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: synchronize user join caches across transactions
Date: Tue, 27 Oct 2026 15:13:27 -0400
Message-ID: <20261027191327.91854-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A local user query before beginning a transaction can leave the join
and its child databases cached at the same store serial. The join then
skips the child cache synchronization when modified inn the
transaction. Commit splits the updated records into the children, but
the transaction state check subsequently drops those changes when
merging local components.

Track transaction state in the join cache and invalidate it before the
serial fast path when that state changes. Rebuilding the join
synchronizes the child caches before mutation, preserving the split
records through commit.

Fixes: fe595f540127 ("libsemanage: preserve read-only store overrides")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database_join.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index 5daa1c02..d6ef6d62 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -28,6 +28,7 @@ struct dbase_join {
 	 * thing being joined  */
 	dbase_config_t *join1;
 	dbase_config_t *join2;
+	int cache_in_transaction;
 
 	/* JOIN extension */
 	const record_join_table_t *rjtable;
@@ -51,6 +52,11 @@ static int dbase_join_cache(semanage_handle_t *handle, dbase_join_t *dbase)
 	record2_t **records2 = NULL;
 	unsigned int rcount1 = 0, rcount2 = 0, i = 0, j = 0;
 
+	/* Synchronize child caches before mutating a join in a new transaction */
+	if (dbase->cache_in_transaction != handle->is_in_transaction)
+		dbase_llist_drop_cache(&dbase->llist);
+	dbase->cache_in_transaction = handle->is_in_transaction;
+
 	/* Already cached */
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
@@ -249,6 +255,7 @@ int dbase_join_init(semanage_handle_t *handle, const record_table_t *rtable,
 	tmp_dbase->rjtable = rjtable;
 	tmp_dbase->join1 = join1;
 	tmp_dbase->join2 = join2;
+	tmp_dbase->cache_in_transaction = handle->is_in_transaction;
 
 	*dbase = tmp_dbase;
 
-- 
2.56.0

