Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128273F4827
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535592; cv=pass; b=DLu7VYfJvfa/pmp2QjhPq+wOuC7beeKbevm0lwfGebK9shSsW1Ha0qCzfA3guxx4SYvqXXli5NzdXgHJqUL2eUs7VUfWGF27MtfwQcKyyE5OXM91h+2gCdzUHAznIfdxIVNrBF5D2cnl8Xmt8NJOkIYOaNYNSIamT367m8zo1kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535592; c=relaxed/simple;
	bh=6G4JBuygg29asOTmihM9IdEL+gseCWPThK62vKiAVwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujU21hbW9Bq+DgVRGhs3TwR8MC0zwis9iMrjhxQb/+1izhX/yOh/YroQLyebNqyZLoXYNtyJTfIqMQFDpUL5Mf2fVSxRr0x0xOetWdRZrKVnT+ezvbYlG1R5IBmFt43/n0gILPbSQApjessFO+/wCyg+uuA5hMtoKK42/Mu1ves=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+oBY76B; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+oBY76B"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a4cb36ae00so1008914b6e.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788535590; cv=none;
        d=google.com; s=arc-20260327;
        b=nePamzWGb92Oist8BrEmUWiFijVODqc3qEzTLmOZylnX6Ti2STJer1MUF2++E8RbnU
         eLHG0mgwuzJiyoJ/3IIomx+tRFFJzHVDAd+wkToRo0OZ8ZUhLnMMp5tkU9EUR9RHK15h
         3u1vcW+OYd7bji/It7X6epDEWlm2Y6/zxqEWzOGFXVA/Za8HqYBzqxQRrOmWqxbonxbZ
         pYKFjM4qTNBGTP46P4L46/X6aFS+Lid048r/sp905peolKjTN3e4/Ebdw+r9den1Dh+V
         2wsg+YGLrI6w1RAR/0WJaHU0P6IX5ed4AFe0VuvIHLIyLpPejXmspSnyNGRtHW7qzVeX
         bRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        fh=QYLv1peSPf4lmf4OZXSRRJXsDfLMVzmoLypETgdMpPU=;
        b=P+VON6wCdzPSW9W6Rl9h6pYplQFaM1VB3ybLM+G5xge0OTuiuu+ahQjBfytgKMkvzh
         kRTwXFSFbIT3Dx3aKZcIS5xkGWjz4t6Jh7EZDlmmIv8dbLALqrd79iI6HUA8K1I8lvXm
         H0ogeCqPVvpAuIaBSjQszxN2RpZcZlns5wo5xhGSopDFhiPZNvkgztZTzdD92jRHUhAy
         d55tNmIUy/1tk2kdvgNsEAtXoeRhMTQ2oqEb/OHW8OJI+e2rlNtn+mnw3EFMfuYhdCuy
         XfHzzj9LousS0uLKv9+IvB2G7zFxpuVZpYqyrxAy4wVpjqbVB6LYLYnED2t/ELnAVg5K
         Vcrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788535590; x=1789140390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        b=N+oBY76BO+SWjNyq+e6ZRNrY67RXdHnOv7I4LYvV17f0ZJKZ+lgqBcrvzMgrWjHwtJ
         AJLirZyITdhdVYBBnrsCUHQHl5NZKGbPVmUI6lC9rRMA+/AKA6PjQeKmfL8IXIIP4UT6
         snllu5jvVxMJhmGihUqWP2Hfo5ttAvr7auxDLPzGsXCI/qgx32QmlzYOBmdLfH7Jf2fy
         UmiW1C8KDAAE7H76oV/dny4o6v7dQ3G5o5KzNrQwR4qr4vPukkIpiquDpZyC0/vSugfE
         DExPg19zv3iEuYo8qUjLlisHBZ9pC76ja+UWhtIEuKORuy+m9BpWd1BIk6zlzL4HDWrT
         1lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535590; x=1789140390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        b=acmKinysKYLI2QafKvdE1g94geIk/qoTgC+Rmo4x+Jmyf9cykEywkR4JlbhpUhgT6n
         sJv9Gejh4+DkGz3SKkn9Z8HAdUMxJcfQtllwFmnpzuT40bj8vrJvUcfzxBsCEB1EQBKD
         /DRIHzJwdkr1vBa7+H3Jfwihb8TpxJVjGzfvOsozRvm8gFdMrvDaMCT6JK+dWuJFp4te
         BURBKSKG3DceHe1XGLvKdZ1J6doiP4sqpMXyxp/hJNRxjPr2uWrWpqZAf0fiQAwYe2LM
         yQYxzEbaw+kXH3tmaXK/CMUt158/gxpVVcNgop89u05EmDqoOdW2dQZtYgbHtAAccL63
         kodw==
