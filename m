Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA03DA7C6
	for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424916; cv=pass; b=qP+SfRu/t5veDNkhuQmctj8N0w51tcLFjjNTLQbcVHQlxEdeU12LhSdnJNdHuAWMOaCcMaiDbJbIJX1ZvLd47cCKGJ8yMYl+tZvSk00fjK7Y/N12kcpRbuW3c/wiW8CYG9UO83bbqEcG4ITqDbc2qZYPGkCu/GLZhrxD2viTqT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424916; c=relaxed/simple;
	bh=LFC6T/TZlJTYTOG8xPec1ne49mOrG0PS0t61EwctXM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbGAHcZoPVmlNPEK5jtJ2zMamr02a8gDF3uw82tTJMY7rQJlXLFSaclMoyTKIdmKvdSEYBh+HPpVWCERYbFh3ufRDrwJ+dHZnumQae0Zvb+nWRmGbGaL9rAGYZLAxaz1akTSmegiPOZUWG6fnLup/u3+ZCZylobMGv7fOmWzGuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HW5IJgLw; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HW5IJgLw"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1530172a12.3
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 11:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773424915; cv=none;
        d=google.com; s=arc-20240605;
        b=GJPHyYaMcLifMB7/Qt7nBKQFCs81R0AGqJlqA2dtyjgJTFROKLucPWrE96Se+01nFR
         OpEWKvNClwLhiFVdfjMhWjydn+gZUhBcB0PiotJW43DUIK7hWTeJXwCZgxyexASjBxb/
         wUPCxdlZKRUJ69ZrGDa3Acojz2kAFGvDhVxNhVFbqa5CVzd29Kax9pNYvtEQULjlixUY
         qIAAS4u7OeYo6XT2TCAu159o0XArgCOe2+G9Fib/qiTcpetbLdhaEv80aufaqp3qWmkC
         NoU9jbj6JHnDzXWXWudzNTMR95ecOPmYEuiKvnLgMrxS4i98B5oXk4JvAoYTVgQLDXvr
         nq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zrju+RNVDDU6VgccZpstP9fjfPhQiMSfWUVUKBWkgBY=;
        fh=0QoX8eCdDipFKot6nhlvYldBm0m6bX6zwtH5vzMpT60=;
        b=HT7/ryvrfC1aG7qebnUTOeElDFe9oFWU0HikHgXCZSNtA2IREyMM6e9bb0XTRdPfXv
         fXdemDo9ODFOw7ZKgnFqnq8bMb/t8cCnI1TbnihBgF3hKqHxKhCdIiSxY6UB8ecKT/cD
         KLRt9Qhr6DicXVkcnbOQiiXEam0aoi5M5qwjuFaeVXEHL9oGUbwKs6WT+LofZgSgZScB
         rpj0ZPNkBG7CWUuv9P9XP7yZtw3andIKXN1wwFeYr+2ZPlJhHDE7+dmeAVsUOdr/H4ru
         UCibK1LBrdwQEamiUP5I2aYkF5vIbcTKW651qeShfPc10QsSEgKzcIlV5nfgcjX9Mkqe
         zv/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773424915; x=1774029715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrju+RNVDDU6VgccZpstP9fjfPhQiMSfWUVUKBWkgBY=;
        b=HW5IJgLwaF311zmj6p2Ejttb4n/Je8tJ4ZXR2dKKjNR9oC2swIRFJDzcV/N34m5tcl
         whWXRyUnUQVqS5Std7OBA5p/7Y0hVeZ+N0130fVF8DyBrj999gjDRKTY2PAw0ukBKvla
         KuX3k6kv7r93tIcvPVoUGAa+cItD0vRrT4vcRSeHLG50poGwan1rv2nMAfVBxX4qDBvI
         LwQMniyHTHvFnINGhryM+LShMoPWElW7ifHs/P6qtRpErLE2O+Ae4JIKKg1X5gekOBGh
         hHhW345M0WNG72T+2qJZMpYksQKWRV710rx2KjqpBqYQoDCwhJYzuN9fdkV+yi4y/QjO
         TEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424915; x=1774029715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrju+RNVDDU6VgccZpstP9fjfPhQiMSfWUVUKBWkgBY=;
        b=Y9Mb3ukKnPBVLqogtVqTveOjbq5//xdqxKh7VuKSrrbYVfx+vYDb6eFdymFY4ze7lU
         WFZFc8tfoLGKhO6e+wdBxKaPwtOE7RpmHCcUurVc8r5KKiq3RCvs8y2ItjPubDePsDV/
         3qgSbWuVB6kInW5lTEOaqCZfOS2AbN5n4EMN/sWwgTBs8ltPtcnKbjIsmNx6GWDtgVg2
         GKRpUkP/vdI14mPQAhkzdWOBhVu5E73WLNq+fnAOlKP5fpzM6L2sjAESYPaG901/cBmS
         SyzsUB+4Ytb2wvbMTntUW9Oj0HFlIRIyFk3q9q/EV0yPTTqmIajAPDlKg6PcvEhPfuIW
         shkg==
