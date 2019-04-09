Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05463C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04232084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLIrzC8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDINva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:51:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38616 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDINva (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 09:51:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so15605067ote.5
        for <selinux@vger.kernel.org>; Tue, 09 Apr 2019 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X1nCHL4sD6GK3PF7rM1B3+2P7yOlLHebaIe4/MUJtXo=;
        b=OLIrzC8SYvXypXGQsedDNzXNfUd9TpEjyLDPvRJnJonZwoX6oR8q5zXyyHihRi2fUS
         Jkz5INDGfxp+cJFBewA4uxSRBb+SJ+BM2+qczNPVpWoppyQFga+v/Wlq3+YtV1+B0la8
         fIhYg22DSHT/TnN30fSubVxDtIJQRkgBil7oYdeIPon3uYF/iSaJJcryadZ1KScbFV2X
         /PxgGNBxAmXyHiPF54+cQHFCvFgqGsUTA72ueSU0eQT3EOWWi3GcLtznfldXAYuZu3kN
         55vs+7seBTUuFSbUAePEJAxsoGtJ1HU/JKVOO6uqmUlHd6J01UHvTIijnw/8G5RgR6x+
         fpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X1nCHL4sD6GK3PF7rM1B3+2P7yOlLHebaIe4/MUJtXo=;
        b=SvY4EeIjsa706LCRB7lnnWq5JXAaYLtHi9SLPlTa256n4bUq0Y30SmTVAHGBrH3OKK
         ZRmnhpO5Ldrd00b5tJ9i7LlHJUG60YU4pWWANEM2yncz6fh1FASMvRTXMFUttxIrtpSi
         3WKfLTqpl4OvHG2+izWJmtrJXjax5UuJN6F8qJWf/UFLCyfgR9Lwj+/ythOhRPXh4H6t
         O44+YKaf40mOXn0p+qiXTX98PguxMbI50W5bg7XC/JlchUMYrOJkI4N30EiDpxX7ZojA
         uJhLoAN84m5wWQQX5tlv1sXjrUBcz+sblvxErd9xbbXyoFxvA92XRsj1SWJ7Prxvl4Yg
         NmBQ==
X-Gm-Message-State: APjAAAUCmeIdJIuqf+x4vgyuATuZkXhOwF+iVjXI99tHDbPQDdJ5GclV
        FAUn/aWdbCS0cY/Hed71r8V5JXDwMZcNcbf/v9+yUlMpJVU=
X-Google-Smtp-Source: APXvYqx1EFPc6Ug5Adc2vpcceJryQDus3MSqSEDXMbVAeUyHGIoVjdOK1zJkrp4nUAVbBhA814LsBKkyelUE/YtSX8c=
X-Received: by 2002:a9d:3d03:: with SMTP id a3mr23641180otc.72.1554817889065;
 Tue, 09 Apr 2019 06:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh5ad2SBUcpY5bNzWRSfV5jjXiojy0aaYJXyzY9EqnVZdQ@mail.gmail.com>
 <20190405190102.13987-1-joshua.brindle@crunchydata.com> <CAFftDdp9+P3ZZQoj9pObbOkDuafBjhn_yuJ7MeVOkxnWDruJWA@mail.gmail.com>
 <CAJfZ7=kmJzGmOX9FxLT1KPEFzXzNF3sokdo1bD5mtT1xqzFCKA@mail.gmail.com>
In-Reply-To: <CAJfZ7=kmJzGmOX9FxLT1KPEFzXzNF3sokdo1bD5mtT1xqzFCKA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 9 Apr 2019 06:51:18 -0700
Message-ID: <CAFftDdo4bDM7BG+jHiAKu=hNKRdE3pHiiKM1PG3kfL1YJ6Z2-w@mail.gmail.com>
Subject: Re: [PATCH v5] Add security_validatetrans support
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged:
https://github.com/SELinuxProject/selinux/pull/142

On Sun, Apr 7, 2019 at 1:59 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Apr 5, 2019 at 9:04 PM William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> >
> > On Fri, Apr 5, 2019 at 12:01 PM Joshua Brindle
> > <joshua.brindle@crunchydata.com> wrote:
> > >
> > > It seems validatetrans support was never added to libselinux, despite=
 being added to
> > > selinuxfs in kernel version 4.5
> > >
> > > There is a utility to test, however the targeted policy has no valida=
tetrans rules so some must be added:
> > >
> > > $ cat validatetrans.cil
> > > (mlsvalidatetrans db_table (and (or (or (or (eq l1 l2) (and (eq t3 un=
confined_t) (domby l1 l2))) (and (eq t3 unconfined_t) (dom l1 l2))) (and (e=
q t3 unconfined_t) (incomp l1 l2))) (or (or (or (eq l1 h2) (and (eq t3 unco=
nfined_t) (domby h1 h2))) (and (eq t3 unconfined_t) (dom h1 h2))) (and (eq =
t3 unconfined_t) (incomp h1 h2)))))
> > >
> > > $ sudo semodule -i validatetrans.cil
> > >
> > > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:ini=
t_t:s0:c0 db_table system_u:system_r: # invalid context here
> > > opening /sys/fs/selinux/validatetrans
> > > security_validatetrans returned -1 errno: Invalid argument
> > >
> > > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:ini=
t_t:s0:c0 db_table system_u:system_r:init_t:s0
> > > opening /sys/fs/selinux/validatetrans
> > > security_validatetrans returned -1 errno: Operation not permitted
> > >
> > > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:ini=
t_t:s0:c0 db_table system_u:system_r:unconfined_t:s0
> > > opening /sys/fs/selinux/validatetrans
> > > security_validatetrans returned 0 errno: Success
> > >
> > > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > ---
> > >  libselinux/include/selinux/selinux.h          | 13 +++
> > >  libselinux/man/man3/security_compute_av.3     | 13 ++-
> > >  libselinux/man/man3/security_validatetrans.c  |  1 +
> > >  .../man/man3/security_validatetrans_raw.c     |  1 +
> > >  libselinux/src/selinux_internal.h             |  2 +
> > >  libselinux/src/validatetrans.c                | 94 +++++++++++++++++=
++
> > >  libselinux/utils/.gitignore                   |  1 +
> > >  libselinux/utils/validatetrans.c              | 30 ++++++
> > >  8 files changed, 154 insertions(+), 1 deletion(-)
> > >  create mode 100644 libselinux/man/man3/security_validatetrans.c
> > >  create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
> > >  create mode 100644 libselinux/src/validatetrans.c
> > >  create mode 100644 libselinux/utils/validatetrans.c
> > >
> > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/includ=
e/selinux/selinux.h
> > > index a34d54fc..f54f236b 100644
> > > --- a/libselinux/include/selinux/selinux.h
> > > +++ b/libselinux/include/selinux/selinux.h
> > > @@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char =
* scon,
> > >                                      const char *username,
> > >                                      char *** con);
> > >
> > > +/* Validate a transition. This determines whether a transition from =
scon to newcon
> > > +   using tcon as the target for object class tclass is valid in the =
loaded policy.
> > > +   This checks against the mlsvalidatetrans and validatetrans constr=
aints in the loaded policy.
> > > +   Returns 0 if allowed and -1 if an error occured with errno set */
> > > +extern int security_validatetrans(const char *scon,
> > > +                                 const char *tcon,
> > > +                                 security_class_t tclass,
> > > +                                 const char *newcon);
> > > +extern int security_validatetrans_raw(const char *scon,
> > > +                                     const char *tcon,
> > > +                                     security_class_t tclass,
> > > +                                     const char *newcon);
> > > +
> > >  /* Load a policy configuration. */
> > >  extern int security_load_policy(void *data, size_t len);
> > >
> > > diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/m=
an/man3/security_compute_av.3
> > > index 2aade5fe..a7181bed 100644
> > > --- a/libselinux/man/man3/security_compute_av.3
> > > +++ b/libselinux/man/man3/security_compute_av.3
> > > @@ -1,7 +1,7 @@
> > >  .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au=
" "SELinux API documentation"
> > >  .SH "NAME"
> > >  security_compute_av, security_compute_av_flags, security_compute_cre=
ate, security_compute_create_name, security_compute_relabel,
> > > -security_compute_member, security_compute_user, security_get_initial=
_context \- query
> > > +security_compute_member, security_compute_user, security_validatetra=
ns, security_get_initial_context \- query
> > >  the SELinux policy database in the kernel
> > >  .
> > >  .SH "SYNOPSIS"
> > > @@ -35,6 +35,10 @@ the SELinux policy database in the kernel
> > >  .sp
> > >  .BI "int security_compute_user_raw(char *" scon ", const char *" use=
rname ", char ***" con );
> > >  .sp
> > > +.BI "int security_validatetrans(char *" scon ", const char *" tcon "=
, security_class_t "tclass ", char *" newcon );
> > > +.sp
> > > +.BI "int security_validatetrans_raw(char *" scon ", const char *" tc=
on ", security_class_t "tclass ", char *" newcon );
> > > +.sp
> > >  .BI "int security_get_initial_context(const char *" name ", char **"=
 con );
