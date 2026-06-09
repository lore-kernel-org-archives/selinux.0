Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB47B42F
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029612; cv=pass; b=Dp9Bjkg3OjmWqkVUD5gqn0N0c183N6J/Vo4EbzfQj3BUfu6qYIPrjEHlwsWo/pljpIYJUvLW0/3CdlnBXPUwQjOxCjhXEtcTlASC7PZ7vzrcKdaU3ahoAMXX/VskAUxVZ7ZT/u9813B7G2o+XC/6XDcXfpomlIxdERazUeEuVbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029612; c=relaxed/simple;
	bh=qgxM1Ytj1HKZ+xlXO/AhynVg0vPsVHeI3rKwBogn/Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mb8Gm6VOW8NZsZMZPLukCeU4+wlyg+tFWYV8vAxjCgp08/zApc/oZy+0Mo6/mM6iNcKzrW91pmAUNfhpEbBs4k9uWh1iBbNwTfEDu6D5cvpTB57Nt6r7D2NkW1Ee07RT74/nLUbPAlYT601YN26gToi4j26e6At+L8Bn69l6PHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW9yRyNb; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW9yRyNb"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3965f215817so52081331fa.3
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 11:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781029609; cv=none;
        d=google.com; s=arc-20240605;
        b=SUhXigRp7aoS3eOSOhwoIN/KzJvsbIbBk0g3cpOuWBYweFfY/Ay1IRKF4toa8ERvwx
         bDMlsssc1FUyx+M9e/jFzZMsp9ogaJiH32cmg9lfGC7lHDFr/8DSPHwPc55CivvnXuSi
         R+KCy+247T8VJf916jbO/Xzq2LGA08QPEdf93uDhXMouYPMeJrpgo95fWBnzqJ+25Yig
         lqYhSsXft/ITqqVE1NhN8ZIwN1XbFeNwLa0JJglo9h3p1W8c0HGeihofBOxbicTWCJsk
         zyMZKk1XpRcbqHXqpArYQTtFOTKKbNZeoQ48CB0V91pjHPcgryKRKajbn7t0agOu9NlK
         uc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oS8DEsef2cRpBK7QsQm6jQoG1z+1ura6VhQIihGo59I=;
        fh=awiB000zUfMcVGmxycbUbg/UQyVXYNPhajlqBz9gu0k=;
        b=RNGB/gtJWsT2MRVJXqm0Pn2HipeX1HFQJPBn9rw1/c57kl879AVddmK/egQ5IeJ80T
         JWsXFrinrO5UG5oeq9sB6A3/xZp5oeIwGKepNrmUhhcYFRSH4OHj/bQ/b2QlY6wU5DR7
         7GPXXpy7QJQaOoMd6c4WDHdyr5lBhrVzgoTK4qtatISW2kUeDv5hx6z/0LG02SBG6oGJ
         PPxcNJXxf97ZJe9FrIC8smAWPjFzfT2QCTqN6utOMcpeydTvxOfleySEYAU4csN6uxZa
         3L1oUm86tahcbNM/Ey+mz9ODxSkPzbpfL7c7fOEjroNPomnCkz8SnAXOSVMBtNN9TK1C
         HKdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029609; x=1781634409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS8DEsef2cRpBK7QsQm6jQoG1z+1ura6VhQIihGo59I=;
        b=LW9yRyNbp7aWDNHZKUzL+jGGpL8JRC17xJrEjuG8Vrjf4WPlPRw/Ae1Q3SfweaUiL5
         qPzenawUk+5vBIvmuikh65MuNuCe9rlHyXNQA6lPll0P8XcN3uV3usFUzqEBrdFWLRpT
         8wu3fyntvE3vnbfvKyIZNiVUL1eOrrnY2YlhKuSD1glmFIgLDtLRRkWbUUQtB5zVoeYo
         nC677m/rmHQlVDbajKIMIgDAJG1IwQ7mkSMP18MwjZwVrU1jqraRXJBJ3vObXIN3KJ29
         cXxgx0gEKW8uDhi7d5IEgoXawV0sV6YDV9DZalD5Qq0wSTfQWH3cpVZZB9HaBE54rxVN
         8U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029609; x=1781634409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS8DEsef2cRpBK7QsQm6jQoG1z+1ura6VhQIihGo59I=;
        b=oO0gotpGfBLBcy+gDt9LlW7qmqHmCbk+dUL2GcHIhwILsJKQymH0ziPeQp92wMgXRf
         +TOeZ2sWuyBm2tf31gaK9mnwi7/9NrRn+Nszvw69Jdgkmvg0sOiVLPlom1yk/LSA0/gw
         Eo8q9E7bQgjiFckimzheB3ZEUH7dfHQ1JE7cyAzUiZ3bSNsUJt4jfjSAVQUBH1lg632W
         gkxyNu44apy1RcZe+FnoKAdXjqjRRX+F6F05VxUgTogmme2QheHeksCQ2SrUmp2tBINJ
         5qlWxMs/3DegUirW+JPkiY0oy9jMmy/cHspPBlW7LNgbs+H3xIm+HKR9SecFaT6HP+21
         OcNA==
