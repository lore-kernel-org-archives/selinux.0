Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2537C001DC
	for <selinux@archiver.kernel.org>; Tue, 11 Jul 2023 17:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGKRDd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKRDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jul 2023 13:03:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73039A1
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 10:03:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so74331271fa.1
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689095010; x=1691687010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U10mCCcne1jEEvvV6AFgfstA/KMs/2YSReJoJP/gLRk=;
        b=fPZppNv0OnwnjQ6ZNbnKUOVAHyUXJKFm4ytKhYKMq3z+LrhGBW0u4HbuxX2NBgCQWV
         tJOdgnBgwH+HOi/LVhGSDwqw5Fv6Hjq2zOc6Dc1uuLJqlW4jqXLHxxi6fsk10yr+7Jr2
         Q4oTkQfnsOD9zuK3gvjiiVCyLwgxJQGHBw7fggTsSsPYkdhqCtIkx0zODWKKmP79P1/9
         7STvQW0bCnTMvn82/v4CYM89GU+KQQrtv7vkCw74/mc0HqpL0eoCysSzYoTC5KHuOcdR
         aFvW/bFeMKaKXoaG1DSJZMOGPFuxFbs4MYlo4JBTT4Q3e1qQrNughZSNA1weS+mgP5xx
         mW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095010; x=1691687010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U10mCCcne1jEEvvV6AFgfstA/KMs/2YSReJoJP/gLRk=;
        b=BzIkwLeF+v+2zwemmPM25LDQtJ+Tfp7XvBKnDjKVxkaVagiO8jUo8ySbE9x4/H7ckU
         lSvPwA6A7+zAIiq4OVIUPoCmjGIGl5qtmfy2Ds4NzIsxqVKx4n2G9f3dciWP569pF52S
         ikVH6RJFvaqTK9WO+HvbV3xyL2wMcEa7XM3aKvm4SWGmDT7/FN7dSNsFntfaQbDiX6xk
         gspqS8WG2tq5wINfjPbLnyAgUo8zgJkyH5LL5yzna93zg+AwBwLTJMSSFDRtMzLBFUdl
         O9+MRwgW8aZjxDjeBXharL/Py+YCahrE5dtD/KWn+8M2tXF+xmUyJVw88go8iPXPOjKH
         0N8A==
X-Gm-Message-State: ABy/qLYi0NAsDv2zROQAk4GuBlNb75zjGKBOHZTeVCEMRgVi0nB9KwXQ
        y3LGIUusmxhL+7qRAICkYrwhUXQDX+KapT5kEys9Xv9hKRU=
X-Google-Smtp-Source: APBJJlH0oZF7PEiSE/zhHXExPPIur2EP1AxzEggd3hNBTfVKzYhUi7PnMiI0d7WujanFkfzvKI1lfhsxfBOmypRFs3s=
X-Received: by 2002:a2e:87d4:0:b0:2b6:d0fa:7023 with SMTP id
 v20-20020a2e87d4000000b002b6d0fa7023mr6976386ljj.24.1689095009319; Tue, 11
 Jul 2023 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230706134819.41903-1-cgzones@googlemail.com>
In-Reply-To: <20230706134819.41903-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 11 Jul 2023 13:03:17 -0400
Message-ID: <CAP+JOzSonSvjqKwXZPBfT6e+bntEYuW9FZmu7xWG6Av5NV1uhQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: introduce getpolicyload
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 9:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a helper binary to print the number of policy reloads on the
> running system.
> Print only a single number to ease the usage by scripts.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/getpolicyload.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 libselinux/utils/getpolicyload.c
>
> diff --git a/libselinux/utils/getpolicyload.c b/libselinux/utils/getpolic=
yload.c
> new file mode 100644
> index 00000000..53217ff5
> --- /dev/null
> +++ b/libselinux/utils/getpolicyload.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <selinux/avc.h>
> +
> +
> +int main() {

Should be:
int main(int argc __attribute__ ((unused)), char* argv[] __attribute__
((unused))) {

> +        int rc;
> +
> +       /*

Extra whitespace after the "*"


> +        * Do not use netlink as fallback, since selinux_status_policyloa=
d(3)
> +        * works only after a first message has been received.
> +        */
> +        rc =3D selinux_status_open(/*fallback=3D*/0);
> +        if (rc < 0) {
> +                fprintf(stderr, "getpolicyload:  failed to open SELinux =
status map:  %m\n");

You should just use argv[0] here.

> +                return EXIT_FAILURE;
> +        }
> +
> +        rc =3D selinux_status_policyload();
> +        if (rc < 0)
> +                fprintf(stderr, "getpolicyload:  failed to read policylo=
ad from SELinux status page:  %m\n");

You should just use argv[0] here as well.

Thanks,
Jim


> +        else
> +                printf("%d\n", rc);
> +
> +        selinux_status_close();
> +
> +        return (rc < 0) ? EXIT_FAILURE : EXIT_SUCCESS;
> +}
> --
> 2.40.1
>
