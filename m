Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEE36F916
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597723; cv=none; b=js/MZYdmEapea27UI24QP9H3ri6PsRgU/ZTKZxg06DJw8HYB7evSO3MmxeJ0/10TWidnWTdwkNoUwZzeNgnQzjpoQXlPA5Zx6fdRh0Cy7ylBSa7wArIZxmNJYgh+L3lrIp7hgViHA3PlEIK0hvtteeR4fo/wRQyv9Pa0I5P8lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597723; c=relaxed/simple;
	bh=lwF75PcWjMPyoUCT7oIGXT18swh8rDbYVLyiUx9HdKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTBLBXUsC8RU3nqHhB0hAq34YNE4pLJ5zt5bO2v1dOzawMUav0mAiVtOJQfpJtWllL1UhMYVWKmvpqq9sJhN3c72hT5TMtXSoL4seEwCCCoS1zEsLufik7MpT2VSew38HPCPj3JijuCtNmV81lQiNIpapbQkeUdfHHEQ768ZgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC/hXlvg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC/hXlvg"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5174a3d9598so9669741cf.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597721; x=1781202521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftrF3Hbx7SeSMQR1MU1OWkXVlC6NjxcrDqsXne1en5o=;
        b=iC/hXlvgw09rNGN4Rz51BqFLOybnHHDFmd/jW7idK1U8Gmjf8ZZ6TJdxe7c86x5N7d
         5iRGJJZMjJDv8zy1sSAOMyICs1zgxGgqecsLI3rQBM6QOIrgPIQrtRguZ7fCkYnHgyCs
         dTrPfjt19ggjVDV2Ku45uIdinCXN5pV/n/6TroMbXOTpNMNAzPMvbXRbZXREWgVrT8wc
         4cL4EwC2nMJ0hGB5VN+AaGW4jiA9OHAuYEFRB4qs844/KpXOnR6JXphJ+yRrxmswU5iB
         DPngaAz3tBCDwk0J23jeuSm7RCmXU0JFKZpq4LaKmMPZCd961KO1hyOY5UcqQbM5czJJ
         gacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597721; x=1781202521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftrF3Hbx7SeSMQR1MU1OWkXVlC6NjxcrDqsXne1en5o=;
        b=lFnnalz+3ZW4i9B8vCzx4Mg+IsgpWUiz/3yYEw08M3FIIZStB+cRz3/QM/jz+ZoFrT
         gGYR9s1wPw3DwO2M+TCwCyTUrzsWydyEQ8m6Xu5koq8WF8EuCL9Um5TfJONenfazHixF
         mXfJZhofzq6/5FeTkUaRacc9d+rHHJEvFOfXsQTPTHVoeMdF/iRfgF3mN0q4kexWDbtV
         8xNU5w5WuD9+Y4rbqqNpJWyDkZdCheorHKtvhXL124Z7g2NFv69YlPlokNmNBPkDkIRb
         RPL1kJkFnzoxneAk9zHU8Hh0DxUtCacAOv/cTHTqm0oTVc8yXsn0HKK7rgI6sVyVQIsa
         pKQQ==
X-Gm-Message-State: AOJu0YykAQUEnyTJGbAiOnXcj5SLxZFd3dQkCb3CGkQi/ysDjOdb67rK
	WfzPbOwS72DNm4VADnsMLrtaaUYqFE+xqiFp6PdUJzpIW6eeQlZ/0Q1B3SIH1Q==
X-Gm-Gg: Acq92OEpfHce2hyPzcZDogpfDzBG7bkKYPYW9fWymbMMrKw2hTZE3NfNh8VpTUYI8QU
	nk08yF7iRDrGZEKAITo/Xnv37onv0PGkVrD/tLPiUPlffdjIMQoN8McNhyV38+73O3qalYB0iDs
	czLmMexOfqL52abeUlRdptsH2a1lNL2JQ8la3eIAEYg3ToMGFNkXi+SZjtBjxhOi3Ios0Glrm45
	DiHjiC6iAkkP3x2e1hTPWw2a8NO8IL5d0ckfwErnB08aPn7Xc51l7cEp2LBCSDQmhBWvkdvBjtQ
	Zb7mSHX2uvMhTwjTQv96Pm2fPyXqE8N+u+hOKtGcNp6Fw9l7jFJKQJpI6BwHwztSfuTo4FxF29o
	CbtMQ62ri3xIWfp7ousDeCSOb+EGMX2+nDEZUKkDsAk5KuTfqOwRbd/lrulHYlvZRWWpg4B1nLH
	3DX0naCKMXiHG3VEY1vQqtSDqyUfq6Ebc90ZCh6wCVhjxc9thWx+Sk0AOseoKrwiKrdjCRN9jzG
	JBkc2e2JlSu4BCyM0zyUKQF+C99AfqGQXEEXg==
