Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C663AE6FD
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942233; cv=pass; b=W0ONLXMPPVCg0Cdq7Qt0r8sq8XjaWAZftZlmejY6hPhS5qSfa51RXs+qRPA+zZ/djccFwgLX965whu+RO10CA4591ahaL7l55vZCPyXR29x+YtAMHkecoUPYvIGVyY0Yqn7g2c3/AeEpIAjKfthrP0dX2yCTOHOTQrI9A1U3XL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942233; c=relaxed/simple;
	bh=cMC2g4Xg+xSxSQLh1eR9Fp5EfnWD1AhAGMZ9yHvFXs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZqUlGdkS6vU2X6dINErT4Jh7R+K+dqGYnu5F+j0jFplm/ei7iJwEG8/kgsBGUYMwsNWIMmqC0QhcG+8whUs/jGZ1FuuHPFt15u6HhNNLD4IOSUH9RcUUg3xv0DO8ChUp+2i/3TyEKsxAwIarTaXb/q67g0EaI8++njQ1kymF98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C3eBBqCB; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C3eBBqCB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1408761a91.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 11:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787942230; cv=none;
        d=google.com; s=arc-20260327;
        b=BHeB1eE3cFA/saw5vpeqpl/k/8oOJaVSOYwnGvhLmHoQWpGOm3QKHHV3Freb/J1nNc
         kiJoxdM2JDtXmcqIUOARa+briLHYbBbZ4mlh+pC78HPP8l87sccmvzYly/j2iaEjMFHr
         P8EGpYVveR9VQgRyl9U9lqbfZuMAyRDBelDH4R5V0LcJlyimsYBz46y9RREJw0BaUfBp
         +HA7cFgjGKnTh3z84XG7Dz5k7A4+BXPJl/nPex0YIkK55thG99grBOKKUEbtXA5JdEaK
         SZG7QSzuiWest469kHKnrXtznrOHqMv8ThFnl3tg83Kuy62kMvwIGw1gj0wGcz+GL/hj
         YO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7J2kj2JZzo8Sy/9/EZa4+zq2hlHw7ZyjA2qjTDjNC0c=;
        fh=dP9Hgs75KO+Fi79Dm9voEzIC8/t1QkCBx7c5SwlCMpk=;
        b=J3G4s857SCSXigmilV/zG7ZVPGaSyLZAIjLkr0kBRs+ki7WEdkGrfk2tI0G/wJJTC0
         fbPzceX6er+rJ7/SXQ/KzIxU+e3AxTFS6A25A1Jyj/6c/FByJR/gN3nWgzJx+U20em6n
         quGQ7KTuAJzXua3mBU5AI31RQANhCS3LRkRkCBME7X4rdeq31NNtQWxWpdX8uQz3MAOQ
         0U5XEvR3JWYc1BcB0nuFlzxKTtOYi5pC5NmP+Q3f2fuMGOWR9HziZMe3i3PbpGifVlhF
         2hnQilkcWmTs6k50Tfu0SEJX0iTmD6FidchoDZQs68dfDjeFCcs9bTWHlSOEvl3dCHd1
         EDcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787942230; x=1788547030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7J2kj2JZzo8Sy/9/EZa4+zq2hlHw7ZyjA2qjTDjNC0c=;
        b=C3eBBqCBOjKUFK+9EH6cDzBSy04ULJ+iSRfmN0huKyIshdToE/8zi7hv0X3UrOZVkW
         AVC4nneEdvx7VeqXclOnrjhAM7rHHVvY5fIvH89ZQeB/TdFo9qhP6hoDs5zbhajD/dk2
         gqtNGlTcFzrnOB7UpM4sIFNzRSm7i9Fh4VaUVzNsxD1d9mypouWCqTi/kmVlNv4vZUcG
         LvFoXDRpVeXn6BmuqxOHX4x586GijJLLkHRwyx0XjGmKeXDaxr3mJpshTeKO+zwepyVS
         VySQfutfipGpn7uwxGShmpld7JY/YAEAPJab8CAIRm0Ia0BcSY1eEM9wc1rTteG5fzOx
         Vgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787942230; x=1788547030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7J2kj2JZzo8Sy/9/EZa4+zq2hlHw7ZyjA2qjTDjNC0c=;
        b=TzcOFofEt2a3VjQ0j1l9enUFSCB7xS3Xa/aPJ4SrN/hivcA+mPtfnSoB6kadwjsGhR
         sLeOzyC9oeet7fKZUlvdXZ4vid7juMOiFgYAflZJtMr6c6EGtSy4Nvj7kRWt7H5aMQMp
         3uLEAElf9vMgPyr5a7dD0Xj8KIPc5D7ti1RG8utU4g284uGzCYbG5r5tIulRmPcOicPj
         BggwxeH9/ktakBU9v75wQBJ6m4tUBSgvA0mXoy4x39YzMY9A5EulhUA/Ysrl7bFD48Nd
         DL44bQJ+JNbEueGh7K8kU3vRL+vpH9LLLUZhxeAIJSfHcr94qncHmYsE8vyiZWJlxEMx
         o1pA==
