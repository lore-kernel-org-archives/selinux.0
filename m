Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E44C4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5C2206B7
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmhZzoSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfDDSnZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:43:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41137 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDDSnZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 14:43:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id v7so2768844oie.8
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k4eTz938M0ZX5RCoZrsJzjflb44n1Lhk3yGjnzVoO0=;
        b=dmhZzoSaPBEgv6RB6FeM6DKgGHl7oBMeZbhM0G3TY82vx/fVZOxqTcqy+z630lZPfm
         hbC58xprRt075v/xK2hB1lzJ9Mq0jZeu+tu01CKqq4XwnUt3N7cKAlEtCo4EFjtGmhQh
         sdrvo3p3VtBIP62S9ohspTcYSgshTD3k0FADh7cZDLXCxTM2AybUHlYfLAOVU6qqwOhX
         Xr8QQBQWey3sZFT9h9Jzs2u7VNafUrl0RxZ5OExEEdTVMuCGkfbLg8J8WHWOQbrokDA6
         pktHQTl85j2x0G6cnHEpX6h+RWIC0THkKIuzlqiF02YTZNwmUmFY2C+AnsGcw7HNigRD
         /cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k4eTz938M0ZX5RCoZrsJzjflb44n1Lhk3yGjnzVoO0=;
        b=bJjKAjoAMAbTvdpuRrOByY5BpcrDMjcpJMwlXnR2ihczVHh/BQ6sT93dGJewJxVXCj
         YQ0upy+JFp/cUcFEG4tmCfTIDDV7XJ84temfV5UKt2RlemUef6aEKiTw+kZtb9n+Y5Zw
         zsuxYHrS3B+Uv3lDsL9j83lbKKranSDsgdnIkxa0aXugQaJgstlZTxoX7ITc1XnWWO9v
         m8S/JQdbxo0BzRdJPvCbPD8nb9j2sTNRPOiwAKGR+L29OsJkjPLY/JshDxpHaTCpDs0R
         BAHk37bLdDrL4g19W4qzuASVlNFBAKQuiI3DE+ZSDOfZuMmy20+W5we6DNv4ES1YFfj1
         19VQ==
X-Gm-Message-State: APjAAAXyTXgd3qWCwyZEyRb7vH/6rmpLgYGC0Se7vfS4dCCNYTMC4Ak9
        nr6WnsU7hZVD/7jKe8CB3OncMaT0zj2IbrrhX21seyOO+z4=
X-Google-Smtp-Source: APXvYqwKEKW6MOSnsdNCNpSuQiQ3bNnRO6RHiWLV6tYT+0YslmtWzNkeGC4zAISfvsueWsiTl4X0r9jyF5JqM1fOwp8=
X-Received: by 2002:aca:c154:: with SMTP id r81mr4122732oif.160.1554403403700;
 Thu, 04 Apr 2019 11:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190404153654.32122-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20190404153654.32122-1-joshua.brindle@crunchydata.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 4 Apr 2019 11:43:12 -0700
