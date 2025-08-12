Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C432EF656
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000758; cv=none; b=SlhJKJBvo8Y6Ci1LAsgjfhOMaXDgeHKc15UCoX1IHrSqbGq1NKevFg7dON97l0EYKgzq3SUhWUbEioVBXhBgyE1seTDD5njW8D8zK05wzUTZ1U73D7oqV9b29QSY/2/ke1MkANzPKzQWtr7Lq65SvhtZzxepF/LwsNWeCeblfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000758; c=relaxed/simple;
	bh=OM8vcBtT2inXwU23JnRa71YwRzQBdth/n5mtx4L41Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOxP9lhlFe/ll5Iy39oBcnux+n/ipfz0tBMldMDqjVVwhPkP6eCSwtq0SlyVSTaENYt+ymUeOSn68BMnXAGalCfFyDsK+M26AgO4jXucPk6jDl8odg2LKfrdOglAxiObF6N5OCPbxwyg/GGxwyU5dXl7VQNlWz9u8A/fOLdRkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtjeBN2B; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtjeBN2B"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31ece02ad92so4103329a91.2
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755000756; x=1755605556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TV9zX+e+G5xVSEIvGGx6BFkGq+VFxTawIxpRbH++DY=;
        b=LtjeBN2Ba6K/EMHR6s+cmRO8pEKxPcBD5MtKwS+Oql0LJFcdAYRKny3jipAi3bL4LS
         cn8MhuI0oqSydzGsf4eI6iOU1zZdLEVnoY0RjMW/GJ0ZnKkaEsCCEjO2dWo11Jc4D86g
         3AwtGAQr69WOnMIa1FBvg2U2wQjRzkT+Esr2y3Qm2NN4PhB89JM8n4/PUlnPBvsyxKVv
         asouDalIBkfdk1sevhB4ILXq7QxFMtFv/KTFPgP896G21W2tfFYaAkUaLed4F2e1T3th
         Xc9c9s0W0uHz3SNwKBrv5cQNFDRk8kp7ra0jqZhteUKxMi2NcfjnUfneT602VKgvzg16
         Sr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000756; x=1755605556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TV9zX+e+G5xVSEIvGGx6BFkGq+VFxTawIxpRbH++DY=;
        b=a1WNMBCtrakkk6PJB4I3pS+LyR2f8bohUc+XKH5cW7VOj6xdl10CnCQGoGoXnwn5Ni
         XQ3ZV40ZR/sMQoHsQsiaOvohyKOYv6Pc2kvGqaZ0n/IrQs65VLbAiL9zWqmxgz6rVBu4
         DIhOspXbL/GOsyuzwfnZiMEtpFobm7X3zWFEIZZDkON7/JISZZdi1sRjhSEI1UB0ONwM
         wtyaIhKmJTVhlNV+PU9udA2rUpw+R4nZ032SXaa1vUFAzDgdm/E8w2FVYMMp0eT+Bg0d
         Lwlf6Q7Ef6hnQkZgwpeZOGwZyN29ZECA1KsU1B+q3b/dlWn4y48bh06rMaJMH1fN11GX
         6i/w==
X-Forwarded-Encrypted: i=1; AJvYcCXdvJoZ5lAX3v6cO3LBwf3yITSBUKy1Q128Udj/ml7a9oLUFkIGdNH1WETlxiCIF0SsjqLwfh4c@vger.kernel.org
X-Gm-Message-State: AOJu0YzR30+kXg89VyCrYTV3Bsu+JeN70dNy6t+zRUqu+S7KtYI2+pUU
	TcIB2IQwd5LgfDjT9U1Mn5H7xGQQYSjSjD9NqSzvavTOnIiFwDJYpBQrurCSK7VBX93Z/Rli31S
	MeJUUgU1vdwutU6cUHZAV6BCDbdR1UHo=
X-Gm-Gg: ASbGncvSs77zNhPRGw97GqGKZ8cBsV6Vdq96jZ8A1+bO9xPqamx+ic7JBrkAUgQDXqG
	RTJ9ueEbc4JemWOsfaSAVuaqytHjxE9Iu2gsKT8JkNU2PCR6H0/LZSbk+awosM7AK9rj4pTiuvq
	1cR8VN/20AMxRymBaNYnCTz81owUNVUtbZZhdjZLTmEEL4kV8PIkAEW9HYShhnSeiUDT/fu7KCX
	rhowiY=
