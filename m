Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2026C001DF
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjHDSkd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDSkc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:40:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C69BA
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:40:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso3976433e87.1
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174427; x=1691779227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQLL53rttS76M1dKbYvsP//9z2oKOnMCRcX0bZkYoIU=;
        b=URaQAYJqAqPlMOmjZABWBR2mEgofqFkrL1TrugE/vUamcMHKvOHMoG865dWClvTj0s
         AnfTm91c3XLPhnGT4WJSUrxyzsXtjaqKaSNZAwLuR67FtE9Zi4H+8s0RxNXAblYSMldw
         bcf9IdfGezCFMOr3e6xJSLiE+rAriA/pcTDkSyYPYSI7gc9YmLJ22q6AFsVYlcvymmOs
         27Zd/y4iY/G/OHz8AhsPzNeYhuSad1tMKef4AlfuECbg4EMCtLvrF4qjhaoMIIRaPNtu
         GvHgiq6saUwmxP6f/cAVQuWmEs7JaDArFxqgp3FNVQjUwEuSvw3VuM1o2zaocaHRNNmN
         eHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174427; x=1691779227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQLL53rttS76M1dKbYvsP//9z2oKOnMCRcX0bZkYoIU=;
        b=Z/r8h0sHmMq80eRvO0VvOzEITAhN8j910CkK7fXUYJ/NDL+LyIqZZvrciYUL4LvB5z
         wv9O5s8xUB8XYwQHH+nz+olBTlFsCMSB/LyAuRZR4TWEcJQc1Y1j+cSko0JUWEG7w7aS
         s1/GXIHeKN/aXwEMeUBwMH3BSUFogQHXhHd2uzXMO8z1fpdFaGzndA7DKSL659ik9vg0
         vaw0ucyTY4ZJacsIn97v07LNFPyMvchWW0ZhLLBE3BKrndzIymcGxy8PHo8M4RhIkhG2
         4UQJzphbUrKT/PzUWoWtqKExeRQvpwjSWKg/ndkoBU/iNtP3aZGu4U/wXqaNbYajs7f/
         p/RA==
X-Gm-Message-State: AOJu0YwnbeoduCEmfmRI4Wj6d9NEmqwkgbKcvA8vHLp5m0xhhwSxN/WY
        cTmEajJtq1wHxHUEKnviNl1MfzG7Pn057A5qdBM+jZ4H
X-Google-Smtp-Source: AGHT+IGF9WlU0oY6PfR1cLpq9SK8qUiYUqaSmnSm84ABPg4UEhH4oo0SCYqZLMnaCC6brSHfLs/dcPZE5+VeZHYfQiw=
X-Received: by 2002:a2e:9254:0:b0:2b9:c4ce:558f with SMTP id
 v20-20020a2e9254000000b002b9c4ce558fmr1891946ljg.37.1691174427249; Fri, 04
 Aug 2023 11:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230719173635.934-1-stephen.smalley.work@gmail.com> <CAP+JOzRzgUeXo2ASBunJA7uVf99TCoJS-RqBty=s=rc5qxexKw@mail.gmail.com>
