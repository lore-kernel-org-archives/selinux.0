Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46982C43334
	for <selinux@archiver.kernel.org>; Thu,  9 Jun 2022 17:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbiFIR0J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbiFIR0I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jun 2022 13:26:08 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82442EF2
        for <selinux@vger.kernel.org>; Thu,  9 Jun 2022 10:26:03 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-fdfe64231dso309516fac.1
        for <selinux@vger.kernel.org>; Thu, 09 Jun 2022 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5KJWMVqK3L1eryPN/LRverdw3SUbShEXANl3e3cHgbQ=;
        b=Dq5FdXtlYWn7tgTq015YPxYTp62rUhjAz8F2DqQV19G/Cup1mM2Sja9vFou8BWjZCl
         EqitJI3N83vJS6i7Jvhnn/3BFCajy55nEkNeq34jCxAFFT1i6cVqsF3/VSMjpCL+p9vp
         vvQkEvNr4VD1NTW3LgXg60USDt7HZxtLtW22Rmy0Fa7DiMIDnSG0fxIcB52iuaLwGVS1
         v4E4VSuocyUopCb7wzj0ssoxcG1KxWfrHesfLm24IVMOuRyvrEzv15fHcqcvRZUhDB81
         04HVPPbUckdDXUG754eNF/AiSmxAReFWlkA9MFI+6MvT/m9T7qnRQ0kM7A3cypqSbQvP
         eBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5KJWMVqK3L1eryPN/LRverdw3SUbShEXANl3e3cHgbQ=;
        b=ULNHMe4yoyAYVfrahn3WzWulZTRdo08AJH+00WzIbxmABiUSxHf2+KymyBFLMdRZXH
         sIGEX6Yjdo6Dq47plGjpk1QomXJPvceOmCf/1MOtvkgtto+3YMv87WZmmy5oMgjMSWdK
         86tcT8uAjGl8k/faS44qv2FV+25HC3HIdCD7xLop0bpmqQD24eJz5mEvk4q4mVDs4lfJ
         SlN7wJqIFik8DuEK34JZYXwycs4RZb1AFgrn1s7EBhrGoLIvyEXqSvwWeeTkxKnxxRPr
         ia4Eitzlf9KAOiNxlNdU04G5VaK+0PH5v75axXbekO3Os35Fdeh0rtLWyYw8qzg69c+W
         Ba0Q==
X-Gm-Message-State: AOAM5310TD0r72/8R+nUJ4IzCAUxeca0CJlrym5+8A434p1xEtmm3/Q7
        qTmE+0pCCOcU1YhE0uIn0EET9SQy+OZyj3P2TmaLIFQdI5c=
X-Google-Smtp-Source: ABdhPJzMja2mdZIlSuq70/a8xV4/ip8qcuoBwHeB96fp1otTAntHNAkeMQGRf/ehKRKCpKjXssMhFcMujvyi61bYXNE=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr2356897oao.182.1654795563034; Thu, 09
 Jun 2022 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220607174145.51330-1-cgzones@googlemail.com>
In-Reply-To: <20220607174145.51330-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Jun 2022 13:25:51 -0400
Message-ID: <CAP+JOzQtbZV-nR1tWMv5jG7gZRaCKqxTtru1gJm_TUOKxjrwjw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] libsepol: export initial SIDs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 3:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Export initial SIDs, so they can be used for example in checkpolicy.
>

We don't want to export the initial SID names. See commit 8677ce5e
"libsepol,checkpolicy: support omitting unused initial sid contexts"
and https://github.com/SELinuxProject/selinux-kernel/issues/12 for
more information. Eventually, we want to go to a dynamic discovery of
initial SIDs. The initial SID names are in kernel_to_common.h as a
hack because the name is not stored in the binary policy, but we don't
want to encourage more use.

Thanks,
Jim

