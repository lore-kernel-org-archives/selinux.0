Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD440DFC1
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683097; cv=none; b=Q/2vuZg839i2JaV/id7jbFRP731s8BhkDSBiQwo37by2Cmbl7IT/Pofa2v46/PUZVCxV4FcIWJkijn2eUMXYu7jcxZ2sb/7yESVRLYLrBD/em4UMXDjWF2ZxDSSi48bcKK+og9g+noxiL44wk1V2+f+o+zFirJNMD34CMv1v+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683097; c=relaxed/simple;
	bh=XYSHw9cqzZWcBgHIYbOBiedWP+wnNXjUyHWdDuuVUXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSnCHHRJJnV2cjdUtTxCW1TUNSlPbdwn3kuTchJG2r/Sy2u7+vDZFxJUZr/3sqPykhzx9k+RlEfXS2jJL6RvcrAMaD0HSFbOgGCFuHpsCKALQEIyZ8hYJYASYQuOkZudRnygbDQmfzSPU111xP9nQlBfzzUPcbhMiIXznmQ4qUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+VPDl4z; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+VPDl4z"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fb4a7d704so50917681cf.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778683095; x=1779287895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NJhqX/mRHDjjiSj+GHonfCgKDxi0fXjDurM61+Usp0=;
        b=p+VPDl4zOmcaN67DpGHH+7ShnEpE2a0hQVtQj/tsNR4GofygchFjdUL59vGEnB9xCJ
         b2qNNSDJvdLJsS2Oc4QCHG796JOUd2f8/KS3N4kgXINvFtXhABZNmJfXRHIEAa7YxwaD
         41waJmHDHQkqVmWBqjpTuXC5TwqS0+rmsVjAwLXbU6v/fKWdOt489sZrUhTxx/WnzhcA
         o7MCsZ51HURWRrjRz/ifFSOGp+Fmq3QMgR1pPhkeLCjUFQ/HMm3Q6ndcppJiKJt+hN7p
         FbzhJ+hgdH4T4+QBBLV3bUzdQin2GoMD+ZUIbafA2PTmFszZ/Cs02EBnu0Qv4SKtY180
         CscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778683095; x=1779287895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NJhqX/mRHDjjiSj+GHonfCgKDxi0fXjDurM61+Usp0=;
        b=dzOqP45BMpt1edxNnTCxuW/oNle4EEPQ64Aib7LaaO2kq2RjA2bAviMkawg/lECWIV
         DFGKHA3B0kyczTTTn1AIH8j09u77kdXJ+qKarKFoEugs1ZXSh2K3pxgFOmZfdroKqawr
         3emFPljF/r0BFpdB1qlOpHsgD6jOYEDTlxvYf2rXFG2KOzH0c0vc+xf8HzD/YdWyfNgy
         zRX2jccw9nfDG5q8QBvWoZ5Pv7tTvmvFgfHnJQMqmF2WuULGUygAhZbGGlJdsAO1BVCP
         095QJJiKZn+RxNlhCFoxW0s3JC+33DlIWiVQqL9FbnVeOl9NQw5aZ9Eu1e8KQTposB2e
         q6bg==
X-Gm-Message-State: AOJu0Yxms/BH+GjV2oSdDWCrcES/gp34TVqpSAOc02sguwecYMtCMPIS
	TeOCBN01GVOx2+zwb7qz1LJ5Fqt/R5OCqojbVrtzsaZ97ak3BOh6+UidTVAdLQ==
X-Gm-Gg: Acq92OGvDStMn17LaKCxZrUY10aGpwHEGHsxXXjAt1RRdP/ez5Bc0qOdraipK1Rvljd
	iIgBspPdx2TAd8XEodCqwFDeZfMQXccih19ClfsmF/ci2X44EUfoaKHdL2kG9JOR8Q0UV3w5BJj
	SQKo4QVn1hdQyclCCAW61BY4ntyM/hyFD+hi0q4DuN2n6vjgqHuYesJvjtZ67ldKQ99m32C5tKT
	QDIyPyNnnsk8SU4iJpO+hmcc9SPPuIBoOkyVO8rFCit6ARrR74isgtV0iWvTtlKRGpNPrwOQKDY
	NYtEiUTOCFlnzPrd3pXvYX9YNPZmsskj1KnBHbbsAkXAGismP9fheUfYevlReJBGM4G58Cl4h+g
	wkf4q8fffLEQ5sHceC2zLPtykHudt/iqhdFcJT/aenPJZNcPdB0JrV2f4JOo614522OOy74IpfM
	QMVqD3xXARi9jf15/ynq0qLKHDRkKRcafxfydw+cTt0TX1MLCyvJ1CglcFJG0qRypArmgZGaV7P
	bBJPdPHCpBchgsExVRc3p+lbsw=
X-Received: by 2002:a05:622a:30a:b0:50e:defb:9dd8 with SMTP id d75a77b69052e-5162f452f7amr46594311cf.6.1778683094692;
        Wed, 13 May 2026 07:38:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148fd8bfe0sm148062641cf.0.2026.05.13.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:38:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: drop unused runuserdir_r
Date: Wed, 13 May 2026 10:37:56 -0400
Message-ID: <20260513143757.39303-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

runuserdir_r is created but never used nor deleted. Get rid of it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 89180d0a..2eef0e2f 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -763,14 +763,12 @@ int main(int argc, char **argv) {
 	char *tmpdir_s = NULL;	/* tmpdir spec'd by user in argv[] */
 	char *tmpdir_r = NULL;	/* tmpdir created by seunshare */
 	char *runuserdir_s = NULL;	/* /var/run/user/UID spec'd by user in argv[] */
-	char *runuserdir_r = NULL;	/* /var/run/user/UID created by seunshare */
 
 	struct stat st_curhomedir;
 	struct stat st_homedir;
 	struct stat st_tmpdir_s;
 	struct stat st_tmpdir_r;
 	struct stat st_runuserdir_s;
-	struct stat st_runuserdir_r;
 
 	const struct option long_options[] = {
 		{"homedir", 1, 0, 'h'},
@@ -902,12 +900,6 @@ int main(int argc, char **argv) {
 		fprintf(stderr, _("Failed to create runtime temporary directory\n"));
 		return -1;
 	}
-	/* create runtime runuserdir */
-	if (runuserdir_s && (runuserdir_r = create_tmpdir(runuserdir_s, &st_runuserdir_s,
-						  &st_runuserdir_r, pwd, execcon)) == NULL) {
-		fprintf(stderr, _("Failed to create runtime $XDG_RUNTIME_DIR directory\n"));
-		return -1;
-	}
 
 	/* spawn child process */
 	child = fork();
-- 
2.53.0

