Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E920125C
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523172; cv=none; b=pYPFScWf9W9RvCqkn9tTixCjflXSIH1rcUy+aGAgKjJCPs95zRhSDYZ6/EDd78OwS2sHYalCXGsi7HEO72YjMqe7qJIIlgV965DgsRm04cc41a8O8S8gDY2H7oKp2jp1ua3C4kWVBLxJNtAkyXkl6WUye3anKkqYzvpD2Li8rEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523172; c=relaxed/simple;
	bh=0Ahv/1R6L9J4i3GO7wIPJ96/5tRm0GkMKVcs2k9xGB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umC6BWWzthlw2CVI1ZP9Ok2eX+Uy7cvTvqtjuWseS4V6nG8cri3SrzXm3McCLtJUjJz2C8klNqKbY91bXg1LlwiIjqef7Ge6xN5x49WWDGLEwyx/f3lllV3xpaERrhbCDL4ttCk34x6E1GoYf3HLwFOFesCnbMQdHxBgINgVmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEcCALGG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEcCALGG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cdb889222so72798415ad.3
        for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731523170; x=1732127970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLqS6PvEyacZurJsPsn3Rs3Y8/3deuFVgKdYHTiOOc4=;
        b=EEcCALGGssSbDBeybM5FtgVeCYKsZ7JHq9pWoVNQLhT4bHCFgUqVKy0Ml0XawYEdm8
         c4EkAo+iGfDASfl2TSpdJvdScuetuzUQb3bTNMUUA5g2p190IN7gCvyXHp7O87atxRXO
         Xm0mDpIPrcz10b8pG6Op8/E4MpLjLuZ2pn7JE6+XsgZn9chtVDXBeuhiEJBzqFL9nlEM
         Bgm3PFaID4s6Reofw9ceYp+fLEHN7F3O1NYg/tetAOuqRH2gYEyz0UDuNx6rCyOA7QcM
         3nbg4Fo6VJ8XevM+fPtgs9UR7AKwIrnkBp7J12lZoXxO4HmWxltCx8fO1JSjRP9BBGYE
         icTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523170; x=1732127970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLqS6PvEyacZurJsPsn3Rs3Y8/3deuFVgKdYHTiOOc4=;
        b=L1WVLHskwRKpROInkRO9jp+QyydwWOkLxdxxtfQkg5HdPNbXbDra84as3MIN7PTUM1
         Dg1QBdcyhdEy0TM0TmGIfapBkr9If8Tjpb/J6N+28rEV03bNGQgwXm6SK9l0lEIrvqJH
         kpGImrfLtAXUu+iBDyjD+AOVCMAoX/2D6GotVWbOJkemzgD9JORt1RR7BaZA7lkNhb0k
         P3LdEeiYRlVMJMXzL5IK+PAYxJaBFY7JkZYb2YD0VfVU6jPL7MmYOlSb/Z3hY0xfBsIg
         wwNaPqPZhpuxvpVrGB1wGlcp7oMT0yzQQuOG4+AGF+MlA0oybzByNvamn8v4ug/TNPfg
         R2rg==
X-Gm-Message-State: AOJu0YzggNdV3hUUf2QXq72gRjgDMTpzvg8qxxOgk5SM0W3Z9vNpxtnW
	iNoFmHOjImEMeiZNjXW5hAxK7rGs15Zc+tDcShGcCoJXTYoqgoA1mDjTj8Z1lGCxevl2sxL0nVm
	2go0OfF2Fn6VBWu2MBI+tMl5CbSY7mQ==
X-Google-Smtp-Source: AGHT+IF/2bfLoIU9jVEMYbyPfobl3xfbAP9TKMwN30YMHY2KTEzmUGUaX7nEwYqxWkDUO8P+czVgk+WU8m5ERzLy80Q=
X-Received: by 2002:a17:902:ced2:b0:20e:986a:6e72 with SMTP id
 d9443c01a7336-211b5ca65cdmr45847155ad.30.1731523169770; Wed, 13 Nov 2024
 10:39:29 -0800 (PST)
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
 <CAEjxPJ5e937eLXjBQ5aOTsfkc2rxii0PSwNJsFkZ-rC0b=f4fg@mail.gmail.com>
 <CAJj0OuswnvrGNpoGFH-jTV+PdHeh46OWEJGAcqFiU1QPif4LXA@mail.gmail.com> <CAEjxPJ7FD4EKauMRqb5Y0n=uyjYDp4q-dk2h0G0Sz9pF=TQLaQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7FD4EKauMRqb5Y0n=uyjYDp4q-dk2h0G0Sz9pF=TQLaQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 13 Nov 2024 13:39:17 -0500
