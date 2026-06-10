Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395940B363
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098298; cv=none; b=PkrsA5g36nRtmjMhrk/dTr6Eew5ZAUPWdL2ieqkOZxo6xBZsPOLcavClVdAbiWEh+ZczmTcqlElhm1op0twM2e8ssbZhakHarZ/SYnB5LhmiItgYZGcMul7EQ94nNj2UnBGoyIfa7+qtDXQsA2v5rOWPHLbTfGQqoWXtyZWE3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098298; c=relaxed/simple;
	bh=KLFk7k5mff1NQQco18sES8wYR4u+gsu2U/FgRpNQEGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieImVjKwS5PVv8i6SH8YJwcOe/q4NjUi54zHtFSo87AMYlloBrTKsdVqm92VjAAjcFDhZ+ryHVOHWXC82TlnAZqxxXZsI+UFYNjO3Rc1TdF83i8Vp4cGSNGon9zko4nRDIn1qVAuntJTYei3u/qoR8SO58AeYIMvkmEdWoZc0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8xgdiwI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8xgdiwI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9158643e538so594699985a.1
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781098291; x=1781703091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOS3VlHkYRKWjvCjCv4D4+PXELTGeHg4Iyhn2zY1S/Y=;
        b=k8xgdiwIk0AqaOEjStInuStrd5nAmkUYGiSrnmncqIfwdoa0crmjGE+rkxJAmdPqnM
         B7hpizIXulQwdf1c1ulHJhalsmdz4CFuynYu/q2jWSI4QzqdqXOxQ1gTJA6Dj7uw3wl5
         +gEZJTxtLj7ezHb9+LtCFCgz3NJ9GmVkOkYH6eok5isLLpgICsdvlxb92QwlB+CwOXaO
         gynYd6H7D7jBKlOXtHogzm2TK5we/ntQmoN3DqOZYpoY/BrjS7Bvl3w4V3fcfTNMyC30
         1XRisDP+RO2W7feGxzIYfrg6BxmJ7Yj20a4Z8AuhdtRnefYjYVLz8akF52/O/zYvmU7u
         lrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098291; x=1781703091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOS3VlHkYRKWjvCjCv4D4+PXELTGeHg4Iyhn2zY1S/Y=;
        b=rBnexwOn2mjPKWN7h4RnuMD1RTOoFVH90ByCVllTaz8xcTHM9g0CGgUSgT7upp8DMC
         fcxng4brVnOD4oSY/Dhw7X4kpe8RhqaRZUf7rBVDtVTTWdKkHUAA/AwH1hWE6Wjj+GTk
         LVt8W1FE1MwffHaxUhAlDyxFK42Lj8zaGaYujPGFiKrY2ZiMU8PhBP/z5fAfDZk9GBrA
         4WCjAn+O5WDvD1qfqzyU08mjm/FnBnf31JIBbQrd9VdWZoYkAzVXFGKlgaSyacmcsoFu
         xR9cLkRFHOAXT7LZUBsl55x0qTMcuhQDLb2Imd5GUZrJDABfuvYK7FQnYw6fBG86E4We
         MbfQ==
X-Gm-Message-State: AOJu0Yy86OvYwHIyJr+PqSrP1hdnbnaRAhhjq+FZJ8+Zqt87FbO4aIvL
	RWINVhzKAB2C7iysc7MpWc737+gJpfDsYSuYKpIUoSkjqqwwd0aQV9b9Fh+fUg==
X-Gm-Gg: Acq92OFTe4GTkTknkMuSldUETZIsZsTtTtkS7v3xNXCYSP+G48ICtLS0rdmIXzd1Wly
	G22Pi2c4jd5F5J89XdveL3s+ZMOG3/VMyM8y7b9N96v9Wk1WnKLcA68MnMMBNlomtMzNoenUdb/
	Dp8a+uRc9bDlhUZw5viY+r7riBoBzmxDexPHLIfSNsObKc0OkwqtHC43DBQBUlpmFkSdmGwZVmB
	6Vmq64NmubDRyt+8088KzVWFie0nTAVc0lojUrutMzpesjBnouWtu8gNWQxQWm0yHLPCtkWg9ca
	sAtlL9Dwjm0tSeERRrRs7U/BifDs//bZ6byInasnE74G5ivAotlt/RNRDIGXXEr4gxkbaGk27jN
	/mSLLyows83JJEP2m72l4HJaol8ULa9q1SRe/7KjGueKVxL5fds8wKdrfgycYGpwzw20dteSGUb
	jpitcMvLklYtf8cNXc6Xkp4yF9kWzFFVwCNUcKf6Jt7J2UCcd1hcwT7JlenMdpc54ZEYaQdcK/a
	xPT2XTV3fxcD48smr6Eozj6IxZ647qyj3KiAQ==
X-Received: by 2002:a05:620a:c54:b0:914:b65f:6abe with SMTP id af79cd13be357-915a9c29e62mr4072300885a.5.1781098283981;
        Wed, 10 Jun 2026 06:31:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a238f8esm2451305085a.15.2026.06.10.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:31:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH v2] define matchpathcon_filespec_add/add64
Date: Wed, 10 Jun 2026 09:31:09 -0400
Message-ID: <20260610133109.6726-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pepper Gray <hello@peppergray.xyz>

matchpathcon_filespec_add and matchpathcon_filespec_add64 are
exported in libselinux.map, so both need to be linker-visible
symbols

fix: #512
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 libselinux/include/selinux/selinux.h |  6 ++----
 libselinux/src/matchpathcon.c        | 16 ++++++----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index de56b727..105b47a0 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -508,11 +508,9 @@ extern int matchpathcon_index(const char *path, mode_t mode, char **con);
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the 
    file contexts configuration.  Return the used specification index. */
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64 && \
-	defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
-#define matchpathcon_filespec_add matchpathcon_filespec_add64
-#endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
+extern int matchpathcon_filespec_add64(ino_t ino, int specind,
+				       const char *file);
 
 /* Destroy any inode associations that have been added, e.g. to restart
    for a new filesystem. */
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..f2c7e561 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -280,25 +280,21 @@ oom:
 	return -1;
 }
 
+int matchpathcon_filespec_add64(unsigned long ino, int specind,
+				const char *file)
+{
+	return matchpathcon_filespec_add(ino, specind, file);
+}
+
 #if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) && \
 	defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
-/* alias defined in the public header but we undefine it here */
-#undef matchpathcon_filespec_add
 
 /* ABI backwards-compatible shim for non-LFS 32-bit systems */
-
 static_assert(sizeof(unsigned long) == sizeof(__ino_t), "inode size mismatch");
 static_assert(sizeof(unsigned long) == sizeof(uint32_t), "inode size mismatch");
 static_assert(sizeof(ino_t) == sizeof(ino64_t), "inode size mismatch");
 static_assert(sizeof(ino64_t) == sizeof(uint64_t), "inode size mismatch");
 
-extern int matchpathcon_filespec_add(unsigned long ino, int specind,
-				     const char *file);
-
-int matchpathcon_filespec_add(unsigned long ino, int specind, const char *file)
-{
-	return matchpathcon_filespec_add64(ino, specind, file);
-}
 #elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) || \
 	defined(__INO_T_MATCHES_INO64_T)
 
-- 
2.54.0

