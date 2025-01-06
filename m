Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C81D63F6
	for <selinux@vger.kernel.org>; Mon,  6 Jan 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157862; cv=none; b=WkQkMx4FnFdL4lyBpxtNfhn+kkWomiemovwehy7s18i3urp8hg0SOeVNeFzhRPm5Kq/96rAXkmXsXiIk/dypJ4aOmgsPViJXhKN+WsLog68Q2BBX7pCZbVoqftZSHDpOiONBbqDHYUoDkJ9iIMsiNAvlT1xssnJxwEW3aOcGhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157862; c=relaxed/simple;
	bh=E+Y7cvfNY8J/elEoeFPuR+/mWUhg7uBuiS1sR3wZM3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFF46cvaGCnA5dzRyw8jDlTE1PubOos2cfFUGa15g9BOA3+WFGIJg/t+qY1L7lP7DYyKoAtv0UrqLc+BIMlS9F3pNvUwju43Fk2abrX09NC+3pzIaMfEGM8PRADXbmeHcG/xuqUPMPEOyMRJjaiazQBp5iJT1ROs2AULiCr4q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQPauJdw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQPauJdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736157859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbbyrMYgNNbZ/gLaHN9/RnHWnd/H5wjsoud/wLUKl7Y=;
	b=BQPauJdwZnH/9kqWUPOC25Y76T+4Kqo0C76WeP/cLebeZH1TI0KAYxtxsoTx4Mm0iU2B+4
	xKwTCzwm/uW+Sx9M8CbqTZqxPzigM7ezQW2KfpMlsgpzoOVhut26dQRJJMMDgkT4do2EHh
	wUYIv790Nfgvm6utXNGdZhLCBDRz5hk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-wRDUhCRXN-upbcRZCg4-jw-1; Mon, 06 Jan 2025 05:04:17 -0500
X-MC-Unique: wRDUhCRXN-upbcRZCg4-jw-1
X-Mimecast-MFC-AGG-ID: wRDUhCRXN-upbcRZCg4-jw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so20841450a91.2
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2025 02:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157856; x=1736762656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbbyrMYgNNbZ/gLaHN9/RnHWnd/H5wjsoud/wLUKl7Y=;
        b=kyG7n0/HqoNizqw45NQMl2hOSfw2hCOylHlCR3UFFfr41m8rvPEqavuUMGxd7Mc8GE
         XMOERzYW9rz3jAgmWc2iaAq95RxhmBc5tH0sEpn6sR80kcO5SoqgaRKYZ+heilry4wxR
         JGuwWaDg1KLy5IxhShA8l/SdhkmH9KdmrQJ6AlkZwPgDOflGi7SwA5hYUTg32RhGbYSZ
         pPRr1MXfAL6mDXG3t8tT6J4JGkukxoaEabmOIR2Sh8b7HiW5HJI/+k9gW3IR/rizbzYS
         P6pVqNct/bfo1LxgaWR3y7+kZC7f5S5dgrH9gV2AfK2QM7PsWSOAx0EuEbTlaSEh2jqe
         qT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDHgzlKZVb9X9m8PRCbAZyBKbXVQvHD2LM+6U/+TPzS9Mh4vcp/QbI3FQAlzmh3kYnA5aHh7qy@vger.kernel.org
X-Gm-Message-State: AOJu0YxHl9Ol5VtcV5MnqwV40lCjqX0aOSQgSL+jouqpqeo7s8c7LNnt
	0k9hocaGkY8eg5ZOCu7me+93o6FKDesmPaJBqL88UpIlIuVNFNgJ4XfFHWbSE8c2CDCauunRFhn
	x5AVEOYD8V1RYf4bCVsTm2X+BPSVBDjtd4lBfcI91BdP1Ny+DPav2T2O2l4WomaGalr9wQWERur
	ggJYwRMgm6ygaSAHMq3nDzhzc3sMiVSA==