X-Google-Smtp-Source: AGHT+IHE0UCdwLQawmKfShyZ2Gn/rWboCe3WmV6lJh/sP5ewolKIOitekak4wyFA1GpiUAe71PDnDP/CWskfNHhg+KM=
X-Received: by 2002:a17:90b:274c:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-321c5674645mr2346867a91.29.1755000755883; Tue, 12 Aug 2025
 05:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
 <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com>
 <CAEjxPJ4gAOXFShde9focOFpO747UaNMcxa9+-YJHT_Yu0GwETQ@mail.gmail.com> <CAHC9VhQLhJBYnnQTNamiQNBSBC8ynE=Cd50mVwuF_86B+PLepA@mail.gmail.com>
In-Reply-To: <CAHC9VhQLhJBYnnQTNamiQNBSBC8ynE=Cd50mVwuF_86B+PLepA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 Aug 2025 08:12:23 -0400
X-Gm-Features: Ac12FXzHFwK_PwS02J9NESuMSYW0zKbdUkVJQvt5cF8Z4IIptW9D_rtp9otX0Lg
Message-ID: <CAEjxPJ5Sn=4Z8Ck8mAbJNJe2f02PSgy4_=O88d70nymYSAc7Vg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: ericsu@linux.microsoft.com, danieldurning.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Aug 11, 2025 at 2:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Aug 11, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Aug 7, 2025 at 9:46=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Also, since you are introducing new permissions and a policy
> > > > capability, please include instructions in the commit description f=
or
> > > > running your testsuite, see
> > > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Start=
ed#add-new-permissions
> > > > and
> > > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Start=
ed#adding-a-new-selinux-policy-capability
> > > > for instructions and links to example previous commits.
> > >
> > > I think it's fair to simply call out the new permissions and policy
> > > capability in the patch's description along with a simple explanation
> > > that the new behavior is gated on the new policy capability.
> > > Including instructions on how to enable a policy capability is
> > > something that I think we can consider "an exercise left to the
> > > reader", with documentation located outside the patch description.
> > > The unfortunate reality is that there is no single right way to add a
> > > policy capability to a system, and those instructions which are distr=
o
> > > independent are likely to also clash with the distro supplied policy
> > > packages.
> > >
> > > Unfortunately, while the process around adding policy capabilities
> > > have improved somewhat over the years, it's still and ugly thing to
> > > have to do and I'm not sure a commit description is the best place to
> > > document that process.  I still have hope that some of the new policy
> > > work will improve this somewhat.
> >
> > My request and the linked example I provide in the wiki page is to put
> > this information into the testsuite patch description, not the kernel
> > patch description ...
>
> Your request was attached to the kernel patch thread, while you may
> have linked to test suite documentation, I think the distinction was
> unclear at best.  Perhaps one could put forward an argument and
> highlight portions of the discussion context, but I'm not going to
> bother to argue that either way; my comments stand with respect to
> kernel patch.

Ok, fair point - sorry for the confusion.

>
> > The instructions in the linked example are distro-agnostic and just
> > leveraging a CIL module, so nothing specialized there.
>
> I suspect there might be issues relating to the distro provided
> packages, but I'll leave that as an exercise for those with more time
> to play with that, and my Debian VM is in a bit of a broken state at
> the moment.

Yes, that could be true. I suppose a better requirement would be to
provide sufficient instructions that a reasonable third party could
re-create the conditions necessary to exercise the tests.
That could just be providing the steps that the patch author took to
run the tests themselves.

> Since there is some documentation on policy capabilities in the wiki,
> perhaps it would be good to provide some actual policy capability
> commit description boilerplate in the wiki?

Good idea - will do that.

> > At the very least, the specific name of the new policy capability and
> > the names of any new permissions and what classes they should be added
> > to needs to be clearly identified in the description.
>
> That was the first sentence in my reply.

Yep, but unfortunately was missing from the testsuite patch
description when it was posted.

>
> --
> paul-moore.com
