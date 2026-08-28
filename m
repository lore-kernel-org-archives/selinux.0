Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21753793BD
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922815; cv=pass; b=G4sz7e5ZhShogL81Kc/b/rM/w08ZT2Uf0+3M0Lfq2Al4SB4c1H/azZT7Ux+02OtyZFRoScN69k/kfWSxLH+Sd8tq3syzFx4eDSLENfmtvcAqsx/1Pbu8q1pw12ePpfot6byGtSAIv8rbk8M53l9kQdeJ26Shke4dQa4CHesLh6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922815; c=relaxed/simple;
	bh=OHobcmuT8MtJGjxPtpw/gOz62bABn4LJextpnHAjcxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddxNMbd2Lyj2W+PACd8JEdtymezvDUHxwuvU/XCz+lyBfja0LmXiUbbV/UVJgR2a4505lAiM2e/6UNBk6Vx8WDJ+wI27mR5jR8YuDwEREp3H3dRS2yKbG6/Vtv0fIsuy4Ec7+BG9lGX8ioeKfdr5AeT/t4B8D3PAaUFJuCUSEu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8f/fOrX; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8f/fOrX"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f48c750afcso998057a34.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 06:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922813; cv=none;
        d=google.com; s=arc-20260327;
        b=Se/1xAEODWzcBVrFQkZ+KykFLwTzGyEGRX/+e/G9BAtIKsIfC3Dw4zq4RYJrybS6vK
         kVvFJ0RwPa4/7kMrBfL/iDe/4rLvLsGpKHsBWDqfBuL9+UubMY46lukcxU8mX5doFHRf
         aHZNtYcoboUfGIIoxMIjkEdECzNiDOAw3zRzWCUolecXXu95vPzeJkWsKgxMXBWCI89T
         n5tvP0TENgUgyT2ZGkmAC2l+o2ddG+7BXBWcnAG/bdt8yS86PdHDDCaSza9yYmtL1j3H
         x5pGG9B2RHnZxrlhtoYkpmJ4bBV+OpDNkpIzuMXBf7YGyggushgi2/7qe5VmAFG2VHrU
         5Ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THitSfJACTuwgbqaWpSZiPQ+Rp2+UxENmZbYy1NnNHk=;
        fh=1KVeMFoTp5h7zfYvJaue+POkJaUcuu/Vsdgh6iV6ZWs=;
        b=YFB+Mv6KxYgEK5VuELZKr3577fAmYHpKMJdcnVHR0qdghAX/6C5ztCC3r4nq+h9sVn
         s8HMXxc8Ubtg3/GFGVfJRTAhHIzlOxdEpOdALnz7/MMdr7ttOvOLqv2oFwrQmWqPqfb6
         tLzRGawLCEXO3tve3uAN4FaMEmT8zXxGnBE8zMu+pDPQx+3HoxJN7kji0Arjo3ux64QX
         BAA98MvBSAQXmp4OoGBLjOCSxcOpvJiXmrQ1I/1alh8+8X9crfDJc320wvjgTznHCRSc
         qn93Tj9mVlrmtrPhoqr5XdrZfcK94HMs8+yLjmggCBFcfkcOoOjO85wJbc+gV0ikU4wk
         9YAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922813; x=1788527613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THitSfJACTuwgbqaWpSZiPQ+Rp2+UxENmZbYy1NnNHk=;
        b=s8f/fOrX7qkIJiCTUi4Rdc04zUBC/vetANYmSipP7vqtTvoQ4tRZ0vlUiJTumFcATV
         NYiUKvm2saXysDvhchuGbQhDjg8YBBcelOlz79XiT3AOez/K1Az3VTKQeoCthUOpZzjD
         8X3w2/voRQDLjFESbJXZFYIcVWNb6A5UylofavRUqctrtw0aj1fam08jOvFEgwHlzMsi
         wsqMMiWe45/i7XBTHbuB2pnsD0Ye2/+E09zGdVIyZ3M+ijkIjIFhNv/KeVs8uPWVv9R3
         3W8e3fFahosmozsnBvqprI8X78/d9DNbYve/dM4Bp+u3EKAIY/2wvTR6V2AW+yJMh4r3
         BoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922813; x=1788527613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THitSfJACTuwgbqaWpSZiPQ+Rp2+UxENmZbYy1NnNHk=;
        b=auMxrQGlx5iw6SIAGrKmsdmR9f1IvNj120vp6HbXpA7VNbDBGW/sC0z5+jtRJIvfsV
         byfTEQiu1WjkQCFDYw15iG5kG9gXeG/7A2EHzZlFsEoPgtPPkz2hnKPvXFQkgHM/lWDQ
         OTpgLRleT5diqDj1PErG6BX2fLHIafjPtIxqYvvCYyPPiERgrLcROxqwUHWmsNmwW4gQ
         FKqdgwf26CS4ze+gJxrmwscedx8DDlwb4na7eHffH5W6SQsbJXnvYpoYeNs/H9TRpZ+T
         bFi9BhuUmaqwdUweEmor7FeVOviA9/0zz/oZUm19rebRjHbB47NO39mzBMBgKOcPtk3a
         4Jyw==
