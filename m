Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17D308F28
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413367; cv=none; b=gOlB539Y5TaQUtjB9fOz47PL+9KUl/J+FfW5fYe6t7+4dyDbIpbWHLY/6oSetxCTlAMAYdOoswcJFlJ0qbnuZy4JokqAJzcJe2EspoFshOQw+ur7SFtIyTJnFmIWspusOleX7L5pak46Ztt6PntoxalrR3XlTyWWOlCuEKlzcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413367; c=relaxed/simple;
	bh=KjcqZLTvSaEqaPGp61Oac72t5ZdLczvDU0m3jSH0/to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfvcJnahmcVib5pSJ0vADg8ojPwvSap4kC2G3OeVwxfY+dF8NXLA45o9V/I4vE29mZUpxhisYltApNBZDLVee9wBlLm+7JenHnj0H+j+6QcmcoqArGs9Tub7go21rtfHVj4/WUD1mfSpTXXbk6Sd5AhDnOL8l80A0hFlUUZNYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i2PqZRE8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i2PqZRE8"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79273a294edso43989337b3.3
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768413365; x=1769018165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFlmt3sIn8Z0F03/apkIHMfoa9liQ7rfyJ1h7ntyW1Q=;
        b=i2PqZRE8J5dRIFVuPAxPi4orhpdG+eiSdEO/thtNCo9fjF1bPv2ubMD+VbvLiJJKch
         +tO4bR50rgAVpiD65UaLkZ1kiwfl2baetaQgM+5RPXsAfhskl8nKVpo0a6PER/rZ4eqJ
         5gFCGjnhGjiecGYxw6vMb0CsW34NZvRQSY3faCZNEOhYp94rRU0t1l3OdKpaid/BOTmO
         mGwNnDuxMrfa5Ua51BaiU1rzMnaKEs/RuBfi0pmLk3nj3Nmi7HZNlBEFOCbNf51yb9w6
         sPvyMTmCqg3IjDFbEREGhNeZGZI35mCXbbB++BfI14hW6UP0l/U60XIr93oUjz2yEqeg
         mQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413365; x=1769018165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFlmt3sIn8Z0F03/apkIHMfoa9liQ7rfyJ1h7ntyW1Q=;
        b=WOfPuBdW5meeOKfvsXuMwSqIYOpDorFOCbtK/5DCy7BFovZavvFZ0WB0zbbxZ7oh68
         W4I/EnRtJIqBVcwgQgPaV6aRfkbCqsu2hWG+l0ICFpMjQlVRox2jzj71UUNdNF5fMhlO
         3KiWTwPqxFddAlkY54ux1N5zJxcxtz21KEXLdzChgpoKXrrhFosMtIxvdynFCDEhm8R9
         LijSFGb3GoSdIxa0W019ujL+hMTDCNOhR5nKI5WqQ9Acs/O6rpis6sgYAxWdYpZGLIM/
         Zv0kPRlbyTMo0zv4aDZkxUasZF5njkIeCmo2gs1nnOAnu1QAeumPOxvrcDyyUj6b8st/
         QL0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHQe1lvESYDFDeY/PqzLOBO276hoo0pSHobnSxkAsD/7jeN0laHdq+DbvOLH31/T5A8izHDCuk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfx+2pik17LcBcENwIu+zhkInerEYtWEllmjQbYSs7h5TCHFC
	oE4gqxeWuxjLALRwrb9l/RgHUi8SUQ3RXpDxI6FmX5RI+a9JLNgt9I+Rv5OjyV+2k/1couB4BIF
	Uk3awDeJAFWCyWqKUXuZ8CcOI3XKVn6U=
X-Gm-Gg: AY/fxX5QyLAcJXyZtbe7m3IV9MXvgfmvBbSRUkWx/RRYDv9io0AahzElMOM8WwBcYwp
	tJY/31WlbhFVFr/ZsYYf4zoKyAlzTomQyLWlagj27aDP57uAXRAVmEcp9jzViHwHHcyRoq6Raje
	xQHDPSlyqJhjRCw9dFDIgwfA9qsjqL8pS1oWdwD5CVApeiRlzK7ANMP/Y9yMWPcnrKA0fr0USz7
	BrJoPuRmMPp7mGLiFRoREVqgw9ofypEW91Z31+F9txxiTV90inMNAh9dAQQnzL6JBMy+QqrMoXQ
	37AK9Q==
X-Received: by 2002:a05:690e:b8d:b0:644:71e8:cd02 with SMTP id
 956f58d0204a3-64901aa65e5mr2899048d50.4.1768413364533; Wed, 14 Jan 2026
 09:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com> <b687544287eb8850f24592a207a0b846@paul-moore.com>
In-Reply-To: <b687544287eb8850f24592a207a0b846@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 14 Jan 2026 18:55:55 +0100
X-Gm-Features: AZwV_Qh53DG07R5vjO4lnwkIQ9mAfkkPQeFz58DOSj1aPAL9B5kicX3CAsaNnEA
Message-ID: <CAJ2a_Dfk7R2n99790ke+b+LBUAY+Jn2Uq-kgm8yzUvX-Hx4xAg@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jan 2026 at 21:45, Paul Moore <paul@paul-moore.com> wrote:
>
> On Dec  4, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
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
> > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
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
> > Changes in v5:
> > - Moved to dev-staging branch instead of main
> > - Added implementation of selinux_bpf_token_capable which is originally
> >   from Daniel's patch
> >   https://lore.kernel.org/selinux/20250801154637.143931-1-danieldurning=
.work@gmail.com/
> >
> > Changes in v6:
> > - Updated bpf_token_capable to use grantor_sid as object in permission
> >   check
> >
> > Changes in v7:
> > - Bug fix in selinux_bpf_token_capable where incorrect source sid
> >   was used in avc_has_perm
> >
> >  security/selinux/hooks.c                   | 117 ++++++++++++++++++++-
> >  security/selinux/include/classmap.h        |   2 +-
> >  security/selinux/include/objsec.h          |   3 +
> >  security/selinux/include/policycap.h       |   1 +
> >  security/selinux/include/policycap_names.h |   1 +
> >  security/selinux/include/security.h        |   6 ++
> >  6 files changed, 127 insertions(+), 3 deletions(-)
>
> Merged into selinux/dev with some minor line length and whitespace
> tweaks.  Thanks everyone!

I think there is a typo in selinux_bpf_token_capable():

switch (CAP_TO_INDEX(cap)) {
    case 0:
        sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
        break;
    case 1:
        sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_USERNS;
//  <-- SECCLASS_CAPABILITY2  ??
        break;
    default:
        pr_err("SELinux:  out of range capability %d\n", cap);
    return -EINVAL;
}

see https://github.com/SELinuxProject/selinux-kernel/blob/5473a722f782f79f9=
6b4691400d681c01fcacc2f/security/selinux/hooks.c#L7263


> --
> paul-moore.com
>
