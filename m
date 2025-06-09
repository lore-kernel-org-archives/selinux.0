Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60A2940D
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507216; cv=none; b=prlbQp9oEecis2cFhUB/T3rRqhwr7/h32RvvRs3XJbNvqt8j+bZmxvC1nHblopzLLNQyuyawDTs4mf51WvRCCNzr9KHz2N56yqd2NY1CEGjI6TzmbdPkR6RflK4i7qKDfg5mr6gh+JPv5xe1oyHHnt84+l3yQeXN6qS5gV+etaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507216; c=relaxed/simple;
	bh=gZkcKnTZzTK5dRAMql+V4IkTMWc/eE7gjPQHElVNbaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TL5ipJNPifQyLZW2LMmk784mc/E1lzX0lMCa5NeekM+u2DmVwpNjIQnwL72mu5+o7/kZeUlXzQ7tRevXZAarW0Qv1BiA0xlXfUYBEZoryUojYsZn+0V+TBXdQajll6PryE1TauwGVYc9LLbW4T/r9VRYQcAI0C3zOR7qY/ZHzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZY8QTrUI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZY8QTrUI"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e447507a0so38318567b3.0
        for <selinux@vger.kernel.org>; Mon, 09 Jun 2025 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749507213; x=1750112013; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtRWGjdkVmRl+DqjlcUaDM4d966mGKRqnyveJTKh9Kc=;
        b=ZY8QTrUInL48pnK0C3HrFMoU9crUWTcnWGdsyVsHpwX5qF5MfJJM77DpbOfzi4X1Nd
         RLN18i9UfKLykjC0rV4TBtDEDigEEHLnBFPyQQuwaSJergGs0y11rU5Lw9UkDGijcWYH
         NGh3cYfabvR16472KPpqV/NWqtgJ2PFar/eBaDblOgz9KYyNRLD9jQFeWqWSQBGRvfI7
         f8TDQJUCV4q4s6DjhBhhXo+fpR2Cf/HydgHSGGtZ1adsJ7zB/O5IwB5GdmYqjZ1F6COH
         3wqb3cwIgURlv2RVqYeqS9VZqYAbLm/zGMuGJIVNlTSqwJX2jz90KkCD/3r2SQfVEx3d
         Gu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507213; x=1750112013;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtRWGjdkVmRl+DqjlcUaDM4d966mGKRqnyveJTKh9Kc=;
        b=EtGlCKYaAYemNZ8yHuN6igkr+xe9uRa+JKlpAK9tW07kFyctb3GOa+3lVw3SiH75Z8
         iqR5JAfxBQw/PSPNpZ5dHRYvacb4DsSqfNcip794aONbm/3gLKM4GerihbjwEEsLaTmg
         tc3fHj20lDo2LUL0etsvOLESrb9GVVh5VF0wsxLwunxb/nuJ+2nefpEgfjPYNzwnn2Gj
         Y8CRIEJAC4A77W7+0sy5SmOh61Iz7aMblsiXptv4E3FqBFuIB07ffJUr0i5hpOUlHKX4
         NLB/h2shUxkr+1zF+9koUwPVAu3T7z+g2wdiXXS74x3DAKAhEk91wN7Q22uLn8We5ejO
         HXEA==
X-Gm-Message-State: AOJu0YxkTaV8JbDESnPuvFTswgqHKUFWr+5iEqFL1CstKEgOcm5FBzV4
	biwZb4GetBzO1ob3lx+6P3AOuiu8kLjrrvKS7lbq70Ejbw3Fsjh1/svNI+qrE2deK8WqycOSYMT
	YU2Mwd6wEIbLgLbq/IQqz/HUPjJqKGmqy9AejSY4iELfzaEJnH0o=
X-Gm-Gg: ASbGncv82x8S7dr7aVMp58cVaGPeUvzqt/sre+S5DgBNkqJ+A5WscAj0wk+w+gf3PhS
	p/DU/WfkY1rc+gOH3TsN1RraTMpUOscd8g7OoPclGWZ4/IrxjB1T4BfWsF/JzKWlIMO9i1uol3h
	P5yG56LVl9dbJN6CLbZLZ4rtBSZKB4/sCwZuFYTnvXVy4=
X-Google-Smtp-Source: AGHT+IHxKU3vNZL/nWup4eH5rbMHQ+sn6smCvaXMtcv1VDedG55+A+40joWgHmq1IaJW8O8PZuLUXs1Bg8pa+53blU4=
X-Received: by 2002:a05:690c:7241:b0:70e:16a3:ce96 with SMTP id
 00721157ae682-710f76ffff3mr224273627b3.26.1749507213585; Mon, 09 Jun 2025
 15:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501192347.189307-2-paul@paul-moore.com> <CAHC9VhTD6Yw4dbHdmUfj+2muDMG9pdbW864m2SH8yH558kkE=g@mail.gmail.com>
In-Reply-To: <CAHC9VhTD6Yw4dbHdmUfj+2muDMG9pdbW864m2SH8yH558kkE=g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Jun 2025 18:13:22 -0400
X-Gm-Features: AX0GCFtN08dayfLej26ScaBLheDSFsLTalzwFeZXC2VM-hCHg81pgwp-JawjJMU
Message-ID: <CAHC9VhRTQkMrzJEeOPZ1yVi8jUzVeN=W+f-DMZnkc3j663fx2Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: add a 5 second sleep to /sys/fs/selinux/user
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, May 1, 2025 at 3:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
> > the deprecation process for /sys/fs/selinux/user:
> >
> >   The selinuxfs "user" node allows userspace to request a list
> >   of security contexts that can be reached for a given SELinux
> >   user from a given starting context. This was used by libselinux
> >   when various login-style programs requested contexts for
> >   users, but libselinux stopped using it in 2020.
> >   Kernel support will be removed no sooner than Dec 2025.
> >
> > A pr_warn() message has been in place since Linux v6.13, this patch
> > adds a five second sleep to /sys/fs/selinux/user to help make the
> > deprecation and upcoming removal more noticeable.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/selinuxfs.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Merged into selinux/dev-staging with the expectation of moving this to
> selinux/dev after the upcoming merge window.

This is now in selinux/dev.

--=20
paul-moore.com
