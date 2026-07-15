Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97F2DCF46
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132453; cv=none; b=lTDcl73/s4dtiD2Vh6atAuRRLr08TWJLDJJECyopsZhWUs97k1hy/sTt92LNHYiWT7sqDO2PRgljjqD9E4eE/ppU/X3SY0249sDpG+uFfYuA+Cis1NQMmLVeniPM4M9lhZDqJOX9lgrn0oAc3cV6hxe2dHCrHuNwDB/ntiHHTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132453; c=relaxed/simple;
	bh=1DQ1j57I5kek4u8JhqtxYvKQrxtW+7fabrpxlAJkwvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNPwfm0qqTo48BXGF3hHMSMrsuxR/Bgz3hA7G5onQugIt0JREOFZLjf1H//1OVVBp7ZxLm0AahrwK8KA4M08H9xzTV5l2kp6DvxZ1PAQQ83lEEO+F+FHwyPDFlF9CXS0vAs7VVDuMEafEk48/ZyV0hLMxsTZpOaoKfNPtCRrTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5pvAUTG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5pvAUTG"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so344672685a.2
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132451; x=1784737251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AucMRsovifTOKYuh3fC2VU1zb08yvOSTXC5wuJxrw4=;
        b=G5pvAUTGhkUtclpjT3f/COhaVMS34M7C+wBUSQGslv689wWWzt4bj6HIn1zoF+tey9
         h0n82RRmBHQpAM5d0vGnHM4cTXrcS4UWXNGHqduK3HIPmNHkR0F8l4GXUuovSUPD2O5X
         A/a/uDWvnRXSzBGyHf7Xz0eG7++J06AVxXW2q3qh2QKNN0258Kdfmz5x1yIoYCmCCVM4
         JHKI6yGbtLPtvdY+H9RK9eEet6AJ4JZNkQx27loth8sNfKi+5y02xLrEMw++m4J0FUhU
         WFMAlIpS8ZG/kDuPioSB2BWR4s8NSUDNpoQK7r6/XpFEKUvmMnyZdjId3B3c1gNlb22o
         YRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132451; x=1784737251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AucMRsovifTOKYuh3fC2VU1zb08yvOSTXC5wuJxrw4=;
        b=j9rPqpX0AQVIGkNDBpo2B5+knWJoUN3E0UIAJ5jKNLkZ5ixANGF247XtHjUYLkgs50
         VHL3Vm0r1aEXwfamnDUF96bh/vgd22uQoDQzkSTHY1E3u/e2hIi3aKvlIQgOEkKvB7on
         ZLSa5virWJiybB0NtZP45m941BRDXza3RpFns/cHpbaE8mGFPTX0KHHSs+Kzf4ZCpUbz
         yX/NTpEAl4koqyGFFcJArLvmgi04F4y/UoY29Y/DIUix2JCcxC+iOq6IWz1i8T1MShTl
         EDW3Kp8/FbNSgsiONuj5b7GE073JaKllAxCTp0piHyCLOJ3J6s80O63rETldzTBvVrX7
         ZL4Q==
X-Gm-Message-State: AOJu0YyQe5/C+x7Fp+6AC5hlTjiuC2pcQyUsaTU4lEDob4C2z6cuflLs
	dmWfU//mqGxFDmT7l2hqz3dl7DvjsIN/y3Hor2ykdT0/Wp/shii6YjT04tbeMw==
X-Gm-Gg: AfdE7clTdEKGJqSYYy79z7cOdIkMNc9feRHhIru0OdULVQn81hrQLduLgsT2EJZ+OXs
	wwFeywbBG8XHZS/dWi5dhJjeLth1sIwrWezSw8rgV6mP3HM37nFOLur7RtZb/E5O/esnqDMHdiL
	eKVSwILheeZIzfIt9Q+8vPdDteUpmHXAxjJ8mSyVS7MZQcQG39O/+Ri4q3frXJ5Q+3R+PYb2cRq
	BmMWAU2E1YftV685SMfQY3foKvfUC/658/NP2Zr53Ok8ix8+YxRU4u+xKRHHjXZg2xnOd5vLVmM
	8GGlvqm6UrtxTNhgsVvST0eDOrgTxrmUi2I5YhZK3rBAn/zJhsRXkyaDd7NYLqrRhcVa1HX+o6X
	qnhtL73Wv8uder5rRRSD+sGxsA6hGt8CxWGWc305M4V9tG3MuIwrptU6WIzLEW9Mpd1Hv/UxREm
	wJC++mY01tKT1ioo7Wu54ou7YyZiOMx79gg/B96o0SnXYOA2iGuRJIWRe1vuPTPRstZKB4OPkK9
	xx4YHyIbQdFGuA/
X-Received: by 2002:a05:620a:2909:b0:930:84d0:fd3b with SMTP id af79cd13be357-930961c3c61mr346975585a.7.1784132451448;
        Wed, 15 Jul 2026 09:20:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 03/10] sandbox/seunshare: cap rm_rf() depth
Date: Wed, 15 Jul 2026 12:20:29 -0400
Message-ID: <20260715162037.42329-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cap the depth for rm_rf() descent to prevent hitting EMFILE
or stack exhaustion. Failure to fully remove the temporary
directory was already non-fatal and harmless.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index d0f3ef1f..1e7822e5 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -485,7 +485,8 @@ err:
  *         a non-root user: symbolic links to root paths (such as /root) will
  *         not be followed.
  */
-static bool rm_rf(int targetfd, const char *path)
+#define RM_RF_MAXDEPTH 128
+static bool rm_rf(int targetfd, const char *path, unsigned int depth)
 {
 	struct stat statbuf;
 
@@ -498,6 +499,11 @@ static bool rm_rf(int targetfd, const char *path)
 	}
 
 	if (S_ISDIR(statbuf.st_mode)) {
+		if (depth >= RM_RF_MAXDEPTH) {
+			fprintf(stderr,
+				_("rm_rf: directory tree too deep, giving up\n"));
+			return false;
+		}
 		const int newfd =
 			openat(targetfd, path,
 			       O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
@@ -521,7 +527,7 @@ static bool rm_rf(int targetfd, const char *path)
 				continue;
 			}
 
-			if (!rm_rf(dirfd(dir), entry->d_name)) {
+			if (!rm_rf(dirfd(dir), entry->d_name, depth + 1)) {
 				rc = false;
 			}
 		}
@@ -628,7 +634,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		rc++;
 
 	/* Recursively remove the runtime temp directory.  */
-	if (!rm_rf(AT_FDCWD, tmpdir)) {
+	if (!rm_rf(AT_FDCWD, tmpdir, 0)) {
 		fprintf(stderr,
 			_("Failed to recursively remove directory %s\n"),
 			tmpdir);
-- 
2.55.0

