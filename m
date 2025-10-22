Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A017D2
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091282; cv=none; b=DTaYIfh375N2zx9BC0zpqu3tHZUF99JAoOu4UKiJGwfaHwId0p0I9ILBjkFpmg1yEXTGuV6K2iebuOPcLreDGJiBvNiGHroKoH8V8nAi+U+3LIAev4ZGGkpsnufKohnrAJFJTrGYXM82Rf0ORPDjxPZ+HG6BJMq2AR/GknTgD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091282; c=relaxed/simple;
	bh=NvQuUGp/83C3Kja2Yt4ZKioDYcN4WIrEk8XrXi4+LEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqbdbWj1ZGQsdmGTPglfj90qDyHKGcAC8XRtBQ38cR6Vo+Z08G88J6uwPVv8ooz3oNXxyVrHBhD4zb9m711X/8IPDOfecg0BWMpPvRlvmFlo3DnbSzwuDPRasWl3XDekAqgmqKwe+Gc03ZGq7LOY4bzZV+tLZn6l3omXlzpNopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnfiX4Nc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnfiX4Nc"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b50206773adso95919366b.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761091279; x=1761696079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUWMjW+J0WNe1GxUHMvM+rAyiNNM4eHi3vBNv/9ss+Y=;
        b=TnfiX4NceKkW08QVfrKGiwiGA/tabS38cOHQP+zrzomThcnyEkQrl+ANRxMQNPkfkV
         k6Zt6pnfONtk15r5BRC6tUXmKIBPkBVlDipR42il2d+yricbWbIx3u8NnFaVrROHaWW1
         65aW12G/tNppwrxjn9OIC8+5gVVXL7fIfKqH0s4vksDI1xlhk0X8Uba5+4x1fEC8zWGX
         HcNAtV2cTQEnlqVFmd3DGZxIlatmASsrLdptN/5QsZTK+CkcxkefpP4HBSIxbyX6aW1a
         9yAeM21oqs4JDupo6QkkHeFPBwD5opfxWsHVp51DO+gOvDJ6gq98yBV+mrLTOqgzzGU4
         1LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761091279; x=1761696079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUWMjW+J0WNe1GxUHMvM+rAyiNNM4eHi3vBNv/9ss+Y=;
        b=EU2bUM+D1WHRNa9LQFHhjY3DFy92xBvauZbVq1vReOMQDVescwQ5D8KA8j2GHmKIAw
         mgkxZczg9R1R8S2Ez6+jUjd2KHJhXQ7tIRz7AIicn1v4TVIQIVLnwIuXBmrPIrCJ9xBN
         rIV5J3m2kAmwL8DA3Xzqx7UtzuP76KVqx8P5ACHb0k/LFgjdVuzMiXUXi/RSRr2iqPQB
         A/RuLQhRT2mEKVpzWigR1JYEbihOLLR5jVKZL6C25a2YmSCXu3OYe7IiMLKxbvKNVSEM
         9WEi5qFa6Wgmqv2PrJC0QS947kJirAGjqNa9KJWpr8IENMmGCGLVuB8JJY50YDNYc/Tn
         Om3g==
X-Forwarded-Encrypted: i=1; AJvYcCU0NXm2Kznsw2GhbVjrbhEzq1z124AUTeKlGE7QOXuyv1x0LmorzU1zFqbkBNkB12LH9eJMSLdJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9hs2XVsEWDAvGdm8z9YQmXkgJ8uzg20eEcMgfpHzgOaksOXo
	e6Bl1//oOhFIMj4j9wjl8aHo0OSGJEavW8uwQV+6f+rJAUEW1Uj/pAy5
X-Gm-Gg: ASbGncto30Vw6m0AmeWQz9bTVrHt8WtRcH1S0uXzOA5qd/ePmdz0miZQYrww/Eg9HbX
	ouSOiLo/iCdHrEyJwK+ppICikDvEYeurBKa4cPjpwzouxZCE6sWFDh6mFSJvo6lilJb+HzZKGpz
	6CFeot66eRlblVJ800X7LwDzaIljTV97OSOGC57kEaoZd+VU1yTESi6FwycC33iRL6HGbGNdSVX
	C/JUCkhI3WhpcbyAIY+MtEjhHcpYTZ8OvzgeKDFOGmjbiEm1hshWZA7Udsd9gv1zsYWZO7eN4hp
	4lPAFMI4bTWpuGot4+gzFdmswMTCCnBrlEq5yIK2luMjoAr8L9bYUsg9j8PoH+i8TleMF0CIUyU
	zKNLxrZeApWIzf0lmi1FQq/obUbkdt3ABQYDz3MZE6FhSALoSRVtzpab98M4Ulr5mdj3IkDmteS
	FMNws0Yzk=
X-Google-Smtp-Source: AGHT+IHs4lIkS8plxxxlucaf2/6ROq6ueG31pou4VhGY1S9klfqCF0/gMcbhRVTr/fm7FDnRKtvEgg==
X-Received: by 2002:a17:907:1c86:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b6d2c7526b3mr219607066b.16.1761091278583;
        Tue, 21 Oct 2025 17:01:18 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1176014366b.31.2025.10.21.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:01:17 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v2] genhomedircon: cleanup parsing of uid config values
Date: Wed, 22 Oct 2025 01:01:05 +0100
Message-ID: <20251022000105.54945-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEjxPJ7=xQBqEp+TWs8GEr_Oi_-t3MaW9cUh0TE8i1F7qWZ0jg@mail.gmail.com>
References: <CAEjxPJ7=xQBqEp+TWs8GEr_Oi_-t3MaW9cUh0TE8i1F7qWZ0jg@mail.gmail.com>
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
 libsemanage/src/genhomedircon.c | 82 +++++++++++++--------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

v2: rename path to something more sensible (afterall, we are parsing a
    UID!) and move the free to later, just before both return paths to
    not dereference it when checking whether we actually parsed a valid
    number or not.

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 34056562..bb840856 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -308,6 +308,30 @@ done:
 	return retval;
 }
 
+static int parse_uid_config(const char *file, const char *key, const char *sep,
+		uid_t fallback, uid_t *out)
+{
+	char *uid_str = semanage_findval(file, key, sep);
+	if (!uid_str || !*uid_str) {
+		free(uid_str);
+		*out = fallback;
+		return 0;
+	}
+
+	char *endptr;
+	const unsigned long val = strtoul(uid_str, &endptr, 0);
+
+	if (endptr != uid_str && *endptr == '\0') {
+		*out = (uid_t)val;
+		free(uid_str);
+		return 0;
+	}
+
+	free(uid_str);
+	*out = fallback;
+	return -1;
+}
+
 static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 {
 	semanage_list_t *homedir_list = NULL;
@@ -315,7 +339,6 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	fc_match_handle_t hand;
 	char *path = NULL;
 	uid_t temp, minuid = 500, maxuid = 60000;
-	int minuid_set = 0;
 	struct passwd *pwbuf;
 	struct stat buf;
 
@@ -362,56 +385,17 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
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
+	if (parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL, FALLBACK_MINUID, &minuid) < 0)
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
+	if (parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL, FALLBACK_MAXUID, &maxuid) < 0)
+		genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
 
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
+	if (parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=", FALLBACK_LU_UIDNUMBER, &temp) < 0)
+		genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
+
+	if (temp < minuid)
+		minuid = temp;
 
 #undef genhomedircon_warn_conv_fail
 
-- 
2.51.0

