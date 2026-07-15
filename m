Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE733A8757
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132453; cv=none; b=V9BMiGkx3IOiRMn/QOxns6GUphF7qpY6z7FcAP7AX3k9Asltk9YBobnzGA01K7SAdCAr8YWose4rL3OVuFEl5ChC2XToZ4qCdEunVhHh8JaGgbzn65SIqbMkpjqu2wOKLAI9AxsfM8mcrka4x+XsZy/SVV3jF1vf7Q4vUjJe1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132453; c=relaxed/simple;
	bh=IIvv/FNWUWDAOq+H4m/XaFFwXGk3bYFd+clnMaJd/7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU3tmPkfjIPSJTmkbH/nM89wrE+RC7+v3RpqzfhSOtcROsw/tahe0cgjktCBwPKgnv1MzqGs3C2xabhF2+lpHSM8CZ3aVrypt0oEubGXf5YDRDrpn52V6nEyRA4yKYU0bQblM70SxMPbtO4gzIwNZ7vDTex6ZZM4AX53tp74A0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmlN74lq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmlN74lq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e4fd65b2bso177640585a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132451; x=1784737251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxnj+X1X2Bt3mQoMkJZ+18aLzbxh0Z1iyD0O/WgOztI=;
        b=BmlN74lqhyDA2GGXiMYrDBRVYYT0Xm3XlQ2wxXpYXtFILq1jexIvwA2mOjEKaIBNPG
         Qq3+sAgzydBRpAxFNKPn59pIoitQK3JS7XtIqnbTodKL2zO52k2kNUE5at2GSkOdS1mX
         Lo6W0EsKmBTvg397L5y4XnHAOZ6IQ4yVRAee3+N5dsAiKBMgz219KsnVAaLOA8sf+sff
         aTq2qRkyEYD7uzLHU9o2v/sL5HzR7QfMyZvq1yARznKYtjQ42CtVDvFqHclzjqUY7IoH
         QZhAHAIJyWR/H3nBNLJArDhR0JHWR3eAilSayJMkqB/5m4GnJFAhqBH3VSALhrF3HXul
         uyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132451; x=1784737251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxnj+X1X2Bt3mQoMkJZ+18aLzbxh0Z1iyD0O/WgOztI=;
        b=PxUnPAWJzTq1Q3QkIABpcCr904EKyb8F9yALj7oZd00+D6VFhQ0sLMWnaiZOsMcPvm
         zBHxIxpLfwHaK4KMEgvmSe/va8hJW+dl7In8OFAfdzX58lPSolMnDNhU33f9B1dc574k
         vTPdJhpdRN6ZJPiur+Kz5n88BBz3Fe8fdECfWgfo6+qkDtKdYpCnIzicTK6CYzavy+r2
         w8IUvBPukq+ZL9bPprBRLfL3BgO3dWk50iWFy5CdhQ6Nhl63N/CJHqHw1M8X3eCVxItA
         UtkCa2KCNjEOTzdyqpc09i+VQITfQaKXHUwAZbRhIApflaMo6pz4R+MNqvc99rPHEsA9
         pOjQ==
X-Gm-Message-State: AOJu0YwvU5oPYWzlks3aUpCMZ3r6mCDRg3fCtdmE8rI5d2ebsOuwAd9h
	cZ5Gqs2dHttolWoD7pi9IpUZiWdGNKkR4jWCJTVb/I/HA4wg++AhRZDJM2v01A==
X-Gm-Gg: AfdE7cnkQIyMh62ZF6VKtQ7gFiabXCrkc69qBrcuxd9Y1SM6uaui+/BdF1NWZ5hWz4x
	niweu40rdbzF/rRtKi4/N7GtSgAEhgnZHcR3zmhF9oFp/KXYSeQROubumD/cuGeN0zKbD3Xgk+Q
	vxWmFuC3GsYTUL/H8/QiebYO862luncnVxCjTJmnDhcHdhVa5uTY9lbMr3VZHI4ybz0LlJmaOug
	JdR8LCYlASNow5q50JppK0ynE+K1Zmkhw2jCiikzaoU3CwneRImruf924qd9ezx/e7YqVnl1VAk
	8fVKQbukOIO9xpT8MTaVa0jvW0KAS38LUG84dIDdi0iiYPXykL1OlrbdUErXJVdZfrj10wIGkmq
	KZ+ObMXmHKFFRywDEs54PwKVL66aoDla5UJNsOItIUsQ81XBcq/Lh247ina/NU934DH/D7Asa4e
	7u80Nr9UdpOwqzZDqqPsfMRIDMl5oTBYqDW1xvXdrW5WbS+8wxrDYfHAZWCy+Kr4UPPlxLVHpSK
	e56WchVy6uph6+n
X-Received: by 2002:a05:620a:284c:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-92ef2b79eb1mr1909281685a.36.1784132450778;
        Wed, 15 Jul 2026 09:20:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 02/10] sandbox/seunshare: make a best-effort to remove tmpdir on error paths
Date: Wed, 15 Jul 2026 12:20:28 -0400
Message-ID: <20260715162037.42329-2-stephen.smalley.work@gmail.com>
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

Try to remove the tmpdir on error paths. Failure is acceptable.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 0c32d03f..d0f3ef1f 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -663,6 +663,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 	int fd_t = -1, fd_s = -1;
 	struct stat tmp_st;
 	char *con = NULL;
+	bool created = false;
 
 	/* get selinux context of source directory */
 	if (execcon) {
@@ -698,6 +699,8 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 		goto err;
 	}
 
+	created = true;
+
 	/* temporary directory must be owned by root:user */
 	fd_t = pin_dir(tmpdir, out_st);
 	if (fd_t < 0)
@@ -747,11 +750,22 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
 		fprintf(stderr,
 			_("Failed to populate runtime temporary directory\n"));
 		cleanup_tmpdir(tmpdir, src, pwd, 0);
+		created = false;
 		goto err;
 	}
 
 	goto good;
 err:
+	if (created) {
+		/*
+		 * Best-effort removal of still-empty tmpdir.
+		 * We do not use setfsuid_checked() here
+		 * because the fsuid is indeterminate on
+		 * some error paths.
+		 */
+		(void)setfsuid(0);
+		(void)rmdir(tmpdir);
+	}
 	free(tmpdir);
 	tmpdir = NULL;
 good:
-- 
2.55.0

