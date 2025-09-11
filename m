Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343331D364;
	Thu, 11 Sep 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599270; cv=none; b=dlfNAKr+BrIULcZ0hfNeQ0SYlueTF/kLxJgRC48+HyV9O0cUaV2ZSnfnA3Rr2QimC/Nbtw9LW3CdImcH7P5DsUaKSNnL/MeAgazrocts+lufVVnq4iHbTbrxDWZ6EV4U94oELT8nUE7APc3V1WFWwZIGvmliHs6jbuIDr7R2v2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599270; c=relaxed/simple;
	bh=5FQciLyfkw/1Nr/g4wrbD+FlhUHdnpLTO3NpsbXz4WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irFLtzqikBbD+nuusTD6UEpCeRVj7tn/kl1GVKC9f5PhgiphnAc2AKJctrnGwbHtsVD8OT8HjRgdT7HSZ8WfcWJIoGeHmufc4GqrffGlR05tYLw9IUyE+9Ud//d24psefdNpaNFcuVNKFUeNOmm2Lj381sBCsv8XJJQ/7txOtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7kJ0qRn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7kJ0qRn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so842327a91.2;
        Thu, 11 Sep 2025 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599268; x=1758204068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHkD6BwVLYAFhBmfkzAvqjPu6AQAFcmIArg7IqukgJ4=;
        b=V7kJ0qRnYAbMSU80mtTXks8COuCImWl6LDrxAnRcg0gi2N9IS1geE1EqmW1fzAz8eJ
         C4KEbkNVwB4xUDP2mZRKWgA7vOzJwTLCh+9tSaRZxrjuByVpm176mT28GnOy8LQxpyaL
         Aa9V97oE1f0OozFrctzRSfaUD4Vc4rPrqkllAEHM58+6BX83D7u1FvfeKPt5MIMHCCZh
         MP5pyQBBBXiXEXPk1G2nrrT/i8uXNor0MC9kwsaA3qYKeYtW1CzRj+60xhjv8zejOisS
         5UYSFDxGYfp7wRLtHNL/D0DlTrA6uCC1OgBfLSjeReFXIPzTFe06nO41ChQbG4mwoG/t
         pbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599268; x=1758204068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHkD6BwVLYAFhBmfkzAvqjPu6AQAFcmIArg7IqukgJ4=;
        b=hVPSPleilRN/ubCji8O2gzKUWtvnUa6z85x+oUH714InbLY6BjEyVPACHVRPX5pt96
         srhkhi6EQ5ufQ8w5aucR8tWjs36c7TKWPB1hQatBVVQvfm35oT5iNPVBqWVN8rWLiq29
         beJXOPqwSD0Zfo8rf2cvubcqL77Pon18QRGxq404P0UelmTJS9QpdwZEhJ8IXompk6YA
         hqeuOvuWfAgl9Mlj6wjzZJWbe/tOawJyPWp5vr5ebNz12MLKzV/d4InvOI9WXuuDvzWy
         iq/ybPN94A6QSrXXvwRuwwurY2YQLjCPfFhhuSSxUR9RK9PCzcsWFuV6Nih4BqGWGyNt
         J64w==
X-Forwarded-Encrypted: i=1; AJvYcCUSvPQGZXb3KloVpeg8IdP31xE93Zx1TY4Dn4wvjD+CSin9G+Rf1RRn2HAFgE0c6cW3l2hHIpesUqP57Va7t7UA+xqdb9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7y8FTDvakNbETdpBF/BGhkB1ImA6v/JApVmm15c+faF4mts47
	AaLtZLaeeV/mzBH+4A7vyCHhEAYouGqXA49/ESlzR0GJ8RUTlGURjieJALaVje1nX3oaVEW5ibJ
	Jxr7XVJZCmKSbZ0xPwRHcZvOm3Dxapo2l7A==
X-Gm-Gg: ASbGncuCCEucYk3fb9BLwc924wQuyEfDvdWM6960K3LSK8uoxbhwMjz+tqMKHYj0Plt
	2PXgK/dd4RxTOSbt5x6q92Yq2uKF2BqWlX7e/6UzKwf+sVNLK1yLX73JalMx6sgzklFi1rRtU3C
	IvcdZqu3NEvXh0fq2DgjM3fuVv2qxHQqZtZ214XRrFc845ay5r2io2lkdm/QyZqzsvBGDm1xpJN
	3mpot+N+r5kCatGZQ==
