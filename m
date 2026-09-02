Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553C4A842D
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362131; cv=none; b=EJgh6DnAAW7BzKPbcTstaOpI8PdiX3ch1/JjZ1OgA+U2/imNiEqHq6yyC3BaxfX3aiK5RwkfII24v1Jh964PNywi4w7OvKKAIaaYI7FtFc4w6uMLd75mbGKTKyTwHe3cDalUfe6RMVf+H2XyhFeUwjUwprrAeWmu/keYqmWUr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362131; c=relaxed/simple;
	bh=o05sseu9/KrcWq11FDOuY30xYFwLfzYGdoGWrpWYUu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI9d4DPHA7lue2pZizvtGayBMRFHn62sZqbUDpvSB+0HvHCGFStlPmOMSzdri7ceqP07JR21MmFH+OAIAB+gJY+HpF16fCqHW8Sg6xJF3rMp1j3NcOL+W5UtDmUDSRgG3m3UJ14Q/7Nhcf4zO8g4UaVG3tx/vdenjKEqHFVzXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgViyJsk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgViyJsk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-936c02e58dfso110917385a.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362127; x=1788966927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzsdG9V5Kk87Gfd+ylNxqHMu+NuNjYCkgXd4UAC7e+8=;
        b=jgViyJskW6SE4lkarvkxAqjWkEQXmA+4vBcUn5YA1hMSJNL0Foi6T7xKywCICEA58c
         646PrEFXPmvYkWh9wFDi0EXoa3Bz3TIJEiaTNF3mykFYVGH/td1fabjf7UBLzgpeWtqm
         kFXj6jZB8OyPK+A67Ih7RCFXWC+Px0kp5Lix6Njg0Hwjy6UQmlH5mZo1kiNxcKLOatL8
         +GHQqKVddEdTnJCuPj+PN1VaQzGI1gHCwuesbhwPjzUucHoBzXz0qjeDlDlsLMrLCPrY
         TqIZNSnW55fMrfFOuQvBfosHSNbSxf2lkFVIQLt/R0HOiDUtZrxdsGEJCuajuzyYu4uu
         HFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362127; x=1788966927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzsdG9V5Kk87Gfd+ylNxqHMu+NuNjYCkgXd4UAC7e+8=;
        b=Im/3LIlZIedU0PGNV+C+4j+aJ4ttViExtsr/jtYgESOd4ZRwIip3LuWX8Gf39rI3VG
         yJwChOqyNSa3dy3rUwJsA31srWG3cxGof8Or52q0G9X0WZ7nB9ffTF6KrgYEJ3gkyVYh
         9xYkTrnNmrPi/r89Bn5FvnrM5Wi7PAh6Cva0J29/Pw4KdvO6HoQqcuYlO2r7eggNWK1B
         VJ05BGQhg2Am44kikbfKQTe2INPoDdvvCe0frBibZ/0MQv/wA2JRbXE7NJIfkVx+aZVb
         /x1jtvSCIOcyTCt5hFog6nk0wEf2u9WR5sqCTwVsqM9Vhw8dNsKQyty2KVDEsXlb2+lU
         xXIA==
X-Gm-Message-State: AFuF++lE8ymupAHLZ/7+pF0/yD6ho7lN5rrKJ7yog8Fv1UAEQEJrfrgz
	imo7ythALkhoV/LE7Dz7mtp7q8vSCoNHlN1DP1Q566SHs3iPfqSMTcft1elpoQ==
X-Gm-Gg: AR+sD12HkFvIErExFYRD3V3eXvOSvMRVU6n8P/KDS89XuvmGobosI6FXxDGLjOG6t5H
	ZNih2MZH13tXDmB1lb47NhHJVGr5HoMAWUasUXs8fND6aw5ElNULxGo5Ni6SdpwaD4/4eN5BDUi
	mOl/5lkha9PTTrIiLc9BVRXQsN9A5hjGogrK5JIpIWsV+sC4wA30oPv03kZhbmwGlPNgQHWh/rN
	Hb9ej2SAs1yL4LqZ+tW5fLkRqmMZ2HDC+pTrrkJFLZBSD75+PdJ3iY3acZAf5lpL7Lj1B2e9rK5
	VC9LXG0skCwgE516eBt7pTjQOuMVb6IDw7eCgJOxURBND621NEwVmadYS8f6f3XLTaE8SG13KXz
	XZuI3YKrO+XoeGJjRUmpDTAZOqyn1pIwdDqYARltZhK63xM9mG8BSO2gAiG2ePoGHaf1p0WJJ+g
	XjUPAnQxKODN7EhVeLRTpV2ideCgumbAbGJu8aH5gSQutkbOHThcIcbWU9vN98SubU1YDYwBB5W
	aTyRPDrymRLHi1T2k+ymop7Qyq8rwICYOpYsv46oxNiC5Ye/dTD4TR5OFI2BVZ/