Message-ID: <CAFftDdr2QMec9S9RdYij7yaTLbMZ-74aOsjjYS6T9ROT0D1b6w@mail.gmail.com>
Subject: Re: [PATCH] Add security_validatetrans support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 4, 2019 at 8:37 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> It seems validatetrans support was never added to libselinux, despite being added to
> selinuxfs in kernel version 4.5
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>  libselinux/include/selinux/selinux.h          | 13 +++
>  libselinux/man/man3/security_compute_av.3     | 13 ++-
>  libselinux/man/man3/security_validatetrans.c  |  1 +
>  .../man/man3/security_validatetrans_raw.c     |  1 +
>  libselinux/src/selinux_internal.h             |  2 +
>  libselinux/src/validatetrans.c                | 80 +++++++++++++++++++
>  6 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/man/man3/security_validatetrans.c
>  create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
>  create mode 100644 libselinux/src/validatetrans.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index a34d54fc..948028ea 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char * scon,
>                                      const char *username,
>                                      char *** con);
>
> +/* Validate a transition. This determines whether a transition from scon to newcon
> +   using tcon as the target for object class tclass is valid in the loaded policy.
> +   This checks against the mlsvalidatetrans and validatetrans constraints in the loaded policy.
> +   Returns 0 if allowed, -EPERM if denied, and -1 if an error occured */
> +extern int security_validatetrans(const char *scon,
> +                                 const char *tcon,
> +                                 security_class_t tclass,
> +                                 const char *newcon);
> +extern int security_validatetrans_raw(const char *scon,
> +                                     const char *tcon,
> +                                     security_class_t tclass,
> +                                     const char *newcon);
> +
>  /* Load a policy configuration. */
>  extern int security_load_policy(void *data, size_t len);
>
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
> index 2aade5fe..e03960bc 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -1,7 +1,7 @@
>  .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>  .SH "NAME"
>  security_compute_av, security_compute_av_flags, security_compute_create, security_compute_create_name, security_compute_relabel,
> -security_compute_member, security_compute_user, security_get_initial_context \- query
> +security_compute_member, security_compute_user, security_validatetrans, security_get_initial_context \- query
>  the SELinux policy database in the kernel
>  .
>  .SH "SYNOPSIS"
> @@ -35,6 +35,10 @@ the SELinux policy database in the kernel
>  .sp
>  .BI "int security_compute_user_raw(char *" scon ", const char *" username ", char ***" con );
>  .sp
> +.BI "int security_validatetrans(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
> +.sp
> +.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
> +.sp
>  .BI "int security_get_initial_context(const char *" name ", char **" con );
>  .sp
>  .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
> @@ -100,6 +104,12 @@ is used to determine the set of user contexts that can be reached from a
>  source context. It is mainly used by
>  .BR get_ordered_context_list ().
>
> +.BR security_validatetrans ()
> +is used to determine if a transition from scon to newcon using tcon as the object
> +is valid for object class tclass. This checks against the mlsvalidatetrans and
> +validatetrans constraints in the loaded policy. Returns 0 if allowed, -EPERM if denied,
> +and -1 if an error occured
> +
>  .BR security_get_initial_context ()
>  is used to get the context of a kernel initial security identifier specified by
>  .I name
> @@ -111,6 +121,7 @@ is used to get the context of a kernel initial security identifier specified by
>  .BR \%security_compute_relabel_raw (),
>  .BR \%security_compute_member_raw (),
>  .BR \%security_compute_user_raw ()
> +.BR \%security_validatetrans_raw ()
>  and
>  .BR \%security_get_initial_context_raw ()
>  behave identically to their non-raw counterparts but do not perform context
> diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/man/man3/security_validatetrans.c
> new file mode 100644
> index 00000000..a60bca4d
> --- /dev/null
> +++ b/libselinux/man/man3/security_validatetrans.c
> @@ -0,0 +1 @@
> +.so man3/security_compute_av.3
> diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinux/man/man3/security_validatetrans_raw.c
> new file mode 100644
> index 00000000..a60bca4d
> --- /dev/null
> +++ b/libselinux/man/man3/security_validatetrans_raw.c
> @@ -0,0 +1 @@
> +.so man3/security_compute_av.3
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index 70b5025d..acd59c7c 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -29,6 +29,8 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(security_compute_create_name_raw)
>      hidden_proto(security_compute_member_raw)
>      hidden_proto(security_compute_relabel_raw)
> +    hidden_proto(security_validatetrans)
> +    hidden_proto(security_validatetrans_raw)
>      hidden_proto(is_selinux_enabled)
>      hidden_proto(is_selinux_mls_enabled)
>      hidden_proto(freecon)
> diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetrans.c
> new file mode 100644
> index 00000000..86bfaa30
> --- /dev/null
> +++ b/libselinux/src/validatetrans.c
> @@ -0,0 +1,80 @@
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <limits.h>
> +#include "selinux_internal.h"
> +#include "policy.h"
> +#include "mapping.h"
> +
> +int security_validatetrans_raw(const char *scon,
> +                              const char *tcon,
> +                              security_class_t tclass,
> +                              const char *newcon)
> +{
> +       char path[PATH_MAX];
> +       char *buf;
> +       size_t size;
> +       int fd, ret;
> +
> +       if (!selinux_mnt) {
> +               errno = ENOENT;
> +               return -1;
> +       }
> +
> +       snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
> +       fd = open(path, O_RDWR | O_CLOEXEC);
> +       if (fd < 0)
> +               return -1;
> +
> +       size = selinux_page_size;
> +       buf = malloc(size);
> +       if (!buf) {
> +               ret = -1;
> +               goto out;
> +       }
> +       snprintf(buf, size, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon);

Shouldn't we be checking both snprintf's for truncation?

I see things like selinux_status_open() not doing it, also it doesn't
use selinux_page_size but calls
sysconf() directly, so that might not be the best example. I just
wonder if we're glossing over truncation
bugs that might be hard to debug if they ever crop up without explicit errors.

> +
> +       ret = write(fd, buf, strlen(buf));
> +       free(buf);
> +out:
> +       close(fd);
> +       return ret;
> +}
> +
> +hidden_def(security_validatetrans_raw)
> +
> +int security_validatetrans(const char *scon,
> +                          const char *tcon,
> +                          security_class_t tclass,
> +                          const char *newcon)
> +{
> +       int ret = -1;
> +       char *rscon = NULL;
> +       char *rtcon = NULL;
> +       char *rnewcon = NULL;
> +
> +       if (selinux_trans_to_raw_context(scon, &rscon)) {
> +               goto out;
> +       }
> +
> +       if (selinux_trans_to_raw_context(tcon, &rtcon)) {
> +               goto out;
> +       }
> +
> +       if (selinux_trans_to_raw_context(newcon, &rnewcon)) {
> +               goto out;
> +       }
> +
> +       ret = security_validatetrans_raw(rscon, rtcon, tclass, rnewcon);
> +
> +out:
> +       freecon(rnewcon);
> +       freecon(rtcon);
> +       freecon(rscon);
> +
> +       return ret;
> +}
> --
> 2.17.2
>

$ git am ~/Downloads/\[PATCH\]\ Add\ security_validatetrans\ support.eml
Applying: Add security_validatetrans support
.git/rebase-apply/patch:68: trailing whitespace.
validatetrans constraints in the loaded policy. Returns 0 if allowed,
-EPERM if denied,
warning: 1 line adds whitespace errors.

Other then my question and trailing whitespace, overall LGTM. Builds and passes.