X-Gm-Message-State: AOJu0YzBJ99cZWRCr0pwCitNOoSdmBQE3qt/n6Z9OqNE3g/sVuJO2mNq
	5ydSQL13y2GCqwSjBP3i9S4bV4fekzHFedWhF96L+Qk3Vkw8v9C7u/dPkg8DG9GoX0VHYcKioH3
	MBYdfJMTGYd17ldXj5cm7wg2L6qlJGL4=
X-Gm-Gg: Acq92OHrZ3Pj0ylnwgGzdQXr6Pv6p3eEh12lRtlMfj5GumbaKovGA2CrQ1N6RX2OODL
	w2kib7Qma9oj7WVczHVS+XtHCUnMkQchm61jZoogRf/tQAqVnpE+S1NjiKmWcIAKk8Hjb4b8y2m
	XEQWZVf4E8lbpVmlrWfMnkbdBRw2VZ7bvcOj7DH6N8jJ5qWRWEtZ+udi6aA1k13oZnDuNSW9mkl
	DedE9VX5TQc6JwNU2o2pvCSro6pXTSjBfL3k7GbtdcsUxSn+8PRV0wvisT+7UmUZhgAepLEgKi0
	qy4VSiQoZHNjt+k=
X-Received: by 2002:a2e:bc24:0:b0:393:5ada:4605 with SMTP id
 38308e7fff4ca-396d09bcf34mr62692171fa.25.1781029608506; Tue, 09 Jun 2026
 11:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608134720.309839-1-stephen.smalley.work@gmail.com> <CAP+JOzTQ-Eyp=-xJz7FKpn_0omJiOWs1tLkzodV+-Yp4AVVcGA@mail.gmail.com>
In-Reply-To: <CAP+JOzTQ-Eyp=-xJz7FKpn_0omJiOWs1tLkzodV+-Yp4AVVcGA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 9 Jun 2026 14:26:36 -0400
X-Gm-Features: AVVi8CdBpGFqfP5XrGm1UuRvKZSvHfy654Vlw67XUQKaRoINShRRKLUv_Rc3w38
Message-ID: <CAP+JOzQi95KJbKjPt0U-DxF2=yTf8apQuJVabmcCnnEhYyG1Bw@mail.gmail.com>
Subject: Re: [PATCH] libselinux/src/se_linux_internal.c: include stdint.h
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 10:43=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 8, 2026 at 9:47=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> >
> > Include stdint.h to avoid the following uclibc build failure raised
> > since version 3.6 and
> > https://github.com/SELinuxProject/selinux/commit/cb8289c2b237e5f66e4a76=
08ecc6c68abeaeaf55:
> >
> > selinux_internal.c: In function 'reallocarray':
> > selinux_internal.c:25:29: error: 'SIZE_MAX' undeclared (first use in th=
is function)
> >    25 |         if (size && nmemb > SIZE_MAX / size) {
> >       |                             ^~~~~~~~
> > selinux_internal.c:6:1: note: 'SIZE_MAX' is defined in header '<stdint.=
h>'; did you forget to '#include <stdint.h>'?
> >     5 | #include <string.h>
> >   +++ |+#include <stdint.h>
> >     6 |
> > selinux_internal.c:25:29: note: each undeclared identifier is reported =
only once for each function it appears in
> >    25 |         if (size && nmemb > SIZE_MAX / size) {
> >       |                             ^~~~~~~~
> >
> > Fixes:
> >  - http://autobuild.buildroot.org/results/7e627744beaa4f7fdfd488dfacbaa=
fc074a999f7
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_internal.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux=
_internal.c
> > index f83ad16a..f82be475 100644
> > --- a/libselinux/src/selinux_internal.c
> > +++ b/libselinux/src/selinux_internal.c
> > @@ -1,6 +1,7 @@
> >  #include "selinux_internal.h"
> >
> >  #include <errno.h>
> > +#include <stdint.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >
> > --
> > 2.54.0
> >
