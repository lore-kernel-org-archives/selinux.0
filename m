Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDB2E5B05
	for <selinux@vger.kernel.org>; Fri,  7 Nov 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523810; cv=none; b=W/N3O/j6PoGnjHoBVphXW8jYG2PkXNhXb753bzRNaSGA8ZslQ6kbFW+ldLBw1y7JHw0ziSw6ugZwgz6FBR8jKVq3ry6IhgW2H3wjuykLe0BmjCrvJNnJTf3euEMb+YcmIOdxmufmfCtS9ApnZl/MosAAuqllwFS8VDwcrPSwjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523810; c=relaxed/simple;
	bh=9lSfpy4lMqSLdbUfzGDzcSa0Gv5TiYjAHTm4roLyve0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeuD9yIEwhNyUlG0TG89hX/0wQti8pFv9wxtvn8HpDjKhm7OcUMlKY0MA8bVIWOkj0/XN4pK8Ke5QwyyFj/fLPYSGgPsXcfgtNhtA8wKxXzZ6kIPvbLrEIUItytNyKgPciwe5wKuptjAUQ+LvvZWIWhLSKM/k6EUvEdkZB1c9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0kobSE6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0kobSE6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so805715a91.2
        for <selinux@vger.kernel.org>; Fri, 07 Nov 2025 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523808; x=1763128608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4cpz2JU8TehbD/u0ESZ68ZV3nQbwUQTsVQXaqaHJUQ=;
        b=d0kobSE6JDdgB+Va7RQduPhPtyu5T1G88cFWLN+1W2CIrcMOD/A4ckIw3VX6ikCxfU
         YV7Iuq0RjSEfdqcmMOE4orKxw8H7hPtTbHpMdiTNoYDTr+iu5HB6WqbFJmXihsSu6Hhw
         pZteCF7r9KnBWOTlfr/bpM/xZpx7Tr0wwV77gtWYZ0thtWHjz1+9QbaI2h68gGK53cfK
         s2JUG9U+gRwtl+rr1O+9W3ZeS7VQ5+7KOn0iK27zuI2LpjpoCseQEq8NhYM9Ra0rF408
         sGQ9HkYL3o0PqraWxIYmU87uviue+KPrEJOHi5Ouhth+fGhOTeSBc2NuLaXvG9lyNoIA
         s9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523808; x=1763128608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4cpz2JU8TehbD/u0ESZ68ZV3nQbwUQTsVQXaqaHJUQ=;
        b=PWKCdCJi5AySqQrsSwzmVHo/DeYFoxaHGpM9Loe3eUr5WBZpEAdeRCEDmcYg8+WL3u
         hlU8fBhlTEGDfhJTaAI40Qh+eytjwu6hVAEaakGgVM/Vxkm3GvKULTlceXkJNY8bWmpn
         y3qP2gc8Oahe9f7dkN55+852h43u9nCA6UsUlFCwPwiVvNiES8xBJKKboneUAyz6CUCi
         NIG72n4caZc8ERPl9XoF3h3GvE/StHnH+rXooMQEAn4JYSnDgJLfOF2OsVXnrtzah9Mo
         LmGsFUYajX14BVYCdiPg6tB80RDgfnhXLpEJTL353QYPdSC1s2cLfYAf23+udHKCXJ99
         a5Aw==
X-Gm-Message-State: AOJu0YxBNbUaSWAts/PI1FW0P8cHK+/IuPqB56+arIx3BMWqpjVgCUJN
	it+O+Dgfn9LCmf/ZT+pRk/cx+NI9i3ezyUSWfq58q1E3IcTojC/CbEpccEjnKUFifBonytdAN/z
	2WIg6AWTEyyz4m2IJKMwv968mPZYmndk=
X-Gm-Gg: ASbGncs85ewPWgxe8NMxUwmrmGj0AG/1lT8YlUYU9sUs5BN4yvwbahSuphvBs8UAelc
	um+CC6zwDQv9DEj+x2niKiPrhwkdHly6VVknxBHSJJpZwcoIfiA4fOyBLWdMu1vLgZ2yq00Tqra
	QmHxtzVBgKlychT1cUrVGWTpWFWmXk44awPNnRR2r5mgIv6LX6VkWYKzCQZ+Pt4F+IuapZ5GPzh
	4QOLS6VIAK5OvZSPRGdU52GlI+kIP465/4YQNVq02rVBu7qLkL4Hubf9omRTLYTM3hHbVA=
X-Google-Smtp-Source: AGHT+IEs4GxQ+fvxXHEoHBccVHNhb7CQMxlc7B5dRNM5/bcc2w33Iw5jTU9xfdlz19KQamenS9t4F4vc2WRhmoJQDjM=
X-Received: by 2002:a17:90b:5544:b0:341:8ac6:2244 with SMTP id
 98e67ed59e1d1-3434c4f932cmr3665615a91.9.1762523808252; Fri, 07 Nov 2025
 05:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1VLLSK1NN9.CCD295WLXVQ6@gmail.com> <CAEjxPJ4dX+_jr3oJdzD2veqU7krK+N_nV5eccP5M8Lo+uNYNeQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4dX+_jr3oJdzD2veqU7krK+N_nV5eccP5M8Lo+uNYNeQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Nov 2025 08:56:37 -0500
