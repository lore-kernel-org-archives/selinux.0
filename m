Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED946526
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CmHlAZfP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4277c62426fso11165561cf.1
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 08:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703091175; x=1703695975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PBFMc7OINIdxVo/2AVvaYSjKXKyCD4X7+pDaYqad6g=;
        b=CmHlAZfPSBsljq1jM4Iyyxd3Nqq3CYaTbEfsFOJ9elcimYaRZtzZJwT8kUHAQquPKD
         c78JntbmDpza3cBpXBloWU8b+kYguSQHJn0EO3rRhcAxeWcFBRKPiWFhUCh7AdXh3jKs
         RZSp+SGMNkKXU9r1FpTuAuGD1oc4OsygRgQ8oVYrE4yG99+G1+mv5CC8kS6FKHt24+0i
         Wk22wpF+XRkDyx36ltWkBH5VdySLOxj/SPvwKWr/LiKDP6dNuIfm+r6F8b/nwGArpote
         jI04a06Xa1VT4MJlCLJnS/ioix0gXPdWR+UNg/DIBT50O6LY0mqDtt1I3xSwN58rPwRV
         Z7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091175; x=1703695975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PBFMc7OINIdxVo/2AVvaYSjKXKyCD4X7+pDaYqad6g=;
        b=iRAjEp+OrzYj7oOPsf2uMgjyA/S3vB4PaRza4p+INMTVaLBgATL1jBkOcP1y91FSFR
         nMKoPa0Xv9ZxeAK8XMPhSbN78vqtsjT8wvH9SjqZmyc9Rm7yPCM/L2RRKYjk1WkJ4rSn
         h3Yn8smFitC3piPhg3EkmOTzfmKZgsZe/vF14c3LQSWFF0D/k1xirYwZNMLpJWs5Bhgs
         +2SZq5ipU8Ah7mAu3aICINKeprxX6QGgGzV9vd3pRin1EO5nHUYaipCNckz1ZWcfrkTi
         9R0nIp5Ncg2MVrZ9MgABx0m+Hi2feFo7P5hdNmTQCNlT81LCSoHSiG1UQtQjP8fvB86r
         jYSg==
X-Gm-Message-State: AOJu0YxyHCZtVHb/2byLbb+SmmZq7QOKNKp+ia+1VdI3d5ca2cXoiQYb
	LdkCOu1deZV/ztFZm7qHQIHfAzWlqweWK9fjYg==
X-Google-Smtp-Source: AGHT+IHSnBtNwrk4VZVwY8eLCXvZUVbUp8In3zdFhLoJUCnRqaO/MpFSpW9rkEMWjNaozAUZrrNfug==
X-Received: by 2002:a05:622a:1a0d:b0:425:97be:7ae3 with SMTP id f13-20020a05622a1a0d00b0042597be7ae3mr25439036qtb.52.1703091174749;
        Wed, 20 Dec 2023 08:52:54 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id jd5-20020a05622a718500b0042753010541sm35622qtb.51.2023.12.20.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:52:54 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] MAINTAINERS: add Ondrej Mosnacek as a SELinux reviewer
Date: Wed, 20 Dec 2023 11:52:45 -0500
Message-ID: <20231220165244.126550-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=paul@paul-moore.com; h=from:subject; bh=FvYcnnxSjOakS74pgmuqvCWuE8aYPkYyY7aY9FFeTEY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlgxvc0tDX0R//SljIgSEK4rBnA/TOwJ95PMb/+ S8bWqP4ct2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYMb3AAKCRDqIPLalzeJ c8TUD/4znmOoLPnx/oSnXZhsvqN2ooPRHbgDNDQx1BIYEWlre9i3YXxtNRDNitIAQN8F8/kBWWG V+kcshIgUKiOpyATIig+ZI6OSCQ5VtxLatH894PQRGgR1T2FFgN4T0nGb54EVjMJdCzjUY1S/t5 4zR6aLRnGUYWQKhWs7VWHNqBVnVHPWksmDKvuM0IpufkC2c+HVA6bP5etJrRKFI1F9NwJGdc9qk OVXL4dUloY1diDOIXrYBtZwOWvarsdz12UwhF7SZGel56bqSVmUtk2+6x52+JmqFvfDsk6rJ8Ik YSNnB4N2M1WhPTe43USOnWH185cg/qCScbJpA4M505Lm2u71VJe3aNQB3MDQmnijmGoAVxAiW2U LISsxw4wKvGdxGyd7YE3bzwJwf/ABI0Z0JEixshcCllJSuSAim1gTeNR43IEu6WeB4UpJ4bemMb bt5h4eHOt5WgZX3jSYh/PCRONOActmk3UjZe/xC1kNMGaep3jVPMOy+dzvdRGCKgT5aFoMZiXXK Uy1CopC+8M0n/Z8UZoVyynubMlGi8K/X9qezCvey/E3h/Mvs4geDMZkZQxmfX5A4a7bL7sc6kHI hwY/8FaIwEJzDxzvo5bPeymbpVtIMZnI5vKBMGVl5fQj2rzYh23dLYrRZZqJN264ieGRy2r+vOv b2it+4vHEpdU7eg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add Ondrej as a trusted SELinux reviewer.  Ondrej has a long history
of providing quality SELinux kernel patches and we're lucky to have
him as an official SELinux reviewer.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 931c52cc8393..295939417dc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19518,6 +19518,7 @@ SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <stephen.smalley.work@gmail.com>
 M:	Eric Paris <eparis@parisplace.org>
+R:	Ondrej Mosnacek <omosnace@redhat.com>
 L:	selinux@vger.kernel.org
 S:	Supported
 W:	https://github.com/SELinuxProject
-- 
2.43.0

