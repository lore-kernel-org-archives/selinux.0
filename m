Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AC3203A4
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592807; cv=none; b=o+fMhFK4rOiVF5ykW7hhdR3dXqaFjDRJxfRjsORPimOtiUZIWtUJVCac6vu3vx51bMLXudYS2ylnQlhslud0/1B9+o6STaesawIOZghnamPs9Ig99IF9/aeXuNmpPx46CkgRSWb+oh197s0vx1sfOWJrHADeqkb4ayviu9n0j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592807; c=relaxed/simple;
	bh=BeApMY9U8UzxJeowbSn2d6nLioG3PcswdOQv9/qwDBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Uk3MdvkptoaFJZfyLknE5VtLR4xvEhqsFaip/AfrbJz2qL5Kz8PlYqDUJa6BB+2qfG2Ar1lXBPCIHUE/YN1kNMWva/ZQz3SUVLo2pCerSuBdFRSGn43JEf7acs/EIdrXTslzHUqvyCUfJydW8TSRu69LbDBkV2FZBkOJLtjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0129ici; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0129ici"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b959b4895so414048a91.1
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757592800; x=1758197600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPDNEfrJHVBGfydaQcq1kn8RomVUdYk2g3YveS8t81M=;
        b=Q0129iciYARx5g/ChpB3ifPrmTKxCgjtZFcsB24rjaTTXoOikjQw4TLbZlSnB1YmvS
         qmx8OYwFYw3761mWMYXB/Fod4r0X0SmstGT3ud5LIEogFbdppB9uF/+61v9c9oMGcyie
         HfIo6WG37Y02jjTQ5Y1At6FE3sCCxd3CnfFk9b/43TrEHKF9PiT16YDfzLqI3KkbrcLq
         9pDgjgwYlwS+Rxm/oLCEtjapeaw4Nq0vwv2Io92ZmAisa3TSkKh3sxjjeLz1PFcm07B0
         5T6ML0dy1COFBFQKmsqkBEyYp8udjBWRX5CA3WSMB9yFM7rpwHmdOBSX8N9aErL+B+Cc
         VzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592800; x=1758197600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPDNEfrJHVBGfydaQcq1kn8RomVUdYk2g3YveS8t81M=;
        b=Am8UwCPf0hECbuE2tcJTeloW6q+Y2xM312dAt6qkqXicMv8oAXIeq3TCS80opGpXhi
         7DtUkDIgSD90A9YE9UK1ima5PN7RZcVX+7Qtz1R783Y+E1IQaKDPcN/ZSKw1Wgf7sXBT
         rZ+n5lAcKtmZirQLG4CpojVCMZGXsA8SjSNV3ZZolGi4CbVzJ/gwzdGiPgZsqDh0+gGo
         ZivyqTQpyX5tIbMkDlxB/VzlXA+AQeoa++JYsSE08EMpl0VLwIRvYUSrvU7PcQCu1kpG
         pM4ntZY1rL/pFs7sreU9wiQPlrPMAaP+wh5T7SohI3JCtVLpRKBAiso80QFCa2FKSOoB
         bGfA==
X-Forwarded-Encrypted: i=1; AJvYcCUpk6HtoeiWV8mmyG4AZ6VJN0+AFJRBzH+6aR3cFjMX9UBocRJ26VTIyMvdlLvU5Ciw5deqC4+G@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLoIMv+2d607xs4XEYd2aJ7QnIN5H+PttanmMhqfndRd/r+vC
	hgBeQHP6xGyhRLxndYe+p8nGLImKosQeu5CNPYm8dgshYjx+Nbsr7IvWLFnO6qx9JcK0FDP1YTS
	wiruo5UcfI64C+wq99LpAM6tMLeRtNT/sEft0
X-Gm-Gg: ASbGncv17nhkfrvHvg9b55OSL+njD1yICDFD0fZBy15KetbgawXywN+JkPf2bOc80iL
	zNNRvpjCCvb93hRFr9S7Z3uGV99XRBoYOCofKCODNMEKzz0v29Z4so0iBROl9VPd8IGBHKr7wpV
	iY5zC8qOhH4krTad5YNnQpQCZBEUfI6tO5+aoYUs1uWD/xu7E0L4ECUfJLEgP+a+GhT0wWY47Zq
	M3dnRnuAzp6DL1XJA==
