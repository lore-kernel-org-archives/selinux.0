Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530203290BD
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526866; cv=pass; b=T5/SoG0ktQHxu4WxNrKBonOUpGMfde8170G52YSQkvqOvzOABmgmhPDRHHUYZ+lQuZ0UzD451Ka01dN9dGnJasE+aDokKv/XtFwFH1ADCMQzJjUeFYX1B3GisfNECMUIuFE9uV3CeZM5Jqub1aPyJwDZCb9ki0igpf7zqKt8bEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526866; c=relaxed/simple;
	bh=uWtGDUOqqF9SyTAWAfXQ3EeCb5m6TKJz6ZnoFQMgkyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZBkVymd5k7StzqXEfgTz7QPT4S18n4PDOm1mkWIMr1vh4qzVsNtBND8dsuKJ7I4PPeFRMo1sQ2drzpOTUkLjd/UkXxKFb7hyWGRHV03ZKxAI+DzmeHDxEw0doJinL5eRxYVVQftn+imTvyaH0+8qHnLXrwhm37GflQ2p/3I90Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2al/S41; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2al/S41"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451fd21113cso1143639fac.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785526864; cv=none;
        d=google.com; s=arc-20260327;
        b=nrEIF2zf2VXaBiDn5JIjm4TZ69VNUyGdBasZ2ZxeJG+65rsqz1EbSAZlPzyuTTorJY
         ddDM+KFSx1t3o7shW7XVSnag+c4r8Ia9OYAMWQLjQTLzfJuEHN4Bhg/9PvCg9QCo0QV4
         +ZdeccaQTtqh8mqjmSTpG1y78d44e3iLhVsh/kMLaJZ7Dd+WSQzHUG+lfSaKRQ7i1Hw9
         giJWKyGPPKsK7IqlrEU16Fh6QGiS/PUbml7ciJDzRYJGr+ujVP1plhhk4xiNRxhef7YE
         S8u4dL5264S8gXapWeDUOgttm8t4nfkwq3ICbAr4byF6xknY67QpPYYz5cNmTsT3g2zx
         meJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWtGDUOqqF9SyTAWAfXQ3EeCb5m6TKJz6ZnoFQMgkyE=;
        fh=Ey5igX6L51rQCUw5Y6brZKzpoCJtIwHvj8fDaqqBf8A=;
        b=LsF7XOvaLTYVLjRVh0om2n3nRz7MkyYQLdp3i4qQGS/lR4TcCi78vuIXkvWXp29Z0B
         hsYbw8miK5mEFqST0JE7XD7TYQ9/peEW72fZMGL2+6ol6mcmSUHfGUOo9k9dypr/rD/j
         C5QzmNt+mn+DwZWLItEF356qYklXruFLYFUS6f+6LkpZTWOeIhCshczpz8a3ut79qXEM
         TBT7+xZ8u6tKj95pP7hfLNfyH9wqs+6rJnphg50e/XdveuHPNFy0PqhY4ay2Ajrxwu0d
         c8TEBzgHpKQDUEoJPONpiR6k2eTg0ur/DwyiRFnTq9ifbFQ+RfTo18UDKmpfyQjNK0e1
         bQ0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785526864; x=1786131664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWtGDUOqqF9SyTAWAfXQ3EeCb5m6TKJz6ZnoFQMgkyE=;
        b=R2al/S41NB9aSvFicN1U7rxETjQGs/hwaeH/DC2t86yElgH1IRH1Fb/mLIQlgg1iVV
         Wd7uJibRUbXfUs774Njh5Dg9BDgy9a7ko5JjeZlgJ6PP4NhBSdHbpUzynwnAOTtshP4k
         mSuSsG+F8jUjHgklTwgZpw22OK1X86heWhTj3XPGKWW3gttEcgYdk/33Mpu4U2hLMgfA
         BwKlYoCPae/CVjyoggtgEepex5CD1gjJHaj4XRJ0s4R9zyts/Yh43eMWvIW2UEuPnaZA
         bjkPk15UCSde+8QW+u7WHtTh40YgOp5uIsDfKET9iJbaQVrHjx59ypWh3q7X4ZgZ/GRq
         XxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785526864; x=1786131664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWtGDUOqqF9SyTAWAfXQ3EeCb5m6TKJz6ZnoFQMgkyE=;
        b=Ybhds0e/fxqBFMjXFmUe8PdcewCa2od51QGwxrczRfTTkxwREkUtjOnP1v1gxeaNde
         /egQSFqPivwj8tWdtjtfxB2sqCJad0IfkjmqetBOQAzp+s+dMNBgKT4bM5l1ZaG9OfJp
         aUD8MPcQTllJZ0qDcy8pkwlPfwQNPhYHleLDlb9UXtADvN+H2LcPHxZoqXk46IPNuoxW
         pqTzc5TaZDhmtOrQH99A+KDk8ZF6Rd1poCxiDfGrjHxOUfyKOxfLp+kKlmseDxPo/C7l
         8KqiJ7xafP2Ayk725UvYtgZh3tnyE22l/KsUeMI23TuHxBbQLQxM0J25DgQcG+bwqub2
         A8fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYhviqgzYdfhMPpRpDc1/bcZU9/MvoHFFCpZMiwpdlVfonnBZqgPc39D1IkRs6++ikwnlO4qOW@vger.kernel.org
