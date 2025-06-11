Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67701714AC
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659293; cv=none; b=K7m3/ZxpXK4Gq+ALoj/0+fDpyYanqA8WLSdjHQnXS653Wg/GvdQRBQivSU7TAr3Vco1tW/Ei7/nE77V35mdId0zP9YLj6wIdBpAELgYPtYPOuuMln389dkjU2V+rRtdIojq1zRsr5Gcu79qW1LotCC40IhmYjUbFeD9Kzgnzuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659293; c=relaxed/simple;
	bh=yJyweujQ540eOfMwFfKKLrRy5OL0KRda5O631Zhn+z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDxWVLDWGhqiuo4FxCGnGCyR7rQw2rUbla8I3YT7I0XHf+Wo8cYR4JJX9LfNCk2wCwXUJGUtvF9K+3arT597vAq3Mb/GiOVHZVFxlKszRVNalLwafAJXeKQhJ+YAQ8qj8jQrnpxYyoV2ZpYJKTviF7DZwCSVV+ufcKGsyVctZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gOuOgkxv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gOuOgkxv"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so5918620276.1
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749659290; x=1750264090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UARxqiLAl/DnZ28ZtiTrp9WabZ2+OrtiDHs7KAvcvkw=;
        b=gOuOgkxvnBcHhdOP9Me+6KA7TCIgGPLkWgQnUoAv0TYPIS7toXPOVpZXlqJ5w4ki1t
         QHu5RS8IRV3DlTV6ADokxQP6wpIOpto8MFCbe2DX78CvQopx41eKA8SQTcWTHSVywixI
         pMrkcTwmmHJ4h+uIacEL7mW5EH+zAhH/yfPZAv/E3u3Nky3HWdJFK6IiOEDCNDqwgrus
         IvRfMpgA1ro13O/WS7k8evT1KwCbakHQqCAchp1Fba/YXFDbmCP4uHTxeV+ClCbCW6po
         JvcvfYX4ReljzHMPp+SPe3mO4JGlNes2nwaXaBeYJ0E4zLBicLGjOvMDUoFmvTPM8Z2L
         Xx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659290; x=1750264090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UARxqiLAl/DnZ28ZtiTrp9WabZ2+OrtiDHs7KAvcvkw=;
        b=nyNTDKUQinZ/tQKHWtXRc0OKleYPpz1l7M5JIe7x21BetP+yMHu9+ue/oow3LNMqfc
         CeQ3FzqNjgFu6kG3FlYFAXzhXd1rscJfb7wTe2wN23dpTz3s2SDO20Pz42lnc9cFStGg
         83FbdHovuPNv2rPAEewQAMXfRrPgJjynIi9OdOLr05JROHFT3wkdtywHstLnfFf6ICY7
         36iS3Qie5baCXiXs2x9mJ1ZsPvr/5jDsg5Oln1cOn62qYOjNC4WsDAO5TNw3ikyC8KBk
         VVXWj802tL0+PXPmrl4K5fHqh1Ade+Pk17RoRG58MOfaARWG5U2khP/Q44lQiY9UdurD
         06BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbZd1VXUUIr2CivhoSNc0vJ9IcbN9heyC5D3+X1Vb6pvv9Pg/c6n1s1fc9KTaH9QSzXKeAH19z@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiIaDC4g6I+g+SdI017szpitaTVWRezHKvjk2I+tJjBWPCswJ
	hpxpf4YEhSgttdXnYiZ5Rtv+ub50lzaHCaJsI7Z9UiPLSc0DuzNXzheElcnyf4M5AwbArLqE5gO
	jr2Ynbn4CAcTieKT7S4mdcHFRZhkx/sC5Q+tEkRW/
X-Gm-Gg: ASbGncsCKD+ouGZjCYNXAbxg7prFtGd2KR4/EbTib9RDpGnKfwRYnlH2PK43UFpyH9D
	nkR5SlAdxHzAVBOonAbNCY52vDYAE64yyNE4o//iNoK8xNYiAy6S6rTEHjXDq5UJfX+8OExfVfM
	2xuQLJtjmj3uqcjH3/X5PftPYDce/gFwVFIp8OFICHV3w=
X-Google-Smtp-Source: AGHT+IGUwUYy4NP5Be+H2R8af1/HDC1J3XhImBL4Y7mYP27l7dIkOqlgy5w7FK0yCuRsiNLB9HS0Cy7UOfHpV8BZnJg=
X-Received: by 2002:a05:6902:98e:b0:e81:9954:978a with SMTP id
 3f1490d57ef6-e81fd9e69f4mr6163248276.47.1749659290677; Wed, 11 Jun 2025
 09:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com> <1749647531.6091.5.camel@trentalancia.com>
In-Reply-To: <1749647531.6091.5.camel@trentalancia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 12:27:59 -0400
X-Gm-Features: AX0GCFujz6RQZY1XF5jStpLVP_ouagfVBzuQQjTmemJ0y0_70SI-WWlHEfXRxjE
Message-ID: <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:12=E2=80=AFAM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> Hello,
>
> I have just tested Stephen's patch and it solves the problem as an
> alternative to the dracut patch and other patches posted here along
> with the issue description:
>
> https://github.com/dracut-ng/dracut-ng/issues/377
>
> Please note that I have only tested the success of the boot process
> with sysvinit and not other aspects of the system functionality, other
> init daemons or regressions that might be caused as a result of
> applying this patch.

Understood, thanks for the testing you've done.

Would you be okay if I added your "Tested-by:" tag to the patch?

> On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > If the end result of a security_compute_sid() computation matches the
> > ssid or tsid, return that SID rather than looking it up again. This
> > avoids the problem of multiple initial SIDs that map to the same
> > context.
> >
> > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > boot processes")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 fixes a compiler error.
> >
> >  security/selinux/ss/services.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c
> > index 7becf3808818..d185754c2786 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
> >                       goto out_unlock;
> >       }
> >       /* Obtain the sid for the context. */
> > -     rc =3D sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> > -     if (rc =3D=3D -ESTALE) {
> > -             rcu_read_unlock();
> > -             context_destroy(&newcontext);
> > -             goto retry;
> > +     if (context_equal(scontext, &newcontext))
> > +             *out_sid =3D ssid;
> > +     else if (context_equal(tcontext, &newcontext))
> > +             *out_sid =3D tsid;
> > +     else {
> > +             rc =3D sidtab_context_to_sid(sidtab, &newcontext,
> > out_sid);
> > +             if (rc =3D=3D -ESTALE) {
> > +                     rcu_read_unlock();
> > +                     context_destroy(&newcontext);
> > +                     goto retry;
> > +             }
> >       }
> >  out_unlock:
> >       rcu_read_unlock();

--=20
paul-moore.com
