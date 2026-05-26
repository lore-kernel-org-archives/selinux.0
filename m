Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1523F7ABE
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802478; cv=pass; b=tDoW+JtdRfeLygar25knD66EqrtdwM0MuMyI8C0bzd/QFkKq+zfMRSLFFezv0ahMkdquIqZCre0ZZIUcRPbQ2bjUxtRTvIOlMg5QDVpMx0UG7s1MBpzskWPVwF5/FENUROX/RK247PJpnkeVuuOke5oFcbQ7HGnW07e4TvtskSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802478; c=relaxed/simple;
	bh=ICC154xO41trJqemeGQtz6Jg0x2YMl8ej13hJTpgzoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjPYX8IzjEm+9kIb4zPBCP244SirmCakNJAbqLkDy2Yt+D574gklpiu2GnINxu8ozV4spbBZNlVhEIey9ev//7LrxS3IZZFVVoBOVK63GcgIZti3mFLAkCP3DX7pBG6kk8JxTKI8rRuCa0EDSROEXUZat/JVN/GNVu4tmpS2Sfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8RN45Wc; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8RN45Wc"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3704709a12.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779802477; cv=none;
        d=google.com; s=arc-20240605;
        b=J2SOcGIKm2BS0wq7gD4OCYiyF9C/ZHjUaoNoXa00Ps9eNaRrAp99fkirvqM4SP9tnc
         DqbPz3bXWJL3kqsW5+nkY5xMAYID2lwGUq+T2WVMfyqzJ1ovbH9DA2Uun91Qehn0YO39
         JMoyTware5dedpRXC4niLxSVJjBuYNmhSxEEGjvBMMcEctPshz3Z7iOGy/8tFVisU7jJ
         +5LLe6cwQP9kvX7DCOSZEqIq8muk+6KWKKT5COSiCmMEFqA2jYgBy2QLePhr7vSVfC0g
         hPqtXQ+kLTeWCzAcUW4ZWgZL9QGRT2Q433L4MogfBgvr73mH5q//2BFs2xIZZNHSuCU5
         tjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ICC154xO41trJqemeGQtz6Jg0x2YMl8ej13hJTpgzoE=;
        fh=1QwKmOBKCzaAoY8BhHeaS5N85aCEEO0c683iIQ2jtso=;
        b=e6kH+6d2F363v7X+CveAvI8CxL8xquAPokKls4yH5x0XIvhyy9r9V4jVLxyV1ldl3V
         e+S6bsXYpdFYhgA/iR5iZW5Gmj9dIBCCt6g+TmYrjx9oe89PMK+Atk+Quy0XbjHZ+igk
         FF9lsGe7Jdq0t9mTHbotymMw9rq0rSLbOLeCUE9mtYjvOkEqxZj8adwUI4URLC78i1BQ
         HVOj6FXvAM2m6kB4fJO9lpEV1GGdtan6CrIy7G/STIQ2buCrnwy6GChQSKXLL90+OeCh
         VZUbVk/iPTBqJAzbRdf7hQ3DeUJgW4kJx1zMP3exmLZqj/HaW19EOkpqkR6gTaoschlU
         0uAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802477; x=1780407277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICC154xO41trJqemeGQtz6Jg0x2YMl8ej13hJTpgzoE=;
        b=a8RN45WcTDQQ/w65uklKdAKEuCyHY2qZuEt5KzLTibgsIJ64HWz2NKfgFQA8a86Gho
         KV1AZzzS3IPAx921JzJfUEcQwPvrbVxLu/8eHNJC/sbp1MM298mDangPWzYR89Clp2rU
         5iriqSD4rXtjRNToGgSbe5QyiCwAnD7wwmpL8//ysIeahpx8xU3aavZjGHdk8paB6DoQ
         oXjEXGHoxTyjXBadvUZrnJFk5tGXx/vOebFQITpREkzY5hgRpkSuQqWe86tTziZEFzqa
         5L34GWs4ngGrwDr7yFXEetUgD0b6RoN2iV3OIx/0RCe+e2NfqDJHweAbYlqCgPKQulVv
         r8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802477; x=1780407277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICC154xO41trJqemeGQtz6Jg0x2YMl8ej13hJTpgzoE=;
        b=a6JGepNwr9OxBsFc7DzrkGtGSB7qn/HqC5VVYCkUYtJmxkS2ooJQ2OjQVn8N3Co2hE
         EWm3o72SYMo7GVzY6wrrwWkTtR+YncVUsdQ+LbV94MJHNCicn/4T0p3YW6jm5EjC3Yqh
         fImSofZjx2JfwZXE4MgXZp1II/KyR0+B/BrTk+CBrVMJ8WtKmBVSU/mcfPMhV5NUx419
         Z8X2JJzpNbSSaYztKyk7leFjfWs5qk46e3PLvIyZyMz4eYO3itbve3h6YL7hOJoEQO5G
         xop2hC0mk8p7dK7GgD3ZG7p2QOxMD8/3lMwnnGraZ+ttH/FwBgRjh0ZShDZEJQ4LAb3a
         OEqw==
