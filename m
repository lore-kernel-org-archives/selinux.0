Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A229C351
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809641; cv=pass; b=Y1OnWCDKhGJYcrKjqfKjG6mRZlp5CjBQQLqgLhRz8vaH8VeDzfowTJ0udx2foEykTCe1yHRVsnT/CUQFhWCfJyM25Px3Rz+HuV+SExlzkIp61wlJx2EFP24jbcmLDgEQ15EuWUnG5odiU21gxK45gnstb2L4FdG9fcHp0+M/uXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809641; c=relaxed/simple;
	bh=11FkUTZuy25BtWzNMx0QQAxU6UKrujVrGtNklmkFr0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ4w0/jc6XbbVwxz2me+irMn4398tDG5bef9SstJYM6OKdeNlOvfGzel/1lpsnPSc6czYuR9qSTOoRhT3VBrWKDB7mNjH9tMN7TMFKNPq9hYRsL4oUcuRVxztfA2vFqZ/B4rW4FxzsifmrgWN8BB003ALO8iu+czpgMUgJ9V2AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Tl7+ZiIM; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Tl7+ZiIM"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c56188aef06so1270601a12.2
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 13:47:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769809639; cv=none;
        d=google.com; s=arc-20240605;
        b=dnCB2a3el8XfxKTAXm8eZuxscOhkIncV0g/7NNzzMQcBx8+JleL1EzkLCYxukdpr1i
         95wDSg8ByFNs4jvoGcyYl/krL10fz39/2CeU/rJ4f1r37SMWpOpdVGIbQNENpkd/gxEn
         Tc0QynqA9aG3bwn23O21VT1PD06h7EAp4BbbOpK2kgha08eQ6XsrMaFedZGL//sU5WFy
         l5B67PzsnzZa06u6Kz8gSDvPXExhqE5HbLf1Hlyds2rhf0+tFGNRdMNHYkQ0VB2XCQIr
         1G4RMwNiUpi+IWMnPuH9vEVGDvab5KPDe3KQqIL+vJjYBLkialnJH2Ey2xG8ThtBrvUh
         3/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11FkUTZuy25BtWzNMx0QQAxU6UKrujVrGtNklmkFr0w=;
        fh=ajhmblVHq8bNn+C0mBuhadS3q17xsFfqyZFMB2qdUgE=;
        b=cdyLdqOT9cs+D4lBBOSW7oMZOd+mnxTPDsTdtQO+BtuXTrv0NBPA1xHXqGGJu8i7Il
         WGK1bZt2GJxK9HLI445HUw80/ZE4GRXb6CoikZcc7XnQivwrM5q8K17QZzs/uhvoW32L
         4gGGO925gBgukr4Ffq9acg57Y/gsUdD2amyu0bU1xt3ANGF1fWeBjkpDkLVkcn68mZFq
         dRBnPH6QnWU30hTZeJnOWKuR4HZb/OPTOmbOrhEJltIoI4XOPeS2veo8uKUhQyxbmGJL
         Y+qBcVvCg6nbnInwCRqHAUW4N88IjEGc3JhsprKvphzxEL6Tw3y78aVcquRBfFZnsion
         FcGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769809639; x=1770414439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11FkUTZuy25BtWzNMx0QQAxU6UKrujVrGtNklmkFr0w=;
        b=Tl7+ZiIMzDn4RTRI62Ez+QMTKJtR8elzsIG+lPdysno87SSEr8tAwhk4TfwAfGs1UD
         7P0KV4xDEVJwUG1yEZqSfnu+pkA3zJ+IcwJEYq55j47WXteBbcF8RUw3F9EmwDoi7kza
         tneUighks/a00U3UubmKcTfMxmuo6+ix2e1O1VYzaADzKtDRizbrj/G4ouIAXPM5AfwJ
         ziPne8TrDh4xwi71Zyq+Paq8CzqQQTujxsO5/Ko9TqTnnixN0db/nFvsQdfaRlJPuD8v
         o5x2a6A3Gt9Q8tgHBYSrs92shEmvdyoWCs5H0pQvozS5Xkxsu+13I6637KVznc5pD73Y
         lLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769809639; x=1770414439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11FkUTZuy25BtWzNMx0QQAxU6UKrujVrGtNklmkFr0w=;
        b=QK++jg1BM/UQP6kWFM5uQqc2+GuHel1VBseK3qemWunjIpAbGeTRTBtE1AvtZh+4l5
         vZkcGOre55NblTiNQBxWs0OA8yt6dhNfkRu7GBuzzFkBPCBanQ5yI6g9uR9cPZavpA9f
         Z6xproj12ZaWPr7kic3f0G7r8QPv5SYwJ+tbtSCskVSgJQmSkPUqpVELpEdd2HMICE/B
         aZXqkmD0H734Czwp/PN0QGRPbj35If3pQGDIY5mpjMTNm/2yy6DSSO7CV8ItA7VW/AY/
         n0J/Njl9BrJmn7Y+T1iuNrFJlsX4CegLMbTnUKeC7wDl7puGMHuWH8RZEfysGP/+/njW
         8T5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwKNUTw/unSrcq95hWZcauh2/Z7YkWWblQxtIlw2Bgq/IukZl4rboEhL5s13V5kxcCMNQGbKRT@vger.kernel.org
