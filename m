Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A9236A8B
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805331; cv=none; b=OnRK2ysb8i3uGgM0oCHWldZO8X8KeEgyF4kMOC3aLJVGm68HZ9Je4x7oNvXlWirYlrKqCqmMprPp8i5Gnp8IXeAfOkoisAxhcPgkomIJUGIhZERjl3Eo4Kk67ckMQFlyglR5S1hVYvdZsHHy03voSdybq4KOxY/eu/bLDRPDLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805331; c=relaxed/simple;
	bh=fBuo1Pcv3wpWeqYlRM10MU2wqom/DjCDnwAb/NsVOzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6SXM+7J2XOF/K7T6/G6yUHKulRBfVbOiyqDDTYsX98+YEikr1LxruOozl62p7Kq8eFOCMcStRWFfouPa63+W7g+54EMHE9yGfGBK5ODbsveKd6YoimwHCkGiMa8Y1W5mP4Lh5dGTzit5mURn8PE26Ry4qZOp54WsIChl2LaKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMvgF3XA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMvgF3XA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-324e7600bf0so1446848a91.0
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755805329; x=1756410129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ4xWYEzfYG9VybAasetnn3dSsUckvod1eui1/h7myo=;
        b=CMvgF3XAsZ96A28hkS40BAlMC+U7H5qJg3kumZpBw8fWsOFHjAVXZ6ZALF8r5Ln78W
         9edwT1LIJLerMzhJ9zaiHBaaXIw9QqeSO3/HIkLfWldA8zfkZYAa5vauIiEc+fbNU4as
         95PQkPa3eXJbTnpsU2s0GbHNFF3/Zr13m69Md9DTl+IU3GOnr0vNlHaquynvU+gM1tVl
         YFowzDkEJrrsP062/YBSK+tPYEVdFD/KFNCsX8sOBhzVj+WGhvRqkIKZmBGpcD0iroda
         1xJT1NGTeZn1N7FR2cpaXBPxeTF9kpHlOV+UfSOlHxKIs1xTrfUt5jqFdSkQqaP4ti0l
         mk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755805329; x=1756410129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ4xWYEzfYG9VybAasetnn3dSsUckvod1eui1/h7myo=;
        b=wIJjRqzD2PEGUgy0ZL6sTA8T9N7daKGaG6B+ZYoQVkgFc/Qq6N6TIQdP4c0CZ+3LwP
         5zJQ5yzzWn6beVu6Y6OwShRYUtEGClHeodeLXLPnMqQI1twiH/Sf9f72fp3xffWyQLfn
         /5CzEu/2rfP2zKFAA9KXMhTveM4e36U/U6qcNFrDz/P11TYHLIPGc6CB91R1gmIr2oto
         o3s8X7S0yl2AwerU4lfU2gPuXJsytksSZnCYQ4Qs6CBi/pMC+9Q/WxcQV6+NSzzpgJ8j
         F1h2aYlAPv0831HRRAHX54pVvJ7gGz9K2+4p/CwzHzssRPvOb3PG2NGLqfX5pCWgTnyh
         riRA==
X-Gm-Message-State: AOJu0Yzjqql2g5PP9Z4wTfpqSIkHRszKLI4zzLAIEvxyAOXPXxJlcaa8
	1Mcyif0ToCebpGibLbrt0DlbyPhfCJWdaa59uBFUdwijPqs/Ph+MZTPancatZ/8DGVDKshM1D6v
	60QZDE8RZNGER+4YKGahXqo4rUePFWnA=
X-Gm-Gg: ASbGncuoZfgRYzrZqeiPK1SvKzkY4qjUR3T9JecX0i6K4RMmeFMXFxLKIta+HGh0uAO
	ewkxkjNzu980TYM7lq1oSeydKiGDEeFmCrvipqlIzX/w74bI3f29E7iRCSV9XrFI6nTg9XrNTUM
	qEWW58K3MGanlR3tSE9cTnAjHY0kde/LLASstnCev7Nv1LuLNIhU5bGihXu/cCEN68p+SK8GKxV
	K+4SMg=
