Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677A78C91
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971487; cv=none; b=JPv/RrsEl4mNRGEuu+6KvwwcyVzNGBigJp+n6bBQ+7JrqcGHERxTef3rNRLPju9Cprt/SAClBb17W+RLVs2m6zeO7wUx9VGA0noraNuGuqnl6OR67HGF0cLPKspm/a+A0yLlot/f0hrzBw6FaNl/q4tpXFa7+NkpWf88Cb3ax5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971487; c=relaxed/simple;
	bh=z/b7aAt4khxdttx3mPhjRkhRN8t3Bd0oaTE2/b8Er0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU+YAPFNGo4kBTG0IoA+xQykWp9hmFasEP7K67BJSUv+U2fE6WfloQAxLvCvMiqlVMc80C3DK50P+oMVb96nXZuFoMvtC0Yj8fgKlp5NYyQR5xCW7H8y3VAjr1Ejh3+B6hRA8rkALvYEnrUp9ofAHxNCy8bV2dGE2VsTlZ/IMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gagLW+GI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gagLW+GI"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b170c99aa49so656768a12.1
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753971485; x=1754576285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceAP8i1CaafdeQktAwO+FcpNcFMvBgAYdjbGHImqWZA=;
        b=gagLW+GIlB/q//BusaVS+YTJcs3hwCsqdhuC6n2lo7VAwRzYFfJ8LEdJ9HPZue0WfK
         BVt7olRFwUv7bD2Rfw/1FnHLVbJfbMKsEDri7MXcSR/vZWyzrWpWsPTho1K/UtJdkpTo
         i3eBarZZnFXpCL5+1B43LwninKmHP/s1K7m0J0lvTWJeeimaCctvpK3DleYZTtoVYblK
         1/eSjkKuqE3DWlMYQ8ltZ/oAp5OVurEXNDi7WtoJdpr6eFBzdmxtljxjyUc42toV0gTh
         19Js0bsA4dA0i6O2s5Kq7DL7K6UecNtQQ+/i9/I7HSmlFvW6JHV3uE6q5u0Irunyb36U
         VfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971485; x=1754576285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceAP8i1CaafdeQktAwO+FcpNcFMvBgAYdjbGHImqWZA=;
        b=hog1VTN7T9iIhCC9skhCHJX99F8AgGNTwIpNk0Nzp20VmpowpGGg4Kav84+8hNNlCA
         a3vMeG+Y/VGgVwoE7sDFjdbXh0R2nh4R1iMqCBo9LGj+J5xCBxnxr9HXnZC65wfWHcLe
         Q3TeZ+8QwWL3AXQ+FNVlHKLXO8yTHDDukaEwUMIAlZC22HjTuHIdIuRAgb4UaNdXx7/1
         G/UVvGpWt3LQxFMP23DJt2oNsSItBjqu/2omnRYashUH0g94mRR7QaMZ8Z0Q2uAjtisU
         3z+oIqWL9Up9ucf2OXqQLzHgzJBNxzsQQQL8A1wJLtxN3LGwLwsdB+s1WJnqalVP+aDD
         T1dQ==
X-Gm-Message-State: AOJu0YzvP8OX3S4yIaUuIIZIEikx8t3EDhOoPZt/YsswUfFrDPU8/KJS
	b1w267cqU4Ec+cqcem2ucU4KZWzwtVnlAieEoJm9MdrHFWuWxcdfggH2JS8yA4gQg8qutsENUIp
	FcSLz332WtRFws3cFwJDTdr6RMaFrkdE=
X-Gm-Gg: ASbGncuiUe0IGCB0SeDie1jMfrV6ukwPUUQ9o7ASgFtxQSIeeQDNtSJWCWPi05FuUS0
	d7018lbR4g3wuW8BIX3DncLmI+kCXP6W8rRFmrDbnXmGyxYGrWs2EkcdbNR5aYN9oFuPzwSGFDO
	zJdXklR+6B9YFQnNoGiCcRFuP+FBuGcPtpmgGgNVvsCdqjgnPMsC1J5AVoa5wnnnTuJIEpywhEt
	o8+va0=
X-Google-Smtp-Source: AGHT+IGV/QdW2H7y7SA8uWAHTRHVIhC8ke6N5OJRYPlA6RrVkx0s5i7NldtBal3xu18giC+h8GIA2X8xQm3GACHiuec=
X-Received: by 2002:a17:90b:562b:b0:311:eb85:96df with SMTP id
 98e67ed59e1d1-31f5de31dbfmr11101949a91.17.1753971482008; Thu, 31 Jul 2025
 07:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730150723.974292-1-nvraxn@gmail.com> <CAEjxPJ78Ynm52M14_Jm48vkLi2MpXBVoQCbyGavauhwkeHf52A@mail.gmail.com>
In-Reply-To: <CAEjxPJ78Ynm52M14_Jm48vkLi2MpXBVoQCbyGavauhwkeHf52A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 31 Jul 2025 10:17:50 -0400
X-Gm-Features: Ac12FXy5ijBkU6q7sUYI5uDP41-Uy-Vpdj9WX2hYTsh4yA_t47Bg1uVq7_V-U4o
Message-ID: <CAEjxPJ6rxztd+qoxeeY4CfwVDTOB03vngarTxPWr77E43wMegQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: load_policy: log using selinux_log instead of fprintf
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 12:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 30, 2025 at 11:08=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> =
wrote:
> >
> > This allows consumers to override our logging to stderr using the
> > callback based mechanism selinux_log provides.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied.