X-Google-Smtp-Source: AGHT+IH/dWW4EKJBkVryXIwBS6BMHWnT8oPFCrQ0gryxM+nteBI4BRTfwS2r0Mg9rMjPDn3vYy+Bfydna3x7e3Qg6ps=
X-Received: by 2002:a17:90b:530b:b0:32b:d502:6ff2 with SMTP id
 98e67ed59e1d1-32d440d9ef6mr20800901a91.34.1757599267610; Thu, 11 Sep 2025
 07:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com> <CAEjxPJ4ctFLY=_AUaNso_a4XJ8AziRoebR2ExFss_s3qNnYhJA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ctFLY=_AUaNso_a4XJ8AziRoebR2ExFss_s3qNnYhJA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 10:00:56 -0400
X-Gm-Features: Ac12FXxWUUn29ZLHOZgrL2I0MAvmSseRHp90xpNMa3a1GNFASB75iSpoaKpc8lc
Message-ID: <CAEjxPJ695zmnpiLLOHkLxt5HVPhFNRZ9Bu+o4khvFwFX3TLpVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com, 
	serge@hallyn.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:41=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 3, 2025 at 3:28=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > In the hopes of nudging the conversation in [1] in a more focused
> > direction with a goal of getting SELinux namespaces upstreamed, this
> > RFC provides a starting point for a concrete discussion. This is RFC
> > only and has only been build-tested thus far.
> >
> > This defines a new LSM_ATTR_UNSHARE attribute for the
> > lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
> > the underlying function for unsharing the SELinux namespace. As with
> > the selinuxfs interface, this immediately unshares the SELinux
> > namespace of the current process just like an unshare(2) system call
> > would do for other namespaces. I have not yet explored the
> > alternatives of deferring the unshare to the next unshare(2),
> > clone(2), or execve(2) call and would want to first confirm that doing
> > so does not introduce any issues in the kernel or make it harder to
> > integrate with existing container runtimes.
> >
> > Differences between this syscall interface and the selinuxfs interface
> > that need discussion before moving forward:
> >
> > 1. The syscall interface does not currently check any Linux capability
> > or DAC permissions, whereas the selinuxfs interface can only be set by
> > uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> > capability or DAC check should apply to this syscall interface and if
> > any, add the checks to either the LSM framework code or to the SELinux
> > hook function.
> >
> > Pros: Checking a capability or DAC permissions prevents misuse of this
> > interface by unprivileged processes, particularly on systems with
> > policies that do not yet define any of the new SELinux permissions
> > introduced for controlling this operation. This is a potential concern
> > on Linux distributions that do not tightly coordinate kernel updates
> > with policy updates (or where users may choose to deploy upstream
> > kernels on their own), but not on Android.
> >
> > Cons: Checking a capability or DAC permissions requires any process
> > that uses this facility to have the corresponding capability or
> > permissions, which might otherwise be unnecessary and create
> > additional risks. This is less likely if we use a capability already
> > required by container runtimes and similar components that might
> > leverage this facility for unsharing SELinux namespaces.
> >
> > 2. The syscall interface checks a new SELinux unshare_selinuxns
> > permission in the process2 class between the task SID and itself,
> > similar to other checks for setting process attributes. This means
> > that:
> >     allow domain self:process2 *; -or-
> >     allow domain self:process2 ~anything-other-than-unshare_selinuxns; =
-or-
> >     allow domain self:process2 unshare_selinuxns;
> > would allow a process to unshare its SELinux namespace.
> >
> > The selinuxfs interface checks a new unshare permission in the
> > security class between the task SID and the security initial SID,
> > likewise similar to other checks for setting selinuxfs attributes.
> > This means that:
> >     allow domain security_t:security *; -or-
> >     allow domain security_t:security ~anything-other-than-unshare; -or-
> >     allow domain security_t:security unshare;
> > would allow a process to unshare its SELinux namespace.
> >
> > Technically, the selinuxfs interface also currently requires open and
> > write access to the selinuxfs node; hence:
> >     allow domain security_t:file { open write };
> > is also required for the selinuxfs interface.
> >
> > We need to decide what we want the SELinux check(s) to be for the
> > syscall and whether it should be more like the former (process
> > attributes) or more like the latter (security policy settings). Note
> > that the permission name itself is unimportant here and only differs
> > because it seemed less evident in the process2 class that we are
> > talking about a SELinux namespace otherwise.
> >
> > Regardless, either form of allow rule can be prohibited in policies
> > via neverallow rules on systems that enforce their usage
> > (e.g. Android, not necessarily on Linux distributions).
> >
> > 3. The selinuxfs interface currently offers more functionality than I
> > have implemented here for the sycall interface, including:
> >
> > a) the ability to read the selinuxfs node to see if your namespace has
> > been unshared, which should be easily implementable via
> > lsm_get_self_attr(2).  However, questions remain as to when that
> > should return 1 versus 0 (currently returns 1 whenever your namespace
> > is NOT the initial SELinux namespace, useful for the testsuite to
> > detect it is in a child, but could instead be reset to 0 by a
> > subsequent policy load to indicate completion of the setup of the
> > namespace, thus hiding from child processes that they are in a child
> > namespace once its policy has been loaded).
> >
> > b) the abilities to get and set the maximum number of SELinux
> > namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> > maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> > node). These could be left in selinuxfs or migrated to some other LSM
> > management APIs since they are global in scope, not per-process
> > attributes.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Gentle ping on this RFC, happy to update and re-submit whenever.

