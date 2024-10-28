Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33971D9681
	for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119145; cv=none; b=ANLCWbvjbbgvLZHrTgOaYUQD+m/GuyylntvO+F0Qwee/+d0gOXeCokZCxkBwjt8OYlMGD5QMhg986UCMrSwDJqWbW4iMz7jCc3eKLJXMQ0Vi67IszKhU8lecakYn7C3LS/3MzjkIEQPhto5h8WjEUcKmuueu1NJsEJ+SmXTtnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119145; c=relaxed/simple;
	bh=WE/7nRRpQk/UYVEomGKKs9q4iiZZ72ymq5bAyv9AaW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYu3tyFy3kYv2EKHEr4fHUj5k/AgZsvX+MS9N/VTBHkFZyw+PPfhIATcFYLRvC2ThI8DPNixYtoA1rSeuGRSmeRE2HRL2eA+l3bYK9iL7Nog9g8YlGb6G1tiwQ3PuY7BbR8UqZsMsa7M5fPShwAMHYpi7DcUT4ZmjgH8ncNSL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRgjo9ph; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRgjo9ph"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca1b6a80aso39916915ad.2
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119143; x=1730723943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JF+Fpcx+IhngXIJkbCSr/ZYvK4si9NuLewcXNjtgIc=;
        b=RRgjo9phFv5eC6vQVIlnPrsDC6r4mbuRdVzCKo8bRKopFl9FGXAym8eM4X3RLVD5/H
         ZTwXyLeM9Bwh/DclUaHBCkDqsN7RyQsksdMrK8McD931T0m2GcYgvuqfVz9SMlmbELxs
         aRdAA0cd403P/pPvqyw10XFgcm/Hxnhq9/G2CteH6WbDyRltiv17WShivi5tIHAR17zx
         MNot2EWWMbcBelel1zK8RPJLzNpuwl5qF7/Jkv2ftK+YydvQfktW72oxYb3oNniErjuP
         9lPnxzdgZMEXZIXgtOgP0cLulN89YIVa1r8BmoIiBTS24fIk2ofkRdvjx8z0MKaGFbTn
         hkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119143; x=1730723943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JF+Fpcx+IhngXIJkbCSr/ZYvK4si9NuLewcXNjtgIc=;
        b=tB8Q/Xg/2QXJn/gxTUz5KB/zLMbqz+m3J7VAX+KlGW+9/WlWL8kKzO/ip2G2Q28ntp
         CpdfNxt8bmjkOVQCiUNklRbcLzeKrTjp76oOHvbmiUVH68+A8bPH5awYs2BTMis2oBko
         E1/O7LdxbNrpDVHhpzrYJgMK1j4jFYrUcqr+g8UCqBGemr3GXlGvMbrmtq3E7tAV0e6m
         VskNGJrOc09fbi60hAiYvSBUoD9Px9LNKKfpEB/r8V96525gegI5gPh83W4mwp7B0Ryg
         nsQ3e/hn1gQBasg/znJkcJNYaxRNIuHXlQgbg5mQu4a4Wo57gaBYLTO0bB0dHgmCgscN
         N/+g==
X-Gm-Message-State: AOJu0YxzUNgQGeiqEuYfYpnpqOWC1yV9qU8NvMptHgcHhJylkx14vsax
	Grxvnb17nWPDEi3860BJnFGv/9JCj/N74vOsYGiqW6UgD7ofw3HRwUjwQUwtMGhT1iXyulimNxR
	ACE4D5REqAxlKe6TBKwStBtTV88zToWg6