X-Google-Smtp-Source: AGHT+IETXwpc3IGJwX4BAF0mKvaScmPHbNDYlOMNjglSo8rIUIsCSNNRpM/mJXWzmd3ppYALgML8WQwlq81flVUKcug=
X-Received: by 2002:a17:90b:3c08:b0:32b:7067:c8f1 with SMTP id
 98e67ed59e1d1-32d43f65352mr23024676a91.18.1757592800225; Thu, 11 Sep 2025
 05:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
 <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
 <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
 <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
 <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com> <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com>
In-Reply-To: <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 08:13:08 -0400
X-Gm-Features: Ac12FXycAkHo_1oxd6oV_jgfzNC2O9pbgpLm1sdW6awo4Q-r7MbGbcRbsGTbFQQ
Message-ID: <CAEjxPJ7SDeMCq=0XFERiFozQmzRiJN9X2NB8v=_X8KOKYCrBLA@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:58=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> On Thu, Sep 11, 2025 at 9:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Sep 10, 2025 at 12:29=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Sep 10, 2025 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Wed, Sep 10, 2025 at 12:06=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@pau=
l-moore.com> wrote:
> > > > > > > > >
> > > > > > > > > A prior commit, see the 'Fixes:' tag below, added support=
 for a new
> > > > > > > > > object class, memfd_file.  As part of that change, suppor=
t for the
> > > > > > > > > new object class was added to selinux_bprm_creds_for_exec=
() to
> > > > > > > > > facilitate execution of memfd_file objects using fexecvc(=
2), or
> > > > > > > > > similar.  This patch adjusts some of the sanity checking =
added in that
> > > > > > > > > commit to avoid a "silent denial" in the case of a kernel=
 bug as well
> > > > > > > > > as return -EACCES instead of -EPERM so that we can more e=
asily
> > > > > > > > > distinguish between a permission denial and a fault in th=
e code.
> > > > > > > >
> > > > > > > > Technically, this doesn't make it easier to distinguish bec=
ause we
> > > > > > > > usually return -EACCES from avc_has_perm() and friends, but=
 return
> > > > > > > > -EPERM for capability denials and in certain other cases (n=
ot always
> > > > > > > > clear why, arguably a bug unless we were just replicating t=
he error
> > > > > > > > number for some existing check that also returned -EPERM).
> > > > > > >
> > > > > > > It's awfully fuzzy from my perspective.
>
> Stephen, from re-reading your messages, I am not sure which option you
> prefer at this stage. Are you leaning back towards -EPERM?
>
> An alternative here would be -EOPNOTSUPP, this would be more explicit
> for userland on the root cause. There are similar usages in hooks.c
> (see selinux_lsm_getattr for instance).

At the end of the day, I don't strongly care and only Paul's opinion
matters for final merge. Some arguments for each of the different
options:
1. -EACCES: Consistent with the majority of the SELinux code,
particularly all avc_has_perm() calls. WRT POSIX.1, it seems to be
primarily for file access checks but broadly can be viewed as "access
denied to an object", which is the majority of the SELinux checks. In
the case of this particular LSM hook and system call, we are dealing
with a file object, and hence -EACCES could be viewed as appropriate
to this check.
2. -EPERM: Used for several cases within this hook function already,
most likely due to checks that mirrored corresponding Linux checks in
the core kernel that were also returning -EPERM. WRT POSIX.1, it seems
to be for any permission check other than file access checks but
broadly can be viewed as "operation not permitted for this process"
with no object in view. In the case of this particular LSM hook and
system call, we are already returning -EPERM for several other cases,
and hence -EPERM could be viewed as appropriate to this check.
3. -EOPNOTSUPP: Used by other SELinux hooks already. WRT POSIX.1, it
seems to be only used for sockets, but on Linux, it has the same value
as ENOTSUP and can broadly be viewed as "operation not supported". In
the case of this particular LSM hook and system call, I don't see any
existing uses of this error value, which could be good or bad
depending on one's perspective (good: easily distinguished from any
other cause; bad: not expected by userspace on execve, not documented
in the execve man page).

As far as I am concerned, feel free to pick any of the above and post
a patch with it along with the corresponding rationale, and Paul can
tell you if he wants something else.
