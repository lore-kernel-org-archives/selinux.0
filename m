Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9A2DE6E6
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780257; cv=none; b=GGl0KnRgnLo90hfZTILz/Y+X6Z5ioS39f+rt2JjH6zyKMpIiXIccPS7WJOrW4v63LbfxI4GCypxPKhqXuCMFwsFGV7kFjlpgpV6gXbC6Pv5bzE1XCn8yubipqFYTy6Ctaue9KWoFI0ZgFWfwmoAMX2ZTlzPPuffZqCPb9Y2EA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780257; c=relaxed/simple;
	bh=NgdshHJXkFF0+KdGeQTJvvQqE9u2ISnEpyfzCHmlY04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBMS9SLsvPRmOzbyHKNEshBe0SzGh0IrNzys4LxKyyW6yPUfd2vDKM0fEvwaBoaxUFbbLBvpl8Nz0chbKmkkMJJthghg4d6D7jIQl1boBjAYzKjmtYy3F4PGvW0jo0RVQTi50iEEdlVqKmdpSxNCqzaxjQknscSWAmY3OGDvNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4FriDFS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4FriDFS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so520162f8f.1
        for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758780252; x=1759385052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ywkV3yvUyGRR/CkYG4/PKEnoe5rsWEQoAUpbW96SHE=;
        b=H4FriDFSwr/fnz95IbAB/OqTbwgB+49W0hPnW6Q7YdZGdmknnZp0WOGlGEv35AMuRL
         etykKV1S1dMc7Qpsjos1S5nXoS7Kff0stzLXmIZTGxNwRFVZ1dnMnEAP50TjV18Bmp3A
         XD2xyk3mx9pE9W3vqAYQSDhpO7fmDDCGMJxbA/qBzEybMbeihcPTtbaXzC4w7RUI00tX
         1o7JxkiPDTk8EwMWRow9Bmkb1wfgSRZQHGYnoZfD1Kt8XEbLxWXLzEdN3b1p3ybScGap
         fyc4VEOmpLDBw3bUE9y+/tlBQPJHs2X51uQUsNGsUL8acZwojEjGhYODTtcUb/P8Anrz
         taBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780252; x=1759385052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ywkV3yvUyGRR/CkYG4/PKEnoe5rsWEQoAUpbW96SHE=;
        b=XAgLjjiUaLMh1eQ6TiQhqhq10bebz916Dwp4llaeiqICIX3r7dF8NdjDJ42iXW6UqN
         cJhBgR2e2KOiujok65W6m5yU4ZuIpnJwQnF3avEmvhtOFkimBkSPxG59m9Wla3Ms6XAF
         6cNhYk/granRK6iXm5lKgrNEMABudQ7SFy/zID7W0/ZSWTpCPXHLBDglnwN7w8DaJT68
         Wvxcvek8wqprUjr8PF3bqr3kSjSXB+d5hHFoPpdWBZHzMTQuA+1AP7V5gTJeNQKEk3s7
         7NgTl5j6+OM8eyAinndk5Yk9GNQg2kxS1yYokQXOJknlAXS6ZPZC4dC657aynyYEAJ4u
         ULog==
X-Forwarded-Encrypted: i=1; AJvYcCXaMzf2JPdYrUc+tNRqeIVYKK/5B60oXQ6cJnQj3iCnnLlGk9MyBZ9IJ7Au3Ppikk1rnSYV+W+V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37aLQ5+/SQn7BZDFj33MKxtB8kw8p5jfLK4AA7TnuIeIybwmM
	CD+35rKQvUcZoi4oZwDwDHgVgkX7dJtYmSGbuRW5onqSdwlQZxg1gFJg
X-Gm-Gg: ASbGncsj4IEEbC62YSgMc3xpA+6ZfSliKsO181ef77WJCTjglpnjFVeeVXaGuLrVXua
	aUgRQt3zQtswprJ9pmqOc1BuY8GD4Wx7uLrR75SjsPT/0nHYhlcUPEkcywoD+QMDpmCPnS0BzRt
	3+L34eWoWHrv63vqgaWDJF8eqmQHISlZsuzS78qAjrnJWO1NSYnuhuezUZEYXNJMMC+glYwu9/l
	piv1mucz8LVsjbDiz+Oo/R1T9y93a/InLdbd1uUkH14IQQJjAh6q8VlEdGFwbAoqYY80t/wEvEz
	bfan8hmRpUrWva8ZN5UAoGli+ixGfzRPSQqSKCHVbu3zmF8RE9qLmXJ4a/+d/ue9kQpRXv9WSnH
	SXoNjcmY=
