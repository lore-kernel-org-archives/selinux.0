Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694625A359
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629474; cv=none; b=tR5867xQqeBt8f7Uc3dRaRCdnXlCGIolb0YJQPoY0VMbEzqJwzDMwG2PjT+LLqcrOvGT8w/fLykB7sa8tfqvoLSDrAA8kxwqVVuM+NMp3VCYFTDPk6fjqlN+QlEX9022um/X2ht8/HhLPmax5M7RT9+YFwZJzlurqCBFMPRHgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629474; c=relaxed/simple;
	bh=r1k9nnCNAdKmeh6GTLl1wxuKCYS4pFVsoHZPAB6Exsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNBrBTGt4B1mxcK7ozheKqvKTkixNCntlONICJLESv6mXr0khLouXSfQLhxBzZqetmxtPzcORd3sEZJY82M1Ygn/A89Xfb5ou4xkkpYGvdUaw/kr4MLqHZslvKMHyc/FSqpY+59aD6ThuHq5s62cECIjMrG+3NZi+JqFnwT4nNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P88q/T24; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P88q/T24"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso4766751a91.3
        for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755629472; x=1756234272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YVYGjOB6s9N63HNI5ovYcbPzuwn+q5vb6MM0sVwzNs=;
        b=P88q/T24BqKcvO/81K52M1yPLenAKqA1RH3O2068mdeRZCgy8rR+mbsliDGTbKbVWV
         NU+1bYcjN8X9DjsRDqzvLuPsARsYbflPU5XG3G8UiW8gy9PeHKCWPK4kDswhuiY8lrIA
         kGuCpDi/BSzC+/Rs27/pqPkY2W74h2R5/TZUHI6uxSH46aJ1Tl2zS9sAQyAcLIUY4wct
         7YJoC0xERxSCX8O6dDXhRnIfRz8Fum989rpZmQi2Mp2AEWnlkl1MAFMYpDg3CDSxF457
         hZGSIDuwHGKDCCHfWSNZ1hmp3FK/SVMTVGRZRIjL3jWo26t1IGdtcXDgwM8heQzsGywB
         MKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629472; x=1756234272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YVYGjOB6s9N63HNI5ovYcbPzuwn+q5vb6MM0sVwzNs=;
        b=OcOxA07dmxt3HOIyK/qrtSF7lGhJa8iCWdrSNmc6DhW/NdD/axiwyJBpzNS+Z+30gI
         z9ogkk4JzJInA2ziwaaWU9++wbqbovOmJ1VmNb5E3W/VeiBTYaAsuGFwAp0pSor5bIpK
         u6PBDwyjYV8J1mRZiLCeGrwI+j7KHakAuogk/KGppWYU/aliIaAG/mTz3dNaKKVu/D3G
         MpX7Dtmg1n2oe52M4UTq7ouUhqELxD/YWRlEIXXLIwxkLgUZ5f4u60khye+M4BIsD81q
         jo969CAbcBQJLaZxZxf+F1KsUgpppQCK6N+w0lkPxASLQHmpGs1SsQ9AFv04pciVe+3c
         jLkA==
X-Forwarded-Encrypted: i=1; AJvYcCXrZWmxaR1CngUUKvfF9fMtfgoR6JAM7in9+4xoJ7R1qRROEZP8agYINLFnNO5aZ5ZQxeXOUtuA@vger.kernel.org
X-Gm-Message-State: AOJu0YzdC/IO3GucD42wz5K2KEywaxXxCnI2kFysYjhYun9QEtgHOtu7
	4w4Ijc+N+pckaQ3Fo8iKVAvhrUlxB98ELiYI3FqEfdC4UVbofUVKIE9NA91tGiAxN57u43aYe7N
	qgJ4UnG295Fb8RNcyzIq3W8viVOcPStVzkx5mtiqP
X-Gm-Gg: ASbGncucApinqbSmS2RP4h9c49c3roTNGeQQKIPqlfzFfRzDlfMOLSryuNvvX46tc3K
	hNX5BfgURdqWmxZiTv7ssTTd/8hWnvf3ZKD0Wg+m1Q3EMWHPmXI09INC48ppaHaLPt34rIHm9n2
	b12IU6/n6KdoifG9TUpUDaOG+k5RA9Yn0UpEXeToVHpYjUP2Emr0GK7zlMJTcNIvNLsKezE3fy+
	wbcx/0=
X-Google-Smtp-Source: AGHT+IFY7UtpC5fuNWLZMOhqrMliLhtKfzIXXOEZkU111XWgE3UzoMhlgcKvZdXaJuBdcRjpTV0bhvlqenEx/LkJ4y0=
X-Received: by 2002:a17:90b:584b:b0:31f:12d:ee4f with SMTP id
 98e67ed59e1d1-324e1423ef4mr305616a91.23.1755629472117; Tue, 19 Aug 2025
 11:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:51:00 -0400
X-Gm-Features: Ac12FXxeXbd4coDV7cLQr6EYlH6Fye0jDGN6ekKW7rnEog0z23VtdEs2Q4BujjA
Message-ID: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> I think we want to be able to unshare a specific security module
> namespace without unsharing the others, i.e. just SELinux or just
> AppArmor.
> Not sure if your suggestion above supports that already but wanted to not=
e it.

The lsm_set_self_attr(2) approach allows for LSM specific unshare
operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
two LSMs have implemented support (AppArmor and SELinux), and
userspace can independently set the attribute as desired for each LSM.

> Serge pointed out that we also will need an API to attach to an
> existing SELinux namespace, which I captured here:
> https://github.com/stephensmalley/selinuxns/issues/19
> This is handled for other Linux namespaces by opening a pseudo file
> under /proc/pid/ns and invoking setns(2), so not sure how we want to
> do it.

One option would be to have a the LSM framework return a LSM namespace
"handle" for a given LSM using lsm_get_self_attr(2) and then do a
setns(2)-esque operation using lsm_set_self_attr(2) with that
"handle".  We would need to figure out what would constitute a
"handle" but let's just mark that as TBD for now with this approach (I
think better options are available).

Since we have an existing LSM namespace combination, with processes
running inside of it, it might be sufficient to simply support moving
into an existing LSM namespace set with setns(2) using only a pidfd
and a new CLONE_LSMNS flag (or similar, upstream might want this as
CLONE_NEWLSM).  This would simply set the LSM namespace set for the
setns(2) caller to match that of the target pidfd.  We still wouldn't
want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().

Any other ideas?

--=20
paul-moore.com
