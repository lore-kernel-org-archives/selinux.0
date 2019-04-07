Return-Path: <SRS0=lGRf=SJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE01C10F0E
	for <selinux@archiver.kernel.org>; Sun,  7 Apr 2019 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F02087F
	for <selinux@archiver.kernel.org>; Sun,  7 Apr 2019 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDGU7J convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sun, 7 Apr 2019 16:59:09 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57452 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGU7J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Apr 2019 16:59:09 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AED48564756
        for <selinux@vger.kernel.org>; Sun,  7 Apr 2019 22:59:04 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id y84so8856892oia.12
        for <selinux@vger.kernel.org>; Sun, 07 Apr 2019 13:59:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWBoF08cqlgUe25bVOX/jQEjdAn0gwaUQ6Q3sB/wUcfNRQkAFV9
        KNFB4fZ9EGfCKkQqTP1DcDRmtzV5Ol+WgQn/VjA=
X-Google-Smtp-Source: APXvYqxoa/SLgJ2qZni8ba4U9yNRdj11ffdgEYoLrqn3I79eOxg/Cg6Yb2ScGKg2lAD47F26aI8K78V+KfkdWUTvMNM=
X-Received: by 2002:aca:4482:: with SMTP id r124mr14634189oia.39.1554670743411;
 Sun, 07 Apr 2019 13:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh5ad2SBUcpY5bNzWRSfV5jjXiojy0aaYJXyzY9EqnVZdQ@mail.gmail.com>
 <20190405190102.13987-1-joshua.brindle@crunchydata.com> <CAFftDdp9+P3ZZQoj9pObbOkDuafBjhn_yuJ7MeVOkxnWDruJWA@mail.gmail.com>
