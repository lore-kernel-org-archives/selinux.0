Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428B55820F
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960558; cv=none; b=n/mEoDAKv61SPV112ccte1TA81iZLNyPldnkGrhlsrJcFQyuXviS5coMuheuqLTEz8+c84jyI30r7gGKlonQfPVUQf+lE7qNV+xl4mQiS0jTo22+KBMXE7Nd2+s6HdUP8/xnzI/cGU2IrTWoW5qbJPJaDLTfMwdOgzy28CluI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960558; c=relaxed/simple;
	bh=/JCunUKT7SIZWZXDrjUzmS7zVvsFjGrkUIOjIcnnOow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEuwPel9b0iopZEFbZ71Xzi3jkcGo16pmbcfGDy46NYsY28hRZgFWrI2PrQMZ2TRlBT3FwyMkDQkzLDrUX7T04HEGV4VFsp1iLURz7SwDq57F/foMFpBkM5fChJD+nspmXrg6jcLSpzyedd+7WiAVht6HZjMyhC6MkN5KGQ9kTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beUBJlTx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beUBJlTx"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a468f4c547so37007211fa.0
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960555; x=1789565355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSpGFth7dJMu64AIVpd7w7rlAothUfpOs/+CNj+UQro=;
        b=beUBJlTxUa4CeTGwY+GLQ92lN6tUw56GyDqpxUgvTbUy7uiskXJi2QnRtyZ175FKsu
         v4/v4BJvtIgMhMHz9G1E/iTrOdnZqzz3jvjRcb6Qk9b5je3cxgMcmW/6Jvd7uCpU2J24
         ZF43tO3lvechrAwACtnggZoth7POcW0B/5AnZ8xJ+jcB6Ks1WMlcAeGlC+KDePHk4xqj
         1B5UhU+MlI9nvddzPz9VIWTgxxjO7Kg7SmoiF1KOItJGWnnbrjkQsZQGrYWbxdDruFHS
         xkdjEde4xAFVrUP67yNrP6rWy4cQZ943J42zQxyDS9xOZvhayZ2rvF4hTFErnhjrXLnW
         bYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960555; x=1789565355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSpGFth7dJMu64AIVpd7w7rlAothUfpOs/+CNj+UQro=;
        b=kLbczaqt5xFY1VrIyw+nUfEdkYWof2WaHMzKpgq8r9E1UYWo8/A7Ww0DV1dkoNU/3F
         uoypCBxs6km7JQ0GKMSZlw+nnBgSZNAkCO0zUTRP7QB+8FZ7sjYTLqPmVmQwfP74T5Qb
         vARqSqCGb8vTsyOAg5wsHIAqr5edNZ3cdi2v3vmiLtRnvD4SzgheZaujANaDwQQtZoLl
         CeISPYo3iV3qcRT9r5I3MaPANR+sN/Tk+ncPQ1kUmlHaiiYYuERZdLc0Hu8oWUWl9PIl
         liVnQkfvKNIAVzfF3QzygWZ7Ys5ktwY/y/EkJrMvxbNpjluDzhr8iRLapQ9qGWQVFKZa
         S1ig==
X-Gm-Message-State: AFuF++nL0Y7fiJAajFhkKIKwcyfDvbhSsFMaj1usgTsBeQEbGKZB5FCl
	grLLhlJ4KREsqfTS8RuSWh0MhCBuvyU2bTrWGerPBYAG8Ur//IF/QS0YChBTrA==
X-Gm-Gg: AYBFou32azK5POQl+M3NdDQ/wijjR2qSPQlHDsyY/nTewM9Pj07hkfldEAF4vcSlYfC
	zx4KVV7pMCZQKwC3fzP9g2dfr3SZyQDECdY1BpI7QQZ+J3FxF6K+lrWEB4f4dDcLtNO7QxqWcrZ
	hBra6pbYjTwvbb3y4Go9KqTVUcWBMU7i9v6oa7FmFLrjHT3gtyl15m05r2Kd+x2oJHBMsDvH6lf
	pwhxf6nYc1dY+w650XBsrlvwTiw559B2iGxz29C6KfePynh1eUyKTtayO61HxRBwPKaXKxrfMpp
	f0upoT4kUxIhqLTpHQjvH5IlR5icxz/SinqsffO2b8ZyK7qScyS+YLSWxhic4MEbwUntpnJx8fg
	KkrFck2CcFV3wt4Hx/ssW9GiJc49bmDKpkZqfe3vT/LOzl19jLqLYb9vEII1TBwScbMAAVUKrgZ
	vr1n7craZq1FS1O+r3RjodLpeDx8zI5onrxyqcYg/xqYa6Jxyh32JOfxo9iMjVgcwPGpdVDUln2
	k6m7RBWM33cpZT27ajDaj5peM37LYe/QRIgkUwIO/71z2DUO2Nm1AfEp7C/KdX4y8IOud7dNvaj
X-Received: by 2002:a05:6512:b9e:b0:5b4:5352:e2b5 with SMTP id 2adb3069b0e04-5b616f0b514mr6138810e87.15.1788960554530;
        Wed, 09 Sep 2026 06:29:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b7e99b0125sm351185e87.61.2026.09.09.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:29:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libsemanage: fall through on an unreadable semanage.conf
Date: Wed,  9 Sep 2026 09:28:54 -0400
Message-ID: <20260909132855.29732-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909132855.29732-1-stephen.smalley.work@gmail.com>
References: <20260909132855.29732-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When searching the configuration roots for semanage.conf, check that
the file is readable, not just that it exists, and fall through to the
next configuration root if not.

This prevents an unreadable /etc/selinux/semanage.conf from causing
libsemanage to fall back to the built-in defaults instead of using
/usr/lib/selinux/semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 8aa1abc8..89e7456f 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -564,14 +564,17 @@ char *semanage_conf_path(void)
 
 	/*
 	 * Rooted at each configuration directory, then (for a chroot
-	 * build) fall back to the host directory.
+	 * build) fall back to the host directory. Probe R_OK rather
+	 * than F_OK: semanage_conf_parse() treats a fopen() failure as
+	 * "use compiled-in defaults", so an unreadable higher-priority
+	 * copy would otherwise mask a readable vendor copy under /usr/lib.
 	 */
 	for (i = 0; dirs[i]; i++) {
 		free(conf);
 		if (asprintf(&conf, "%s%s%s", semanage_root(), dirs[i],
 			     SEMANAGE_CONF_FILE) < 0)
 			return NULL;
-		if (access(conf, F_OK) == 0)
+		if (access(conf, R_OK) == 0)
 			return conf;
 	}
 	if (semanage_root()[0] != '\0') {
@@ -580,7 +583,7 @@ char *semanage_conf_path(void)
 			if (asprintf(&conf, "%s%s", dirs[i],
 				     SEMANAGE_CONF_FILE) < 0)
 				return NULL;
-			if (access(conf, F_OK) == 0)
+			if (access(conf, R_OK) == 0)
 				return conf;
 		}
 	}
-- 
2.55.0