> Add helper functions for name lookup.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/initialsids.h | 89 +++++++++++++++++++
>  libsepol/include/sepol/policydb/policydb.h    |  2 +-
>  libsepol/src/kernel_to_cil.c                  |  1 +
>  libsepol/src/kernel_to_common.h               | 53 -----------
>  libsepol/src/kernel_to_conf.c                 |  1 +
>  libsepol/src/module_to_cil.c                  |  1 +
>  6 files changed, 93 insertions(+), 54 deletions(-)
>  create mode 100644 libsepol/include/sepol/policydb/initialsids.h
>
> diff --git a/libsepol/include/sepol/policydb/initialsids.h b/libsepol/inc=
lude/sepol/policydb/initialsids.h
> new file mode 100644
> index 00000000..7b2fe021
> --- /dev/null
> +++ b/libsepol/include/sepol/policydb/initialsids.h
> @@ -0,0 +1,89 @@
> +#ifndef _SEPOL_POLICYDB_INITIALSIDS_H_
> +#define _SEPOL_POLICYDB_INITIALSIDS_H_
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +// initial sid names aren't actually stored in the pp files, need to a h=
ave
> +// a mapping, taken from the linux kernel
> +static const char * const selinux_sid_to_str[] =3D {
> +       "null",
> +       "kernel",
> +       "security",
> +       "unlabeled",
> +       "fs",
> +       "file",
> +       "file_labels",
> +       "init",
> +       "any_socket",
> +       "port",
> +       "netif",
> +       "netmsg",
> +       "node",
> +       "igmp_packet",
> +       "icmp_socket",
> +       "tcp_socket",
> +       "sysctl_modprobe",
> +       "sysctl",
> +       "sysctl_fs",
> +       "sysctl_kernel",
> +       "sysctl_net",
> +       "sysctl_net_unix",
> +       "sysctl_vm",
> +       "sysctl_dev",
> +       "kmod",
> +       "policy",
> +       "scmp_packet",
> +       "devnull",
> +};
> +
> +#define SELINUX_SID_SZ (sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to=
_str[0]))
> +
> +static inline unsigned int selinux_str_to_sid(const char *name)
> +{
> +       unsigned i;
> +
> +       for (i =3D 1; i < SELINUX_SID_SZ; i++) {
> +               if (strcmp(name, selinux_sid_to_str[i]) =3D=3D 0)
> +                       return i;
> +       }
> +
> +       return 0;
> +}
> +
> +static const char * const xen_sid_to_str[] =3D {
> +       "null",
> +       "xen",
> +       "dom0",
> +       "domio",
> +       "domxen",
> +       "unlabeled",
> +       "security",
> +       "ioport",
> +       "iomem",
> +       "irq",
> +       "device",
> +       "domU",
> +       "domDM",
> +};
> +
> +#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
> +
> +static inline unsigned int xen_str_to_sid(const char *name)
> +{
> +       unsigned i;
> +
> +       for (i =3D 1; i < XEN_SID_SZ; i++) {
> +               if (strcmp(name, xen_sid_to_str[i]) =3D=3D 0)
> +                       return i;
> +       }
> +
> +       return 0;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif                         /* _SEPOL_POLICYDB_INITIALSIDS_H_ */
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index de0068a6..2ce4da5d 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -340,7 +340,7 @@ typedef struct range_trans_rule {
>   */
>  typedef struct ocontext {
>         union {
> -               char *name;     /* name of initial SID, fs, netif, fstype=
, path */
> +               char *name;     /* name of initial SID (not saved in bina=
ry policy), fs, netif, fstype, path */
>                 struct {
>                         uint8_t protocol;
>                         uint16_t low_port;
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 9128ac55..42251684 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -20,6 +20,7 @@
>  #include <sepol/policydb/avtab.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hashtab.h>
> +#include <sepol/policydb/initialsids.h>
>  #include <sepol/policydb/polcaps.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index 159c4289..5e8482bf 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -10,59 +10,6 @@
>  #define DEFAULT_LEVEL "systemlow"
>  #define DEFAULT_OBJECT "object_r"
>
> -// initial sid names aren't actually stored in the pp files, need to a h=
ave
> -// a mapping, taken from the linux kernel
> -static const char * const selinux_sid_to_str[] =3D {
> -       "null",
> -       "kernel",
> -       "security",
> -       "unlabeled",
> -       "fs",
> -       "file",
> -       "file_labels",
> -       "init",
> -       "any_socket",
> -       "port",
> -       "netif",
> -       "netmsg",
> -       "node",
> -       "igmp_packet",
> -       "icmp_socket",
> -       "tcp_socket",
> -       "sysctl_modprobe",
> -       "sysctl",
> -       "sysctl_fs",
> -       "sysctl_kernel",
> -       "sysctl_net",
> -       "sysctl_net_unix",
> -       "sysctl_vm",
> -       "sysctl_dev",
> -       "kmod",
> -       "policy",
> -       "scmp_packet",
> -       "devnull",
> -};
> -
> -#define SELINUX_SID_SZ (sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to=
_str[0]))
> -
> -static const char * const xen_sid_to_str[] =3D {
> -       "null",
> -       "xen",
> -       "dom0",
> -       "domio",
> -       "domxen",
> -       "unlabeled",
> -       "security",
> -       "ioport",
> -       "iomem",
> -       "irq",
> -       "device",
> -       "domU",
> -       "domDM",
> -};
> -
> -#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
> -
>  static const uint32_t avtab_flavors[] =3D {
>         AVTAB_ALLOWED,
>         AVTAB_AUDITALLOW,
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 63dffd9b..51a8270d 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -19,6 +19,7 @@
>  #include <sepol/policydb/avtab.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hashtab.h>
> +#include <sepol/policydb/initialsids.h>
>  #include <sepol/policydb/polcaps.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b35bf055..1945b369 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -47,6 +47,7 @@
>  #include <sepol/module_to_cil.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hashtab.h>
> +#include <sepol/policydb/initialsids.h>
>  #include <sepol/policydb/polcaps.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
> --
> 2.36.1
>
