Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238033EB0E
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313307; cv=none; b=I+6LqfDOVwtZGLKd0v4BKUlaBQLqrhnQ/IG7BSkqB7DqtqtxC3hwVtG8Pq98V64mxGxTgoJLQDQYhXdTSCIjfyiUI56R4gy3D8QNCFZ9stH9Px4/ysbBdt0KVBCaNxtQSQFvA/8QBvGRvqOH7+dkK2dtfaulf0/mWypcunWYfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313307; c=relaxed/simple;
	bh=IIvv/FNWUWDAOq+H4m/XaFFwXGk3bYFd+clnMaJd/7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkhQkO/1wpUEcgHD11OCnTiz3NPzKID0fU4i1R3Rs+nL373S7WU42fxGbpfrMPuov8/KEyNb6TlHuoIHOqq6HC6B3hYzf33ZaNlf9apYEzxPwIWaqBsocdPv8PUd7tlvve6jFzQ5p2uf2oDR6SZPg42w7jJQsZvXyrUGN1h3hng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsGuMzvl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsGuMzvl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e85499ffbso379873885a.0
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313305; x=1784918105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxnj+X1X2Bt3mQoMkJZ+18aLzbxh0Z1iyD0O/WgOztI=;
        b=UsGuMzvlzqcuLJIrQiZWlyaTlON0OoLhi5tT3bAhfxLpfhdbNajiWu0l5PbL+PcdFD
         iBI/nFlQMWKR3Q3pTJcLboxG66FAuJI+PCySUpy4kHaBrCx8E83QwELHnox07pt26ovF
         mRqGdODadFuU2Y34Jkmxpor+ajcFY9UAPc3FYZ7s3uSNYbiSj7ysmqk34TMHUgaLIY0y
         Att6tyQ+nr+apm4IzK0F1aUUkGXv0hGjc8AN27WDm7vB31hdbtofflD6NdH4upgzUTSV
         Rn5l6BcRH+/8dgDBkChicXihT0Y9AWocTgL4iO/mjAG6gRphzVj0QUmxVHc+8AH8HGBY
         01MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313305; x=1784918105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxnj+X1X2Bt3mQoMkJZ+18aLzbxh0Z1iyD0O/WgOztI=;
        b=WrUGcU13Wh+75PITr3ZsnYqRuqSIojPbR6fKskK5HGlha7bYWqmh38/qEGniwQBG9T
         J528Iu4LDA5sO5GLyyxGk41s29HsO0hZKx/ZE50IaQBu+NiyV6mttZMfdVCQWDtGkn58
         JFdOM+lPgdL/SM8BV10G0mYKjuk5UgXYGOvetkwnui0szbw8EgZ0HVoA3iIef1D5kAIQ
         hQ36oWZGkgb+aNeHn3M759jURdmoz/2mU8ZM1QwjaehS5Y1Ee4zy2+zYNi00wWBo1RbW
         knVJvIUNl9FzAyGwBuVH4HEaqJQ+aSujEwjISc+dNmu+U9Pgiok4n1jJGQH25u+T9w0S
         BQsQ==
X-Gm-Message-State: AOJu0YyTzQrPEkMEsImTpyK6c5JL3yIu3VzGUJBz1jGph6O8VIWu+Wps
	VRwip3JMWNuIQFvMvmIw3YK/uIyJ2Xg6ZnRD6vnnpAaMdtUMJLFpledBJCEKlQ==
X-Gm-Gg: AfdE7cmWNzdrgbEYV8Fk1QYrIZSi5qqcQEJSOJ2inG7XoRwbLzacyOOqRSta0O3jj5F
	yelyUEZHA8L85fVdWFvTcqx85Er1FfHyw1o522ZxA96frIbURMjhVAzrP1qSr/WLgpyT9fv1K/S
	aRmnDYyzlkLqLdpjN3fc3j5FBcfUK4SV9Eb4XKIMU3MbG9YvXVJ20QyMB2x0ncAKS9GrZ1h1jiZ
	SgnJfHl1oiw5hqGm61zuIs6HMrM7oROe1XnidVpcJNP/7ekeLXk609Xt6CVl3175AjS7CdRj/HV
	Kr8cmT9uyyTXo58aDir/hlRRvO7oTVnOezCc98s6hOjhp4C/wt2vNqdpF2YUXKcp7rPw2mIPseI
	noi9ckIGGprCuEaLCkA4oYxeix/KWV+aeXYe0mHmbxH+7JVuq/yMYmND6568tb91P+VkbOx8VXU
	3ukOb7PALFGEaBT1dopFrSJBWfq6Jw0YYf9F5vih2maJzTdgbLcON3JlmuyuNFTl47hzmYcrLXF
	X7CRQ==
X-Received: by 2002:a05:620a:199f:b0:930:a3da:3a77 with SMTP id af79cd13be357-930b3e6fba7mr430856085a.16.1784313305087;
        Fri, 17 Jul 2026 11:35:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 02/10] sandbox/seunshare: make a best-effort to remove tmpdir on error paths
Date: Fri, 17 Jul 2026 14:34:16 -0400
Message-ID: <20260717183424.20324-2-stephen.smalley.work@gmail.com>
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