> > >  .sp
> > >  .BI "int security_get_initial_context_raw(const char *" name ", char=
 **" con );
> > > @@ -100,6 +104,12 @@ is used to determine the set of user contexts th=
at can be reached from a
> > >  source context. It is mainly used by
> > >  .BR get_ordered_context_list ().
> > >
> > > +.BR security_validatetrans ()
> > > +is used to determine if a transition from scon to newcon using tcon =
as the object
> > > +is valid for object class tclass. This checks against the mlsvalidat=
etrans and
> > > +validatetrans constraints in the loaded policy. Returns 0 if allowed=
, and -1
> > > +if an error occured with errno set.
> > > +
> > >  .BR security_get_initial_context ()
> > >  is used to get the context of a kernel initial security identifier s=
pecified by
> > >  .I name
> > > @@ -111,6 +121,7 @@ is used to get the context of a kernel initial se=
curity identifier specified by
> > >  .BR \%security_compute_relabel_raw (),
> > >  .BR \%security_compute_member_raw (),
> > >  .BR \%security_compute_user_raw ()
> > > +.BR \%security_validatetrans_raw ()
> > >  and
> > >  .BR \%security_get_initial_context_raw ()
> > >  behave identically to their non-raw counterparts but do not perform =
context
> > > diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinu=
x/man/man3/security_validatetrans.c
> > > new file mode 100644
> > > index 00000000..a60bca4d
> > > --- /dev/null
> > > +++ b/libselinux/man/man3/security_validatetrans.c
> > > @@ -0,0 +1 @@
> > > +.so man3/security_compute_av.3
> > > diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libse=
linux/man/man3/security_validatetrans_raw.c
> > > new file mode 100644
> > > index 00000000..a60bca4d
> > > --- /dev/null
> > > +++ b/libselinux/man/man3/security_validatetrans_raw.c
> > > @@ -0,0 +1 @@
> > > +.so man3/security_compute_av.3
> > > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selin=
ux_internal.h
> > > index 70b5025d..acd59c7c 100644
> > > --- a/libselinux/src/selinux_internal.h
> > > +++ b/libselinux/src/selinux_internal.h
> > > @@ -29,6 +29,8 @@ hidden_proto(selinux_mkload_policy)
> > >      hidden_proto(security_compute_create_name_raw)
> > >      hidden_proto(security_compute_member_raw)
> > >      hidden_proto(security_compute_relabel_raw)
> > > +    hidden_proto(security_validatetrans)
> > > +    hidden_proto(security_validatetrans_raw)
> > >      hidden_proto(is_selinux_enabled)
> > >      hidden_proto(is_selinux_mls_enabled)
> > >      hidden_proto(freecon)
> > > diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validate=
trans.c
> > > new file mode 100644
> > > index 00000000..2aa300cf
> > > --- /dev/null
> > > +++ b/libselinux/src/validatetrans.c
> > > @@ -0,0 +1,94 @@
> > > +#include <unistd.h>
> > > +#include <sys/types.h>
> > > +#include <fcntl.h>
> > > +#include <stdlib.h>
> > > +#include <stdio.h>
> > > +#include <errno.h>
> > > +#include <string.h>
> > > +#include <limits.h>
> > > +#include "selinux_internal.h"
> > > +#include "policy.h"
> > > +#include "mapping.h"
> > > +
> > > +int security_validatetrans_raw(const char *scon,
> > > +                              const char *tcon,
> > > +                              security_class_t tclass,
> > > +                              const char *newcon)
> > > +{
> > > +       char path[PATH_MAX];
> > > +       char *buf =3D NULL;
> > > +       int size, bufsz;
> > > +       int fd, ret =3D -1;
> > > +       errno =3D ENOENT;
> > > +
> > > +       if (!selinux_mnt) {
> > > +               return -1;
> > > +       }
> > > +
> > > +       snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
> > > +       fd =3D open(path, O_WRONLY | O_CLOEXEC);
> > > +       if (fd < 0) {
> > > +               return -1;
> > > +       }
> > > +
> > > +       errno =3D EINVAL;
> > > +       size =3D selinux_page_size;
> > > +       buf =3D malloc(size);
> > > +       if (!buf) {
> > > +               goto out;
> > > +       }
> > > +
> > > +       bufsz =3D snprintf(buf, size, "%s %s %hu %s", scon, tcon, unm=
ap_class(tclass), newcon);
> > > +       if (bufsz >=3D size || bufsz < 0) {
> > > +               // It got truncated or there was an encoding error
> > > +               goto out;
> > > +       }
> > > +
> > > +       // clear errno for write()
> > > +       errno =3D 0;
> > > +       ret =3D write(fd, buf, strlen(buf));
> > > +       if (ret > 0) {
> > > +               // The kernel returns the bytes written on success, n=
ot 0 as noted in the commit message
> > > +               ret =3D 0;
> > > +       }
> > > +out:
> > > +       free(buf);
> > > +       close(fd);
> > > +       return ret;
> > > +}
> > > +
> > > +hidden_def(security_validatetrans_raw)
> > > +
> > > +int security_validatetrans(const char *scon,
> > > +                          const char *tcon,
> > > +                          security_class_t tclass,
> > > +                          const char *newcon)
> > > +{
> > > +       int ret =3D -1;
> > > +       char *rscon =3D NULL;
> > > +       char *rtcon =3D NULL;
> > > +       char *rnewcon =3D NULL;
> > > +
> > > +       if (selinux_trans_to_raw_context(scon, &rscon)) {
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (selinux_trans_to_raw_context(tcon, &rtcon)) {
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (selinux_trans_to_raw_context(newcon, &rnewcon)) {
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret =3D security_validatetrans_raw(rscon, rtcon, tclass, rnew=
con);
> > > +
> > > +out:
> > > +       freecon(rnewcon);
> > > +       freecon(rtcon);
> > > +       freecon(rscon);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +hidden_def(security_validatetrans)
> > > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignor=
e
> > > index 5cd01025..aba18a3c 100644
> > > --- a/libselinux/utils/.gitignore
> > > +++ b/libselinux/utils/.gitignore
> > > @@ -25,3 +25,4 @@ setenforce
> > >  setfilecon
> > >  togglesebool
> > >  selinux_check_access
> > > +validatetrans
> > > diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/vali=
datetrans.c
> > > new file mode 100644
> > > index 00000000..1db33e66
> > > --- /dev/null
> > > +++ b/libselinux/utils/validatetrans.c
> > > @@ -0,0 +1,30 @@
> > > +#include <unistd.h>
> > > +#include <sys/types.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <selinux/selinux.h>
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +       security_class_t tclass;
> > > +       int ret;
> > > +
> > > +       if (argc !=3D 5) {
> > > +               fprintf(stderr, "usage:  %s scontext tcontext tclass =
newcontext\n",
> > > +                       argv[0]);
> > > +               exit(1);
> > > +       }
> > > +
> > > +       tclass =3D string_to_security_class(argv[3]);
> > > +       if (!tclass) {
> > > +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0],=
 argv[3]);
> > > +               exit(2);
> > > +       }
> > > +
> > > +       ret =3D security_validatetrans(argv[1], argv[2], tclass, argv=
[4]);
> > > +       printf("security_validatetrans returned %d errno: %s\n", ret,=
 strerror(errno));
> > > +
> > > +       return ret;
> > > +}
> > > --
> > > 2.17.2
> > >
> >
> > ack - staged: https://github.com/SELinuxProject/selinux/pull/142
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks!
> Nicolas
>
