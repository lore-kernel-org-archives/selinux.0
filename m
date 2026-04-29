Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174A381AED
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482529; cv=none; b=sdRD2ELyyyvXkIHROa1zBZIbM19o/magtgmigQAmb5Jo6GTsjlr51DuDyvPtHAByH0Wufd0R++X3SsIeSWhwXs4bItr/U+FFUBV9HND/O2oS4NMnGfmumaObDF3M/gJwDpXkIloeYp+lw2m/mWiDslzkH23WqXuLtLZ+N8iG0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482529; c=relaxed/simple;
	bh=AVVfidRNkIG12FElfxJX/C4PYf8guPKAeHXfxOIQitA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dc0za4WCaxl8cYTQAtLWKuAXQDSJYLk5f2Hb8KwKKvmXg4uEFLVAin13/Xp70fCNFqK3Ww4x+In1gFIqIN4RTbx+f85rzFECsftJCSspAnaeVp2yeLx+2993I54Sez40HlIaselYVuBRj16zCUXeexXwF33iMvvcJPyhLg6wvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8n2RMF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8n2RMF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so564016d6.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777482527; x=1778087327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2houCxmp01jO01puxRMvWqUGgjmDqA1MRps0ecv2QU=;
        b=Cn8n2RMFF1uwYCwtGI+IAaz/czbyBV3QiR/W9I1t5TYrtJYlJltbMN5ivmNpwmm8o9
         udgvxJuqGeOKKIVReMetMDYzvXL78aCgdCQBdR5REnX8jjvdO+nUyVsluWgRpnZrWLYj
         nWnvM5SaZFQUl5O67rPGuysdqMoULA7rNf2sfIN6DxVc1mS6IrKRQcCCcsAAQvveNaru
         Q77934yFM2G5as78ZqfJrZZ+xS58nbhjWRq/RPWYyE8YsG/b3iQ+jFCei/05QxVIZPAM
         Ei0iE4+mCkUk8KaHPf8Y3ngqNsA9rwKXBssgateT5L4e55VCpE9u5PZjTyZ8TGULmEMF
         6JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482527; x=1778087327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2houCxmp01jO01puxRMvWqUGgjmDqA1MRps0ecv2QU=;
        b=sIvqT8sUbOzedJHOMgptYKbGhok+0C4/E3gEwS0LLgjzBm2OIn4qH3IIIFoSLvXdnc
         7Y9iNivlpoFOWmmT8rMVmdOaVuhI1Xm0P/V9H6XJNGrAjnrDKiMFJzogbzGEdBeHIKVy
         AYUtHpew5oJQQR2zAAFg1cfpX7obC/IpEIRiUgQDOUsh4cNdyEg+DqHn2D65aGbYJWA0
         A9v7Al9pFHWkYLs4t8xcMOfuCEcy/qnW/pmgLOvbKsF5DrnN+9VQs8Y/8RUlXjT8rQyj
         MO1rDn1Z5z+OD2hDAUP/Xq3uCa4czLU0CK4ccon6ZCVbA4guFvEHoRo6zDIFa01QhQis
         wWag==
X-Gm-Message-State: AOJu0YwA6B4IXXuVJLAQ6j1+YHym8oGAoq5mQ5u+Lxa0AbDLPycynjLN
	veW/nzplx+B7mFlTq7OiWbafTE3CMdItZaWOTsc8qTPBJmY+lDU9DU31fRkDxg==
X-Gm-Gg: AeBDiese+YbpyRe5IWPt2ozyrBQkSmVlrZTFnLjMwcfzJG+fj5TMDGViwXUpxSHS6sw
	e3hPawAYv0O0E4ptfT+dIQnQXIFk7vWijwJenKYBleMfn5QmT3JxqdtqhYW7ao8lNrChQRkjVdc
	yVVVfcem+5vYKtQPw1n83uppOfhHRy4n4K5rtj6pP/+S30syeiKgGN3Zq+cXrQEjLATS4mfCGsQ
	bfUpzwfrzVMX5yWOVXOAudwkcsE7xQSlLdzBS3OCMK6Tw4/MkRdF0RNONxeXrWK058UgvzaWNcl
	UaXTOPj3ublgOCpe37/u+M35fjBND2MEd1BTZjm3rw2uM1UYwT6RdaQeESGziYC+EDMUhZAsMNT
	5+39e6vVV/mZEp14w9D0Xvw2CZEeG50YNMBK5Lyoktk1zE96dP5bRtk0NWC5FZ4fqiN41Qp3Iuq
	39i7F+BeoD/+dBmM8nrhQrO5GLhXF35wLORUaUgoZu0sRnNBfJhKcCAbWbnpcSZgEl7e+afCRpJ
	eYibn2ga7ciT95gUhX8upr0W/cAtH2fN7oXMe7MHTLQk2Ybh1GN1YKbZLFe+NQnCQ==
X-Received: by 2002:a05:620a:4402:b0:8dd:b4fc:d561 with SMTP id af79cd13be357-8f7d6c4950amr1197895485a.10.1777482527294;
        Wed, 29 Apr 2026 10:08:47 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f58333esm225980685a.28.2026.04.29.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:08:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/3] selinux: remove deprecated interfaces
Date: Wed, 29 Apr 2026 13:08:30 -0400
Message-ID: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several selinuxfs interfaces have been deprecated for some time.
Let's finish removing them entirely.

Stephen Smalley (3):
  selinux: remove /sys/fs/selinux/user
  selinux: remove /sys/fs/selinux/disable
  selinux: remove /sys/fs/selinux/checkreqprot

 .../{obsolete => removed}/sysfs-selinux-user  |   0
 security/selinux/selinuxfs.c                  | 176 ------------------
 2 files changed, 176 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

-- 
2.54.0