X-Forwarded-Encrypted: i=1; AKwUvBx10HahALcM8VVYdlJY5dVjOTAyWHVjUtNr9diK5C12zMzmB8yNOrEm7/EVRqdgXeooakSR3gnW@vger.kernel.org
X-Gm-Message-State: AFuF++lrqjWyn9sFaL+wNVrlN6BDNd2B9hICcwM9KDRlrMlzw1PIhIb4
	Lj6Y2IobvRrVLAgxP4Uob87XKN8XUXM076oPBOeIjacWbeRYM5pr/BCSI/o+HX5v7EEjdAzRBxB
	jpHAeywsvws5Vz/0UEpx3DmdsVsQzOXx+Ept40Wdj
X-Gm-Gg: AYBFou0uf5I6c0XbtgKK4oGl6W8rHgBeyX8khvF+q2o2pf8hsaBPjnsYQxWTlVBrR97
	osDaCL7LQUJ7r2F6dSt6WhFf1Sser3Nm/V3UV0ZecDgOodkWHvhpGKUcr35Sz7VCV5E3M3gVkmo
	+LzTaHnOEnZc9huRR1FmtX6vJD+rs/1/S6/8ShDr4fhorGoud25n0YrIPAsmJbaHkm/EQx/DL7U
	ciiBcoo3wtTqW575l+PWKVs+G3kSAnDvupwB6W5udxxvxkidGxJtKEUibaagUVxTlWlRnxuCm+/
	jE965bgfXaxL/HUvDoAvVPihFvnQV338DqE6qFxy9MZ1+vxSzK/usk0=
X-Received: by 2002:a17:90a:1049:b0:398:9be6:f99a with SMTP id
 98e67ed59e1d1-3989be6fae0mr1827904a91.25.1787942229889; Fri, 28 Aug 2026
 11:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
 <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
 <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com> <CAEjxPJ41irF+1T=ntzL5pB2UMBAWDv3yMwtSJB69J_tvq=Ao9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ41irF+1T=ntzL5pB2UMBAWDv3yMwtSJB69J_tvq=Ao9A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 14:36:57 -0400
