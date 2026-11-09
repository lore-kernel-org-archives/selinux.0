Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240862;
	b=2zr5zixWJUrsrTe1+RGa7UpfyunJ3IET0vV/+enplVbjVHyBVSMI2JChFeJVjckJsyc1
	 9U+Q7nLxi1HxUJ+sqoYtMhOB0rBV1fou7jS/3CD9g1cHqK5dWc/0kJcbcsYoQfyxoli3o
	 a7HYliF//VfLMjzOBd0WbgBJjqP/oomSJHQ9Zfa50i+3DN0TLvuos26vHVDsLNZ1URcaV
	 uzlcjwppEH/vsVzR5kV+vZ7Q81CbnMAKJGWZ9C+AMoqFkq5vUhZ5InIEohVC7ykAXeEWA
	 DyQo+/PzvfHm2ZUSL7du4bZqweq2UgMTsWkjuScpRc3efv9l4yoc3PstFFqfvvoirIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=nsIuWJ6Kj2pSGGfMCXkp9iHIuGKU7N/fjPUbgEaQ5To=;
	b=dULoODNZAeUhajinwuTb14j5GJfYppyQ+uXBxYwknTzO3AllUPf0A8pjaZO7lZJ14zBx
	 zts8da6dGE0pkd2/sJupO4StT8JrEqvLHEfcWF5QQm4ud+DywlwSjjw4indhDMVvemjav
	 gPEMfH7f9A3sndxg09jVFEVK+LiWux9eA5j/6NnRfo0XtcWzJ0KrdFyCcyfYnlndKVtkg
	 p384NBM8pP4Ey7o0aGmzn2alobhyqJbkpj9fPJGsj9uB9gkO/DGKgdJKDOIiJmKYZ+Ekd
	 oRv0hOZomKuBtvhHuVY2uaeItrjkJQ4aHuuWQWwo+QW4lnjh5WIMHipSIv/qMtOAc8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWD+++ub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB3606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWD+++ub
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0dba37a7fso10687377b3.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240861; cv=none;
        d=google.com; s=arc-20260327;
        b=QABgRvrRkOs2usLtTSihJDZ5OouBxfnSoc1an94veeQNKD9aJHkYrYmbKIN/x6zEBw
         pTxJaiyzNM5bkoDAMlBi2/CPzdo/xkzY7ANvVD+C8vLXN2g7VdFhYuUqqH0zP83WdgR2
         4QDPJr8FgnbjVpn1S7Qg/4obrcEqEkHg6JVjBFjkrybdNUy3rxLpgVNT7Ok4FCipN0VF
         2tijtHJXg74MHwY4Ud9yfR77JlXIwZQpv86BMmp8LUazK2TMR9rmRbYVKnfJOu411F84
         K3rrUxIkqqfhcLALNuWXdUSs+rbqsbWeCFulmrF0dlPznbGDE/4QtYaQZEqyudU4wBHp
         iZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsIuWJ6Kj2pSGGfMCXkp9iHIuGKU7N/fjPUbgEaQ5To=;
        fh=dE59vFSsQp8L4IVL9xeZu27J4r6yv2p7roueiPvn7mg=;
        b=cPMG970xkfhtvP8cwuwx6g8cEk+Wd8hhkH5tVCfR5Zhx5Q3bM61FOE4hk45ldxQb7V
         l+QD63Yk1TFta7n9X2teKj3GhghWbj7tjtF1x9ICsaNCdMk2TAdQDzyOKp8+z5efFaji
         LGEgz78G+HjMfaSpRXACu+mU78jU/ObkbIoY0qTtrMiidYjrw8dJ44gqcG8HrWVq1p4C
         P4lPpXbbBioUWwRQPwg904ret9uoLbbwv3PZmmIwz/bVcZ/57LAvoKAXYJddwQbK6cZ5
         hm50PBOUnVkrGWE8ZDBct9h0EWDvWL/eZhyzT4R39Z39eyu7rTpf2quBX3BnLv4UKlRP
         P8wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240861; x=1794845661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nsIuWJ6Kj2pSGGfMCXkp9iHIuGKU7N/fjPUbgEaQ5To=;
        b=pWD+++ubIDLgzzuRyD8LAcM/qAcolaxFi/kn0/ZQPE3tZkBkaFZxrcNlBsTl0RzpBz
         Je39xk+ytPs8xfUGUVUzGMvVOg5xazy7RfHZBpAOVfR8D5w31zVDT92+t/VGJaS7ieTe
         Bk7yZJ92e9Od8jimEORGU4femfFeBL02RxKmbWQjfTYH6jXl8S0BDNfthf6i6T8fKBg5
         n8ZxQkW0RF97c9lV0DYbpMePD8uvj1ZbApeAyzYu7MH77muYcD8v8rtxTwLr8j9Nez2m
         /9l6oyelFYfOKcwKwKvxuHwM8F94ADSfbwgO3YK6l1qBWf6Kd0yaw/3xhvc3zN/PQuMT
         ujww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240861; x=1794845661;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nsIuWJ6Kj2pSGGfMCXkp9iHIuGKU7N/fjPUbgEaQ5To=;
        b=fnSCAjIX/YNckEKN1H8ktMvfL17trQmSwLqnGcpVn7+IQw6CC93D9poZpD2Kx9f9zq
         evo9nVIu4YT7d2IIVZ9+UAQsew5l1O7xEBnBjnt928o2QgJMlALRIjwOdWS9BOg9OWst
         pJsGWNr0plHtY/iqPDXaW6r22TM9XBNMUOcS1eS7Kb1bszvvgNmP7Arct9EICT2aBGJj
         dl5GYmyxeVGBFD4Ob8LVqo74x449xQ4kN4fb2h1uGJdeD4KoTm5VDyhA57P1DTy6JoRh
         oDHaTeMla0B07sC/rax6ai0er0HByO+duLRWDbblarSSxecFIoVH8K3j2+IJOOPNBuhZ
         eO/Q==