X-Forwarded-Encrypted: i=1; AKwUvByBuOuLLdV4tOEv7lrWrJwj7RePiXnlMrgsC5oChyEhZIL7iwGp6j68RoksFFRckFW/FpLfckPn@vger.kernel.org
X-Gm-Message-State: AFuF++mLjErBzM8L/E+BNhwBne2HUnm14XhamM3i9o6/YViBKbCl+xxc
	G7fmKrXrRbZGEHaNAUaqdvo67S2sHqdo8A8tt1A05OX98rcc5S1LO1Aey0e79WA0iojuye53Sc6
	L/8416vtwl/yg28yWT+Y6IfquBpbvm5kfL2CEHGf2GAvAT4z0v9f8Jw==
X-Gm-Gg: AYBFou3X+ODyq1D/FMb91rgEYsnruNEF/YS/iZspq4lQFwtYEzty1q2iZMmnjBvX8cy
	DK2u67H+yA0VMZw/4h+YITrKWkr345uc5TAQ21QuEgbcL2vTlaSh4Ad2cLWqd24e75bILqPO3dZ
	O3C55yT1hfw5Gk02eNFg0V4gwAH4UrpWZfJHGWkV85zcrAegXyyVjJSGItyFfjBXwGgnLeEymjj
	IrzXh3rYehxnThFt4tPXaCj09jHkozHj3k4huURtevrIiokb6lp3P1EQOeRQEqJ7D/4gMvRqn18
	VLVZLMDxGbuSevOWqtbNfX/c3ERdHvOTptE2WZ1GI6tu
X-Received: by 2002:a05:6808:448c:b0:4b9:a829:f011 with SMTP id
 5614622812f47-4b9a829f9d4mr3198458b6e.29.1788535589785; Fri, 04 Sep 2026
 08:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
 <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com> <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Sep 2026 11:26:16 -0400
X-Gm-Features: AcwNN1VoKU-uhh0ttKBdjKCG7-gBwHzJQTC-yOcw92FxcFNF5yaUZ8e4ZLjBjpw
Message-ID: <CAHC9VhRXFaZUnDYjd1sdgxSy2ngjEghcv7vE64qXiWQNzOLBhg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 3, 2026 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Are you sure that's the behavior you want?
> >
> > Think about how the socket/connect check works for local operations:
> > the task requesting the socket/connect operation is the subject and
> > the socket is the object.  In the currently proposed patch, when an
> > ASCONF socket/connect operation is requested, the subject is treated
> > completely differently as the socket is used to represent both the
> > subject and object.  Even if we consider the socket's label a proxy
> > for the creating task, using the socket's label as the subject of an
> > ASCONF permission check makes little sense as it is the remote
> > endpoint that triggers the ASCONF operation, not a local entity.
> >
> > > I don't think there is
> > > precedent for performing the socket layer checks with the peer SID as
> > > the subject rather than the local socket SID ...
> >
> > I think that is because all (?) of the other socket layer checks are
> > initiated by the local system.  The ASCONF operations are unique
> > because a remote node initiates them, which is why the network peer
> > label is used as the subject as that best represents the remote
> > endpoint.
> >
> > Please feel free to put forth your own reasoning on this, a discussion
> > would be good, but I think we do need to recognize that ASCONF
> > operations are different from local socket operations.
>
> That seems reasonable. Wondering if this change will then require
> updates to the selinux-testsuite (or if not, we ought to test this
> behavior too).

Yes, definitely.

--=20
paul-moore.com
