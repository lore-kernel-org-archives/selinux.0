Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0623ABD8C
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919874; cv=pass; b=mANPSbNA23i9F2lfGDv16xbTm6yDRnsvo0EwVoZy2/NhgYnq1gywkoUcHdW7VUaDmv6OgLctr1r4F1n8bWoKh03l/ilcV01pDhkHhQVIrdO023yL4Z+xY4JCcCh7j1Uakxd5Yk+QYBiMD5qOBCnl1mR3/N77WZVjpfxjtNa3LkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919874; c=relaxed/simple;
	bh=ValqcIN00owC661uYdNThFFAStPexfEVqVYHMDR9RQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2TBNsejVE+lTnATTO6dvbZszNrZjnHolyVXg1CJgc23l3VxoSad/PkHP/zBs6T6rc5R7JUNAwNLlaoTN5wsG4Aj7378ZofpGrdcpaQrBBnZQnOw0U09R6EUeOV26cgU6nrb7UKrEzMqmrSB2mczhXqADQtCR2BOw6bGfIXjwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG1Vjjrv; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG1Vjjrv"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-455ca262ccbso726806fac.1
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 05:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919849; cv=none;
        d=google.com; s=arc-20260327;
        b=Ua/wHRs346amXzHBrsy1kXYdzEP6c3MiGjecbB/JtNIH6gPRfidJOVDaIkdPS6WqCD
         8j2/GRpP3KUjzbt1UrzSD9nb3cy1XaKA8A6cypkFQd1yskQVLmciFyb0j3jQql6VPiJS
         VrGPrtbY1H+zHVtCkQoW3rmszX7Oe48aadRIXvqPK0subXh+33EYksvayLjU3SlS3/Fb
         qdxZPkoZTzU1wdqJRVZQwvxoOxl2QlYTC3Hm+U///Z3ODWmufr9msd85IkSNzpmwkYjh
         ++QZsiEJJKbnfe9jNg13AYmZl9WsCPx8oXUrCShA1bN0PoKfHbeyjQqk+GcZHp0LUDlI
         fFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2EPJqqg6HmV8mwMtbFPLSYz6WdaV6grmJ0TkULQFBs=;
        fh=9jAbEv5JSeYVAxdvs/iM2WOoaHOyg2Mu3s+jEtkWjsM=;
        b=oD9CFJqqYHSbOOVMq0RiHZgpwxiONQjf6ZCOUS9Swcz93BtiBJRveYSt9hsKfVijtF
         WPD2K6YA0OlkL8VMrgXnWLhwQnVmn9uJBv8H+u9UxanYnnubbWxnK8/MHcHKkHup5tIp
         pOuNnqqM53pqJpfSq06JcrUTtWD3Ug4oDw69pFmEAoxH/aAWlGDr04HTBDuDm7YXrWmE
         jbhpmdR3lpY++4dt3chTzlGH8Rtm10b7+547+Uoy5RNSumgphcLZN+JLVtWpd5lS/UX3
         rL8dESddameasRqo3pGVY/3EzcDPCIvy6WfFfwjawJh3/1jOwuX/0InLDOXUTrDp+D4o
         S3sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919849; x=1788524649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2EPJqqg6HmV8mwMtbFPLSYz6WdaV6grmJ0TkULQFBs=;
        b=UG1Vjjrv2W8TueLkV7oHjEdK/FAKm9Yc7K2IMYOnQqgG+wmM2uk3s87CvoMn56So4D
         qOhU/CgMKuXBaLy1LZutDkjVtKQoYfvwXpHdZVQlmtAAq3pDE9+USbtI1lx7exglkf7D
         LiSNwwk5ryGuDgL+y5NjWoUS8eBgEdEVdF4kR8Hb05yH0pHo9rMsyog9XqQ2KmJd6fgX
         Dv0/3iXEMbzrvjOlhnhWIqsSoClm4GsVGvvEQCY56b/PgqT7ke8KSR0wYtWtPlqe5Zjm
         YCtBgZy1/layy0U/nosAAElZR69XSB8VRuLg+25AULJF8iwC85DE5E5ZAYO1TH+/Q5v8
         MEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919849; x=1788524649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2EPJqqg6HmV8mwMtbFPLSYz6WdaV6grmJ0TkULQFBs=;
        b=jkpXjCrjyo7QL+gfQJhE58NEYTGT68jP3TinqYGvUIRJF7iyjB86ojEluvJRq2jcOn
         rhy1h04QNnrh75kEv25A1M0p1JYB5vP0+V01thh5XdL24qBZJXqyqBr2mCZ2qtm0FXGh
         RkbrCMIddzrbTz0GnwJ5CUyZOIUk/ffqj1+plpIYIO8kBVfV8C+rstv9dY8hDiQ7reFD
         SLZzUz7ICHHECfVyaTMZ1d3joWGsHLY4OA1qJG3miG/7a8S4N0UF6TZiA4I+Mg9q9goR
         HZqyoc4QAK07solgEMvhVhujB25yBfpe7w0lXTPhKwxTI/CpRaDxVQaCLV+wvJhTSkQ2
         tQIw==