>
> > ---
> >  libselinux/src/load_policy.c | 37 ++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 18 deletions(-)
> >
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index f67e5538..8e737a23 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -16,6 +16,7 @@
> >  #include <sepol/policydb.h>
> >  #endif
> >  #include <dlfcn.h>
> > +#include "callbacks.h"
> >  #include "policy.h"
> >  #include <limits.h>
> >
> > @@ -136,25 +137,25 @@ int selinux_mkload_policy(int preservebools __att=
ribute__((unused)))
> >                 fd =3D open(path, O_RDONLY | O_CLOEXEC);
> >         }
> >         if (fd < 0) {
> > -               fprintf(stderr,
> > -                       "SELinux:  Could not open policy file <=3D %s.%=
d:  %m\n",
> > -                       selinux_binary_policy_path(), maxvers);
> > +               selinux_log(SELINUX_ERROR,
> > +                           "SELinux:  Could not open policy file <=3D =
%s.%d:  %m\n",
> > +                           selinux_binary_policy_path(), maxvers);
> >                 goto dlclose;
> >         }
> >
> >         if (fstat(fd, &sb) < 0) {
> > -               fprintf(stderr,
> > -                       "SELinux:  Could not stat policy file %s:  %m\n=
",
> > -                       path);
> > +               selinux_log(SELINUX_ERROR,
> > +                           "SELinux:  Could not stat policy file %s:  =
%m\n",
> > +                           path);
> >                 goto close;
> >         }
> >
> >         size =3D sb.st_size;
> >         data =3D map =3D mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0=
);
> >         if (map =3D=3D MAP_FAILED) {
> > -               fprintf(stderr,
> > -                       "SELinux:  Could not map policy file %s:  %m\n"=
,
> > -                       path);
> > +               selinux_log(SELINUX_ERROR,
> > +                           "SELinux:  Could not map policy file %s:  %=
m\n",
> > +                           path);
> >                 goto close;
> >         }
> >
> > @@ -175,9 +176,9 @@ int selinux_mkload_policy(int preservebools __attri=
bute__((unused)))
> >                 if (policydb_set_vers(policydb, kernvers) ||
> >                     policydb_to_image(NULL, policydb, &data, &size)) {
> >                         /* Downgrade failed, keep searching. */
> > -                       fprintf(stderr,
> > -                               "SELinux:  Could not downgrade policy f=
ile %s, searching for an older version.\n",
> > -                               path);
> > +                       selinux_log(SELINUX_ERROR,
> > +                                   "SELinux:  Could not downgrade poli=
cy file %s, searching for an older version.\n",
> > +                                   path);
> >                         policy_file_free(pf);
> >                         policydb_free(policydb);
> >                         munmap(map, sb.st_size);
> > @@ -192,9 +193,9 @@ int selinux_mkload_policy(int preservebools __attri=
bute__((unused)))
> >         rc =3D security_load_policy(data, size);
> >
> >         if (rc)
> > -               fprintf(stderr,
> > -                       "SELinux:  Could not load policy file %s:  %m\n=
",
> > -                       path);
> > +               selinux_log(SELINUX_ERROR,
> > +                           "SELinux:  Could not load policy file %s:  =
%m\n",
> > +                           path);
> >
> >        unmap:
> >         if (data !=3D map)
> > @@ -205,7 +206,7 @@ int selinux_mkload_policy(int preservebools __attri=
bute__((unused)))
> >        dlclose:
> >  #ifdef SHARED
> >         if (errormsg)
> > -               fprintf(stderr, "libselinux:  %s\n", errormsg);
> > +               selinux_log(SELINUX_ERROR, "libselinux:  %s\n", errorms=
g);
> >         if (libsepolh)
> >                 dlclose(libsepolh);
> >  #endif
> > @@ -317,7 +318,7 @@ int selinux_init_load_policy(int *enforce)
> >                         *enforce =3D 0;
> >                 } else {
> >                         /* Only emit this error if selinux was not disa=
bled */
> > -                       fprintf(stderr, "Mount failed for selinuxfs on =
%s:  %m\n", SELINUXMNT);
> > +                       selinux_log(SELINUX_ERROR, "Mount failed for se=
linuxfs on %s:  %m\n", SELINUXMNT);
> >                 }
> >
> >                 if (rc =3D=3D 0)
> > @@ -365,7 +366,7 @@ int selinux_init_load_policy(int *enforce)
> >         if (orig_enforce !=3D *enforce) {
> >                 rc =3D security_setenforce(*enforce);
> >                 if (rc < 0) {
> > -                       fprintf(stderr, "SELinux:  Unable to switch to =
%s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
> > +                       selinux_log(SELINUX_ERROR, "SELinux:  Unable to=
 switch to %s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
> >                         if (*enforce)
> >                                 goto noload;
> >                 }
> > --
> > 2.50.1
> >
> >
