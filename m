Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98C2DF6F6
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924592; cv=none; b=EsOJKm1rYq+DoU7ockf4o8Sru/cIaFr7W2sUd9SxRD0ScjEX69dBtleEYynb8TxNekCopjhu9uyCMBVxmj9YP+NvTnhmTzA6jMZcHoyge9co2VVIvwil9VtTL5h4DvZg/+4s8Z24lhSm/lcwUE5mGPTlgDzqnXYPbTLS5iOqjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924592; c=relaxed/simple;
	bh=xN8XBXkI287TfFAYHrKVZGF4Vm23gKL48ILIda8mJ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnZHReev+ha5gExWVQPK2JcWwWDkZOqD6Dok8W2taZIBjWJ5Q2W9627r3eyEnX5yN2i6oaAF2EBgDPGqMou1sKQkuBTmMgbYC69sw6CCedydvHIFqdwjQIqrwA7+ybr9xypSp9PX9mXous1ag/NdRP4ShVIc3/3kjW2uMx/5v1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB0tjbl7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB0tjbl7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51780bbc560so38887061cf.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924590; x=1781529390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFd38nCIix/ytPmXh+hqQxWHlMJHMGDjr28Y92NCFsk=;
        b=SB0tjbl7ldBI1Bcy9DqrbWpNylwheDAuMhzvbh0qCOQhKmINBUNdw5vXaizpRq7ufA
         8dSEDBBurDWN4W5lm6DvStAGBLO/erUEi4Pzz++Zf8fEhOPMYYSE4U542+Njpjx4q5gg
         TlmLU6ajtwRAuU5h7U6fotMofEVHgKVfI9PwFjoQYez3mWebYyk/yArcphjQRrtrEaAS
         QLD/d3QKI0DUD0nVkB3oazD9DZGgQ5Zv2yNAWz8gF9serY+SCCvkWvSmR7h1dd7WvtLZ
         mpmdhp5RAUWtRjzRXH0Av7xcIrD66WCMnylzbCetKmFjTsCcyQFFX7oaDasecmPcbh9o
         T4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924590; x=1781529390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFd38nCIix/ytPmXh+hqQxWHlMJHMGDjr28Y92NCFsk=;
        b=DtKjevq+7DymOFO929jluGkNy/VsVZF5PdA7Gf4hTPcqVDtZuLQlqpdeTGlP9vtyEC
         N74catOhobF3UtFZiPJDQzsUrPJ1HYUfs7ADfQhf3+oWlqq5GkM9aZXP5oJsmIYPSPC9
         hQMJ81Dzjqp9CWcc8rUryTDl3Uy92Puto/B0unlZc2eSmpsOJwQRh04STJuBHKAZW+fo
         X+HPZIwAkl2Qc442i+2+rItacZQ/5C98FfnCjiLVtPfM7eRLXLuCxQcbj5iA+PabH89T
         bQFU0cBPXAwJecny0fsfm8Lnwm8z51nR7dpMsJ4fjshdBX04NRJuoh7dIYpw2L2nsr6K
         mHEQ==
X-Gm-Message-State: AOJu0YztMGw42GQeUVIP/eEJRGkA+H/wKrK6izS9vI+y0jfFKPZpvX+C
	OVOBsIuwc/L8t91EMrIYIbgYgdyklQA9j2MzdmvFawkGx6rkOrpcVCoQof7z5Q==
X-Gm-Gg: Acq92OHZxjoZCF8Irl3a5e6jn3ChFSOFYv8lyCfxFJEcuXSnS1ujGwKyaDHa43PAwl8
	okhlewzO7F4lyYAs8MgVx2jk7Dgnj4ln8g1PBDO00zvHuQJL59oPWSqz8AFTxfw9eYg+CS5m8Q6
	jo16ESgB+Yyn3jAksngxSeqaLi4K1UaJ7VUd2PJLiREb2BNhY9UgA0ElsUmtCvJIjNspVs87c4P
	QOA0ZG0GQdn207RjfwA2K/vqEqVyXIYOjN2eCUUNtBuN5PlURYzR2b7Nen78A2pJoxPA7RHj/rh
	TJ8prKHraHURwX9J3mhHI2VZYQHof5uZAzQHk3hy2vvobG+vi0MVT+lluSaSH5m/4aq8W6/rJLV
	6MMKeN4pI4Gkp1c4Fp0OF91hI2igb6L2iJXyi/4Rs6LTq9qO2p0M8+/TefDnQy3HpcGhslQhL8I
	76eJt3Q9n5+L0SQ1vZzsS0RMtHsTF/WtK9/W8ANYLLxa7slgRKT3kiGtD5v1MilzkxUjLrh/mCc
	5YSYMkLPCQTCGpTNbX/LKYwaUL4zddGJDEupg==
X-Received: by 2002:a05:622a:17c7:b0:50f:f030:920d with SMTP id d75a77b69052e-5179881c7d5mr142848731cf.30.1780924589709;
        Mon, 08 Jun 2026 06:16:29 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775df4dd6sm152599351cf.27.2026.06.08.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:16:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Renato Caldas <renato@calgera.com>
Subject: [PATCH] libselinux: restore: drop the obsolete LSF transitional API.
Date: Mon,  8 Jun 2026 09:16:14 -0400
Message-ID: <20260608131614.308870-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Renato Caldas <renato@calgera.com>

The preferred way to enable LSF support on 32 bit systems is to define
_FILE_OFFSET_BITS=64 when building selinux.

Signed-off-by: Renato Caldas <renato@calgera.com>
---
 libselinux/src/selinux_restorecon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 10807867..0159fb7f 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -487,7 +487,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	file_spec_t *prevfl, *fl;
 	uint32_t h;
 	int ret;
-	struct stat64 sb;
+	struct stat sb;
 
 	__pthread_mutex_lock(&fl_mutex);
 
@@ -501,7 +501,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
 	     prevfl = fl, fl = fl->next) {
 		if (ino == fl->ino) {
-			ret = lstat64(fl->file, &sb);
+			ret = lstat(fl->file, &sb);
 			if (ret < 0 || sb.st_ino != ino) {
 				freecon(fl->con);
 				free(fl->file);
-- 
2.54.0

