Return-Path: <SRS0=5WGn=SH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392DDC4360F
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD721726
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXNqRb+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfDEOoI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:44:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40240 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOoH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Apr 2019 10:44:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so5841691otp.7
        for <selinux@vger.kernel.org>; Fri, 05 Apr 2019 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7klJXwJJ5TFHLoOHaj47thJWewPjtLWmfZ7J5v3ZSY=;
        b=WXNqRb+kvlT8KcCNFbG5SjtrdZUEgrHYhV4+FWiYvTzQp3SV6nEZtChDGh+loLC5km
         XAtbFqSTn7P+T/H+81a9eZxqtonLiaj3x/sogJbvsfcuYPTPCd1+NJZflxqGncHIU+F7
         q6pPNJpNbjXyicxLuN/ah1LDfvJAvIGz8FbHxf2pLZ4cHLaKMlTe2obG+LU9mz7PL5yq
         JsPPS0XVi/wy6il0RSS+1BmMycUywD9GU06AopHhD+4j5k2PhjPMIxVJfgVxi3/4ywQx
         NXJyU/nMSgn46lsr4fQ5lGzPdhlTjyvPnGwdnnJQlk60fXVpdLcNgoZXFse8z14yCbqj
         yPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7klJXwJJ5TFHLoOHaj47thJWewPjtLWmfZ7J5v3ZSY=;
        b=ha+JZ0O3swx5uK9Wut8ydEIoavrS8OzVmnUoG4cpSKw5zEkkwKfPHB3AtrecKg5E54
         CDNzDRt5eqyGPnL/i3vaL9Gsm+X76ZaF/rEvtuJ9irl3bsufcSPAropSYYyGvrgklXxX
         7ATVeDZ+1/sCBvZucPQBLREIhlnQXNM2Ee7sz5QqcCMTEGiYgbegLLZqPlm/7UepgmvT
         aEZj851Jtl084pTpCMBFpOZ5emBrkj2S5BsxX4HXpyn5MT2nCUlekrTrtjrrojiWfQ44
         t6xztifkxuHGt0gJUd5AeRIuOu/Egvv88t+lOceGgZsxyO3Q2w/A0I5ppeh/hkzo4WYs
         wkmw==
X-Gm-Message-State: APjAAAU0JeANS0Al7A7eU6Otj17QWJ3azvDUJoM4N27YdGyj7pWlQWdf
        CUd/6smZuOClJxlshWMiADDSLx7/1nkFda35A7U=
X-Google-Smtp-Source: APXvYqxR5nXWNB87/CHW9JBPnreMAQALUpS8o4o8rbpQepXNptdJ3VyEiabXu7rihOlknBjaxuWUwH4WtHAZEeEbyrg=
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr8084751otp.234.1554475446467;
 Fri, 05 Apr 2019 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190405003233.29183-1-joshua.brindle@crunchydata.com> <20190405140850.3873-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20190405140850.3873-1-joshua.brindle@crunchydata.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 5 Apr 2019 07:43:55 -0700
