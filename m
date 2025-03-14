Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7B200BB5
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962508; cv=none; b=Je586m73gdkM6iup1ZHoIRWckF0ev9aEt+7StggJCLvnmnZpkfRQA/bm7Iv1JEDR1zvE/+rEwUWI4srOpnwHM/n8I/+hJPQDWSnZM6IHgMDMNfRWGK8xVvRw6MIiSw0O9SRuOCHl2Odq90t+pX12KlxgM/xTRaFV2ofOf5n1okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962508; c=relaxed/simple;
	bh=3TT5lvs+qRaPNuOxeRfDnkvZSNjnbXB6XDMYlNWqs1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBcfPXnP+jxuEx0AV2/RPW3SM/N3mqBQsDGa5gYBJKKZHp+x7nzT/YVlo/gQPuTxvgFf6GqbbMaQhmnzyBrnUaprXo09wXAHN7YBAQRHvpi+khY7yWu1zijOT7SYyhQyZ3Kl4pw3diiXeg8E/ApG/4/sIjCULUQ167qTF8dN40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIULIirx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIULIirx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so3674598a91.0
        for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962506; x=1742567306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TT5lvs+qRaPNuOxeRfDnkvZSNjnbXB6XDMYlNWqs1E=;
        b=aIULIirx1HToXb7eYX05jNElhHVxYw7d4KyMJCjvRKCYVV46KFMKwS2ZMhfzikcUkK
         BKv3nQSosVo14J/WO2BfjbLZHn6KhbSjmQPYpQw1qAAxUK4YwxWqNujdwMDYpbjQb6Vj
         XvQ1svp9t6+EEfWVnHrQjg9dPW/1x3gVeiBndn5m22eFJKfgdB/gCeAWp0G5jlD8Gwlm
         ZUwjlYcblQWNzUEGyKdy7n9ULb+QL0WNkc32AlJ/WCssJoOeVEL/L1OG7SokU5P8IdEe
         Fs1/CxM6yIDXVXYJCtoWxOLEKObrmjhnDd9DfZ8j5ozOp2FbZAfLXUtj6GsE8g+vGV0r
         2Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962506; x=1742567306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TT5lvs+qRaPNuOxeRfDnkvZSNjnbXB6XDMYlNWqs1E=;
        b=ewz/7HkQ93Cys5puHfCpJUPt2KLGnZ9spW9RE1RnT2YxihuhGqL0/0wVIMvpaMSy8M
         nI5RQWGyl++W02JEloU2v/i4w5JrPbJIABVXjH15pWvhO4S3Vwme4QLV9Ahnyvh9srsS
         bDvv+goraPGUqNwKV3p++J7cwioER7akPDm4YVQPXuXjYCK2Bx8VfNWb/Sc+XdYsrYMs
         tiKZ9H/TzyggVzJXlPTn6fv9ajUbM4nPQ1jN5l9ljdmjCV/DLaGJtRJKiq3MasaZ9Nho
         Sr/TzL7s1PXjj0mE0JBOMfe6lQed4q6jORhNL4uFf9IQ1nPfcwXvueTQt9GsB9cJR0lz
         pShg==
X-Forwarded-Encrypted: i=1; AJvYcCX75kQvxYnGyNf+EUPbH7t2IPnPC3rVhL/eWkUeTfR9dDmBi6oVmDg67bkDbjzCR4EAvlWA25MM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rqb/mJO4h3qHeCzm12m82n6OvET8dfnCN/xYdENM48HOVZsu
	ER6cq/GWLwOHhNTLlXBnIZEBRjKDtGXyievU4hQqLUuwNH5rIoBu5kPmCKulsNPxQ2QzE0TpEPa
	RcI/8cBh99A+TgPSldis3Iy50NrY=
X-Gm-Gg: ASbGncu7V4JfAMGlLzDizqu2opJTMgI3TC4TwkVgz9eYsi4Fk+pxMn2WPhnOZGvQ4DV
	7Exa8i7SWAPiAiaPM6bNxPnHaVDtlF0warzLa2c2b5LXduSY++yk+siRuuZOfa2YJ1UtChoS58P
	DShx6JOVatvQWIhckDPBtl+9wRPQ==
X-Google-Smtp-Source: AGHT+IE2O2zhf/HYC/1XTAQKdx5d82D5z3/xErDl9CQ27QaK4q86uPWMBPz2otac7pMcW0pg62oe0MGRaNQcCOiucFQ=
X-Received: by 2002:a17:90b:1113:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-30151cef70emr3174490a91.21.1741962506435; Fri, 14 Mar 2025
 07:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
 <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com> <CAJ2a_Dc4pNdL8bp_wydmRmQ46GXkWhcA5jTVApF3E415stcA=A@mail.gmail.com>
In-Reply-To: <CAJ2a_Dc4pNdL8bp_wydmRmQ46GXkWhcA5jTVApF3E415stcA=A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Mar 2025 10:28:14 -0400
X-Gm-Features: AQ5f1JqjId4022macl94GtE-l485B_8cuMMleUse_zS87-9xy8WVSEPC3M546Nw
Message-ID: <CAEjxPJ5VuJpcZe-j5auXjviV=79jR2HzWfo-qPFAioRcw6Fi_w@mail.gmail.com>
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy
 instead of cache
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 9:01=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 12 Mar 2025 at 14:04, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Mar 12, 2025 at 4:01=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Retrieve the netlabel_wildcard policy capability in security_netif_si=
d()
> > > from the locked active policy instead of the cached value in
> > > selinux_state.
> > >
> > > Fixes: 8af43b61c17e ("selinux: support wildcard network interface nam=
es")
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Do we have tests for this feature? I didn't see any.
>
> No.
>
> Is there a way to retrieve the context of a network interface without
> actually sending packets? (Then one could simply use `ip link add
> $name_to_test type dummy`).

Not as far as I know. The inet_socket tests should exercise the
relevant permission checks that use the netif SIDs.
