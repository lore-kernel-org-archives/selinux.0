Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980C345CAB
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313311; cv=none; b=cR7oQSo7OWWGDcjdOXrysyNHAzDv1s8T9NxTAycw/U6mYZ+8QXvFL0nNnLIzqEE+Y37KgtNzkK+xCwdYm/wbaWh4OXdw50bvpRR9opGJZhSPfgSWEgayg1aVFXupUmtpPXJM4m5jQePVVXPja3MgO0kU3cLuhjEvY4dRBeeAwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313311; c=relaxed/simple;
	bh=1DQ1j57I5kek4u8JhqtxYvKQrxtW+7fabrpxlAJkwvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDZxjM05RALJNec/iokGJwdcDVyUDRX254tW5W+6AfGs8YMbQrzHPBoBtNGMQs4nvQIwEoZkpiqDTskTlWiZ1mrvbS8j3WdHq818NFbBKybbOmasp4sI2qx7mlecp5VxLETp0o3AN37XrECaEPsEubUyim16xzrKyO7b+WCs7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMA7hNk1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMA7hNk1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0e5e36912so68053666d6.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313309; x=1784918109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AucMRsovifTOKYuh3fC2VU1zb08yvOSTXC5wuJxrw4=;
        b=sMA7hNk1eywfpxrPQynHS85dLiEHtTwarfmfz7GYldv54HF8tPGSMi9eqtbPcMnWs2
         QYsNOpz5j03pw7vhsq90OkTeXaoWCii0RDBDs9ozvAIfvMSasWw1GS9qr0D3p+lWutBt
         pX6lHxHAmuFsOD5IZv/limhTNov8u9W/9LZZ51n9gOaCnIDU/lM/oMBo/hLabcGPQAxY
         z323gdlDKENl3dZD5GpfU5DC+Yn8L/YWGJf6VKdDD7/uTtu3ubXaWo6qOEOglAzd1INc
         T3CdT28+gEuI+o4GOzi7IBrG77w6/WZcrHcaVG3YRJp8I7SHe9nA561uh4orE36rw2UE
         qJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313309; x=1784918109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AucMRsovifTOKYuh3fC2VU1zb08yvOSTXC5wuJxrw4=;
        b=QulbMlgLDSVffbiD1olh2VlChm8q8789U3LsmTVFB4zvzCtkIXxP/jU6kKsK3ilHKS
         JkZc9TvaX8yiVcaaLxoiyj9sUy4gGCJR4EY/VqbU7k78P0936bp9PJ1Q5ttoIrbqDWF9
         JvhXCQR8bWK1wzcOZF0Ehn6mc88FQ5oVeJfTYoxwXEkCI1r/C3bwV13yxxVjUneqqqSs
         N6gW9ET5aZjp3lH8FsGmuXQLesZanOc/oe1gXzoetKPLi79IMAjgeoctEI/hnk0Qxka0
         7SEhsFYapBVFniYKNra6djo5rZQnVy4dfCC41Dxda3t4QDMXnu/QSJMOTa8DCIjY55Jt
         +jrg==
X-Gm-Message-State: AOJu0Yy93bMsZBk1LlRBbRMRd1Rnww5iqQ/FpeMk1eb3951hVOOdp6dX
	OJoRthc/sgjmP23ADOH6Z3yZ33HXpbnGKGr+yEN+f3qGrj+ltm4HG571J/xlNw==
X-Gm-Gg: AfdE7clfA6C8jmNA82eNJzXImTSrH8XaRS8FWwdIy7OBjKtRoTbjwD5c+o7L0+5QzrK
	rPD7QIDuNv5UeaMENAKEpxvgCdH8LBOwwLZfrXoVnIyn/DabBDfiIuNGbOSLpSPCbsTElOGoBvu
	UJzljd2Pl40r2UH9CYqDO5fGE+oS0I9/LTzBB+yB/jkrq1O1xUHOMdiavAs38pyv3R6gbR6yvUA
	Bz0skZ8tz4kVUa62s54ptC5+3g+pWo4PeSDMiPFPNqBWNjFRG8A/gMrOlwzF+N7cYimCBPwRjSS
	hhv7XEZOoU/fkv7J2a+Jgl59RNXYjgBSyCPxtroEC9qMhRq93IKj0yD5lIj7Fhx/21E16XZUNLt
	+6Bk0rZU2fLtR5Fs5CjLUzN93Bx//WENdW//ldbdc05JtJ6rH4fGbfGZQgbEan+T8EBZPh7oDLk
	kL7O2JH0dBKYy7vQO23RGFZq1cB9cX7JrnphWcBR0pHnnnGM1xlRtgLVmGM5rtovw3pKGXImjpY
	7nDMw==
X-Received: by 2002:ad4:5748:0:b0:8ff:496e:1071 with SMTP id 6a1803df08f44-907783184c8mr46029146d6.1.1784313308808;
        Fri, 17 Jul 2026 11:35:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 03/10] sandbox/seunshare: cap rm_rf() depth
Date: Fri, 17 Jul 2026 14:34:17 -0400
Message-ID: <20260717183424.20324-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
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

