Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3635BDC4
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147536; cv=none; b=Yxz8m502yOG5MuYxzsxEChZMwPyUlSJs6ZJMAEr3FG7UGLLdvrJqV6lj9DxXunKiQbGJO1SJAvp14QgR/r1fMWE8BIBf5CEmH0X5W9Rkxv48lwxfwWKtt1ZsEGY5IBkDguuCqbRWJRaTyEPmkJ3xCeGkMClfS0OUveRumy8JXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147536; c=relaxed/simple;
	bh=rmoRL8xcFj04gHNMhhCSjoLyJI+g5Qbbbi+H2qgKPiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHAexIf44UwgBW5+CmQ9ejMV5Uvmv1zhBrDcSVXQTJ3IqUen6x77NK51SN6AxJpRIGtzNF/aecOfXQAXfCTq4IR0T3YI8u9o5PxI39Xf2vb5/7yP1tWwlbMGxVI4AAO4gBsD7LQSZQrtNjdwn6V5F+CI2avKS5lFtVtY3wFvo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1l1JLNS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1l1JLNS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so88270165ad.0
        for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147529; x=1761752329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmoRL8xcFj04gHNMhhCSjoLyJI+g5Qbbbi+H2qgKPiQ=;
        b=V1l1JLNSOVD0dtNYBt24uvmSVPPoOrFtUV4c/ldjNruLPUgzdsjUnvuDso5OtYOjKS
         gK3bfxNw/LuO9SCLxswjKQWzF9LjSoq4LuwPEDIEsVveCAltgL+nQJWD+z9RwDVw86Ya
         aTBxI+C81BUJ+7DNlDqRknAB7NAnjyEWM2vZf+NZW6B01x1WEJMt7MuXaQYobVbYvzOJ
         jqgZyHbFqHbIBUNIcBNrKWOwGV+H+muav/Q+lHsYgAlqdgvrTVbX6f7x3YVFaeRYnFEG
         2Nw8Mm0kZmbi9q0/sKsSycTXHphrjqgdhrC/KFJRsVjpElZ4IuGDvTb9MfXGPhetWDYu
         3WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147529; x=1761752329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmoRL8xcFj04gHNMhhCSjoLyJI+g5Qbbbi+H2qgKPiQ=;
        b=CRJpUn9FnNRKq6nFFWP/oBl9i9DLrHOEdfkxk+AIp+KT+RLDniAky+Zp2MV/XjmYSu
         YZJ2jdYt08TXX2dPAlUNx6CSY2FnSLyFTOwkVPxxLu9OGHfmU7TSjc9S7TByxaB/9THi
         t6GDjgVB80QmCdb5avVudsSpq5VjYkdKTGWjrcxKedAE+msy2G0nP2eGK6ss/us5b9qd
         6wtnicbm7y7RbZA1nE1sG9eXcB5+YgvzR0ytM3VVZlsxHhjHZtqCim4TwtB4Sy3ydINX
         eOjMKhFcXIKTmwjNJxWYjZNKPjR4rOl0PnVe1AmgCKtqIV0zXL4dUnr02VnIcjcOLfro
         d/uA==
X-Gm-Message-State: AOJu0Yy5G75n8gE6G0pbdwCGaRrTy3eQHyrRVXSGt+me28K545sPYQ5b
	4AozZobce68hHg9485UdQkdLITqNvrHG79/hw5tiZSCWbHo+yi5f7JVg1IAcnq4FoslvPjFOsuj
	tqiXMTpPkoPh2YESFsl+1c1zLFHETgSKveA==
X-Gm-Gg: ASbGnctKOCcUqPtxZbXvTBBdondRwaGWvrD6VKq6OlAeHRczS9xjUX1JNlqXntsbpx/
	lmHqzphOJwVqYtJX4J52kfwxz23HBrvB7KGH1qaXbTtFnbQVOexrqjj70WotdnmuGWhl5lFpI7v
	Kt4y3SXn0lqrPPmXuUuRrSqYlTHeHXneeLbY7GjGtMHjwmCy8pEN25FKjMMgryKoH8Pi/T56CNO
	hpbMP+4urUm/gs/5WdVeoh7KDV+h976nS1WFyhojtAYaJwVCBRabjRH/xef
X-Google-Smtp-Source: AGHT+IEQ+ZqqhkH1VPVqfWdAOxyv2Z81vUkHOtoifY9XkxdwMlVHQINy7bXXWxvjYYmSwvyDsArRm34lyPCGW3xnV4I=
X-Received: by 2002:a17:903:1965:b0:281:613:844b with SMTP id
 d9443c01a7336-290cc6d44b1mr240624185ad.52.1761147529209; Wed, 22 Oct 2025
 08:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7VktYWYreg4PMUSTeoxRvBBoD0HVb1bsXdsach+j7PyA@mail.gmail.com>
 <20251020174027.11343-1-nvraxn@gmail.com> <CAEjxPJ5Qab+=YSVNFhjHxGrzb983XtqzKoTi5avbYQ9w6t+a9w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Qab+=YSVNFhjHxGrzb983XtqzKoTi5avbYQ9w6t+a9w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Oct 2025 11:38:37 -0400
X-Gm-Features: AS18NWAFyMoc1_gdHKMqFU8t2aTL7A4cvjh33wMb48LUc7pqpz8mMZDFHoOrAnY
Message-ID: <CAEjxPJ7Sfk+A3xunHGuMWWwpq65DsPFgCocpWKhgSXCSnGOEFg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 20, 2025 at 1:42=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > In package build/install environments, when semodule(8) is passed the
> > `--path` option, it is expected that it creates the entire directory
> > tree for the policy root.
> >
> > Some package managers warn or error if permissions do not align between
> > the tree on the existing system and the build environment about to be
> > merged. To make sure this is a non-issue, create the tree of the policy
> > root with 0755 permissions (in line with standards for `/var/lib`) and
> > then chmod the final path to the more restrictive 0700 permissions. As
> > the contents being placed in the policy root are security sensitive,
> > error instead of warning if we fail to chown the policy root to 0700.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