X-Google-Smtp-Source: AGHT+IHM7hU4Q2080psEPl8nAtWzPs4nVS/s/iGJBKbp/HoPlCmsP/0lj5OBChCwopECn8FMmZAmWJ4+qMp7RyfRHZo=
X-Received: by 2002:a17:90a:d605:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-32515eda590mr934880a91.27.1755805328865; Thu, 21 Aug 2025
 12:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com> <CAEjxPJ5rj2XyBdLxWkc6SUp0Y2uovoO5twFixZ2uZLZBfMrRhw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5rj2XyBdLxWkc6SUp0Y2uovoO5twFixZ2uZLZBfMrRhw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 21 Aug 2025 15:41:57 -0400
X-Gm-Features: Ac12FXwUwoDV-61Ha4f_sFYPCo_XBiIw8ivbOu2Z6wf8p7XsuVnH9WvfFyzQiZE
Message-ID: <CAEjxPJ5Y7mGiAkQ6SgjkYdp0m+e0N1V06_tac8333t-j5w0vcw@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 2:20=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to an
> > unprivileged process:
> >   https://lore.kernel.org/linux-security-module/20231130185229.2688956-=
1-andrii@kernel.org/
> >
> > This patch adds SELinux support for controlling BPF token access. With
> > this change, SELinux policies can now enforce constraints on BPF token
> > usage based on both the delegating (privileged) process and the recipie=
nt
> > (unprivileged) process.
> >
> > Supported operations currently include:
> >   - map_create
> >   - prog_load
> >
> > High-level workflow:
> >   1. An unprivileged process creates a VFS context via `fsopen()` and
> >      obtains a file descriptor.
> >   2. This descriptor is passed to a privileged process, which configure=
s
> >      BPF token delegation options and mounts a BPF filesystem.
> >   3. SELinux records the `creator_sid` of the privileged process during
> >      mount setup.
> >   4. The unprivileged process then uses this BPF fs mount to create a
> >      token and attach it to subsequent BPF syscalls.
> >   5. During verification of `map_create` and `prog_load`, SELinux uses
> >      `creator_sid` and the current SID to check policy permissions via:
> >        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >                     BPF__MAP_CREATE, NULL);
> >
> > The implementation introduces two new permissions:
> >   - map_create_as
> >   - prog_load_as
> >
> > At token creation time, SELinux verifies that the current process has t=
he
> > appropriate `*_as` permission (depending on the `allowed_cmds` value in
> > the bpf_token) to act on behalf of the `creator_sid`.
> >
> > Example SELinux policy:
> >   allow test_bpf_t self:bpf {
> >       map_create map_read map_write prog_load prog_run
> >       map_create_as prog_load_as
> >   };
> >
> > Additionally, a new policy capability bpf_token_perms is added to ensur=
e
> > backward compatibility. If disabled, previous behavior ((checks based o=
n
> > current process SID)) is preserved.
> >
> > Changes in v2:
> > - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
> >   creator_sid from wrong file descriptor
> > - Removed unnecessary checks for null, per review comments from
> >   the first patch
> >
> > Changes in v3:
> > - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_creat=
e and
> >   allow it to fall through to the permission checks which will fail as
> >   access denied to unlabeled_t
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > ---
> >  security/selinux/hooks.c                   | 90 +++++++++++++++++++++-
> >  security/selinux/include/classmap.h        |  2 +-
> >  security/selinux/include/objsec.h          |  4 +
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  6 ++
> >  6 files changed, 101 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e474cd7398ef..d949e9c5aa31 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7110,7 +7135,12 @@ static int selinux_bpf_map_create(struct bpf_map=
 *map, union bpf_attr *attr,
> >         bpfsec->sid =3D current_sid();
> >         map->security =3D bpfsec;
> >
> > -       return 0;
> > +       if (!token)
> > +               ssid =3D bpfsec->sid;
> > +       else
> > +               ssid =3D selinux_bpffs_creator_sid(attr->map_token_fd);
> > +
> > +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_C=
REATE, NULL);
> >  }
>
> Apologies for not noticing this on earlier versions, but here and
> below you are introducing potential error returns after an allocation
> has taken place.
> Hence, you need to free the security blob before returning if
> avc_has_perm() returns non-zero here, or the caller needs to handle
> it.
> This may be partially moot given that there are separate patches that
> went upstream in the lsm tree to move the blob allocation to the LSM
> framework, but should double check that it handles this situation
> correctly too.

Actually, it appears that the core kernel handles this already by
calling the corresponding free hook on non-zero return from these
hooks, so never mind.
That's not typical for many hooks at least last I looked, but seems to
be the pattern for the bpf ones.
