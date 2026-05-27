Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4F3033DF
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896412; cv=none; b=ty32txQVSTudznn1QAwitlj/HgCw+OU8SzL9mKYifm8QZ8dRguEYpn2hpCkdGOOd/mmcOj9IvntwZX1+XSjv2oTpF+JSLR4xcmo40melyoxfoqx6ecIlg2krozcd8bMGlqllJMQNA6BUFqp8Qtgg1G/lDJtUqMXrpTWgS2EwlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896412; c=relaxed/simple;
	bh=cZOrf9zIhRzjKuithxCjGJ8cxcrSyXlXd7jatEAfDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPGDkwBkLgxyEOECZcQHnTMJvY/RxS2jsQh9AG0nzx9295CMTM5YZQWZNfZbT9DHlZe1hKIS9HUXXgTZ1/V0I+x61K93gKvzKpaeyVmnl6OOw8cEmgCjUoc4ENeQ0WN0a4DK/RW0tK650JVAWbZI8AYKy2DfjJYIHKlkOmGSK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ7c0ckl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ7c0ckl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90d042fa745so2113459885a.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896410; x=1780501210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yRcPWCntc999Tx+ajq/7j+w1Zc9+v4eH5zoH/01JiQ=;
        b=LQ7c0ckli2iQS+EaIFpQCPNDqEZOEnFsnKf9j3Uf6q8rJxf+UfJBaAuu2/N0DD0j/j
         xksnU0if9JBgSwMr+ff1O0dCY50zk9CU2BrV1wArlmMKRLuQC5lKvm4qCiwYso/E9e5d
         RiRCsSpGVo0c+cDifNulzqhG4kQVhzZG43LRKikvoo2FQShBWdsDXbI4ztyrNxSbcih4
         vHncOfe8/WB5jEY+Ljj8VeCjeuXo6iXzwa7V8Qk5E4xClhJnngnQID17F1N11neBRv7w
         vVFqH/JJNAs+bZl9CeyAPG4JYS6ojbHQVgtV95ebLJSLwV9F14y5bQBiK7ytM888SbOO
         kXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896410; x=1780501210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRcPWCntc999Tx+ajq/7j+w1Zc9+v4eH5zoH/01JiQ=;
        b=fx80rDreaSHDNglkqUYXc5jxgbnSd7NtzMUsnyRbduVTYGKIkD3vuFD3Sd/UmE1goO
         Vus5B4mW3bQKdVSCJDBNqlL6YCpZ6Ul4ZO4thHHWAAi7XMmapJpo8/MvO50YnaHsQ1mR
         knwTleOpkOzufh/ccbsaB84rAHnz9/fGjI91TBZ9GYzBlzMFfg1FjtbpjpbeE2LVNMNG
         VmU8BVsLvM3hnsbx5P8Ui8kd0Ktkuog1+OWQb2yVl7FKJ/KPLS/Q/dfU6Ema4IoQxVa6
         aA+yyZkgguXfZpUT6Vv3YUs5+AUB2N8GKjdNelqNKlo96BNmYyIanKBKKfl7rSLxi/YZ
         sxQw==
X-Gm-Message-State: AOJu0YxxslvZkdmJGDzlsTceROi+6q8GiUfVXSiDAQ9+M9DrHX0rPvlr
	9DztVzxQ2QDXnzzBNIJzrOGNJLTMjmTGeAOWzc1F8HRwXhQv0zMbwZrYeJ+VQg==
X-Gm-Gg: Acq92OE0wKlXzb3kjyCirjDEVCww5fYthPt4rsbGMt2Gwd0EwRTkN/9qwswbo1dr4Lz
	kq6/km8wXWESQsmrHhueGz8aXrtpB/1BVZBc4nshddZxFWWfmeYCc7SpTqjxJZGZERYXXGlu5Zv
	1hbtTMVsN+oxNZZbXgg0ysHStsRIp5ZTxRkbgeY4cOq6Wh/7ztF4kIvvyCMhaK2aq9Se5ZnCC3S
	f+XcJqhD/zmSv+CCXaPDVYDKp3Ua576C6ZNTolVLg+nXPVUtumwT/g3d9E3iGLTzWpQmhe9IoU0
	Ca2XpNWSKUt8KSceOFMBQL9U/UHlrejwVbIo9G8F3BN3bNmEwQfED75oQkU4klM5xxR+W5wCRYt
	tWBqZQWMyQ7gvHNyqJH3rgGjF5McY+EX6jOQBtuKGc5YeALW19FaMJ0tRn7Zax/X8COZ5aHctqe
	d2hWocTG2FJMYRY2pBFUaDNH5P3NS+gmDeYsBSlK5Kw/cdajYsqYcFGSVU+4k7Vw2nhwpE6Qe00
	HQZgkFhAEJpJXo2EfSerLlJ+OE=
X-Received: by 2002:a05:620a:372a:b0:914:c100:6a22 with SMTP id af79cd13be357-914c10072c5mr2798942285a.48.1779896410086;
        Wed, 27 May 2026 08:40:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c526sm494679785a.39.2026.05.27.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:40:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] mcstrans: fix memory leak of sortable
Date: Wed, 27 May 2026 11:39:51 -0400
Message-ID: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix memory leak of sortable on the error path.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index daf9b7a6..d12ea587 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1030,6 +1030,7 @@ build_regexp(pcre2_code **r, char *buffer) {
 static int
 build_regexps(domain_t *domain) {
 	char *buffer = NULL;
+	char **sortable = NULL;
 	size_t cap = 0, len = 0;
 	base_classification_t *bc;
 	word_group_t *g;
@@ -1047,7 +1048,7 @@ build_regexps(domain_t *domain) {
 		n_el++;
 	}
 
-	char **sortable = calloc(n_el, sizeof(char *));
+	sortable = calloc(n_el, sizeof(char *));
 	if (!sortable) {
 		log_error("allocation error %s", strerror(errno));
 		goto err;
@@ -1065,6 +1066,7 @@ build_regexps(domain_t *domain) {
 	}
 
 	free(sortable);
+	sortable = NULL;
 
 	log_debug(">>> %s classification regexp=%s\n", domain->name, buffer);
 	build_regexp(&domain->base_classification_regexp, buffer);
@@ -1142,6 +1144,7 @@ build_regexps(domain_t *domain) {
 	free(buffer);
 	return 0;
 err:
+	free(sortable);
 	free(buffer);
 	return -1;
 #undef APPEND
-- 
2.54.0

