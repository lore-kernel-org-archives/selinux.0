Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476163B2FC7
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726247; cv=pass; b=FuvHBsRW0PWDMcqv0PPRT4Z2LfJbVLi6vtkBJcM6TGi78UEyNdc0uORn+rlWYGDIMYB/Vyv36jmyntsmT3aLzZdVk1D0iMRE6JIQN/kWvqkmhKx0t+BJHTZNdUspMLqtLeVE4zNiMK6WufpK64kvxJbRD6zF1sfI7dOLRwWaPSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726247; c=relaxed/simple;
	bh=nI3PY2U+NLmKCLed6WuZA5K6L7ksvUfb+p4DaYOUmTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiPe4Z0/8WB5PigEBErMnodfx1OC14pBUmncCw6fbfbcpUK4w0P0DTPCrJKF4ZUW/3eKK36I5/uYGqnWbWL4vKs6sbVb+D1RxAEBM4kOsUFWNnPWqhW70ma5TEVXrnkscrvsyU0OFUwOq3ss62trpU8MtaC00kIrG3sJ0ql29Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fb8RXS/y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZphQNOd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fb8RXS/y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZphQNOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775726228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	b=Fb8RXS/y4aSReffzZL3nvEE5PLpG41gJMEtWGsYTO4CmgYNhtmjknWsQ5y2BBtjON5k4pq
	+b3cE5WrC+Dyd/i6RmQahh5u0Qb6+gc0RTYDk1qZhRQMzMkzZenSdXUw//DM8wF9japCMs
	iUkM9TBKNEudyQCtzWprl6YRbd8d2HA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-sL8U96IiMLOXK-oIoi01AQ-1; Thu, 09 Apr 2026 05:17:07 -0400
X-MC-Unique: sL8U96IiMLOXK-oIoi01AQ-1
X-Mimecast-MFC-AGG-ID: sL8U96IiMLOXK-oIoi01AQ_1775726226
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adef9d486bso7130805ad.2
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 02:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775726226; cv=none;
        d=google.com; s=arc-20240605;
        b=IF5oEvF+l8w/LgLaQFwbyDRD7pXUJQPVRf8a4ZUW1UVTASC2dD8aLwj5JuEupUx7XU
         zEV/XWN/JPJOBohyb5fNBcAzQofqqynMPee/7Boyahr+93RkpuBhHFCBSK0er4pcK04Z
         lloW11u7vxTSHmUs9EpSMFsrhfSnMMdc4r9aDRnbUhCiVgjA0hbKyTw/IV8zvaludhH/
         sJRmcjDPvxJn1F3ML8aSPlMiRTs00PL46MYMgyS12UHpHc17Y+8Egog9lFGCmFiQy3Vx
         wwrRT33k7FQ0Hs0VNNC6CxzRpsYtmrpy3HHx6oTw7NRjYdHyPuBzmCXlDJXPOEjC3tSM
         uNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        fh=SS7Qs1wXDsz+L8JqROtm8z/EB9DxtUMZBOV4pH9Zczc=;
        b=XXwmFjq5ptJlIhzFi9zYFOSRdodW3JSEuzu9sOuZiJnIS+a94zNtj/ZjtS8vd0VZcm
         fD8QSkb5W2LtRI7AsM6PqytfwdW9s+aP2lrFlOdQq0WOQfK5j+EjhIv0R8sJg0n05gH4
         iZx6Hb4fym7tht2fmjeDGzEcYIza2cvmqNcYQV18dQd7bEtrkf94WqXl24Cebiuro83+
         CQHChEQ+QlEZB1oeadn0WOgbX3BbNEKSQCrOLqELbVXKQqWm4XO4nJsSxZK4WpyBjRQv
         wm55QGrMS+ZLHACUVCp4gC8HR0zutzKhEKJSJCW/S1jV+tBchOP6akcezl+p4y0ofPz/
         S10A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775726226; x=1776331026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=KZphQNOd2MZ2lzUFAkV2aEzOyKmZrZUJd68VC1wdhAFgUIDQbHkPSCXjY0fRd6X6Ei
         WjUAyZLtWj0AasPiCdZbyzFk9X2fECwPbzO/SA3mHboti9snTCbPJUVvTOZ2f5SKnTvn
         s6fSidnBE3jhtiiNAC/07ROdlDJUAumsqQIP3lkGvh9SmcRI92hj1o8YDvfNLYF25Gh1
         QqA325yotQTgHqjwDaGJ6C7w4wQPIRc0P5W3ujA63Y76rwPrIpjwaAOcv9xzbXKKh+kQ
         1gAvmm51GiIJjzAF2SLHXbNahx15+yuWDArMlsdej64SkMtWG8rHJznIY6K5ClkSwqR7
         mZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726226; x=1776331026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=p3g0dbZShMuFToTzJor/3iT1c+ey8ftQXVdGtninFawS+quVo+SBj0Nfa/BxzAmoAz
         1WZvm2v/tyyRCWDKD1+EkrIaHifsfEXp3MY6DDlycQBq6NYfmLe/SakMoXlrO/BB2TAD
         PWzeIZB47/POCnIc2uLZOWweBkxrHHKiCmLh2Q4q77khq+VOE7eczQcZ9SkenvuQpYg6
         TaifFfX6AtBd/atIe8bxcwNkRUvP7REIiyJPp3MDykbO/gxLxdLIWNH/N9JqQWM1UtMe
         qKX8JAgkfk23xP/h9wzYLWNB7WnUuzDG83uy69TlEoh0hw/Ms4YYl1pBtCjCT18IikFk
         1NiA==