X-Forwarded-Encrypted: i=1; AHgh+RoYgxHpRxVgE25xU8uozNw+h7PMHrU3ZOudhASfe+0DzicLYGczmxbCymYXCU0hl9x34fwtsCcH@vger.kernel.org
X-Gm-Message-State: AFuF++m61j96rRB22gSmr77AgmyXlVfq+Wamwl+Gx8+7vvH6UCV3Tld8
	Zo5vr8jcaSNmgG0H8NRw62rtM/mCVkeYvPlHGr5vPpuTG76zbhIf2IxCpOChawkRZhH9oz0bspu
	xRe2VyYnSNYHsltG3qye0KFu28qlfIAQ=
X-Gm-Gg: AR+sD10rcuKIBhmYqX6KCSBw+5TmcdztpO3hS1ZH/3P+Ymmp/sHISp2ie1t6NodTDfb
	ydp8sBSsHGbKFB/XSLPjHkRQeqq6MPwPpw9xVKacgBxScWaCBFnKV0isNeJ1xhl1cLnV0Fle/U/
	/6hBy3CQCXz2ZIttK+mOQNWxrhg62ByazuFwmcdjRDT7p5cNAL1MsT03LXaTtmwkCiYkEL4O+31
	lRSUsen87iHmEpkkTH9nQL2x2t76pufdl/uRGoM6yVlCZlswkYUyUhIf4VhArLxXYMVJEWbH7ow
	TvdIGfMajmJE2iXtW3PMwdntlQ3b3225yQ9SpQN+v3fj
X-Received: by 2002:a05:6820:83d2:20b0:6aa:db9f:6b89 with SMTP id
 006d021491bc7-6b1c668456cmr4652460eaf.21.1787922812189; Fri, 28 Aug 2026
 06:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 09:13:20 -0400
X-Gm-Features: AcwNN1U5Z7ZiJrZoNduhiCZADmmqlmmh1Rz5heytxqtHd03U9vXyQ-zmvPlGbkM
Message-ID: <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 27, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On May 28, 2026 danieldurning.work@gmail.com wrote:
> > >
> > > Add implementations of the namespace_init and namespace_install
> > > hooks for SELinux. Corresponding permissions are defined for each
> > > hook (create and setns, respectively). Additionally, mount
> > > namespaces have a create_anon permission to control anonymous
> > > mount namespace creation separately. New security classes are
> > > defined for each individual namespace type to allow granularity.
> > >
> > > In namespace_init we check the caller's SID against itself. When
> > > a namespace is created the SID of the caller is saved in the
> > > namespace security blob. This SID is checked against the caller
> > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > ns_common is pointing to an init namespace, since these are
> > > created before policy load and will be lacking a security blob.
> > >
> > > Requires Christian Brauner's revised namespace LSM blob patch
> > > and Micka=C3=ABl Sala=C3=BCn's v2 LSM namespace audit data patch, whi=
ch are
> > > the first 2 patches in the series linked below.
> > >
> > > Link: https://lore.kernel.org/linux-security-module/20260527181127.87=
9771-2-mic@digikod.net
> > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Added the create_anon permission to separately control creation
> > > of anonymous mount namespaces
> > >
> > > Changes in v3:
> > > - Rebased onto v2 of the LSM namespace blob/audit data patches
> > > ---
> > >  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++=
++
> > >  security/selinux/include/classmap.h | 12 ++++-
> > >  security/selinux/include/objsec.h   | 10 +++++
> > >  3 files changed, 90 insertions(+), 1 deletion(-)
> >
> > This looks good to me with the exception of one thing (below).
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 95d0fb20d84e..94ef03b65e9a 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct inod=
e *inode, struct lsm_context *cp)
> > >       cp->id =3D LSM_ID_SELINUX;
> > >       return 0;
> > >  }
> > > +
> > > +static int selinux_namespace_init(struct ns_common *ns)
> > > +{
> > > +     struct common_audit_data ad;
> > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > +     u32 sid =3D current_sid();
> > > +
> > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > +
> > > +     nssec->sid =3D sid;
> > > +     if (ns->inum =3D=3D MNT_NS_ANON_INO)
> > > +             return avc_has_perm(sid, sid, sclass,
> > > +                                     MNT_NAMESPACE__CREATE_ANON, &ad=
);
> > > +
> > > +     return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
> > > +}
> > > +
> > > +static int selinux_namespace_install(const struct nsset *nsset,
> > > +                               struct ns_common *ns)
> > > +{
> > > +     struct common_audit_data ad;
> > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > +     u32 sid =3D current_sid();
> > > +
> > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > +
> > > +     if (!nssec)
> > > +             return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
> > > +                                     NAMESPACE__SETNS, &ad);
> >
> > In which cases do we expect to see "nssec" equal to NULL?  If this is a
> > possibility, shouldn't we be checking for the "ns" parameter to be NULL
> > and not "nssec"?  I'm asking because selinux_ns() shouldn't ever return
> > NULL, and if the "ns" parameter has a chance of being NULL then we risk
> > a crash from the dereference in selinux_ns().
>
> From the patch description:
> "We fall back to SECINITSID_KERNEL if ns_common is pointing to an init
> namespace, since these are created before policy load and will be
> lacking a security blob."
>
> To be more precise, those init namespaces are created before
> LSM/SELinux has initialized IIUC.

If we wanted to fix that, we'd need the patch that introduces the LSM
hooks for namespaces to also update security_init() to alloc the nssec
for the initial namespaces, maybe?