X-Gm-Message-State: AOJu0YxGawZUYjO74qxexokevqGvQp2M5gsg4ELHZtgSeEXrzzh9ozps
	OfrQvcJb9Lus5sTHAG0YcvBtUmHgeU7QbjXz3LPsSr7XI3fmpX8MutbTKiY7eSEHGEL2iJ4ba8S
	90sjenPYbO9cLUYufYtQmRKOnfRmi6XE0uh58Qeii
X-Gm-Gg: AZuq6aKRPs4joUo1xI3PPZMUKRcMfmUoiz++XrNExrrmEI7ffTRM9tmUb0sWui/Jw3A
	xcxJHGBROvan7eSYPsW7SJYdUlZrfcZY07fVDHnFkp8xB2RzPX1lupSth30JCc096wz4Cq1IxYQ
	hLo03sAsBnB0Dahl2bwJPJU6kloEb0YAaK02vpKwhxFWd7zTub1iEFMOIe6Rr0yrvW6468dJKrp
	4i91p7d/mnT/gW3KkQ5QqRk2juNGysiKTdQIXR5roCeBcwDiCby2F4Ne0SZARgvQO2UxP80kCTE
	NDuYeg==
X-Received: by 2002:a17:90a:e710:b0:353:5c16:aa7 with SMTP id
 98e67ed59e1d1-3543b4007c8mr4355226a91.25.1769809639674; Fri, 30 Jan 2026
 13:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171140.90966-1-cgoettsche@seltendoof.de> <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GTB9=-rZOkKe1uiq3G4pdSzPKVcSpYBH9hrhufDq0=A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jan 2026 16:47:08 -0500
X-Gm-Features: AZwV_QiKS2R_PQ9Zsa4m9dl5l5Q61p96gHFm0Qwskc06xe3Ssej-aJNxxOblYT0
Message-ID: <CAHC9VhRODBvRXGh+c5LBCwS2=pfxYpTfc-Wrt3DXD93wgq5yxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent truncation of status map
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jan 30, 2026 at 12:11=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Currently the SELinux status map can be truncated, given the necessary
> > permissions, leading to foreign user space processes getting a bus erro=
r
> > (SIGBUS) while concurrently making use of the status map.
> > For example systemd can be killed that way, see [1].
> >
> > Override the setattr inode handler and check for O_TRUNC in the open
> > handler to prevent truncations.
> >
> > Link [1]: https://github.com/systemd/systemd/issues/37349
> > Closes: https://github.com/SELinuxProject/selinux/issues/475
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> This issue can't be limited to just the status node, so if we care
> about preventing this, we ought to do it for them all.
> When would we want to allow truncation of _any_ selinuxfs file?

Fair point.

--=20
paul-moore.com
