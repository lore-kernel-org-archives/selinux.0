Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29E4879E
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UUuIHCR9"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbdacafe012so134904276.1
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703108129; x=1703712929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AxAQvYhmhIfUqWH7duUzPZfIF+U7r5XIuQJtwq0N2w=;
        b=UUuIHCR9Z6MCoqgm03X/+NY0c12KV932axShY7LJzuQ61B/Wq9ZQIX/W3uL2qSkVxO
         ZjNQpLOkPi7Ey/6vonDqUWoojvw2SIPu3OAP8N+ZALeX7080SLndqanQwL4p/2LH2NT+
         3Emwe21STK5jTTEQukhqzpLhfAJTftBEEbFfUVMTuCfc4l8Pa8720hTOhHh79EUNvos6
         B82oYNhZH43S8dN/cDhLrnqYiUcpq6UBxqvYsNaX/Tx6Gjp6/Y9hGkyLyw+mBJKWeDa8
         r5iR5laldT0f+qWBpZQ22ILA5T0kMeE9wsz4d0SH3eFlQ4qRj82eBtew1hySgpthEDjE
         E0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108129; x=1703712929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AxAQvYhmhIfUqWH7duUzPZfIF+U7r5XIuQJtwq0N2w=;
        b=lzvoaKx3CvxHml5WpMRlRbtQhRDvaTURWIcwzXICE1/dGsuIIRjCtk/oEWZLFDB1Ir
         LqUDS1HgJovor8TcX0uFTRqSj2/vSe7H9e7jmbsBAaV1q03A3VATqach5wGVohw1E2Du
         DYjjA4JCoxH7QBZTSilcKtVuP28cvB6QJ34ybHPaf8a0YjfJ1tg2t5T809mdopPLh9T5
         qWSyXlyS74MqKv5h8K0pEpq1Ucfbo2k5+yg42uTfMVplvZYHwAG7r8ho+FVMa1yuCnWT
         IJxSglZ9fK9COAjZw6+17xkg5mZ1ssfXZHrNh0QsOiUbnaHvQlTCyLFn70mx67YPDaYv
         OpRg==
X-Gm-Message-State: AOJu0Yw/or9dC90gO99Zz7LAkUlvowFYC1hLDkH8OU5++P/ccW0Fa8Qw
	eN9GDaSOxi16jKwmQFdpR5z4hnBcOZ9Mj357xh61
X-Google-Smtp-Source: AGHT+IFosPpMjzCvih79hRO0tYrhLHSlPcFGCjYGSvXhZ46V32jgqWJ379mulOVwn3keNvIGmfCl8hZd1txiBkat8QI=
X-Received: by 2002:a25:d6c4:0:b0:dbd:4aea:b098 with SMTP id
 n187-20020a25d6c4000000b00dbd4aeab098mr301577ybg.131.1703108129210; Wed, 20
 Dec 2023 13:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bkaurtrk.fsf@redhat.com> <878r5yrsnc.fsf@redhat.com>
 <bea94ac8b2feca19ef51ad271e56ff88617614e1.camel@suse.de> <87o7elxdxs.fsf@redhat.com>
In-Reply-To: <87o7elxdxs.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 16:35:18 -0500
Message-ID: <CAHC9VhQf-gBppuYbfcnSomHFGVvYtUcUbG-p2jvt-0ZUDq=6SA@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.6
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:21=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Cathy Hu <cahu@suse.de> writes:
>
> > Hi,
> >
> > thanks for the new userspace release. I was just packaging it for
> > opensuse when I saw that the signing key changed.
> >
> > Could someone confirm if that is correct? I am just a bit unsure since
> > the new key has no signatures from people that I frequently see on this
> > mailinglist.
> >
> > New key (almost no signatures):
> > https://keyserver.ubuntu.com/pks/lookup?search=3D1BE2C0FF08949623102FD2=
564695881C254508D1&fingerprint=3Don&op=3Dindex
> >
> > Old key (lots of signatures):
> > https://keyserver.ubuntu.com/pks/lookup?search=3DE853C1848B0185CF42864D=
F363A8AD4B982C4373&fingerprint=3Don&op=3Dindex
> >
>
> Thanks for checking signatures!
>
> This is correct.
>
> It's signed by me - Petr Lautrbach <lautrbach@redhat.com> known as
> bachradsusi on github and the public key could be found at
>
> https://github.com/bachradsusi.gpg
>
> This key is signed by
> E853C1848B0185CF42864DF363A8AD4B982C4373 Petr Lautrbach
> <plautrba@redhat.com> which is signed by other guys ...

Perhaps it makes sense to include some text in the README.md with
information about what GPG fingerprints are valid for signing
releases?  Adding it to the README.md not only means that it is front
and center on the GitHub page, it also means that any fingerprints
added to the file will be part of the signed release tarballs
providing a history of authorized GPG identities (although that
doesn't help us until we build up that history).

As an example, here is what we do in libseccomp:
https://github.com/seccomp/libseccomp#verifying-release-tarballs

--=20
paul-moore.com
