Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F81D61A3
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777901; cv=none; b=VQ9ha9ZvCc1b+R91p8sg2Ts+vNaEZXtBAIwmngTSRs4cxsG9KndhsFxk0ohcj1RB6luIOhH1WiEu9cTd9vv9SqaCilFBuP7UESLPO1gfUrRzifqKKyUkJrI7IiR10sRiUecFW4ZxVgy6TjrJ0LDJ0V0R8A+aAgbate7TunxKaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777901; c=relaxed/simple;
	bh=OgNQx6MTB/+Lkk30H35EjEDRp9V54treFcLAugrwVvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeIGTIskKzOXOLp0ZxT1o2sqQYYBY9W8CLbWKVEclRQzWx3rles4IvDnFJlglSOVSqWa3Q0QDloS10HnX7fkubp9KgtiQauQoVOPRTqsNPy2PKwVJtQdXdUH7gxhOZYekP1eUuwqM+IIkzku1uMqzR9tBlR3lf2/LnBmmIJrWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXlYm8jn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXlYm8jn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6219174a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777900; x=1760382700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYE5tladHjFyLRmIypI7gJmPqIaNZDMbSlmbfEfdnBE=;
        b=gXlYm8jn/Av4gYfbrOucZeeHW42dbytyMc3kgKt1B+5gXt+TJLY4wM+BXosD00FnO0
         wcjA2bFV0UhpTcAy52zzV42zb7nFWjfG5l5CZQL3UWOCP0ZG/WV+6mrKuwYNG3W+o6UO
         BpBgW3Hctw8soVNmAZmgUNkPpKZ2PGll4wNrzaNmHpgf6Z1S+MJH4/b8ZXZvRmkTXBop
         NBSQdDHd5Kk3k9p/r9f+g1Z7b6yYVExTZ/aLU5uZJWI9jevMRHjITot4RboNXKdHS0cb
         Dd7ZZZTYxzN5247EgfaWqkdjT3qPRXDDNwOqxnzpSl12AN/PuP1CYl3Tu3R2to9jGebL
         /8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777900; x=1760382700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYE5tladHjFyLRmIypI7gJmPqIaNZDMbSlmbfEfdnBE=;
        b=hLutgg6E5z+0iBIQGo5uyer6JuIImabEf87apBtzhM2DRZR3ynO1pETonD04mUBbI8
         3NR9J/Uq/VMyLpg6NEeMpcrAJrHcqideXXBCCoSeR/3/7UKMXhoiBQPu4Y1UOM9IogRq
         aNYMhuXVeZSmY0S34GEkt3LUwq4d8pnon3tDgHTzh01RuUvII5zao5E41XZlrJOm91nk
         dKT+8QC0aA4vhrNgrvoEb0x61UIVPtZNp8/oVXM+zzANZKL0Bo05zmVPXOAI3iJualfX
         H41emvyhcyzprm21cgAvAtevOvyuvngy0F4rnwiDjh3AdHrZrj1dPcySQyeNLIrpiSSn
         cBHQ==
X-Gm-Message-State: AOJu0YxlagIkLAb5eMlVdflRWDofF+vuXeFn0RgloNDETQAiMfo0mrwY
	JBJW8xRa+onFLCnxQx1EILVMEEW/xZanQ1knOAPcNSyyUQiO3SeKYGaIhntFIorgAVFoUH8egwZ
	OIinhGO8K60pMZbSZCutWglLHrWdRmYFH+w==
X-Gm-Gg: ASbGncuzAbVLbFGZn5pMopx7abfRjGurNNBPkMaKrGma/2k+SaLKEXhMLhVYXb+Spm6
	TdZeKT0hQAe64A17+GCARAoP2nYiQXc+0ImQ1PGufSfUEs+NN8JCGz0h0az2j8506BExovd3y1V
	7npd49BXRu4hKJgmQHAYCO5Ict6g3GJEM1ocqWK5dk2h44/2XZrLKqxyknoCAa9dvhx4lyWQoea
	LgRdbHE5Q5uX0ypGvzHBXmQYQwSeMVTc91Ri7kvIw==
X-Google-Smtp-Source: AGHT+IEb8m+6UZM4BcxDCVDLy6IZqUnA4bxwJG8aP2efxeyEq5bYswxaFu47wxOjoplmkjIOmeGmeHIo2/MH1gJmPcQ=
X-Received: by 2002:a17:90b:1c89:b0:32b:7d2f:2ee7 with SMTP id
 98e67ed59e1d1-339c271ec11mr15246164a91.13.1759777899553; Mon, 06 Oct 2025
 12:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172205.429-1-ericsu@linux.microsoft.com> <CAEjxPJ46pVykPEeXT73G5h_sAXuU68+w4kfW-fQrfM0EMq+xzw@mail.gmail.com>
In-Reply-To: <CAEjxPJ46pVykPEeXT73G5h_sAXuU68+w4kfW-fQrfM0EMq+xzw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 15:11:28 -0400
X-Gm-Features: AS18NWCZFeFT4oDqYIwoxRYU1UwR9QXmQ8ElcCnLQPH_vC42j-B31HCo2GZjizk
Message-ID: <CAEjxPJ4XyNmyXB5w+8a78fkQDMwF+DHP1efEJhXZPTsSABEAuQ@mail.gmail.com>
Subject: Re: [PATCH v4] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 6, 2025 at 1:22=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.=
com> wrote:
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to
> > an unprivileged process:
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
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > ---
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
> > Changes in v4:
> > - Added initialization of creator_sid in selinux_sb_alloc_security
> > - Enabled handling of creator_sid in selinux_cmp_sb_context and
> >   selinux_sb_clone_mnt_opts
> > - Minor updates based on review comments
> >
> >  security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
> >  security/selinux/include/classmap.h        |  2 +-
> >  security/selinux/include/objsec.h          |  2 +
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  6 ++
> >  6 files changed, 102 insertions(+), 3 deletions(-)
> >
>
> What is this patch relative to? Didn't apply for me on
> selinux/dev-staging or selinux/dev.
> Optimally should target selinux/dev-staging at this point since it has
> the memfd patch and hence its policy capability defined, and your new
> one should go after that one.
>
> Also, did you ever explain why your implementation lacks a
> bpf_token_capable() hook and whether that still needs to be addressed?

Also, if you could re-base your libsepol patch on the latest selinux
userspace, updating your policy capability definition there as well,
that would help with testing.
