Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193174;
	b=z4VFjAvd3jHTT5lCJMwYDhwEdYKiJXfJhVtGpqtDQFlc8LgYNdOzPHApYS4Udc0AzaF2
	 4RZ7K6AKChpUb6bosOFhtVTxamgsUP6eyXFJGjBG7zE9Rchl8PQOg3hRL5LnyM7HPfuSW
	 /a6iTTOtIiCFFf62qUaX0vjltDOGsmNro8kTxMluzPwuDFF++DnZFZzu5pHqB9OQHoyGw
	 7ichnpsAUgMxbS6tfX483QcDvRLqu/KnZfPXr3tcOTtrRtXohYnW9xW384t8jrEC6Dgnn
	 f2vCqN4Q4sFkIR1BWQO9mYf0NAThkYUU/ND3aSJ3h6SdSG903rNuAVXyM7dCfj9g7+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gX4PkTbBkpO8uSNQbe7VviIeIuIATVcpL+fYXq1lvtI=;
	b=5bhhJpsOnAVSusSphwocaf9mX5ksKHn8H/FsjxnCes+5njWeGN0jIkiaOoKYsMhms26k
	 yXL1yk+QEMV8jNg7Tuk5rw6Ti921tv8nifCvaef56aEtCxhwkWvCRXCGqFZLZR6Xg/UKB
	 9NOhaaqWQkWeqJ/HDQFeBBvQln9Dmy/xic+hwehkpDjbYtCc0iX00rvrKmEVCHg+PhdAb
	 m1+PLUHZ1/6xq5g2pYnuT+tZf4Xxw1KtoaEx6Vl9O/8fqKr8LAnb74dOP/GSjumb77JcM
	 ChWZ0E/9hEXa3ZVZOIobx/hBQLMWXvcLxaP6zel8rDQLjCHFgSVukOiTBLHwmS2//Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+b23gTn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A5606A321
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 13:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+b23gTn
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0dba37a7fso8075327b3.0
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 06:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793193173; cv=none;
        d=google.com; s=arc-20260327;
        b=XU8OO5fl5MWEXjC0v2uKpg9yXaf+x7kVCkSQ4FcCFDkhRJGGkAX0mmLaK/LaupvE6u
         /00sFILBIOtMKGZ4AyFFknUuFMjXh6r5MeREHrVEJHCn/q8KzffUKJSkceLUyTOZ3zeS
         ACYBRIdDKZSbOd1MbpUe8mypeV7uH3cZBE69JIA1i+MJjdcNk+eY1fzQHvNp9Fz87kJ8
         2pPAjPRO0Fou78GIwzbojxDVwlmXTZAnfqdvFu+kAtSUgetVm+Ylt2sH7fwZ2lI5REaH
         axajJznLoDuJyntopyB2sP3pxTL8WbTkPENgbavp1kKwMsGYTPlx8i70lZLXD8bnb5Qa
         sdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gX4PkTbBkpO8uSNQbe7VviIeIuIATVcpL+fYXq1lvtI=;
        fh=99TLgBUCiW7lpV1N792WBDDaz1uWxETRBfhRBi4L9U4=;
        b=OmtUKUVAzuZl4IIdxOQKV/q2lK6C6iFMk3wY2uqqitn2ht43DZcujTdryQZ2Zpro76
         rkYaDO+8XGDjj756f4pjT4wl9fYPho8Dzp+1L0TZuYVCn7lhTjyZ3ffFs0pgTHalMPqK
         6D9bnICgB8BJpDxjrUpE3JvXHqKSClvzVUmXxr9f5iA/xr9FfiURnaBKaNVr1peEGug2
         wYvUyFMRT7esPcMUV1UiGGzXWq/sAlJlNB+gl+msAL59221OlCGdx+sjyftfRHG6HiRj
         pnPpP/C071Dks81S6LXZFlY7eTL1QRFR1KI7/guHq9kCIN/43bubByxUPPzmi1Qyz7Y0
         /gbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793193173; x=1793797973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gX4PkTbBkpO8uSNQbe7VviIeIuIATVcpL+fYXq1lvtI=;
        b=j+b23gTnG9me3pvtKHTEkh6HHqXLiZb75QMtOSZByXsZF3O75aL8ZrGCDEs1KPozk9
         ELEPiavXE5MRYdPWWMON+atguh9Vw5RW0ugU2MzRfvxGrEa8jQL8g2ESCkd42KvCXKFJ
         XOFiswIdyLmgiuOxXauzkYvQCB9Awku82iMnTYodQ7RI1dMQ+ZL9qF8uJn/TDeIDx4PV
         2fYaeRLulufxyrcInKOybZbHu9Jf1MYMl9JGmzTntj+EoKNWUgRfEoFso64Xqj9zaPzY
         eUfE9fp6zXRbFKEbfply6lzk3/ZAvbQddsSLNQu15eQd/14iy+1FNTdXFYHe4GN4Kw3l
         Xbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193173; x=1793797973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gX4PkTbBkpO8uSNQbe7VviIeIuIATVcpL+fYXq1lvtI=;
        b=rtC/s9bOf0RJhcT2/OqVJVk388VZ2ABw73zwPpLxxOoF338kbIeUPumB9DwaIu/n9E
         JwNUaLziz/2z7OvvtZoqy/3Qishb50b3HWVk9uXGY7nceNgymA2ydM7Yoi7xYYfXJADk
         t6JX1jC4T+PRtzNw5oIGujNwGrGHuUeEJMEmL5/m0YKfLVmpfmTlZOjDgMmCkPIYYdMw
         PcNo2Wnc56pLZZBY9h2OSTiZDHHztB7sL5nk+aFKMjN5J4FlkDpXhHMbUBtVrkBFbncV
         7oqEa4lppN/q5hm2f+VKzqekbMUgl4lH/lBHjg/7slGrNuR9osgS2Il8iynVd4xim/iq
         UG5Q==