Message-ID: <CAFftDdrzF1DnuXyKkinNCEmNKeQdqmyTXxqBLTdgxeR_dT1W7A@mail.gmail.com>
Subject: Re: [PATCH v3] Add security_validatetrans support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 5, 2019 at 7:09 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> It seems validatetrans support was never added to libselinux, despite bei=
ng added to
> selinuxfs in kernel version 4.5
>
> There is a utility to test, however the targeted policy has no validatetr=
ans rules so some must be added:
>
> $ cat validatetrans.cil
> (mlsvalidatetrans db_table (and (or (or (or (eq l1 l2) (and (eq t3 unconf=
ined_t) (domby l1 l2))) (and (eq t3 unconfined_t) (dom l1 l2))) (and (eq t3=
 unconfined_t) (incomp l1 l2))) (or (or (or (eq l1 h2) (and (eq t3 unconfin=
ed_t) (domby h1 h2))) (and (eq t3 unconfined_t) (dom h1 h2))) (and (eq t3 u=
nconfined_t) (incomp h1 h2)))))
>
> $ sudo semodule -i validatetrans.cil
>
> $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:=
s0:c0 db_table system_u:system_r: # invalid context here
> opening /sys/fs/selinux/validatetrans
> security_validatetrans returned -1 errno: Invalid argument
>
> $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:=
s0:c0 db_table system_u:system_r:init_t:s0
> opening /sys/fs/selinux/validatetrans
> security_validatetrans returned -1 errno: Operation not permitted
>
> $ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:=
s0:c0 db_table system_u:system_r:unconfined_t:s0
> opening /sys/fs/selinux/validatetrans
> security_validatetrans returned 0 errno: Success
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>  libselinux/include/selinux/selinux.h          | 13 +++
>  libselinux/man/man3/security_compute_av.3     | 13 ++-
>  libselinux/man/man3/security_validatetrans.c  |  1 +
>  .../man/man3/security_validatetrans_raw.c     |  1 +
>  libselinux/src/selinux_internal.h             |  2 +
>  libselinux/src/validatetrans.c                | 98 +++++++++++++++++++
>  libselinux/utils/.gitignore                   |  1 +
>  libselinux/utils/validatetrans.c              | 30 ++++++
>  8 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/man/man3/security_validatetrans.c
>  create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
>  create mode 100644 libselinux/src/validatetrans.c
>  create mode 100644 libselinux/utils/validatetrans.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index a34d54fc..f54f236b 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char * sc=
on,
>                                      const char *username,
>                                      char *** con);
>
> +/* Validate a transition. This determines whether a transition from scon=
 to newcon
> +   using tcon as the target for object class tclass is valid in the load=
ed policy.
> +   This checks against the mlsvalidatetrans and validatetrans constraint=
s in the loaded policy.
> +   Returns 0 if allowed and -1 if an error occured with errno set */
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
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/m=
an3/security_compute_av.3
> index 2aade5fe..a7181bed 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -1,7 +1,7 @@
>  .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "S=
ELinux API documentation"
>  .SH "NAME"
>  security_compute_av, security_compute_av_flags, security_compute_create,=
 security_compute_create_name, security_compute_relabel,
> -security_compute_member, security_compute_user, security_get_initial_con=
text \- query
> +security_compute_member, security_compute_user, security_validatetrans, =
security_get_initial_context \- query
>  the SELinux policy database in the kernel
>  .
>  .SH "SYNOPSIS"
> @@ -35,6 +35,10 @@ the SELinux policy database in the kernel
>  .sp
>  .BI "int security_compute_user_raw(char *" scon ", const char *" usernam=
e ", char ***" con );
>  .sp
> +.BI "int security_validatetrans(char *" scon ", const char *" tcon ", se=
curity_class_t "tclass ", char *" newcon );
> +.sp
> +.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon "=
, security_class_t "tclass ", char *" newcon );
> +.sp
>  .BI "int security_get_initial_context(const char *" name ", char **" con=
 );
>  .sp
>  .BI "int security_get_initial_context_raw(const char *" name ", char **"=
 con );