X-Forwarded-Encrypted: i=1; AJvYcCVFVn50Z0KC8b+uh/re43BLUuDi3XZ4HtZACO/qLd7YLBZOhOFpHRax6gHVYZVD2kJqng6xEdWX@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiuPAaZtQ7r5H5a9OmrrWYMTSUYbTpwDSRU873Gmni2S7t4A6
	ybztSfs5+457idRBDdyP71nb1XM+MNgqdvd1j2P7bF10hIaLzdezIV7jsJ0nWQD2t5xh3dgoj3C
	+5pm2dCKDIO9CTnJuKVbqkw1hxckvgnmDD72/zM9I
X-Gm-Gg: ATEYQzy2rvm0UA9N3o43bZ8j6Zi5BL9XrX6/1jZPnpfLtB17gsmFTjlZ76Vx7mIzuTz
	3UtcBWIzHq2k2OqFgAnRtogUEuvEnMUoHYeAAWkDKNJEjit7pMNNmJaQBK0QdDIiStRMBCmrHw5
	q8uv/fqEPl6vO69zX7Ug/9vb7yHuPrmACSbXhBgg43LaugX4QBGNwD36GKjzZ7gPSbslFGTgECr
	J4v3NVRQiJj4Bb7o+c/Jmg/SrknI6ucR1RWDo7+/lPtF9b3SEON27n7tpVai0kQ40cc59a6x6iu
	J0dGyi4=
X-Received: by 2002:a17:902:f787:b0:2ae:cae3:4818 with SMTP id
 d9443c01a7336-2aecae365c2mr42659805ad.49.1773424914503; Fri, 13 Mar 2026
 11:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313061235.9552-1-marwanmhks@gmail.com> <CAEjxPJ6Xft+Y1Nj=b_kSnBFdSVZO0h_MugObhvUD0x_WcybGRw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xft+Y1Nj=b_kSnBFdSVZO0h_MugObhvUD0x_WcybGRw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Mar 2026 14:01:42 -0400
X-Gm-Features: AaiRm52yLyYqPcw0aJ9jqHqtf6cB8iJhLY4Cl7ugXPdoW1nbLlKxf63V4QVy9WE
Message-ID: <CAHC9VhQPVt2XuSMQ3o6HmbwBrZiOE5WxhD0ZHL3Y_CtfupNayw@mail.gmail.com>
Subject: Re: [RFC] selinux: add selinux=2 boot parameter for permissive mode
 through kernel cmdline
To: Marwan Seliem <marwanmhks@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: omosnace@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Mar 13, 2026 at 2:12=E2=80=AFAM Marwan Seliem <marwanmhks@gmail.c=
om> wrote:
> >
> > Hi Paul, Stephen, Ondrej,
> >
> > I wanted to reach out to ask whether a change like the following would =
be considered useful or acceptable upstream, before investing more time pol=
ishing it.
> >
> > Background
> > ----------
> > On a platform with the following Kconfig:
> >
> >   CONFIG_SECURITY_SELINUX_DEVELOP is not set
> >   CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> >
> > The only runtime options for the selinux=3D boot parameter are:
> >
> >   selinux=3D0  ->  SELinux disabled entirely
> >   selinux=3D1  ->  SELinux enforcing, non-switchable
> >
> > There is no way to boot into permissive mode without either enabling
> > CONFIG_SECURITY_SELINUX_DEVELOP (which also enables setenforce and is
> > not desirable in production) or disabling SELinux entirely.
>
> Android handles this by neverallow'ing setenforce permission in their pol=
icy.
> Hence, they can enable CONFIG_SECURITY_SELINUX_DEVELOP but prohibit
> any userspace setenforce beyond the initial setenforce(1) by the init
> program.

The Android approach is what I would expect to use in a case like
this, and honestly I prefer that much more than another kernel command
line state.

--=20
paul-moore.com