X-Received: by 2002:a05:622a:5c17:b0:517:5ffc:4a11 with SMTP id d75a77b69052e-51795afdcdemr191041cf.36.1780597720389;
        Thu, 04 Jun 2026 11:28:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fe25sm60258856d6.3.2026.06.04.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:28:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] restorecond: delete unused code
Date: Thu,  4 Jun 2026 14:28:21 -0400
Message-ID: <20260604182822.265426-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604182822.265426-1-stephen.smalley.work@gmail.com>
References: <20260604182822.265426-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused functions and definitions left over from when
restorecond was split from setfiles.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/restore.c | 73 -------------------------------------------
 restorecond/restore.h | 12 -------
 2 files changed, 85 deletions(-)

diff --git a/restorecond/restore.c b/restorecond/restore.c
index 23c2c98e..c8437f4e 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -54,76 +54,3 @@ void restore_init(struct restore_opts *opts)
 		selinux_restorecon_set_exclude_list(
 			(const char **)exclude_list);
 }
-
-void restore_finish(void)
-{
-	int i;
-
-	if (exclude_list) {
-		for (i = 0; exclude_list[i]; i++)
-			free(exclude_list[i]);
-		free(exclude_list);
-	}
-}
-
-int process_glob(char *name, struct restore_opts *opts)
-{
-	glob_t globbuf;
-	size_t i = 0;
-	int len, rc, errors;
-
-	memset(&globbuf, 0, sizeof(globbuf));
-
-	errors = glob(name,
-		      GLOB_TILDE | GLOB_PERIOD | GLOB_NOCHECK | GLOB_BRACE,
-		      NULL, &globbuf);
-	if (errors)
-		return errors;
-
-	for (i = 0; i < globbuf.gl_pathc; i++) {
-		len = strlen(globbuf.gl_pathv[i]) - 2;
-		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0)
-			continue;
-		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
-			continue;
-		rc = selinux_restorecon(globbuf.gl_pathv[i],
-					opts->restorecon_flags);
-		if (rc < 0)
-			errors = rc;
-	}
-
-	globfree(&globbuf);
-
-	return errors;
-}
-
-void add_exclude(const char *directory)
-{
-	char **tmp_list;
-
-	if (directory == NULL || directory[0] != '/') {
-		fprintf(stderr, "Full path required for exclude: %s.\n",
-			directory);
-		exit(-1);
-	}
-
-	/* Add another two entries, one for directory, and the other to
-	 * terminate the list.
-	 */
-	tmp_list = realloc(exclude_list, sizeof(char *) * (exclude_count + 2));
-	if (!tmp_list) {
-		fprintf(stderr, "realloc failed while excluding %s.\n",
-			directory);
-		exit(-1);
-	}
-	exclude_list = tmp_list;
-
-	exclude_list[exclude_count] = strdup(directory);
-	if (!exclude_list[exclude_count]) {
-		fprintf(stderr, "strdup failed while excluding %s.\n",
-			directory);
-		exit(-1);
-	}
-	exclude_count++;
-	exclude_list[exclude_count] = NULL;
-}
diff --git a/restorecond/restore.h b/restorecond/restore.h
index d7935e06..17f0bc37 100644
--- a/restorecond/restore.h
+++ b/restorecond/restore.h
@@ -3,13 +3,11 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-#include <fts.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
 #include <syslog.h>
 #include <sys/stat.h>
-#include <sepol/sepol.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 #include <selinux/restorecon.h>
@@ -17,13 +15,6 @@
 #include <limits.h>
 #include <stdint.h>
 
-/*
- * STAR_COUNT is also defined in libselinux/src/selinux_restorecon.c where it
- * is used to output "*" for each number of files processed. Defined here for
- * inclusion in man pages.
-*/
-#define STAR_COUNT 1000
-
 /* Things that need to be init'd */
 struct restore_opts {
 	unsigned int nochange;
@@ -54,9 +45,6 @@ struct restore_opts {
 };
 
 void restore_init(struct restore_opts *opts);
-void restore_finish(void);
-void add_exclude(const char *directory);
-int process_glob(char *name, struct restore_opts *opts);
 extern char **exclude_list;
 
 #endif
-- 
2.54.0

