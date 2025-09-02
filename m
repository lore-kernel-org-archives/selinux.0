Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF82765E3
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830634; cv=none; b=gCae8VDlY0uKana5GR4i0WBP8n9wY79COrGlIc8+AB3N+EkISr5rSYTEUE2Ag5i5Uz+M6RIx++3CnVtholrHVRkQF8G9m3M9DVccRE0ArTp/flE6bx5E42cmz8OD2Dcme0yDfzoNxrZ/pBCOTp699yT1AAUTSm2unB/ED/vP74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830634; c=relaxed/simple;
	bh=M56tKrsVKfFswchTPIU4R0Df0h7cYm5qwl0t8I8lriY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr4HfgjR06ezVi/aphZEr4c9fH66EBRSnJ+jsRpvSXVruJQJ6iC2VFu9eSNKnuefAbbCS3GCw89Eavl3fj8s9nE9StzaECUaWvSZwYETPwoeiyRkZBV7UfsHajNDQ4sGS78POCs7x/LFEY/o5JDaV/mDKcAu7WECpyRSb650C+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlZ9upI3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlZ9upI3"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4717543ed9so3555942a12.3
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756830631; x=1757435431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6yq902p5IbsjXwwha9EJtS7u9gSx4+nYshY99QqUIg=;
        b=RlZ9upI3Dedin3ejv2tpUYUtw6Zvz2RO3nDjdGr+cC1rDR0lqMt3RbNyBYwhFIRuKL
         XGbBDngI2y/eWbD2r9DEFbGTtcKJAsCARmFwkKGnLpUfMMCqzVrF3xTnJRmn55I0EFhe
         f2ur6bk7aGoRKGpWw3sNSkFSkLQgheYd7Aw0TVZJ1xjRfz3VLUH/SMQGCfC7OHi42njZ
         LYyiAM7FfUF6w/kWSRmVQg8PAGiAcYrTPYZpoik4D/nnQ+FwifM1IRbXRRSdVvkpMRz3
         USp+NdaRvTCmUKv2SoB8TcI8WlwkENkNz0dhzC1iaFmxapppza/2VQYzUoXRlFVXPH2K
         5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830631; x=1757435431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6yq902p5IbsjXwwha9EJtS7u9gSx4+nYshY99QqUIg=;
        b=YWK45tIK4cBKbjRGf+bUR76RcoHUjOPK3/4FFhobDUdVlSTz8eSmAvnbr3G8yzEEbG
         RbK1tDQetl5zh9S+3H8XQ/ni+s6EwvhaFn2YBDO43dapQYts0SC2H5laioaq+3TNDYZM
         9sPQCTqyYw4EsHOYRKyYmSwW4PjaNZGHRB4QGUmJAz/UbBdC20KYI24ay+RCE/42Dezw
         duP7X4ZR9xaNFWujfgP6deqlie1x4vpfSpaD28/AqpqJOso3ukTr6D8af9W0sg0Lgakg
         YyEs+oe+nRz1sCFALn0vfxKQXbviaRJzI0bAVP8igqV2R7ZQCZWxWl3rwC+e+zwQvPk0
         m3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV/IBvDoaXnUb8j7GIO0S3ysBWgafE/pp6s9axR5ZCFoTEcWTDUD7jnkqEYKNlutT3ycmbauv3f@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+vVjjD3MDnBGJuAGr8xNFZ0g3yrFQmPAJqS7kfShTmB/D0qt
	dlsLcZP3iJIrMCdZSDsqSVtuUkYTj1+aOOZhm51XQXJTWf5YuTinITOKsr/WyooxYzd0aBH+bjl
	SNKFuBpHrSCkxY+8JB3hOPRgCWjJ/nXs=
X-Gm-Gg: ASbGncubIS3JXx4TbCPhPfwNBSVJlTiIavpbc5LSOLuVqd2EA4UNWTVBZdQNXCd/ny8
	pfVb934wYGjXdjDw/BrOcRsoh5A7XOlhCuQLwaLQYuKfHNbRtIOhZ+Ez736fiMd6QCoIBHunwPY
	dZsyGQq3V/iOW06W7eIhB10J7HuCz+JwrGT7MfQbjj7g61/ldoGM6etTI1LoYvHR1uKw6UO5knY
	axhEmM=
X-Google-Smtp-Source: AGHT+IFjv3XMjyQqYsWNX0oAcYDv6Xb0l7PC6s0BU3Y/Lay/kDgTWx9yxNI8QhG4n6crKP0dEkHDNbdGzJbablUS2YQ=
X-Received: by 2002:a17:90b:3a87:b0:327:7334:d857 with SMTP id
 98e67ed59e1d1-328156cd296mr13538981a91.28.1756830631209; Tue, 02 Sep 2025
 09:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901143412.2904562-1-rjones@redhat.com> <20250901143412.2904562-2-rjones@redhat.com>
 <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com> <871poo96ld.fsf@redhat.com>
