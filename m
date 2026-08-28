Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23B368D5E
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940508; cv=pass; b=Htsry4B4qEURoM0/R916TcFSninpzv/P+FWUY6492GcVQ+kNOiKOTNE4W4syp7RGz3JmcrjzFFKBysmnc2QixGk067q9L1D6pPDyS68llVTYL4DkplH50MFMfzMCZoOOIV4HIDYvT/t+2f+1KLdgiXLzwBSV3fweIcY37gvIcco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940508; c=relaxed/simple;
	bh=uVhSm2ZX5h3fq3Mqty9iMCyM5td2LzUQz+speFZ6p5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DimU9KbpyaWOCEP9tFzgOclsXJ03ymz/T3mETEZLwz4IcwrxK19Buzf9r3nfxpPcogdIdxeREs/eEnR6GAAx8G+kXBJjYvgdmL2vmZEjuFqIwWHvlnVSXGMkwuqQgm5TQGPp1aW418oIblpUE0LJzBna2Xg2FAxWLouvmJ9l6HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OBcPvR9i; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OBcPvR9i"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1276517a91.1
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 11:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787940506; cv=none;
        d=google.com; s=arc-20260327;
        b=Zh0wcgS28OMTMcpM7ODFBw8YhS3XmaUU0zBsD3HWSkXuIoaFdVKRZokeWTW1/RWUIs
         tX+kicSCYvGX/E2usDRyWP/yf6A7KawCC6TyB9RfTWD2yljFaOJcKDVqG3hO9bjVo48p
         Cf6jRalOvIkGJzQZuzUZmEn4NQQOh6DoZhKa/1hdykG1qLvf0BG2h+3wCiWlc2cLdFT5
         DOsBlJLzR+MxkwSaee+7kZBNkwlMPzWbqWnKP2+a2G/O2+UvzwnDpU0IOpwp8cfx1TKH
         28PF2wwow2lhVPpR2cRBnrX70ATT6/YsjG+LPvY4u0NNrXfi7Vg78oPgybm5lUD5XKmO
         2GyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uugv0gZ2IU6A9cdDgQ70b1u+ixICnhGrOKZnZ8hQUzY=;
        fh=pZXivrTiaVwIt7PyNIFEoS9IFacLzZyJuV63RleVvPs=;
        b=LSjvV41KMvZ7/qoNi4D8kz7mS3QiDG7Io84JU0EJMIWO1iI9+q2uN2KTO1Z1I2cVGE
         3Pu1rSYywgt+oWKP3EAEeVVxQg80xUwUc/fruEEgqIpMAC2y3JPXTAcYndXLLpQDKso7
         VOyEckawwXyAYsEeM0+wLTbSiEFemcqVRSgaz8UJMXxWROwE/vOVGyBoS875gDTw28bK
         nz/u9mWFZ6lZiZ915IEg263w0BRHcI0kfu+VByPS98UUx+Pm/19OFWZzjwmXwmVSpnXk
         T4gjJks9jqgD7yiy2Gw2hRH3fbIU4Qxth9AO5NT/6KhsyCwbHCoVVeYQNnzDe0KngwI7
         R1ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787940506; x=1788545306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uugv0gZ2IU6A9cdDgQ70b1u+ixICnhGrOKZnZ8hQUzY=;
        b=OBcPvR9i5r6X5KldSMmLX7SeuPkMTDEDyBd6auk/3THtOSAOg8kDBXkhLQnwWmWN/q
         W5B4c/SKF/4a/oScQJFh0lZD/qY+6K5CPLNoS0gaOYC0j3I8f7HF1O0eSrB9RlerJOE3
         C+x/Gd1XMzWC9ppL3eA8+zNWei4uldqsXhS+sbFtFxs3GD8yr253rvDk436dgp9rOtZh
         e+DBEk5Bgy2LrcWrsWabu+PK2cFYJVUIKzy8MTHZbf/Ralpg7vhz9pN30Gh3xtkSvOEn
         rKQE14HiTFILQdsRJQezOh/jEYal09G2np/pJM9wW2IVCkuTUhcPpn0yV+HFQhcrnaT1
         2E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787940506; x=1788545306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uugv0gZ2IU6A9cdDgQ70b1u+ixICnhGrOKZnZ8hQUzY=;
        b=ZOhr9Wq0EblfKCa3vFWTTJN/WUGtxiZYkGUPEzsBsTpmVOeiWKVzpeyqH++zAZicI8
         5OBxj52unwWLA1/5gxsGr9fNZimBLD1Nyc9tahD+ARxFbyZta8MuXcn0seBN6znfI5vb
         qoy00BSuMSDCvLb86KTXVltQ8kQVWi7TYkDCPpHkoVcRRlskNDM9EoKogCofK7qnvoqA
         hglyItSlUJEoAix94WBvNaKCBGahKWBemmZomjx4zkEbm775PLzXVrM+4BdZaWMkX9AK
         UbGM09/Y+x+IK57tDxb3yzfIYGB+O2gicEeKMJ2GvY4n22lN6NdqRL3zyQbu3fmtHPJS
         mz8w==