X-Gm-Message-State: AOJu0YzGmt8jVnsMiZLltUgI1IGlBWMlwZ2MD2ghsodrJWSHMiIhBKtc
	XEkJ9JtOlPAu9k3wOo4A9mFzlnL9ZJmOcUFWFKeijqNGY9hThr5hb3ocjcyc3iA0LkFVMC+nHdp
	NqV6BNeMVYvrsilUBZrXSfX+hhIY9u9cVUA==
X-Gm-Gg: Acq92OGTyRj0DvOef8qMyJB3RjOB8OrXLlZlClfhu6EusJ/zO7QsujZQyd3dpADX6UZ
	VEQ7INrjnQeLbOCsIyf77E1g4hkWbomccfGLJdL6CCHLFcJZLgdiJvy9we02/nZRg/Lx6nRIgtn
	pmwvg7XNWYhQsR0a+GheV8Fm/3OxazAu6Zd6qF19YTtwSKQpsHdROqkoVBtT4/Y4kPmtAMzsFXX
	+j/GM9Jy8+ADB3uLbbtrSwVZFCRtzu51c9YxuV9pJSO84+UOo/Fh8Tm6fXSE+mv/iHiS4Gt/nn8
	JTCthAM=
X-Received: by 2002:a05:6a20:a105:b0:3b3:2703:11b with SMTP id
 adf61e73a8af0-3b328e9cc53mr20115224637.25.1779802476974; Tue, 26 May 2026
 06:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:34:23 -0400
X-Gm-Features: AVHnY4LXeVqLI4Yp-vtYcau6WSTnTgsig3DYvH-yFom4n4V9dVQoi6aoUWxhka8
Message-ID: <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com>
Subject: Re: Minimum kernel version for SELinux userspace
To: SElinux list <selinux@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Petr Lautrbach <plautrba@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <perfinion@gentoo.org>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> There are newer kernel APIs we could leverage to further improve the
> SELinux userspace, but doing so would require setting a minimum kernel
> version for new SELinux userspace releases. Not sure we've done that
> previously.
>
> In particular, I'd like to be able to use some or all of the following:
> open_tree() + move_mount(): v5.2
> openat2(RESOLVE_*): v5.6
> mount_setattr(): v5.12
>
> The question is what if any of these can we assume to be the minimum
> kernel version going forward?
> - kernel.org LTS kernels span 5.10 through 6.18 currently.
> - Android common kernels track LTS kernels.
> - RHEL 9 kernel was 5.14-based.
> - Ubuntu 22.04 kernel was 5.15-based.
> - Debian 12 kernel was 6.1-based.
>
> I would guess we could set the minimum kernel version to v5.12 and use
> all of these interfaces, at least in code not used by Android.
> Thoughts?

As further context, I'm only looking at open_tree(), move_mount(), and
mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
sandbox/seunshare.c, restorecond/watch.c, and
libselinux/src/selinux_restorecon.c. None of these are used today by
Android AFAIK, although selinux_restorecon() was based on
selinux_android_restorecon() and might be re-unified with it some day.

It would likely also be helpful to understand whether it is worth
further rewriting of sandbox/seunshare.c or if it is likely to be
obsoleted/replaced in the near term.