X-Gm-Message-State: AFq9FYKVLKO+X+7OUBtqLSCyyEWHaLWI0GOzyWUXJwPlswVwm8g2IeEs
	bqi05IBU6IE2i38r6/HbnWR19kCwvPNQz7uJYymqpdMIC8qunPPYAlBpUJ+Pv5v/X/F4+DD/8X1
	xKmPYxh71wYqQWPZyDOUXIfcKACnd+H6AVNWy
X-Gm-Gg: AYBFou3/+F/7wJX6xv7TpmnVztWSBbqVm2Dxdq9e1oqu978AMWxGBxNRXv9oi4vdD/t
	4qZBF68fyLQpFcNmS7vgm2CHqwdKT//jaR7svoHMg2Lu2yCCZbfgyOXscFrLyrV5yM8y6IdzPMU
	1WGaLPl6SUpnlkkIEiNnfHZNYhYGvVtzYLjq6r2uK12iORdoARbDcqmjRvob/o7FR4XEh2bFli7
	knMYUVwnCIE7OLGyNEEbbF3T63R17vDschvPpYt1u1Fu/P/osSlsupt7ympsAKjiS2HIm/6e/G+
	6nueqS6xOozxhhn2uMyXoNK6AdnEPhJR2XUsAkWTnTMkx4lm18N4LT/ulnrlh6n3aX8o4zuUnm3
	hPiPBUtLs8fS//clo7eizRE4sbJIiTbtXMLdiBjFj8GOZ+RiqkVq5pAfsZKxY396VUfS2NPwm7s
	MjD3892U6cjmUAcJW8zSFqEso7j4OuYA/6zHL1hAAPFYVqo2m7+SqmvCh3ug==
X-Received: by 2002:a05:690e:458a:10b0:676:ce5e:7a1 with SMTP id
 956f58d0204a3-67a7bd71880mr1066552d50.162.1793193173070; Wed, 28 Oct 2026
 06:12:53 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SA1P110MB166157581CF3D150601ED288AC61A@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
 <CAEjxPJ56sJtPYT7nptEcMTP3HKh_dfyMOdfGQnxsQn3uaWZn8g@mail.gmail.com> <SA1P110MB1661894742797CD6BE2618ACAC6FA@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <SA1P110MB1661894742797CD6BE2618ACAC6FA@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 28 Oct 2026 09:12:42 -0400
X-Gm-Features: AclHuK-Na-g0zBLxMGLqABy1kQRpacaK-yCOoCJp026HEPjzjC2XI2HPKVe8iUo
Message-ID: <CAEjxPJ40p=LaUEFadQuwe2F0USa0YPaJBufoVg62wN2E8GnThA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Allow unknown permissions in permissive mode
To: "Sloane, Brandon" <bsloane@owlcyberdefense.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 9:11=E2=80=AFAM Sloane, Brandon
<bsloane@owlcyberdefense.com> wrote:
>
> Thanks for looking at this. I'm having some trouble getting our corporate=
 email server to play nicely with git send-email. I'll send a revised patch=
 once we work that out.