X-Forwarded-Encrypted: i=1; AJvYcCXEYYMfsha999PrmWoNw0hyc7tsjEe4owoZH/CHmzeXqzR0pLxAoO4MlwI8CbjhgzecEKnMeGbd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj5HWnItWa0FDr5Yq9I1W85sZD+Zck746gIazmiYZsIqCQiQF
	GBiOvr7Mm1YoOhSmO9K+iY9qXr8UFYIbWpEnaQEBZb/ub+PTiSRVw2UvZwY6qCtg8Lcyiuk1y7x
	KwCPk3IKTgREOfz0yNjTyV2ZIamSBYzk9U16Cg5zYIZFG//ni9USVCC7lO6Y/fgmQ91pm38tkzM
	P9b/1T3fVrZJHs/S7J+i6v9fTpDtp6NNCs8Ka+su0indJLWa0=
X-Gm-Gg: AeBDietB1Jph8g8N6SjmsOHw75xZSx5vGkS3ktYlgehktzUf2dFqjzP1TaXsPq3eqJS
	JaWCG+DYRuKccSE3Yg+GBMhBp93fPe7dx9NUgiML2Ib0iszyi80urYWCtOYPNPdDeOZGfWbM+YY
	nnhmmZXV4PIC7r9oGmSTQvLbDRQJHfRLAOm/PYL75dYl+qzk6kcDd1I+26ums6STucn3om/wc1G
	NaMmQ==
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b2c72d51famr29334095ad.5.1775726225903;
        Thu, 09 Apr 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id
 d9443c01a7336-2b2c72d51famr29333645ad.5.1775726225399; Thu, 09 Apr 2026
 02:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
 <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com> <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Apr 2026 11:16:53 +0200
X-Gm-Features: AQROBzC2DVx5qKVA4ihG0eixfkIbnn_9pZw2Pb18PXvqySFVij5lkBTtbkuLvjk
Message-ID: <CAFqZXNu3t2G6rUDToAH5CCRkHj-n_RVF4L51cmg0J+4W6T4D6Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > The existing SELinux security model for overlayfs is to allow acc=
ess if
> > > > > the current task is able to access the top level file (the "user"=
 file)
> > > > > and the mounter's credentials are sufficient to access the lower
> > > > > level file (the "backing" file).  Unfortunately, the current code=
 does
> > > > > not properly enforce these access controls for both mmap() and mp=
rotect()
> > > > > operations on overlayfs filesystems.
> > > > >
> > > > > This patch makes use of the newly created security_mmap_backing_f=
ile()
> > > > > LSM hook to provide the missing backing file enforcement for mmap=
()
> > > > > operations, and leverages the backing file API and new LSM blob t=
o
> > > > > provide the necessary information to properly enforce the mprotec=
t()
> > > > > access controls.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Do you have tests for these changes showing the before and after (i=
.e.
> > > > failing without your patches, passing with them)? I tried running a=
n
> > > > earlier set from Ondrej but they failed.
> > >
> > > A few months ago I sent you and Ondrej some feedback on those early
> > > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > > I've been using a hacked up combination of the existing tests, some o=
f
> > > Ondrej's additions, and an additional debug/test patch to ensure the
> > > labeling is correct.  It's far from ideal, but I didn't invest time i=
n
> > > test development as I assumed Ondrej would continue his efforts there
> > > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > > on getting a solution as soon as possible for obvious reasons.
> >
> > Ok, I'm happy to look at even unpolished tests - just want something I
> > can use to exercise the before and after states.
>
> Hopefully Ondrej can provide an updated patch.

Sorry for the radio silence... I just posted the fixed patch to the list.

I also pushed a more targeted standalone TMT/beakerlib test here,
which also tests the dynamic transition situation:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/overlayfs-mmap-b=
ugs/f/kernel/overlayfs-mmap-bugs

To run it on Fedora, it should be enough to `dnf install -y beakerlib
selinux-policy-devel gcc` and run the runtest.sh script directly.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

