Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FD21A4A1
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871316; cv=none; b=UEpcIt0/d2arxsIN6R0ZbY0vuTziiwtl/Rcw4TwCUBEORChgwPMzSHyjPUzWDZhWltYdbs7vEmbbnrJAUx0j2/Wl9ybY+1b7h71kQpdyR4qr8bVDO2rV/DPQxQh4aZaCg+WjQq/qshpy7BxR6JTGc1XOZjuvRihFdnoaw4MdnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871316; c=relaxed/simple;
	bh=EvkjYP/3sSXbzLG7BRTO0iHCS3Wc0r41hNxdmkwsebs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPHdFf9LweO0mwyobzDZNiGzn6gQENQjDC7mTGYXLzDjKviZzX+h3mlPTedCltsrpelOIdNTiwoDSDhhDNkPa53paKekvqIvFmOrxpbpDXauvISOquHicejbSRqbwmPezFk1X72FqzvaQqLm7O07JSrnvKGxsp1C7VjrP6t5EzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a57G0Lq/; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a57G0Lq/"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288d74b3a91so1371893fac.0
        for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729871313; x=1730476113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hn0iGv6FjBT85MocjDfQQ+jwJ0vITk/KFYz1Jnfq+Y=;
        b=a57G0Lq/uwLu3T2wOihnt3G0tdh/ygvioWmAOqBpfmOdp9Utog8B7QMGNHuRfLRrTU
         z9Mlznn3q3uIqRZJ6HWGe8vvJoRlPXLIEN/ArfPgO4ghZ/3J+MiWB/sEkz3nOEcGXrE4
         rl/1x3zKuBB+iWeZ1QQk4UCE79huW+K5zaFQrRVJjB7T8DTCACwVPM9n/n1jrQw33UFY
         Y2YgASDAWjpp5A9axYbyNwfy+jpMu4Sb3xQumzm5cE0TcG/icOomo+dY5TQXlO0ePnc8
         MOGgx3PH5+Anmw8SwqYjmxUHnkdrLgSsuOe/EgX8VlT2Y8/ExU/Z526BQuKOLmbGPe1R
         CE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871313; x=1730476113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hn0iGv6FjBT85MocjDfQQ+jwJ0vITk/KFYz1Jnfq+Y=;
        b=QybBxG3dpbK35H9pFSZZd63As/gHNdg26MvyRa6yZvk8y+xGnyYY58JQf3lzotwDaf
         xr4mhY+xVYeafiGmgWXUMvwNR+FKUirEPmZLpLKALLDGCK9B2UZJsehfBjOZ+iEm975J
         IMzU12NoxuAd8kmLZDB8eiRqyFtQOfTj5Tw7NyLMgU1O8J+vuHV9trsRzsJwakq5OxW1
         e3OBmLcmhCzXtzBQBEr4O2Eqsx1meeFzQyAG+/e2tPPFUy640C8JLdWKQec+HDfadPv5
         fKPuOtUhJWbCceKUKAwlCtnzrLMtJBvmkI6f2KWm1qsVJCkz+Tt4UV3JTutak+Dr3Tcc
         gyWg==
X-Gm-Message-State: AOJu0YxsZRDXnd46k1FuOmisRnb/UKAegC0cxJzE4A7EFuMqjDPwdLoc
	JMNOxgDjpyyk11oKnK6h8zkCREk+otK7wz26yKiVcr8AvoeRfJwFY0yc9Ze8I5Xpx+HQokRiabn
	BQGpYKuFHqMKR5ULDKOH2WWceO7rDmg==
X-Google-Smtp-Source: AGHT+IExGM4rJYnCufxqNhw/b7whksYV8U/m6nu0Qom46horCGph0EOuvTWKYF4C+hQKFkH4y/EIqzyDEhNNyA3QvLU=
X-Received: by 2002:a05:6870:a79b:b0:268:9f88:18ef with SMTP id
 586e51a60fabf-28ced27ba4cmr5826500fac.13.1729871313457; Fri, 25 Oct 2024
 08:48:33 -0700 (PDT)
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
 <CAEjxPJ59ypVNV=oeYAgqZhdB+CQacjtgribCorXuoODe0JXnxw@mail.gmail.com> <CAEjxPJ7Pv_OHiYspdpWHiaEkH0XBQpThn6+ZiuycR-0k-4e_yA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Pv_OHiYspdpWHiaEkH0XBQpThn6+ZiuycR-0k-4e_yA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Oct 2024 11:48:21 -0400
Message-ID: <CAEjxPJ5e937eLXjBQ5aOTsfkc2rxii0PSwNJsFkZ-rC0b=f4fg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Ok, I confirmed that the remaining denials are due to multiple tmpfs
> mounts and a socket created by systemd-nspawn during setup of the
> container that are then used by the container at runtime, and I
> confirmed that allowing those permissions in the container policy
> enables a Fedora container to boot in enforcing mode with its own
> SELinux namespace on a Fedora host in enforcing mode. Ultimately we
> will want the container runtime (systemd-nspawn in this case) to
> properly label those tmpfs mounts and the socket but that's just a
> matter of further userspace changes to systemd-nspawn.
>
> Still lots to do to allow more interesting combinations but I'll leave
> it there for a bit and see if anyone is actually interested in this
> besides me...

As per the discussion at the project meeting, I have added a Kconfig
option CONFIG_SECURITY_SELINUX_NS (default n) that controls whether
the SELinux namespace support is exposed to userspace at all but does
not affect the underlying infrastructure support.
Hence, anyone wishing to experiment with it will need to enable that
option. At this point, the safeguards on SELinux namespaces are as
follows:
- You have to explicitly enable it in Kconfig for it to be exposed to
userspace at all by the kernel,
- If enabled in Kconfig, the /sys/fs/selinux/unshare node for
unsharing the SELinux namespace can only be written by processes that
have the root UID (or CAP_DAC_OVERRIDE if non-root) and the new
unshare SELinux permission (obviously on Fedora the latter is
default-allowed unless you define the permission, but even then you
still have to be root or CAP_DAC_OVERRIDE).
- If enabled in Kconfig, then two additional Kconfig options and
/sys/fs/selinux nodes are provided for specifying the maximum number
of SELinux namespaces (default 65535) and the maximum depth to which
they can be nested (default 32). The
/sys/fs/selinux/{maxns,maxnsdepth} nodes can only be written by a
process with the root uid (or CAP_DAC_OVERRIDE) and the new
setmaxns/setmaxnsdepth SELinux permissions. Further,  they can only be
set from the initial SELinux namespace, not from child namespaces.

Hopefully those safeguards remove any qualms people might have about testin=
g.

Would welcome any code reviewers or testers, especially for corner
cases that I am less likely to exercise myself - e.g. policies not
based on refpolicy, containers and/or host OSes that are not Fedora
derivatives, etc. You'll need the patched kernel, libselinux,
systemd-nspawn, and systemd (or roll your own userspace patches for
your preferred container runtime and/or init daemon) to exercise it,
as previously described in the thread.
