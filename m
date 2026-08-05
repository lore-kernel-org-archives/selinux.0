Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93593D47DD
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961480; cv=none; b=beyC0mDlG6fbk9jXhYMUuCO3703yd+nA+nM9noArRF5NDFci5vD1Qlz8G6/FX5EEnBQvnxyIXcgU2ZbL6/NIWIZIGATBiNxA5N+nRtmiZVKh4u7cWAAx8Uuwp+F0UfllCXBgOld8KErw9BGBgKyJ4VMxeOmhgKdEtuueDRWWe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961480; c=relaxed/simple;
	bh=9EB+yPueLE4eNzjZXRf1+qRGobDQDTE47/I1H9AusW4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=t4XQe2ve0ra/3mbiHj+pteTclH1kAb8noOXhyzxlAwqWWa0ebmaTIjWsCbdsxBf/ZlmdcDcYfY3rciSeRt2J+A/OEmHCbuH25M/e+hR4HMDbiLvvLvidoGGKa9ZAg54nk7gSqnatXdM4N2dhpORrxPFIpUueJa9sGFNc3pCyWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=faHtedTy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="faHtedTy"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e50a650a0so80728485a.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785961478; x=1786566278; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vZft3ZLAfDQnTWAJQjKv+QpX7ma9bE3TeX4kEGzSho=;
        b=faHtedTyx6SwTIT4rBLd6vzkdhr+xfJCGdC1xMbCeFX8oUrULq/suRirdTJacQH39Y
         Mwa61BQtoXiEyDDeXpHkLf46Wx6f3a7J10RyX/zUQAFht2+1es07Nc+7OgEhA4hm8ioU
         J42ImKG/DW1ou76ytzPT+xKmGvDJxI/aetsEe5cp7xYSLLYONBE+WbMg18Yd6bJl1vpE
         BzD1GBRg/92cv3XoF90KdFiOPFZxvAEzyLQffJKZHFcH7Hj+IFlq7bs2cQ2EACFOPOhv
         1DBqG5gIwU8KwuED2dNF+Aqfr4e28JJpDjwCh6w1Kl3foRZkFcNiGOLwZHWCXYFYq/Ce
         DS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961478; x=1786566278;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4vZft3ZLAfDQnTWAJQjKv+QpX7ma9bE3TeX4kEGzSho=;
        b=VzCmqkIiFqWrC3kGE459+D9Mky7O0K2PLXehwXLiGb8F5ichhMANwa5ZrifS/GQbAn
         dN+dWmNNTJ9Kl2Pji30tZwQAMdljUQ3LUNSinpR4N0vllMvvm7jNT/MwAryxMgDpJ5zD
         YlxheMICs1Ya308+kOLAbOFTZ7R5n90dAw3JvkfGFQo7s2p8cpPKgcnozNip62gKEi2c
         LAl7B+WUns31Ma9IxKD7yAad9k13WXjF4kb1Xq92LrGnjezySdrhNrOTVIQJfR86TZQA
         WhhCC0ML14ObyotLXYanwL8+VxUODntl3UnS0PO6IfAyWdvo7iVd11Jaaw9mJieenXaU
         co8Q==
X-Gm-Message-State: AOJu0YykZzkMoJUPNUFCR20FOvZJZRDb5Oynldcm2guiqU12OzBg+NVu
	8Ht1d2RYAyBJs4KlcP62KZSBRhIKhep/qg1McCSZvmFQShwiNwKweJ6Ctluf4xzefIziSb8J3vr
	FQbhIcQ==
X-Gm-Gg: AR+sD12Y6pMhoo3ETiOGb3gXvvam5d27K3qZcSMGNCTqRPZO9Qz0TIUDyflcfQ+YGx1
	eut4OoS38LM7HggFVINTrqTbAn26/IDCYJE+7HL8Col2ipxVy5rwMS2AVPPYZGxWWm+wJmh5MEL
	At1fbYzTYu0n/A54fupNteCKPDQtQT2GoGJ8V5kMWWtMOcfmPm/GUNdbt5MhTPgCJn4gNUrQWu0
	RWBaE31JtC7FL+k5uqNBDi1dVKdBlmFlAflZYbiLn/8FtzRBBGBSpCw3xUXbfXKVy+S+E//5zyw
	sxl4D7ouSc9qlU19C6YwxoBS2PsLdhEwiTtTisg9KWDhp3+ppXuuqD1V4mcsklSV9358WiQ2J9e
	jORpUoLS6yKUH5URNr5ECCtWX9rAfq+sw6XV7ggH1oFTvhf82xLw2UVWvVxWM7Gv1nhi/Peug4N
	7Hdru7cmVZ6Apb02eVZdo6sFKl8ogJCf0qJtcBGiyRApRzcrSAw/otn1xTLFKUlH52KRrkslI9B
	1d1ov6L+4dFnnOUndEftZscTf2z68Mogg==
X-Received: by 2002:a05:620a:1989:b0:936:41fe:2350 with SMTP id af79cd13be357-9364910443dmr875713085a.4.1785961477613;
        Wed, 05 Aug 2026 13:24:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365818c9a7sm82088385a.5.2026.08.05.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:24:36 -0700 (PDT)
Date: Wed, 05 Aug 2026 16:24:35 -0400
Message-ID: <e8381f47156a6d70a99d5a3c24286662@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260805
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Eight SELinux patches for the next v7.2-rcX release, a quick summary
below:

- Continue to improve the validation of SELinux policies during load

- Fix a SELinux regression caused by bpffs changes in v7.2-rc1

- Fix a SELinux preformance regression caused by SELinux changes in v7.2-rc1

Paul

--
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260805

for you to fetch changes up to 9c1cc4a7f79275ef93746f6247685763b475bfb0:

  selinux: check level category sets once at load time
    (2026-08-04 10:57:46 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260805
----------------------------------------------------------------

Bryam Vargas (6):
      selinux: reject a permission value exceeding the class permission
         count
      selinux: reject a class permission count below its inherited
         common
      selinux: do not cancel a policy conversion that never started
      selinux: require a class's permission values to cover its
         permission count
      selinux: reject an unclaimed class value in security_get_classes()
      selinux: require every boolean value to be defined

Carlos Llamas (1):
      selinux: bpf: check SBLABEL_MNT before isec init

Stephen Smalley (1):
      selinux: check level category sets once at load time

 security/selinux/hooks.c       |    8 +-
 security/selinux/ss/mls.c      |   24 ++-----
 security/selinux/ss/policydb.c |  108 +++++++++++++++++++++++++++++++--
 security/selinux/ss/services.c |   28 ++++++--
 4 files changed, 136 insertions(+), 32 deletions(-)

--
paul-moore.com
