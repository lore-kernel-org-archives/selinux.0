Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3D149E0E
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149803; cv=none; b=Vd/rDg1xfct2nKj63ZfqyPbJ6wxKJztJUVEV5pgpxiinB+IPAFY5yiXTGqBbpJ0Qjc2cfXMuCp5Cd38Mw2tZUWVEDTVSdoPFNFpngoQ3MXXF9fr9sRJ1AZZaaYQoaMkalGfarUnyIfg2Um4TqWlv9l4IZmsXB5iSxOThBSm+8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149803; c=relaxed/simple;
	bh=7yMoumJPJH+ykwIfuej/8sN2n4f+qphSf6s51bi6PPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYkWkg4mCvxnXu5TlNQPqGMwMVu78QV5OFDq20zMrPX1BnLQOFt+VCflh6g4VyMmw8bIs4uUhFi+Qo82X1N5xu+Uf1jlctlMu4L8tk/BYOqvggf0e7w1rjTvCP3uzSQLZHvPFYP8Bt9vG54YwjbqjERPqes819aMMXQM/sJX60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WG5vh/Wd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WG5vh/Wd"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0e7b421c88so1335351276.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723149801; x=1723754601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O/x8B7y2mxuE7n+m8qQYp3H5sJi/9SEnvOkvV6m0ko=;
        b=WG5vh/WdHQUeimfvOfuL/YP5Kh4MRzTtXZvhlRjiNbSDzc7kj40f+vF5CrF7Et7fIf
         RyZQcH4UESEJwBTWqn/W++N+SMCfAaX4aa+s4dQ9gxCE5dWHCbm14AgQlCGu6914tf+0
         EWbtpn+mkhml9cWx+OCqK47yy3NQ1WCPdbDUWwBZBiPh0PuFOY2hsE3OZv5un9Z/rR+x
         uLNHT8BQbfdfemeBWsmbhd9nGcOx8QITfKiKoyHpRf78lqwdWk2VymsotoevT5wvDCSX
         NYD+ZAicSRLr2aTUnrTpYnmttS2wBJUj83OQGiNHM1XUb5w8yxhA9PcEjbJzrfIH3gLg
         UeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149801; x=1723754601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O/x8B7y2mxuE7n+m8qQYp3H5sJi/9SEnvOkvV6m0ko=;
        b=FQeeWwYkHP1ikf2gNbY2f7nz8qwD7UHqnCFx/B96aAdoPQGqpuBpDV46emS/a4FXYF
         +OfMs5Rp4BruoG8dG5VR8/CgJwko71hlDQmPxrNpuBK1Bvto+DzMqoJ/l6RTS47fUqT+
         6zEsS5ZqL66+mFAh3S/SbqCzcH06VuKJtG4xdxkGg1Iv64bM5UC8ugXfJHZyhG2UEepz
         OMdw704SFe3fQRs8phdztvU9poTv7RK/VVfYeiF2ogHrPSS4tEOsa/HbXifBDYQ4geGF
         0ivEY/o4LDSqyQFmxF3vFWPasmV/hRXYhmIYqG3gWrFI/D+MVe9wb6i5Xg2VMO7gJxmo
         i+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx6nOrAjw2QMTpE7yWm01YR0egnIGxg0Np3PtcEUndwKxNBM3f5evAk4XFkbm7heZtjb/1xGiF0kA6pl2o80ZS4NNKv5+9yA==
X-Gm-Message-State: AOJu0YxEgP2RaJ840k+opG3yflz/ya4CZcYGrkSKFsLTwSxLDrJaZv9p
	ee1lOFhNz5qzXpOTLKaMdrAgx/AKp0FqxcvtbnBEqvLUx+RK3s1PGDR22jco5rUCxZbI0LcYr5b
	QaMn5adz56pHIVE5Rz2jx8n/f0nrSamIPKVUs
X-Google-Smtp-Source: AGHT+IFC1OE8KRHMmKr7rH6deuBf4mReLOmlhhp4bt2rRsDL0UNunfMv48tgujt16YhA6szzxv4EBxiOmRjYSPwsTEs=
X-Received: by 2002:a05:6902:1b09:b0:e03:5fee:66a with SMTP id
 3f1490d57ef6-e0e9dbbe0e0mr3791769276.42.1723149800910; Thu, 08 Aug 2024
 13:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808130909.1027860-1-wangkefeng.wang@huawei.com>
 <CAEjxPJ4b2Xcptmi2cJNyh=N=1ky=yfg_wVB1yDLwr8uuhujxew@mail.gmail.com>
 <CAHC9VhRz=drY-=W64VezugemWsBgaQZS_NQ2TZzrS0-fhZgg6A@mail.gmail.com> <CAEjxPJ5JsNF=ypOFJxLGB3aBOAXLC7av+_HWS_FObfdGz+d0AQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5JsNF=ypOFJxLGB3aBOAXLC7av+_HWS_FObfdGz+d0AQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 16:43:10 -0400
Message-ID: <CAHC9VhQyX_pnJm=_Fyv=E6n013=ku54xs5=uAHo76oTAvnMJ6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "selinux: use vma_is_initial_stack() and vma_is_initial_heap()"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Marc Reisner <reisner.marc@gmail.com>, david@redhat.com, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 8, 2024 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Aug 8, 2024 at 9:40=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 8, 2024 at 9:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@h=
uawei.com> wrote:
> > > >
> > > > This reverts commit 68df1baf158fddc07b6f0333e4c81fe1ccecd6ff.
> > > >
> > > > The selinux only want to check whether the VMA range is within the =
heap
> > > > range or not, but vma_is_initial_heap() helper will check the inter=
section
> > > > between the two ranges, which leads to some issue, let's turn back =
to the
> > > > original validation.
> > > >
> > > > Reported-by: Marc Reisner <reisner.marc@gmail.com>
> > > > Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.co=
m/
> > > > Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_i=
s_initial_heap()")
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >
> > > I was only going to recommend reverting the change to the heap check
> > > but in case Paul is fine with a straight revert,
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > I was hoping that the mm folks would put together a quick patch to fix
> > what looks like a problem with the helper, but I'm not sure when that
> > is going to happen and with other callers I don't want to change the
> > helper and break a different part of the kernel.  Unfortunately that
> > leaves us with needing a revert, but like Stephen said, I think
> > reverting just the heap helper is the right thing to do right now; I
> > also want to put a comment in there for the next time someone tries to
> > re-add the vma_is_initial_heap().  Give me some time, I'll have a
> > patch out for this later today.
>
> FWIW, I tossed the reproducer code from Marc Reisner into a branch of
> the SELinux testsuite and wrapped it up with an added test to the mmap
> tests here:
> https://github.com/stephensmalley/selinux-testsuite/tree/execheapregressi=
on
>
> Passes with the revert, fails without.
> Would need to be modified to be portable to actually be suitable for
> inclusion though.

Thanks Stephen.

FWIW, I think improving this test such that it could be included in
the test suite would be a very good thing to do.

--=20
paul-moore.com
