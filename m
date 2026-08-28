Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F486341
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941924; cv=pass; b=gjgev2igMAdmhGI0jc2xRfha5aWSQ1JFJv12aj8BRgXT/1GhB27kB3Nw7qxMqJuZpTqQ1aNMublyIAZpKsLtN2X/jPh9dFxi5dJD/MxXt05mByWISsSpu7lvvmaurOn8K1lWfv2ZQ5CD1aJEGsBnmo5gmw05eC7Iv/hb3sw3fZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941924; c=relaxed/simple;
	bh=l+miw9qbpn2nwJeTAxkJs/O8YHOrGA+GAOhbBRBb3ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjcUQK9KTrzKjrJO0rAQB8JCkBgHnewi2DBH6ELpATAlC81liVfbJyRQmDm9l5i53KNelGaaK4PnS/CYenhGWbIRnnO7XWOAK+kJfXypHJ0CGhsYCSv6ptbuwXGt5EIFmJGSeKmJpueAz2C8qikJTPDIR/6RNXHhKzjuD33DpDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+bQmZ5p; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+bQmZ5p"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f18c0e03e3so813241a34.2
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 11:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787941922; cv=none;
        d=google.com; s=arc-20260327;
        b=oJbPQtZ3mB8mB0ggReRw2nNOtNf4znXjHo0ejcs5AU3pIfPzJ520hJUhFtrT2c2xol
         yyTuGs08qOOTkuL18MahavAzWDY8azJE1xGd6Z4T8zLL+QhdCXaJF3JJdte9T+B8x7+7
         V0VCiMllUkr731gDPW9c8eRysLj1xOT9GfI/f37aNgYB+S+04qz+9+VMv01nHfDbekTX
         aMbCp7Xg6OUDQ3WWpVVBbK6qX8GRPKU5fQholtDLiq0yQHN2+kU89b6G7ms2IWqYw6Lh
         FLXXZgm/D95wiQBAYJr+026wIWFjemdQjHyNahPilBZ64CGDBWENrxMXYuu3VpIMBkMI
         Whbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4r+TEbwr7+fR+jjd9fDytcqLQZfp96okwVd6lMXEDo=;
        fh=k4zE9t1WxjJXDO2tWNnBC/vzzqmxrWT+s3KyOKX5rWw=;
        b=B/Ur2DeJLyAv3193Pkpj2rkup4d0ISuL2/xDqT732ufHoF+VEJTgsa3hSWgMoEC6RV
         AJx5LC1heNlQqgzIkbp8gYP/yG27yxmy1xrY7dI+zTk991CysHZML/LSF0M5qqaKn8hA
         M+0di4BnbwO8VKc94lqV7UHY7lVHsqUS8LUdIHzfgKLaeSRtiCp2LHI4LZLj8xG8Qfp+
         +DMw81dyV0Y3wunZlmzBA6DF/rWZ5+TcL/SJi1CX/Odu/FUUagksaVXtjxKczISPad4n
         X+Im+1/z8TF/c6uvmNsAZTLff/RBogRCdqbgO/ObOENlsQXFyWo68/fnP3zzY+fivRjC
         ZA+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787941922; x=1788546722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p4r+TEbwr7+fR+jjd9fDytcqLQZfp96okwVd6lMXEDo=;
        b=L+bQmZ5p1roD+xj6CfHHJmZv6mvog1gCfLAilWlju1PDjvDBToNlGpmR8JVoQGYhIT
         DSNbW+jcaMmqHXDnOgr7jzZr48j4MeP8X1nSZXo8SGHIs5Fa89p0yo0RyTperK7q9kN9
         MD2L1+0rPIkwHnVpqDGZQEUX+o+5q9CjjaVW3Cig+JvZo5KXSoLTF1CBberLdNBnZgf4
         h/hqZpgDun8a5BbAp43fP18VusPZ72T8nMMDmNjsvVtochg3xyzG/eAsLgQFXZshbhuq
         s2fUrHatbV353GVCK+LVhLrzdRlBCFfXW6w2TEtxaHyMKcEMv8b3FAyk+unCvroCVgLR
         A+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787941922; x=1788546722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4r+TEbwr7+fR+jjd9fDytcqLQZfp96okwVd6lMXEDo=;
        b=MQuhBPcOLNI/cFIvql3mdtV3shuW5a7mt/xELx/eOUKpOsxbEvuylwIiB+lHJDDkLN
         hBJ8HVBAfPMc9CclfT2zYxTlJT+7jj/QvrNHsSYR1nlEtNwmY6aApUlI4Hg12hED8atZ
         0drGnI48AGkwftLS/WOVjcUzy3pGMIsqeXVA28CY1DC3cqyb76DMjuyViV+clVEq+K2f
         t+F+nzsucs2mn2Fl8LiQLpPexJXekGvFc9KtBSsEzPPIKQsntcKrDxyOGS9rjeGF9UzU
         T1yIbuyNDn/7UVVD/WW07fa22zLbC5pfLJYl87gUajmV0ZwunYxFHj6CTRjnJiCAIXs5
         JjgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJYe1gDIdxcQ5Eqs7n4uWO02JqPANgOaCbfpdec6H6RBm3wQw/x7Vl3zcmqOPy9dxQMIkrII5m@vger.kernel.org
