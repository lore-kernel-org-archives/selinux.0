Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996A1FBEA6
	for <selinux@vger.kernel.org>; Fri, 20 Jun 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445311; cv=none; b=hvTN7zG38ib59z5PItniNLm2xgcsjY1Ysn0oStAgyeHFQrDVYDDOxy/6MaOfIGF/TOfsri0Dm0V6Tfy1M9rX8zTKpu3a/DslZHl96jsmQaxO9IIiMne+UgVroD4vUWMSxVvYJGkRdNYnLErB1/8S8IYpO4l4yzhpxDpu7+p7Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445311; c=relaxed/simple;
	bh=UgAGfEg6mWnQnX8gl4ifHKcdRw6iSUc8PBTq/HOCf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBO0xpy91004OnHS5Q6uwiyoL1lVtAj6p/yxrt/DSNmAgs6fN0DOW+PLiTzDnyJTTKdugoM0KlBLEy4Azn5kPyrKz2DBTOYCgXrWm2HGclyqIVO4tkXNypLK7/VFyTQlisdZKzTujrp8cbvf3UrC2kXTHI5e9uu7hXOH5ZhxR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvNMh8U5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvNMh8U5"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3137c20213cso2148461a91.3
        for <selinux@vger.kernel.org>; Fri, 20 Jun 2025 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445309; x=1751050109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgAGfEg6mWnQnX8gl4ifHKcdRw6iSUc8PBTq/HOCf4s=;
        b=jvNMh8U5Ra8qhsXFweozMOR3mPETXw5fGF9nqKE4SYsLA1R4xv9ST20mAoTqb6W+Fa
         3mo5xgliv3D5G3SvGgwuno4d3JUoFKQVMpVkglEqH7kE7mKan7hRfIAzaDZFK/0vKTre
         QsMi6Tx/bDWfLL809yWT3jn+hXh6wulHyK5wuTV+/MRssdwXdEWbnugm0bgw6XnrFICr
         UKqhpNFwliFoWeYvAXND9tSb5sUQvXcsMSnq/VYtufqM6S3dzfoU9obtd336pzUqm5f0
         57KGKmPn9oBCzPjTUux1ohZ0T0EsG3JPl0w8vMExqEKATlYqn7s0PmtKOsrnR3oNenp0
         UWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445309; x=1751050109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgAGfEg6mWnQnX8gl4ifHKcdRw6iSUc8PBTq/HOCf4s=;
        b=wKy8T6eHT6AqWsF0greMetkmxx2OMYJ54kg6dCOScq/qBAVfdsH61cOW/gvr/OC09K
         Zho+fu5ju3mm1GsS6OdCdIM5wwLjEW7vliYtuJu+UDUhYYhl6O3N2DOngTbVkpK7yA/p
         0LvJsxwViHPOlGFg0FcH964iNoOPFkCwZUKv2q4sjHO2ZoHLn75C5rczDbzUj4d6m192
         SH3tTkK5K89PGBdp5TNzCW4snsm8+7sdx3Nrg+uEQRY5IWOlPPxH7VscM5+gabRg0VxG
         Ro6PG+/Xl0IcmnwYX84OAEek8EGl18PC2ZEtkPGI3zhmyfFO4pr3Zjse5mMGbZ99V3rK
         cHAg==
X-Forwarded-Encrypted: i=1; AJvYcCUmv970RUxg5ILoyoUU1uPe9gYSIhGpknSYZWeVJ7TQE+8OQj8eWgibJ7VFFGaO6QSHfALpAWjC@vger.kernel.org
X-Gm-Message-State: AOJu0YztooPJxGozcf42x5L9QRw5lxm4XTWdYZD1VpZ+EaTgvsFHrOQQ
	389pxMj3Wf5XQ2L5jwoG5Qd4Lqd8AeSOyTbyBD/Hxsxa49gHpHU720Er0uY/u0SJNs1vedOil5X
	k+K6X4Df2F8kmVoM0fCZy0C479tdheMtTIw==
X-Gm-Gg: ASbGncuPbD4pGKYrD76IlGRq1B2F9AxwsAC32KzaU3z+XA6KJ/qP8WuZ+ZeWR9gvklL
	gWH3Vq12kp4JzZBKf7PRZD1FJTqAFsHweziHFqcwCVjsY5ZoPCLxFFu9YVKHPy3j0JHipVdteHf
	K943a9g7qNwUeBp9VfzC9JwiCE3CEHrvuMlxwMhUL92jI=
