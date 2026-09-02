Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DE48C8AE
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356767; cv=none; b=IqE6dzKj9UvLsuQdHyjd+wGMVpg5Y3QN6Wowp4iGZsujNm2TAKQnlR0Tqre/8UNc+MKFTkCD7NanOjN9WSImmTFJ5zjw6is3jf4e5haqQGKNaYotFJM5xjlz47KH9C4Z+buXSVGoIRo/VYQ2w6zXfLQE73bmd90sPqy1NQy3Vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356767; c=relaxed/simple;
	bh=l2Z9/NloOg9snZYZ5/pJ9Np8NHLur40V4oVIgNlDs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnBwTCTSV/PT6Hukn02lXXR08Uc4dSpSDKHHO8ONdDb56fcUHiZoSaMXjwg6TGsyfnlQlHrWFdVtWJyqBQ+OgqN4NM/Pzd/G+zWs6zmW7I+PgSYZuy9p1VDhyQATEUSJgPbfKd5u/otJrpWQACljZjmS+zEt2aP4RNzoGj8I3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVO8t9iD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVO8t9iD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfe810293so8795331cf.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356765; x=1788961565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pv1Ra2Pmk1UTYpmzOV9WGbzKnM2hNTAR8cUV4Nx5S2Y=;
        b=kVO8t9iDKldO6FYv46vq6wnXqvizB1Rx8qvCFQ+JriNCb++1baHpN/P5mu5Cq1CckL
         lnj4cnTwioq1QIgyEobcLiHTnT9wyGJLoPizLWBwF+ObgRapmVA00jEsx3pFl0qgOTlx
         RZCRyEYEhjbrNXWRpal4Zm+6jB56418xvn5Cmnq8k9sZ9rbjrZGw92/ZF2eyzGGAnEhv
         hTPzYZe+6Z1xWa/cWyrJt9yc8tCigjJY4ujjspQ/CpzdxckTt/ZJGlPaEDqPKeNxsuWq
         mInnx+FEVs0ueXo0PYwF1j6ILvSNG/cAf4nVQvX7boEWR3XCMrdKZKAT4Yp5db2VhbB4
         lEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356765; x=1788961565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pv1Ra2Pmk1UTYpmzOV9WGbzKnM2hNTAR8cUV4Nx5S2Y=;
        b=f0I28PQWkYi69YLSPNtUdPFrZQiQcTKvKN2uERz4QBhn2SldTaOgCJXjcBdmP20oVC
         DnyOFXaBMr/hlrFJc9OrTP+2YlJumVyVidTdRLghkSPDRBE/20xG1/47FIQlkK76WewA
         bBvXTK1OGqi53y6X8zJ0pr3xXBoWwGrexC2fAuD6q+P0J3t7rAgheMzyVIUXUbCzh3Va
         P2FOErH5yJM/ZYyXgW+3o5Ap5JDkgnpFmb9XN6iB1ZvsjXPQ2KIqaf/FvQsYD3i8S1aB
         IFibFzGD1VGrS98YphhRTUjg21pE2TYq39pPppfei3F9Gv1TbPcYYxS+cMsfH0vzCOZo
         /Tlw==
X-Gm-Message-State: AFuF++nPojHky8U1E+eCmd9SeHtwleEFgdXWSBz4IjR5Eld8lSJg1Tow
	WjNnAEqkrENazxKLUZJvGjZlbvMSzXEMdPVPb8IOMaX4yHJN2BrhcVr2VIYE7Q==
X-Gm-Gg: AR+sD13ySfvOmUhPReRn7L08nAxEOLGWtEMcOLp++2leVhjeH9yUmBLGYc/AtPdD1Oi
	NnZATU4vI3C9qE37TLtg1fIBEEE89STTmgMI3R2DQf3vxIwhKtaI8WFz31MYaU2XNL2Pv/EU1oa
	RABjmu78gp4xuWSPdZObWD/muZb1yWh6VFJL+qLwxi9a3WCp2g4kJUdoXCRNRqvJ4YhKAEqZIcK
	/2YZSMzK/OEblgdR58cAXP7vsreSoDeF9jsczWGGZFKb3U/aQvcuc8NE50dxSOM/ZQbMGizRrZU
	Zu+9+4W7v1R3Kh94bubZJCTZvoxBZVrDgVu2mcZd5beecRgD/oI6sha8OUeCoJxcv8+k95KnsrM
	f2yMAUKnf1LspsDSpMEH8IOyuHPqI5P9yWZCFzJZAUS580qYNukqev9J1LhCgNb4FIMI9IezMgv
	xpA1F+t0TB/eDnWWU0CSm7T0yQqkTytQmmCTyLif74cHUG5wJt4qsDVZUFNI/sPk8diaghMoqwe
	LbyHbbWk6JhxsH7hDNxOd9b1/IEg9MrfCcH+AUifc03j7PA/AkU70xZWEJYC+Ie
X-Received: by 2002:ac8:7fca:0:b0:530:31bd:98c with SMTP id d75a77b69052e-53036c29d4bmr47323221cf.12.1788356764868;
        Wed, 02 Sep 2026 06:46:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 8/9] libsemanage: search /run and /usr/lib for semanage.conf
Date: Wed,  2 Sep 2026 09:33:16 -0400
Message-ID: <20260902133316.51981-10-stephen.smalley.work@gmail.com>
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

