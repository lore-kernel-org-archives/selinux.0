Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204911A00F8
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515278; cv=none; b=tangBpmNL+e5LcJdLo7bb/N8VyeC1n21zjh/9kejvsL8vsWTCPfUInNfBacUlOuTIM8pTPCzYEh3Yne8k7j7nvLipyw5dwXfBHxOvprgYBlV9NBBxuTypdq1isJMXuW1wwZANlGsNYmhc9uDOZrqwmFsb4Xs3+P41iVH4AfenVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515278; c=relaxed/simple;
	bh=akFqatchn0EDyxLmabAm9Mqbyu6IBUARnMCNL0MFudQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jMzMGpE611P7isWbtT3r3NDQRYw4spJrnxrq413K1XUzMsuT0tKqop4mvkt9J7Kluax5QMovPIQN4VaGo2ygCnzrprShadNWhv4Ci2YJDo5LtMN20EGCNhXeUj8fDlE5d3w+r1OdeioYIgendwvXWsxg6zjchx8e2Cq34T+ImJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcRD1e8R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcRD1e8R"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so4521237a91.0
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722515276; x=1723120076; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akFqatchn0EDyxLmabAm9Mqbyu6IBUARnMCNL0MFudQ=;
        b=RcRD1e8RPEeUQJ9Rvv9bmUGLlZp/L4N0owXyH01iJk0YSABAb98B1+W3qU+aQI2RGj
         W1/PCYd//kAgenDv6sAbAkGchHrEwekpEZJth6hEDqYRYSZJREmF8I/yTTyosCMCyMTo
         VbYT+8oKtc5dafrjq7Qff7hLGBXbd+MWCd+PxtvAqjCirnUxlWHUzNYcyev4iWsb2y37
         mjrhwtUmzgQnbl3tOK29yC3u+b+OstAOiF9wMKu0kWI6YR5NPaKstWoSUZ/Zi9jW1eB7
         xDUWsjwbtkBVyWTPknyzfespHG9NLdqT8yElI/Dpt5+nEn/YcRUzAvesCgx5ZUfTv2GO
         OOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515276; x=1723120076;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akFqatchn0EDyxLmabAm9Mqbyu6IBUARnMCNL0MFudQ=;
        b=hDsyJzsSYMHlFluzlw3fX9ipCvof6piFsonGS07nCCR2YXVGp9fzKpdZss5tldegT5
         gVAioG+KTP8R4/lmy6M8aSVeXQpDHw4vyx+IMpu+AQ6apC+Zis5G8UBVDpHXoIsM6CrH
         ihN0hj/kUcP7o66WwqpVIta76+nFpUhnaxA6INtgi1jloh5hpOnyItrmVPjhvB7zMlGJ
         4TrbDMWQe5Lvb27ZAW71KwLOlJNV9FvwtefrVo9ENBf7koevtYJe96hEwRuFr+EB2Bsl
         LWaEk7lO30JQQpbWXvDKU1qkpgV7htZl5z4/zlWqFhw7c33dY1AQ3eTNB6vcqNf+AVJe
         9wKw==
X-Forwarded-Encrypted: i=1; AJvYcCXJfBrdlKJt/9khsUraMtvlKJs6bSX2O+hTdr1+SbKpcP0a+/9GNsD5m1ksbNjtfzRoA9ZSqTVutwRfGiN4+32IpKbWFHsXQA==
X-Gm-Message-State: AOJu0YycQd3h+46TZnJBcqFw4qp1hIJSK9K/zKlL3OFnla7aVeyFThGR
	T8iiPGEh9PqFI6H4IuZeK0ylT0M8l7Jg6FR4S4R2HZRLWLeyb99k+GldXEPozAmjy8j/u8nbtev
	DKCvsTcKnIFfwu4lIKUC2DA25y9aQB/mI
X-Google-Smtp-Source: AGHT+IHRQCwAT1ILlC2N41PiQtWNPNQH54CGTmZ363Xfihp1nzrIElp05XAdM5PsEK5z09t9QAamtoAvYWHkGj4Y4m0=
X-Received: by 2002:a17:90a:4b81:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2cfe7b18d55mr2725927a91.30.1722515276282; Thu, 01 Aug 2024
 05:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Aug 2024 08:27:45 -0400
Message-ID: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
Subject: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Given the recent discussion of the SELinux namespaces patches, I
re-based the working-selinuxns branch of my selinux-kernel fork on top
of the dev branch. This required first reverting commit e67b79850fcc
("selinux: stop passing selinux_state pointers and their offspring")
which I had created at Linus' request some time ago to avoid the
extraneous overhead associated with passing those pointers when there
could only be one selinux_state structure. Due to the number of
changes, both substantive and coding style related, since the last
re-base in 2020, there were numerous conflicts that required manual
resolution. I also checked the coding style of each patch with Paul's
scripts and fixed any issues introduced by the patches along the way.

The rebase can be found at:
https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns

It boots, passes the selinux-testsuite (including the NFS tests), and
passes the following
trivial exercising of the unshare mechanism:
$ sudo bash
# echo 1 > /sys/fs/selinux/unshare
# unshare -m -n
# umount /sys/fs/selinux
# mount -t selinuxfs none /sys/fs/selinux
# id
uid=0(root) gid=0(root) groups=0(root) context=kernel
# getenforce
Permissive
# load_policy
# id
uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t:s0

All the same caveats apply - this is still not safe to use and has
many unresolved issues as noted in the patch descriptions.