X-Received: by 2002:a05:620a:2589:b0:937:6ed3:78d with SMTP id af79cd13be357-93960f3bc9fmr671598985a.20.1788362127204;
        Wed, 02 Sep 2026 08:15:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 8/9] libsemanage: search /run and /usr/lib for semanage.conf
Date: Wed,  2 Sep 2026 11:14:05 -0400
Message-ID: <20260902151406.54168-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanage_conf_path() only tried
<semanage_root()>/etc/selinux/semanage.conf and the un-rooted /etc
fallback so the file that carries ro-store-root could not itself live
in the read-only vendor tree.

Search the same configuration directories libselinux uses:
    /etc/selinux/ /run/selinux/ /usr/lib/selinux/
overridable via -DSEMANAGE_CONF_DIRS=, rooted first and then falling
back to the host directories as before. When none exist the primary
/etc-based path is returned so the caller's diagnostic message refers
to the canonical location.

With this a vendor image can ship /usr/lib/selinux/semanage.conf and
leave /etc/selinux empty.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c | 60 +++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 9bece5f2..10919ed5 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -539,6 +539,16 @@ const char *semanage_final_path(enum semanage_final_defs store,
 	return semanage_final_paths[store][path_name];
 }
 
+/*
+ * Directories under which semanage.conf is searched, in order. This
+ * mirrors the libselinux configuration-root search list so a vendor
+ * can ship semanage.conf (carrying ro-store-root=) alongside the
+ * read-only runtime tree. Overridable at build time.
+ */
+#ifndef SEMANAGE_CONF_DIRS
+#define SEMANAGE_CONF_DIRS "/etc/selinux/", "/run/selinux/", "/usr/lib/selinux/"
+#endif
+
 /* Return a fully-qualified path + filename to the semanage
  * configuration file. If semanage.conf file in the semanage
  * root is cannot be read, use the default semanage.conf as a
@@ -548,24 +558,42 @@ const char *semanage_final_path(enum semanage_final_defs store,
  */
 char *semanage_conf_path(void)
 {
-	char *semanage_conf = NULL;
-	size_t len;
-	struct stat sb;
+	static const char *dirs[] = { SEMANAGE_CONF_DIRS, NULL };
+	char *conf = NULL;
+	unsigned int i;
 
-	len = strlen(semanage_root()) + strlen(selinux_path()) +
-	      strlen(SEMANAGE_CONF_FILE);
-	semanage_conf = calloc(len + 1, sizeof(char));
-	if (!semanage_conf)
+	/*
+	 * Rooted at each configuration directory, then (for a chroot
+	 * build) fall back to the host directory.
+	 */
+	for (i = 0; dirs[i]; i++) {
+		free(conf);
+		if (asprintf(&conf, "%s%s%s", semanage_root(), dirs[i],
+			     SEMANAGE_CONF_FILE) < 0)
+			return NULL;
+		if (access(conf, F_OK) == 0)
+			return conf;
+	}
+	if (semanage_root()[0] != '\0') {
+		for (i = 0; dirs[i]; i++) {
+			free(conf);
+			if (asprintf(&conf, "%s%s", dirs[i],
+				     SEMANAGE_CONF_FILE) < 0)
+				return NULL;
+			if (access(conf, F_OK) == 0)
+				return conf;
+		}
+	}
+
+	/*
+	 * Nothing found; return the primary path so the caller's
+	 * error message includes the canonical location.
+	 */
+	free(conf);
+	if (asprintf(&conf, "%s%s%s", semanage_root(), dirs[0],
+		     SEMANAGE_CONF_FILE) < 0)
 		return NULL;
-	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(),
-		 selinux_path(), SEMANAGE_CONF_FILE);
-
-	if (stat(semanage_conf, &sb) != 0 && errno == ENOENT) {
-		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(),
-			 SEMANAGE_CONF_FILE);
-	}
-
-	return semanage_conf;
+	return conf;
 }
 
 /* Recursively create a directory from a path string.
-- 
2.55.0