X-Forwarded-Encrypted: i=1; AKwUvBz06UsP4crMYD1fb37ytnp+RMfVpTpfBbguDnik5Cp929c+nvCmo2UumiMUJvAcNjD7awKtUCO5@vger.kernel.org
X-Gm-Message-State: AFuF++k+lAGmJDf+1Vi+eTGerp6arbKHsnggYutoZAcb3NtAmUfeJWNF
	WApfn0hWn6Z3+7mM8Z5LCyqllbifmBKJZOjmza8b8gdptDpHh4wQsgH/Ib1s2eSObt4hvq9dtEE
	1bxh7f7rxdVTHzxPdlb3+mAt8icrZHIp7RdtzE1jhH69TKu3F76yEFX66
X-Gm-Gg: AYBFou3V6HzXKBEMX8Mj5+tukX7wVqXsIl3GaqJM7oU8WJjNQuWxTdl+C6QsNiPJkLe
	5zRnd8zogNIhfrndt3G1oXzObJYFhce+TJ+E7jzeJL+HZVN+kVCKZ4wJjCDk1gRhsNrVFFhDNLu
	LIUpsKnzjoEGJa6zeOGQOFYLfV1l1bfuphNw2aSkpTXdJ8FPweVGy1joQacRGZzavDhtqcQklR4
	I1MyR5HPx9GrmhhG4RiPeGlXGJll1C0TNVE1HCGzp0W7z8olMVOKQjd4A/lIyKtd8WxX9LXbUEs
	XpiohR4NOzMlf702hjssEhxIdjiX3g6wQmxIXilnlTXQ
X-Received: by 2002:a17:90b:5626:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-3989bd135fcmr2659098a91.23.1787940505746; Fri, 28 Aug 2026
 11:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
 <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 14:08:13 -0400