X-Google-Smtp-Source: AGHT+IH8BrrX43L4DkqShVL5xW+haQpXSuyGlFhEwn776AAxrYIGwcy/YXJg1X0HbIzseoMflNUhux4xUzwuUIQcOJU=
X-Received: by 2002:a17:90b:3d50:b0:311:a314:c2cf with SMTP id
 98e67ed59e1d1-3159d8f7de2mr6022386a91.30.1750445309556; Fri, 20 Jun 2025
 11:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
 <CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
 <CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com>
 <87zfeky6lz.fsf@defensec.nl> <CAHC9VhT-e8=TrjVcMYW8um_DrA1V1u6m+qrH1JCQ_3fxJY__Ww@mail.gmail.com>
 <87v7p8xc40.fsf@defensec.nl>
In-Reply-To: <87v7p8xc40.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 20 Jun 2025 14:48:17 -0400
X-Gm-Features: AX0GCFsHNZXaG3RKln2WNICnMvW45EfTy9QpTCvFPqzHWMval4UttMC6ff2IIKk
Message-ID: <CAEjxPJ7aV6foQWrRU0+TJ81Dgco0BnMpBzeLDqYiO2CxxXuQ8w@mail.gmail.com>
Subject: Re: selinux userspace wiki
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 3:08=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Fri, Jun 6, 2025 at 4:13=E2=80=AFPM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >>
> >> > On Thu, Jun 5, 2025 at 3:05=E2=80=AFPM Stephen Smalley
> >> > <stephen.smalley.work@gmail.com> wrote:
> >> >>
> >> >> On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
> >> >> <stephen.smalley.work@gmail.com> wrote:
> >> >> >
> >> >> > Since I created a Getting Started guide under the selinux-kernel =
wiki
> >> >> > [1], I also did some refreshing of the selinux userspace wiki [2]=
,
> >> >> > moved the Presentations and Papers sections from the kernel wiki =
to
> >> >> > the latter, and cross-linked them for easy discovery. However, I =
had a
> >> >> > few questions about the selinux userspace wiki:
> >> >> >
> >> >> > 1. The Home page and the Userspace Packages page are at least par=
tly
> >> >> > redundant in their content, and the actual list of userspace pack=
ages
> >> >> > modified for SELinux was very out of date (I added a note to that
> >> >> > effect and how to query for a more current/accurate set). Should =
we
> >> >> > drop one or the other or somehow combine them?
> >> >> >
> >> >> > 2. The Tools page is likewise quite out of date. Do we want to re=
fresh
> >> >> > it (and if so, does anyone want to do so), or drop it?
> >> >>
> >> >> Sorry, forgot to include the links:
> >> >>
> >> >> [1] https://github.com/selinuxproject/selinux-kernel/wiki
> >> >> [2] https://github.com/SELinuxProject/selinux/wiki
> >> >
> >> > I refreshed the Tools page, deleted the custom sidebar that was
> >> > (presumably unintentionally) hiding several child pages, and moved t=
he
> >> > Other Resources section to its own sub-page,
> >> > https://github.com/SELinuxProject/selinux/wiki/Other-Resources
> >> > and made further additions to the Presentations and Papers sub-page,
> >> > https://github.com/SELinuxProject/selinux/wiki/Presentations-and-Pap=
ers
> >> >
> >> > Feel free to suggest others that should be added or if you are a
> >> > maintainer, to add them yourself.
> >> >
> >> > Another question about the old content: the Contributing page lists =
an
> >> > IRC channel. Is it still correct and used by maintainers? If not,
> >> > should remove or update appropriately.
> >> >
> >>
> >> Yes #selinux on libera.chat is still correct and used by maintainers.
> >
> > ... and I'll add that Dominick has been doing a tremendous job, over
> > many years, providing help and support over the IRC channel too!
>
> Thanks for that acknowledgement. I enjoy talking about this matter and
> IRC too because its easy to hop onto a channel and start the conversation=
.

Yes, thank you for doing so. For anyone else following this thread, I
have made further updates to the SELinux userspace wiki, including
making a complete pass through the Tools and Userspace Packages pages.
Any SELinux maintainers are welcome to make further updates directly
and happy to take suggestions from others.