> @@ -100,6 +104,12 @@ is used to determine the set of user contexts that c=
an be reached from a
>  source context. It is mainly used by
>  .BR get_ordered_context_list ().
>
> +.BR security_validatetrans ()
> +is used to determine if a transition from scon to newcon using tcon as t=
he object
> +is valid for object class tclass. This checks against the mlsvalidatetra=
ns and
> +validatetrans constraints in the loaded policy. Returns 0 if allowed, an=
d -1
> +if an error occured with errno set.
> +
>  .BR security_get_initial_context ()
>  is used to get the context of a kernel initial security identifier speci=
fied by
>  .I name
> @@ -111,6 +121,7 @@ is used to get the context of a kernel initial securi=
ty identifier specified by
>  .BR \%security_compute_relabel_raw (),
>  .BR \%security_compute_member_raw (),
>  .BR \%security_compute_user_raw ()
> +.BR \%security_validatetrans_raw ()
>  and
>  .BR \%security_get_initial_context_raw ()
>  behave identically to their non-raw counterparts but do not perform cont=
ext
> diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/ma=
n/man3/security_validatetrans.c
> new file mode 100644
> index 00000000..a60bca4d
> --- /dev/null
> +++ b/libselinux/man/man3/security_validatetrans.c
> @@ -0,0 +1 @@
> +.so man3/security_compute_av.3
> diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinu=
x/man/man3/security_validatetrans_raw.c
> new file mode 100644
> index 00000000..a60bca4d
> --- /dev/null
> +++ b/libselinux/man/man3/security_validatetrans_raw.c
> @@ -0,0 +1 @@
> +.so man3/security_compute_av.3
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
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
> diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetran=
s.c
> new file mode 100644
> index 00000000..e080e166
> --- /dev/null
> +++ b/libselinux/src/validatetrans.c
> @@ -0,0 +1,98 @@
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
> +       char *buf =3D NULL;
> +       int size, bufsz;
> +       int fd, ret =3D -1;
> +       errno =3D ENOENT;
> +
> +       if (!selinux_mnt) {
> +               return -1;
> +       }
> +
> +       snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
> +       fd =3D open(path, O_WRONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               return -1;
> +       }
> +
> +       errno =3D EINVAL;
> +       size =3D selinux_page_size;
> +       buf =3D malloc(size);
> +       if (!buf) {
> +               goto out;
> +       }
> +
> +       bufsz =3D snprintf(NULL, 0, "%s %s %hu %s", scon, tcon, unmap_cla=
ss(tclass), newcon);
> +       if (bufsz > size) {
> +               // This is going to be too large
> +               goto out;
> +       }
> +       if (bufsz !=3D snprintf(buf, size, "%s %s %hu %s", scon, tcon, un=
map_class(tclass), newcon)) {
> +               // It got truncated somehow
> +               goto out;
> +       }

This seems like the hardest way to do this, especially to catch an
exceptional error.
Per the man page, "a  return  value  of  size or more means that the
output was truncated."
     bufsz =3D snprintf(buf, size, "%s %s %hu %s", scon, tcon,
unmap_class(tclass), newcon)
     if (bufsz < 0 || bufsz >=3D size) {
               // It got truncated somehow
              goto out;
      }

No need to call it twice.

> +
> +       // clear errno for write()
> +       errno =3D 0;
> +       ret =3D write(fd, buf, strlen(buf));
> +       if (ret > 0) {
> +               // The kernel returns the bytes written on success, not 0=
 as noted in the commit message
> +               ret =3D 0;
> +       }
> +out:
> +       free(buf);
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
> +       int ret =3D -1;
> +       char *rscon =3D NULL;
> +       char *rtcon =3D NULL;
> +       char *rnewcon =3D NULL;
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
> +       ret =3D security_validatetrans_raw(rscon, rtcon, tclass, rnewcon)=
;
> +
> +out:
> +       freecon(rnewcon);
> +       freecon(rtcon);
> +       freecon(rscon);
> +
> +       return ret;
> +}
> +
> +hidden_def(security_validatetrans)
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 5cd01025..aba18a3c 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -25,3 +25,4 @@ setenforce
>  setfilecon
>  togglesebool
>  selinux_check_access
> +validatetrans
> diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/validate=
trans.c
> new file mode 100644
> index 00000000..1db33e66
> --- /dev/null
> +++ b/libselinux/utils/validatetrans.c
> @@ -0,0 +1,30 @@
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +       security_class_t tclass;
> +       int ret;
> +
> +       if (argc !=3D 5) {
> +               fprintf(stderr, "usage:  %s scontext tcontext tclass newc=
ontext\n",
> +                       argv[0]);
> +               exit(1);
> +       }
> +
> +       tclass =3D string_to_security_class(argv[3]);
> +       if (!tclass) {
> +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);
> +               exit(2);
> +       }
> +
> +       ret =3D security_validatetrans(argv[1], argv[2], tclass, argv[4])=
;
> +       printf("security_validatetrans returned %d errno: %s\n", ret, str=
error(errno));
> +
> +       return ret;
> +}
> --
> 2.17.2
>
