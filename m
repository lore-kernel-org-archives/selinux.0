Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780288;
	b=QzeVRxg4K4pQMNeIh2UHRTBMH3HdkGiSyrZw3pn9J7ubzj4VmXGRyi/Em3zF9SEkBJvn
	 LoAh52uNig4A4FWGJjaCGjmi2ZgN4MLr+9WqkRVaeZsjTOVlE7sxx2kQLRuIRhdP0WMnE
	 +YCxIS/UYhow37esSxpbccnlWplqkHNYCLf0QVvjdVmxEcLpo04MtXaAm5TY4vOtzXWuo
	 0uq+htSE+s8X31sATHlxiw4Xp/x7sXZ8ygKLD4JE1wvS4lQ9A7Ff47Qc61ZvhEL9bchGy
	 WlrB2gc2ifCsa5AX3gq0vjeqx2yydyr40PhXLX6vNMn1BZynoseAK1lK4M2L5Q0y99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sZqD3Cy2POwzSwjH69P3xU7leEtotXGaH8xS+czYwy4=;
	b=nzg1ZPa4tBWqr/ZW7HljFoqEm6kgqS3g2WuY3WTHfiOUDtYq5+dObKJvYAA4/fiaTC8A
	 pgjC4ZGBaE+28qevWzTWZTt4tkIM+cpFoSanGPuUTyiT9z9oaL/e1GE4nbCTn359nDwZT
	 YL1mLq6DaxWXou4jymi9t4UFPwN4BBKrXJ7E6iTEM4zGjbJ8onbZVPxwVla8MESBcPNOs
	 JfioG6zYYGFv2CfUEAJNAcfkR0fMHtOOGEyS8361ZKeEAyttotCb7adtAJYIK2N+UT1nZ
	 g64xW5ZkJszbYklUIvXCgLah8EmST4HL/5SPVfETEtdMq7tWywbq6Tu5gzqMETjYDpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UaMh2//Z";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EB606A31B
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 18:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 066EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UaMh2//Z
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533778ab0bdso11622821cf.3
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780287; x=1793385087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZqD3Cy2POwzSwjH69P3xU7leEtotXGaH8xS+czYwy4=;
        b=UaMh2//ZW2xPZhoXPs5FOBnsHJjc54iGIA8qh0ZOm5UOVfk4OR9b64RviZp/p5N2TB
         9MwKzle9S2Xu//ixZtZjbMWpWUZcalMJiucH6LLNTSy8ml8YMvHE9veGWei0hRKDOKk9
         MbyW3/wPYEMcVeyAe0nXd5G//Rcv9AsCk9U/aVSTC9WT6e0ZxwTmmh1p2wUscWb6c4nA
         Cs1f50+j1IAn/nv9kze2mCpCabpdU8MN5ryYT0gtV50s1I4YYzAptAew+WGkSeImpkva
         Wus88jkPyNw2SMcv8zzLbJtDL23DUBMq9ibqi9uILW9IukSgrpJdM3Wpf2A+zXKTu4AR
         nB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780287; x=1793385087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZqD3Cy2POwzSwjH69P3xU7leEtotXGaH8xS+czYwy4=;
        b=YekjLIoaKMJTdMK7UP1Z/vvvIqWWJkfj/LdgjFxrrI3CRvwd3YanewBtsYRh4a3zdR
         P6wA9lFC5ovvk56vpLZcaP/XOqyImTcrhI8s1iYp5Wr7p44BWbB02BGiYEiRlGWR3UAe
         kXfoD+QS5yovxsNJ8HaYZXQaWpCrxlNMrL14LFZZ34ViRS4JkP8sUp4x6XalxCtW6Lzf
         Xsf7L8VrXcMbBEie/sVxfVCQ9TLTO5gJl7553DJKfytqKQrCdQ3VXOs58rvcoIHpo5YR
         VQDiwTzpzop3Zkwxmm4x98KTBjZGhXeG6V4TLXRHaU9AXLMLD0Da9zn5yDLKylD4Mmmf
         VXpw==
X-Gm-Message-State: AFq9FYLR+qtfFI0Eo50yg/hZ75g5yrg2QPuG6qiHhmbFH+jyZKrIS8rZ
	Qqstwpys5rP2rcKpWq5oo46gNC1oEnMkgLP78QX+LEgX2vVK3XcCMHO5oIBzZXzj