X-Gm-Features: AcwNN1XZ5rfKGIlyuOn20vt6_vzqO6jmerCr_zIyBZ8T78p3KWD1sZm7rTd_1Tk
Message-ID: <CAHC9VhQU4VUac7DqC6FLYbH8-BV+uYivnncTQy5KV+cKpCd4aQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:32=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 28, 2026 at 2:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Aug 28, 2026 at 9:13=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Fri, Aug 28, 2026 at 8:23=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Aug 27, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > On May 28, 2026 danieldurning.work@gmail.com wrote:
> > > > > >
> > > > > > Add implementations of the namespace_init and namespace_install
> > > > > > hooks for SELinux. Corresponding permissions are defined for ea=
ch
> > > > > > hook (create and setns, respectively). Additionally, mount
> > > > > > namespaces have a create_anon permission to control anonymous
> > > > > > mount namespace creation separately. New security classes are
> > > > > > defined for each individual namespace type to allow granularity=
.
> > > > > >
> > > > > > In namespace_init we check the caller's SID against itself. Whe=
n
> > > > > > a namespace is created the SID of the caller is saved in the
> > > > > > namespace security blob. This SID is checked against the caller
> > > > > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > > > > ns_common is pointing to an init namespace, since these are
> > > > > > created before policy load and will be lacking a security blob.
> > > > > >
> > > > > > Requires Christian Brauner's revised namespace LSM blob patch
> > > > > > and Micka=C3=ABl Sala=C3=BCn's v2 LSM namespace audit data patc=
h, which are
> > > > > > the first 2 patches in the series linked below.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-security-module/20260527181=
127.879771-2-mic@digikod.net
> > > > > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Added the create_anon permission to separately control creati=
on
> > > > > > of anonymous mount namespaces
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Rebased onto v2 of the LSM namespace blob/audit data patches
> > > > > > ---
> > > > > >  security/selinux/hooks.c            | 69 +++++++++++++++++++++=
++++++++
> > > > > >  security/selinux/include/classmap.h | 12 ++++-
> > > > > >  security/selinux/include/objsec.h   | 10 +++++
> > > > > >  3 files changed, 90 insertions(+), 1 deletion(-)
> > > > >
> > > > > This looks good to me with the exception of one thing (below).
> > > > >
> > > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.=
c
> > > > > > index 95d0fb20d84e..94ef03b65e9a 100644
> > > > > > --- a/security/selinux/hooks.c
> > > > > > +++ b/security/selinux/hooks.c
> > > > > > @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struc=
t inode *inode, struct lsm_context *cp)
> > > > > >       cp->id =3D LSM_ID_SELINUX;
> > > > > >       return 0;
> > > > > >  }
> > > > > > +
> > > > > > +static int selinux_namespace_init(struct ns_common *ns)
> > > > > > +{
> > > > > > +     struct common_audit_data ad;
> > > > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > > > +     u32 sid =3D current_sid();
> > > > > > +
> > > > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > > > +
> > > > > > +     nssec->sid =3D sid;
> > > > > > +     if (ns->inum =3D=3D MNT_NS_ANON_INO)
> > > > > > +             return avc_has_perm(sid, sid, sclass,
> > > > > > +                                     MNT_NAMESPACE__CREATE_ANO=
N, &ad);
> > > > > > +
> > > > > > +     return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, =
&ad);
> > > > > > +}
> > > > > > +
> > > > > > +static int selinux_namespace_install(const struct nsset *nsset=
,
> > > > > > +                               struct ns_common *ns)
> > > > > > +{
> > > > > > +     struct common_audit_data ad;
> > > > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > > > +     u32 sid =3D current_sid();
> > > > > > +
> > > > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > > > +
> > > > > > +     if (!nssec)
> > > > > > +             return avc_has_perm(sid, SECINITSID_KERNEL, sclas=
s,
> > > > > > +                                     NAMESPACE__SETNS, &ad);
> > > > >
> > > > > In which cases do we expect to see "nssec" equal to NULL?  If thi=
s is a
> > > > > possibility, shouldn't we be checking for the "ns" parameter to b=
e NULL
> > > > > and not "nssec"?  I'm asking because selinux_ns() shouldn't ever =
return
> > > > > NULL, and if the "ns" parameter has a chance of being NULL then w=
e risk
> > > > > a crash from the dereference in selinux_ns().
> > > >
> > > > From the patch description:
> > > > "We fall back to SECINITSID_KERNEL if ns_common is pointing to an i=
nit
> > > > namespace, since these are created before policy load and will be
> > > > lacking a security blob."
> > > >
> > > > To be more precise, those init namespaces are created before
> > > > LSM/SELinux has initialized IIUC.
> >
> > Forget the description for a moment and look at the code.  Perhaps I'm
> > just burned out and missing something obvious, but I'm not seeing a
> > path where "nssec" is ever NULL (without some dumb luck).
> >
> > With "nssec" being defined by the following line:
> >
> >   nssec =3D selinux_ns(ns);
> >
> > ... and selinux_ns() being a fairly simple function:
> >
> >   ns_security_struct *selinux_ns(ns_common *ns)
> >   {
> >     return ns->ns_security + selinux_blob_sizes.lbs_ns;
> >   }
> >
> > ... if the "ns" parameter passed to selinux_namespace_install() is
> > NULL, the kernel will crash out in selinux_ns() due to the bogus
> > dereference.  If "ns->ns_security" is NULL then the return/"nssec"
> > value is going to be non-NULL but very wrong.  The only way I can see
> > nssec being NULL is the dumb luck case where "ns->ns_security" is NULL
> > and the "selinux_blob_sizes.lbs_ns" offset happens to also be zero;
> > here "nssec" will be NULL, but we can't rely on that.
>
> I think that would be the default at the moment so likely what he was tes=
ting.
> But yes, agreed - we can't rely on that.
>
> > > If we wanted to fix that, we'd need the patch that introduces the LSM
> > > hooks for namespaces to also update security_init() to alloc the nsse=
c
> > > for the initial namespaces, maybe?
> >
> > Somewhat independent of my concern above, but yes, that's probably a
> > good idea regardless.  Assuming that the namespaces are properly setup
> > before the call to security_init(), call lsm_ns_alloc() for each
> > namespace in security_init() and then each LSM can initialize init's
> > namespace blobs as necessary in their own init function, e.g.
> > selinux_init().
>
> Ok, I've lost the plot on that patch - where is it at this stage?

Merged in lsm/dev-staging with the expectation that it will move to
lsm/dev next week after the merge window closes on Sunday (it's in the
LSM tree as both Landlock and SELinux have pending patches that depend
on those hooks).  If you want to submit a patch to allocate init's
namespace blobs in security_init() (which would be very welcome) go
ahead and base it off that branch.

--=20
paul-moore.com
