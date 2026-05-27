Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C43AB291
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911258; cv=pass; b=V4aOTsNyu+HUSFiGNIyzaHEgZT3yRbXRR+wMsbmKFKPZj4VTMxwEnZX+y33Lu2YUecfCSRtMBy88bu1ZB4MtZiEPRSp3tubGO9ifORsvmENLQJgtDf1JBTO7LhxAZs7/nm8T8VF9Z6gywnZxI/epL0TfbWXvs37RtFRHcNoOzds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911258; c=relaxed/simple;
	bh=kTywPN3H+0U4+OP12n473DxnMPrPY7zBbBFF2Kp4cTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCcM2FfqVinPqPEqhbS/wBtJVw/27YHsIhzt8huau0WPmqIi6Wd65b/jWU39OEDlhFCpeWqXdpQj0T0sRpdeTgTpJPcekMqWfNXzaD+eLIr6TGhFs6L94iDDs+gdMyI6e/5ZWjCB62vTYLvgfOJECebZ3W848wHvqeVWYsZr6UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtPUG1lO; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtPUG1lO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba928852a5so84600225ad.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779911257; cv=none;
        d=google.com; s=arc-20240605;
        b=CCLpYtgIEV7sRVMTxBtn/FdP8pxl4dd9LYunaKXG2X7QgpQcuWZxT3lZt30juQb/Rw
         Cy6Bo3mtDIqiebL86sfOeGHtTTSq9iDh6LeDtaFB0g5jnkMqv21HhWr8dsaP0wKIhGiS
         cVf2CAtg/6gejfbtSc6MLmRirv5uh38AbS4YxkFy92aq5el43az11KnQ6Ox+9xhpFuR3
         pyzaSx7AyMUK7pU+6Ao9uo+55XlDkXyKvIzPQGVH6UtkEOrexh0TFIkEMwx3HLEAkyIg
         PEKPOABUkjhtjyQIWzVliuOzsDTV//GxiBzUucKBvStb9bd/mGGgDpOuo3U5dGHdphFm
         brSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kTywPN3H+0U4+OP12n473DxnMPrPY7zBbBFF2Kp4cTw=;
        fh=UyK2yluEfDy/4KqdUzHAPc4sSFHTBxg+D2OXxrc9Nic=;
        b=axV6g6HVo2Ji7na+1qrMRxAQc022c/LVRN+pIKNPorQ9oC0dZSHe7WFNWT0iuvhEVX
         zHuND3FK3pV5eIvwI0xriZckdSmtWAygVaPOkSZXlMYfFw3x1v4dve+fhlF+zruGI6Em
         b8GBADz3KbLbuUePTCiYU+F0EG5ukoHZx+qY5SEqDTfBsYQNL1HAOVOxw5jQ/kZe0p4K
         thBGd1HgrtMtWqnwolM5Q4CU8FXAUlw9Jn40Mwaym3qBKsujCUf8Lc7aZbDChACtpgKA
         yH0ZFg4GgsHoGDjci99aRhwH/MXlkfvO1uY41Kv/6aOZv3VVafubSDT25Z9UYmwHl1gB
         kUaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911257; x=1780516057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTywPN3H+0U4+OP12n473DxnMPrPY7zBbBFF2Kp4cTw=;
        b=mtPUG1lOnwvUYpn4aq0JjDsIvidPDJwOxDsKXkpTrlNzm5JT+xKzfkkm8A0RJfLvKl
         H61Fss8+JFVOjjek/zFdNJG4QtPG7d+zWquEmsEY1gMwps8sPvGSFKr6XIpgvMf4/a5p
         Ve9oAa/lUyBjqUfjW5vRIRkDFVX509cc+/rcAqx4gBRbUKROcpl7oBT2udNasqncCECG
         LKai4MEBderyfeeN90FvquTIdAJwrsLsIUJ+C8ODyOrdCpjxH+vn1wrNrkAwF92NhfZZ
         mEbDGUKGwTRGUu+yP2nijzqliPUOcgmOlIsnPke+yRAL3Z21CXy+44b4czvDcc6G8G9+
         vtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911257; x=1780516057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTywPN3H+0U4+OP12n473DxnMPrPY7zBbBFF2Kp4cTw=;
        b=YvP6zd/6ZCFM5yVaoaW9UEaWgYM3O406QNKidoAuAvG7TKgZW8B1ZJhjFERVUdmfg4
         z4QyUOC/KUkXBtWiy0bGHnCwFzijQSmYHp5zwIYTSXG4rFyBH3Pn1rxzza+V5oo6bnEz
         Pdvq5+oqegY/Aqb8BniBmCXi2le2iODkQsXd09cmGFRJdI3hbKoopzYccdJGhXtJtRIt
         uR1ujFkjbvjPZMIlbT+ueQq0aud8jPLTr0VD6aRZvMxthvnGU6irWBUmSWjJgWuYObZm
         hN9rj/vllGbTryiBp5aBTWsIHkYcmMVregYpAbw/+ftfUBEKtxYkGxrtLB4wzdUb9LNB
         uwkw==
