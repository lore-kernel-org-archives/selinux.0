Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9083E47B
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328237; cv=none; b=c0gOoJjzulv+4nBXtWBnhDdXX+l7syVErWOLCgZuvRaSjLHrmcIBkSzboG5IJuIC5RcCvQoJWJQ8XtXC2BIN6qDfCAnLAGdoCERSjImzjYiRteP0zP84eP/I8rLeOv7YNQ5+uRUsVCoG76NTtBqkRYsbKQ1DMotcop25dcIPnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328237; c=relaxed/simple;
	bh=5VtGDt3KWRiHGF1OMvRh9yX0LMBoxRYDiea2S+dG264=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaiepIv+I1T4qdrVQSa1nIaS6Y2wkZ25oJsA4tycKGC/QzsCatfGFKDrs0/IT3FP7H6Q2+nC13lJNtRDKPHVLKhG2wperxqux/Ua6Dsf6U1R+YL19uDbaGhVTgnfzUmMG1lPSg4bYLPUcYP6S3rf9B97yfBNcLjNSTMsCvZ892E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VRFhbkih; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VRFhbkih"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so7869033a12.3
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710328234; x=1710933034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRm07oRcFQpuFZHSWy9+4xHfuMjKa/RbfPCuw51eQuk=;
        b=VRFhbkihz5VNUbF7a/f+xqyDZiISliMpXZm2NdFdMlISN84Jsb6m5t/esx8n91HqxI
         0SooBY4xEItSgeqXcxpRkilJgnACsygdXpArdobPr9y74+wc6hajJjvrJwXDtt99m3uv
         POWserkeLxN8fQTMpA61tOeznUwYYgjsOQHErprRJuhJzsXJbQkIEvKUBchJCA2ODHH+
         iD3I2ZPgA0BePi3Ic0Wo69WT6Wk/8rsOtRGlsQBBus/1uoitLdY8Sqq+g7xuXHpumdVr
         JejifijCtKa789izyCb4wzrk6UpL6hQ7wDWSPGl2Y0EWnFxM7h6APjlorO9vOpTPrKFi
         Y+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328234; x=1710933034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRm07oRcFQpuFZHSWy9+4xHfuMjKa/RbfPCuw51eQuk=;
        b=pr+woeR6QzUJ8SdM4iACUeuWZAJITafYZB+6KWvvzK8D6gg8qJic9GECarQ9ua1nos
         cr4zkckT0a+cVckJ/jxVqximBEMCfdRtGmZLpq7Q4vA/0nZBmrNoJ9GmXB+FjydH+C0X
         f/cKyIhuEQdq4ckvxBzutFpSo3JI2r6OLOWJGt8z9phs2jBoEl/KopgYEjGpE2c58P2U
         YtRG8u+bB68KnmCYQP18bODruwKQqQSVl+4Fa3eRDiS/Av7MHiUebeUBEPPnC5NxtFaU
         JteODXlhVXnGjFL5zcBs7bmj8RcZXokE79S+ymfmwVd4Fc9s5aDN2BQgDhOd5X6ngDnx
         3o8Q==
X-Gm-Message-State: AOJu0YxbupQP/DUjA1n0chOtjiEA5VhrAmmie4uOYbEGaj9RlACMhZvY
	Vs0yDxYRxpAUUlCcZ4olLckpDcTfy+Y8r06g8uhAH6eu7VGl6tB23O7mNoZ+cIs=
X-Google-Smtp-Source: AGHT+IGw96y5l4A5+TK9knwOToMsLpsVem+rU556tNSgl3OhDK2AQ5j984d0JzrsKqW8TGqi37H0TA==
X-Received: by 2002:a17:907:c283:b0:a46:5de3:43c7 with SMTP id tk3-20020a170907c28300b00a465de343c7mr943227ejc.12.1710328233981;
        Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-077-001-104-044.77.1.pool.telefonica.de. [77.1.104.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00a463c821e4dsm1794319ejc.10.2024.03.13.04.10.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 5/5] libselinux/utils/selabel_digest: pass BASEONLY only for file backend
Date: Wed, 13 Mar 2024 12:10:25 +0100
Message-ID: <20240313111025.43720-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313111025.43720-1-cgzones@googlemail.com>
References: <20240313111025.43720-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 65c8fd45 ("libselinux: fail selabel_open(3) on invalid
option") selabel_open(3) rejects options not supported for the
respective backend.  Pass SELABEL_OPT_BASEONLY only if the file backend
is selected.

Reported-by: zgzxx (https://github.com/SELinuxProject/selinux/issues/427)
Fixes: 65c8fd45 ("libselinux: fail selabel_open(3) on invalid option")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 64051070..47aad21f 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -71,8 +71,8 @@ int main(int argc, char **argv)
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
 		{ SELABEL_OPT_PATH, file },
-		{ SELABEL_OPT_BASEONLY, baseonly },
-		{ SELABEL_OPT_DIGEST, digest }
+		{ SELABEL_OPT_DIGEST, digest },
+		{ SELABEL_OPT_BASEONLY, baseonly }
 	};
 
 	if (argc < 3)
@@ -119,10 +119,10 @@ int main(int argc, char **argv)
 	memset(cmd_buf, 0, sizeof(cmd_buf));
 
 	selabel_option[0].value = file;
-	selabel_option[1].value = baseonly;
-	selabel_option[2].value = digest;
+	selabel_option[1].value = digest;
+	selabel_option[2].value = baseonly;
 
-	hnd = selabel_open(backend, selabel_option, 3);
+	hnd = selabel_open(backend, selabel_option, backend == SELABEL_CTX_FILE ? 3 : 2);
 	if (!hnd) {
 		switch (errno) {
 		case EOVERFLOW:
-- 
2.43.0

