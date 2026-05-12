Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEF25FA29
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609133; cv=pass; b=EsZg4igfZUFnF0w9vTe9QjUYzkkHZtbXpfAK1NuSMK6/8kssEQTmvQq9FG44WRajtnucynepyeySzSuE3iPDk9tf8Um+nuR9pKmFePlkpQW1BGz8Ls9wT05SUQ8/4x8+KVacIlAD/vUdSVam+M+CeuVLJm4hOzkkB4W9lYFkTNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609133; c=relaxed/simple;
	bh=JsaF8ENiaGHJYK9ZFtCSTYb3NH0YOEuQWS1Q4zU//98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8VuVMOsg6wp13FuXJCx/17rsqMoPSNJsE8gx3tgTULsXdLlJ7OFH3bsPUt58i0gfbi73iQydZxK7mcgyv9CBMlC17duhXoD1hDYEkvdJwQbbIw8hI9doapq8SAUwUodZlbV+5PjDndcmJpS0esrJnx9C1Dgb2MQWEAOrSKD9XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l273LW36; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l273LW36"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393c93a01abso49575761fa.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609130; cv=none;
        d=google.com; s=arc-20240605;
        b=L8XuH39GwGqX+3ZEyJACRIDFVGLox6BQjUz81ttN2X07D6GpO+/5RkwUTxy39T0Kre
         68cOBND4wTNn34VWNAHShHidfeJOsfYRBEyIDbTDTRl9naiEJb3TS5zUxv83my2C6nsa
         3q0uN/XWORDevfUrdtap4H+kITmuQWJ2ilXiUZsNenEmosOrjWyrobHkBJfbZrhiNfP7
         +PimZmkUTwapnyGPLmrjedmC+j8XWEvZiphI2RNRWgiE7wIdzVpTeP/yoMpyuh8KCzbq
         +naIGZfH0ZGUNnPAWwWXSyPWz3SwbUYyeFnHl+ks3PjRMDrK5MyESdy/fiHa0ikNctAc
         GeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alLwJzp7RoL+tmJ+kZmqg1kS85H7oI3eIxIwdB/SG9Y=;
        fh=KvSoq69ZmuetYYVfARox4VMQVrnYOas6NoD6yMzQ270=;
        b=Sp2kKY9KfRwvMiDxeFzsOW+RJFBd8vt6+BLcQ+MDYLa3hodcKn9KgLl2SfnbYpNv1w
         kEG5hiZ/pHVn2bQzO8gbz1AEyWrZ1K4awjlcXRv+oPgNlV0jHkRCYyKAitpYBFrG9voq
         3w4yhDjVrIYFpsWKNVj31rGhENhy/gsQ8hkzC6KMLwHzatgX6v7oyZ2osRPSJGsMD1pw
         8IDAOOn1dOraehTMvuJt19VyGwy+TJjJ1KHRBaFm1dQrZkI3RiOPPBk/1vRMlqT5Wi7S
         /m4JCBjlbsog4FgUPxBqBEdzFEu7DEgYDAA4sM/DCiIMX07tLJ3u93bMexpShwr696O3
         Z3Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609130; x=1779213930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alLwJzp7RoL+tmJ+kZmqg1kS85H7oI3eIxIwdB/SG9Y=;
        b=l273LW36rNNqsst9pjMRkmjq16aFRBpPKk/f9DhD2RNVZi60kblGMsurGc4vUhDNeP
         7b16tdvU4XJ4fjipJOXldypR8ZSc+7TiKkiouoysdlxfPtyrpZKvi4LHnnwjtd9WoDZy
         lBdPhIkhkx/X07eX3r1QfQAkmL44SdkyLyCHCIJX/UhGF+DvJLHgpJoNeYzljrckZFG1
         PEZfEWax+luzCqSKyuOxlsH39sXNUad+QsM6rcsc44dbTOlMA7ls2moFeyyOP+VjNJLy
         s1VTKDSPDfncPd6/tUTJW0LHOrxg/OH0i3VNgz4dXSnq3zC/3JS+76kdzhHf7xmsGYWc
         W/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609130; x=1779213930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alLwJzp7RoL+tmJ+kZmqg1kS85H7oI3eIxIwdB/SG9Y=;
        b=BlLAO2TiSU28gJoR9W9+xPFyTZdaeuw8BfK4q1KCfh9EELZ6G6u7NLKvwKzuI43/Qv
         L/JNfR4EURR1IY2usv5pGDbvPjKIwZEE3V65cRP1k+m24wnci9thnSCLkuhm3ibjqczs
         X9HSDHvPqC43/xpmzHQW9Zg6/SmbyUTeKAo0ICWv8zg868+L52wV1tyc7xjW2a2a+7s3
         +XMP/PxhHyaBaIh3PLDk340vsrA23zM4LlRjq3tesS8+wQgAyAdvlxGeNaW/MMNs3SlM
         YYeUNrPYj7wk7IcTGD5jRzIu+I4In/IcGqDZinoBNlXgoOhAeqT9lVUt6m2BI1fOdDRK
         ufxA==
