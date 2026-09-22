Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA633563FC5
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093953; cv=none; b=eOqn2lsauRqd4o2NpJxr57amjxNriE4sdZiObs6TquwSAZCVZwH8PPBZL5AiTh5fJfOGTG+VUUuZIUX8DinVXPch7cKyBjGeTDXASSNldMlkBHjGMpBaHt4SQvAkaaL5uXUgDzrA69/uWSpIcR3CXVB9Xk43nyC2b4t1c4wkK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093953; c=relaxed/simple;
	bh=XvPtP2c8fmeZH7VfqVVBuytpk2Q614qWtLym/IIT7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPxZ+qUfUt5luiWcR654UUDcUfP3FjAFw+o7n6YmSY6sy/d/dMU7SDDQ4TNBZfAMfcj9ibNqii5ZiHNw68vEgtS/BgjcE+Uu41FxMF2ShSIa30iBwkGiCh6agBPrdJeXXqt23zmK8PC73rpv8fxxFFLdWpZqVSNRyImmDSBdMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/aw+nnT; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/aw+nnT"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb769ca02so981591cf.0
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093951; x=1790698751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibi4r6F7K2AJs3vMYzYotJMK48I8FGAno2SoaanFuGY=;
        b=q/aw+nnTgt95simmS1NGUGHm0u2FsS1kcCi+1P52KDqnHkjqApNhRDuBavWScko6sL
         24VU8het3mvdiwHmw8kEnCMJd8XkRaYAGmdL+ry+RN26quKGX2Qoksj6retUoO3zINiJ
         8YAJy6NFpTICPegrBpytA9E65m0h40lypQWGJpl3jm3Km0lpiv9hqIUxfhpcaz5ggi9+
         QA78pZcdjcZJJ4VygphJcK+ju4YmK+UJP0hy3N8EpbFXi4mvT58WaMrqh3QKN3ZZqI2q
         eP2MYl1ozFevpKxgk3hlle/SwokvjTx1HHYo9cx4bnu463CH2LR2FAvJHTVU27RVRsej
         hxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093951; x=1790698751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibi4r6F7K2AJs3vMYzYotJMK48I8FGAno2SoaanFuGY=;
        b=nBQYcmkErIOgFxEwBX0o/ZFODDZeCb2KSFbHbNkOy0HGjC3nMvySsLzO+Px0mDyI6j
         3FER0OB2gUzWJ7y7NiexAbRsZDAQlwlei5j4oGyuaf3lg4OMuU1ZQLYJa2hFh7NbzVp1
         6/jUDy3iW4TI+Kj3YRza/LGaqEpHoRhgptdEOViqWhAJ5L2Z0/waLEdzEmhmGtqD/ATU
         h82V4yXOzfxRx/ePXCziXzPQMfYnrR7YSOQedaaeHr/zJIEz8a4Dl2Nefzos4BtLO4e5
         qY6mzPrX4LMMavNNylvDWzrpLpEiyIAgoa414qXMyxrrSYsJfFmavIVQg3olFwi4Vjup
         LFBA==
X-Gm-Message-State: AFuF++kJ903gi4Za9qpS5z/ZLwHDTsC6IKw3Y/R4alBUJI7Z45B22XvR
	YDmdMTrmEQmByDys2fRvKuShWDxSl7CDuIlQbErb07cNojBzxFJMdEVI3ak/6A==
