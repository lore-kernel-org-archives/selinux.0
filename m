Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED24B7143
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446661; cv=none; b=fkX8NZjIkIMwJM5Q/8gFe6Cs9wEmVh36yjcMa8xXJXWL0zmHvLHU/8iweC+tfxVWJqvj/A/tNsy/IeiHVf1OUdygxTnw2y+jSdT+8u4+swG3hK5D/pLeBz8huTKwzC9+wBcjNAyOobM4v2FRA0MBBiK0CmWjSBU/qfcczVxM/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446661; c=relaxed/simple;
	bh=Bmy4Hzc7TM5FSuZRBHrihgaxMJUpl6XiyTXNLTo4meE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlRmZ4I3Y5QCOG4Qyw5aGzsGq7WnxlRWbH0vELo4od/7H2A/o8TWTMowW7Uw38RQzwdtkcyVDK+/qxtcel4hNmjOxvVGoXcWLzX8RswieggE3o6kc5fXhDx6J6BvrCTzo9SzyKZADrEdDicAYPTBAPA1Y2+AUloBOde9UUbBuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scdF8txS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scdF8txS"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so30248721cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446656; x=1789051456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhaES9nLdb9pAAIvfeMf6ZrWLCPzlfVvYNmQFuzm0vs=;
        b=scdF8txSHEnu10Snk2ahaVru0V3dI1TXrIs8KcE6xbr7eyH3s+kBzn69LECTv0mTqy
         gOcNgr35kKz1PErPvdMUQN7a00xYLXMMo6f7jxo9g0BGhE/52EMg+YHusZ/Xxh/GqPPO
         WDc9/tXi30XcuzCyWMLY/mMDzASbjYCreuzHyTjBxToDjXAqD+p+FIfmWwl+q1ZRqIR/
         FT1aBp0Us/ii9nC8ER+gkSBNkHGl1Q4XahkR5LTk2MS6GEw3KijTCnCHvoIw62Ux2VDc
         iiZkA5jgfmlHp54OBgjWKqWK0Oi0hxx/qeoov4K9ddbXhHiR3MGkr+1SS2CdWcEw0o+c
         r5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446656; x=1789051456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhaES9nLdb9pAAIvfeMf6ZrWLCPzlfVvYNmQFuzm0vs=;
        b=s2dn7lEZsN7b56jMd3BArmcch3hoF7kVShYmZOTfE8V5zo8S07F6t1TVows8BzS72b
         pPuuxm8twca29D0picABHi223u1jFuqdQxnygXXTnGOSI9Mx7lPYIp9FZ1UO8Q6O62ul
         MkKwIVkbxfmRgVzGDRJasRZ8OxbgoJ16Ng2nXVyKG2GbpI3/yjtAZPxalFIDiPqZLjuS
         hadJf+IV3v4+DctR7AU3+5Omgoawd5HcBRQeFlvNn3VkgY4i83E8AaiI9lLS0h5skRhX
         07K8WXa2X4WZqaDFhCY6rgym5RC07pi1aEv7YDJRTBlcIgpdw0Nmxk8gANhc2qtnmpxQ
         10lA==
X-Gm-Message-State: AFuF++lzV8wB6u2Iv0vmAieqP0I/K8OEIcup0W+WSSYPxX/h8ZQaMwgs
	xLCYRuBt55qRGx5UBVLmiDhoB3GvfE6XxhSZMD/9KCiB7DV0h/uicLe6pSBVnw==
X-Gm-Gg: AYBFou1Xp5Pk+JKIb/zB1/MpcBghMTvBTFp8bRBD6JgDQ+RLJSnPWKycXF0NkRPRg9H
	Vr9rza6LKM3vK4dZC2RXsSweVU+90Q5ux8OpdNWuJ/2rmE5AEYZiz84y1NVtKu1MlGfKoaJFgvq
	DfVAnujc0A0/WD8RGnBUB5HtOLzOYPCTJ02TG8ybkNPtiRqWT3BF4pjTwtKW/iWuo8kbZS+Xtjy
	CWvcbUEOrmfQKTEQ1OOeZ36rs571I4aQrer7/XWbPfbwORzixyVHXC97EFmDfBteYEXIb96i2i8
	etWPyvhjfj7TuYTtPJxccTzbO7VJqFxXuROmbu4N+LIyZAI/fJZCUffiBozlCo4iFnDWnO27Dui
	xnpmdXLHBwEEMtCfAL7xw4Ow0Vc1hYzBY3XUgmqFLXnZ6I01l2p5jHHFljIqlPZD0c69SI6CNvu
	OAJaX120ixRhBTIKvMI8wEtH5VNr8r20maloRAsbTQKtOi2P9YI+kq/yHOcQwWCbH6YD211RyVO
	wYQtP2QJu0oftVrwiXm5FQuP3NzP8C4Iil4wGHbCZLTjB/QrLuisPKAAdt6Aq28
X-Received: by 2002:a05:622a:258f:b0:52f:aa6c:bc7d with SMTP id d75a77b69052e-53036cdae5bmr162638821cf.28.1788446651722;
        Thu, 03 Sep 2026 07:44:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 8/9] libsemanage: search /etc and /usr/lib for semanage.conf
Date: Thu,  3 Sep 2026 10:34:34 -0400
Message-ID: <20260903143433.19810-12-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
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
    /etc/selinux/ /usr/lib/selinux/
overridable via -DSEMANAGE_CONF_DIRS=, rooted first and then falling
back to the host directories as before. When none exist the primary
/etc-based path is returned so the caller's diagnostic message refers
to the canonical location.

With this a vendor image can ship /usr/lib/selinux/semanage.conf and
leave /etc/selinux empty.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 drops /run/selinux from the default semanage.conf search path and
example ro-store-root config since it is not required for the 
stateless use case and it introduces the risk that any domain that can
write to var_run_t can inject files that will be used by
libsemanage. Distros are free to re-add it using -DSEMANAGE_CONF_DIRS=
but if you do so, be sure to create and label /run/selinux correctly.  

 libsemanage/src/semanage_store.c | 60 +++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 9bece5f2..1e30d24b 100644
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
+#define SEMANAGE_CONF_DIRS "/etc/selinux/", "/usr/lib/selinux/"
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

