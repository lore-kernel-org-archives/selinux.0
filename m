Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73926246782
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542881; cv=pass; b=bkDrwq3540zO4DJxej2BbC5Yf77MBmmcQkZSziHySJIZaSVpXnaGosqQS6Giuu1P70r1N3YLCUL3xmuiOq1Bmj/C7ePwu+B5ygdDEztBPwg5OE2mjW85r5uwOug/oFb+o0oq1iENqSb9vWZPLdprjEO7hT6bP0e90SlNjS2vPeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542881; c=relaxed/simple;
	bh=FDYyja1nL5bHPOpMSxV7dedMCNppXgdXahVRB8Ip9iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh8sOluXX3kP++NWWS5eqBpYcon90Y2qcmfM6S+MeN/vStqwjlrvTmPmbzbJlH6iUuY2mGE7ARZxWR+OJHg36fWxn4UxAgYWxeN1sV0e+n0WRdrVOrSIc2mBnbu6CnyZxzP/obITRHBpioQKK6AZPXsrx7T7Fj0Z2SKLQU5khjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGGKIu0k; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGGKIu0k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84236f9b638so1753673b3a.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 10:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542880; cv=none;
        d=google.com; s=arc-20240605;
        b=lU86LGq/9SrkAO+0k6XOT6iyBgU44xy60Uz1m22ac6eNaIkU7Bzvj8CUmJnSa+bw0g
         jjms4+rNVsIldMNcZ0gLHdcI5VptfguKlkloWRUu+1G4BItor5JFF5MWzfp/LOH5cTwR
         wXHls0MNhoNyRDBJHIGGrWhG9TKEkEFYikZDSmMUrOVtt2loC/SAzYNavAXlSEHOvrA6
         eAQ1EppgyPfJ/XUsqVeUJOpE7mUfRFe33KX4UvuIlynn0gxoYThAA+cTErW3eaF5uw20
         TsBKPx0f1dOg7tBsBK6OlRDvPrqP+OPbAb7bt2ZDJOIgOL6DjvfMeZ6R3cmVK502rnFR
         5RBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/HRgi9IQAcgUhYKVcTYQF87GovFmdNDLDpUKpgEBopY=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=aHRQVb7lhIugxCfezdYZjNNQAiWeftvRVXkBzjw1UGxBJDIU7Jst4ERmSR+1XfuAHj
         AL4j+hj6Rg7PLiDea4L2OnYWBz/0Rtda/dlk+zb5G2D7f0GD1Ncuqe9zPt1sUkWT6ozG
         gFkNe0h8ndU7RPquqnulUMzd59FO/OfpZrNXiouV+GAhWDMv+JOUa2nLO2HhO6s2ozS2
         XA5Sm30a6xGQ9zCNLc/6JnUQBtBj769TQe2Bn2gYZygbmfT2jJu+6wZezt7aRwi1JIXw
         c32p8i594dXqFg2nmSpDnYG8XbGvI68OEr8h5zKaP0cCGfDscN7rGj98vjZjn6chvCfJ
         bS4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542880; x=1782147680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HRgi9IQAcgUhYKVcTYQF87GovFmdNDLDpUKpgEBopY=;
        b=bGGKIu0kPW0WjICCtfXEpNVbiU2eXdbgbUUa1rWWZiOpIOp5t398MSswtorX1lcK2B
         AHFUqSssaVGSAfSWC3iaAocw8B6BsbA1Vksgb4YY7ZNoZEKpOS7zdFathkHcmsbVmnsw
         4ywSET8kcsSdnvJnHiSnx5axtJXbHoSKZMnw+evnettJ3hHQ7zuqcD+42dperEW0CKkg
         HTNQrZxbexu6QkTcKJdIz7fR8I89/VfGOWHsqeiOkMPLgdFOOcD6mLyYNDCjh/NM5gkw
         Nh4PNxxuKGBhPTvJzJ8GnKJ4XKKGUOAc5gpTlSXHgwib3oG3zzYoWsXjwZYeKQg+Cyt6
         nsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542880; x=1782147680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HRgi9IQAcgUhYKVcTYQF87GovFmdNDLDpUKpgEBopY=;
        b=SH/smNgUjwIH5aUguT1h2xcC/XSWjYRgCZ7WOqhZX0BHXCJ113yGmbe4odpfHIDYNa
         nCArkwrQjnha+0UiGH4aU5BX1mLMAMpXHXIFKm1sFEONuT7J3PneOFA1wC0iggjb0aMV
         4mhgdFwQvghfoxp6dXfLsMx03BVYhUxXTvGYGa18y2EXe1SnjXr+hft448OnkS0JdG4y
         ioszNpYrEO1aW+raGLIhEUSv6qRP4+FzXez2O62273ZOFutNNorthN/Lm/4fctaKr9xG
         4E1Dt2qwOI6RuQGzhEnmyd1Ui/0Fsn2GC9H58LRK5XogpvLdwcXG+KTjCTmPuELQt8Ti
         DoIQ==