This is why I use a gmail account for my patch submission and reviews;
git send-email man page even has instructions for wiring up gmail to
it.

>
> > -----Original Message-----
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Sent: Monday, October 26, 2026 4:13 PM
> > To: Sloane, Brandon <bsloane@owlcyberdefense.com>
> > Cc: selinux@vger.kernel.org
> > Subject: Re: [PATCH] libselinux: Allow unknown permissions in permissiv=
e
> > mode
> >
> > On Mon, Oct 26, 2026 at 1:37=E2=80=AFPM Sloane, Brandon
> > <bsloane@owlcyberdefense.com> wrote:
> > >
> > > In selinux_check_access, we first check security_deny_unknown, and
> > > allow unknown permissions if that is not set. If the permission is
> > > known, we proceed to invoke avc_has_perm, which handles permissive
> > mode.
> > >
> > > The above leaves a gap when security_deny_unknown is set and the
> > > system is in permissive mode. Under such a configuration,
> > > selinux_check_access would fail on unknown permissions prior to
> > > invoking avc_has_perm. This commit updates that behaviour so that
> > > selinux_check_access treats security_deny_unknown as unset when in
> > permissive mode.
> > >
> > > This new behaviour is consistent with the Linux kernel's behaviour,
> > > which allows access in permissive mode for unknown permissions, even
> > > when deny_unknown is set.
> > >
> > > Signed-off-by: Brandon Sloane <bsloane@owlcyberdefense.com>
> >
> > Your patch was corrupted; please submit using git send-email, see
> > https://usg02.safelinks.protection.office365.us/?url=3Dhttps%3A%2F%2Fgi=
thu
> > b.com%2FSELinuxProject%2Fselinux%2Fwiki%2FContributing&data=3D05%7C0
> > 2%7Cbsloane%40owlcyberdefense.com%7Ca7ecc334a84b4fe907df08df339
> > d921a%7C0c7a5d8a53f744d2b6c963bab40ba995%7C0%7C0%7C6392864
> > 24003753784%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW
> > UsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D
> > %3D%7C0%7C%7C%7C&sdata=3Dj7fhAww4f%2FQ4OOS6vK3Uov7NQUkoxm8
> > oWwAiwWVgWnI%3D&reserved=3D0.
> > Also, see below.
> >
> > > ---
> > >  libselinux/src/checkAccess.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/libselinux/src/checkAccess.c
> > > b/libselinux/src/checkAccess.c index 3cdd2413..18e4abda 100644
> > > --- a/libselinux/src/checkAccess.c
> > > +++ b/libselinux/src/checkAccess.c
> > > @@ -26,6 +26,7 @@ int selinux_check_access(const char *scon, const
> > > char *tcon, const char *class,
> > >         security_id_t tcon_id;
> > >         security_class_t sclass;
> > >         access_vector_t av;
> > > +       bool allow_unknown;
> >
> > If you are going to use a bool variable, you need to add #include <stdb=
ool.h>
> > to this file as well.
> >
> > >
> > >         __selinux_once(once, avc_init_once);
> > >
> > > @@ -47,11 +48,13 @@ int selinux_check_access(const char *scon, const
> > > char *tcon, const char *class,
> > >
> > >         (void)selinux_status_updated();
> > >
> > > +       allow_unknown =3D !security_deny_unknown() ||
> > > !security_getenforce();
> >
> > This is a fast path regression; we switched over to using the SELinux s=
tatus
> > page to avoid requiring extra syscalls to check such things.
> > Use the status page interfaces instead.
> >
> > > +
> > >         sclass =3D string_to_security_class(class);
> > >         if (sclass =3D=3D 0) {
> > >                 rc =3D errno;
> > >                 avc_log(SELINUX_ERROR, "Unknown class %s", class);
> > > -               if (security_deny_unknown() =3D=3D 0)
> > > +               if (allow_unknown)
> > >                         return 0;
> >
> > This create a mismatch when a caller specified AVC_OPT_SETENFORCE upon
> > avc_open(3); in that case the callers wants to ignore system enforcing =
mode.
