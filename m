Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40843596B
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390733; cv=none; b=FNpmiPA0HI5SNtFc3AXNIxaSSCzzsMDYqBoOE+xHrdRV/WwWGZAn1Y7j+n3f9HfCSPXdobHLpxtjymEdGaygwYCx9SR1ODHUFHvEMRPFpHyeCj+1mX4fkw3l9B7+dHGxlyQSLzfgxQfIJ/2uOGDquW+2njADNLGlLtDZQxJ2T6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390733; c=relaxed/simple;
	bh=6Y+jDEnR/C4ve9UIJoG4xWv65dQMzYVu0zgFm/doa2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7GYfQI6XU6oShL1kTD1MUsrCh/mn9Kxz3fORXz0BShM/LYBZoMMHKuqYOeWSQkQvDh4JLDRkZIqYmv4jT8CFMvLkM2aSNdmDLej8X9VqNDhRaCtQq1VMU/mOEflZ3IpDFH0vMRTHzwZD5iViLvzS6BGyEpxAMTbS4xOfUJLYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lws4Yk+/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lws4Yk+/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30185d00446so970603a91.0
        for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390731; x=1742995531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y+jDEnR/C4ve9UIJoG4xWv65dQMzYVu0zgFm/doa2k=;
        b=lws4Yk+/o+/JNCvR8nxYtJZxRb0Op4jTepMKxFGTgj+UH7Nj+6YScMgJU/XsFFSGS3
         mzKg/VBk2DPXsotuBR0LbEnM1wgRlLxqno9AB4xHuJnMK2o8SwXopWo1qHUj2dIqhLni
         PEqLqVHVlbwhH+cCndY8rxbfWnzFZxE1hr4h6i+yiJSVmwnE0FRMlpNAHaGMrJwILThx
         mHkK0u1v2/xscP6hjMWSEvutZCLYCqGrPfQM7vPdLHSWP68VG1W2EmNkZ+Y0H8Q6i4IC
         HUC8BgAK1/kAJbf5M2o6dkrorBvt2MvvvDuQIPnVLm5WTOOEbOEjc/IT3ymdJLwmrdot
         W9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390731; x=1742995531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y+jDEnR/C4ve9UIJoG4xWv65dQMzYVu0zgFm/doa2k=;
        b=q5RtqTYcjr7eQpHZ9G4Hg43Cr5CeE1BwmuV8nF5uMHC9pfAg3NtNwtwOi5rVnLDkp9
         andGqWit4sxja/W8hp7l1Wh1baCsTWFmhq/rd5udZJ6lnriXJ2Pykt5aY7MpJBJbwb5I
         ecCC369wHKxGu6aVdN9wH74rJri1ojZvwRQF6Wxq/UqblA7wvgXRnawrLoylMH+/8WaW
         0S7gQ5xcp5n9VHP2wZDdD3uW5Yq2h5zph9OQ0uSBxkG6OUGcLhfW8LguOtOKI52Vm/Cl
         QtToyc7O+77mJj3d83q0FCOmsLMCmiW0XXWyTnGQnlM/fdy8N1QR9QcR9PLQMcxxZ61j
         YOZQ==
X-Gm-Message-State: AOJu0YxoasKz0AxERlbolJ4P91JAw7rmHbWNfdzLPKK8lP/wfNgSqwfD
	JmdnlIwIHWEY1Z16qc3P4hSC5u2CfVNc8lmCqRApmkWMGm07OATx8KnAV2i9FOXqEcE1qbajkN6
	g+FB77dRkLik+cHzSDu++mFg9Y24=
X-Gm-Gg: ASbGnctEBwHaqaaQwZ3l1zya4/NNet9KSeJrcZLd0fATkBdxaCF0fsNHdSd9Zflno11
	tKWuhuGLnWzTnUvxDAU2qEFA6OFO0Ms2ThLU+oCT/Y9jvB4+3VeTy30H3GjOzR8quIJkz9drFRr
	1fYUWATFsxLzNWuv4tn33RPu//xA==
X-Google-Smtp-Source: AGHT+IHZ39LCY4TmML2vh5thiTduua7dMllyx74FDDJZ5KSrY1+j/yNEutvY5JJFH4Y8l4r7jwJ/GqONson0f408Oj8=
X-Received: by 2002:a17:90b:1b47:b0:2ff:5267:e7da with SMTP id
 98e67ed59e1d1-301bda17dabmr4512510a91.3.1742390730971; Wed, 19 Mar 2025
 06:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de> <87senb7mt4.fsf@redhat.com>
 <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de> <87plif7egm.fsf@redhat.com>
 <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com>
 <87msdi7acy.fsf@redhat.com> <CAEjxPJ7Q8y+3S-kR6bKmRc8HW+ArDJb1z9D-=sRnWe+zYEW1eg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Q8y+3S-kR6bKmRc8HW+ArDJb1z9D-=sRnWe+zYEW1eg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Mar 2025 09:25:18 -0400
X-Gm-Features: AQ5f1JpPmTUp1akHZJJKC1NfOiZ8Ctf6PsaK9hUctf_LFN1l002tefVviT_DHsI
Message-ID: <CAEjxPJ5rG5yfwB=8aH8iDFTXgo8W8JBmjLMA7A5q_eMbEJmgaw@mail.gmail.com>
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Cathy Hu <cahu@suse.de>, fvogt@suse.com, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 9:16=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 18, 2025 at 9:11=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach@red=
hat.com> wrote:
> > >>
> > >> Cathy Hu <cahu@suse.de> writes:
> > >>
> > >> > On 17.03.25 15:29, Petr Lautrbach wrote:
> > >> >>
> > >> >> You could use `-e <directory>` to exclude read only subdirectorie=
s.
> > >> >>
> > >> >
> > >> > Yes that is possible, but also requires a manual change by the use=
r to set
> > >> > this up together with the snapshot (same as telling them to add <<=
none>>),
> > >> > which we would like to avoid.
> > >>
> > >> Your -relabel.service's are generated and so can be restorecon optio=
ns
> > >> there.
> > >>
> > >> Fedora uses fixfiles -
> > >> https://github.com/SELinuxProject/selinux/blob/main/policycoreutils/=
scripts/fixfiles
> > >> - which detects ro filesystems and skip them.
> > >
> > > We already have logic in libselinux/src/selinux_restorecon.c to
> > > exclude filesystems that lack seclabel support; should we augment thi=
s
> > > to also exclude read-only filesystems to avoid the need to work aroun=
d
> > > this in all callers?
> > >
> >
> > https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/seli=
nux_restorecon.c#L238
> >
> > You're right, I didn't know about that.
> >
> > I think it would make sense to exclude also `ro` mount points.
>
> I think the tricky part is the case where the caller deliberately
> passed those mount points to restorecon/setfiles. The current
> exclusion logic IIRC won't exclude any explicitly passed directories
> to avoid silently failing. But skipping read-only mounts on a
> traversal of a subdirectory would make sense IMHO.

Actually, maybe not. Scenario: Read-only mount on a higher level
directory with read-write mount of a lower level directory (e.g.
read-only / with a writable /var), and restorecon or setfiles invoked
on /.
Maybe it is best to just defer this to the callers.

>
> >
> > >>
> > >>
> > >>
> > >> > Is there a reason why these r-o subvolumes are not skipped by defa=
ult?
> > >> > Could they be skipped without a problem and it is just missing the=
 implementation?
> > >> >
> > >> > Thanks :)
> > >> >
> > >> > Kind regards,
> > >> > Cathy
> > >> >
> >
