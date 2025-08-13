Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978632F0674
	for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097391; cv=none; b=iW1dPBFm1csERscmTojcISSqKiuR/i1/WuB+7uYz2sIanXdOxsZL57YUZA9I+6mQv95FzzcU5VFso1FWFQkHDK3iJ3XgmlUXOBRUslyq5ynhL8OH08Fkl4bydKO1pO/ymzw3HDrWci/PMImcHnhcV20gSw7Tq1mY5pWoSfkU7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097391; c=relaxed/simple;
	bh=fmPrTQ4YKs1jMVcAb/eNaksQ7CJXnVGxPqNLizxlWOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/zC39Oe73et3+AesjfxNGFsbqzW72BqSM64Inx7I5pBGDQncwmKeKzCJghEih2l99mDdm6VIU1npgzWSDxLExlvW+1+RS7gkKycofYJvBuACsW9E9ORsnXHgkPZLajbEAb9J7Jg8WAvcBmibiJo04/ztqPJtzRnnLQ0S/alNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAK+ESYL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAK+ESYL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266cb393so19289a91.0
        for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755097389; x=1755702189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xpMqyCb64zX4SvyvBBBejlVrwHkQI2KpM6zwWrJyXw=;
        b=bAK+ESYL/8rkrdDsbnToT6p0WFfoS9gqxeKPk4Z6fxkONUZgVtSH6MNLTzLVoqW5Mz
         oZuIY4yLmAbPwbP3HNfdmBEIJ6bnz3gyl9rmArIdHdW7AstY0jDn+RtHVDleUH6p+J4H
         bXS9qfNT/+JChmZPSlYtXpkIhoDGTzVkagX41AVwr+R1pzwpwzPLSzenmGgfgGNdcJJM
         0u9j46PtQAiwFkLZX/NyZyEqNgz9B1668rk+FbvPzTXvl7Rl3k/3tVpDy2RzoKMuHlen
         qD4tnXd5UnihetB7ekaZGRjFwF4EvepBudRiGH16G5EDG5UvcASmPVBUHTKfGwSR2z1Z
         rrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097389; x=1755702189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xpMqyCb64zX4SvyvBBBejlVrwHkQI2KpM6zwWrJyXw=;
        b=hoejYxZzQVBl4KAkVGNOJUlYl/sIgZAQyAmt84PLTgd2z0jkf1sRLSQU7llKD6WyAD
         DqqS7PnbDGaLxvXdM+0aALerObSPcsgkyioypDdpOM8aeSPBOAue4rYNh92nfXZZhzOX
         REPlwUlTCpGYEERrPMKzYra38MEYmPkinCejGIaPKBeRPi+g/OWlNUTlGIRm1Rpyj5FT
         S3OhkQR4XbHOJAJR2piehz81UiCce0MSj9nHBRnBoh1Fu7t4DZJ8BLT/bfHgNgK/qYTt
         XQvJ5oy9XUhx1JecNWyjxlGek4ZVeQsa/Zf8nFWslhL4gdTLe4SWAcGzof1hgg/F/kok
         T18g==
X-Forwarded-Encrypted: i=1; AJvYcCW9n4HbLoERgYfArTrpGmRCkM7f+y2wzcrOZK8CwOKh2FNPnwG9s/o1EfUe0jYDMwrFw26IZT9D@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9di5zFpw8O3YeI/fDQdy9hMRshcUoRVsTVzafFNT8KzITb+6
	RDCS9A7ZWqDuaSL9IqG6faT8TqlOW+0ActZsXilr2x6XkjVE4UIroRbqfQNavUE2/qMxobAFLhj
	bFPADXwh2f2snhkFvYJPYGs7u+9Mx/Lo=
X-Gm-Gg: ASbGnct1tgLpOTiSbcp76wTztjqRUUWlhbDSDSF6FVcpN8XUG86pceh9eWD28UPQ9TQ
	5ujDDU8cmMdrBkOabIDokjyAF/oBBRI6Fny2U5Q9CJYGTwAFdlhMlbMI9BMEnW5y+3kPD7uwV3V
	XQf18D5qKqDEC/Lvh+ErV33PuuKcS1rPl5u59nBGnmgccWIMV9g8vVGM4QNxvvMVcvsv6G7Js9B
	Ha9mAk=
X-Google-Smtp-Source: AGHT+IEfcllvjdhC3qaN/P3q6z9IajwgYQzMlAifBxzPcyhzErsqY0WMspCR1ec9BPbQ5mD1h0rsNjFS9KhpR01Sxn8=
X-Received: by 2002:a17:90b:39c7:b0:312:e279:9ccf with SMTP id
 98e67ed59e1d1-321d0d69316mr4400091a91.5.1755097388561; Wed, 13 Aug 2025
 08:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAKrb_fGECzqWO+Kq7n+5Q=J404npPyttrkLcXwLkdM-UZcZmLA@mail.gmail.com>
 <e5278ea4-33b5-48b5-a59e-bef7c4cfe866@linux.microsoft.com> <CAEjxPJ6OgHn6VoXNhcUOxKd5e2AVzKZQajfVaqt40VENor=weQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6OgHn6VoXNhcUOxKd5e2AVzKZQajfVaqt40VENor=weQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 13 Aug 2025 11:02:56 -0400
