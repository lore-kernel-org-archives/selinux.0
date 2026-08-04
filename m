Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77513F3290
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855471; cv=none; b=d4XKMotm1WcWCfQTDxrSfF+Zqeis3nxw2Voga+l8yKlgFsKjQIqpjye2AJYQaGTT+y/6khEfTEGHXzb3bE6GwiA+7vC7CVtnQ3TY8DSumZ2YYRx1tdUyQQOVmQa04RTMZb2nyYGPNMz9qLRfRSxQTV6isZ6Oqibnt56QV2B5zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855471; c=relaxed/simple;
	bh=Iw40x3W/XPFHtvY7CdGm3yvLNasxxOhDkHu6ztEp/MQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lY9AwopFRuoCXJIxpXYL2pI7H9/tY1eoxjcDCxPS8f6PwHwvq6Rmo7zGfsGSNuTUKcBaR7j7ohpBpmp3xiaDMVN3buBRcMEwyS5q6BjsQuV6ObT7EbQuvO4apjSrClmZFkgtDT89BgAi03vo2zPRZAkHXrmri5CeDTcZ0TNtVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AJOS6xBm; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AJOS6xBm"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ed19f4d60so292385a.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785855466; x=1786460266; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjFo3NJM/uUOgohWlmqL226ttsG/xIf0yq06sVKGPQg=;
        b=AJOS6xBmnRg73WhEF6CT/RYMS3mQb7kzDb876HAKjeQjMTlVVMsxdigvC5lLiIH6ce
         FQtWQUiT8uiyj1unuhObQR168HRpK3+AhYYG2u56WjA5aq5jtsiIyGUHEUIFuEnaF92u
         G1Mo8GKGMgZMYSo0/tszloYCcFP+DOoezPzkrzR+P4zzFtnziKBsV8R5ID5Wm4fUvgl8
         49WCY8fGpzq474pdBndONgSc7eGddHhk5qwgkMXMPkehQc0yK66stMjtM1vD8TEqIli9
         b15jWdxYwQEH64dOaq1p6vh95IEurhc+AwaXM9d4KJRdKMoKT41epZQ3Y/i/ENDpeqtG
         WaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855466; x=1786460266;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjFo3NJM/uUOgohWlmqL226ttsG/xIf0yq06sVKGPQg=;
        b=qbzVIt3r4+ZFXI3cJink5aNq9kqglwfX/eQRhnexsLeGvLOpWe7DYPRuLfQqbuQ8i7
         /pWAogJDKlty5H2BtMNEIpbP1BzP9zXXMFuOzM82Rimj8seVsmr/HS6NWExghFliBge4
         FuirxzpKeWO7SPWcJvxVmB70rFzc5vlNB+d7TLSdW3OdWqSrgaaoC83xW1NR12vF5++B
         bkM/YVApmNWAptOJZHP98CMtin3QZc6CpJjFIXgAWWLc7q9xNvkUs6LYCdicuUQRqGcO
         OskSEdGeOXxi2ddLcdB8txP1cf3lWYlLI4kyxBIFud/CWuHsO9nwE260iDVEigXNhYJt
         Kx+w==
X-Forwarded-Encrypted: i=1; AHgh+Rr5W54wIeFqEZpBMbYxe/W/zzaTY7ZuIS/f5lUeSEVzC8759jyffFu1nDkCT91MAYllDbZhvKbU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9imcav2MTZ08iIFEITmdrekgDI6PB2+NOAWielCcAX4Vyba2R
	mth3dUhvavc90UmcA0FVb2vBSilgzm2D7MGz//om/ZTXGnB8DPiIWEriCBYm91bcRYuLA5K/JRb
	9wMv2fQ==
X-Gm-Gg: AR+sD13O8pntjb3VJrguqvKcyux3x4X/bBqPmJRIAM0QZxpkmwVZ4YrrLXsRfs1C8Ko
	ICIPiOI2ldN11UrK/h+nI2VwYEkUNylVB06SiEoRm13K+UgSR6KlwTK/MuuD6NKp8/142wpPFTx
	5FoWmBMvFFssyM7yholVyZMAUUD1xdbDoqJ+O/ES8oYaDYxvhLrH55lHjfZ8JJE1uFvEGIOXJME
	3KjVqWo5NLG5q93mX32Ksd3uiOls+90r/KTtcjVJemSjHwFkTZOYsbDD6ICvxMyZd7qtn0sRZyI
	wOQ0C8U1x+dxC08V8rt/uQHmOYIvWlF1yNRCyey6dEn4XWvdO8xX++cN2WBhUgwxM+F8jRtUHgh
	ByDjGFhna0kB9OsiDjnOLcROSHubZpBlBLn10pIUy/Em0cr+GyL/WhjKju8k+yrnnyEi4KXxSk7
	3fLr2ZrDDP0K60iEMzDStN4WXFxtKw9P4znU0uCkAfyPrnXrvwaO55MMmepoHcDqeHzAdSZ1gCC
	YpBif0sTlhdBHjXyUvGGeovyH8D1OIVnpiFv7bNoV9A
X-Received: by 2002:a05:620a:8bc2:b0:930:9533:5e32 with SMTP id af79cd13be357-9363184d54emr492412785a.7.1785855466054;
        Tue, 04 Aug 2026 07:57:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641756c67sm97926285a.19.2026.08.04.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:57:45 -0700 (PDT)
Date: Tue, 04 Aug 2026 10:57:44 -0400
Message-ID: <8335d7b97813e178446e4e8b37e8e961@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260803_1511/pstg-lib:20260803_1500/pstg-pwork:20260803_1511
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, jhladky@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Jiri Vozar <jvozar@redhat.com>
Subject: Re: [PATCH] selinux: check level category sets once at load time
References: <20260804135700.3713-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804135700.3713-1-stephen.smalley.work@gmail.com>

On Aug  4, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
> isvalid checks") introduces a new loop in mls_level_isvalid() that
> causes ~89-94% throughput regression in System V IPC message queue
> operations (msgsnd/msgrcv).
> 
> Move the expensive part of the ebitmap checking to policy load time
> instead as the reporter suggested.
> 
> Reported-by: Jiri Vozar <jvozar@redhat.com>
> Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com/
> Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
> Suggested-by: Jiri Vozar <jvozar@redhat.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/mls.c      | 24 +++++++-----------------
>  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 17 deletions(-)

Merged into selinux/stable-7.2, thanks everyone!

--
paul-moore.com