X-Gm-Message-State: AFuF++krrlYnlUPIaNek5bmbRAcj+f6ZAfO7MWlmWAkQXtCCERL0/ZGs
	riwxufVgwBfet6XBwnGuWYa+nMkTg0sP/XGbGpEqdNaSGITYdCV90WfB6D+n0Qp3zKMBRgxyIbl
	D2eW/BZI1FoBEogr9YFJx4R/MGx/AzFk=
X-Gm-Gg: AR+sD13wgNcFpY9M//Ek78d+SiDlVDHyIWnQ0HXxPxDGFXal7Qc+xTtJ6ymoA4yTADN
	XhvJUaP2oshh22lbdmcoNrILJFFQPbcuLj5eAJwFROqewVl5mFOa78GNj1Er9ZPg+HU/7/YEDw5
	IcePXiibEqI+lbbgOUB+7iz19+hO5JazcgApwz5tdj8AJ/gRkxNJEWPXarO/bxghM3WT3RX6S0v
	yATDoL1UGuNXS2dCpin1Os1g6w7CFRUF+k/K6Yjdre2Umbnn0MgcOnyJPNoOa5ZlQCd1Bvk3V4B
	CwWk9mwQ4lWpyp7K3YDXdEiWjd5cX/e2nB09jSdVvyIh
X-Received: by 2002:a05:6820:c3d2:20b0:6b1:d110:a05f with SMTP id
 006d021491bc7-6b1d110a2camr3303176eaf.27.1787941921775; Fri, 28 Aug 2026
 11:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
 <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com> <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com>
In-Reply-To: <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 14:31:50 -0400
X-Gm-Features: AcwNN1VkhW_1T6DCSgPXYBZIB1TAC9iE2hX9U2ILF2rmqd2wbf91_cD8T0UDwdY
Message-ID: <CAEjxPJ41irF+1T=ntzL5pB2UMBAWDv3yMwtSJB69J_tvq=Ao9A@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Aug 28, 2026 at 9:13=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 28, 2026 at 8:23=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Aug 27, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On May 28, 2026 danieldurning.work@gmail.com wrote:
> > > > >
> > > > > Add implementations of the namespace_init and namespace_install
> > > > > hooks for SELinux. Corresponding permissions are defined for each
> > > > > hook (create and setns, respectively). Additionally, mount
> > > > > namespaces have a create_anon permission to control anonymous
> > > > > mount namespace creation separately. New security classes are
> > > > > defined for each individual namespace type to allow granularity.
> > > > >
> > > > > In namespace_init we check the caller's SID against itself. When
> > > > > a namespace is created the SID of the caller is saved in the
> > > > > namespace security blob. This SID is checked against the caller
> > > > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > > > ns_common is pointing to an init namespace, since these are
> > > > > created before policy load and will be lacking a security blob.
> > > > >
> > > > > Requires Christian Brauner's revised namespace LSM blob patch
> > > > > and Micka=C3=ABl Sala=C3=BCn's v2 LSM namespace audit data patch,=
 which are
