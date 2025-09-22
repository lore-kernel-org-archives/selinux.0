Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939A242D90
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546763; cv=none; b=lkxc7vDh7Stm4gWUF+MUnfU9ljz82v8PO29sZ7h62X8ids/cp1VfVxxOa8aD1oShj3wZf+b/HLv2qW+7/siOzAu2mmAVw6XzPHgoDadZiv59FZv5zKg09CspWrD75uggn343fEThamCIzhUs0pcz4w36S19POBkbVx4IaeLaYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546763; c=relaxed/simple;
	bh=uOdISHyO/SByEHogAEAJPMB3jhvhzan36scydbrpki0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kih1z9HeA8VMt6joRFzO2yduqjLQv+rhmlR5die/+0kKBmCOL1t+zqsBBkZHDpKtW5P6htQOqrwaJWyjv0ZjsxITBytE+UnFYIKn6WQZ3ScvfKs07CvvDo1e7aGGpzPrn0VMR/VWzqWbRAQKRnDKwSuEXK/mv9YvbjwySqBuBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmaxiOB2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmaxiOB2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1534053a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546761; x=1759151561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFvHbq8BGAwHmjI5XMDiCg9CB8o/Dt308prrHiAcRyI=;
        b=CmaxiOB2iSDFyh0IxGPe+IAxNL92/zMkqZq1gy3+TIJz8ZjpEEgtx9KAZX0xNVyL17
         N9MKAmJ57KJm7bkjh3TIhMZQ8QJWFpUcjFHytQMWWBdliwpFPrL5766CGLjESc4tC2sz
         Wrlk266ZQ/EwlOJyBl2ES5QBxTzZijierMNbXZO+I95svVAW64DKjHfTN+UatZh3yxEy
         PM3KmsApzoJBVTt1LrCFpLmo1gEHpuowIOod0dHDp0KxxIs3poYRi/Lnch87r5Maleia
         1Y2jMgJVEl7TzRMewZszfgsev9IwGehzkl0w80t28IP0sOH4UxUZ2aw4yR9UVy2j9+DB
         2yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546761; x=1759151561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFvHbq8BGAwHmjI5XMDiCg9CB8o/Dt308prrHiAcRyI=;
        b=M0Tdpp25NdkpA3dpwei+PkYmD6ufP4LQxFmM4xickHGgM5+4aDDeIYz85g/r7FB8ra
         1ACzGDLsgQ9q8d9U2z6dhixSKvUAQi66taZoFKvOQacrJ/60D83iHiEHaiVKnC9f43be
         Rwv9oXpTwAOA0c2IC/OisRSU+YZ2VqQFzewod4oU4pg3k4ZQCj0L+XXqA+H/+FPcei05
         rjNTh81POCvfmQVpsV8VMgTFMNRBmdLHQvWNG/U+IusrczFlaoN2IoyZgVcbWDWTRqZJ
         oUf7Sr1uFnXkXbhmyImPKWVHTh/WA75/OyT/gTqWq9jgR6dOfRmaB3rOF80h8r+U1Pnl
         JW9g==
X-Forwarded-Encrypted: i=1; AJvYcCWGnTA1v9nqG2Ba5IG8BadoDutmY2fzBzEqFMsjp9gnVtSagYft1mGg+TWtICVj89nuz55HX9nv@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBAS5zrPuckQbAu5OFC6eZLPqVGsYC1gcP/Oc3/kaGKTL9Cba
	SpF0O3QZKKjik+sKL8Oao2gO56jry5+n+UU2XCYmZC0Zw74Ec5etQmYJy4O71ryoq/A68rAn1Sa
	4gyFFiZOsES7j6wkT+hCKI40ymH6a/Vc=
X-Gm-Gg: ASbGnct9gPEECqzVIbOU3J3SkiGesvZibGdgpooqZs//TTOhO+AsO2YYC+o3tjtYCmm
	f+3tXwwBCrsxMuhIFSRmGyotw7Oetx5onpVtwZtfscAuIhvR9nee1q6xPLnw2xJ1ByFB7YYenGq
	wzt5Cpc7Bg2PB/uCvooRnTAOcQ0oE72C16/OBcYZsreJBSfUxExiewg9LbB+5ggO9gY2kDeqRC6
	qzUdSQ=
X-Google-Smtp-Source: AGHT+IErOhD8VYTYiXj/emQEmjvSZJYRDnQiUT71TAsYBNpYKZHlMYedIO8UbMKe7SgXnEyy3ylBN2ENEcWlSiRqsO0=
X-Received: by 2002:a17:90b:33c8:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-33097fdd77dmr15212107a91.3.1758546760692; Mon, 22 Sep 2025
 06:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Sep 2025 09:12:29 -0400
X-Gm-Features: AS18NWCCoF-gEznmiapevcW7RPAuF_YwrH7AbkG9x3tb1Dsso_FuxRXtaZlxNKU
Message-ID: <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 2:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Sep 17, 2025 at 10:04=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
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
> > ---
> > Changes since v2:
> > - Add WARN_ON when using unexpected class. Return -EACCES instead
> >   of -EPERM
> > - Remove extra new line
> > - Rebase on selinux/dev
> >
> > Changes since v1:
> > - Move test of class earlier in selinux_bprm_creds_for_exec
> > - Remove duplicate call to security_transition_sid
> >
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 ++++++++++--
> >  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 +++++
> >  7 files changed, 44 insertions(+), 7 deletions(-)
>
> Thanks Thi=C3=A9baud, I'm going to merge this into selinux/dev-staging no=
w
> with the plan to move it over to selinux/dev after the upcoming merge
> window closes.
>
> Hugh, since the changes between this patch and the v2 you ACK'd are
> minimal and limited to the SELinux error handling code (see diff
> below), I'm going to carry over your ACK, but if you have any concerns
> or objections please let us know.
>
> Thanks everyone!

When would you recommend that I re-apply the corresponding userspace
patch to reserve this policy capability number for memfd_class?
After it is moved to selinux/dev? Understand that it isn't truly
reserved until it lands in a kernel.org kernel but would prefer to
reapply it sooner than that since there may be other policy capability
requests queueing up (e.g. bpf token) that should be done relative to
it. Can always revert it again if necessary, at least until another
userspace release is made (not sure on timeline for that).

>
> --
> paul-moore.com
