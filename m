Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCDC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8D760C3D
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhA1D0M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 22:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhA1D0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 22:26:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF6C061573
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:25:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so4953819edb.9
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOvuR1EHL3auJ3254YzQ2GupogQhN9qNF4C9zwM9XhI=;
        b=YhhAxygfhvXS5qmo5lVn0nDZzFr4LcEAtYfjJhQs6W6zmeEz73naszBXD2CZSAEVBR
         sIcOK4Iebzy7qoat4OEW3VRfUCE52BoDOw4ThYMU/RfAZvtKWTs5U5VZ+SuqnkmFIfRN
         m1utqZWxXQFcCija59PN75ks3k4m7OnXffB1Q7i4bIGZRjQ20XfMXMHKFrshXok6l/T7
         raSLuLRd4vLU7c29CUsp7SEkcV7ngLVu48lnhc5UDDZKsylOnQHYzPsCe3wY6Y0BK7/p
         jzHy0BjyA9AKiMedcHMO24P1E+Tg+AwRqCY0gg7djROoWn6Pmb0HHgHg6KEx0EojJPHx
         kzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOvuR1EHL3auJ3254YzQ2GupogQhN9qNF4C9zwM9XhI=;
        b=k2hew2fFJB8mgJIjqNvTYENTai3Mf/c4sYJ5x2qyKWyK3SVsbaKP8j/0pMi2r+WwaW
         xoxqCxNYkIMrm3p45A/8TheUTR6nSY0DskZUFKarHNQPgk+aW5PwB3kt008gJv2vdhnN
         hqgGLbP7xrCK1OxufWQ+zOxKE6bTJUYpy2XLJ3XaSvsuWnVdCHa8twrDZBNFjQWJsMCD
         ebAe3pXrVz1Y/+Vm70MTmR8qV4zQ1ChdIuVfQuDyns3T0cPi4TyegNnROhsTbHcXCu/g
         WFLdyGpsrAdeLCgqeyyxizAyp6zswYPp2p1+Zls/0wyNl26Ui9MAL4MM12Gl18pclGUb
         DOAw==
X-Gm-Message-State: AOAM531ns+P29oWr5Jnp+lmRp54rjPZbxxntd0agH2DHKOEWIg6UkMVj
        NtZcPvnjXgupYRJMSI4yzpZF3I2NFo/1668eN/HT
X-Google-Smtp-Source: ABdhPJzrFnkX9YvAFy440IPhVOou4kn6nvIS+vV1vMCJ6YfOh8EH27hFCbBDOegTxKe15NSl04Ll4YQ65dOCFS6GGP0=
X-Received: by 2002:a05:6402:34e:: with SMTP id r14mr12109648edw.269.1611804328580;
 Wed, 27 Jan 2021 19:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20210127153303.135235-1-richard_c_haines@btinternet.com>
In-Reply-To: <20210127153303.135235-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:25:17 -0500
Message-ID: <CAHC9VhSkuL2eUaBQYQBHEmy3OPP+vSmEVT9Eh0PTx8t4DZ5nJA@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Add new section for Embedded Systems
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 27, 2021 at 10:33 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add a new section and supporting examples for embedded systems.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> Changes from RFC version: Added comments from Dominick, minor text updates
> and rework example Makefiles.
>
>  src/embedded_systems.md                       | 546 ++++++++++++++++++
>  src/implementing_seaware_apps.md              |   2 +-
>  .../embedded-policy/android-policy/README.md  |  34 ++
>  .../android-policy/android-10/Makefile        |  42 ++
>  .../android-policy/android-4/Makefile         |  31 +
>  .../android-policy/brillo-device/Makefile     |  46 ++
>  .../android-policy/brillo/Makefile            |  38 ++
>  .../reference-policy/README.md                |   6 +
>  .../reference-policy/build.conf               |  84 +++
>  .../reference-policy/modules.conf             | 236 ++++++++
>  src/seandroid.md                              |  12 +-
>  src/section_list.txt                          |   1 +
>  src/toc.md                                    |   1 +
>  13 files changed, 1074 insertions(+), 5 deletions(-)
>  create mode 100644 src/embedded_systems.md
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/README.md
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/android-10/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/android-4/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/README.md
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/build.conf
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/modules.conf

This is great guys - thank you!

-- 
paul moore
www.paul-moore.com
