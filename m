Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517602DECD4
	for <selinux@vger.kernel.org>; Fri,  7 Nov 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522139; cv=none; b=T/hTej0oFrTxhBF8W0hoZalei+y74BELhFtFPC5b3e64Cuvm+wsFjJNo7rSCiiEMPr2ts893I+2h8s9zAVPbX+soaAWEsNWX5w3PgUWIlK9363e2VbXf5mWTx5U6nn4g8adiqYMOKszJoFzuhBD/+EaU5750GgCPFRB8+1iWVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522139; c=relaxed/simple;
	bh=souzBdq0P9HlPZtv0YI0CSxtzPRCIBLcAdxpqC3vMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+UTq8YL+E+4QfiJ7kMFWaxiMvTtdcXV/eJzn2Tg22tX9CCpYBZkOjkKh6uZUyMYM1Df9bg40LbHgt4DeO6dPDDGrrj7S6EGCklXQHLPVlGB1CpLkItMCKg5mmeSI9NvSZLmNNESVRnlJm0mOO/1MUzIlKx0UtjFoRM8dH+L2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZtROeNN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZtROeNN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ba507fe592dso462440a12.2
        for <selinux@vger.kernel.org>; Fri, 07 Nov 2025 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762522137; x=1763126937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Dbd0NB/APJqkZUUDuPMw12W7POdvYCn4j4qOB5ONwY=;
        b=nZtROeNNBlWJkRXjSFnun/oJkGKU2g9eDRh3S5MgFJ8XJ+uxf+S9XjRAR+4rLwvpiv
         jfW/IyuPJotE/gSZp5IjU+BBSBF81zfuIU0sdQg8PKG76PghsX2EMQyjjnanRZQE+yC5
         0e2rKPstqXOb9IIevcmxnlFMp4/wWjwxPFWFN7wef1uVol/IcfzQulJiSJBaxi9+QjmK
         jOGddWJKQzVX8mLb0p0YBtNwaXSnsNM7l/TGQF00zPtf08HPA0bne5tbW9n7sZlUctmt
         mz/4e489vzHxLXiIAJFzNBGDkn0WK49ikTH2A7ez0ffC7CZoYvc4c93QVEr9sRBM5TuG
         Lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522137; x=1763126937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Dbd0NB/APJqkZUUDuPMw12W7POdvYCn4j4qOB5ONwY=;
        b=IvRTyEuXLqpoupMD3vLyYhTaeV7XHXS0yL3ZDjzMkkYNB8mAWmykk0IMaZomD552ME
         tFhyUByBmFzP2beW6ayfSJQbcA52a0vm+kTJrpIlwmMz+Z5lSTojboDQL3TohWaEtORs
         X4DfIi0KvguCu2vZUTTF75DDnRiktBMbpumO7t42DxCr6qmwcaQeLrbvyIGSPfUabX6A
         05aM/Xt3XcqAGhS2/boDBpVNxiikfLlY3eRDERrisxNEGDIw/HX2BJv7CJg+Dfaz/LFl
         tnFqh58nm39RLOAvwXvQiCV6O4u1scDUxfSwQ4CT9XyMH6IDe06MTxnqcQcS6hcXLiMc
         t2tg==
X-Gm-Message-State: AOJu0YxQcmzrwsTphLvmUHVymt0VSnPgy9WsEWDhZo9soH5o3DDJVmO7
	tg7mkBAtHEtg/j5tjAbAojdIzy57dpEhNqT+7zD5Wu126RRWhHG35eMSgOFoBTUo3r56FybfYwa
	VZbLjueEXotz53AMdwFXiNoDGS1aoZDM=
X-Gm-Gg: ASbGncvoYZ7m/y9u4pinxgDM8ySuVScdSM5KyWkBMu90Ocw8KHqTHWCBB1025QiIsnh
	m/z/gEX5dirpxsmETHO8KKQMkrFQRZZiIihVfToWvibNbHsw7FneHuT8hbUrJ824ZD+Gkh4h3G2
	QSeTfxZF9Qjr4JC9SMwZiJLUj8Mm1JRMO3fMYmmXFBtuqn2l0GcfN2eGJkDhV5pKlv1mjKzgYRx
	1aPIsRSq1l1SVud5HbXjlLhXX/pyIZlr3r29lGGzb1P2HeHB2rW2TIv3Z+62ElZXO6pYsY=
