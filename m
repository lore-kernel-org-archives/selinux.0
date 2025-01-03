Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00C186A
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898532; cv=none; b=VFMFxwI+F0NoO2NW2ZTorDXqbi48T3CL7oyKtvP8XEzic5hs3itfdQbtafx0RwZdIMRql4NQ3wl8HuQ2xbNRa0ZJ5I9hKqyQFGBh/5soErl/8u1b8yRPhPu3ohxqte7guK/SBXPLKA8CS6ZDiDwLvA/WsUsD1TeuOUj7nvOwhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898532; c=relaxed/simple;
	bh=tcUzTQ/bkJ14MNeIiB6ZMeZx5pPx85VXQb179Zj6oYY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lifK8TNYab0hytXmsosi13JZ5B2758dCh7Pqd8CeO8Fo7mEF5bTWLMGhmLxrN4MkyetFgtrJss3NHxbj4uDglF0tWTbVSWASZbIzmmOhso70UMeR/OY1Z52m+OBS2GNOOYYLTDy0PosEhRKm43pjCke3SoyrfUIbOt6uVXWl9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlCXhbjZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlCXhbjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735898529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PWdpqWR8+NCysH4Wgw3wwJR5dSOWnXip2a0cFupwcfs=;
	b=YlCXhbjZ1vJmSW4KLl17I3xmICUJJRBV1NmxdSfITb+RyZrdOfBIcWhH8tM0Vh8Emdbk8u
	Vdwu4qHcbBzvaSJ1Mbo/6eEbQMwByQY5q7QCU+ttfIdv6mCsKgEI+FLXFOfVD7c0mCzpIW
	AoOADYMdm9qQE0i8FpP7P+KHVcvUngI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-P3OHqexWNc6WmbReAD1VOA-1; Fri, 03 Jan 2025 05:02:07 -0500
X-MC-Unique: P3OHqexWNc6WmbReAD1VOA-1
X-Mimecast-MFC-AGG-ID: P3OHqexWNc6WmbReAD1VOA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so64458555e9.3
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 02:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898526; x=1736503326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWdpqWR8+NCysH4Wgw3wwJR5dSOWnXip2a0cFupwcfs=;
        b=Y117RKQsTgttcTRIHM5mWmMUKelrOXqGn+9f04EAeQfO+azXJEVm0XLdiMtbxUFDcY
         9ClC76UFMBYiE5sOsdvjb0s+wy20mL2hozKgHtsXva6pyAQoeg7z05TzJIVldV3CmE+g
         XEkwFPsTwma4eUdtdgKFEErWcXXIpESt8TJ5nr3dyMc3MUTEuj8WQNSN0krv4SmV5Tpm
         rfXTbSnlh8kY3Wbiv9IwJV/pa6PiUEwoVK6HMxD4YgZkaagNb2nTM63Eiyvqh59FclSh
         8NzwFVkQLalQXzG/vGNfzDsLLkm31t1dhyj6mJu3M8KR5gnShElXITYvDIrtGROMEL3L
         Y8KQ==
X-Gm-Message-State: AOJu0YyCxwGJsW+UAx2mWOrJsgDhkAKksPOU2iThZY3SY+8Jq81GkcJp
	0ooYTt5sBhWamOTIobfl8aW62yi6a5d3plnHW+pVpZDdwPuDco7hKAOKWgk+j6IZG7rZOuP7ksh
	Up9iGsWJ3PZ5BfW+Af856YihFV4/52AR263LZQlewUTO1u+z9f0lUXel9Tbd3eyEAOeZx2kBVI+
	dwC7wxA6pTrAxSbQk3BIutuDRhXKmHRClixz79Neg=
X-Gm-Gg: ASbGncta/dq84bFMHB4eARhwZRGst+J4YNQHPQdxFUm7dWOvFVxqZUHCUW5FrjsXxqK
	HiaEUKc6f3sLrqhgOn/SQqRui/Wu/vWQS7exER9hsqckCX30osBIMKJfYRMgRL6CVdi4FqJtYLe
	VBZQgyH9f3Nwwc4R+RHQDgeeVgmpt1zeBO1nV3YDVnBwSYn4giUlw4FSxT75NBBAwd8r/5vAlB2
	e1940iKf8ZL1ghqYTWnjtbTj9j2L22cqptVH0dEP05nptG5RR32csr0RqhmweLJJojle2PU
X-Received: by 2002:a05:600c:1ca7:b0:434:fe3c:c67c with SMTP id 5b1f17b1804b1-43668b5e201mr378012725e9.26.1735898525771;
        Fri, 03 Jan 2025 02:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH68lsMP+yTUzLt2suq/RQ7jzKCtIwWPcWVBKfB4kAvOhZTHhe2weXHEc6gp6XZVXfT59dhXA==
X-Received: by 2002:a05:600c:1ca7:b0:434:fe3c:c67c with SMTP id 5b1f17b1804b1-43668b5e201mr378012325e9.26.1735898525261;
        Fri, 03 Jan 2025 02:02:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm519175535e9.1.2025.01.03.02.02.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:02:04 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace 0/4] ci: fix and migrate the testsuite part to Testing Farm
Date: Fri,  3 Jan 2025 11:01:59 +0100
Message-ID: <20250103100203.32580-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the current MacOS + Vagrant setup isn't working reliably any more
and the testsuite itself has switched its CI to TF, do the same for
userspace as well. Also fix a few other CI issues while there.

In the PR the testsuite failed to run - it seems that GitHub doesn't
want to use the secrets from neither the fork's nor the target repo's
settings in a pull request... *shrugs*

However, in my fork it passed: https://github.com/WOnder93/selinux/actions/runs/12376819131

Ondrej Mosnacek (4):
  ci: use Testing Farm for running the testsuite
  ci: update Python versions
  ci: add missing libbz2-dev dependency
  ci: fix pypy conditional

 .fmf/version                       |   1 +
 .github/workflows/run_tests.yml    |  39 ++++-----
 .github/workflows/tf_testsuite.yml |  17 ++++
 .github/workflows/vm_testsuite.yml |  22 -----
 scripts/ci/.gitignore              |   1 -
 scripts/ci/LICENSE                 |   5 --
 scripts/ci/README.md               |   8 --
 scripts/ci/Vagrantfile             |  48 -----------
 scripts/ci/fedora-test-runner.sh   | 100 ----------------------
 scripts/ci/travis-kvm-setup.sh     | 130 -----------------------------
 tmt/plans.fmf                      |  48 +++++++++++
 11 files changed, 84 insertions(+), 335 deletions(-)
 create mode 100644 .fmf/version
 create mode 100644 .github/workflows/tf_testsuite.yml
 delete mode 100644 .github/workflows/vm_testsuite.yml
 delete mode 100644 scripts/ci/.gitignore
 delete mode 100644 scripts/ci/LICENSE
 delete mode 100644 scripts/ci/README.md
 delete mode 100644 scripts/ci/Vagrantfile
 delete mode 100755 scripts/ci/fedora-test-runner.sh
 delete mode 100755 scripts/ci/travis-kvm-setup.sh
 create mode 100644 tmt/plans.fmf

-- 
2.47.1

