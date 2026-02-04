Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A82314B93
	for <selinux@vger.kernel.org>; Wed,  4 Feb 2026 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178243; cv=none; b=Bzsxm5NQgx91pumHZksoMIRV9OVMdWCn6c1cXZoi34RF5sHBfxyAr1WKcLWgslxRz3WZvfqfjPyBRvJOXO8d/2AKcX6ob9HIrouS8t7NB6QyBmXfBXLDv1wQZwW6etXbPFZkuh4irnDRAFw7+Opg/vUe+Nh5xttEfISZ5c5mVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178243; c=relaxed/simple;
	bh=zAl0WGrVOlcwJ6+0E2cEBC6ivgIn3WmGzzpnAjoaClQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=nC5Bxp2++BCoSchEKFWHEDBHp1E4wnfjN/bTGJauKAQz21LwH6ptaBDLLaktbmBp/ThjoDdtsYUecPP0YtGDHQeNxvCw86ahggsp7ipQIFsBqd7l54uus9KJM/DAp2C220U2dixmiTay98+20njjwtrOnjmgUElMj0Y1ON3zVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FbIsUqCD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FbIsUqCD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c70ce93afaso683047885a.0
        for <selinux@vger.kernel.org>; Tue, 03 Feb 2026 20:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770178239; x=1770783039; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9X0znTAy1Uzid+CyhH1GZFisTMJ2hpyJjos5mdZiPA=;
        b=FbIsUqCDeOJuv0FXM7HYFAcXBTxTnmKqqeMitiTSzY/JJwkHTY17Lu9KcUZpJNqfvR
         FDKlBbL9/uIvklW1ZMQ2U8bZuVttuKqPs8iISpVfq+MuLxbt0e8WBszHnBmUoVDdevDg
         H+i73VzB6+t4oqauQGpQH6m6xaFf7hNKOAYtUtyfCaxfJy+ql/XcUVQJVHdBgAnWTr4A
         7iBDoBBw7lRYRzje475WOeJsOTkYnjlMwu31SRxGYpmrCbm9Zn/Qmt8iX+df+snCSTPu
         7x/9+9Gtj3f6B5g/6ad1LFpRMCFMftZnouio8IXIxHYtOVjsYEI/KgYem7J9l2WCoe3Y
         /vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178239; x=1770783039;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9X0znTAy1Uzid+CyhH1GZFisTMJ2hpyJjos5mdZiPA=;
        b=UtXAgHaFzfB0PyyQuTHpdt5Vgz4G8Vlli1bF4Pib5qwcJZvgk5JnEWRgiXxjRg0MUl
         XOtXaDe85vnoYBKHSTuJI9M3NW/LBnOuNuGtKJJXysGKWpR4/q9W48O7Ddgj5zZbgmmo
         im7uw/fFnmJGOY3nxjgV31/I15nrsc4UgA3y18gVsJdivCQtyIOyf4Q8/usTvo9EvWWk
         3ZDAkWEiFbPI9tLlJY2a7yfv1gTS40NnAqK1aq3chd0MkzTjjJVSPr/nj4FmnaLimcX8
         REfOo294PMcJdeOnwYLeuycjlOKhjBzpSWLEQaHYMBBjwGpO6L/9gLlOa+e1Hzxcm1Om
         ZuJA==
X-Gm-Message-State: AOJu0YxlC4RGpujWGNVzDTPlAQLXGL/+MLeLHGj1euM0yR20GQ6VRYgj
	FUqfulLAa8SuipHk2K10OugIn6df1YPgR+CLrXln+4j8lz07SfeS4n1bId7MPKfOXg==
X-Gm-Gg: AZuq6aIbnOMyNhhty+hbUlqyI3y21Wvpd6ubOLmBCcn1JlGMfYp1Pd6Dd/gaiaP4nMA
	0wLxLrrO0VtDFR/YBiLB7DJoAkHsiSoHTm/wVEm13+4a1tDCTmfq7Z4xnLN1QqOKZQhB/UEMNZO
	6hAEVbVbZHpPuhdDUYCJw4NXK8Ne98tbSAkyowK588zMmGZ01S8OXbFsSVHy1ARWqRn4AzYAPk9
	xlZBxAWspCtChPW1Y0XBFqjakwyMpCL//NpfoTSpiCWE30MBHYYlJgtsVwI8J+zGI802Lc8YmTi
	plfghaz/IuyEK23RD0iyZyi3Njsxah301JOf4+xWIbxqYFtm2ybXdpnX5HP46VaxTMqGYxxTK3n
	J7T+AxXJSnVpZVJn7bYbOW4UD6PF6xhXLjp9Trl1W41iC3yPaz3Doy60EFXuy7THAc6mF9rOzz+
	b0DxOcgnjeI9Sk0uoX5gfs1dhwrGQ55y0876C9Imxdz2bR9IfjY/9moxQd
X-Received: by 2002:a05:620a:3181:b0:8c6:a64e:928d with SMTP id af79cd13be357-8ca2fa9055dmr231363385a.83.1770178239556;
        Tue, 03 Feb 2026 20:10:39 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2e971sm107019585a.35.2026.02.03.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 20:10:38 -0800 (PST)
Date: Tue, 03 Feb 2026 23:10:38 -0500
Message-ID: <74f395ba13926ab0391bd8714abc6036@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260203
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

This is a bit early, but due to some personal scheduling I'd rather send
this to you now, and you always mention you prefer to get pull requests
early (perhaps not this early?) so here is hoping this is a win-win.

Here are the highlights for the SELinux changes queued for the Linux v7.0
merge window:

- Add support for SELinux based access control of BPF tokens

We worked with the BPF devs to add the necessary LSM hooks when the BPF
token code was first introduced, but it took us a bit longer to add the
SELinux wiring and support.  In order to preserve existing token-unaware
SELinux policies, the new code is gated by the new "bpf_token_perms"
policy capability.

Additional details regarding the new permissions, and behaviors can be
found in the associated commit.

- Remove a BUG() from the SELinux capability code

We now perform a similar check during compile time so we can safely
remove the BUG() call.

Paul

--
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260203

for you to fetch changes up to ea64aa57d596c4cbe518ffd043c52ef64089708d:

  selinux: drop the BUG() in cred_has_capability()
    (2026-01-14 16:26:21 -0500)

----------------------------------------------------------------
selinux/stable-7.0 PR 20260203
----------------------------------------------------------------

Eric Suen (1):
      selinux: add support for BPF token access control

Paul Moore (3):
      selinux: move the selinux_blob_sizes struct
      selinux: fix a capabilities parsing typo in
         selinux_bpf_token_capable()
      selinux: drop the BUG() in cred_has_capability()

 security/selinux/hooks.c                   |  163 +++++++++++++++++----
 security/selinux/include/classmap.h        |    2 
 security/selinux/include/objsec.h          |    3 
 security/selinux/include/policycap.h       |    1 
 security/selinux/include/policycap_names.h |    1 
 security/selinux/include/security.h        |    6 
 6 files changed, 151 insertions(+), 25 deletions(-)

--
paul-moore.com