X-Gm-Gg: AYBFou2FhEBnieOEtD4iv/wEImQRUlz15RLEgS/zOiw8uVhHBnacTHHt0t802sOQ0xj
	3wZOR8cNy85S0oKcG5s5ovht62BGl9h/slaQxdDzUGTVr8bAazK4oFWeFZIGAHer/IZPUBadWzm
	qW49B3xhxk7C+8g1EssaSjyBxe6UUsn4N7OONWaqBjXlCNU8sJBq8JUYIgFjSDor/SMhO7SVz/Y
	mJ+KqVfDNCZU8/YW2uJejQR93vNxjDvFRMJEG4cp4loq/eMkXYCU4yDU3jOyOdZjc36VnRYzQaX
	YWcACzBTSR8Dkq5+7YAhsnqPP+zhaGp8MFMw4dVOCdPChToOCOrWEKeeLtIzGZRzuYnEWIsNDXh
	vZ1o3n5oPlh6sIwK9le/HKjvtteerzROx+GN7N31ljc4/RSEAfxaFaumIaUfIgGrOxXV9xjMp7D
	47h3Edo1APntOch5glkbNbWsgbrsWWqyYxWxh7efFdePNW7H7JzNQObqFlDwlzUmM4o7GZvbGuG
	d7dsrRtiskYQIOcnaQUgItuKQeptbE0B9v6KE4U9dLTLoQQWQJBowOdsZRWVOFAaLRATrvuEctm
	Ibyn2f3+pofsLaecWihUwsL3ogewXFPvaJ0/KqxPlaTfEoERNZQ5qKqNgzO1yTdVw9/COrIwLT+
	gE3ZlPmYWCp/FGQ5MGP6WG2SsIrq0cTu2xFxL8lHHnw==
X-Received: by 2002:a05:622a:2986:b0:535:b21:c997 with SMTP id d75a77b69052e-536c2100a78mr43406391cf.8.1792780286661;
        Fri, 23 Oct 2026 11:31:26 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7cdfsm754121cf.10.2026.10.23.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:31:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: preserve cached records when replacement cloning fails
Date: Fri, 23 Oct 2026 14:31:12 -0400
Message-ID: <20261023183112.61272-1-stephen.smalley.work@gmail.com>
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

Both dbase_llist_set() and dbase_llist_modify() free the old record
before cloning its replacement. Record clone functions such as
sepol_bool_clone() leave the output pointer unchanged on allocation
failure. A failed update therefore leaves entry->data dangling, and a
subsequent query or cleanup accesses freed memory.

Clone into a temporary pointer first and replace the cached record
only after success, preserving the original record contents on
failure.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database_llist.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 48c3bda1..209e8ec1 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -157,6 +157,7 @@ int dbase_llist_set(semanage_handle_t *handle, dbase_llist_t *dbase,
 		    const record_key_t *key, const record_t *data)
 {
 	cache_entry_t *entry;
+	record_t *replacement;
 	int status;
 
 	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
@@ -166,9 +167,10 @@ int dbase_llist_set(semanage_handle_t *handle, dbase_llist_t *dbase,
 		ERR(handle, "record not found in the database");
 		goto err;
 	} else {
-		dbase->rtable->free(entry->data);
-		if (dbase->rtable->clone(handle, data, &entry->data) < 0)
+		if (dbase->rtable->clone(handle, data, &replacement) < 0)
 			goto err;
+		dbase->rtable->free(entry->data);
+		entry->data = replacement;
 	}
 
 	dbase->modified = 1;
@@ -183,6 +185,7 @@ int dbase_llist_modify(semanage_handle_t *handle, dbase_llist_t *dbase,
 		       const record_key_t *key, const record_t *data)
 {
 	cache_entry_t *entry;
+	record_t *replacement;
 	int status;
 
 	status = dbase_llist_cache_locate(handle, dbase, key, &entry);
@@ -192,9 +195,10 @@ int dbase_llist_modify(semanage_handle_t *handle, dbase_llist_t *dbase,
 		if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
 			goto err;
 	} else {
-		dbase->rtable->free(entry->data);
-		if (dbase->rtable->clone(handle, data, &entry->data) < 0)
+		if (dbase->rtable->clone(handle, data, &replacement) < 0)
 			goto err;
+		dbase->rtable->free(entry->data);
+		entry->data = replacement;
 	}
 
 	dbase->modified = 1;
-- 
2.56.0

