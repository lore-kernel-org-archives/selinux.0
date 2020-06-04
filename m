Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2188C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AF2077D
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5uoMFhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgFDTD3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgFDTD2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 15:03:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F58C08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 12:03:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so5610313ote.11
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFZeEBAucH2GhgwDxSWMyh6WNVYdXi+eFYy5wM2lRmI=;
        b=o5uoMFhRsofrKQdu2gIweE0VpgAdn+ttqfU+5/rY1Xyz9ax4e3xE8Nj2hk1ZbYxhmv
         88VKwlM6d98C0L9mmxU/HPZ1wCDJmmt6/RQJovnJ+8cE97vrxR89Z76Kw53mkiRZum/M
         yIDK8Xas9fwbXNixCGRn76MySfGGgBN2cgMvDO2F9ygyzoyaj0FSTllNXp06IS04Jkfc
         Rz4TY9Tk0SbdzbiNHveClT2MfIY8Ox9+WbylHqY4JzBKBoF+5x7bMNj67/2BB/dV00VJ
         phV7D5eUiI/czWznOWabln+uVZGblCbRj1VthEgJin3AYPj8rQzsw7jU20lxkD9qaxK9
         EA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFZeEBAucH2GhgwDxSWMyh6WNVYdXi+eFYy5wM2lRmI=;
        b=YLRL9rL+sCbDjqFVFm2hsHAY6B8CfYPXHUKG+CVV5PgY720jhCDy0htMeOYXcwRAPJ
         sSmujcLBp96H4tNpl2mne+cRG8JvBiOHvZimeJm2xZXipm84yzDcHSnN2NiggxBBZn3E
         uynF5uN82cSQaOrOk2EIwnpbNg7juL+dPfeCYL0sLuUYruMSAXobyBgeZ77ek+vM5xCi
         LnlQL93BNUHv6XtLITaPWDX3K0QH5WAFO+5lEOZ5/ST5bzB2EI7fEkDQk9TpdCsOZXC+
         cc+iGit0KaZv5gGw+QcdwuJYJJ+9vnQwZ/AcQCO3bs03dyZrF2zMZXgLK0pqULjg1f2E
         Dc5w==
X-Gm-Message-State: AOAM5316+5XR7xxrMH7TeKU0fUiY1yCRBoF0sdI7v8nfB5zLBU9ADTUA
        I6oEIHVN3HEFYiwZT6hMesI5cdmxX963Walihtc=
X-Google-Smtp-Source: ABdhPJwPdMJRRkuH8R1XYQFzypy2CUHWReJQ6xrg1xcENGHCbV5R1Ds/fJ0GdTvqaeErnqEMBOO1w6qOSgrnRsZJ7vU=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr4960807ote.135.1591297407138;
 Thu, 04 Jun 2020 12:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200601093453.GB30453@workstation> <20200602185507.3784-1-william.c.roberts@intel.com>
In-Reply-To: <20200602185507.3784-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 15:03:16 -0400
Message-ID: <CAEjxPJ4NU0rd0ZgGuNXpWy37St==bfT8_XfR1Z1YQNwdLVR6tw@mail.gmail.com>
Subject: Re: [PATCH] README: start a section for documenting CFLAGS
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 2:55 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Start a section in the README for documenting that custom CFLAGS yeilds
> CUSTOM results and that your mileage may vary. The first CFLAG to
> document that you likely want to include is -fsemantic-interposition.

Spelling error (yields), capitalization (CUSTOM), and it should be
-fno-semantic-interposition.

>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  README.md | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/README.md b/README.md
> index 9d64f0b5cf90..f37a9f91f51e 100644
> --- a/README.md
> +++ b/README.md
> @@ -120,6 +120,17 @@ lacks library functions or other dependencies relied upon by your
>  distribution.  If it breaks, you get to keep both pieces.
>
>
> +## Setting CFLAGS
> +
> +Setting CFLAGS during the make process will cause the omission of many default CFLAGS. While the project strives
> +to provide a sane set of default CFLAGS, custom CFLAGS could break the build, or have other undesired changes
> +on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that we encourage to be set when
> +overriding CFLAGS are:
> +
> +- -fsemantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
> +   will support passing this flag, but ignore it. Previous clang versions fail.
> +
> +

-fno-semantic-interposition.  Also overly repetitive use of CFLAGS above.
