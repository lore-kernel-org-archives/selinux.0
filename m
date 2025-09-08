Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB71F0E2E
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371894; cv=none; b=dqgKlZSk5S25hCCs71Asw4CtJFPEvNNbHkoG1Z62agrWRPBJamYofDY6Baj0tPAekKm9CZuRxsK4vPayb09tu5W7BSfJp188VUXPxMxkV4ccCQohXfZTycacwErnJG3NcByT6npMImz5nSNk+xnySQ0u1HyrS2lODkGnmQxRzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371894; c=relaxed/simple;
	bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a25isx+oE8ZjPFfeaJx6tZVjeSnMaweJzuG24Y3ruT5YUQJkvV+HhyQmAkjhz66r40lxvxl+o1u0Cr5Y7ASt2q1svdUtR1TuFI4PX3Dl6txtyMxfB909nPAc4djp/NSD4+0gAxqx1U0rnZzWIn4wo/ZoUVgjhCFHC4mqmklxCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYGjV2L7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYGjV2L7"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5607a16639aso15896e87.1
        for <selinux@vger.kernel.org>; Mon, 08 Sep 2025 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371889; x=1757976689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=gYGjV2L7/MkOedYGu9TUdyLQ5CgBHp9YrCv6Gh70xrEJOxOFNVH+Bj5+9jKHlejWKy
         0WpnYL4CDkSwBujtEtqgMFTSFtKHwGjTr1fGr+ob53RrOWGxU3C72+fhMrZF7fwiroT0
         vlLlRZrum2/s6aoQpS1JbHClXZoEfwQiNMU+fKMfi+LA6BCkSSj59nGwpeNIRhbPwXXe
         OcYArqmiQcwJ/tS52EqDJE9BiTWORo880ovUGWtZX73pHMvAt6AFQAQ7Ry4N6yjRAOxt
         LxvQIMut1t9+ee9Zup03rNnL9zitqZgtu7EkNLatFTZj9brrh+ycHsurzJ4QGy1Y3mp1
         KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371889; x=1757976689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=ApfYTZud0+ow3SR2jWOFNDlyWlL+gYlg/VICD8tePVsy0WvZPQ/P5q/GsltFry6M7A
         6hIpTTu6uT8w4/KJ3H9FhclTj21gC4m263vBTTqaS5dzG3C59gZLmBJuzB6o8MLJrNlc
         /AlSqQQnnhAqNLhTe3dvScW7Fs3UQCdepquFw4p0M3mQotFRyQxEEQrhElFSanXP6F0w
         vEvhZmCyi1MbScyBxVIkrg2EK3cw6hFNRwzGnOmDhWKmuU05rcpYbkVNf5bzW0Ozvi1N
         rs83/NrOkfVF91E9fGtqFKxlNQfQC/bx8sFjs87/NUYHty1p1scWk4sQLN/bj4PPw8om
         TetA==
X-Forwarded-Encrypted: i=1; AJvYcCUQlDp2LRTCCzk2X++u0Ljrhdk4WQhVwSqCx51JEBj/aPomqvm3xW8b7wiyZmJUs1wUDqz31A8f@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbha5Z+gBdafi+uOXKwRWBWtI+TrO6Q8zf9IgO2cXW8+b4IWJu
	NtdVG6Od8a85z+tZML29aKUphmVza/596FV7KueA3UH22/0aiL2mHbkzDS6k+kK2wd5fme2Nw0k
	qJvHBgfmKBn0cVMS9Ev5LV6ox889yYqnUhacyRsWW
X-Gm-Gg: ASbGncuvPG/tJLePqImJoS989sSKGHW1sfz2E6lcW6C90ovSk64cER0tuTlDsOgAm82
	QbWVhiKiJFQAUc68166Nn+O3js0S0eS3qq6O9uO+G2gk8rgrfs9MJj8gdCAtDzJvdRUBfCYdHZW
	ooXS1DFFT96AU85qC8Q/Mwpr2oHGjOqzdFkqiC1lHjN4Sv4Wa5niFqN+3O4xpFenuhn7rXwhYSg
	Q3PRBrPa51Fyhww3NE/iGnvFY0ToXLGF864eSh/FBYe4g==
X-Google-Smtp-Source: AGHT+IHGlPCHT+44DAvJB9zRm+3LM/HXySp5XwuN4EFQvOUkmZCnoZLTNZDiAYuGffXb4da9PPxUbTsQPmLHNTo18Sg=
X-Received: by 2002:ac2:5b92:0:b0:55f:6c68:400c with SMTP id
 2adb3069b0e04-56272295585mr463209e87.7.1757371889119; Mon, 08 Sep 2025
 15:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 9 Sep 2025 08:51:12 +1000
X-Gm-Features: Ac12FXzaXfPJRpw8SIYa0ofw9A3koHJPN82BozBv8c8kOd4rvQR4t_4Herx7EQg
Message-ID: <CA+zpnLdbLjuGrk-178coxAH1pzpEA1jRzGn8zU9DHZ1rQspP4A@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> When you revise a patch, you aren't supposed to retain other's tags
> since they haven't technically reviewed, agreed to, or tested the
> revised change.
> That said, I have now done so and thus these tags can remain!
>

I'm sorry for that. Thanks for the clarification, I wasn't sure what
the process was. And thanks for the review!