X-Gm-Gg: ASbGnctfkWinj/XVh9k2v8CXYLogNHMv4AYcZdnsqWbEA5wXqy8mpL691ExNOTUs0rq
	1GcXFnVp3atDi9tl/QQgynx6Q01FTC9K4BoU0qdBpCZrWR+9B7D0n0zHDrLhVdU+VVlWtaas=
X-Received: by 2002:a17:90a:da88:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2f452e214cemr88413839a91.9.1736157856372;
        Mon, 06 Jan 2025 02:04:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHld9PlMUnGQjjZZoQAP0kbnUMTlqB+Psy0lUPR/S+C72QqJ4t1BwdSety4Mdb+kQtehrmp3xsFvMJ4Kl6jHD4=
X-Received: by 2002:a17:90a:da88:b0:2f4:49d8:e718 with SMTP id
 98e67ed59e1d1-2f452e214cemr88413808a91.9.1736157856044; Mon, 06 Jan 2025
 02:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
 <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
 <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
 <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com>
 <CAHC9VhRFOm9DBXMF2SbwBxZqtPrr5ghbDRqcwjX6TP_79xDT_g@mail.gmail.com>
 <CAFqZXNt0KozfAybTnoL39DtOx+kx4QLgGVrA7z4c0aOqj4v2BQ@mail.gmail.com> <CAHC9VhQwfWz9HPyeJOCVvn3Pb3mG6pR_pUiWHzyRNcj1v8o6BQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQwfWz9HPyeJOCVvn3Pb3mG6pR_pUiWHzyRNcj1v8o6BQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 6 Jan 2025 11:04:05 +0100
Message-ID: <CAFqZXNvhaZe8+TiWJ6kfGZPc0_60hvmRWfTWgua-42uwTN8dPA@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Paul Moore <paul@paul-moore.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 5:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jan 3, 2025 at 8:48=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > There seems to be another issue with the aarch64 builds now: the
> > latest -rc3 RPMs are not present in the repo, even though they are
> > referenced in the repo metadata ...
>
> Please let me know if you see this happen again, but I think this was
> just an usual combination of things coming together, including some
> rather spectacular timing to catch the repo at just the right point in
> time to see this.  I'll explain a bit more below if you're curious,
> but everything appears to be working correctly with the 6.13-rc5
> builds, at least on my test systems:
>
> * https://groups.google.com/g/kernel-secnext/c/i4UAqrY5E8o
>
> As far as to why this happened with the -rc3 build, let me first
> provide some background:
>
> - In an effort to limit the amount of disk space needed for
> repo.paul-moore.com I only keep the last 14 days of builds on that
> system.
>
> - The job which uploads the builds to repo.paul-moore.com first
> removes all packages built more than 14 days ago, then uploads the new
> builds, and finally regenerates the repo metadata using createrepo.
> While there is a window where the packages have been removed and the
> metadata has not yet been updated, this generally isn't a problem
> because 1) the time window is relatively short and 2) there generally
> isn't much interest in "old" secnext kernel builds (it is somewhat
> counter to the whole bleeding edge testing idea).
>
> - When there is a significant backlog of packages to build, as was the
> case when I restored the aarch64 builder, the package build job starts
> with the newest src.rpm first and works backwards, because once again,
> people generally only care about the most recent secnext builds so
> this approach gets that build out quicker.  In this particular case
> that was likely 6.13-rc3.
>
> So, despite 6.13-rc3 being the "latest" kernel build in terms of
> version, it was one of the older packages in terms of build date and
> thus when the repo.paul-moore.com was updated with fresh builds, the
> "old" 6.13-rc3 packages were removed.  If the testing farm tests
> happened to start during that window where the packages had been
> removed, but the metadata not yet updated, I suspect you would have
> run into the problem you describe.

Yes, when I re-ran the jobs later, the installation succeeded (and it
installed an -rc5 kernel). Thanks for the explanation!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

