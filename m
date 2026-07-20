Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E873BD63B
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572690; cv=none; b=sCFBi92IzpjUuxR09QW6xrUmcoSpwTpm7U2vMQGjt4ryQc4TGsfkPClzDJwurs0GyaZ23PUs5C53Hkvr/KlSAWjzVjCP03UlcaC85TX0dkV3IxoHy9cof24YtUwaJ1s+M12LEdzYhXiqd43iKt69oW89TLjo2RdD/YpEyitAnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572690; c=relaxed/simple;
	bh=Du6qu2a6XVv1nnLZbf6nfMfS9AwTaJnGPHCkSjJe5z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NprCJhQIS3Zto95dDysQ6O6mfAjQUSw0p/XoslPYJIhwoyHYRwCq6jvWS+lE6dQJmMjCAJGYLDIFSex9Bm9Z+Z9lfPIP2abxbEPf8AYa5V6HCPmC4MtB3wDe7pG37+lJ7ssjepysjSTzwb7PC4hUDJAaqNKYsAO/wv/yNvsTAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE7OS41t; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE7OS41t"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0cea8883so50262101cf.1
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572683; x=1785177483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MME+mQuQ0mGC0fOb/jo2DJe9oLikDmZZvOrE6HHQXI=;
        b=ZE7OS41th5sXEArB+U6OrgOEZn+Iae1zsP9ukJpfTkkvF6ScLgZ/UzpR63G81d3MIm
         OQ4oWU9aKBFEq4rnfY0JWPTj3FY0BRshAIWUvbT2/TUW2PoxWfRiDthq02OPEqDkFGgL
         n4/Ce8KilumPmP5+IPuf5qrjO6KQYtbviM21Z1xI+PYyaKkR7YWR/6MYfHcoWdY4Se6L
         gv6rI4OQ5fAom/g3+W8WYQfv3gdLI5MTKZipG7Pj9fA6aOM/V48bc9QGadzvVMLE9chY
         pHUa447JDbIYG+1zHeGtR0Xz6CZv52QFRyb20VF8pvLVaijkSEXscsTBVRuBOQQU7CBv
         vuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572683; x=1785177483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MME+mQuQ0mGC0fOb/jo2DJe9oLikDmZZvOrE6HHQXI=;
        b=nsVaFBwOk2c9oYIUA8zjfAUcPYa8RQP0HZEx+3fOqxg00gXMWQU8vptC3K1BcP45gD
         CvrCUu0VqzUrEWG/3nV+MNBF6SaRH5TtBI2C2oYj5+HU5GUsRzX/6Gz0d0+BYzxxxSrg
         kl0hPVv1FPM314t1Z+pp1pJqEyqSVZHtIKzzeCJ0DtsJ3LevPqcPl1cL2lVK6TamZVTG
         KOgXyBvn9X3HmA4e/1prH7os/1p3eUxWa/J/g5wg0q6lXVF0EtD4uU7zHoYp0kHQcgXA
         OmFLvK6NHoH9nL5l1VVYXUuG8omTJqkp6/96HkR4dL7329rMgY9d3tMLc6zv6GU8UVPJ
         ItHA==
X-Gm-Message-State: AOJu0YwLUCeF98Cala2wlvgt7oTURa8ovwCs0nHgX+6QBHW2zcio+Ycs
	oTYtxpetfODWFVH8ozmrlmXtaf7TQVxr9sFRyaU4gJDFOhiEqcEatA6m3VYCUA==
X-Gm-Gg: AfdE7cm/KzttvKEYhm+lLL79OZKQ+rCPxnn94y0ecJfZzoPYVmhUhNkXwaaAnp59wsK
	Hu5LKR8zuPANr8pSgKEDmsNteBeWxHEX/WtgDkmoJA/+j4mLoG0Y5Ep3meRTe3wjIpSsz1WzjZY
	yIfDJHix9MhelPgXJ8uqmoVa1TmokwmWOTcIZIYnMBEC45LIbHpmdGE7RrbHqh5mA4e1KnVvoYd
	g5RY9jKVZTLkGqmeH1D3ZA42YP9mOamb0FFVliOafqHwizf9F/VhpeX6wK2XMEVc2TqD+hIViDt
	jlf8xPfO92UfFBDSEBsEiEDlWfZDT4iYN+UsmqNCKm31IW3ajjakVIrWiGbqeD3irHx7Of7kljP
	6e5PvGBXbkwK4opNfzUEwdPcd7dDpylzTFrBag+dsmGf4qnsXV4waerbEyA8Z5viJYbQISZnRNq
	H0V2L+D2Z6EGNqNsB/66CoGeOBAN2EJc270eBZce2w28eRjw7nCt8K2I1m6Hm1bngbJKrrZhfyb
	1rVQQ==
X-Received: by 2002:a05:622a:60c:b0:51c:98f:f288 with SMTP id d75a77b69052e-51fc1293160mr197073861cf.25.1784572683017;
        Mon, 20 Jul 2026 11:38:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778541ffasm97739756d6.10.2026.07.20.11.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:38:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/scripts/fixfiles: drop unused functions
Date: Mon, 20 Jul 2026 14:37:45 -0400
Message-ID: <20260720183745.47045-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After "policycoreutils/scripts/fixfiles: drop /tmp cleanup", these
functions are no long used, so we can remove them.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/scripts/fixfiles | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index b5f193e1..493c86f9 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -66,23 +66,6 @@ for i in $FS; do
 done
 }
 
-#
-# Get the default label returned from the kernel for a file with a label the
-# kernel does not understand
-#
-get_undefined_type() {
-	SELINUXMNT=`grep selinuxfs /proc/self/mountinfo | head -1 | awk '{ print $5 }'`
-	cat ${SELINUXMNT}/initial_contexts/unlabeled | secon -t
-}
-
-#
-# Get the default label for a file without a label
-#
-get_unlabeled_type() {
-	SELINUXMNT=`grep selinuxfs /proc/self/mountinfo | head -1 | awk '{ print $5 }'`
-	cat $SELINUXMNT/initial_contexts/file | secon -t
-}
-
 exclude_dirs_from_relabelling() {
     exclude_from_relabelling=
     if [ -e /etc/selinux/fixfiles_exclude_dirs ]
-- 
2.55.0

