Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340A286430
	for <selinux@vger.kernel.org>; Fri,  5 Sep 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111238; cv=none; b=T49TQE55jaL/UZ3pgjAo2ibCz56zfi3UZSg6iaMnDk7xqX+7jsEtaajPfdMxWcFiPpeb2hv2ovNN+QmTC++Pr8mf6SzBPJ6JK3xWw42MyrKTQUfiVH5blbZIHI2o3os0e0NCxT01dFbGkDvVFj0RxB7qnqJZtq2lMdXid+cvLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111238; c=relaxed/simple;
	bh=AZppQpwuWqYUy9syMAiud+b8ut6j2XrYuweM1e9f9cs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mD6X+kXR5Bq7gZoyW8Poh+0SSxoqCZxtGZEepaF5plbzyaMCPCvhl2E8jGdzHCMVqZoj5gvqHpWMbXAS1PUTgF4ydAHKtP802ppKq706ymEfvocvUMSNJU88mNBjFoO/b9GenicnD3/Ap8B667nj/SfGFkaEuFjFl5L2kiySVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYP0RDnn; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYP0RDnn"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-88709bc9a60so291432839f.2
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757111236; x=1757716036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WBrKuX2LN/XLXYsBo8MKK/22tPKbOLoG+RYV/aRIhhY=;
        b=eYP0RDnnSPUVrTmn4eouwLg8yo47tOJwsYKJSsjDVSCqOExJIOJZswtjNH57pjkrpU
         5YIVlj7XRzJB6K3FlfuaOWpMtFyrT2+5ng0J+K1nkCYUdOrJB/3oPRL7N25k/NTwaBn0
         nfs55z7tNc2tLD3NYJO4pecqvsYJaxsI377FizDGsaAnlImbuRqLfVsUcLssfwv01w62
         83Ile7Ih6rd1zNppavwGx/7qlHgJomun9AgWvZyDzBtu4qXlacRhcQezB5fG/MOWI/mC
         +C/M+XfwFn5IYTsGBNc7/au2AY3yus+FLHgCbExWj/X3zFFtHhFeBMiDQVd3pLUDD4a6
         iokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757111236; x=1757716036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBrKuX2LN/XLXYsBo8MKK/22tPKbOLoG+RYV/aRIhhY=;
        b=amO9tHIJf1JzOIH0L6WfqyqYgMzM5yP/sZwCbUzBe4lVTxn6v5mkyrwh4ziBxzJUsA
         JSIFBDihhC4z6cb0sunicpncUlJPsW/gccbGCttF/0UnDmvcE2VGb25GbDzevWiQsyM9
         eCZtSP0gqskDSinAZFTroESVjciNh7Q/4Hl1LWsJpVrhZb6G/ZlHW+unp/Nq18W+ILnI
         Zs4NAYQ/4xpDRwYnqKerWoAa8ZFC0dDj/c+duh9QbGQNbN7pEK9YZmsmBQVh1FCVBxkZ
         zPEzb6f47/SqjOnhB0O45kSkkQxxm95zTvrRpTydRvPGMwiy2XHcQa3OIGv36Kk8elN4
         IG5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2KreEnTq2W5hBlXGp2Kt8E4ZsWs0WNjTjb+eRjVhFYUQC+tfqfFv35p9vPoKqBXtMn59yZ2yy@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPeQJNZKrSIXTQ9Jt2VqW5D4RMyKSnfyUMunzRIWsfODVsB/M
	+Rb6SSTohBO0uqop9dvBDv1A0Ya/2/9tVMb0aqLDtYgFp8IXWpFZXABVDjA8XHXTGB4dRZ4mRCn
	D0Z2VHX1blw==
X-Google-Smtp-Source: AGHT+IGXSFXfkWoQEoRGV7ycAUlfjOG//VdVmLeu9tSMlVvNgEhGD2juMvgtuMG1rJACmxFDuGO2oVJYmjNI
X-Received: from iouw30.prod.google.com ([2002:a05:6602:35e:b0:887:7b4:58ea])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:1492:b0:881:87f1:7258
 with SMTP id ca18e2360f4ac-887774d8692mr70242739f.3.1757111235762; Fri, 05
 Sep 2025 15:27:15 -0700 (PDT)
Date: Fri,  5 Sep 2025 22:26:55 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905222656.3692837-1-nkapron@google.com>
Subject: [PATCH] selinux: fix logic issue with per-file labeling for functionfs
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Neill Kapron <nkapron@google.com>
Cc: kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch resolves a logic issue with selinux_set_mnt_opts when
selinux_policycap_functionfs_seclabel is enabled. The issue was
introduced between v1 and v2 of the original patchset.

Fixes: 1b22454bb5e6 ("selinux: enable per-file labeling for functionfs")
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 333bb6cba25e..0e47b4bb8d40 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -745,7 +745,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "pstore") ||
 	    !strcmp(sb->s_type->name, "securityfs") ||
 	    (selinux_policycap_functionfs_seclabel() &&
-	     strcmp(sb->s_type->name, "functionfs")))
+	     !strcmp(sb->s_type->name, "functionfs")))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
-- 
2.51.0.355.g5224444f11-goog