X-Gm-Message-State: AOJu0Yxq7dnBMAzD3zMbW4ejEMVNm1YiyiuUYn8mGcu1wXNnendM4tZV
	w+zVxjhSBnXMxJWoCU6sRZzTRCsZqTqFW9vptZiL5BP/ZDC+zryCAAfGOBoaO7Yqg9AjKuW/UlH
	j46wyfxEjvDwtOjO9797NugN5DB6iw18=
X-Gm-Gg: Acq92OH50R/okl1jLeAjZVYSm5sI6dRWsNXla3UGf4huy9Gm8mlLd3qpwlg1Sfh7zPe
	gvpqaoU9pXysyGxG6HEPDm2nMK0eftOLwf/6R5BMC479Q191YHCUIUkGAz17pYtGr22Rf1/FgCg
	b4UV3dJ28N/dENnxN2ClA3WpbJ2zUFwLjdw1ITXVXdByOPlJaWBrXRmvIMPQnh3boeOnpogrCci
	M2wVppl3m1Nxf1bMh+fXVCNchVz6ue+P8hGFhykUsqiRWJyBtT0AsPKh/Y3xe2GP+OIXm/pCd+f
	JE3C
X-Received: by 2002:a05:651c:887:b0:394:1c6:6dd3 with SMTP id
 38308e7fff4ca-3944b3e231cmr68461fa.4.1778609129383; Tue, 12 May 2026 11:05:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC-oOXP04oBE7ciLr7eZBx857uw8sQm6u5v1DpjwYzfzY8vvVA@mail.gmail.com>
 <20260427123304.74899-1-lautrbach@redhat.com> <878qa8tvs5.fsf@redhat.com>
In-Reply-To: <878qa8tvs5.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 14:05:18 -0400
X-Gm-Features: AVHnY4KapTk5YaLedksrWhdsGr-zgFiDjbhxgTvnXbK5oDH7F9NOIx9xF6dNF88
Message-ID: <CAP+JOzQw0Wrro2p8uRSyzt7BgZMJjrEUEUCSOKaauqOi+j1g2w@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/secon: fix discarded-qualifiers warning
 with glibc 2.43
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Dustin Kirkland <dustin.kirkland@chainguard.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 8:54=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Petr Lautrbach <lautrbach@redhat.com> writes:
>
> > From: Dustin Kirkland <dustin.kirkland@chainguard.dev>
> >
> > In my_getXcon_raw(), ptr is declared as const char * but is assigned
> > from fgets(), which returns char *. With glibc 2.43, strchr(const char
> > *, int) now returns const char *, so the subsequent assignment to
> > char *tmp triggers:
> >
> >   secon.c:365:18: error: initialization discards 'const' qualifier
> >   from pointer target type [-Werror=3Ddiscarded-qualifiers]
> >
> > The const on ptr was always incorrect: fgets() returns a mutable
> > pointer into buf (a char[4096]), and the result of strchr() through
> > ptr is written to via *tmp =3D 0. Remove the erroneous const.
> >
> > This is the same class of bug reported in issue #506
> > (libselinux/src/selinux_config.c:284). The fix here is analogous:
> > the variable should not have been const-qualified in the first place.
> >
> > Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >
> > Resent of the original patch downloaded from githu as the original patc=
h in the
> > email was slightly broken.
> >
> >  policycoreutils/secon/secon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/seco=
n.c
> > index d624fa136f3e..9a05cf1959ba 100644
> > --- a/policycoreutils/secon/secon.c
> > +++ b/policycoreutils/secon/secon.c
> > @@ -348,7 +348,7 @@ static int my_getXcon_raw(pid_t pid, char  **con, c=
onst char *val)
> >  {
> >       char buf[4096];
> >       FILE *fp =3D NULL;
> > -     const char *ptr =3D NULL;
> > +     char *ptr =3D NULL;
> >
> >       snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)p=
id,
> >                val);
> > --
> > 2.54.0
>
>
