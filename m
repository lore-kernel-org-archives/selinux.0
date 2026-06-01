Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7A3B95EC
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323370; cv=none; b=oiJEOd17H7pmXZdNpR5RTVn7Lx9ppP+PMXFOWKdPNZDz9IFrc+V/bTsg8VEDDGd2qivebrpveJ6/cQb/TAq/PA5wC08dBQ3/P7v32b7OUgVAhAZJHC2+eUtpOWqm+QbYIYd7QuFzWmjiyxYgzXS5YsUhVRfvvYZSRGkNMEl0lq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323370; c=relaxed/simple;
	bh=t7MvOY59coI+xDKcWv1vndOhbIIzyggdr18tln1Lg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKbrlVzYiFF6qlxNYk6lHtb7CbivIMSpbvNG+YOPxO7a1QmZay0Z+bPhknh3vJ2o68om2uxmfKjhg80QKZeLxUKNMkSaGt75J/mBxF1eSG+xrTKJFCt4GNXiy7oH5UFwByG+BVALQ9/5wKNV41boML46Lb/gqgl5Dpjd3Vw9Cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpMidY9W; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpMidY9W"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914b5f85129so879015385a.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323368; x=1780928168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTVJod6BHUvrZ27xKZuZWrX4MFXsECIKhgoWvOlfX3M=;
        b=LpMidY9WeBXjEsfjuKMtw+PiSxcRqeM03/um1dftsyV6NUQEae1Macpx5SJugaF3IP
         9kq9lM3ZPOf2ehfdEte3uryZe/QSXp+LHip51NULX2r/pnqZLgAEwBfLJLjjrbOx+77e
         zmbaZAkXK5HIADkfOdTbK4QFcQrX68BdwgPlDYVKAJO77OAv2ZpYR8PGi64F+tw1vGIY
         1zXYY/b0EHhlBBxakPEzS572xeYIFx8kqmp6bOdcvWj56IP1asL7bLMzie+AlI4KLF5A
         oN2Kt96VuOBdvANsgL7GdeI/zWpimJcEEVzJ+ToxBz8ZH+H5C/hc2/xoISX/arkd5Q23
         AF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323368; x=1780928168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTVJod6BHUvrZ27xKZuZWrX4MFXsECIKhgoWvOlfX3M=;
        b=c3Q0u5/Ym94UHfI0toZggDlmy4xi0fIwKplgnxm9Ww1+r9oG8q3GlnkXcbWPf4Flxq
         UliWMQ0bXisFDBWYk6xlcTCNgIfPcJ2rPbT3N+/kgwG7uKa3ud8i/QhO71rPD+l5XRaS
         S8OIjs3ByF+GWGR3Q52CypfQehDX2aIji/he+62Vwt1EEofPwom57IcFHn9ArFpFtN1x
         umdMGf/VyKlbpl14wLKcyguzzhGgb55yHUUlENluHkEgui+1Etcx5aU+IIu6TATnk3NB
         cjHmgw5NKwjtiJR2vwOms9tFHSD7/eeodPcvafIEQi0Wp1+O/nImr7PgCi3MIkafqOoC
         pzDA==
X-Gm-Message-State: AOJu0YyOHAMJ+daOnwCPdbpwL4TF6sXDlC2SNTb6jdJq0bW9wPSZJRX8
	oMrIJWR0LGvaPNhCJ53AYMnIuU4cgjnH5k6yE++x9o7TELtXVvdMthiUIFTDiw==
X-Gm-Gg: Acq92OFykL/vR+7pA060I1g+1zn34DfWCg+mhBuofesXhF+x+pFMdsxI13J1y7OzOqj
	kfbIWSEQQtxwFDpAPDfC8mmyKObdYocvdxCR0FcHBX51JCcqyegta7PzSMaAec+Kp+WeZy72Lqz
	FtO5lvlZKWxOZ2zh/RyWe41QNdinJqMkCpFP9fnri9gVBMTbfTYOVo13AsfgEuRnYimQQl1QS0l
	OffjyqVI59+961DB9JQPHagR+CYINWyFMBNeKOoZpJTMACDHtxkI29gOolJOgEmRYlJBLPnMXbU
	s9p8p4yyIQC65jWiMNMPKqGYSDceDA1cUX05z0PTq7HLxDYc/oBqyEs6l4Qoud5WD0H31wn1kw4
	dGuJSWWwmcbJLW7zbsLj1PvJZc5sn2WSqbDdSoYj/kByQVJeFOGv6EPhZwPMeOQu/T29tBPga4q
	kpf3D+Qdd+K3c/CEwrq6+Jaqlf3+lrUI7M9T9IhazHRBhOk2adf2FwFwdd9I0rG/ySkJslr5Tfh
	2AK8O15gNjqrXrHBHScuaqkXJX9nVeJrrEcdQ==
X-Received: by 2002:a05:620a:4711:b0:914:babf:9f54 with SMTP id af79cd13be357-9153d9f8a4amr1700767885a.34.1780323367868;
        Mon, 01 Jun 2026 07:16:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/6] libselinux: read_spec_entries(): handle nread == 0
Date: Mon,  1 Jun 2026 10:15:47 -0400
Message-ID: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check and handle nread == 0 correctly.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_support.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 3cfd92ed..d7636f87 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -80,6 +80,11 @@ int  read_spec_entries(char *line_buf, size_t nread, const char **errbuf, int nu
 
 	*errbuf = NULL;
 
+	if (nread == 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	if (line_buf[nread - 1] == '\n')
 		line_buf[nread - 1] = '\0';
 	else
-- 
2.54.0

