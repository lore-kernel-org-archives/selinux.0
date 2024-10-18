Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AEF2022C1
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265542; cv=none; b=ZpzPuVy1VzsQADlEAJzHdr/VMS4ZN/yaS66qXA8RRKrIpkTg5/dim5d4viffqw+cHcZ7tdTs7Fu6j+wuTAReFsWZKk5ZPBLBiDoAaY6o3LghNrp5XKyX9d8vaASaihOHnCz9/Wo7Qlsh1Vo5aiXSOwE/2KJcas9ovwEPKUBOT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265542; c=relaxed/simple;
	bh=RNKet7t1hYT+xNj0Jz4RMPwSbCurr2T9K3R9ZIgDEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPcIIdx0fZ0STcJlT0c9eBbir92RtY9EeJjvp/lWaQav4FM39Qfzno8tbIn0BWwB+3v4hqSfudkR8kRmH3pSdW/tKcJHod45Y4QkOKyXELhrTuC59gqPzEeVnQyofBeR/bDUA0N0QBsuaou/bCURmxxlryDYpHXFCIcWS+m9aTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=W3IbzvNz; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W3IbzvNz"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7180cc146d8so1184887a34.0
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729265539; x=1729870339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHUnrGICmAPGHQYF6/N572r4+c4u84iqn5uYp+PkKXM=;
        b=W3IbzvNz9nhGeqwi6ccwb5nJL/nqjnTvzyK5IV06HjAv9PmuHq/fyoMIxVu04XZGNZ
         z+5hcXy2b1pOBWZSts9njPrI7ZOrnGAZyJQfry5n5BmWpBbuKqTh3uPTv8zHUJZ1u6F2
         AE/u6kMBuYtD6tyZcGSN7Vc8Kob7YIzXhl/QwzIqR6TycFSvSlMthi1HRo+EJ4DKE8yP
         0sU+jtb40ggOxGzVCzAQOM67ZxEN/rWg+0S2n/4TpAL3KJ7vncwA94JPUDnAyBu2DJO3
         UjA/jNzOhEYPn5E7jGHNyInwwsgs/Q6mYwVBtqjtkp2E6nOFneQpvSmbnkQ/Qb73/3rr
         rfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265539; x=1729870339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHUnrGICmAPGHQYF6/N572r4+c4u84iqn5uYp+PkKXM=;
        b=G2i+1p1wc7TcVCXqKIN8nW2SecNuVUiNQ0WYk19vQu2WMVActnUBrxly+w8JtgZ9If
         cIU1C2GvRlKto3TyvAuDGAtSNQfapS0RwDECrgaqzk/hOtYSWeuH4dSzP350QC1YFTdG
         TGNXjYtK6K93SZI4Yu7e/P3NAIY/vL3+DN+PdbvT1qdDnwaKQ2fyb62fJCFSKkhg4/Ly
         24QDWPTm0gfJfZKyOO4UXGIwSWqD3z7VwCfATC8b/54ISvtxRXS7O5Jwi8cYZCN83Y1h
         gAyzhOxv67UkVpncnpouISZqtpr+d7hSv3msk4yY9DJUwRLaDic38sdtK5DgiNqMwybc
         nojw==
X-Gm-Message-State: AOJu0YzXGZDgDx+SsQ/QodjGQ8iOCUyO+YX5EJ8EXlJWwkT8Ft6iXdg4
	wFfAp/OZDgCEDombe3O3CPFUatZ32lYNsRYhGLsb/ADf5FLNe+IpnzDZrss6Yglrpunty3x8LYp
	w+HWL5kj/BN90PII2OY5LxImmxyo=
X-Google-Smtp-Source: AGHT+IHhzebRZq+UkN+X2PzPxgAaU7uWmgyq4OD1l38YawG0Ru9DOj4fXJ8rDb2Q6VYgojDVh4bkZgGZKe0OhuxnV60=
X-Received: by 2002:a05:6830:6dc7:b0:713:7415:3c61 with SMTP id
 46e09a7af769-7181a84f70amr2395357a34.9.1729265539471; Fri, 18 Oct 2024
 08:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408153006.69840-1-cgoettsche@seltendoof.de> <CAEjxPJ4MRkgTSjc1uzASZzcvCNgnkcpZW-QHCYU7sMHqVQB8Eg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MRkgTSjc1uzASZzcvCNgnkcpZW-QHCYU7sMHqVQB8Eg@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 18 Oct 2024 17:32:08 +0200
Message-ID: <CAJ2a_DeVbO-8_UUvCk=OWY6s=rZnUpNR02nBA9r29XC0weRtOg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] newrole: constant time password comparison
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 at 19:56, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Apr 8, 2024 at 11:31=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Perform the password hash comparison in a time constant way to avoid
> > leaking the length of the identical prefix via a side-channel.
> > Since only hashes are compared leaking the total length is non critical=
.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Should we just require PAM for newrole and be done with it?

Since the shadow backend still works and seems to not to have a high
maintenance cost, I would argue to keep it.
Maybe one could stronger emphasize to use the PAM backend, via a note
in the Makefile or a warning during compilation.

>
> > ---
> >  policycoreutils/newrole/newrole.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index 5a1a1129..1e01d2ef 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -338,6 +338,24 @@ static void memzero(void *ptr, size_t size)
> >         }
> >  }
> >
> > +static int streq_constant(const char *userinput, const char *secret)
> > +{
> > +       const volatile char *x =3D userinput, *y =3D secret;
> > +       size_t i, u_len, s_len;
> > +       int ret =3D 0;
> > +
> > +       u_len =3D strlen(userinput);
> > +       s_len =3D strlen(secret);
> > +
> > +       if (u_len !=3D s_len)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < u_len; i++)
> > +               ret |=3D x[i] ^ y[i];
> > +
> > +       return ret =3D=3D 0;
> > +}
> > +
> >  /* authenticate_via_shadow_passwd()
> >   *
> >   * in:     uname - the calling user's user name
> > @@ -383,7 +401,7 @@ static int authenticate_via_shadow_passwd(const cha=
r *uname)
> >                 return 0;
> >         }
> >
> > -       ret =3D !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
> > +       ret =3D streq_constant(encrypted_password_s, p_shadow_line->sp_=
pwdp);
> >         memzero(encrypted_password_s, strlen(encrypted_password_s));
> >         return ret;
> >  }
> > --
> > 2.43.0
> >
> >