X-Gm-Features: AcwNN1WpijuL-ki2rHuKgCAAy1BythKZgC1Gs76ZIoChtYi4BfCxRRnKu-GxdIo
Message-ID: <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 28, 2026 at 8:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Aug 27, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On May 28, 2026 danieldurning.work@gmail.com wrote:
> > > >
> > > > Add implementations of the namespace_init and namespace_install
> > > > hooks for SELinux. Corresponding permissions are defined for each
> > > > hook (create and setns, respectively). Additionally, mount
> > > > namespaces have a create_anon permission to control anonymous
> > > > mount namespace creation separately. New security classes are
> > > > defined for each individual namespace type to allow granularity.
> > > >
> > > > In namespace_init we check the caller's SID against itself. When
> > > > a namespace is created the SID of the caller is saved in the
> > > > namespace security blob. This SID is checked against the caller
> > > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > > ns_common is pointing to an init namespace, since these are
> > > > created before policy load and will be lacking a security blob.
> > > >
> > > > Requires Christian Brauner's revised namespace LSM blob patch
> > > > and Micka=C3=ABl Sala=C3=BCn's v2 LSM namespace audit data patch, w=
hich are
> > > > the first 2 patches in the series linked below.
> > > >
> > > > Link: https://lore.kernel.org/linux-security-module/20260527181127.=
879771-2-mic@digikod.net
> > > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Added the create_anon permission to separately control creation
> > > > of anonymous mount namespaces
> > > >
> > > > Changes in v3:
> > > > - Rebased onto v2 of the LSM namespace blob/audit data patches
> > > > ---
> > > >  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++=
++++
> > > >  security/selinux/include/classmap.h | 12 ++++-
> > > >  security/selinux/include/objsec.h   | 10 +++++
> > > >  3 files changed, 90 insertions(+), 1 deletion(-)
> > >
> > > This looks good to me with the exception of one thing (below).
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 95d0fb20d84e..94ef03b65e9a 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct in=
ode *inode, struct lsm_context *cp)
> > > >       cp->id =3D LSM_ID_SELINUX;
> > > >       return 0;
> > > >  }
> > > > +
> > > > +static int selinux_namespace_init(struct ns_common *ns)
> > > > +{
> > > > +     struct common_audit_data ad;
> > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > +     u32 sid =3D current_sid();
> > > > +
> > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > +
> > > > +     nssec->sid =3D sid;
> > > > +     if (ns->inum =3D=3D MNT_NS_ANON_INO)
> > > > +             return avc_has_perm(sid, sid, sclass,
> > > > +                                     MNT_NAMESPACE__CREATE_ANON, &=
ad);
> > > > +
> > > > +     return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad)=
;
> > > > +}
> > > > +
> > > > +static int selinux_namespace_install(const struct nsset *nsset,
> > > > +                               struct ns_common *ns)
> > > > +{
> > > > +     struct common_audit_data ad;
> > > > +     struct ns_security_struct *nssec =3D selinux_ns(ns);
> > > > +     u16 sclass =3D ns_type_to_security_class(ns);
> > > > +     u32 sid =3D current_sid();
> > > > +
> > > > +     ad.type =3D LSM_AUDIT_DATA_NS;
> > > > +     ad.u.ns.ns_type =3D ns->ns_type;
> > > > +     ad.u.ns.ns_id =3D ns->ns_id;
> > > > +
> > > > +     if (!nssec)
> > > > +             return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
> > > > +                                     NAMESPACE__SETNS, &ad);
> > >
> > > In which cases do we expect to see "nssec" equal to NULL?  If this is=
 a
> > > possibility, shouldn't we be checking for the "ns" parameter to be NU=
LL
> > > and not "nssec"?  I'm asking because selinux_ns() shouldn't ever retu=
rn
> > > NULL, and if the "ns" parameter has a chance of being NULL then we ri=
sk
> > > a crash from the dereference in selinux_ns().
> >
> > From the patch description:
> > "We fall back to SECINITSID_KERNEL if ns_common is pointing to an init
> > namespace, since these are created before policy load and will be
> > lacking a security blob."
> >
> > To be more precise, those init namespaces are created before
> > LSM/SELinux has initialized IIUC.

Forget the description for a moment and look at the code.  Perhaps I'm
just burned out and missing something obvious, but I'm not seeing a
path where "nssec" is ever NULL (without some dumb luck).

With "nssec" being defined by the following line:

  nssec =3D selinux_ns(ns);

... and selinux_ns() being a fairly simple function:

  ns_security_struct *selinux_ns(ns_common *ns)
  {
    return ns->ns_security + selinux_blob_sizes.lbs_ns;
  }

... if the "ns" parameter passed to selinux_namespace_install() is
NULL, the kernel will crash out in selinux_ns() due to the bogus
dereference.  If "ns->ns_security" is NULL then the return/"nssec"
value is going to be non-NULL but very wrong.  The only way I can see
nssec being NULL is the dumb luck case where "ns->ns_security" is NULL
and the "selinux_blob_sizes.lbs_ns" offset happens to also be zero;
here "nssec" will be NULL, but we can't rely on that.

> If we wanted to fix that, we'd need the patch that introduces the LSM
> hooks for namespaces to also update security_init() to alloc the nssec
> for the initial namespaces, maybe?

Somewhat independent of my concern above, but yes, that's probably a
good idea regardless.  Assuming that the namespaces are properly setup
before the call to security_init(), call lsm_ns_alloc() for each
namespace in security_init() and then each LSM can initialize init's
namespace blobs as necessary in their own init function, e.g.
selinux_init().

--=20
paul-moore.com
