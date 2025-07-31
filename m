Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191135971
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989179; cv=none; b=PLo3EzDyyoie/sDoWJBEG2LzIj/56p/5ArXx+manPBOrZSS95NVskJjVbmBTihfHBHHRdko4UE4lVlnoqRmkLZQnEavOpgZAvHwrW4Km+5zsPHbRDo6fl/O+aUzHr0oTs0A2UWQDT2SS5xJ8EbvtaDST+hL3xxYP5AgTuCezzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989179; c=relaxed/simple;
	bh=PobyZq8q8gTLhIxMhAZdB5iVXIfpwSwerrt5aK20Z1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8LozZ/SsZK+7mBvWaZ78WYbxPJf097TkUfKyFF+gTOoLdr0FwDlQUIG2CNRUiUyeqZOLQ5kRRSMBQkIbaIIeUEH1oRS8jyktp36beKwGrbb8oWgVkchITWyzHpCkn70NsD/JmgSsBo2iNR7H4Gmyr0XLnhBwMuBG8xpJ7hSFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwSNn28Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwSNn28Z"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b79bddd604so609706f8f.0
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753989176; x=1754593976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLg8mfg+NSK7huvbzUce032z47AEJeJZ9ohAtC28rWs=;
        b=jwSNn28ZhKZABgNAkOEZEANHyaVokGDwch8HfcRk+7cfHGyJ6arn3SezTcx8IagLf+
         5/6TH7KQBOnDQ8ffVWBJN0irh+oXgpoLrIuiZeLIGUZ5DKkExH7oJaSWRBQpdErdHkUj
         X/bmz5v+IPiPk122JH1Y3lfzHIBFCMvrHanzBQj2i+344OGeuu6Le6ncXBsNCzhiaTFf
         +IiBD6oRuKMwcDA2Dd9M57i5rOi4dUg/OyX39p6VgEWzNfDGKnJStqidUrKxhpYe/yW+
         k8GA8FkrPuAnscYH2E6KcPCtV8zic9XhrcXuXaZdBzzUuoS+hYj6IrQXvxaeRzP5sZxs
         1lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753989176; x=1754593976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLg8mfg+NSK7huvbzUce032z47AEJeJZ9ohAtC28rWs=;
        b=LFDUIgrkg0WGnYN49Mx1YL2MhbkVy7Er/GTdw806o+mUyVQNLtZLtyQwvZiDOhBC1y
         ddM2kVBhZM+KG0Ur3bu4b7caHKtns6biT1abnTSLTQadPtBM1LjV9cHNPVx92ILLlkIt
         wR6ZZwAu5AcjowqHzKiX1DdXIcP/zCZshiQB6uUstj3pczpEXTd268CwPR9JHsRkfVJx
         Fz47iL09YqvdcdLzXSkHD/RHfsTTBTBU/9Hh1P1bfRYjtVetDS8IfqswXKhJAJHcLuPM
         jcXyiS7LolRZ1++rNzwZlHurTyqs8NQ9vRewob1N4b2xQvWpVw5d4Jw8GJMDA82ZZgBO
         qJyQ==
X-Gm-Message-State: AOJu0Yxj4i3U4VnZJUdyFZu1Aon3TlzhwAgyXBPl47Bkz0LR41LUhW4g
	mygqESOfthmNZd9xQSiR9X+MHJCa1G/sllZrEkZHA9+LUWosoZdVRWxm8aY63g==
X-Gm-Gg: ASbGncvY0c+6drWhfAD0dcXT/3ceZmLQY+58C5n3G6hyqe46zURcLvK1oxJ688U92S1
	1+VCwDHjnZ+iMCW26Etn0G9WmCBFpPwMWw2Hvl/AsrjOTFRlHVDlnhlN6LPDMbBi5XPcatJLaH9
	FzaJ45G4D+IRcQ7YLCgPaqupuvEFMVNR7eD8klN9SDrFQR7g3UcODxHCYB+iVCSaaE3DAxBrhF+
	MF+gX6NeKuLBf2T+/NkuzFoxgQs5xocJtZRSdes6hI69PFemzuylFeRjkYBNSsnRdp1+lplizwf
	dRaDyw2P/+WOlUBBJtqF2CmpeJ80vrudR1magxOyUAHa6eTfosTeb6PyJCHJjX0nG2jSc4w16Mo
	qSj12jsmBnwtB
