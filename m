Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC126BFCE
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803214; cv=none; b=dJYRVW8NXe7nHEq0eRjqlCsJGkvFbaG34w35UxK6wgjJFXWr3D5vw8qZoDKnB8tSoVF+rzL420lTRu9FkFb5lTeJ+XfL17b7GUr/5ksyXfIBB9NKo3nzzZtWMM3digT1DAXAHlfFhV1cX/v7gpd4IAWQ+lFCehtdsgIHXuhbGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803214; c=relaxed/simple;
	bh=Gj2Z3VM7XXwdXmZXc3Ring5EhajZ/J60TF7feen4+5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlb37jnABrM6wJLXLdjtuoyaYhX2U76DjlXi7kt0dpExBk1bWJITxGYa1xd2hlE1Ke2ZCE4rGvtIoj8fMDTXvu+/ZMZhZ0e+ueDOZKxBbg2d2oFRDiVgEHKdZwylgO8w6900ortejR3PVFz7+21FLy2DD/8rGvWOAaXzp2h3Idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgvnCwwE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgvnCwwE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2449788923eso10686705ad.2
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755803212; x=1756408012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xii07RlM+pFisAUiJHHx1zdNbyIW5eZ5+W7VdnuBJCk=;
        b=cgvnCwwE9WeAzWoPJFwhxw8zYmPdaQYVrVGafRax7huoizZmwDH0kLZibcOKgxMh3x
         7UE02FQWbAOrx44eza5Gk00mK3D/DTea0xAHc8fXyB4ZHTBA5PuoTfQVDLe1Lyn6JdzD
         XEbCbqjrRFFIN0xYiKY5v7I0bIzs1tfh0/KpMq6Vzh86wchinq37zckhtQAh9rivOTO9
         tAUME2/+iA8DGAFBr7FVHosfWmbk63UXGVxUUL7WN4RvKfNx9FV3EhOwN0ql30m1XbTD
         PAeA3OoLBWddiSTtMI8wdGTtXWLufmalZpjDTMQ7clG5eIrjhCyAgjM70PVSNDDmhUJF
         Co/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803212; x=1756408012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xii07RlM+pFisAUiJHHx1zdNbyIW5eZ5+W7VdnuBJCk=;
        b=CpSj4rJhDDKB5z5+xSdTdrruJ5NpU4CW4JnorHMrNGvGt1Pf1mhwz3Lbfe80vWhT3a
         g04Kaa90LyMOuW3WIa7Hav9JRhC+yNlNcLZnL6FR5zsk7TwySP4NEeT0+S7jj1Hf5Tp9
         5/1PWtrb/1M22zsvqO6tn6sCmuXPToneaa+7OIfpDRpZnJrkNf90mMyjllThoj8OpYYm
         GYmUJsBLLK9nmSzknA+qVMNvUC2y2okxGHFmVRhCnIhdrIFpXWLv3sFDHiCKfgKh6fRX
         YAH0N8fVNCyJr9C+fTHrQudZozayAqSaucGd3q1l0/VBsWwTqLac/mxFFQDDYGrZqYoo
         V3Qw==
X-Gm-Message-State: AOJu0Yw1u/LhLemrhz/MO2kV/9VK0u+Bie3W+hi4f+8LIr8/iJrhX73v
	E9pYuOaYw01Iea8H3YG+Wh2CGDAr5/afdktVoXwVnDB03XeYOicKpemp90XRKl97hynzNvkGZED
	j8QhJQO76Yw4zFHfH1xqM4/uPI+DU/QE=
X-Gm-Gg: ASbGncvAE0SyTxKF/qs1VRUgQI5Sk1yUazmel06Cqycmty3qgycZZYwbZhmYxaWeexg
	jUN/eIYrFhuGHbIE9TCqG2Uf98EwvPWQhHu+RtrT3b8ozpOQW/Ia/45o5odROfTdrQqb0MFj8j5
	Hf98RwFFu32dOvesWFrv9OdMmJPo91G7Z8VlCP795euhvvjYEUWKxD6RQ+ScQUnBdCmgCAWoCEZ
	DGD9De97YwM9apoiw==
X-Google-Smtp-Source: AGHT+IGEQtgI16Xz3dCfIGawd8DC9GO4S6fr2gyQDHwdiOWfM7AuD7Prh3fCmprL6L/a99PNUgeJoqgI106gWvfIuho=
X-Received: by 2002:a17:902:ce01:b0:242:b14b:15ab with SMTP id
 d9443c01a7336-2462ef61498mr5942465ad.42.1755803211906; Thu, 21 Aug 2025
 12:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250821182021.304-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 21 Aug 2025 15:06:40 -0400
X-Gm-Features: Ac12FXxwKBYiu7hgYzW-rtOgE35cpjV10dUu2Qk8a-J9bkmDv6FciU6Rt0Dd7dA
Message-ID: <CAEjxPJ5rj2XyBdLxWkc6SUp0Y2uovoO5twFixZ2uZLZBfMrRhw@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:20=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to an
> unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-=
andrii@kernel.org/
>
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
>
> Supported operations currently include:
>   - map_create
>   - prog_load
>
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
>
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
>
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
>
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
>
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
>
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
>
> Changes in v3:
> - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_create =
and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  security/selinux/hooks.c                   | 90 +++++++++++++++++++++-
>  security/selinux/include/classmap.h        |  2 +-
>  security/selinux/include/objsec.h          |  4 +
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  6 files changed, 101 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e474cd7398ef..d949e9c5aa31 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7110,7 +7135,12 @@ static int selinux_bpf_map_create(struct bpf_map *=
map, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         map->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       else
> +               ssid =3D selinux_bpffs_creator_sid(attr->map_token_fd);
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE, NULL);
>  }

Apologies for not noticing this on earlier versions, but here and
below you are introducing potential error returns after an allocation
has taken place.
Hence, you need to free the security blob before returning if
avc_has_perm() returns non-zero here, or the caller needs to handle
it.
This may be partially moot given that there are separate patches that
went upstream in the lsm tree to move the blob allocation to the LSM
framework, but should double check that it handles this situation
correctly too.