X-Gm-Features: Ac12FXwYUSOhpG1cgzjeJChmtSSss2FM7DjqsLzHlZ5Km5dizGS_uPuop24pRdE
Message-ID: <CAEjxPJ5H6gWin-fnBMogZJtzZRmxz=q6XeMeP1mR5ju0ENj3xQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 3:30=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > On 8/7/2025 11:00 AM, Daniel Durning wrote:
> > > On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM<ericsu@linux.microsoft.com> wr=
ote:
> > >> From: Eric Suen<ericsu@linux.microsoft.com>
> > >>
> > >> BPF token support was introduced to allow a privileged process to de=
legate
> > >> limited BPF functionality=E2=80=94such as map creation and program l=
oading=E2=80=94to an
> > >> unprivileged process:
> > >>    https://lore.kernel.org/linux-security-module/20231130185229.2688=
956-1-andrii@kernel.org/
> > >>
> > >> This patch adds SELinux support for controlling BPF token access. Wi=
th
> > >> this change, SELinux policies can now enforce constraints on BPF tok=
en
> > >> usage based on both the delegating (privileged) process and the reci=
pient
> > >> (unprivileged) process.
> > >>
> > >> Supported operations currently include:
> > >>    - map_create
> > >>    - prog_load
> > >>
> > >> High-level workflow:
> > >>    1. An unprivileged process creates a VFS context via `fsopen()` a=
nd
> > >>       obtains a file descriptor.
> > >>    2. This descriptor is passed to a privileged process, which confi=
gures
> > >>       BPF token delegation options and mounts a BPF filesystem.
> > >>    3. SELinux records the `creator_sid` of the privileged process du=
ring
> > >>       mount setup.
> > >>    4. The unprivileged process then uses this BPF fs mount to create=
 a
> > >>       token and attach it to subsequent BPF syscalls.
> > >>    5. During verification of `map_create` and `prog_load`, SELinux u=
ses
> > >>       `creator_sid` and the current SID to check policy permissions =
via:
> > >>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> > >>                      BPF__MAP_CREATE, NULL);
> > >>
> > >> To verify the logic introduced by this patch, my fork of the SELinux
> > >> testsuite with relevant test cases is available here:
> > >>    https://github.com/havefuncoding1/selinux-testsuite
> > >>
>
> > >> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog =
*prog)
> > >>                              BPF__PROG_RUN, NULL);
> > >>   }
> > >>
> > >> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> > >> +{
> > >> +       struct path path;
> > >> +       struct super_block *sb;
> > >> +       struct superblock_security_struct *sbsec;
> > >> +
> > >> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> > >> +
> > >> +       if (!fd_file(f))
> > >> +               return SECSID_NULL;
> > > Is it possible for this value to be null assuming there is not a bug
> > > in the kernel? You would not want to do a runtime check for something
> > > that would indicate a kernel bug lest you accidentally hide the bug.
> > I always think being defensive is a good thing in kernel development.
> > But you have a valid point, and I will review and update in next
> > iteration if appropriate. Same applies to all similar comments below.
> > Thank you.
>
> The Linux kernel way is to NOT check conditions that can only occur if
> there is a kernel bug (or use BUG_ON/BUG/etc macros for such checks so
> they can be compiled away for production, but adding new instances of
> those is generally frowned upon). So unless you can identify a case
> where these are userspace-triggerable, you shouldn't be checking them.

On a quick look, the only other use of "CLASS(fd,
f)(attr->token_create.bpffs_fd);" that I saw was in
kernel/bpf/token.c:bpf_token_create(), and it checks for fd_empty(f)
rather than fd_file(f). The other question I have though is are we
guaranteed that attr->token_create.bpffs_fd is always set on all
callers of this selinux_bpffs_creator_sid() function outside the
context of bpf_token_create()?

>
> > >> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_=
map *map, union bpf_attr *attr,
> > >>          bpfsec->sid =3D current_sid();
> > >>          map->security =3D bpfsec;
> > >>
> > >> -       return 0;
> > >> +       if (!token)
> > >> +               ssid =3D bpfsec->sid;
> > >> +       else {
> > >> +               ssid =3D selinux_bpffs_creator_sid(attr);
> > >> +               if (ssid =3D=3D SECSID_NULL)
> > >> +                       return -EPERM;
> > > Should this ever be null? See above (for this and all repeated
> > > occurrences of this check).
>
> If this check remains in your final patch, then returning -EPERM from
> SELinux is uncommon - we usually return -EACCES on permission denials,
> only using -EPERM for superuser/capability checks. Also silently
> returning -EPERM or -EACCES is not ideal for SELinux since it provides
> no insight to the user as to the cause and no way to override (ala
> permissive mode) if needed. It might actually be better to just fall
> through and let it pass SECSID_NULL to avc_has_perm(), which will
> produce an SELinux avc audit message (with the unlabeled context,
> since any unknown SID is mapped to that automatically) to the user and
> the option for overriding via permissive mode.