Message-ID: <CAEjxPJ4RPOA7E=VGOvMgUyYa78vLUOdjxQwVmRMC6A8Ee=e+wQ@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: "C.J. Collier" <cjac@colliertech.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Topi Miettinen <toiwoton@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, russell@coker.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 26, 2024 at 2:29=E2=80=AFAM C.J. Collier <cjac@colliertech.or=
g> wrote:
> >
> > Hi Stephen,
> >
> > I'd be interested in testing this new code.  Are there any tips or tool=
s for spinning up a qemu environment with a kernel patched to include the c=
hanges?  Where can I find your test suite?
> >
> > I presume that you're targeting RHEL/Fedora.  I'd be interested in exer=
cising the Debian use case.
> >
> > Is there an irc channel?
> >
> > Russell, do you have any tips?
> >
> > Most of my customers are Hadoop users.
> >
> > Thanks for your persistence here, Stephen.  I've been watching with int=
erest since August.
>
> Thanks for offering to test, but be warned that there is a bit of a
> high bar to doing so.
>
> At present, one has to clone, build, and boot the working-selinuxns
> branch of my selinux-kernel fork:
>     git clone -b working-selinuxns
> https://github.com/stephensmalley/selinux-kernel
> with CONFIG_SECURITY_SELINUX_NS=3Dy set in the kernel configuration.
> The _MAXNS and _MAXNSDEPTH configuration options can either be left
> with their default values or,
> if you want to prevent child namespaces from creating their own nested
> SELinux namespaces beyond
> the one they are given, you could set CONFIG_SECURITY_SELINUX_MAXNSDEPTH =
to 1 or
> "echo 1 > /sys/fs/selinux/maxnsdepth" at runtime.
>
> To exercise the functionality in containers, I have sample patches for
> libselinux to wrap the kernel interface on the selinuxns branch of my
> selinux fork:
>     git clone -b selinuxns https://github.com/stephensmalley/selinux
> and patches for systemd-nspawn and systemd on the selinuxns branch of
> my systemd fork:
>     git clone -b selinuxns https://github.com/stephensmalley/systemd
>
> You'd most likely want to cherry-pick the patches over to whatever
> versions of libselinux and systemd your distro is using.
>
> As far as testing goes, to date that has consisted of running the
> existing selinux-testsuite in the init SELinux namespace
> and in a manually unshared child SELinux namespace to ensure no
> regressions, with some patches to the testsuite for
> corner cases in the selinuxns branch of my selinux-testsuite fork:
>    git clone -b selinuxns https://github.com/stephensmalley/selinux-tests=
uite
>
> And using the patched systemd-nspawn to spawn a container with its own
> SELinux namespace via the new --selinux-namespace option,
> with the patched systemd inside the container so that it will proceed
> to load its own policy and set its own enforcing mode based on the
> container's
> configuration, independent of the host OS. For the latter, I've only
> tested Fedora containers on a Fedora host thus far. Some policy tweaks
> are required to make this work in enforcing mode but that's relatively
> straightforward based on the logs when run in permissive mode.
>
> Sorry, no irc channel specifically for this and I'm not generally on
> the existing selinux irc channels due to limitations associated with
> my workplace.
>
> Happy to send more detailed instructions and answer questions by email
> off-list if you are still interested.

Status update for those who are following along and/or interested in
trying it themselves and/or interested in helping:

- I have successfully booted Fedora, Rocky 9, and Rocky 8 with SELinux
enforcing in containers with their own SELinux namespace on a Fedora
host with SELinux enforcing. The purpose of trying Rocky 9 and Rocky 8
was to exercise distro releases with increasingly older policies and
userspace. No obvious problems manifested although admittedly I didn't
do much more than boot, login, and look around a bit.

- I have done the same on a Fedora host OS with no policy loaded (the
closest to SELinux-disabled on the host that can still support SELinux
namespaces for the containers). That triggered a kernel bug that I
have now fixed, required some further policy customizations for the
containers due to differences in the labeling (or lack thereof) on the
host, and required relabeling the container filesystem on first boot,
but otherwise seemed to work.

- I have done the same on an Ubuntu host OS, again with SELinux
enabled but no policy loaded on the host itself. This worked
identically to the previous case (in fact even used the exact same
container images for Fedora and Rocky 8 and 9).

There are still a number of known issues still to be resolved to make
the SELinux namespaces fully safe (but access from userspace is
protected behind a kernel config option + a new SELinux unshare
permission + root/CAP_DAC_OVERRIDE to write to the selinuxfs unshare
interface + the ability to limit the depth and number of namespaces so
that e.g. containers can't further unshare/nest namespaces), and I
haven't yet looked at performance overheads, but I'm wondering if it
makes sense to post the latest patch series for review / discussion?
Or something else to get a bit more feedback / engagement?
