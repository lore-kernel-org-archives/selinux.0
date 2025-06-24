Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED22BFC70
	for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770264; cv=none; b=HJbL/MdEMVazsIcUEhJIjjLOTHERRdOVndf3FxpZVDKIwKNKiryThUoVi2yugLUVzsEXv7/FiHbnWEUsQ1gtkVdzgjOey1Enr05mgjhSDMO8YlRDu4D1xncyne25Kpu5p8G4YjADJM80jp6abnvxdwxBkjQKc9anpNjeo/P67oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770264; c=relaxed/simple;
	bh=mXruKnHr7lgjoXVfaY7bkNvtq3DDI+BHuMpRk0gSwJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCmXzRX4jWUtHp3xuq9q0plPj+uUqk6RRin3YoEJvDe+sCs5RHhJhEFRaPM3F5xJbx+FHYw+ditGSdTmrSbRUDG1ONcg8FuW0qpFqAEiuzvkhyoxLCIIHdVMeIISQJ/WB+/Sg9loZ/KOkKgcMDkprTcwV72usCzXzWMvVjsT0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm5prYSl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm5prYSl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so359159a91.1
        for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750770262; x=1751375062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9n3Aw4wPFm4oeIftPG6IOT1Em4BTOsD881sEIex7ng=;
        b=Rm5prYSljVe7inerqEH8MEWJHDUQ9Abv25pMA1JZ0b8i1SBvOg0x78rLMVwXmi26y+
         daU9SvpIsO0ahQyh6xqbgy3CmXZkvW0E3Tnmx07QpCGtR/tk24YFOvaxqX//dJBnXkfC
         naAvLjRTcTIiOdvwDPQ8GQwngHUhF4CFPht1PURMhZmbMtVbU31/AYZhYQ/1D029NNI1
         3CxU+iTW62TeLo5xPwGvTa25xHY15eM76/KkBnmme9y1oYYLYsIaAgDcQ/0kFVVDMzGO
         QFXmRDLGn67Ksf6gKmtM3ysXVopXjapLR9fZXhF+XqoB0jQtiT/p4eN/nqUXI2yUd1wU
         m1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770262; x=1751375062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9n3Aw4wPFm4oeIftPG6IOT1Em4BTOsD881sEIex7ng=;
        b=QYkf0B/URqCkclXgHnkb+XP5Xj4G0FZGECwT6++pXjRJFoTWU8limUuJhVSxez8FSM
         t3BYvnBpY66ijtVmFOEh2pKQA7uwYVDWJsimvz6sU4GQybgcicObzuSJftSoH4x2MRNg
         +3FYVXqMUCNh7gULpyIT8PWE2kJqXRmAQzuMbUxFigqJKFi0SeiNHAFXpRjSgGNhUPG8
         ul7Q7U8Sb1Ah43zeRPlkfEJgcPea/2gZXbJIaHMlNJn3jSp/0G1CuvG9ogjvemDU8xLD
         72cGUduEun7C4MmA98dNcSzovLSxoX2zyic87o2LMvUIwoK6Uk+gy4TZ41eCiE1keVqX
         FpGw==
X-Gm-Message-State: AOJu0Yy70YhZ1A0Qf8TEVaLj941oHUNlNkJlpw4vXYSrlOeGRjpkv517
	PcoJ5CJrt4cAKsv0Gb2iN42N9JSsuF4r2Xi4PMOuwwhrzqmoUi+4heraMN/dHGq2zVuSltamrlA
	ywnrq6KTW+1Ug9mh9FOojNV1Bg/OjMh0=
X-Gm-Gg: ASbGnctlybIpvpIR+csn5A1wARcM8QfCEYVElTm5yt/hp40oV7b+kwCQ4tk/f71Cxi1
	uJrw/yPV4cGTlVmdYZaWrZM/ZPQ+U09f/QmvtjbqQHe4teA3pZZF9sXdKx7RQFqxXEdzfUJ46U8
	Em0jTSWI39BBakDNQwwsCDtUXy7vKlMeT2HMoDSWGfBXc=