In-Reply-To: <CAFftDdp9+P3ZZQoj9pObbOkDuafBjhn_yuJ7MeVOkxnWDruJWA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 7 Apr 2019 22:58:51 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kmJzGmOX9FxLT1KPEFzXzNF3sokdo1bD5mtT1xqzFCKA@mail.gmail.com>
Message-ID: <CAJfZ7=kmJzGmOX9FxLT1KPEFzXzNF3sokdo1bD5mtT1xqzFCKA@mail.gmail.com>
Subject: Re: [PATCH v5] Add security_validatetrans support
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr  7 22:59:05 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 5, 2019 at 9:04 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Fri, Apr 5, 2019 at 12:01 PM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > It seems validatetrans support was never added to libselinux, despite being added to
> > selinuxfs in kernel version 4.5
> >
> > There is a utility to test, however the targeted policy has no validatetrans rules so some must be added:
> >
> > $ cat validatetrans.cil
> > (mlsvalidatetrans db_table (and (or (or (or (eq l1 l2) (and (eq t3 unconfined_t) (domby l1 l2))) (and (eq t3 unconfined_t) (dom l1 l2))) (and (eq t3 unconfined_t) (incomp l1 l2))) (or (or (or (eq l1 h2) (and (eq t3 unconfined_t) (domby h1 h2))) (and (eq t3 unconfined_t) (dom h1 h2))) (and (eq t3 unconfined_t) (incomp h1 h2)))))
> >
> > $ sudo semodule -i validatetrans.cil
> >
> > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r: # invalid context here
> > opening /sys/fs/selinux/validatetrans
> > security_validatetrans returned -1 errno: Invalid argument
> >
> > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r:init_t:s0
> > opening /sys/fs/selinux/validatetrans
> > security_validatetrans returned -1 errno: Operation not permitted
> >
> > $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r:unconfined_t:s0
> > opening /sys/fs/selinux/validatetrans
> > security_validatetrans returned 0 errno: Success
> >
> > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > ---
> >  libselinux/include/selinux/selinux.h          | 13 +++
> >  libselinux/man/man3/security_compute_av.3     | 13 ++-
> >  libselinux/man/man3/security_validatetrans.c  |  1 +
> >  .../man/man3/security_validatetrans_raw.c     |  1 +
> >  libselinux/src/selinux_internal.h             |  2 +
> >  libselinux/src/validatetrans.c                | 94 +++++++++++++++++++
> >  libselinux/utils/.gitignore                   |  1 +
> >  libselinux/utils/validatetrans.c              | 30 ++++++
> >  8 files changed, 154 insertions(+), 1 deletion(-)
> >  create mode 100644 libselinux/man/man3/security_validatetrans.c
> >  create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
> >  create mode 100644 libselinux/src/validatetrans.c
> >  create mode 100644 libselinux/utils/validatetrans.c
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> > index a34d54fc..f54f236b 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char * scon,
> >                                      const char *username,
> >                                      char *** con);
> >
> > +/* Validate a transition. This determines whether a transition from scon to newcon
> > +   using tcon as the target for object class tclass is valid in the loaded policy.
> > +   This checks against the mlsvalidatetrans and validatetrans constraints in the loaded policy.
> > +   Returns 0 if allowed and -1 if an error occured with errno set */
> > +extern int security_validatetrans(const char *scon,
> > +                                 const char *tcon,
> > +                                 security_class_t tclass,
> > +                                 const char *newcon);
> > +extern int security_validatetrans_raw(const char *scon,
> > +                                     const char *tcon,
> > +                                     security_class_t tclass,
> > +                                     const char *newcon);
> > +
> >  /* Load a policy configuration. */
> >  extern int security_load_policy(void *data, size_t len);
> >
> > diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
> > index 2aade5fe..a7181bed 100644
> > --- a/libselinux/man/man3/security_compute_av.3
> > +++ b/libselinux/man/man3/security_compute_av.3
> > @@ -1,7 +1,7 @@
> >  .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
> >  .SH "NAME"
> >  security_compute_av, security_compute_av_flags, security_compute_create, security_compute_create_name, security_compute_relabel,
> > -security_compute_member, security_compute_user, security_get_initial_context \- query
> > +security_compute_member, security_compute_user, security_validatetrans, security_get_initial_context \- query
> >  the SELinux policy database in the kernel
> >  .
> >  .SH "SYNOPSIS"
> > @@ -35,6 +35,10 @@ the SELinux policy database in the kernel
> >  .sp
> >  .BI "int security_compute_user_raw(char *" scon ", const char *" username ", char ***" con );
> >  .sp
> > +.BI "int security_validatetrans(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
> > +.sp
> > +.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
> > +.sp
> >  .BI "int security_get_initial_context(const char *" name ", char **" con );
> >  .sp
> >  .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
> > @@ -100,6 +104,12 @@ is used to determine the set of user contexts that can be reached from a
> >  source context. It is mainly used by
> >  .BR get_ordered_context_list ().
> >
> > +.BR security_validatetrans ()
> > +is used to determine if a transition from scon to newcon using tcon as the object
> > +is valid for object class tclass. This checks against the mlsvalidatetrans and
> > +validatetrans constraints in the loaded policy. Returns 0 if allowed, and -1
> > +if an error occured with errno set.
> > +
> >  .BR security_get_initial_context ()
> >  is used to get the context of a kernel initial security identifier specified by
> >  .I name
> > @@ -111,6 +121,7 @@ is used to get the context of a kernel initial security identifier specified by
> >  .BR \%security_compute_relabel_raw (),
> >  .BR \%security_compute_member_raw (),
> >  .BR \%security_compute_user_raw ()
> > +.BR \%security_validatetrans_raw ()
> >  and
> >  .BR \%security_get_initial_context_raw ()
> >  behave identically to their non-raw counterparts but do not perform context
> > diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/man/man3/security_validatetrans.c
> > new file mode 100644
> > index 00000000..a60bca4d
> > --- /dev/null
> > +++ b/libselinux/man/man3/security_validatetrans.c
> > @@ -0,0 +1 @@
> > +.so man3/security_compute_av.3
> > diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinux/man/man3/security_validatetrans_raw.c
> > new file mode 100644
> > index 00000000..a60bca4d
> > --- /dev/null
> > +++ b/libselinux/man/man3/security_validatetrans_raw.c
> > @@ -0,0 +1 @@
> > +.so man3/security_compute_av.3
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> > index 70b5025d..acd59c7c 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -29,6 +29,8 @@ hidden_proto(selinux_mkload_policy)
> >      hidden_proto(security_compute_create_name_raw)
> >      hidden_proto(security_compute_member_raw)
> >      hidden_proto(security_compute_relabel_raw)
> > +    hidden_proto(security_validatetrans)
> > +    hidden_proto(security_validatetrans_raw)
> >      hidden_proto(is_selinux_enabled)
> >      hidden_proto(is_selinux_mls_enabled)
> >      hidden_proto(freecon)
> > diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetrans.c
> > new file mode 100644
> > index 00000000..2aa300cf
> > --- /dev/null
> > +++ b/libselinux/src/validatetrans.c
> > @@ -0,0 +1,94 @@
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <limits.h>
> > +#include "selinux_internal.h"
> > +#include "policy.h"
> > +#include "mapping.h"
> > +
> > +int security_validatetrans_raw(const char *scon,
> > +                              const char *tcon,
> > +                              security_class_t tclass,
> > +                              const char *newcon)
> > +{
> > +       char path[PATH_MAX];
> > +       char *buf = NULL;
> > +       int size, bufsz;
> > +       int fd, ret = -1;
> > +       errno = ENOENT;
> > +
> > +       if (!selinux_mnt) {
> > +               return -1;
> > +       }
> > +
> > +       snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
> > +       fd = open(path, O_WRONLY | O_CLOEXEC);
> > +       if (fd < 0) {
> > +               return -1;
> > +       }
> > +
> > +       errno = EINVAL;
> > +       size = selinux_page_size;
> > +       buf = malloc(size);
> > +       if (!buf) {
> > +               goto out;
> > +       }
> > +
> > +       bufsz = snprintf(buf, size, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon);
> > +       if (bufsz >= size || bufsz < 0) {
> > +               // It got truncated or there was an encoding error
> > +               goto out;
> > +       }
> > +
> > +       // clear errno for write()
> > +       errno = 0;
> > +       ret = write(fd, buf, strlen(buf));
> > +       if (ret > 0) {
> > +               // The kernel returns the bytes written on success, not 0 as noted in the commit message
> > +               ret = 0;
> > +       }
> > +out:
> > +       free(buf);
> > +       close(fd);
> > +       return ret;
> > +}
> > +
> > +hidden_def(security_validatetrans_raw)
> > +
> > +int security_validatetrans(const char *scon,
> > +                          const char *tcon,
> > +                          security_class_t tclass,
> > +                          const char *newcon)
> > +{
> > +       int ret = -1;
> > +       char *rscon = NULL;
> > +       char *rtcon = NULL;
> > +       char *rnewcon = NULL;
> > +
> > +       if (selinux_trans_to_raw_context(scon, &rscon)) {
> > +               goto out;
> > +       }
> > +
> > +       if (selinux_trans_to_raw_context(tcon, &rtcon)) {
> > +               goto out;
> > +       }
> > +
> > +       if (selinux_trans_to_raw_context(newcon, &rnewcon)) {
> > +               goto out;
> > +       }
> > +
> > +       ret = security_validatetrans_raw(rscon, rtcon, tclass, rnewcon);
> > +
> > +out:
> > +       freecon(rnewcon);
> > +       freecon(rtcon);
> > +       freecon(rscon);
> > +
> > +       return ret;
> > +}
> > +
> > +hidden_def(security_validatetrans)
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index 5cd01025..aba18a3c 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -25,3 +25,4 @@ setenforce
> >  setfilecon
> >  togglesebool
> >  selinux_check_access
> > +validatetrans
> > diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/validatetrans.c
> > new file mode 100644
> > index 00000000..1db33e66
> > --- /dev/null
> > +++ b/libselinux/utils/validatetrans.c
> > @@ -0,0 +1,30 @@
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <selinux/selinux.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       security_class_t tclass;
> > +       int ret;
> > +
> > +       if (argc != 5) {
> > +               fprintf(stderr, "usage:  %s scontext tcontext tclass newcontext\n",
> > +                       argv[0]);
> > +               exit(1);
> > +       }
> > +
> > +       tclass = string_to_security_class(argv[3]);
> > +       if (!tclass) {
> > +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
> > +               exit(2);
> > +       }
> > +
> > +       ret = security_validatetrans(argv[1], argv[2], tclass, argv[4]);
> > +       printf("security_validatetrans returned %d errno: %s\n", ret, strerror(errno));
> > +
> > +       return ret;
> > +}
> > --
> > 2.17.2
> >
>
> ack - staged: https://github.com/SELinuxProject/selinux/pull/142

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

