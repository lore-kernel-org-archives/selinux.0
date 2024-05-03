Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEC153816
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750580; cv=none; b=P7UMmnEwWx+x/0wCKdeG5TSwSANyU2SYrrEhK6FniI+VWqqQ5Ec3HE9t+r6i2nHJ/3C8gBmom/2hJvKpx+6s7j4krA8SRbmzJpfmo49i4YFP8ZVotmdGxnYshPuIiPs89lA/NmN/fEDLTFNgeXmuqj1O4ARAxJlEHYT3vM1I1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750580; c=relaxed/simple;
	bh=PPLRXb62f4TU6cKCKcR6WRKOqy9oFuCtyNmeX43BH8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULDpjzpauTw5VFY8QTY8N0s9f94OScLzv5IlMX8mqsoMJHxQu/LPtgg+Rjsnct7T3U9uhW3yhre2YpGbmbp3XZkc+h/9+5mr/lxa0/rf5hR8/m6T6v0QnFgcOTcqC/YP8Vzc7LcF1aFVcPGHMIkaUYylHXloTPTnaEdy9syTGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XGKqiyMR; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XGKqiyMR"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61be613d903so55747717b3.0
        for <selinux@vger.kernel.org>; Fri, 03 May 2024 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714750578; x=1715355378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyPq+FXtpv0zVbPIfepwfMAL573nm0zxQL2MhNwWIuA=;
        b=XGKqiyMRFQCKFvph6T6+ZxGSouhdIcdjcqaDuuv8GJWrj179OXE79D/5YrI+EXe9qL
         wO9J0TXE4nO0uvKSaRMf3BcvVWBSZshq1++ZiVus89qAjPNW0hxNunNiEu9rHi9Mos+F
         TBOTBqyD2fgq5tFdYcNB1XO7lFPJ/bBvxYduxfaFwpHeozIiBzvWCodKcT7FrngV3Wcv
         XsJqZhXRNO05pD3TpJ731vIe5GV1l8oH5w6ahzlTclRX7ogZPbugA0rusqvznzDnyYKm
         INXEKQw0TRZOATbH+0xCUHclpLN2anRudtSpGuUEuApAqs9wHj2KQx0hR2PjpIMsd84r
         JTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750578; x=1715355378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyPq+FXtpv0zVbPIfepwfMAL573nm0zxQL2MhNwWIuA=;
        b=E91/4WHWzQ3i6u+ZAy8RRnKsl8jJ90gDgjYanrqqu0DKRPn8j04/Suv1jVDh2LhgtI
         /8i6nuojmCRpwwJD9KgzDNKgW3+OhPVp8wXkEIFH89cE86ccEvMvHC14mX1rNvrNPr5d
         axD1XvUcUep+KtcxXAEln8YKAe8m+dzOM8Wd5/GTtZDrKQUCrjKtX1rO6GBtynQs2pIo
         i5sowe44EWQyPszz7Wy5H1bnMzCGVr89K7JmED0EBCLePcZExswA5o1hAiVlrSzbYAnZ
         ZWy+BKJ6VOG2yAjXSGOkUqOPxWO3Bt2+m+P06Lkx2TZB+jrf9a1PLYEjT+K845l1ghY+
         UdYg==
X-Gm-Message-State: AOJu0Yx5oj6og5OHKifXt8iPHkjq/zApgQEs66AMzc0Sdoqd6mQKdFBg
	/aL2J+UHTr/SQYEmAx090GKFN+Lp7Wy9hx2+nSunIGkOE3DK92BrvDzru38yCH43/9dyirludKL
	OyFNOPsAcggMkNg1PBBedvthipvaiPCirgYNV
X-Google-Smtp-Source: AGHT+IHNmYq8uwLtuw+Yl16klFehRrlDbla44Yoq9rkkxOLZ8yAmZMpxozUNXch4+bgrY3Ki++MH8nRFKX2yC9gicVo=
X-Received: by 2002:a81:6d05:0:b0:61a:bfab:8328 with SMTP id
 i5-20020a816d05000000b0061abfab8328mr2861801ywc.11.1714750577953; Fri, 03 May
 2024 08:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
In-Reply-To: <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 May 2024 11:36:07 -0400
Message-ID: <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:26=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/2/2024 5:58 PM, Paul Moore wrote:
> > The current security_inode_setxattr() and security_inode_removexattr()
> > hooks rely on individual LSMs to either call into the associated
> > capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
> > return a magic value of 1 to indicate that the LSM layer itself should
> > perform the capability checks.  Unfortunately, with the default return
> > value for these LSM hooks being 0, an individual LSM hook returning a
> > 1 will cause the LSM hook processing to exit early, potentially
> > skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
> > of the LSMs which currently register inode xattr hooks should end up
> > returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
> > executing last there should be no real harm in stopping processing of
> > the LSM hooks.  However, the reliance on the individual LSMs to either
> > call the capability hooks themselves, or signal the LSM with a return
> > value of 1, is fragile and relies on a specific set of LSMs being
> > enabled.  This patch is an effort to resolve, or minimize, these
> > issues.
> >
> > Before we discuss the solution,
>
> https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-ca.c=
om/T/#mac61625dc1983d13ee5e8015fd22e1165381f079
>
> ... or am I missing something?

Yes, that patch, as well as some of the others that have been posted,
change the ordering of the access control checks, moving the LSM-based
checks ahead of the capability-based checks.  The patch I'm proposing
here not only preserves the current ordering, but it sticks with our
access control convention of DAC-before-LSM.

--=20
paul-moore.com
