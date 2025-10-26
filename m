Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFF2FC881
	for <selinux@vger.kernel.org>; Sun, 26 Oct 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506014; cv=none; b=OfLaCIo/l4aJ2r1nuRB/nWbVElLtVy5H1m1oqk3Ywb8FfzvFgcaJHXRVFJGt87ZR10JAg5WY9TQRzBdfeyR9sFodMF6eGaurGpYUiVqAfaujnoDrdZ1bSM0RtZUIxta0qx7qQ4h24ECQbHpZjd+raz81Qt0F8UFuMPExKOXVeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506014; c=relaxed/simple;
	bh=1otbcRUMJp9mdDb3MpghaPHUzb6g/pfYP/1jqP1Snbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edp9ddiFU2VCtKY3IW8grZBrVfWtWtDm1jCs0esLg8BvDva+4deJ69myC1Lf8QNiMzsw5SRx6ZGECHZjsaGvsPeBbRWPtGxRAIJgu4v27U9wGVz68IGmthJk9m1JdwPYFlj5Mkgrj/yfLOz+ti2HEvCncoXBsfvgi9o0zhMONhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyqvsdX1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyqvsdX1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so606536066b.2
        for <selinux@vger.kernel.org>; Sun, 26 Oct 2025 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506011; x=1762110811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7l7TRwbCq/5QsYYPi9mD+G5w+CGf73vkh3wblTTt4Q=;
        b=HyqvsdX1pBl18Y9PXGzKcHo9RWYx4aZB4Cz+B5fbRLaSOTjooxt+yEEQsDpIKM6Nqm
         C1yUJqvQiv/mRSuvRYb/cFcrYe795T6swFJRyXaDQq40+GY/f+gfsl1Q/pjC3YEpF2xK
         RwmhUemJlsDe3TNMw0URQM4kxZDYmV+cjepdYQLKcVsSPgbNlGomsDaGqhf9RfZNZE+r
         rKwDFdx89stNlmfaesDYHe842SVR4s5Tuo9NK/+SlMcgS9l2+D3k8HWGfQGhcapF0cnw
         qoEeH2LwGpsba/XuFaqoNozqhJAmjLCLdo77VXm1S2xqZJEeGur5HYQKQJgGl9QMDYEP
         S8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506011; x=1762110811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7l7TRwbCq/5QsYYPi9mD+G5w+CGf73vkh3wblTTt4Q=;
        b=nqLP140cWx0L0zrC43Q5Dxt5tYlgJF63EX/nf4J408Wdwpih13tlrbXc/md+uDOucQ
         BnyDbCTNPobub4QHFQuySLhvE/h6vSHlKJjxdZ829FxOhVY0b5zeidyCpuQa8MWFmZcA
         nU6PoPvEI2+XmAxUnDXA8pr2Ey//OpE8UToSTPOKEgpVkeGz/0Anpo5kPLWUoDekEBVJ
         EW5bqIG+AoCkuj7U8G1y3JARcwi480NHJtov/tfnTnP7IhmqsWHJaJcTmdmV52E1wNRg
         muMjeJLPPVNagyCTeOKwLnR53+svw9MKex+NizBA/cQ6puOd7YIcjVfPFEtY02wjjzeK
         nF8A==
X-Forwarded-Encrypted: i=1; AJvYcCVIFlms+xKiZTFnxZ9zYPq8FMrt45hKLFbhuFutMPCb8VetBh7plLJsGGiNleHEf+YWF7Id3amc@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9PboEsShd39ZkI/Qg4XkcQ3GuzV/tGqIh5u726LO75vrS1Ml
	UZgKvi5RumfkAoXlQCuOqTadjcekhRBKdIpYiQXRqEWn6Az0kESEIjOP
X-Gm-Gg: ASbGncsKb5hAp+6RAbnarFiakzhCrJQFcyxIV5JoYrEVbBNuDeYvEbj7dSORVR/vvRm
	KEROIU3mUKz9/qwbPH5j2GJeAcxb3gFZSN1W7dbvGnPJ7LRYJwVr0LPNSYcSVBQfSgzkUd1YSsQ
	g/TkuB0dbyt1INpdS8XWmG9EpY0agbuuoZwV0WCReDiwtsN3986eyq6orF5st+8U7+fWZ7SPebG
	mjrPpRj8KOKFG31J53odbIb8AtvRWw5pbxob8okwBA4o4iHLcf+EpMdZ+k/BPavnozhhl5jYdbh
	0oT8Hlvov0pO6ROm0rAptFqYrxVdPWhCiehyads2Ps2S+u8Ec7Q78g8KtQjxrL+vTkIpnwdZPZV
	yXIPBJrMpwF+kgAoagsC2HDWwSndEZ7lA5ga3XL11XNJSDvLBKr0ivDoyo3MguMSwVZE0J4jcHB
	ceHRwL02g=
X-Google-Smtp-Source: AGHT+IF14K/mQ0zPAFVA8SWRmYpb16yDX0eCO+DeQ9NTjB0lJjFfQOoobDmuBm/OeNSHSTvPkrUQXA==
X-Received: by 2002:a17:907:d93:b0:b32:2b60:f13 with SMTP id a640c23a62f3a-b6473f42d62mr4281477966b.54.1761506010828;
        Sun, 26 Oct 2025 12:13:30 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm537595366b.5.2025.10.26.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:13:30 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org,
	hylandb256@gmail.com,
	"Hyland B." <me@ow.swag.toys>
Subject: [PATCH v4] genhomedircon: cleanup parsing of uid config values
Date: Sun, 26 Oct 2025 19:13:17 +0000
Message-ID: <20251026191317.28685-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEjxPJ6BxZV=sUxzfThj=zu2BxX5S43WHBhc2GUie+-V8QZCBg@mail.gmail.com>
References: <CAEjxPJ6BxZV=sUxzfThj=zu2BxX5S43WHBhc2GUie+-V8QZCBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parsing KV files with a separator of similar format is fairly similar,
so we may as well add a helper function to make it easier to read.

Credit to Hyland for reminding me to check for ERANGE.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
Reviewed-by: Hyland B. <me@ow.swag.toys>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
v4: add credit to Hyland for reminding me to check for ERANGE.

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