X-Google-Smtp-Source: AGHT+IHBV8XoQSJrv12vEY42HMgpH0Jq4ctB92V/YGdhUUb7UUrJTxNiFuMub/3V9ZKm1K6ljzMHXA==
X-Received: by 2002:a05:6000:1786:b0:3b7:9c79:32be with SMTP id ffacd0b85a97d-3b79c7935eamr2985537f8f.45.1753989175402;
        Thu, 31 Jul 2025 12:12:55 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589f0803e9sm38145165e9.0.2025.07.31.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:12:55 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] seunshare: fix the frail tmpdir cleanup
Date: Thu, 31 Jul 2025 20:12:52 +0100
Message-ID: <20250731191252.1091439-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, rm is invoked via system (3) to cleanup the runtime
temp directory.  This really isn't all that robust, *especially* given
that seunshare is supposed to be a security boundry.  Instead do this
using libc, the API designed to be used within C programs.

Also, don't bother trying to delete the contents of the tmpdir and then
trying to delete the parent directory with rmdir later - for some...
undocumented reason currently we attempt to delete the contents of the
dir with dropped perms, *then* elevate perms, *then* delete the tmpdir.

This doesn't really make all that much sense as far as I can tell.  We
should be the only ones using the tmpdir, so we may as well just delete
the entire thing using the rm_rf () function with elevated permissions.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 sandbox/seunshare.c | 71 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 97430535..d1d96257 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -403,6 +403,60 @@ err:
 	return rc;
 }
 
+static bool rm_rf(int targetfd, const char *path) {
+	struct stat statbuf;
+
+	if (fstatat(targetfd, path, &statbuf, 0) < 0) {
+		if (errno == ENOENT) {
+			return true;
+		}
+		perror("fstatat");
+		return false;
+	}
+
+	if (S_ISDIR(statbuf.st_mode)) {
+		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (newfd < 0) {
+			perror("openat");
+			return false;
+		}
+
+		DIR *dir = fdopendir(newfd);
+		if (!dir) {
+			perror("fdopendir");
+			close(newfd);
+			return false;
+		}
+
+		struct dirent *entry;
+		int rc = true;
+		while ((entry = readdir(dir)) != NULL) {
+			if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
+				continue;
+			}
+
+			if (rm_rf(dirfd(dir), entry->d_name) != 0) {
+				rc = false;
+			}
+		}
+
+		closedir(dir);
+
+		if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
+			perror("unlinkat");
+			rc = false;
+		}
+
+		return rc;
+	} else {
+		if (unlinkat(targetfd, path, 0) < 0) {
+			perror("unlinkat");
+			return false;
+		}
+		return true;
+	}
+}
+
 /**
  * Clean up runtime temporary directory.  Returns 0 if no problem was detected,
  * >0 if some error was detected, but errors here are treated as non-fatal and
@@ -428,24 +482,17 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free(cmdbuf); cmdbuf = NULL;
 	}
 
-	/* remove files from the runtime temporary directory */
-	if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir) == -1) {
-		fprintf(stderr, _("Out of memory\n"));
-		cmdbuf = NULL;
+	if ((uid_t)setfsuid(0) != 0) {
+		/* setfsuid does not return error, but this check makes code checkers happy */
 		rc++;
 	}
-	/* this may fail if there's root-owned file left in the runtime tmpdir */
-	if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) rc++;
-	free(cmdbuf); cmdbuf = NULL;
 
-	/* remove runtime temporary directory */
-	if ((uid_t)setfsuid(0) != 0) {
-		/* setfsuid does not return error, but this check makes code checkers happy */
+	/* Recursively remove the runtime temp directory.  */
+	if (!rm_rf(AT_FDCWD, tmpdir)) {
+		fprintf(stderr, _("Failed to recursively remove directory %s\n"), tmpdir);
 		rc++;
 	}
 
-	if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
-		fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
 	if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
 		fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
 		rc++;
-- 
2.50.1