X-Google-Smtp-Source: AGHT+IEz8tUxUXJB574VLjJzviNv1SO1AYSHlFcXeeel28zWQD+NjKSMnZlTc7FEUATK0OPguxjXUxKSfgaJm/VtwUY=
X-Received: by 2002:a17:90a:8b94:b0:2e2:d175:5f8d with SMTP id
 98e67ed59e1d1-2e8f105e6admr9721874a91.10.1730119143011; Mon, 28 Oct 2024
 05:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
 <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
 <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com> <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
 <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
 <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
 <CAEjxPJ4RbypeHbdpWPXGRstDAWWiEv+-dCWXc1aAO+zpkxnkEg@mail.gmail.com>
 <CAEjxPJ5Co0P1sVYmAiD0WnquNv8XOMAyi09GCW3jTPqsvZEsGQ@mail.gmail.com>
 <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com>
 <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com>
 <CAEjxPJ4S9Z1WOpcDNJ5t4vCuHM4DqAr2jLscSiPJrARr6QPJfA@mail.gmail.com>
 <CAEjxPJ7vMQ6SBVXUjfG+3XvHdkCvSO=fBwftFdt9kTfLrPzr_Q@mail.gmail.com>
 <CAEjxPJ6Kg4P8DBhG_JZj_U61PwyJF0jVJXX3QsLMrduR7RzrPg@mail.gmail.com>
 <CAEjxPJ6PevN1XCyqsC2gT3mXt4h78ed_=AiZBT+Q_oanx2DRdA@mail.gmail.com>
 <CAEjxPJ59ypVNV=oeYAgqZhdB+CQacjtgribCorXuoODe0JXnxw@mail.gmail.com>
 <CAEjxPJ7Pv_OHiYspdpWHiaEkH0XBQpThn6+ZiuycR-0k-4e_yA@mail.gmail.com>
 <CAEjxPJ5e937eLXjBQ5aOTsfkc2rxii0PSwNJsFkZ-rC0b=f4fg@mail.gmail.com> <CAJj0OuswnvrGNpoGFH-jTV+PdHeh46OWEJGAcqFiU1QPif4LXA@mail.gmail.com>
In-Reply-To: <CAJj0OuswnvrGNpoGFH-jTV+PdHeh46OWEJGAcqFiU1QPif4LXA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Oct 2024 08:38:51 -0400
Message-ID: <CAEjxPJ7FD4EKauMRqb5Y0n=uyjYDp4q-dk2h0G0Sz9pF=TQLaQ@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: "C.J. Collier" <cjac@colliertech.org>
Cc: SElinux list <selinux@vger.kernel.org>, russell@coker.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 2:29=E2=80=AFAM C.J. Collier <cjac@colliertech.org>=
 wrote:
>
> Hi Stephen,
>
> I'd be interested in testing this new code.  Are there any tips or tools =
for spinning up a qemu environment with a kernel patched to include the cha=
nges?  Where can I find your test suite?
>
> I presume that you're targeting RHEL/Fedora.  I'd be interested in exerci=
sing the Debian use case.
>
> Is there an irc channel?
>
> Russell, do you have any tips?
>
> Most of my customers are Hadoop users.
>
> Thanks for your persistence here, Stephen.  I've been watching with inter=
est since August.

Thanks for offering to test, but be warned that there is a bit of a
high bar to doing so.

At present, one has to clone, build, and boot the working-selinuxns
branch of my selinux-kernel fork:
    git clone -b working-selinuxns
https://github.com/stephensmalley/selinux-kernel
with CONFIG_SECURITY_SELINUX_NS=3Dy set in the kernel configuration.
The _MAXNS and _MAXNSDEPTH configuration options can either be left
with their default values or,
if you want to prevent child namespaces from creating their own nested
SELinux namespaces beyond
the one they are given, you could set CONFIG_SECURITY_SELINUX_MAXNSDEPTH to=
 1 or
"echo 1 > /sys/fs/selinux/maxnsdepth" at runtime.

To exercise the functionality in containers, I have sample patches for
libselinux to wrap the kernel interface on the selinuxns branch of my
selinux fork:
    git clone -b selinuxns https://github.com/stephensmalley/selinux
and patches for systemd-nspawn and systemd on the selinuxns branch of
my systemd fork:
    git clone -b selinuxns https://github.com/stephensmalley/systemd

You'd most likely want to cherry-pick the patches over to whatever
versions of libselinux and systemd your distro is using.

As far as testing goes, to date that has consisted of running the
existing selinux-testsuite in the init SELinux namespace
and in a manually unshared child SELinux namespace to ensure no
regressions, with some patches to the testsuite for
corner cases in the selinuxns branch of my selinux-testsuite fork:
   git clone -b selinuxns https://github.com/stephensmalley/selinux-testsui=
te

And using the patched systemd-nspawn to spawn a container with its own
SELinux namespace via the new --selinux-namespace option,
with the patched systemd inside the container so that it will proceed
to load its own policy and set its own enforcing mode based on the
container's
configuration, independent of the host OS. For the latter, I've only
tested Fedora containers on a Fedora host thus far. Some policy tweaks
are required to make this work in enforcing mode but that's relatively
straightforward based on the logs when run in permissive mode.

Sorry, no irc channel specifically for this and I'm not generally on
the existing selinux irc channels due to limitations associated with
my workplace.

Happy to send more detailed instructions and answer questions by email
off-list if you are still interested.
