Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E8800
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926756; cv=none; b=AZSvuTqj5gxhWagHJY5tnFmTJV2P17oUcSnnKam5lQpP0PRto7RT52hPs2xAaPM3b2+/xKrY2AYKWlf3S6BLWrFyuf6B/v9Xby44l0krMPDTcDLt17NLHqnjsRO8WozuKzD2M7qeZSIfSa5DY+55YruVGtuIJwzZS5wj6iqUSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926756; c=relaxed/simple;
	bh=wVzeBI5iq5pcaL7sKL878hNf9vStv3AgI8KZKMV3sE0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QvUbE7qWaNpKHgJTER9y+G9eED/2fCqgtcRi7Yepl2sVydP4D6lvEoesH4ZgZVK1UMiaGkiiDxCo3TVfx6WSe3Jyo1jNGW0IgsUNIpI18Tbwezly4Ai24B+LJxiHo7c8MGGmfooge0isPezNELr7pi2fteomMcbNLQWln6DUHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ffz/ENBz; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ffz/ENBz"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5102582e23eso96907201cf.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779926754; x=1780531554; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Isx2qxK8pV4e9JSva6BI15c8Rdmr8Eimwb3dscRj6BM=;
        b=ffz/ENBzx4/0fSEWNsMHuHEA+8Z9hlYcuAVwI8g8xSsPHTbo47F9W24oOZQLXGarDd
         69LDgHUnyXA9oxGC+cInpQIWh3RVuOF7mp6yf/nMq9qN2SHGV0ns/boLjgm7FNT7KwDH
         qBI3tgB5WlYZWAakzEv/XPlxG4DIqMhKXnHG2MniOLAIGOls95fKrFOqLlZ1Ge/D9irs
         4QqLEVkiL+Gdj2gKaG87C8rwK87/vW7Ni5i3OuPnQcJ2DEuD9YAXxk0qzydiSjf/SWI0
         CND25dBsxfkJkxPFjESOPuf2n2srTBrXx2nhVcMsQC8bo60Q0QTvzuohd0ifubE4MFjx
         wNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779926754; x=1780531554;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isx2qxK8pV4e9JSva6BI15c8Rdmr8Eimwb3dscRj6BM=;
        b=YBYwpLjueXmKTweoajcTHNxsRAscwoR6mgjb7yoqFc0GlsplmaoWRJp1uT+LBAjazW
         F9GA3TXjvWu+v7+cnEIebk9g17l+IZPXLFTuhrh4wnQa1ZqmpBwZQZxYELfbKL6ductk
         DbBaSZezIpHxRGxT68HxlEzEJHF7ks3g7dMHwN4xukddpoixOqJzt9clOZXNoLtdmdY6
         Y3k7BsV4orzCm2oeiLxGVk46MVUWFRNT8BJH7jEs5tE+6JCzrlnu7XRewZfjNWWd1ziZ
         a43U5cU3PGx2F9L67OBMGBaqdddoP3/bWDEJj7IMYslFI+chC/dEmfFcHXnmcFwY3n/7
         Xalg==
X-Forwarded-Encrypted: i=1; AFNElJ/IWGzhoeMVid8mqELCCTEUv0+36VWxdRcnI3NDEU7Lk0cCffUGFXT71h/XMvJRccnrIj+xn6Es@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7EForWCa/qfvIXsr9dnBzhWu/ZVXotnRMAp/HEqvmC34audZ
	tUl2SiiYdOpSuUHd5DuTNisxYpxjZwyPQCxwgDlswuJz4cjK5qWqPs+/AMWO3tKui9QiTpo3ctl
	wIVWLG0gMJZs=
X-Gm-Gg: Acq92OGMnlZ6ZhIIYX4/Y54saT9MdDIa941XhEtD8fzFTF5IxZasZ9IpoG4ITkdXPNG
	89eQSLDhrjFo/3iYB1akDeuzrE/KEeFRfBkWVDIjSWpUXaafYHPDY3gpSG0xlxgmH5edY5Lc+AE
	0p7g+U+5wUIse0C4FaL7McSWpCDaeQtshce/SnLBMV2VkmrOB4O402PAy5xm+Uq+W3t8frLIGHH
	YmzMapZCsrb7dCeQ59W/iSXS/EISfkmt+pbkqwaDd0UN8ewKwNv9rBpxhksTHnitT8NFOgVmY13
	hVoMn5BW57OUJagYjocqxYqDmAxbBrVCpZf++HVMTDioJ+0nj4U3YU90Csi+NfT0ZCEYQNzTAA7
	hxnM8P1EEUXSZFa/ewObbFw+FPtcKhKJA+kGSEkTHcr/yWFIqCYgRlkzkjgaijbP2qLvd2zVJyU
	KsWhkni/fqOk2KS++PSYF7rRB6dAYQY1SfAuORjksBayGh7d15XREWkWr+dD/NQ6qJ2AZ8+slYo
	kHpxVg=
X-Received: by 2002:a05:622a:3cb:b0:516:e93f:826c with SMTP id d75a77b69052e-516e93f846bmr235313531cf.36.1779926754106;
        Wed, 27 May 2026 17:05:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc8f3sm57912571cf.18.2026.05.27.17.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:05:52 -0700 (PDT)
Date: Wed, 27 May 2026 20:05:52 -0400
Message-ID: <51a1cbe14d3ed32b303d6ed95a69c155@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: Oliwier Iwan <oliwieriwan@mailbox.org>, selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-kernel@vger.kernel.org, Oliwier Iwan <oliwieriwan@mailbox.org>
Subject: Re: [PATCH] selinux: add comments to smp_wmb() calls in status.c
References: <20260521223815.67902-1-oliwieriwan@mailbox.org>
In-Reply-To: <20260521223815.67902-1-oliwieriwan@mailbox.org>

On May 21, 2026 Oliwier Iwan <oliwieriwan@mailbox.org> wrote:
> 
> The seqlock pattern used in selinux_status_update_setenforce() and
> selinux_status_update_policyload() requires memory barriers to ensure
> correct ordering of the sequence counter updates relative to the data
> writes. Add comments to the smp_wmb() calls to make this ordering
> explicit and self-documenting.
> 
> Signed-off-by: Oliwier Iwan <oliwieriwan@mailbox.org>
> ---
>  security/selinux/status.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thank you for submitting a patch, but I don't believe the comments are
necessary.

--
paul-moore.com
