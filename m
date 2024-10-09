Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517B178CC5
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462343; cv=none; b=m8mrfp4VL5bafIcnZ9YU5cCcX3P1QH3LDI5e/y6+c6wR+KrqvtXBJyyo6wNrDmPRdTUg8vRoQ+RueHpb7t3Pq1/czz86siH4uzilztlMVORbV9Ju2bSTJKeJ7MbrrEnObxm6hvll1GpQEzE/Q2Cq1VbF4/FRX3EbHyvBAxU7z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462343; c=relaxed/simple;
	bh=jFAgE3qFuULuiM/EVaEKhJ/qLPcodqcJ690KcvvbWnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRraA7s5lDk/8LWHMaT5MsGNtd3EdZ55KFAbASXW0udRDPppGV6UnwHZDOw0Dj4Ac1sPC3L7+xNlOHzxGvyE6q9V1/vpa4wOgZXs2p7bmVckWjCTXJKmlha5Rptxn0VZ+k+YajNudNB5ojoyWQW7Fr+7QvktFzinZd6jqMJjkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOptJWVg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOptJWVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYjRvTGvKpXcM8QeH+7E/BU7m+Zk5pTEJ3LhtyGvK6Q=;
	b=HOptJWVgGxg6928uaHGbMCtLOK2FTx+SY6qM+YU/kUESJNsaWmo5oRl+iuvyXysuphTnsh
	kIcmDwtO4KSnZRX0SHfwmBVKlmx6qlbhIPXOXkx35O184GeihgN6lBpMtqGPzSwmG+SKNK
	3CIV8Nrg3CgGxG1eQGVt1lRC94DmHZM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Rm9Vg0bdOeyft6qX-7l0mg-1; Wed, 09 Oct 2024 04:25:39 -0400
X-MC-Unique: Rm9Vg0bdOeyft6qX-7l0mg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e18d5b9a25so8453778a91.2
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2024 01:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462338; x=1729067138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYjRvTGvKpXcM8QeH+7E/BU7m+Zk5pTEJ3LhtyGvK6Q=;
        b=b5LN9HQTNS9w8dHweXXOdRrgNjQMyFKRSVx6q4nR8K8b+dq0pJXdlyr7nUu1Qzo+jo
         FPq9YhCeIWW8xKGr/D5hCpEJXSymmS49Ed87Ml71v9yWxLD5K2NLpkU0uSxEP5VwHP//
         R5KQrl16JLiaQ1zxX2otp78RXYy9ngLTVmYafhN7K4dBI+eiwU05fBPrJ8+Vcy3RUZSu
         0vEnHlcquHFGDiizv8wXAn2xNqXNoKKJ7aAQTRir7XUACbM7gajPG21KRpwY6MRlFNqN
         9q3z+ifxcYIPFbfYblIjoVQuIH5OGXONeYZ6Z6i+pSqn4oxsLXgVQIkynvEQv7z+HKuU
         4HoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjnWzqw3CknKo5TI6seFSRTMVH6Y0jYnp1DuH3DnzuDZ+BLu0KXY9T+Qu7YCubcHEPk8T3kzMY@vger.kernel.org
X-Gm-Message-State: AOJu0YydpTU0axd2BGvkcQ+9irM2XZNRQQD8k6wgd7neDmRuBlv5jLXT
	MwyIflMC/gn0gQROlGxF9wBs8tDL5wZRwLgeQoB9GIsHaTJgt3HV/cxnlRxqSt+G2HIOggcap07
	YIC6jJzclS4z66EOXAt46iiSlAtlCxowBcfSsLsohRn36KnC+jEPjXRwQGa50vr+4rBCnNEmir9
	MOf4IA3XwYQ5he5oFuB4W9zTzdIEkXnw==
X-Received: by 2002:a17:90b:198e:b0:2e2:af57:37eb with SMTP id 98e67ed59e1d1-2e2af5748ffmr916153a91.41.1728462338591;
        Wed, 09 Oct 2024 01:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGT5t9+eUy9vBNNoQdNRiEc1iBho1fKsKK3VENcMPa8Pzdeb+2ucs7S0yFdCXRKdCVPdNpJvQCbwfYptto31Q=
X-Received: by 2002:a17:90b:198e:b0:2e2:af57:37eb with SMTP id
 98e67ed59e1d1-2e2af5748ffmr916140a91.41.1728462338205; Wed, 09 Oct 2024
 01:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ4MH_r36Oy4K1Mcg4isGRQ+TC3Yr86DJV9fFOe3oddmLw@mail.gmail.com>
 <CAEjxPJ40boVZji2DZVzHn63KmNOf0MkjkS5h9eBU4CSptfSuNQ@mail.gmail.com> <CAHC9VhQ5bEPw8Kmy7Q4XJpWN1q9z5HpKVnkU2RN6TBrYvEecWA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5bEPw8Kmy7Q4XJpWN1q9z5HpKVnkU2RN6TBrYvEecWA@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 9 Oct 2024 10:25:27 +0200
Message-ID: <CAFqZXNvc9Ux60qad0EWTDkzcz30ZwUS-y43XG=L2N=4gYB0yQQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for netlink xperms
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	tweek@google.com, brambonne@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 8, 2024 at 9:02=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Sep 16, 2024 at 9:04=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 4:00=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Add tests for netlink xperms. Test program is based on an earlier t=
est
> > > > program for netlink_send checking by Paul Moore. Exercising these
> > > > tests depends on the corresponding kernel patch, userspace patches,
> > > > and updating the base policy to define the new nlmsg permissions
> > > > and to enable the new netlink_xperm policy capability.
> > > >
> > > > For testing purposes, you can update the base policy by manually
> > > > modifying your base module and tweaking /usr/share/selinux/devel
> > > > (latter only required due to writing the test policy as a .te file
> > > > rather than as .cil in order to use the test macros) as follows:
> > > >     sudo semodule -c -E base
> > > >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
> > > >     sudo semodule -i base.cil
> > > >     echo "(policycap netlink_xperm)" > netlink_xperm.cil
> > > >     sudo semodule -i netlink_xperm.cil
> > > >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
> > > >         /usr/share/selinux/devel/include/support/all_perms.spt
> > > >
> > > > When finished testing, you can semodule -r base netlink_xperm to
> > > > undo the two module changes and restore your all_perms.spt file
> > > > from the saved .orig file.
> > > >
> > > > NB The above may lead to unexpected denials of the new nlmsg permis=
sion
> > > > for existing domains on your system and prevent new ssh sessions fr=
om
> > > > being created. Recommend only inserting the netlink_xperm.cil modul=
e
> > > > just prior to running the testsuite and removing immediately therea=
fter.
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Now that the kernel and userspace patches have been accepted, can we
> > > get this testsuite patch merged please? The test will only be enabled
> > > when the underlying policy defines the new nlmsg permission and
> > > enables the new netlink_xperm policy capability, so it won't break
> > > anything in the interim. We will need to separately submit a patch fo=
r
> > > refpolicy and/or Fedora policy to add these.
> >
> > Any objections to merging these tests now that the corresponding
> > kernel support is merged?
>
> Not from me, although since the kernel support was merged less than 24
> hours ago I might give Ondrej another day or two just in case he was
> waiting on that.  If we still haven't heard from Ondrej towards the
> end of the week I think it's fair game to merge, I would have thought
> if he had any concerns he would have voiced them by now.

It is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e5fe2=
22fb5af892c579593e1cbc50

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