X-Google-Smtp-Source: AGHT+IHEzYqu2GEBZXYci+o8EGhREMrtP2A8h4yEFsKqX9kH0Nmv+bQnrLZ85wiigjvKkI7jVoQacopYcVW3yJAlnI0=
X-Received: by 2002:a17:90b:2dcd:b0:312:1508:fb4d with SMTP id
 98e67ed59e1d1-3159d8fd1c0mr27469149a91.33.1750770261768; Tue, 24 Jun 2025
 06:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu> <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 24 Jun 2025 09:04:10 -0400
X-Gm-Features: AX0GCFvOZ-MQK5VLrTjCYiSRKb3FPlcI7p3J0PXd7l617qGPU_VbQmuQzj1fFwA
Message-ID: <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 24, 2025 at 1:44=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco=
.com> wrote:
> >
> > On Mon, Jun 23, 2025 at 08:09:34AM -0400, Stephen Smalley wrote:
> > > On Mon, Jun 23, 2025 at 7:37=E2=80=AFAM Martin Erts=C3=A5s <mertsas@c=
isco.com> wrote:
> > > >
> > > > Good day.
> > > >
> > > > I have been looking a bit on your SELinux Namespace work, as we hav=
e a
> > > > usecase for it where it will be necessary. Basically we're running
> > > > Android in a lxc container.
> > > >
> > > > Currently we just have a single label for everything happening insi=
de
> > > > the container, and disabled every SELinux handling from the Android=
 side,
> > > > as that doesn't work.
> > > >
> > > > So we're looking into if your namespace patches will allow us to le=
t
> > > > Android do its own SELinux handling, and it seems very promising, s=
o
> > > > thanks a lot.
> > > >
> > > > My question is about user namespaces and the selinux namespace. I s=
ee
> > > > you very consciously have not linked the two, and I was wondering i=
f
> > > > the problem I'm seeing might be due to that?
> > > >
> > > > What I try to do is, as root in the init usernamespace:
> > > >
> > > > ```
> > > > # unshare -m -n -U --map-root-user
> > > > # mount --make-rprivate /
> > > > # echo 1 > /sys/fs/selinux/unshare
> > > > # umount /sys/fs/selinux
> > > > # mount -t selinuxfs selinux /sys/fs/selinux
> > > > ```
> > > >
> > > > The problem is in the umount step, it returns with:
> > > >
> > > > `umount: /sys/fs/selinux: not mounted.`
> > > >
> > > > Do you know if there's a way I can make this work? Or is this a
> > > > limitation of the current implementation? Seems like the flow today=
 has
> > > > to be to first unshare and remount the selinuxfs, and then enter th=
e
> > > > user namespace.
> > >
> > > So, first, unless your email contains proprietary information, I woul=
d
> > > recommend cc'ing the selinux mailing list.
> > > Then, with regard to your question, the above doesn't appear to be du=
e
> > > to anything in SELinux itself, as the same
> > > behavior occurs even if I don't unshare the SELinux namespace and eve=
n
> > > if SELinux is permissive.
> > > I would have to look further into what unshare -m -n -U
> > > --map-root-user and mount --make-rprivate / does that is causing this
> > > behavior but it doesn't seem like it is something in SELinux itself.
> >
> > Thank you for the reply.
> >
> > You're correct. I was assuming it was due to the SELinux namespace, but
> > testing without the patches at all shows the same behaviour. I'll dig
> > into that and see what I can find then. Thank you.
>
> On further thought, I think that you aren't allowed to unmount or
> otherwise modify a mount for a filesystem that was mounted by a
> different user namespace, so when you unshare the user namespace, you
> can no longer unmount the old selinuxfs mount. Hence, it does appear
> that you would need to unshare the SELinux namespace first, then the
> user namespace.

Looks like you also cannot mount selinuxfs from the child user
namespace; again, this occurs even if SELinux is permissive, so it
appears to be a DAC and/or capabilities restriction imposed on user
namespaces. So the sequence would have to be along the lines of:
# echo 1 > /sys/fs/selinux/unshare # unshare SELinux namespace
# unshare -m # unshare mount namespace so we can unmount old selinuxfs
# umount /sys/fs/selinux # unmount old selinuxfs
# mount -t selinuxfs none /sys/fs/selinux # mount new selinuxfs for
child namespace
#  unshare -m -n -U --map-root-user # unshare user namespace

And then it is possible to load policy into the child namespace (or
you could do it before, either way).

Note that we have a helper on my selinuxns branch of libselinux that
handles the first 3 steps for you, leaving the rest to be done by
systemd or whatever.