X-Gm-Message-State: AOJu0YyX6Af3hTj7xqj7ihfplbQ6NYB9+3+fiHLcefEyFk5oA82A+QSt
	cPxrj90/ATya2eDbd3uYk8Ge7OtI97fHcGpkA+Dv/vfQ0Df5drY/vHk33DMBRPD8FWDpcLekwiP
	krWgiskZId/+Hi6BumdX2CwSCZV4p4MQ=
X-Gm-Gg: Acq92OGH5Owi4rnOK8wZ8SDNOzsYGdou+q1TGuA0/iYK4mqOZmvgveJZmPs2qdSy1CQ
	N5k0FNqbrZyBQqZHp1K4px94B7ekZhpZAMbf8kPRoncqPhFrYK81nnKg5fypl3nbhBr39CbatkW
	f0rD4jmAlGbxFy19YF+U1u0zXgPXxkjWdn4eZil6MEN3kmSyY8+do+g7b+P/qdpvygVkKSuXYpq
	sLI246ROKQPPsyo7d3a/JECfjJzbp8hKIjoR/4qrNTYuR/XbfZdVCnU4lB7IFah6z4O6YR765m+
	KAiPcdN12bWm9kDXbA==
X-Received: by 2002:a17:903:4407:b0:2bd:9a27:70f1 with SMTP id
 d9443c01a7336-2beb0804542mr258867455ad.30.1779911256943; Wed, 27 May 2026
 12:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
 <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com> <87mrxmnrz5.fsf@redhat.com>
In-Reply-To: <87mrxmnrz5.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:47:25 -0400
X-Gm-Features: AVHnY4JjyObuqSswXQFvvdC64h3kVXezL7j3UGrsFYCvdB0VoKD4GnMxKcXAkhw
Message-ID: <CAEjxPJ7y-q=sFpd51ci5OvH9Qvf5-jx-7oTWOrrrhKSvF2YMng@mail.gmail.com>
Subject: Re: Minimum kernel version for SELinux userspace
To: Petr Lautrbach <plautrba@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <perfinion@gentoo.org>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:52=E2=80=AFAM Petr Lautrbach <plautrba@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> There are newer kernel APIs we could leverage to further improve the
> >> SELinux userspace, but doing so would require setting a minimum kernel
> >> version for new SELinux userspace releases. Not sure we've done that
> >> previously.
> >>
> >> In particular, I'd like to be able to use some or all of the following=
:
> >> open_tree() + move_mount(): v5.2
> >> openat2(RESOLVE_*): v5.6
> >> mount_setattr(): v5.12
> >>
> >> The question is what if any of these can we assume to be the minimum
> >> kernel version going forward?
> >> - kernel.org LTS kernels span 5.10 through 6.18 currently.
> >> - Android common kernels track LTS kernels.
> >> - RHEL 9 kernel was 5.14-based.
> >> - Ubuntu 22.04 kernel was 5.15-based.
> >> - Debian 12 kernel was 6.1-based.
> >>
> >> I would guess we could set the minimum kernel version to v5.12 and use
> >> all of these interfaces, at least in code not used by Android.
> >> Thoughts?
> >
> > As further context, I'm only looking at open_tree(), move_mount(), and
> > mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
> > sandbox/seunshare.c, restorecond/watch.c, and
> > libselinux/src/selinux_restorecon.c. None of these are used today by
> > Android AFAIK, although selinux_restorecon() was based on
> > selinux_android_restorecon() and might be re-unified with it some day.
> >
> > It would likely also be helpful to understand whether it is worth
> > further rewriting of sandbox/seunshare.c or if it is likely to be
> > obsoleted/replaced in the near term.
>
> We don't have any specific plan other than support it in existing
> version for release RHELs
>
> For future, I'd say that using bwrap could make things much easier.
> And I would not mind to move sandbox out of SELinuxProject/selinux to its
> own repository like SELinuxProject/sandbox.

Ok, do you have an opinion on setting a minimum kernel version for
future SELinux userspace releases (not 3.11, but say 3.12 and later)
so we can start using some or all of these interfaces without
requiring backward-compatibility fallbacks?