X-Forwarded-Encrypted: i=1; AHgh+Rojg8zg8r33qhBUzYO/WiSgoN31zs/GVFaq34WiRDpcNRMnqDSR+KL5Rlak5+mfGYF2O83HZCYb@vger.kernel.org
X-Gm-Message-State: AFuF++k3SUS6uZF77Vm01ccTsSODo/bEJ1uRHplo6ewwLeZaxee4DDpi
	k4EOxyUQAgyS670SKciwSLGd/NMgZkxkrd4Cx6JFkhQZB6aKQKBh0ZZcRRCKnvDWxyrQYc/0FTX
	ejYnU/Hi9bIdj8FMhNQciXcA+RyjPDlk=
X-Gm-Gg: AR+sD10d4bl/BuJB3dJUaPOq9SRh/QKiiwcl3CnOW/1RqOufFHMrCUOS8adrZc6cyto
	BplCOFG3UtYBaD4o0BN9YlOCbbJBwkIcUSo2T1YigJa2I1uBQXqLZnkDpX4MyqWQERIg3RTQ+VM
	BkdNqAgVICsuDI7+mqP4wCWpUb3tAMKx/9JHX2E8/Lsz3xBlEups2tT1WXuO446y73bpnoCxngK
	zcoboiAireuEkXiv9Okp+EHPbQ9gcXp785b2qZ+ON6Bmy856rO8GZzNhOIKnU920dvU6Y0TmBnp
	73e3YSkl9iPHxCtXZ7CVLkGCkQLV27fbAkV2xkI9KtKJ
X-Received: by 2002:a05:6870:17a7:b0:468:2c18:a031 with SMTP id
 586e51a60fabf-4683734b9b9mr6966250fac.12.1787919848723; Fri, 28 Aug 2026
 05:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com> <876b917a5d999b14351073aba6aece2d@paul-moore.com>
In-Reply-To: <876b917a5d999b14351073aba6aece2d@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 08:23:57 -0400
X-Gm-Features: AcwNN1XxCx40NZZXEvkt0IVnGzyC_cibGP0s_BfH41b-vw_0ysI0teCsjnEqYUI
Message-ID: <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 28, 2026 danieldurning.work@gmail.com wrote:
> >
> > Add implementations of the namespace_init and namespace_install
> > hooks for SELinux. Corresponding permissions are defined for each
> > hook (create and setns, respectively). Additionally, mount
> > namespaces have a create_anon permission to control anonymous
> > mount namespace creation separately. New security classes are
> > defined for each individual namespace type to allow granularity.
> >
> > In namespace_init we check the caller's SID against itself. When
> > a namespace is created the SID of the caller is saved in the
> > namespace security blob. This SID is checked against the caller
> > in namespace_install. We fall back to SECINITSID_KERNEL if
> > ns_common is pointing to an init namespace, since these are
> > created before policy load and will be lacking a security blob.
> >
> > Requires Christian Brauner's revised namespace LSM blob patch
> > and Micka=C3=ABl Sala=C3=BCn's v2 LSM namespace audit data patch, which=
 are
> > the first 2 patches in the series linked below.
> >
> > Link: https://lore.kernel.org/linux-security-module/20260527181127.8797=
71-2-mic@digikod.net
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > ---
> > Changes in v2:
> > - Added the create_anon permission to separately control creation
> > of anonymous mount namespaces
> >
> > Changes in v3:
> > - Rebased onto v2 of the LSM namespace blob/audit data patches
> > ---
> >  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
> >  security/selinux/include/classmap.h | 12 ++++-
> >  security/selinux/include/objsec.h   | 10 +++++
> >  3 files changed, 90 insertions(+), 1 deletion(-)
>
> This looks good to me with the exception of one thing (below).
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 95d0fb20d84e..94ef03b65e9a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct inode =
*inode, struct lsm_context *cp)
> >       cp->id =3D LSM_ID_SELINUX;
> >       return 0;
> >  }
> > +
> > +static int selinux_namespace_init(struct ns_common *ns)
> > +{
> > +     struct common_audit_data ad;
> > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > +     u16 sclass =3D ns_type_to_security_class(ns);
> > +     u32 sid =3D current_sid();
> > +
> > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > +     ad.u.ns.ns_type =3D ns->ns_type;
> > +     ad.u.ns.ns_id =3D ns->ns_id;
> > +
> > +     nssec->sid =3D sid;
> > +     if (ns->inum =3D=3D MNT_NS_ANON_INO)
> > +             return avc_has_perm(sid, sid, sclass,
> > +                                     MNT_NAMESPACE__CREATE_ANON, &ad);
> > +
> > +     return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
> > +}
> > +
> > +static int selinux_namespace_install(const struct nsset *nsset,
> > +                               struct ns_common *ns)
> > +{
> > +     struct common_audit_data ad;
> > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > +     u16 sclass =3D ns_type_to_security_class(ns);
> > +     u32 sid =3D current_sid();
> > +
> > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > +     ad.u.ns.ns_type =3D ns->ns_type;
> > +     ad.u.ns.ns_id =3D ns->ns_id;
> > +
> > +     if (!nssec)
> > +             return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
> > +                                     NAMESPACE__SETNS, &ad);
>
> In which cases do we expect to see "nssec" equal to NULL?  If this is a
> possibility, shouldn't we be checking for the "ns" parameter to be NULL
> and not "nssec"?  I'm asking because selinux_ns() shouldn't ever return
> NULL, and if the "ns" parameter has a chance of being NULL then we risk
> a crash from the dereference in selinux_ns().

From the patch description:
"We fall back to SECINITSID_KERNEL if ns_common is pointing to an init
namespace, since these are created before policy load and will be
lacking a security blob."

To be more precise, those init namespaces are created before
LSM/SELinux has initialized IIUC.