In-Reply-To: <CAP+JOzRzgUeXo2ASBunJA7uVf99TCoJS-RqBty=s=rc5qxexKw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:40:15 -0400
Message-ID: <CAP+JOzRycAmjm6zdGKFiGFDcjEQVAdgw=kD49w9+j0vwZmORfg@mail.gmail.com>
Subject: Re: [PATCH userspace] checkpolicy,libselinux,libsepol,policycoreutils,semodule-utils:
 update my email
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 20, 2023 at 3:17=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Jul 19, 2023 at 1:37=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update my email address.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  checkpolicy/checkmodule.8                               | 1 -
> >  checkpolicy/checkpolicy.8                               | 4 ++--
> >  checkpolicy/checkpolicy.c                               | 2 +-
> >  checkpolicy/policy_define.c                             | 2 +-
> >  checkpolicy/policy_parse.y                              | 2 +-
> >  checkpolicy/policy_scan.l                               | 2 +-
> >  checkpolicy/queue.c                                     | 2 +-
> >  checkpolicy/queue.h                                     | 2 +-
> >  checkpolicy/ru/checkmodule.8                            | 1 -
> >  checkpolicy/ru/checkpolicy.8                            | 4 ++--
> >  libselinux/man/man3/avc_has_perm.3                      | 2 +-
> >  libselinux/man/man3/matchpathcon.3                      | 2 +-
> >  libselinux/man/man3/matchpathcon_checkmatches.3         | 2 +-
> >  libselinux/man/man3/selinux_lsetfilecon_default.3       | 2 +-
> >  libselinux/man/man3/selinux_set_mapping.3               | 2 +-
> >  libselinux/man/man3/set_matchpathcon_flags.3            | 2 +-
> >  libselinux/src/avc.c                                    | 2 +-
> >  libselinux/src/hashtab.c                                | 2 +-
> >  libselinux/src/hashtab.h                                | 2 +-
> >  libselinux/src/label_file.c                             | 2 +-
> >  libsepol/include/sepol/policydb/avtab.h                 | 2 +-
> >  libsepol/include/sepol/policydb/constraint.h            | 2 +-
> >  libsepol/include/sepol/policydb/context.h               | 2 +-
> >  libsepol/include/sepol/policydb/ebitmap.h               | 2 +-
> >  libsepol/include/sepol/policydb/flask_types.h           | 2 +-
> >  libsepol/include/sepol/policydb/hashtab.h               | 2 +-
> >  libsepol/include/sepol/policydb/mls_types.h             | 2 +-
> >  libsepol/include/sepol/policydb/policydb.h              | 2 +-
> >  libsepol/include/sepol/policydb/services.h              | 2 +-
> >  libsepol/include/sepol/policydb/sidtab.h                | 2 +-
> >  libsepol/include/sepol/policydb/symtab.h                | 2 +-
> >  libsepol/man/man3/sepol_check_context.3                 | 2 +-
> >  libsepol/man/man8/genpolbools.8                         | 2 +-
> >  libsepol/src/assertion.c                                | 2 +-
> >  libsepol/src/avtab.c                                    | 2 +-
> >  libsepol/src/ebitmap.c                                  | 2 +-
> >  libsepol/src/hashtab.c                                  | 2 +-
> >  libsepol/src/mls.c                                      | 2 +-
> >  libsepol/src/mls.h                                      | 2 +-
> >  libsepol/src/policydb.c                                 | 2 +-
> >  libsepol/src/services.c                                 | 2 +-
> >  libsepol/src/sidtab.c                                   | 2 +-
> >  libsepol/src/symtab.c                                   | 2 +-
> >  libsepol/src/write.c                                    | 2 +-
> >  policycoreutils/load_policy/load_policy.8               | 2 +-
> >  policycoreutils/load_policy/ru/load_policy.8            | 2 +-
> >  policycoreutils/newrole/hashtab.c                       | 2 +-
> >  policycoreutils/newrole/hashtab.h                       | 2 +-
> >  policycoreutils/setfiles/ru/setfiles.8                  | 2 +-
> >  policycoreutils/setfiles/setfiles.8                     | 2 +-
> >  semodule-utils/semodule_package/ru/semodule_unpackage.8 | 2 +-
> >  semodule-utils/semodule_package/semodule_unpackage.8    | 2 +-
> >  52 files changed, 52 insertions(+), 54 deletions(-)
> >
> > diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
> > index ed9efd4c..93c9b537 100644
> > --- a/checkpolicy/checkmodule.8
> > +++ b/checkpolicy/checkmodule.8
> > @@ -75,4 +75,3 @@ SELinux Reference Policy documentation at https://git=
hub.com/SELinuxProject/refp
> >  This manual page was copied from the checkpolicy man page
> >  written by =C3=81rp=C3=A1d Magos=C3=A1nyi <mag@bunuel.tii.matav.hu>,
> >  and edited by Dan Walsh <dwalsh@redhat.com>.
> > -The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
> > diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> > index 54724f59..81a3647d 100644
> > --- a/checkpolicy/checkpolicy.8
> > +++ b/checkpolicy/checkpolicy.8
> > @@ -84,5 +84,5 @@ SELinux Reference Policy documentation at https://git=
hub.com/SELinuxProject/refp
> >
> >  .SH AUTHOR
> >  This manual page was written by =C3=81rp=C3=A1d Magos=C3=A1nyi <mag@bu=
nuel.tii.matav.hu>,
> > -and edited by Stephen Smalley <sds@tycho.nsa.gov>.
> > -The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
> > +and edited by Stephen Smalley <stephen.smalley.work@gmail.com>.
> > +The program was written by Stephen Smalley <stephen.smalley.work@gmail=
.com>.
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index 623ba8b2..fcec6e51 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -1,6 +1,6 @@
> >
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  /*
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 8421b253..ea6d9e61 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  /*
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 6b6890a3..03e687e8 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -1,6 +1,6 @@
> >
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  /*
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 9ffac353..ea0be269 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -1,6 +1,6 @@
> >
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  /* Updated: David Caplan, <dac@tresys.com>
> > diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
> > index 82e66732..9f4c651a 100644
> > --- a/checkpolicy/queue.c
> > +++ b/checkpolicy/queue.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/checkpolicy/queue.h b/checkpolicy/queue.h
> > index 60c07fe0..45116dee 100644
> > --- a/checkpolicy/queue.h
> > +++ b/checkpolicy/queue.h
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/checkpolicy/ru/checkmodule.8 b/checkpolicy/ru/checkmodule.=
8
> > index d7d3f65c..c6125904 100644
> > --- a/checkpolicy/ru/checkmodule.8
> > +++ b/checkpolicy/ru/checkmodule.8
> > @@ -52,5 +52,4 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
> >  .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> >  =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D1=81=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=
=D0=BD=D0=B0 =D1=81=D0=BE =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=8B =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 checkpol=
icy, =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =C3=81rp=
=C3=A1d Magos=C3=A1nyi <mag@bunuel.tii.matav.hu>,
> >  =D0=B8 =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 Dan Walsh <dwalsh@redhat.com>.
> > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<sds@tycho.nsa.gov>.
> >  =D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=
=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=
=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=9E=D0=BB=D0=B5=D1=81=D1=8F =D0=93=
=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE <gammaray@base=
alt.ru>.
> > diff --git a/checkpolicy/ru/checkpolicy.8 b/checkpolicy/ru/checkpolicy.=
8
> > index f08d1dc9..bc9da9da 100644
> > --- a/checkpolicy/ru/checkpolicy.8
> > +++ b/checkpolicy/ru/checkpolicy.8
> > @@ -55,6 +55,6 @@ checkpolicy \- =D0=BA=D0=BE=D0=BC=D0=BF=D0=B8=D0=BB=
=D1=8F=D1=82=D0=BE=D1=80 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 S=
ELinux
> >
> >  .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> >  =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 =C3=81r=
p=C3=A1d Magos=C3=A1nyi <mag@bunuel.tii.matav.hu>,
> > -=D0=B8 =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 Stephen Smalley <sds@tycho.nsa.gov>.
> > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<sds@tycho.nsa.gov>.
> > +=D0=B8 =D0=BE=D1=82=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 Stephen Smalley <stephen.smalley.work@gmail.com=
>.
> > +=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<stephen.smalley.work@gmail.com>.
> >  =D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=
=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=
=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=9E=D0=BB=D0=B5=D1=81=D1=8F =D0=93=
=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE <gammaray@base=
alt.ru>.
> > diff --git a/libselinux/man/man3/avc_has_perm.3 b/libselinux/man/man3/a=
vc_has_perm.3
> > index 62809f9a..9ea7c35d 100644
> > --- a/libselinux/man/man3/avc_has_perm.3
> > +++ b/libselinux/man/man3/avc_has_perm.3
> > @@ -176,7 +176,7 @@ Make sure that userspace object managers are grante=
d appropriate access to
> >  netlink by the policy.
> >  .
> >  .SH "AUTHOR"
> > -Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov=
>
> > +Originally Eamon Walsh.  Updated by Stephen Smalley <stephen.smalley.w=
ork@gmail.com>
> >  .
> >  .SH "SEE ALSO"
> >  .ad l
> > diff --git a/libselinux/man/man3/matchpathcon.3 b/libselinux/man/man3/m=
atchpathcon.3
> > index 177f15d7..88bc47c0 100644
> > --- a/libselinux/man/man3/matchpathcon.3
> > +++ b/libselinux/man/man3/matchpathcon.3
> > @@ -1,4 +1,4 @@
> > -.TH "matchpathcon" "3" "21 November 2009" "sds@tycho.nsa.gov" "SELinux=
 API documentation"
> > +.TH "matchpathcon" "3" "21 November 2009" "stephen.smalley.work@gmail.=
com" "SELinux API documentation"
> >  .SH "NAME"
> >  matchpathcon, matchpathcon_index \- get the default SELinux security c=
ontext for the specified path from the file contexts configuration
> >  .
> > diff --git a/libselinux/man/man3/matchpathcon_checkmatches.3 b/libselin=
ux/man/man3/matchpathcon_checkmatches.3
> > index 6bbee44a..8e1cd2ad 100644
> > --- a/libselinux/man/man3/matchpathcon_checkmatches.3
> > +++ b/libselinux/man/man3/matchpathcon_checkmatches.3
> > @@ -1,4 +1,4 @@
> > -.TH "matchpathcon_checkmatches" "3" "21 November 2009" "sds@tycho.nsa.=
gov" "SELinux API documentation"
> > +.TH "matchpathcon_checkmatches" "3" "21 November 2009" "stephen.smalle=
y.work@gmail.com" "SELinux API documentation"
> >  .SH "NAME"
> >  matchpathcon_checkmatches, matchpathcon_filespec_add, matchpathcon_fil=
espec_destroy, matchpathcon_filespec_eval \- check and report whether any s=
pecification index has no matches with any inode. Maintenance and statistic=
s on inode associations
> >  .
> > diff --git a/libselinux/man/man3/selinux_lsetfilecon_default.3 b/libsel=
inux/man/man3/selinux_lsetfilecon_default.3
> > index d4fc6583..5d6b2e3c 100644
> > --- a/libselinux/man/man3/selinux_lsetfilecon_default.3
> > +++ b/libselinux/man/man3/selinux_lsetfilecon_default.3
> > @@ -1,4 +1,4 @@
> > -.TH "selinux_lsetfilecon_default" "3" "21 November 2009" "sds@tycho.ns=
a.gov" "SELinux API documentation"
> > +.TH "selinux_lsetfilecon_default" "3" "21 November 2009" "stephen.smal=
ley.work@gmail.com" "SELinux API documentation"
> >  .SH "NAME"
> >  selinux_lsetfilecon_default \- set the file context to the system defa=
ults
> >  .
> > diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man=
/man3/selinux_set_mapping.3
> > index 4624fbc7..a1f82e5a 100644
> > --- a/libselinux/man/man3/selinux_set_mapping.3
> > +++ b/libselinux/man/man3/selinux_set_mapping.3
> > @@ -93,7 +93,7 @@ and
> >  class) will be identified by 1, 2, 4, and 8 respectively.  Classes and=
 permissions not listed in the mapping cannot be used.
> >  .
> >  .SH "AUTHOR"
> > -Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov=
>
> > +Originally Eamon Walsh.  Updated by Stephen Smalley <stephen.smalley.w=
ork@gmail.com>
> >  .
> >  .SH "SEE ALSO"
> >  .BR selinux_check_access (3),
> > diff --git a/libselinux/man/man3/set_matchpathcon_flags.3 b/libselinux/=
man/man3/set_matchpathcon_flags.3
> > index 2841becc..b9b2fed8 100644
> > --- a/libselinux/man/man3/set_matchpathcon_flags.3
> > +++ b/libselinux/man/man3/set_matchpathcon_flags.3
> > @@ -1,4 +1,4 @@
> > -.TH "set_matchpathcon_flags" "3" "21 November 2009" "sds@tycho.nsa.gov=
" "SELinux API documentation"
> > +.TH "set_matchpathcon_flags" "3" "21 November 2009" "stephen.smalley.w=
ork@gmail.com" "SELinux API documentation"
> >  .SH "NAME"
> >  set_matchpathcon_flags, set_matchpathcon_invalidcon, set_matchpathcon_=
printf \- set flags controlling the operation of matchpathcon or matchpathc=
on_index and configure the behaviour of validity checking and error display=
ing
> >  .
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index 8d5983a2..5e1c036e 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -4,7 +4,7 @@
> >   * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
> >   *
> >   * Derived from the kernel AVC implementation by
> > - * Stephen Smalley <sds@tycho.nsa.gov> and
> > + * Stephen Smalley <stephen.smalley.work@gmail.com> and
> >   * James Morris <jmorris@redhat.com>.
> >   */
> >  #include <selinux/avc.h>
> > diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
> > index c415ad0d..7452613b 100644
> > --- a/libselinux/src/hashtab.c
> > +++ b/libselinux/src/hashtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
> > index 9d2b593b..f10fc0af 100644
> > --- a/libselinux/src/hashtab.h
> > +++ b/libselinux/src/hashtab.h
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index d489c1f7..3da28c45 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -2,7 +2,7 @@
> >   * File contexts backend for labeling system
> >   *
> >   * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
> > - * Author : Stephen Smalley <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley <stephen.smalley.work@gmail.com>
> >   */
> >
> >  #include <assert.h>
> > diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include=
/sepol/policydb/avtab.h
> > index 7d892879..e807ee4a 100644
> > --- a/libsepol/include/sepol/policydb/avtab.h
> > +++ b/libsepol/include/sepol/policydb/avtab.h
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
> > diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/in=
clude/sepol/policydb/constraint.h
> > index 82335e21..19b24870 100644
> > --- a/libsepol/include/sepol/policydb/constraint.h
> > +++ b/libsepol/include/sepol/policydb/constraint.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/inclu=
de/sepol/policydb/context.h
> > index 025c894f..f78bc700 100644
> > --- a/libsepol/include/sepol/policydb/context.h
> > +++ b/libsepol/include/sepol/policydb/context.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/inclu=
de/sepol/policydb/ebitmap.h
> > index 85b7ccfb..c434c4ba 100644
> > --- a/libsepol/include/sepol/policydb/ebitmap.h
> > +++ b/libsepol/include/sepol/policydb/ebitmap.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/i=
nclude/sepol/policydb/flask_types.h
> > index 02c22eac..32a0b410 100644
> > --- a/libsepol/include/sepol/policydb/flask_types.h
> > +++ b/libsepol/include/sepol/policydb/flask_types.h
> > @@ -1,7 +1,7 @@
> >  /* -*- linux-c -*- */
> >
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  #ifndef _SEPOL_POLICYDB_FLASK_TYPES_H_
> > diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/inclu=
de/sepol/policydb/hashtab.h
> > index 354ebb43..d11a5bda 100644
> > --- a/libsepol/include/sepol/policydb/hashtab.h
> > +++ b/libsepol/include/sepol/policydb/hashtab.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/inc=
lude/sepol/policydb/mls_types.h
> > index 12990c69..a5e27b2a 100644
> > --- a/libsepol/include/sepol/policydb/mls_types.h
> > +++ b/libsepol/include/sepol/policydb/mls_types.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >  /*
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> >   *
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/incl=
ude/sepol/policydb/policydb.h
> > index 48b7b8bb..cf36ee96 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated: Joshua Brindle <jbrindle@tresys.com>
> > diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/incl=
ude/sepol/policydb/services.h
> > index bcb0930f..f2e311aa 100644
> > --- a/libsepol/include/sepol/policydb/services.h
> > +++ b/libsepol/include/sepol/policydb/services.h
> > @@ -2,7 +2,7 @@
> >  /* -*- linux-c -*- */
> >
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >
> >  #ifndef _SEPOL_POLICYDB_SERVICES_H_
> > diff --git a/libsepol/include/sepol/policydb/sidtab.h b/libsepol/includ=
e/sepol/policydb/sidtab.h
> > index 893e6f0b..1bde332c 100644
> > --- a/libsepol/include/sepol/policydb/sidtab.h
> > +++ b/libsepol/include/sepol/policydb/sidtab.h
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/include/sepol/policydb/symtab.h b/libsepol/includ=
e/sepol/policydb/symtab.h
> > index 8b9ddca9..72b3276e 100644
> > --- a/libsepol/include/sepol/policydb/symtab.h
> > +++ b/libsepol/include/sepol/policydb/symtab.h
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/man/man3/sepol_check_context.3 b/libsepol/man/man=
3/sepol_check_context.3
> > index 4a3c57d1..152ac0b0 100644
> > --- a/libsepol/man/man3/sepol_check_context.3
> > +++ b/libsepol/man/man3/sepol_check_context.3
> > @@ -1,4 +1,4 @@
> > -.TH "sepol_check_context" "3" "15 March 2005" "sds@tycho.nsa.gov" "SE =
Linux binary policy API documentation"
> > +.TH "sepol_check_context" "3" "15 March 2005" "stephen.smalley.work@gm=
ail.com" "SE Linux binary policy API documentation"
> >  .SH "NAME"
> >  sepol_check_context \- Check the validity of a security context agains=
t a binary policy.
> >  .SH "SYNOPSIS"
> > diff --git a/libsepol/man/man8/genpolbools.8 b/libsepol/man/man8/genpol=
bools.8
> > index fc792c8c..e7196ee7 100644
> > --- a/libsepol/man/man8/genpolbools.8
> > +++ b/libsepol/man/man8/genpolbools.8
> > @@ -1,4 +1,4 @@
> > -.TH "genpolbools" "8" "11 August 2004" "sds@tycho.nsa.gov" "SELinux Co=
mmand Line documentation"
> > +.TH "genpolbools" "8" "11 August 2004" "stephen.smalley.work@gmail.com=
" "SELinux Command Line documentation"
> >  .SH "NAME"
> >  genpolbools \- Rewrite a binary policy with different boolean settings
> >  .SH "SYNOPSIS"
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index 11185253..b6ac4cfe 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -1,7 +1,7 @@
> >  /* Authors: Joshua Brindle <jbrindle@tresys.com>
> >   *
> >   * Assertion checker for avtab entries, taken from
> > - * checkpolicy.c by Stephen Smalley <sds@tycho.nsa.gov>
> > + * checkpolicy.c by Stephen Smalley <stephen.smalley.work@gmail.com>
> >   *
> >   * Copyright (C) 2005 Tresys Technology, LLC
> >   *
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 99fdaa87..319b85ae 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index 3ec1042f..2348add4 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> > index 922a8a4a..4a827fd3 100644
> > --- a/libsepol/src/hashtab.c
> > +++ b/libsepol/src/hashtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated : Karl MacMillan <kmacmillan@mentalrootkit.com>
> > diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> > index 4ffe9814..45db8920 100644
> > --- a/libsepol/src/mls.c
> > +++ b/libsepol/src/mls.c
> > @@ -1,4 +1,4 @@
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >  /*
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> >   *
> > diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
> > index befd12c5..14694cce 100644
> > --- a/libsepol/src/mls.h
> > +++ b/libsepol/src/mls.h
> > @@ -1,4 +1,4 @@
> > -/* Author: Stephen Smalley, <sds@tycho.nsa.gov>
> > +/* Author: Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> >   *
> >   *      Support for enhanced MLS infrastructure.
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 552eb77a..ac5be0f8 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 6bddc287..d5322f76 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> > + * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
> >   */
> >  /*
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> > diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
> > index 0cec41d2..def8d313 100644
> > --- a/libsepol/src/sidtab.c
> > +++ b/libsepol/src/sidtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
> > index a6061851..78567dbf 100644
> > --- a/libsepol/src/symtab.c
> > +++ b/libsepol/src/symtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index f0ed9e33..ac119595 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /*
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> > diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutil=
s/load_policy/load_policy.8
> > index 867c35e4..636d8359 100644
> > --- a/policycoreutils/load_policy/load_policy.8
> > +++ b/policycoreutils/load_policy/load_policy.8
> > @@ -39,4 +39,4 @@ Initial policy load failed and enforcing mode request=
ed
> >  .SH AUTHORS
> >  .nf
> >  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> > -The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
> > +The program was written by Stephen Smalley <stephen.smalley.work@gmail=
.com>.
> > diff --git a/policycoreutils/load_policy/ru/load_policy.8 b/policycoreu=
tils/load_policy/ru/load_policy.8
> > index 25140b2e..6c29e30a 100644
> > --- a/policycoreutils/load_policy/ru/load_policy.8
> > +++ b/policycoreutils/load_policy/ru/load_policy.8
> > @@ -37,5 +37,5 @@ load_policy =D0=B7=D0=B0=D0=B3=D1=80=D1=83=D0=B6=D0=
=B0=D0=B5=D1=82 =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BF=D0=BE=D0=BB=D0=B8=D1=
=82=D0=B8
> >  .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> >  .nf
> >  =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
> > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<sds@tycho.nsa.gov>.
> > +=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<stephen.smalley.work@gmail.com>.
> >  =D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=
=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=
=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=
=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@bas=
ealt.ru>.
> > diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrol=
e/hashtab.c
> > index 26d4f4c7..bbd0adf7 100644
> > --- a/policycoreutils/newrole/hashtab.c
> > +++ b/policycoreutils/newrole/hashtab.c
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrol=
e/hashtab.h
> > index 092b96a9..9c00f7cb 100644
> > --- a/policycoreutils/newrole/hashtab.h
> > +++ b/policycoreutils/newrole/hashtab.h
> > @@ -1,5 +1,5 @@
> >
> > -/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +/* Author : Stephen Smalley, <stephen.smalley.work@gmail.com> */
> >
> >  /* FLASK */
> >
> > diff --git a/policycoreutils/setfiles/ru/setfiles.8 b/policycoreutils/s=
etfiles/ru/setfiles.8
> > index 91010145..730b634b 100644
> > --- a/policycoreutils/setfiles/ru/setfiles.8
> > +++ b/policycoreutils/setfiles/ru/setfiles.8
> > @@ -217,5 +217,5 @@ GNU
> >
> >  .SH "=D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB"
> >  =D0=AD=D1=82=D0=B0 man-=D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=
=B0 =D0=B1=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=
=B0 Russell Coker <russell@coker.com.au>.
> > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<sds@tycho.nsa.gov>.
> > +=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<stephen.smalley.work@gmail.com>.
> >  =D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=
=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=
=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=
=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@bas=
ealt.ru>
> > diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setf=
iles/setfiles.8
> > index 892a5062..ee017250 100644
> > --- a/policycoreutils/setfiles/setfiles.8
> > +++ b/policycoreutils/setfiles/setfiles.8
> > @@ -300,7 +300,7 @@ Fix labeling of files listed in file_list file, ign=
oring any that do not exist
> >
> >  .SH "AUTHOR"
> >  This man page was written by Russell Coker <russell@coker.com.au>.
> > -The program was written by Stephen Smalley <sds@tycho.nsa.gov>
> > +The program was written by Stephen Smalley <stephen.smalley.work@gmail=
.com>
> >
> >  .SH "SEE ALSO"
> >  .BR restorecon (8),
> > diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/=
semodule-utils/semodule_package/ru/semodule_unpackage.8
> > index 6c7e234b..057ae3d7 100644
> > --- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
> > +++ b/semodule-utils/semodule_package/ru/semodule_unpackage.8
> > @@ -20,5 +20,5 @@ $ semodule_unpackage httpd.pp httpd.mod httpd.fc
> >  .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> >  .nf
> >  =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
> > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<sds@tycho.nsa.gov>.
> > +=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<stephen.smalley.work@gmail.com>.
> >  =D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=
=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=
=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=
=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@bas=
ealt.ru>.
> > diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/sem=
odule-utils/semodule_package/semodule_unpackage.8
> > index 0432f7a1..79554cef 100644
> > --- a/semodule-utils/semodule_package/semodule_unpackage.8
> > +++ b/semodule-utils/semodule_package/semodule_unpackage.8
> > @@ -21,4 +21,4 @@ $ semodule_unpackage httpd.pp httpd.mod httpd.fc
> >  .SH AUTHORS
> >  .nf
> >  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> > -The program was written by Stephen Smalley <sds@tycho.nsa.gov>
> > +The program was written by Stephen Smalley <stephen.smalley.work@gmail=
.com>
> > --
> > 2.40.1
> >
