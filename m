Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CD81727
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333740; cv=none; b=ed+Sms3q5j+BrZcjYNAiBzI31zsaYER6gNR5h3yNrNOfsQnGJEX+arPJ3ynOrQS6IiVn4PyjbgW6VdRfTPwAedfm61ChEnCmQNCrUDXk/vrihSWtaDoaxIRzJXR9wGc8unC2pp/+55lzz9WUtlAVkZN1NZ1X0f6mK/unCIho0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333740; c=relaxed/simple;
	bh=oNlP/0AVChi/V+NbRC1FwmqGjAJ8NMWRIGbGB0xxZ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSxXrY1cb/9cvpIWZPoRu15zQUWVTdHS4sZHouEJTCcJ9H2Pn6GXUblu0Frxra8kBbBHbSqMrH6kJvHUu0iRXnIMGdwzp6xK+uH2NmZplKMFgLmr+7UZ3dq+frVozoQKqNRdAzHXWuHravLcUmXn4RgqfC1USKAmGBhX2xnk6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TmOkczAt; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TmOkczAt"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d405f238so4240675276.3
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728333738; x=1728938538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9nPNz5jKAqBu4xgTMU8r7QChwEpNtr52hYUvzp+xPI=;
        b=TmOkczAt/viV4lX5BY1Mj0LqvAWMmsXrIZZ2xElcReRoUNcy2MjfH7fpwbb+B4p0Xw
         43J4WXGIRUc9Eo5cEYLFpICgEJDrefZG2AxOLCsXewsBMkU+J1O4hZWtYRvsbhg6luXQ
         +ykx6KPF8nyRzunTh3bi6qpIspvnpcmIupiOP9oicJEJLj+Or6m21/e8qH9mbue/aoSZ
         pGJKvm5J/XDDHFQg3oPyYhChM79Yu3BVh8MofmGItgyayA2nSs7VBNkcegZNgNq3M5SY
         7lvKM6TFQDnvaViru9bo3njiKbT9YpAJd67iGuMxmARq/ZeR4Eb4H12XpwUhyvPCtuD6
         qWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333738; x=1728938538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9nPNz5jKAqBu4xgTMU8r7QChwEpNtr52hYUvzp+xPI=;
        b=u6H4OwoXynST4OFVX136aODwTguBtUk3C9Odijj7ATf+8BNMpGi4PzI5YE5tTVldmH
         NNw7BK9d3GxLoncreRFxCDxu4+WzAX02slBvVq+zpwvtykQAWEvV1SjRprvjrggEficA
         9pi1sSLo98eD7U7MIoEPfoR64R887/IUV0OmcRMCjzj6e8YMmA4vakZJbAsY3jeLzBRD
         upFvALPUp4q7DksVEehtkjbPSiRbIb/8P5Z0AelVnWbQjBjm6bPBoZKkQYpQtDQbfR6n
         4EyFkQKcQvpNWvyKxpJ0QWJ7BpI5LYRj+zhYLq7YCRsMX8VOYyyYf6bNXN/Fd6RHJcz/
         F6pw==
X-Forwarded-Encrypted: i=1; AJvYcCU0fecU6mHNI9X/zPKQrcTlrvbtP3kTkd/5g/tF8TwpG1YxM5Wu+Tf2ejvV7NkkDyoyXMNH0isS@vger.kernel.org
X-Gm-Message-State: AOJu0YzueJJYQrpZKb8I80mvsSDnNfcgtabIwUloRdU06tL4BmZwMmQW
	tCnRDU+jDPHkPQLxp8+COW0+m9ONayQfh2/mQLPJ7FnuFSb6yKzF7x21iHYuDa8DH0HGpq/LWP0
	THe1owqmBCyWI6y7mcFFkzCX9UKFt/QdVUmvbp8FYbl3GvLw=
X-Google-Smtp-Source: AGHT+IG/C0r00UO95Y3gDnfSJCY8GFCIXy9w1doE62W0BANQwGIYHgxm3K9assUO92K7maEzWsw5uU+0t5qP6+Nkyiw=
X-Received: by 2002:a05:6902:2b92:b0:e26:122d:90c with SMTP id
 3f1490d57ef6-e289395143bmr10209514276.38.1728333738251; Mon, 07 Oct 2024
 13:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004172709.25165-1-stephen.smalley.work@gmail.com> <e0e248fb03ce2e03b332c06d6f377715@paul-moore.com>
In-Reply-To: <e0e248fb03ce2e03b332c06d6f377715@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 16:42:07 -0400
Message-ID: <CAHC9VhTS=7OHAjrc+H0_aF7MCcP-SPnQ91ngnVKHTahkmAc=vQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Deprecate /sys/fs/selinux/user
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Oct  4, 2024 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > The only known user of this interface was libselinux and its
> > internal usage of this interface for get_ordered_context_list(3)
> > was removed in Feb 2020, with a deprecation warning added to
> > security_compute_user(3) at the same time. Add a deprecation
> > warning to the kernel and schedule it for final removal in 2025.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 switches to pr_warn_ratelimited().
> >
> >  Documentation/ABI/obsolete/sysfs-selinux-user | 12 ++++++++++++
> >  security/selinux/selinuxfs.c                  |  4 ++++
> >  2 files changed, 16 insertions(+)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-user
>
> Merged into selinux/dev, thanks!

After this makes it up to Linus during the next merge window, let's
start adding some ssleep() pain to this interface to help draw
attention to the deprecation just as we did with our last couple of
deprecation removals.

--=20
paul-moore.com
