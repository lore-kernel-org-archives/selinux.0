Return-Path: <SRS0=NDoE=UW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC53C43613
	for <selinux@archiver.kernel.org>; Sun, 23 Jun 2019 19:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499CB20665
	for <selinux@archiver.kernel.org>; Sun, 23 Jun 2019 19:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFWTrM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Jun 2019 15:47:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58131 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfFWTrM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Jun 2019 15:47:12 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 469D556129E
        for <selinux@vger.kernel.org>; Sun, 23 Jun 2019 21:47:08 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id n5so11452443otk.1
        for <selinux@vger.kernel.org>; Sun, 23 Jun 2019 12:47:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXL5neD1JBB3L3N60Hd4kdltpVJgTwpts70uCGYbyYPyO9jO19I
        GzVy2Wb5UTpsHkOaWMaYWRJy4e0F4VGvl+PnRT4=
X-Google-Smtp-Source: APXvYqyLQ+pEAKGIhSFf/XnM7PAjHfE4VkYttakTrkWlDyALWOcet0UpisxZfqON7UeBZf5189tftAeye9f8q34bjcE=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr21235959otp.189.1561319227279;
 Sun, 23 Jun 2019 12:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190621153955.19684-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190621153955.19684-1-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 23 Jun 2019 21:46:55 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nwZhkAEAM=FvLLC_qrLQHEugTiH5B_h2VS=XsUEe81uA@mail.gmail.com>
Message-ID: <CAJfZ7=nwZhkAEAM=FvLLC_qrLQHEugTiH5B_h2VS=XsUEe81uA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] selinux: Remove legacy local boolean and user code
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jun 23 21:47:08 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 6:10 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Remove legacy local boolean and user code, and to preserve API/ABI
> compatibility the following functions int values should be set to '0'
> as they are no longer used:
>   selinux_mkload_policy(int preservebools)
>   security_set_boolean_list(.... int permanent)
> and the following are now no-op and return '-1':
>   security_load_booleans()
>   sepol_genusers()
>   sepol_set_delusers()
>   sepol_genbools()
>   sepol_genbools_array()
> and these still return their paths for compatibility, however they are
> marked as deprecated:
>   selinux_booleans_path()
>   selinux_users_path()
>
> These have been removed as they are local functions only:
>   sepol_genusers_policydb()
>   sepol_genbools_policydb()
>
> Also "SETLOCALDEFS" removed from SELinux config file and code.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
[...]
> diff --git a/libsepol/src/deprecated_funcs.c b/libsepol/src/deprecated_funcs.c
> new file mode 100644
> index 00000000..08121c2c
> --- /dev/null
> +++ b/libsepol/src/deprecated_funcs.c
> @@ -0,0 +1,50 @@
> +#include <stdio.h>
> +#include "debug.h"
> +
> +/*
> + * Need to keep these stubs for the libsepol interfaces exported in
> + * libsepol.map.in, as they are part of the shared library ABI.
> + */
> +
> +static const char *msg = "Deprecated interface";
> +
> +/*
> + * These two functions are deprecated and referenced in:
> + *     include/libsepol/users.h
> + */
> +int sepol_genusers(void *data __attribute((unused)),
> +                  size_t len __attribute((unused)),
> +                  const char *usersdir __attribute((unused)),
> +                  void **newdata __attribute((unused)),
> +                  size_t *newlen __attribute((unused)))
> +{
> +       WARN(NULL, msg);
> +       return -1;
> +}
> +
> +void sepol_set_delusers(int on __attribute((unused)))
> +{
> +       WARN(NULL, msg);
> +}
> +
> +/*
> + * These two functions are deprecated and referenced in:
> + *     include/libsepol/booleans.h
> + */
> +int sepol_genbools(void *data __attribute((unused)),
> +                  size_t len __attribute((unused)),
> +                  const char *booleans __attribute((unused)))
> +{
> +       WARN(NULL, msg);
> +       return -1;
> +}
> +
> +int sepol_genbools_array(void *data __attribute((unused)),
> +                        size_t len __attribute((unused)),
> +                        char **names __attribute((unused)),
> +                        int *values __attribute((unused)),
> +                        int nel __attribute((unused)))
> +{
> +       WARN(NULL, msg);
> +       return -1;
> +}

Hello,
While testing these patches, I encountered an build error with the WARN:

deprecated_funcs.c:21:2: error: format not a string literal and no
format arguments [-Werror=format-security]
  WARN(NULL, msg);
  ^

gcc and clang do not seems to be smart enough to use the fact that
"msg" is a constant literal string. Could you please fix this, for
example by repeating the message directly in the functions, or by
defining a macro instead of a constant variable, or by using
WARN(NULL, "%s", msg)?

Thanks,
Nicolas

