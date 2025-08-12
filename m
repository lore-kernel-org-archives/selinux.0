Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE61DDC0B
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001666; cv=none; b=JaUR3JxbJNqEpIBfFKPy/hvn6Ed6DMJjvuZcJuyUd7fHPk6K+5k+jXcHTy7/BaGIwux6ypWGMlWxGdIOaMP1JeUNjAgp9HIGeY4PeLwYd7Sm6DSz7GUMaDHbaVQRvTR+D2gIgJrk7Gv/CkMwc1s7zwMg9SnM+bBkvBni4SMeTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001666; c=relaxed/simple;
	bh=952xq6Uz9Y9dzD0fr/lt1hHKSPNVztDhx6AcSSzrUGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRIM4cCxVK4WDPF8FI+vr18Yo6W4FAtZMCAW7/muh+qUp+9+40L1YmtCEfifgJsjXgQe0eC8y0xZK9fnHD31v+lG19ApmCnlwtRmBZWdZDvDhA38NBp0CPy7eLofQHhituzphb/NzdQvtMGkqE6Oc5uWuztiXw1tzIABwqDROYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN8lH+Ma; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN8lH+Ma"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so4816809a91.3
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755001664; x=1755606464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwCAGceu4/gql2x5fQ1kXpf2VxSRLnCVipIz+AYDNB8=;
        b=bN8lH+MazEqPW3aQ9MZ7RiW64mPLddX0EfAsl4Jbg6rRIFmZcvOiF0ptLzPmIVk2wS
         pSmf7VCCw0hv1dy0dpURvBI3hpDbMIh+/COUurBirrk/JfI+a/rrWzbBvF5XRPuOUx8e
         0XSTSuXkhz5vo52Ymy+O77Zh9W1R0MaNCrgDzxejoabmSbPRacNzRh8xxJ1+TJEODBT6
         S2NvQK6rP0SI1pXPh55MYYG8P63iVXxAx2nM+FRbreEOOqz0AE4isG2L4f5cAZgc8JNQ
         gBVUds/MbFrJSUrXnnIleQN1Rp63Nf7NLBFn7zc44f+an4Fln1whjm/JA7/VAuw9DsUl
         o5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001664; x=1755606464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwCAGceu4/gql2x5fQ1kXpf2VxSRLnCVipIz+AYDNB8=;
        b=H5DXLPaKTLBnZtJmRKQ4rtsFsl2f+5e/l44vas6p435qAu44djeHXwv50MZtdMuiuo
         CvicmPF/sHfqm+Z3L5QwN+r0/r6sbduwnTOEa/X/MM2b5htihyEa00gzYJUwcdRHbBsU
         i41rWaMm7Bc29wi2j6QY087r4Cjq8HFEw0PmaHMvXkC0H32BS4EcaqXuwReP2ctoULkG
         7FVIzJPwpbLsdX6Dwi2dlBHWtKvaJn8I9faYcokGj0vAzfFbERzAtQpipLzH/sncYuUo
         WLNBPyA0hGVGVw4n+kuM42e8z+GCiEJSar7ymg8fGC07F75B3EMKIWl+W9n/yFMsrZLw
         w0jg==
X-Forwarded-Encrypted: i=1; AJvYcCVbG66Y0DcICykMbhMg/l19qUUIj4vsdJe6v+YQqGBU1gBiz+h/ZgT7t0RuDiYX9s0k97nvvIew@vger.kernel.org
X-Gm-Message-State: AOJu0YxszFUgy7F/rGD6aiwNtXT+bcLf4OHpvN7BGSJcdfaigGZU8Y6G
	4Hy4Ls0AvRakc5nqv2PADI+nLxARtBrRzpj9SckV+D6a5Wv6GvQ4xCpfR6Oo5nmCBJaX46Dm8Iu
	3DhAz6RCxfXOUcsZRKa4flbtefy0V8SV6NQ==
X-Gm-Gg: ASbGncuqZZBkgPNjlF8hES9NJoFXrwlJgL2lGiTB8FLaOamIHCFxqzIrZFo2YWRwcpk
	vKMu7jYaGa0Ze31Gl55VioZK6cH697hrpn8RSDexPJ7kmA2aQ65fPZ/9nHCsbdDAMy+EvK2B/on
	GImjjhcmStwQA1PY58JxaLwySyqCvABxfhqhisNax7mLi+pz4jvNH08EaZpTYxVCrRBJl/QtYai
	QUmUVU=