X-Forwarded-Encrypted: i=1; AL+hErFIP8ULGDVtp15f/QaiwLg7X0PuAIvdi3/L+jlE7y7UOPC2ZyRbranuVL1+IT68JxX2HSUPshd5@vger.kernel.org
X-Gm-Message-State: APuU4Z9F5kLCs+1a/HV43dMBKVKU/awCYQ+N3jkl0L/k7AyHlPPLsziT
	x8zVBOnUEyb/tgJ0193OE3MpnCMdBLUkCsSfrZYXL5+Mq9hqcPu82xUWL7gLapJeoQl54n+1f9q
	vmbWkHNBS6fNslbJdnkIjrGBVz1wwZhw=
X-Gm-Gg: AYBFou1X+kARI3fAdzBz3un0xwLUeVVuCP9j8ibcQk1lxdMIzU3Fs2nrIv6nGlxZ94D
	VH6i5CgSM0T87mJ6LN4he/389t8C7lFFNzeJkBeRD+nQ9bh6ePNjzVGTg6VBdTMxzFiIH7XfnDW
	8oTLTbhP46J70kQ1eKn33G14sIDVhU9uwCVoMRmM+5e6qxfQD7mPdM7WmkAoo3uxoI0ELzDca8x
	yE8D1EML9HAyW4Qcki2zepZffm4Wu18wpbNOJomYgHV51Plvy93X9CrXKGjCwrXuQgLUlAT5pa5
	q31JHxgx87Mq2ylIgKMJRpLeV/x8gCatULM5nZcHIeC9n0pEGj4N7gE0BXty85U6I+6h4lniNmt
	BV3dYjnY+JD0n/BLBM37CCNVcEAUa+gDT9w1JDvuHtRcLB9+HbbUzBdSLPweC+DN6c+/DabWk2s
	EpWwdhrofzYOv9RN9RTQZxdiBa7Wwd98TPBb2qpNl2/ohPyiyDb+SMXlK6VQ==
X-Received: by 2002:a05:690e:168c:b0:67c:b95:6753 with SMTP id
 956f58d0204a3-67c5682f0e9mr21392d50.146.1794240861000; Mon, 09 Nov 2026
 08:14:21 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
 <auxhNtTcQa-6TS35@suse.com> <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
 <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com> <auyV4UaYWjPiDZdD@suse.com>
In-Reply-To: <auyV4UaYWjPiDZdD@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:14:10 -0500
X-Gm-Features: AclHuK9NCxQKUEV7A10cCtK_GjPkJub3EjmqU4wUvEQpr3E9qlDSAOHB0dX7pRA
Message-ID: <CAEjxPJ6p+wGhq+Cjpg+J8HGZ=4x6e2o5AZ1OYHK4CCqVjd5GZw@mail.gmail.com>
Subject: Re: Question about libselinux *_with_level functions
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:45=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.de> w=
rote:
>
> On 2026-11-05 09:25 (UTC -0500), Stephen Smalley wrote:
> >On Thu, Nov 5, 2026 at 9:18=E2=80=AFAM Stephen Smalley
> ><stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Thu, Nov 5, 2026 at 6:03=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.=
de> wrote:
> >> >
> >> > On 2026-05-27 13:46 (UTC -0400), Stephen Smalley wrote:
> >> > >I believe this is a regression introduced by the deprecation/remova=
l
> >> > >of /sys/fs/selinux/user,
> >> > >as used by security_compute_user(), which was formerly used by
> >> > >get_ordered_context_list*().
> >> >
> >> > Hi,
> >> >
> >> > Just checking the state of this. Is this planned to be fixed at some=
 point?
> >>
> >> Sorry I saw Petr's response in the GitHub issue and was then unclear
> >> that there is anything to be fixed at the moment. Patches accepted if
> >> there is in fact a real bug for a real user of this interface.
> >
> >Actually, on a re-read, I see that there is indeed a bug that likely
> >has a relatively simple fix; is that something you want to create or
> >should we?
>
> Yes, I understood that the GH response was a red herring back then and I =
figured
> this email thread was the right path. But then it kinda fell through the =
cracks.
>
> I'd appreciate if you could come up with a fix, since I lack the historic=
al
> context to understand he regression and the deprecation of the previous
> features you mentioned.

A fix has been posted and merged, please test:
https://github.com/SELinuxProject/selinux/commit/fb81f2f56990fccae2c67d41ad=
e5ad4abaa6944d
