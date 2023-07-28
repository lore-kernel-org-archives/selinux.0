Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F5DC001DF
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 18:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjG1SMC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG1SMB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 14:12:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106F1724
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:11:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9a2033978so37311921fa.0
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690567917; x=1691172717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJq8k6lNNex+jxuHtO6Nud6WPY1Yrkpm7xO/rdyH600=;
        b=RTehvfHgLhFcS611WXRXOL/MjJ5r5/Mb2bsiQpNqrdarq07Qb32fiyOlZNv4zamAgO
         6soM2JerxHQaKL+nF2+5rU25FRSqtAKOO6RdE4qlE5k48h1khHKU12YmE1GHv8JCOQNh
         t+vcSTfgvRunrh6FPxhXaoQaQYgkgjmunMHAx11T7sWPwQZdIEz8aPhm1W0PvIglGt0T
         vtkbLe7th1Var2Y4onJpUZLB5IWuwYsskZOOLXz//ObRGzRlsL+spJ7zIB9OshlKrovW
         cAeu0KInEFULxQfCaymfJCJ3pQcD9YYtnPiG5Ju7F3vEsBPUI640S10jSp3ySoXp08qV
         88Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567917; x=1691172717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJq8k6lNNex+jxuHtO6Nud6WPY1Yrkpm7xO/rdyH600=;
        b=LPzqLk8IDtvJ2tkD/riNphn9HAXDGHt9UK7ozFVbaZ1FtF0qapHigGfYhdGUHkyHmt
         q+d8FtEkNbQLC1uNSSsDXQ3YSm6brRLiOvI6UKDj+iwIl/UOgS7JORxtyEF1xNt7HrWZ
         91dbu4zy9Q/M4HOfGt4WM+30p9WdxJNRWn2cxf6XCqlWMQd2vqdvxol7b9S7R6nDrryJ
         cRj+KJm+21bGmmH3P9wILaUQ2pIUiu0GfBa6amwRD0MI+mlTG+85mwKVs4sVgpcfwr0c
         mAcCg3CBjbLO7N7F43QZPzG27skl9fv9ZArgyBW6M85mFKZEikBePTI3n7wMbl7cvBGC
         +CnA==
X-Gm-Message-State: ABy/qLYRe+5jg72kEsQwH4qvWWItTOFYIpQ62bES/5Xchy9HEm4h4rnH
        VzKbxQ/XkTUm1kTkRTVHppySwK8dWl4AaY4fwdG09BgvOV0=
X-Google-Smtp-Source: APBJJlGEi5yJwV2Q0d5cNaIKZIrL+EYMooRALEs2W7ljpR8n0z76SrzvDo6eBPrft3VzREpvUb3ArQWz2DRCMA0EcUg=
X-Received: by 2002:a2e:9e89:0:b0:2b9:cddc:adeb with SMTP id
 f9-20020a2e9e89000000b002b9cddcadebmr2137662ljk.29.1690567916938; Fri, 28 Jul
 2023 11:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230714185033.45471-1-cgzones@googlemail.com>
In-Reply-To: <20230714185033.45471-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 28 Jul 2023 14:11:45 -0400
Message-ID: <CAP+JOzSz83bTgWaWF6EogNrfcbsZG7SgKZ_5aFz2co4iYMZgxg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: introduce getpolicyload
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 2:56=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a helper binary to print the number of policy reloads on the
> running system.
> Print only a single number to ease the usage by scripts.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   - use main() prototype with arguments
>   - use argv[0] instead of hard coding program name
>   - fix indentation and spacing issues
>   - add binary to .gitignore file
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/.gitignore      |  1 +
>  libselinux/utils/getpolicyload.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 libselinux/utils/getpolicyload.c
>
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index b19b94a8..b3311360 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -10,6 +10,7 @@ getenforce
>  getfilecon
>  getpidcon
>  getpidprevcon
> +getpolicyload
>  getsebool
>  getseuser
>  matchpathcon
> diff --git a/libselinux/utils/getpolicyload.c b/libselinux/utils/getpolic=
yload.c
> new file mode 100644
> index 00000000..ce06bb78
> --- /dev/null
> +++ b/libselinux/utils/getpolicyload.c
> @@ -0,0 +1,30 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <selinux/avc.h>
> +
> +
> +int main(int argc __attribute__ ((unused)),
> +         char* argv[] __attribute__ ((unused))) {
> +       int rc;
> +
> +       /*
> +       * Do not use netlink as fallback, since selinux_status_policyload=
(3)
> +       * works only after a first message has been received.
> +       */
> +       rc =3D selinux_status_open(/*fallback=3D*/0);
> +       if (rc < 0) {
> +               fprintf(stderr, "%s:  failed to open SELinux status map: =
 %m\n", argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       rc =3D selinux_status_policyload();
> +       if (rc < 0)
> +               fprintf(stderr, "%s:  failed to read policyload from SELi=
nux status page:  %m\n", argv[0]);
> +       else
> +               printf("%d\n", rc);
> +
> +       selinux_status_close();
> +
> +       return (rc < 0) ? EXIT_FAILURE : EXIT_SUCCESS;
> +}
> --
> 2.40.1
>
