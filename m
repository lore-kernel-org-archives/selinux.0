Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5E2797BE
	for <selinux@vger.kernel.org>; Wed, 28 May 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453283; cv=none; b=WC+CVNQAzX5X0WPKRs3vKv/gBGFTz3Gohbf9Ne1J1W+52sfcz9sFsVD1tBrpLShBYylukg5Vj1F/ji7dOaJje9kPKgqlpr6ePm34Nz/8jc7jOADS5u8dasOjBGqjNMaxri9L88ej7vLFs8hhWPJ3dXTAPFHyQXV5mXO/OnlCSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453283; c=relaxed/simple;
	bh=TXStWabHCV5OH33n5IxckXUYPGUr4lF+nwLfjBj5SdE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mNB0W/x6pcHVNN3JPiTlcpbZKfPVukl8doGQdCujuUkTfyN0yfd34jVdgp4K17XNvhB1mNbZdPqtHMxzGWVYrYIQn2ePG3sptNHq4Kz+zokgUaXx0WpKwH3uxeUp8jhl6N/faSZVg9rl09iPTCLG4Xu3Xr6qn0q6qYk+jVcX+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE8qt3wv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE8qt3wv"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312028c644bso12274a91.0
        for <selinux@vger.kernel.org>; Wed, 28 May 2025 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453280; x=1749058080; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXStWabHCV5OH33n5IxckXUYPGUr4lF+nwLfjBj5SdE=;
        b=XE8qt3wvyFXlygw+ZihHiuPFsm/H316B8yTXxgIqqSf+HUVFobF2UsAQoMHosUodei
         fIa23SnWB6FFKO8tWL6Kaa7+cBdD9ClYErqiZQHmo8IO1wEaCBSuOMk19I1lgUSfNmIW
         qALNKesuu8kzdfn01s0xA6IgWTVWzefCDrmJIXp8y8td5n6XDh0UfWTUW4wjW5ZA2sJ6
         I6YuWJ/W1SUbWeMJi4lL03B/YN0A1koiuMTxXgZ3OPSeMOM1IOBxf4aWZaGf1sRDZ8iH
         7DDoBQ6D9f7pnIwD5UECisZOJrVh+j77Akj3qh9S6vkqVecjsZexgg3wnPbSUSn11BPg
         BS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453280; x=1749058080;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXStWabHCV5OH33n5IxckXUYPGUr4lF+nwLfjBj5SdE=;
        b=OHD6ZmG+2pCG7eDpliilvcLMeB7ndA//NOGJ/zZWhjpxq+1ElAFpRdoM6OmkVPBigD
         bK4s9vLtCZYETImOaEIJNpg3HnnrnntvqR1+lfxjAZXwEzMoM4N+4dngtFe5gDFUoTkP
         o9FrTa2c2uK/9VP4OpN+5pnrvFRm29dhgGCeOzEyrNRyOjZsOhVGpd2pJRKBgw5K28LA
         BcLUCCGOYJQeXkLTkbs9mz1iTGV4DQoRPBSBuIveMNtGybaSFYXz9mRj/S7s85U1F2Eu
         BGg2i5uDFLaXU7fdPzKCPPlwpm4WvDgOWnt8SdyLH16WtQqTMjg/xmkETTtMHr3vrqQg
         p/gA==
X-Gm-Message-State: AOJu0YwDuezwkvOnq+XSDRYNXHmrhno8r1dXpxu9ftbRW3QvIJgIheHd
	pDWrcnI+y8OjsuuH2Bh7HqlcNOkw/AKf+PM3NlzvbANQROzK1Oz2QvlOtG/HbEYyapOWD3udHt1
	Zw0FioxdHJ2euHP1JiODWdxjR7Hx/NeTN9FLF
X-Gm-Gg: ASbGnctpFW2qMuyvZln3gYXJiZuyNZU5XEQxKiDnzvKWAxzLW065TMLSESPPAU/bQxl
	6l5rjZndtHUNbf4u0tgqWHalo5zdMKDNjQBsQ+q4n2lUN3EKkNo/6k5D9+oJ1Jk3Roi/+ncodNb
	t+2rqkNUh12fJcHEGwutR6Ya5m2H5meIAA
X-Google-Smtp-Source: AGHT+IGRQEwqfUHYatr8Mzpzk1Dtxm+sw0gkD+Ux5MkuUaZxLD3L4S3kyeXZqp9Axv2ulhcThPUUW95iFZv60h7IUk0=
X-Received: by 2002:a17:90b:3c85:b0:312:2bb:aa8c with SMTP id
 98e67ed59e1d1-31202bbab62mr2977416a91.33.1748453280455; Wed, 28 May 2025
 10:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 28 May 2025 13:27:49 -0400
X-Gm-Features: AX0GCFvrKVfCpToAOu61r8PHXdEL6vEyu9RnHZbgTg_4zgYOlbMBoIDo9DOF-xE
Message-ID: <CAEjxPJ7LMSSCEG7r6bDbSrV16tYuttZ5bsEkTMJuuF7tWzGWBg@mail.gmail.com>
Subject: SELinux kernel getting started guide
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

A new page has been added to the selinux-kernel wiki on GitHub,
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started

This page describes how to get started with SELinux kernel development
and may be more generally helpful. We may end up deciding to move the
content elsewhere to make it more easily updatable.