X-Gm-Message-State: AOJu0YybATI/j6PbMiWVvOTT9Mgap0QXvUU42OEo6yus/BER6dnQ5gE6
	vxKfTBYj4hz5CUG1sOdiTmiiaJacybpw9139pwk+HNUcEo4AMrA/R0R2mepIxz5EwO4g5drWutW
	qdOb1Twok4g3OSK7onOubU/GtWekimdw=
X-Gm-Gg: AR+sD13gonjvJzCg02frBaP2FIExJfdJMFQXRtMk9EbYp7wbxkHrwMgbP1jOaOr5g1i
	H6WCxTzaF9OSTpRyF9ncmT72gpDyP1ripvoc8yMb0Otue9ch6SulOPuqAjBk3lhE4ZBPQoiNPTE
	/dsjjVHSSiegx5s/pProeOk+PYx7+/9MgedYeyIsr9vrOBJ+THqSIshsXWZrkk6Bn17F7YC6A00
	bLflL6Mtz4QMtCFRnEXrEyw6LBkqsYPeyCD9Bih0lirlAbe1T7Mq5hbI7otgKsl199btmhJreYW
	mjSuvlf9i5TX8XTi+NJFDWfY71CYGoL3dSf252w/JkK4
X-Received: by 2002:a05:6870:61d2:b0:451:ca58:626e with SMTP id
 586e51a60fabf-458f1409f3fmr4959221fac.8.1785526864021; Fri, 31 Jul 2026
 12:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me> <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 15:40:52 -0400
X-Gm-Features: AUfX_mz8AM8ipWjKDfZGobnb3q4e68FCpZm5jqrAs7FgxMJWC1-ORqnOqFU1rXQ
Message-ID: <CAEjxPJ7dbZx8tKuR0L4=7dxqVi=mvbf16y3n4X=mVSx+DfhxUw@mail.gmail.com>
Subject: Re: [PATCH 1/4] selinux: do not cancel a policy conversion that never started
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:44=E2=80=AFPM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> sel_write_load() calls selinux_policy_cancel() when sel_make_policy_nodes=
()
> fails, and that helper dereferences the outgoing policy to cancel its
> sidtab conversion. On the first policy load there is no outgoing policy:
> security_load_policy() returns early for that case, before it converts
> anything, and state->policy is still NULL. A first load that fails while
> building the selinuxfs tree therefore takes a NULL dereference in
> selinux_policy_cancel(), reached from a write(2) to /sys/fs/selinux/load.
>
> Skip the cancel when there is no old policy, mirroring the check
> security_load_policy() already makes before it converts.
>
> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxf=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