X-Google-Smtp-Source: AGHT+IGMHiENGA0Osa8xEKoNO3y71yxcsRgA/4WANO5ueNFN1+cMKi80A0wZt9JylO6yXmj8pkvHMb7nHJTuj1bz3+o=
X-Received: by 2002:a17:903:22cb:b0:295:8a21:155a with SMTP id
 d9443c01a7336-297c045f08fmr40966555ad.35.1762522137372; Fri, 07 Nov 2025
 05:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1VLLSK1NN9.CCD295WLXVQ6@gmail.com>
In-Reply-To: <DE1VLLSK1NN9.CCD295WLXVQ6@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Nov 2025 08:28:46 -0500
X-Gm-Features: AWmQ_bmnjviRv48IWKJxs3nsRgQzlieCPQOJtWQdRZi-5axg2sBpWFDXboLektQ
Message-ID: <CAEjxPJ4dX+_jr3oJdzD2veqU7krK+N_nV5eccP5M8Lo+uNYNeQ@mail.gmail.com>
Subject: Re: DBus Permissions
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, dominick.grift@defensec.nl, lautrbach@redhat.com, 
	cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:58=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> I've been looking into SELinux support for filtering DBus permissions
> lately. Right now, we have a few things of note from the dbus class:
>
> (class dbus (acquire_svc send_msg))
>
> 1. acquire_svc. This is useful for:
>    Allowing contexts to own names on the bus. We have numerous names
>    that exist on the bus that are effectively trusted: applications
>    need to be able to trust that the owner of a name is the intended
>    target. An example of this would be org.freedesktop.PolicyKit1 and
>    polkit: applications check if unprivileged subjects are allowed to
>    perform privileged operations using this DBus API. We can make use of
>    acquire_svc to ensure that only e.g. polkit.subj may own that name.
>
> 2. send_msg. This is useful for ensuring that subjects may only speak
>    to their intended targets.
>
> However, this has some serious limitations. For one, many names on the
> bus provide *both* unprivileged and privileged interfaces. An example
> of this is org.freedesktop.systemd1, the systemd api. It has various
> actions that aren't all that privileged (for example GetUnit) as well
> as actions that are highly privileged (such as StartUnit). A bug has
> been filed[1] such that any service capable of speaking to systemd over
> dbus can effectively escape its sandboxing (systemd's sandboxing, not
> selinux confinement)! It can simply start a transient unit using dbus
> without the same restrictions applied to the unit.
>
> In the case of systemd however, the situation is actually *much* better
> than other cases: systemd is actually SELinux aware and is an object
> manager, which means we at least have some control over what happens.
> However, dbus is a pretty fundermental IPC primative for desktop Linux.
> Plenty of things that aren't object managers nor SELinux aware provide
> privileged and unprivileged interfaces on the same bus name. One of the
> main advantages of brokering is the ability to perform various checks
> without the server needing to implement them.
>
> Hence, I propose extending what we can do with DBus to allow us to be
> much more granular with it. Other LSMs and IPC systems already have
> access control similar to this:
>
> 1. Android's binder supports service names being labelled[2]. This is
>    slightly different to the case of DBus here with binder being part
>    of the kernel, however the core concept could still apply as we may
>    simply provide dropins to extend the functionality of dbus config
>    to label names, and extend the dbus class. This would provide back-
>    wards compatability. It's also somewhat limited however because of
>    the DBus IPC design.
>
> 2. AppArmor has a much more rich access control setup for DBus. It does
>    not require installing DBus policy files, and supports performing
>    filtering based on the bus type, the path on the bus, the interface,
>    and the member. It also supports representing this all in policy[3].
>    This is in my opinion a much cleaner approach than requiring us to
>    have loads of labels for each possible member and interface. However,
>    I don't really have any idea as to how we this could represented in
>    policy. Maybe something using xperms? But I'm a bit lost as to how
>    an xperm set could be mapped to it.

In the olden days before SELinux, when we were working with the CMU
Mach microkernel and its IPC system [1],
we auto-generated access vector definitions (permission names) from
the Mach Interface Generation (MIG) files,
and each access vector had a general portion with common permissions
and then a service-specific portion with the
generated permissions. As long as you have no more than 32 interfaces
per interface, you can fit that in an access vector
without xperms; else you could use xperms for that purpose. WRT
xperms, it's just a matter of mapping each interface to
an integer index which likely already happens and then using that to
generate a mapping for policy writers to use.

[1] https://www-old.cs.utah.edu/flux/fluke/html/dtos/HTML/dtos.html

> [1] https://github.com/systemd/systemd/issues/8846
> [2] https://source.android.com/docs/core/architecture/hidl/binder-ipc#nam=
es
> [3] https://man.archlinux.org/man/apparmor.d.5.en#DBus_rules
>
> Thoughts/suggestions?
> Rahul
