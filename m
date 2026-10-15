Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BF231A23
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043388; cv=none; b=eJYIkUTP7T8KJkJ3rfYiAtOiEe/SQlcE5XkSb+2XrWu9ufs6Fjn80Ppj9ncfTw+JoDeo/LmjiwR34wTuCLJUJtoW7ADBqcMoW+bBVqvktzmwWJaPB1lebCauO8EUYqsYBBl3nXrs5O6XDVXB5N0ZZf/Iceq8Tz5+uWDTb/EEns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043388; c=relaxed/simple;
	bh=dFMYBXM/P37gO12o4ynYNTUpAC/rccoZtVXfUeqP2Hs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Geg3KiueYt4Nb+c6Xobn/ARGkzwIQsg+pSOoDurY76f3LUdQACw8FSc6Muzs6UY+I51P83ByXMhMHg0bYcmgh0zUlMroiKnwB5Lj2GkXHItUUpGEtWj107roCervuvS0ZH8+G/93fGAdbaWRbI0KyMUB7d+755jGjoy0cWTpR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvrnKS3x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvrnKS3x"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso1934624f8f.2
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043385; x=1792648185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwYuK3m8xnIp2zig0dcs+mhXGmSIEd8K/KMKsO0RE1w=;
        b=VvrnKS3x3gafL8mqjv0RUcr3uL2svWu85ECrDT+A6QmVAWL/EGB4ruwCMDDcHrPtXy
         yEFrh8lOCeX0dSHPsHmGbRVTmJRvqJ9aR/EK1HF/DwbuhESBouwi+0gnmP9LKnD4099k
         h3rhyLamltrbfov12qB3KIcdgnmR+rFLIBHvNSQjbSCvciPu1enaHeIFFevyrOt+ZtXs
         luTLyrS5+NQOSep6ZSQBC3LuWwmi5QKE8jH1KooU7DtPGyL0viJY2Ae6HJMLV5Bi+Dm5
         pCcdMx6HVtIJsVc3teCu4uQVXQ+R2aVGz5Ec2XUJqr56Bs+OkEbJHSV2/KWHppXctHB7
         2CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043385; x=1792648185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwYuK3m8xnIp2zig0dcs+mhXGmSIEd8K/KMKsO0RE1w=;
        b=TTO92SYoHCfFMVbnnR/yOklfQrzJMWAUGtdcdDX6QnBAadzmJvq9ArPMOwSO/JOYTl
         5QmZOZ7gfeqyHlD+Kyk0r7cxgdYyr83S2FN3Lvog2I4NcEVhxAqJ+FfnkSmSmWT1o9Ti
         x96jnZL6VgzScmUN8TljPxy3I/UMq5wYPcmbh2+3HQkf7I5CvbDegLYQOsQW8SO1cfr/
         aT2Ir+TxJh5uMwI7iJACZx0OtSRwYRdKNjyQc7MPsDJo99XTc8oc++MDTp3iiV4SpaRF
         LEcFu7RdcX2B0p17wCjwqylpBnLaUi7aoRoQjKZ7qaA7zhOnsvSVwAjbUtWTMHXOWCtB
         a9pg==
X-Gm-Message-State: AFq9FYKx9GtRMqAzVoYXlmusc/WoBEnhkFQ+t9R7Bf0LQIY0btVM+rw6
	ziNGwgvUEgYN1R0+kFzRPOA3y9/UunF6RKvOpuHUydjMBK2ittNKNs9mx9g7BA==
X-Gm-Gg: AYBFou38vmkbsIkP8nQrdEjdqVx8+e4BAdAxzg1KD+iK9EsyVNW3TshVixMEocxoMhr
	kRcIAlSjOanZ49IyM4PHjzHrJY6L4oMqe7s88VgTyaeHooW0RduFDFfy0j6RTEohC/2kd1NDxj6
	33LpUxtt8Y9piwNxyYpnp7j0TQmdTqSAXZMlg9wCbhDXf18wBxHjKgZ1jMNg2A+YGr/K8W5O/S9
	iiu/BtjkU3mhR4wMLs7odcua350qWb5pxTgepJAzQt9lYLydrZuNgS9hoPjD15WbqCvvRBWIvod
	KMNhEHUGx9cd+rueTh1ciO9B8neiqHU5u+GQYu/OWcu1eUDRxmHGNpHxCoOxXKPLkGyxQLhPOb2
	pZlbbAzRE5APpCXRsIw4zlWF6KKCxolkm6YHq0raVR/hUzZECk6J+cD/KzLnhi4X9JhDm+HI8VB
	VFXRARrL1xGco7X3nr+tj2VPNAMMaI9eJXmLSj84sgkXgNxuaw09l7y63j/O2fF8oRx+kGKbIBR
	epNYkCfCLgEEtE=
X-Received: by 2002:a05:6000:98d:b0:48c:4a62:9af7 with SMTP id ffacd0b85a97d-48dbaae9e03mr31309335f8f.28.1792043385089;
        Wed, 14 Oct 2026 22:49:45 -0700 (PDT)
Received: from omos-acer ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48deeadc0b5sm6901587f8f.6.2026.10.14.22.49.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:49:44 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 3/4] tests/filesystem/statfs_test.c: fix a compiler warning on s390x
Date: Thu, 15 Oct 2026 07:49:31 +0200
Message-ID: <20261015054932.845406-4-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054932.845406-1-omosnacek@gmail.com>
References: <20261015054932.845406-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct format specifiers and casts to make sure that the code
compiles and works correctly on all architectures. This particularly
fixes a compiler warning on s390x, which is now treated as an error.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tests/filesystem/statfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/filesystem/statfs_test.c b/tests/filesystem/statfs_test.c
index 310b66d..fafe686 100644
--- a/tests/filesystem/statfs_test.c
+++ b/tests/filesystem/statfs_test.c
@@ -59,7 +59,7 @@ int main(int argc, char *argv[])
 
 	if (verbose)
 		printf("statfs(2) returned magic filesystem: 0x%lx\n",
-		       statfs_t.f_type);
+		       (long unsigned)statfs_t.f_type);
 
 	return 0;
 }
-- 
2.54.0