In-Reply-To: <871poo96ld.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 12:30:19 -0400
X-Gm-Features: Ac12FXzD9eOKhQCIIVa8LjTWR_XwJJ_DcBR57SvAoeVbWXluSl9R-qHlF88Ico8
Message-ID: <CAEjxPJ7qMBpEHxgFQJKo0_q2P+ObeQQ4xtLWEONg9=A8Kvvx7g@mail.gmail.com>
Subject: Re: [PATCH] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:12=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Sep 1, 2025 at 10:34=E2=80=AFAM Richard W.M. Jones <rjones@redh=
at.com> wrote:
> >>
> >> SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have
> >> differing contexts.  However doing this involves building a large
> >> internal hashtable that stores the full path of every file examined by
> >> setfiles.  For filesystems that have very large numbers of files or
> >> long pathnames, this uses a lot of memory, which makes SELinux
> >> relabelling in constrained memory environments infeasible.
> >>
> >> This adds a new setfiles -A option that disables this tracking.
> >>
> >> For example, using setfiles to relabel a filesystem with 15 million
> >> files took 3.7GB of RAM.  Using this option, the same filesystem can
> >> be relabelled in 121MB (albeit with no warnings or errors possible for
> >> conflicting labels, but for our use case we don't care about that.)
> >>
> >> Fixes: https://issues.redhat.com/browse/RHEL-111505
> >> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> >
> > I don't think we usually include downstream issue tracker links in our
> > upstream commit messages, but no need to re-submit just for that.
>
> FTR in git log there are already about 60 references to bugzilla.redhat.c=
om and
> issues.redhat.com is replacement of bugzilla.redhat.com for issues
> reported on RHEL or CentOS. There are also bugs.debian.org,
> bugs.gentoo.org, bugs.chromium.org references.
>
>
> Until these issue trackers disappear, it could be a good source for anoth=
er
> context or related discussions.

Ok, thanks for clarifying. I know that tends to be frowned upon in the
kernel but wasn't sure what current userspace practice is.
My only request then is that such issues be publicly accessible if
they are going to be referenced upstream.
But I won't die on that hill if others disagree.

>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> >> ---
> >>  policycoreutils/setfiles/setfiles.8 | 4 ++++
> >>  policycoreutils/setfiles/setfiles.c | 5 ++++-
> >>  2 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/set=
files/setfiles.8
> >> index eabf0a1c..7c9c5d39 100644
> >> --- a/policycoreutils/setfiles/setfiles.8
> >> +++ b/policycoreutils/setfiles/setfiles.8
> >> @@ -23,6 +23,7 @@ setfiles \- set SELinux file security contexts.
> >>  .RB [ \-I | \-D ]
> >>  .RB [ \-T
> >>  .IR nthreads ]
> >> +.RB [ \-A ]
> >>  .I spec_file
> >>  .IR pathname \ ...
> >>
> >> @@ -187,6 +188,9 @@ use up to
> >>  threads.  Specify 0 to create as many threads as there are available
> >>  CPU cores; 1 to use only a single thread (default); or any positive
> >>  number to use the given number of threads (if possible).
> >> +.TP
> >> +.B \-A
> >> +do not track conflicting inodes (saves memory)
> >>
> >>  .SH "ARGUMENTS"
> >>  .TP
> >> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/set=
files/setfiles.c
> >> index ad09f840..40f2e7fe 100644
> >> --- a/policycoreutils/setfiles/setfiles.c
> >> +++ b/policycoreutils/setfiles/setfiles.c
> >> @@ -147,7 +147,7 @@ int main(int argc, char **argv)
> >>         const char *base;
> >>         int errors =3D 0;
> >>         const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> >> -       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
> >> +       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:A";
> >>         const char *opts;
> >>         union selinux_callback cb;
> >>         long unsigned skipped_errors;
> >> @@ -375,6 +375,9 @@ int main(int argc, char **argv)
> >>                         if (*optarg =3D=3D '\0' || *endptr !=3D '\0')
> >>                                 usage(argv[0]);
> >>                         break;
> >> +               case 'A':
> >> +                       r_opts.add_assoc =3D 0;
> >> +                       break;
> >>                 case 'h':
> >>                 case '?':
> >>                         usage(argv[0]);
> >> --
> >> 2.50.1
> >>
> >>
>