X-Gm-Message-State: AOJu0YwTdbqdUT2pZ5rTjicw9ztgoyWHncojBlLz9wTvEbGNEamGV5kZ
	AdKBWcQXXsLzmemK9JyBs3Jrt42IIJhZf2U2RfdMXcxyG0XL/Hc9ovxwJeGL2NlUQTHHtNmWGam
	oGDnw4mtaVWeFvyhcUq4j3Q6OBWzVOLE=
X-Gm-Gg: Acq92OHZuopVOXPvd9ytrDiWGXbPLTlX4HUieTUwfocmlgV3xnNrYyNFmARcokMALEP
	iVVYAE4iRjz7tAZxUhyp7WpDdaO5MACjCAAhY8cGh8nDDfWddoqPcjE/o0GRHpNihH8b1DP9UZv
	1wGx1gifpe8KqsqT7lzZOW46S3ANx4Jrgz53URi8VaCd24xsMiuL1vm5hM9+3aAn+Nq3HKYXACL
	KZX/PSLiwZPHvgBfOg1Dh+vOslaxSbpkpjFRLMSyEiLSg+irwVRfH6Qu483Uj33Vg2WMpbQReqh
	YiwSdec=
X-Received: by 2002:a05:6a00:2403:b0:834:efcb:12b4 with SMTP id
 d2e1a72fcca58-844e1a309b9mr12811390b3a.28.1781542879534; Mon, 15 Jun 2026
 10:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614162323.18730-1-kalevi@kolttonen.fi> <CAEjxPJ6C7ST4B6Xuq1dvE7Bx7EuZ1NVzh6yE7w0VRziXKHORiQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6C7ST4B6Xuq1dvE7Bx7EuZ1NVzh6yE7w0VRziXKHORiQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 13:01:07 -0400
X-Gm-Features: AVVi8CcFCWzqMrSHEWzklgceEIHBKtwX_3gSl8mT1VGZX97l00jnVRNe9vUBSvQ
Message-ID: <CAEjxPJ58UmimfTz9VhOVbUyGEyGWA7G5SfVs1iRf03-Fnfe9sQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jun 14, 2026 at 12:23=E2=80=AFPM Kalevi Kolttonen <kalevi@koltton=
en.fi> wrote:
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

By the way, note that several of your patches had exactly the same
subject line even though they were modifying different files or
components; it would be better to either combine them into one patch
(if a single logical change) or use a different leading prefix to
indicate what they modify.

>
> > ---
> >  policycoreutils/newrole/newrole.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index 19271c2a..8f75706e 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -55,6 +55,7 @@
> >  #error NAMESPACE_PRIV needs the USE_PAM option
> >  #endif
> >
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h> /* for malloc(), realloc(), free() */
> >  #include <pwd.h> /* for getpwuid() */
> > @@ -390,11 +391,11 @@ static int authenticate_via_shadow_passwd(const c=
har *uname)
> >
> >  /**
> >   * This function checks to see if the shell is known in /etc/shells.
> > - * If so, it returns 1. On error or illegal shell, it returns 0.
> > + * If so, it returns true. On error or illegal shell, it returns false=
.
> >   */
> > -static int verify_shell(const char *shell_name)
> > +static bool verify_shell(const char *shell_name)
> >  {
> > -       int found =3D 0;
> > +       bool found =3D false;
> >         const char *buf;
> >
> >         if (!(shell_name && shell_name[0]))
> > @@ -407,7 +408,7 @@ static int verify_shell(const char *shell_name)
> >
> >                 /* check the shell skipping newline char */
> >                 if (!strcmp(shell_name, buf)) {
> > -                       found =3D 1;
> > +                       found =3D true;
> >                         break;
> >                 }
> >         }
> > @@ -457,7 +458,7 @@ static int extract_pw_data(struct passwd *pw_copy)
> >                 goto out_free;
> >         }
> >
> > -       if (verify_shell(pw->pw_shell) =3D=3D 0) {
> > +       if (!verify_shell(pw->pw_shell)) {
> >                 fprintf(stderr, _("Error!  Shell is not valid.\n"));
> >                 goto out_free;
> >         }
> > --
> > 2.54.0
> >
> >
