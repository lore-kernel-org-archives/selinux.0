Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853182ED165
	for <selinux@vger.kernel.org>; Fri, 24 Oct 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293292; cv=none; b=jXpCoBovrUdaFhA4YHT7a3IVfUcYby80bSW3KHOR4Vo43p/CcIMUTJu2LSREE2iEdDv6rwDZEUqBqranYqfuRSxzMJ5xaT8PLSPUOKnLGxTrAFOW/2Hdmq0ER8cuytjdrEudcBoOrRok1nj0EdNAWxVNDpPxpXroJDkyUb3xrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293292; c=relaxed/simple;
	bh=scyFXidKF6tH3q3+wcDfdsbQpniJVT3Cy+BCNhSJdVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWR5hLzkoOXdNGolKP4HZ13SYiispapxdRwmLyI4gX0yiIaccE5BvO+f8jme3sK4vP584mzEBdr4egVSdqqhpvOkgbO7XoGTk3LdKCdHDS9d0j3EQNUKZHu036hZCc58mlXCvLApuUhcscEnbhc5W/RTTguVFJgApNWKWCaW5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/uwbimK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/uwbimK"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b50206773adso233187366b.0
        for <selinux@vger.kernel.org>; Fri, 24 Oct 2025 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761293287; x=1761898087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eof3l8FcbGs/LUz5LKy49+Ple9wtq5xYQDgdytpRc4=;
        b=G/uwbimKBfJ0JEmet/NhrGnOQj7ccN7IkklEtfGANHOERjpYind6uUwYHb8b1cLjnw
         DD2RfyqED3Q/aj7euOPDbwAEoovZ/wV5FzxyhzhrGmaoqsn+Kp2B4COXm+KllG8G8V6r
         OclhYguBXcljBxPbwfmLna0boXBNpTnAZfscN1qBXqAC5l3ZWgafcXwW7KyNO/YUlOBp
         g1HKtoUBN8q44x0gVxEzbUo6q9Fs7ChG1Mkel15KxtE5sWpxxjik1x0ob5CxNgyN0K2G
         WqkbLdLdkxFf0YVBs65MhtavSA8snMu5DgCb92S1pd0P1FZFZFIwcKuqOs4+tBeymBXy
         BcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293287; x=1761898087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eof3l8FcbGs/LUz5LKy49+Ple9wtq5xYQDgdytpRc4=;
        b=iQheRFvw6GY0dbCKQv5V/mjPFtASdT5ksTNauPgB1HoUPk/Ta9fJECt5d8TbpBw5hQ
         q0Sb34kJkmJjyG3WYGNEEPbLGagw34t0j3FnuKgwbQbaLoQpDp+aQWbwMmHAszrBme8x
         KEZqRvjR67Z+UQ0GAJnp1GYW3wyGtnD0A2HXuEGvzI6/egRm2YkLi3rxtVA1dT0onYCk
         vrLnoIMhv0HxDc1EKy+Et92yE03Hu/Z+tlQUK4nUZVbjQ51BHgtDdcEPD8SxzY6/4Dqx
         FSFXxvc1tmaV+uRccqOM43YhYzfmN+2kAzQU57KHFmUH1PvQeX5I5w+3BJ3mmWuJUYhK
         vzXg==
X-Forwarded-Encrypted: i=1; AJvYcCUBHHYEjeoEtYjApzCt+T4BTnJQzutZnkDVUp4jiAmWWY2y5EkV4cxhbK3j8XqGCVhubac8hsgX@vger.kernel.org
X-Gm-Message-State: AOJu0YyfddLpiWEe4Kb3xdO9ivlRUZjksSJEWkAexJhaC8TBk4BNRK0U
	7OEqEmIXhi8Vy+Xn5awupTYB6gPnfa7KQ8FI+V/0mtNLTcgdqf1VFZpM1vhArA==
X-Gm-Gg: ASbGnct59SWaBWIkhU0oIYWyk8bGXZUooG3LuGWZvj2U1tgwTCz1L0j/+uy0ZtDv6H/
	bUxnK39EUh+MJLiB77Q9SxV3LbcVpp3lt/++q3Z2DShc+knmx5jBfahQ+e+619zsBJPXQJ5w9Zz
	NgO5zn1WfE5QH3+Idc7cT8FV7zaLOR+f8L1qI4E6VAh8fseFikdC8WXkJyDJnxrqvnQ6IqV5TyJ
	+raBMX9p0Ox+au78Se7HuqGHwLXjjc5aPrUEbbHFvXkWYOex7vnYEj3epPO6X0r37eg3Xmdhtd8
	hAtWWLHLA1I07bekmhaGFA1ps+J+4BtOhg6Lm1zgKsSH/eR2A5WzamHaL4s4v20Xd/FwKdF10aW
	3R4pZ+e1QyeZUXFPVzDcprAqny+B++la+PIV131Dy3uR6luKTKo45Zw0j7XoFVvOdCjhlyGuM4T
	iUkoWXAiM=
