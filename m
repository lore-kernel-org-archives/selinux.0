Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762942D758
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212979; cv=none; b=tJfrbQ0Dxs0EgTqe3I8q1n8+/u/4365q3WAE6U3rQk5K2XpAD8jGlmKg5138xRkrOOZ1fY7I/0T8OcmkqJTJ4HJMzOxy5r+/lqZtcIZT0eiKWpxJ4PVw41BRhBaxn/1SC+4MeGE1hrTczn5fz5hjXfWTTbEr281hx5aPkos0bZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212979; c=relaxed/simple;
	bh=d/6V/XFaQOz5pSO1ohYgP73mUcCQkdeW5mO2JyhLxhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsoWGlT0iA8ncq2WlILCWObNA2r/Hqb6exFxp5fLpfchACPZUzQiUKnGx2Q8p9oxNRV/tJnI80Slc3RzTvKXNtwNa3HRx/OY5Uo4Dk/yp6t4G0trkPSLCAMHzgRvJSG+c1rQEYkLgturPxZF9XsjhBNY6FTbX7C8Bcc0Oi68nwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csHDGwYY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csHDGwYY"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2a818fc4so54743241cf.2
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212974; x=1784817774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9Hcgmx1ubr1HUVtit3H13ijpwy8lGjnTxaW7fkOiNg=;
        b=csHDGwYYjbOqs7X7gIJ3gRm0TYqIjA430/o/gseW/rsP8BhSf9SJO+EjDqxBBhPsDP
         CHvuH33K6/sMHLHpzknegoe5Fs7S4AaIiA9Saih4tsOBvBwRNPit5SOKsCkXuRIoEJWG
         0Dmgtna5zBupbE4kBSjgb+egPQYdRAzNbr8O+oZLFIA6CCAj+EqAaSgh71IFSo3ASTSD
         i7eb2fwyMfPqyR1xDRAW9KKDP4WNu6x4hqChn01/iqU7jLogWH4aECEzthqyLr1/4nu5
         lDKc6UI3t4RD7thCg2I93btIMnsFUoXV4smnb29DL8xB2y4bpilYFk5Clsaupr2p2Zx3
         VeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212974; x=1784817774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9Hcgmx1ubr1HUVtit3H13ijpwy8lGjnTxaW7fkOiNg=;
        b=s87Vm6Bl7JX4w1Y6glVkxR/9uT3+3t9xFOyGcbS/KoyYHPKYykXUPxF7EC4YYFB+AD
         tWrJHGQwwboN+XoEH/gCXT8+7Z7+YXgRcXSABezM8TS8Nm8/sra3BPRXzhaFcH6qYd8C
         dSmXANh6KITlVOtzGH/jICJ5UOQnh1KJ4CtM6LtyJMoF7fhx5s2uM4oGxnogGF3XOnwl
         fXFtEoxyQVaRedy20+N6SNANUqcJByt/5AZVd4T7OUhAt5jQGjVVErGLYHv/DrmQNRdj
         UwdMnJJ6YTwTBoN3hx2tKXJp22YI7252zEiKoUyMUinamsT8guyx2nL/Ov/5sRJr7FFN
         VdSg==
X-Gm-Message-State: AOJu0Yw866+Tv/xyC7gx9ANkSIOlcdUps4itb+FHB6MqJrW1j8zaLbop
	ggNwDqbsvBLRfhS+FuxjQ0vhF/zBCzqtfZTwV+7WIy36gI3Tnu6BtoZ7woH4ZQ==
X-Gm-Gg: AfdE7cm+mF6pxzux5Ylo6PCsPyYMeBVy7j1dIx2WDuiT5kUjqZ2t1WxT2wq+Y43AyYe
	TQr6L/JQDKpBbAyyuznBWz8VkLVOQ82YM1nqNLQ5msm/zeThIKIMPhaQ0e4gbWWl+FPz5PxE2mL
	jBzokvnVOGH9uTevkKzYTPzn/QJHgXW6yRlwTTfsM6iKm4EP2Z5Gf6eIED1VFGOMpJ5CxHAyCbX
	Yz5eYN1cAIaNZFu9jpKTkF0LpJVGQcfWy6mFIshu6F1p/hL5sL4ljH6K3dYwSlhuZ1R1L0MoYh9
	OS6PbevYZ6m/ovvpDF8iakjJjU/XhIGkjhzOq/PuPWF8/vZmFkYwwCQz37MrsmHRqvEWZbwERK4
	01DfMqGupeq4Mx7l/v4/vLtjOOltVUy8KjS7stC8y0mBNSbgt02gu6RBgQju45LThMgBGTKkQpD
	ouohlUj3dECKGbEZfegmRPyHRlb65HVUiQnmZwZoixsDOUNr5Ep9ON5O1bk6VFCB9NBHYFqy8e6
	h27Rw==
X-Received: by 2002:ac8:58c7:0:b0:51c:9193:fd9e with SMTP id d75a77b69052e-51e4ede8144mr76035401cf.15.1784212974248;
        Thu, 16 Jul 2026 07:42:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm160238101cf.22.2026.07.16.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:42:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/hll/pp: use argv[optind] appropriately
Date: Thu, 16 Jul 2026 10:42:39 -0400
Message-ID: <20260716144239.8681-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input and output filenames are read from argv[1] and argv[2]
regardless of what getopt consumed so "pp -- foo.pp" tries to open
"--". Use optind.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/hll/pp/pp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 7280a70b..08d2c56d 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -90,8 +90,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc >= optind + 1 && strcmp(argv[1], "-") != 0) {
-		ifile = argv[1];
+	if (argc >= optind + 1 && strcmp(argv[optind], "-") != 0) {
+		ifile = argv[optind];
 		in = fopen(ifile, "rb");
 		if (in == NULL) {
 			log_err("Failed to open %s: %s", ifile,
@@ -104,8 +104,8 @@ int main(int argc, char **argv)
 		in = stdin;
 	}
 
-	if (argc >= optind + 2 && strcmp(argv[2], "-") != 0) {
-		ofile = argv[2];
+	if (argc >= optind + 2 && strcmp(argv[optind + 1], "-") != 0) {
+		ofile = argv[optind + 1];
 		out = fopen(ofile, "w");
 		if (out == NULL) {
 			log_err("Failed to open %s: %s", ofile,
-- 
2.55.0

