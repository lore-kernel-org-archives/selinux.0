Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1015C433F5
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 03:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiAMDSh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiAMDSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jan 2022 22:18:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A16C06173F
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 19:18:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o6so17899737edc.4
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YBqCVlM5Y0AkzoplYiM9m6k/7pPPMEXr2zhT+ZAYi8=;
        b=tuLH+0ezfhqYCyiDBdi70jyEAcNj/938uoXRNfeXM+xUCWUVOl2hbOrNpEx4MMgNWQ
         QR093dypoBrevV5zMiyeQyOGzt7Tfzh5gLkXEFSaixeqCmM5A42K8btpWrGACPCVJspv
         A+laNGCqmBcUQVcY9KRqNM8CiJowJ/sNOstT1jkuDK18rOIzpIMxMtRfHtBEWMNRbffz
         H4xezLpXRRru178bHqCeSiCkoNUakOUUJl0hUmGyundE+odMefTJqQanbMoET1u7pcTL
         ijlAZmUzNlMOptoO8/S5/COPNW2rdKSmBWNmgT1N8AewifIUAMmWuroVbU81bSV2dZ3c
         02mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YBqCVlM5Y0AkzoplYiM9m6k/7pPPMEXr2zhT+ZAYi8=;
        b=YSrLMLYsgIvNfGNXSJmA5hwXQxuCb0fpPhRpCph1w+qkWGZmUyzysa5RpT87aekf90
         eXoRZNA78YpRp4GVxe8/BWQsP4OlZPGs1CL0WCPgxU6DVaMsH3wuPVPitvoIkxr583Al
         sAI241iy7Osv+zZUzDd5XGhOBggQBRATT8hYTq32mxpyUjlM57Ql0zYWGMIGR5qmleMB
         Ip1hIVVXdJEFeP7s6+MjiPO5/rHjsrQqjtiGdsQY76rm6jCJWpNXgL0ftOndB4qrQw+Q
         +brhOcT4YzEmpB80/R02ZAk5M1PDGE87TH4p9uVxj9lxrrlxdFmRW0ye9nDOnnuURt0S
         Uh3g==
X-Gm-Message-State: AOAM531jauQ5n7eD8AyphrX5rpMFzdfFUXIIR3b3NOfZRe9Rh/GAymF8
        ALFpTWbe6NeC0k/4+hkhNcPkDPG1QikuXg7TILTqwNd3Vw==
X-Google-Smtp-Source: ABdhPJwe0QWllUi6hTWfTlmF0hexa2kxntSVN3Xithe/b4sez0hMVGvJMU21/E7ys/HjC0ro8wQY23qJuOOH6SbJXuE=
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr1996282ejc.29.1642043912450;
 Wed, 12 Jan 2022 19:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20211216173306.36377-1-richard_c_haines@btinternet.com>
In-Reply-To: <20211216173306.36377-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jan 2022 22:18:21 -0500
Message-ID: <CAHC9VhQdfEkpq9XGxyj8cO7Z3wasOpC7ov75fbQgj1xT_4_iQQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Add epub build
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 16, 2021 at 12:33 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Build an epub document. If Calibre is installed also build a version
> suitable for a Kindle (azw3 format).
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  .gitignore          |  1 +
>  BUILD.md            | 26 ++++++++++++++++-----
>  CONTRIBUTING.md     | 13 ++++++-----
>  Makefile            | 55 +++++++++++++++++++++++++++++++++++++++------
>  README.md           |  8 ++++---
>  src/cover.md        | 16 +++++++++++++
>  src/cover_epub.md   |  2 ++
>  src/metadata.yaml   | 14 ++++++++++++
>  src/styles_epub.css | 52 ++++++++++++++++++++++++++++++++++++++++++
>  src/styles_html.css |  8 +++++++
>  src/styles_pdf.css  |  8 +++++++
>  src/title.md        | 16 -------------
>  12 files changed, 183 insertions(+), 36 deletions(-)
>  create mode 100644 src/cover.md
>  create mode 100644 src/cover_epub.md
>  create mode 100644 src/styles_epub.css

This is starting to look quite good!

The larger tables still render significantly outside the boundaries of
the page (the first table in the overview section is particularly bad
for some reason), but overall it looks pretty good and I'm hopeful
that if we continue to play with it a bit more we can get the tables
looking reasonable.  In the absolute worst case we consider converting
the tables to another formatting style; tables seem to always be a
problem in markdown anyway.

Merged into the main branch, thanks again Richard!

-- 
paul moore
www.paul-moore.com
