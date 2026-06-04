Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6247B429
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577854; cv=none; b=Z4JiZlDnB4xryqFzPZtdQ6zE/ChDgzuFX5iDeqcvmHyWzieUE7LHOTBl515VUn5dOpaSazKfxTe/x7xobcmPFd2ViMJH+cks3Xi4gmw/iypVYCfspRvYk5u8n+ise4yDfDErtLLGY061VbP9kF3hJLzaljSNJu3ys/ZcaFmKwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577854; c=relaxed/simple;
	bh=ihDWUSO//LX4U0Lau8sR7oaeAvVLanFMsd3WzxXQ3qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJfUqBkwl+mcuzhREAUVDHA9EvmXegJ4xibAu/EM3b3qd0d11TIut8LA1EIENb+eKEpJHwX7hGsFfRJqHLf2i9xbCBGbLpSMktWOhipTCxQe4XS+ENVATSkT+MZ4k5WXzQHSNwg/fHmGAaQHODG2LdLHHM5IEjDtG/I/b2scK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC9FW55T; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC9FW55T"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9158629a220so79392885a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577852; x=1781182652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kreBmD9OYabfOhZ1X+SeCxG/D37CYkeO9QZEo80Z+E=;
        b=pC9FW55T2RbNRrZSe0U5LWCRoGGlkujmXAxSK38ntVzC809z04EKgilp+1GxUv/mRE
         iW7wHEhHGK4CLqN5HwRKjMvu85DVxS3o4k2aH6Ga3BNP+cpCDaVQMRasUj5tU7BDNs72
         7JjVFHoomzDZgn+xpOTbL4khXmRtpwf7Gs2Xz7K31Hxf/NiokzrAoaHZ31iw0NIR+ixK
         20IuniKLCD3cRKGmeI7+BB9fQ1upuMPWtGii9CDWwYpzACw2mqqXPpnpgV3jOAmADBNp
         E2tusgI+HpiWog04n6mics5RtfOcKnEQIgbjEFxllglYRHCQkd9hQwe8WSl/E3l6lzHH
         vmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577852; x=1781182652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kreBmD9OYabfOhZ1X+SeCxG/D37CYkeO9QZEo80Z+E=;
        b=CAmvETwJoFNEOQMHVyAQo1EjMCc+6TPe9c2t8yUf38A40x6ViGgZThlFhMZ7rqdArQ
         +SuNpqpNw/DDMPPTxlmE86krviUeiAuNfB0HjhXyeHJaM28cLPgbiHD64sIxmeIY8B/6
         GLdc7ZAc76a/A0fNDYs0XV/64aiAHc6s3U1468rTaoRzFPj6kZ2X+hSVbUnpid9nPrc8
         zGkrzbK65y426zgjRLpJf23klj+LoYsO46W0xBI27D3UCn7VKu9uCCVkqMXd6VihL/zB
         kFnMxq/u0QYXRVEJZIRw/ncdqojz3NM4SYvy+2xKmtopTFCx3ypceMHWsnwj7LF2SOK/
         LQZg==
X-Gm-Message-State: AOJu0YwpC0i2OB3ba6D7HyF958LwtgMLBCS8HzVk8Ff1d5yGFXzBq8k5
	F77atAjdasfxeSKLdDsMcayIv3ngd5IrpES/zyjstlanQIK/tM4uozvonzFVnQ==
X-Gm-Gg: Acq92OGdUS623Ez2bbnpp+df/YLw9qVY8cDvyr3MZrDhZIIzdVK6fwiLVTsNV/X3acu
	hbaNEoIYGtjjO3AT/pdUy/MF1QzmyH0+sLAMzTN7vG492K4pQil+MFd8X9I8WJkeIqkHHggIEB1
	uiEKXAFJKOMgqGwt+TFhuQTcet5GT9tcrukFUnlDl/mCFXgvp4StBIq+fxlpJ9Uq2B/jSxE9Myw
	UXkvvnL8+MdDval3wCZwn/WQBNg1RVplbyfH6vLowGjCtwT02bBNL3WGQehzAQTDZO3Y0i80Cdj
	+aqgmCoBwuaqUk+HhqwrlsulJHZ347ikI2cOFw3m7LUIfpqS89+7BzYmgpJmnKDWoiTmGlla1tc
	kItVrt1uLCBS2xpxyY50sTKNGKLWw5c0t+22D0f3QwqXClzkjNyXUwAx/sZgd0mrBbJhTDd0+0p
	YkV/Sps0wE6j80q0zWdcVCzoFR0cZh5ixVZTeGTsv7IsX5vqACoDwKEQnkWS1H5amQFolcMmRWs
	dZEqH00m0hwxOXLtLj29O5Tmmptm8lMNkxeCw==
X-Received: by 2002:a05:620a:1984:b0:915:a5bd:d82b with SMTP id af79cd13be357-915a5bdf3damr92855185a.9.1780577851847;
        Thu, 04 Jun 2026 05:57:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm586427685a.35.2026.06.04.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:57:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] restorecond: avoid busy-loop when watch list is empty
Date: Thu,  4 Jun 2026 08:57:15 -0400
Message-ID: <20260604125715.255605-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If nothing in the original config exists or every inotify_add_watch()
fails for some other reason, firstDir will be NULL, watch() will
return 0, and main() will busy-loop. Just fall through to blocking
on the read() on the inotify fd, which correctly will wait
until the config or utmp is updated and further watches are added.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 86dbc77a..333f0af0 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -313,8 +313,6 @@ int watch(int fd, const char *watch_file)
 {
 	char buf[BUF_LEN];
 	int len, i = 0;
-	if (firstDir == NULL)
-		return 0;
 
 	len = read(fd, buf, BUF_LEN);
 	if (len < 0) {
-- 
2.54.0