X-Gm-Features: AWmQ_bkbA7-WaGn8K0fXjOIkwTv_4VKIXvuOWmTwlOTAgjJZAk5NDI_h3NW-DU4
Message-ID: <CAEjxPJ7COA5+GMtOQRaPzqaAUk583-Py=MwANt5eP35jXsdzgw@mail.gmail.com>
Subject: Re: DBus Permissions
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, dominick.grift@defensec.nl, lautrbach@redhat.com, 
	cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 2:58=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > I've been looking into SELinux support for filtering DBus permissions
> > lately. Right now, we have a few things of note from the dbus class:
> >
> > (class dbus (acquire_svc send_msg))
> >
> > 1. acquire_svc. This is useful for:
> >    Allowing contexts to own names on the bus. We have numerous names
> >    that exist on the bus that are effectively trusted: applications
> >    need to be able to trust that the owner of a name is the intended
> >    target. An example of this would be org.freedesktop.PolicyKit1 and
> >    polkit: applications check if unprivileged subjects are allowed to
> >    perform privileged operations using this DBus API. We can make use o=
f
> >    acquire_svc to ensure that only e.g. polkit.subj may own that name.
> >
> > 2. send_msg. This is useful for ensuring that subjects may only speak
> >    to their intended targets.
> >
> > However, this has some serious limitations. For one, many names on the
> > bus provide *both* unprivileged and privileged interfaces. An example
> > of this is org.freedesktop.systemd1, the systemd api. It has various
> > actions that aren't all that privileged (for example GetUnit) as well
> > as actions that are highly privileged (such as StartUnit). A bug has
> > been filed[1] such that any service capable of speaking to systemd over
> > dbus can effectively escape its sandboxing (systemd's sandboxing, not
> > selinux confinement)! It can simply start a transient unit using dbus
> > without the same restrictions applied to the unit.
> >
> > In the case of systemd however, the situation is actually *much* better
> > than other cases: systemd is actually SELinux aware and is an object
> > manager, which means we at least have some control over what happens.
> > However, dbus is a pretty fundermental IPC primative for desktop Linux.
> > Plenty of things that aren't object managers nor SELinux aware provide
> > privileged and unprivileged interfaces on the same bus name. One of the
> > main advantages of brokering is the ability to perform various checks
> > without the server needing to implement them.
> >
> > Hence, I propose extending what we can do with DBus to allow us to be
> > much more granular with it. Other LSMs and IPC systems already have
> > access control similar to this:
> >
> > 1. Android's binder supports service names being labelled[2]. This is
> >    slightly different to the case of DBus here with binder being part
> >    of the kernel, however the core concept could still apply as we may
> >    simply provide dropins to extend the functionality of dbus config
> >    to label names, and extend the dbus class. This would provide back-
> >    wards compatability. It's also somewhat limited however because of
> >    the DBus IPC design.
> >
> > 2. AppArmor has a much more rich access control setup for DBus. It does
> >    not require installing DBus policy files, and supports performing
> >    filtering based on the bus type, the path on the bus, the interface,
> >    and the member. It also supports representing this all in policy[3].
> >    This is in my opinion a much cleaner approach than requiring us to
> >    have loads of labels for each possible member and interface. However=
,
> >    I don't really have any idea as to how we this could represented in
> >    policy. Maybe something using xperms? But I'm a bit lost as to how
> >    an xperm set could be mapped to it.
>
> In the olden days before SELinux, when we were working with the CMU
> Mach microkernel and its IPC system [1],
> we auto-generated access vector definitions (permission names) from
> the Mach Interface Generation (MIG) files,
> and each access vector had a general portion with common permissions
> and then a service-specific portion with the
> generated permissions. As long as you have no more than 32 interfaces
> per interface, you can fit that in an access vector
> without xperms; else you could use xperms for that purpose. WRT
> xperms, it's just a matter of mapping each interface to
> an integer index which likely already happens and then using that to
> generate a mapping for policy writers to use.

I should note however that we largely moved away from that model for
the successors to DTMach/DTOS, splitting out separate class/permission
definitions and responsibility to the individual object managers.
Checking the "service" permissions in the auto-generated IPC wrappers
or subsystem has its own set of limitations, e.g. the object manager
will not yet have looked up and potentially locked the underlying
object in question.

>
> [1] https://www-old.cs.utah.edu/flux/fluke/html/dtos/HTML/dtos.html
>
> > [1] https://github.com/systemd/systemd/issues/8846
> > [2] https://source.android.com/docs/core/architecture/hidl/binder-ipc#n=
ames
> > [3] https://man.archlinux.org/man/apparmor.d.5.en#DBus_rules
> >
> > Thoughts/suggestions?
> > Rahul