> > ---
> >  include/uapi/linux/lsm.h            | 1 +
> >  security/selinux/hooks.c            | 8 ++++++++
> >  security/selinux/include/classmap.h | 4 +++-
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> > index 938593dfd5da..fb1b4a8aa639 100644
> > --- a/include/uapi/linux/lsm.h
> > +++ b/include/uapi/linux/lsm.h
> > @@ -83,6 +83,7 @@ struct lsm_ctx {
> >  #define LSM_ATTR_KEYCREATE     103
> >  #define LSM_ATTR_PREV          104
> >  #define LSM_ATTR_SOCKCREATE    105
> > +#define LSM_ATTR_UNSHARE       106
> >
> >  /*
> >   * LSM_FLAG_XXX definitions identify special handling instructions
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index c544b3e2fd5c..11b0b3c5b74a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6812,6 +6812,10 @@ static int selinux_lsm_setattr(u64 attr, void *v=
alue, size_t size)
> >                 error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PR=
OCESS,
> >                                      PROCESS__SETCURRENT, NULL);
> >                 break;
> > +       case LSM_ATTR_UNSHARE:
> > +               error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PR=
OCESS,
>
> Ignore the obvious typo here (should be SECCLASS_PROCESS2 above). Will
> be fixed before submission. Otherwise, the RFC remains the same.
>
> > +                                    PROCESS2__UNSHARE_SELINUXNS, NULL)=
;
> > +               break;
> >         default:
> >                 error =3D -EOPNOTSUPP;
> >                 break;
> > @@ -6923,6 +6927,10 @@ static int selinux_lsm_setattr(u64 attr, void *v=
alue, size_t size)
> >                 }
> >
> >                 tsec->sid =3D sid;
> > +       } else if (attr =3D=3D LSM_ATTR_UNSHARE) {
> > +               error =3D selinux_state_create(new);
> > +               if (error)
> > +                       goto abort_change;
> >         } else {
> >                 error =3D -EINVAL;
> >                 goto abort_change;
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index be52ebb6b94a..07fe316308cd 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >             "siginh",       "setrlimit",     "rlimitinh",   "dyntransit=
ion",
> >             "setcurrent",   "execmem",       "execstack",   "execheap",
> >             "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
> > -       { "process2", { "nnp_transition", "nosuid_transition", NULL } }=
,
> > +       { "process2",
> > +         { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
> > +           NULL } },
> >         { "system",
> >           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
> >             "module_request", "module_load", "firmware_load",
> > --
> > 2.51.0
> >