X-Google-Smtp-Source: AGHT+IGTxLljGFzt76MsPzPw58ji/sy79tGDoirP/CVvsv5IPweo/O5N1ypkZtGNI01ae9xZPPikBvlj/bqdfjnBlO8=
X-Received: by 2002:a17:90b:2ecd:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-321c0b7a61cmr4207129a91.31.1755001663603; Tue, 12 Aug 2025
 05:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAKrb_fGECzqWO+Kq7n+5Q=J404npPyttrkLcXwLkdM-UZcZmLA@mail.gmail.com> <e5278ea4-33b5-48b5-a59e-bef7c4cfe866@linux.microsoft.com>
In-Reply-To: <e5278ea4-33b5-48b5-a59e-bef7c4cfe866@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 Aug 2025 08:27:32 -0400
X-Gm-Features: Ac12FXyQJ3boT5ELzMpCkXtyr6omVgJsgy57BrtQdZKE1YR6ZZNlH3BXyppFCcc
Message-ID: <CAEjxPJ6OgHn6VoXNhcUOxKd5e2AVzKZQajfVaqt40VENor=weQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:30=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> On 8/7/2025 11:00 AM, Daniel Durning wrote:
> > On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM<ericsu@linux.microsoft.com> wrot=
e:
> >> From: Eric Suen<ericsu@linux.microsoft.com>
> >>
> >> BPF token support was introduced to allow a privileged process to dele=
gate
> >> limited BPF functionality=E2=80=94such as map creation and program loa=
ding=E2=80=94to an
> >> unprivileged process:
> >>    https://lore.kernel.org/linux-security-module/20231130185229.268895=
6-1-andrii@kernel.org/
> >>
> >> This patch adds SELinux support for controlling BPF token access. With
> >> this change, SELinux policies can now enforce constraints on BPF token
> >> usage based on both the delegating (privileged) process and the recipi=
ent
> >> (unprivileged) process.
> >>
> >> Supported operations currently include:
> >>    - map_create
> >>    - prog_load
> >>
> >> High-level workflow:
> >>    1. An unprivileged process creates a VFS context via `fsopen()` and
> >>       obtains a file descriptor.
> >>    2. This descriptor is passed to a privileged process, which configu=
res
> >>       BPF token delegation options and mounts a BPF filesystem.
> >>    3. SELinux records the `creator_sid` of the privileged process duri=
ng
> >>       mount setup.
> >>    4. The unprivileged process then uses this BPF fs mount to create a
> >>       token and attach it to subsequent BPF syscalls.
> >>    5. During verification of `map_create` and `prog_load`, SELinux use=
s
> >>       `creator_sid` and the current SID to check policy permissions vi=
a:
> >>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >>                      BPF__MAP_CREATE, NULL);
> >>
> >> To verify the logic introduced by this patch, my fork of the SELinux
> >> testsuite with relevant test cases is available here:
> >>    https://github.com/havefuncoding1/selinux-testsuite
> >>

> >> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *p=
rog)
> >>                              BPF__PROG_RUN, NULL);
> >>   }
> >>
> >> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> >> +{
> >> +       struct path path;
> >> +       struct super_block *sb;
> >> +       struct superblock_security_struct *sbsec;
> >> +
> >> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> >> +
> >> +       if (!fd_file(f))
> >> +               return SECSID_NULL;
> > Is it possible for this value to be null assuming there is not a bug
> > in the kernel? You would not want to do a runtime check for something
> > that would indicate a kernel bug lest you accidentally hide the bug.
> I always think being defensive is a good thing in kernel development.
> But you have a valid point, and I will review and update in next
> iteration if appropriate. Same applies to all similar comments below.
> Thank you.

The Linux kernel way is to NOT check conditions that can only occur if
there is a kernel bug (or use BUG_ON/BUG/etc macros for such checks so
they can be compiled away for production, but adding new instances of
those is generally frowned upon). So unless you can identify a case
where these are userspace-triggerable, you shouldn't be checking them.

> >> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_ma=
p *map, union bpf_attr *attr,
> >>          bpfsec->sid =3D current_sid();
> >>          map->security =3D bpfsec;
> >>
> >> -       return 0;
> >> +       if (!token)
> >> +               ssid =3D bpfsec->sid;
> >> +       else {
> >> +               ssid =3D selinux_bpffs_creator_sid(attr);
> >> +               if (ssid =3D=3D SECSID_NULL)
> >> +                       return -EPERM;
> > Should this ever be null? See above (for this and all repeated
> > occurrences of this check).

If this check remains in your final patch, then returning -EPERM from
SELinux is uncommon - we usually return -EACCES on permission denials,
only using -EPERM for superuser/capability checks. Also silently
returning -EPERM or -EACCES is not ideal for SELinux since it provides
no insight to the user as to the cause and no way to override (ala
permissive mode) if needed. It might actually be better to just fall
through and let it pass SECSID_NULL to avc_has_perm(), which will
produce an SELinux avc audit message (with the unlabeled context,
since any unknown SID is mapped to that automatically) to the user and
the option for overriding via permissive mode.
