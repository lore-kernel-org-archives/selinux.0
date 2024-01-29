Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB312158D89
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565534; cv=none; b=kILZsNL2+qQSqfjwhonhamW3S0q9VONuagymHagNqcS5+xsFDU+WOba+pRRyFsNLvhX7j9nX2/deeKNEGrakOGCELybCQRR41KNXRdf/3B4bLHClscPV3npcFBsQsG+5UUNy2MruVrZP8Zr1NjV/Y0gizN0/ftkDXvBicYBL15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565534; c=relaxed/simple;
	bh=E0RF1mJ/mUPc+QixJKIWdZC1+BeLhd6nu+UxDkti62M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbfMXH7ydZp241+8af9kpBQK8UnTEqQWy1q3XhArDr4tKRi5nAsKybyFPX+5ClfyebF7Vfu5M07r4SLIRg5tAq7qk6pedGk3iNurqS+MEr+K75pnDp3a1TJc2pcZQhEW5vzDm+lbzyzkFf1uXIuPVwMcBqWviuFoG54esOhgw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dZaZVhn3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dZaZVhn3"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6782e92c2so1384295276.3
        for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706565531; x=1707170331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j33XwLip/BOUJqqAiy6d2Atp4T1jmNrV20g5ZGu292c=;
        b=dZaZVhn3pXYFHW/KQW+M79lN3bo3qX7xMAw6+Qo05IHIfn6Pa60DeFLiwoIROoF+aR
         w7gABmyjoc8BByLMzZbGMKLavRUpi6zrqBKaT6RRPDygBWCeHs0BqPJsj6uSsPAze8Vw
         4dsAWYy9dipUnV194BWNexJKMYwZdqMoVK2qGjd+GSF2DMGTI51apuaz53NiikYyvYey
         SrAVvcWa1iUYRWUqYDTkOwiX6ermG8uQ74sh5EWp7lZG6Nxg85/4CX2L2knJfTUm5mjj
         jFTzaE1sywFfTJFibFrGDAJ86jfoRuVbu0dVyYRZ4AG0pNmGlX0Hh18r4g5Kb+wPv1p1
         ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565531; x=1707170331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j33XwLip/BOUJqqAiy6d2Atp4T1jmNrV20g5ZGu292c=;
        b=PnNcQ4scXaqzF328aQAV2GfnxY8JEXlbMgamGsZ9ELmo3IdW/ti93Y7lQ6sWnAgIoA
         3WWl+kxrsEqUzudCREFHcC6wT7ZhxIsRNhtVgaDLV5haR/1tv9gLVhrm0s0GQAcEpfiY
         IRarOnoAdFDT9/HqQBXaj+48vtnb8bYoO5CZ3OI1PXaGaIlOn8Uo3ZPd5DwQoLMvUzHk
         uwChFeCWh/p6enyJ1r69Mul1dOiXjdz8aSjK7BiqNo/4Rts1In+DDH6qygdsTOW0JWiH
         5vCtoKEXJtxQaZQk8f9oDKXn4oWxnOASenl8BH/VpY7fRjASKiOZUTRPl/mMg/951L15
         l5WA==
X-Gm-Message-State: AOJu0YxBEbsjrN154/2wceibNURt3lwdUa39a9Wc1hT6AsyRBzrhjIlZ
	PyhF8fTi/lwmqWRzaNkrXtso1hPwSZFoxAaNO43yrrBoYpZjoYoG75rzNZDLUhZ2ljrRywIeVYR
	a3puc89boAiaxEe7cQkhAYzVwC55ZBMEovyuV
X-Google-Smtp-Source: AGHT+IEsiAtmYcZ6C3MJ2jpika/F1Y1Rd+JfRMm2OYA6YpXQeVa60zB2ul2Ipm87ct4WwptJXaLcTavQgwxIpRaW32o=
X-Received: by 2002:a05:6902:2082:b0:dc2:266a:7809 with SMTP id
 di2-20020a056902208200b00dc2266a7809mr3704214ybb.79.1706565531627; Mon, 29
 Jan 2024 13:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128100035.82170-1-debug.penguin32@gmail.com>
In-Reply-To: <20240128100035.82170-1-debug.penguin32@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 16:58:40 -0500
Message-ID: <CAHC9VhSsyOpZuHwT1ZZz3h=kWYXnWoCGfy_pLwEktXAfswkRAQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use kfree_sensitive for certain code paths of security
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 5:02=E2=80=AFAM Ronald Monthero
<debug.penguin32@gmail.com> wrote:
>
> As with kfree_sensitive() it does kfree() and memzero_explicit()
> internally to clear sensitive data. The patch includes some of
> the code paths to free data such as keys, hash table and
> scontext and tcontext of selinux, which would benefit
> from kfree_sensitive() to replace kfree()
>
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  security/selinux/avc.c            |  4 ++--
>  security/selinux/ima.c            |  2 +-
>  security/selinux/selinuxfs.c      | 16 ++++++++--------
>  security/selinux/ss/conditional.c |  4 ++--
>  security/selinux/ss/hashtab.c     |  2 +-
>  security/selinux/ss/policydb.c    |  6 +++---
>  6 files changed, 17 insertions(+), 17 deletions(-)

I agree with Casey's comment, I'm not seeing anything in the SELinux
code that would warrant the use of kfree_sensitive().

--=20
paul-moore.com