X-Google-Smtp-Source: AGHT+IGTUhbBV5KUT6R6znGOhBHZv6vIVCa8SAx6CbMvY25Fx00AgQgve2tGJohbRJDJ3aIyuLQV8Q==
X-Received: by 2002:a17:907:6e89:b0:b3c:9bee:eb95 with SMTP id a640c23a62f3a-b6d6bade06fmr240410866b.3.1761293287246;
        Fri, 24 Oct 2025 01:08:07 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5130d517sm461321366b.3.2025.10.24.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:08:06 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v3] genhomedircon: cleanup parsing of uid config values
Date: Fri, 24 Oct 2025 09:07:57 +0100
Message-ID: <20251024080757.15618-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEjxPJ6fWTXOrD6Fhj=JK9xReGxMT7BzXF1PT5WXfFf07=Udtw@mail.gmail.com>
References: <CAEjxPJ6fWTXOrD6Fhj=JK9xReGxMT7BzXF1PT5WXfFf07=Udtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parsing KV files with a separator of similar format is fairly similar,
so we may as well add a helper function to make it easier to read.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/genhomedircon.c | 107 +++++++++++++++++---------------
 1 file changed, 57 insertions(+), 50 deletions(-)

v2: rename path to something more sensible (afterall, we are parsing a
    UID!) and move the free to later, just before both return paths to
    not dereference it when checking whether we actually parsed a valid
    number or not.
v3: handle the fallback case for minuid properly such that we don't end
    up always using a fallback if minuid is not set in login.defs, and
    return a bool instead as it's a bit more sensible for what we're
    trying to return. Also, check for ERANGE.

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 34056562..e91c64e6 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -308,14 +308,52 @@ done:
 	return retval;
 }
 
+/*
+ * Parses `file` for `key` seperated by `sep` into `out`.
+ * Returns:
+ *   true on success.
+ *   false on failure.
+ *   `out` is guaranteed to be initalised.
+ *   `fallback_set` is initalised to false, and set to true if a fallback was used.
+ */
+static bool parse_uid_config(const char *file, const char *key, const char *sep,
+		uid_t fallback, uid_t *out, bool *fallback_set)
+{
+	assert(out);
+	assert(fallback_set);
+
+	*fallback_set = false;
+
+	char *uid_str = semanage_findval(file, key, sep);
+	if (!uid_str || !*uid_str) {
+		free(uid_str);
+		*fallback_set = true;
+		*out = fallback;
+		return true;
+	}
+
+	char *endptr;
+	errno = 0;
+	const unsigned long val = strtoul(uid_str, &endptr, 0);
+
+	if (endptr != uid_str && *endptr == '\0' && errno != ERANGE) {
+		*out = (uid_t)val;
+		free(uid_str);
+		return true;
+	}
+
+	free(uid_str);
+	*fallback_set = true;
+	*out = fallback;
+	return false;
+}
+
 static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 {
 	semanage_list_t *homedir_list = NULL;
 	semanage_list_t *shells = NULL;
 	fc_match_handle_t hand;
 	char *path = NULL;
-	uid_t temp, minuid = 500, maxuid = 60000;
-	int minuid_set = 0;
 	struct passwd *pwbuf;
 	struct stat buf;
 
@@ -362,56 +400,25 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	     "Conversion failed for key " key ", is its value a number?" \
 	     "  Falling back to default value of `%s`.", #val);
 
-	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			minuid = (uid_t)val;
-			minuid_set = 1;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
-			minuid = FALLBACK_MINUID;
-			minuid_set = 1;
-		}
-	}
-	free(path);
-	path = NULL;
+	uid_t minuid;
+	bool fallback_set;
+	if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL, FALLBACK_MINUID, &minuid, &fallback_set))
+		genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
 
-	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			maxuid = (uid_t)val;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
-			maxuid = FALLBACK_MAXUID;
-		}
-	}
-	free(path);
-	path = NULL;
+	const bool logindefs_minuid_fallback_set = fallback_set;
 
-	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			temp = (uid_t)val;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
-			temp = FALLBACK_LU_UIDNUMBER;
-		}
-		if (!minuid_set || temp < minuid) {
-			minuid = temp;
-			minuid_set = 1;
-		}
-	}
-	free(path);
-	path = NULL;
+	uid_t temp;
+	if (!parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=", FALLBACK_LU_UIDNUMBER, &temp, &fallback_set))
+		genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
+
+	if (logindefs_minuid_fallback_set)
+		minuid = temp;
+
+	uid_t maxuid;
+	/* We don't actually check fallback_set here, PATH_ETC_LOGIN_DEFS is the one source of
+	   truth for UID_MAX.  */
+	if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL, FALLBACK_MAXUID, &maxuid, &fallback_set))
+		genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
 
 #undef genhomedircon_warn_conv_fail
 
-- 
2.51.0

