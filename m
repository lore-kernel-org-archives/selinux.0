Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110B285CB8
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079232; cv=none; b=HuQW2vuuqC+Oth4ESa4VTb1qhrpfn0EuZEAh6zEboAVy0JFHy+RALFoMi6D9qjNYcurvM1Q3kJfXPB+gmP08X5zC0Bk/WJ9Pb5w5p+a7UFPTw8+xYG7zxIM2Dt704tJXmmhfOIHc0YZyymKtVxKAQ09vF/020UanbpEo/PTXYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079232; c=relaxed/simple;
	bh=jIC9bZ7v5oLFglVMO+satMjgouFAAxO4H+ZX/1Jc/g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvz4omacoPUq/hliTmaIlKymDFHUQkDyuOBDxChCvBQ7t5CthXn86ROCC/Fkdw0MrYcdjjQnviFK1/xeQWkaO6uXEtJfZn2bq9Q2b54qy4lo03FspMKKO2kjkmD46pa2byU1m+3/kfluBgZje+S7gD4BIuQBvnemeci121htSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfF576J3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfF576J3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so3295486a12.2
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750079231; x=1750684031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIC9bZ7v5oLFglVMO+satMjgouFAAxO4H+ZX/1Jc/g4=;
        b=FfF576J3fGGiCnid8uyy1uGlz0tst824V3Gtwev9duv0P3q9eFM5FNPjc1Nu0iMK02
         hIVwE0dTmc/m1FG0bVdS2g3g13v1TwrWmK1UsfGj0ldEJG8W9aNETptXNNrL/kgh0VT4
         mAyz8kQLbONaBno6cSNw94nx+wrN+ypIClgzu5HXkqqwQvcB3jhcWN789/dPvfcFcNid
         cu0yMTPguXPHMe4EyuxVRODMjMgiuVpfuSh1eD0A6NY6O7zh2OUgDT8nS9UGWUq766ZG
         JgeUyzsORIa84kRvPz5TitRvkIEKIasLBnbFYN6nWOALEXx4yjCEkbQMMWIyxC5L08hG
         i4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079231; x=1750684031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIC9bZ7v5oLFglVMO+satMjgouFAAxO4H+ZX/1Jc/g4=;
        b=e5+B+bTX4nOrWHUJyYReWYcH90Z3oQMhro3gD33YDpe66TK1W5WwfRfYNrn8iVZD96
         Z+v8Y6Mk6OT5SU7VXyd8yvzvn2dH70YA4swvKNxD8Xf4PLEgleqmBBoVCKzXBwvRsFR2
         4jEDXhIVmrk+plQwWA/whPjpvw6EnyGsUkG8I9ZXmeDxJmZLONc4IE7qrhjM0aVczKTa
         wOIRm8zjmKZAawI1ZlGSOyyVPw11ZQxevvJgQS4+iY5ZhYjkkyTJ3Et93EeklcGIZAHG
         DteWwVp1mC/JOkqLu4yTERxR6mH8OUt4tn5hchG4U5Y0+xbnSbxWloQVnPz/Xts6RD7Z
         XwMQ==
X-Gm-Message-State: AOJu0YxsFIbWKXdlUmFn56cPrAdiPueFEwisZK5YUvMZwYmmyA30CPdp
	2OuA8/2nd1ye9BPJB/boy+yL1miSZThJ7CTdnJ1nQBKXdbEKBjXxO0VEDYzHDPmQDnMqHjhXsz9
	ACM80FoFbo6qD0UhS8MOWUX6pdx+d5KeCkP3F
X-Gm-Gg: ASbGnctbfWt2Zrf184kq6siww6BVphQwnkN6wUr+EWo45rLwB8qEAXT7/nc5hPJGC58
	GvBDlgMBh5+AhwmvoWCAiZ1M8es0KBneEt6ZB2Gw5YokMdg9j0x5x1i4F4ktBkjbQ5fz/JPY9aT
	H+LwMOEYhaJJ7oxVRt/WyXGAG7XcRTDdwLqFa/efg4GXlzwXXTdjqRJw==
X-Google-Smtp-Source: AGHT+IF4zhvbPSVbZApvxr0/JCT3Spn/kgNdShuFnUYN55BB51aEKh3q7Yi6P8bxwFKjk6SVjavLYUucGmZhaA9BU1s=
X-Received: by 2002:a05:6a00:2181:b0:746:2ae9:fc42 with SMTP id
 d2e1a72fcca58-7489cfc37a3mr12735950b3a.19.1750079230558; Mon, 16 Jun 2025
 06:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de> <CAEjxPJ621C3V3wiPwaYvUVUMs--590iGjE5Q=ZScy3wYuZtXQQ@mail.gmail.com>
 <CAEjxPJ6Yin+JiSz9ZHjgtOewEy6xacpKw9KDd=mEfFYnv4JuNQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Yin+JiSz9ZHjgtOewEy6xacpKw9KDd=mEfFYnv4JuNQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Jun 2025 09:06:58 -0400
X-Gm-Features: AX0GCFtzXfvuFT7izliZzLoi2Dl407sC6_l87bC1n8TsgwMbq5-Ufpl-asmd-GM
Message-ID: <CAEjxPJ6xhg82i4asWO93-Co7WZTjOkPxa4nTYo5wcyTYzcFVAQ@mail.gmail.com>
Subject: Re: selinuxproject.org down?
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 21, 2025 at 3:30=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, May 21, 2025 at 7:39=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> > >
> > > Hi,
> > >
> > > I might have missed something, but selinuxproject.org is down.
> > > Is this intentional?
> >
> > That site has been mostly unmaintained and archival only for a while
> > now. If there is anything there you are relying on, I would recommend
> > copying to the github.com/selinuxproject/selinux/wiki and updating any
> > links.
>
> Also, you may find the content available at
> https://github.com/SELinuxProject/selinux-kernel/wiki to be helpful.

I have populated
https://github.com/SELinuxProject/selinux/wiki/Other-Resources with
links to a number of SELinux-related resources, including links to
per-distribution SELinux information. I would recommend updating
selinuxproject.org links to refer to
https://github.com/SELinuxProject/selinux/wiki instead.