X-Google-Smtp-Source: AGHT+IFSC6X/o4vhGMzf3Vb/x/iik2+Juoy+BXT8ZzfgZh8Q6PJ5LDqWIR7W137HnoSxmWV8+AuTYA==
X-Received: by 2002:a05:6000:25c3:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-40e4accc86fmr1941830f8f.58.1758780251916;
        Wed, 24 Sep 2025 23:04:11 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm1508874f8f.31.2025.09.24.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:04:11 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v2] libsemanage: get_home_dirs: cleanup parsing of values from conf files
Date: Thu, 25 Sep 2025 07:03:46 +0100
Message-ID: <20250925060346.906929-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
References: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atoi (3) is... bugprone.  It's virtually impossible to differentiate an
invalid value (e.g. the string "foo") from a valid value such as "0" as
0 is returned on error!  From the manual page:

>       except that atoi() does not detect errors.
> RETURN VALUE
>       The converted value or 0 on error.

In the case of get_home_dirs, atoi is downright wrong.  We are parsing
UID_MIN, UID_MAX, and LU_UIDNUMBER, which all have a numerical value,
without any validation that what we are parsing is actually a number.
This is especially problematic as that means that in the case of an
invalid value (e.g. UID_MIN=foo), UID_MIN is incorrectly parsed as 0.

Instead, use strtoul (3) to parse these values.  If parsing fails, such
as in the case where UID_MIN=foo, warn that parsing failed, and use the
default values for each key as specified by the manual page.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/genhomedircon.c | 47 ++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

v2: use a macro for the default values and error string

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 8782e2cb..34056562 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -64,6 +64,11 @@
 #define PATH_SHELLS_FILE "/etc/shells"
 #define PATH_NOLOGIN_SHELL "/sbin/nologin"
 
+/* fallback values */
+#define FALLBACK_MINUID 1000
+#define FALLBACK_MAXUID 60000
+#define FALLBACK_LU_UIDNUMBER 500
+
 /* comments written to context file */
 #define COMMENT_FILE_CONTEXT_HEADER "#\n#\n# " \
 			"User-specific file contexts, generated via libsemanage\n" \
@@ -352,26 +357,54 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		goto fail;
 	}
 
+#define genhomedircon_warn_conv_fail(key, val) \
+	WARN(s->h_semanage, \
+	     "Conversion failed for key " key ", is its value a number?" \
+	     "  Falling back to default value of `%s`.", #val);
+
 	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
 	if (path && *path) {
-		temp = atoi(path);
-		minuid = temp;
-		minuid_set = 1;
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			minuid = (uid_t)val;
+			minuid_set = 1;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
+			minuid = FALLBACK_MINUID;
+			minuid_set = 1;
+		}
 	}
 	free(path);
 	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
 	if (path && *path) {
-		temp = atoi(path);
-		maxuid = temp;
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			maxuid = (uid_t)val;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
+			maxuid = FALLBACK_MAXUID;
+		}
 	}
 	free(path);
 	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
 	if (path && *path) {
-		temp = atoi(path);
+		char *endptr;
+		const unsigned long val = strtoul(path, &endptr, 0);
+		if (endptr != path && *endptr == '\0') {
+			temp = (uid_t)val;
+		} else {
+			/* we were provided an invalid value, use defaults.  */
+			genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
+			temp = FALLBACK_LU_UIDNUMBER;
+		}
 		if (!minuid_set || temp < minuid) {
 			minuid = temp;
 			minuid_set = 1;
@@ -380,6 +413,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	free(path);
 	path = NULL;
 
+#undef genhomedircon_warn_conv_fail
+
 	errno = 0;
 	setpwent();
 	while (1) {
-- 
2.50.1