X-Gm-Gg: AYBFou37Q7Aoz8KIfH1PF299lBPVh7L+2WVqnhhPYksQD1dT7RPDnW/I3w8fwaalVAH
	q/NLUhL4FpFwurun86xDZYOPb+bTSj3UMjjjcc7CVQwV8Cq0/QrlnbLZM+2uUv4a45dr+hKohik
	+kS3UJKFXadWpvGvQhks4jy+iEFYF3Vq0QVvIw7HQ0wggdn+W+M3MowPY++C2WUnlQ0szRhOody
	nHxHl0F2Z4fAH1mf/kCyMtoUMGgL7/sTxARz/cbJhClPAmksTrVYG4F8Bh6X5n1LcUjeOBAHNz5
	xPzB2FwPuiot/gDyDCH7z3QPl3zj2egwnJuhKSwtOAcCwit36fhtpy99c7X/q1WRsk75znQ2MeT
	hj4cm4CI9FiJnNnLAo01+vPcGILcUUW46IxsO7wtfj9ADtg7iPSs5vjwMZZSN6YB5jvkqEjAUiK
	kShqJBtu0Ke913dHTrDyCEo8RVwG1pteywsxiGnhupUgucmAv0Vu/TcEMKBSD9O2cu8jwZcJDfQ
	yM8gu7JngWPYbfnH8uNlh804a/aWnQtAj1SYfSdaGqMNIN+6ShXOJShtcePieVcV+tP6sDcvrj0
X-Received: by 2002:a05:622a:8e:b0:530:e5f8:7f59 with SMTP id d75a77b69052e-532eacf13f1mr1342141cf.30.1790093950587;
        Tue, 22 Sep 2026 09:19:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb1e01a1sm113461cf.9.2026.09.22.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:19:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] policycoreutils/newrole: search fallback location for newrole_pam.conf
Date: Tue, 22 Sep 2026 12:17:40 -0400
Message-ID: <20260922161738.47551-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922161738.47551-2-stephen.smalley.work@gmail.com>
References: <20260922161738.47551-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

newrole_pam.conf is optional and lives directly under /etc/selinux,
outside the active policy root. On a stateless install a vendor may
ship it under /usr/lib/selinux; try that as a fallback so per-command
PAM service mappings are honored there too.

The fallback list is a build-time constant
(PAM_SERVICE_CONFIG_FALLBACKS) rather than a libselinux call for the
same reason as restorecond: the file is per-installation, not per-
policy-type, so selinux_policy_open() would not remap it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 breaks the loop if (cfg) so that paths[i] still refers to the
correct path for error messages in process_pam_config().

 policycoreutils/newrole/newrole.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 741d30a1..d1385142 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -100,6 +100,9 @@
 
 #ifdef USE_PAM
 #define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf"
+#ifndef PAM_SERVICE_CONFIG_FALLBACKS
+#define PAM_SERVICE_CONFIG_FALLBACKS "/usr/lib/selinux/newrole_pam.conf"
+#endif
 #endif
 
 #define DEFAULT_PATH "/usr/bin:/bin"
@@ -249,9 +252,8 @@ static int reqsymcmp(hashtab_t h __attribute__((unused)),
 static hashtab_t app_service_names = NULL;
 #define PAM_SERVICE_SLOTS 64
 
-static int process_pam_config(FILE *cfg)
+static int process_pam_config(const char *config_file_path, FILE *cfg)
 {
-	const char *config_file_path = PAM_SERVICE_CONFIG;
 	char *line_buf = NULL;
 	unsigned long lineno = 0;
 	size_t len = 0;
@@ -305,16 +307,23 @@ err:
  */
 static int read_pam_config(void)
 {
-	const char *config_file_path = PAM_SERVICE_CONFIG;
+	static const char *paths[] = { PAM_SERVICE_CONFIG,
+				       PAM_SERVICE_CONFIG_FALLBACKS, NULL };
 	FILE *cfg = NULL;
-	cfg = fopen(config_file_path, "r");
+	unsigned int i;
+
+	for (i = 0; paths[i]; i++) {
+		cfg = fopen(paths[i], "re");
+		if (cfg)
+			break;
+	}
 	if (!cfg)
 		return 0; /* This configuration is optional. */
 	app_service_names =
 		hashtab_create(reqsymhash, reqsymcmp, PAM_SERVICE_SLOTS);
 	if (!app_service_names)
 		goto err;
-	if (process_pam_config(cfg))
+	if (process_pam_config(paths[i], cfg))
 		goto err;
 	fclose(cfg);
 	return 0;
-- 
2.55.0

