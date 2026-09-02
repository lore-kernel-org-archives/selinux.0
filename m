Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E96351C2D
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357819; cv=none; b=TCzF5kNGPujpubfWxM/UXf7/wxsnVwK8PLJCFvbCfKGQsf2q+6sP0oXCz/P1L/YJ3WNrrM9xYTRHP1MGMOvWDULYO7AsprannJpgRcs5pqf6WDkreMiaTHa1jCDARuetuL9zXHCLT5zuoMC4YFbu1O1uMFZ1NXQXvcC2qMHX8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357819; c=relaxed/simple;
	bh=l2Z9/NloOg9snZYZ5/pJ9Np8NHLur40V4oVIgNlDs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8uMBd6LMhUitH2pBf9MTguwgD+dKVGcnH3J346dJc8dVUNXxJ9jy6TN4fJWa5PX+NBvmmEm2Vk9BO1hdza8NR2soG0iTyfls0WljKCGQuAdtIrpcuNd61yrtvRyvRjbe14uaFSUvMgbpX/w40a3Qn1KhaWmOFX9M9CjsWPSspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsdCte51; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsdCte51"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e7d9c747eso13589636d6.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357816; x=1788962616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pv1Ra2Pmk1UTYpmzOV9WGbzKnM2hNTAR8cUV4Nx5S2Y=;
        b=VsdCte51U+TlvScljqCDelrNv8uz1GoQThCALLm9AE3iwsQM7U1bkE9zno5hsNsAo6
         FPh9xcBJl62sAKAEsM7KVvGy5c3/5kenmUhK3JBko1oLRG9FkzhbARYsVtX+KYgJRsWQ
         f+3QlPq9Ip4HVYPW0KBJacdv86B9SVH08DhOXXvuW7xVgHxlKJpk+05tOTQ+isFlox8N
         8cnZEpxY8jvR4Is7HmUfRtUB5gLtEXhsIeOEleserxuSVPZHTcloAAPMfX/OcO/nMlOv
         tiTCDjBv3YZpM7lG2XdhtUdBcPRihdFx5/vJilCt3q2RbXxpqhWYcvGbHnwO/kAglm1+
         mOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357816; x=1788962616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pv1Ra2Pmk1UTYpmzOV9WGbzKnM2hNTAR8cUV4Nx5S2Y=;
        b=ntPVVA4tekgXmIMswl9a339zCpYBURClf4B4dUsTkgo1my2zXzfnBr5hYBg8WCy9v8
         F1NbI34lWiNuGWU+7LgULZuH+4pYH3hbXoMGN4ZBZ2eH/fumnvHOziP3KvyqDAAw7+XZ
         MgwO6pNsIGwscOq3FbjX9gu4dI8qoq+URxP7uAiWnHzMJkRGtYl4apmAOkC63NhgDk7A
         S+Eyd0E99AmrvQJvYkL3U14qPRh9MWRZq252tYP7R7cE9EUBt8GkpnOoyunUxpYFLL2s
         JU5sP/mYXnyV64LK2hQnMJFMUAACTEyXRQo/7RqloVXwdOmhPaXFV7komrReJHo9UwwF
         nxBg==
X-Gm-Message-State: AFuF++nYiQvRhJjTV+zra4angvF8JTZ4+4bRyDohB8frFYY8Nb/fcU3/
	AW9u/gaMxgL1xhBMwu5rIsIZUL3ZFCYz475y+qtdOgVUuAt9yPZd/nqAuUuQMQ==
X-Gm-Gg: AYBFou3bK69NEtve599jcsmP08YIvH2C2Lw/EskCHBLo1SnDDnYxN9c2MmuD5BU0E2T
	HpoAXHi5LBCwByxfSwqlvAD/zdyD4i+ziJA5ZSSIWrRI+9+f7Dl9/kYKHx8hkWaZpZY8nsXCcud
	JT/kfXNAOR2MkcoixcvTXCzQ3MC8irJaLrFXwWGEVfQGhfjrajRsurP0Y3AUKkQBrwXWZhORjTJ
	WoD4aX956EGlXeKKnH0HWhgUbTnm3emVruU1C5jIKLLJsNcEQTU8/uuUZccDNttPmfz56S8pFf3
	03Eg5TuPRSQWbLZDvznGq0Fwp5Sp5bGDebBJifntPXlaROx+LMwbWi5qi0Nj2Jp7gF/QAICKs2B
	p9LgyVLaaIovWAKhmrrQL/YOT0Edn0pXHqauTZqEJAUWXcF8WMfDdShRhOCgK+JXwNsWatNj+no
	eOn1wRFqCH5riGxSZyvHEsKnbxr/BHxxaqwcYtnLGfLByQ8rL325p5Oshi510mlVthfc9ZY9GDt
	3tR0JrlvUzG2fi9GBfVivqECdgmQONXzw8QFCQvO+H6Bu52yF/kso+OUFvGTari
X-Received: by 2002:a05:6214:2264:b0:907:64a4:ca00 with SMTP id 6a1803df08f44-90e9f238b68mr69376776d6.10.1788357815926;
        Wed, 02 Sep 2026 07:03:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 8/9] libsemanage: search /run and /usr/lib for semanage.conf
Date: Wed,  2 Sep 2026 10:02:10 -0400
Message-ID: <20260902140211.53084-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
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
index cdf4cf17..9a1bd4a1 100644
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
+	if (asprintf(&conf, "%s%s%s", dirs[0], semanage_root(),
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