> > > > > the first 2 patches in the series linked below.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-security-module/2026052718112=
7.879771-2-mic@digikod.net
> > > > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Added the create_anon permission to separately control creation
> > > > > of anonymous mount namespaces
> > > > >
> > > > > Changes in v3:
> > > > > - Rebased onto v2 of the LSM namespace blob/audit data patches
> > > > > ---
> > > > >  security/selinux/hooks.c            | 69 +++++++++++++++++++++++=
++++++
> > > > >  security/selinux/include/classmap.h | 12 ++++-
> > > > >  security/selinux/include/objsec.h   | 10 +++++
> > > > >  3 files changed, 90 insertions(+), 1 deletion(-)
> > > >
> > > > This looks good to me with the exception of one thing (below).
> > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 95d0fb20d84e..94ef03b65e9a 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct =
inode *inode, struct lsm_context *cp)
> > > > >       cp->id =3D LSM_ID_SELINUX;
> > > > >       return 0;
> > > > >  }
> > > > > +
> > > > > +static int selinux_namespace_init(struct ns_common *ns)
> > > > > +{
> > > > > +     struct common_audit_data ad;
> > > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > > +     u32 sid =3D current_sid();
> > > > > +
> > > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > > +
> > > > > +     nssec->sid =3D sid;
> > > > > +     if (ns->inum =3D=3D MNT_NS_ANON_INO)
> > > > > +             return avc_has_perm(sid, sid, sclass,
> > > > > +                                     MNT_NAMESPACE__CREATE_ANON,=
 &ad);
> > > > > +
> > > > > +     return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &a=
d);
> > > > > +}
> > > > > +
> > > > > +static int selinux_namespace_install(const struct nsset *nsset,
> > > > > +                               struct ns_common *ns)
> > > > > +{
> > > > > +     struct common_audit_data ad;
> > > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > > +     u32 sid =3D current_sid();
> > > > > +
> > > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > > +
> > > > > +     if (!nssec)
> > > > > +             return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
> > > > > +                                     NAMESPACE__SETNS, &ad);
> > > >
> > > > In which cases do we expect to see "nssec" equal to NULL?  If this =
is a
> > > > possibility, shouldn't we be checking for the "ns" parameter to be =
NULL
> > > > and not "nssec"?  I'm asking because selinux_ns() shouldn't ever re=
turn
> > > > NULL, and if the "ns" parameter has a chance of being NULL then we =
risk
> > > > a crash from the dereference in selinux_ns().
> > >
> > > From the patch description:
> > > "We fall back to SECINITSID_KERNEL if ns_common is pointing to an ini=
t
> > > namespace, since these are created before policy load and will be
> > > lacking a security blob."
> > >
> > > To be more precise, those init namespaces are created before
> > > LSM/SELinux has initialized IIUC.
>
> Forget the description for a moment and look at the code.  Perhaps I'm
> just burned out and missing something obvious, but I'm not seeing a
> path where "nssec" is ever NULL (without some dumb luck).
>
> With "nssec" being defined by the following line:
>
>   nssec =3D selinux_ns(ns);
>
> ... and selinux_ns() being a fairly simple function:
>
>   ns_security_struct *selinux_ns(ns_common *ns)
>   {
>     return ns->ns_security + selinux_blob_sizes.lbs_ns;
>   }
>
> ... if the "ns" parameter passed to selinux_namespace_install() is
> NULL, the kernel will crash out in selinux_ns() due to the bogus
> dereference.  If "ns->ns_security" is NULL then the return/"nssec"
> value is going to be non-NULL but very wrong.  The only way I can see
> nssec being NULL is the dumb luck case where "ns->ns_security" is NULL
> and the "selinux_blob_sizes.lbs_ns" offset happens to also be zero;
> here "nssec" will be NULL, but we can't rely on that.

I think that would be the default at the moment so likely what he was testi=
ng.
But yes, agreed - we can't rely on that.

> > If we wanted to fix that, we'd need the patch that introduces the LSM
> > hooks for namespaces to also update security_init() to alloc the nssec
> > for the initial namespaces, maybe?
>
> Somewhat independent of my concern above, but yes, that's probably a
> good idea regardless.  Assuming that the namespaces are properly setup
> before the call to security_init(), call lsm_ns_alloc() for each
> namespace in security_init() and then each LSM can initialize init's
> namespace blobs as necessary in their own init function, e.g.
> selinux_init().

Ok, I've lost the plot on that patch - where is it at this stage?
