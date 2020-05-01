Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91592C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D97A24956
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q/ftg6nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgEAQ0v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgEAQ0u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 12:26:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F8C061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 09:26:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so7882981ejx.5
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2p3FOaX0DS09/7QbgKGgrB1yUjM8UsdqcmOadbYKYZ4=;
        b=Q/ftg6nUFNjVXUdFalpT98v8aCqcxryx9cl+or9ChKXsUUaecXIx6/iczWj/1cmjoq
         VSqQZ39fMLCd+SAleX8JTclrYUV+qt+jOXuBRF4n5UU3bbJvCGGDVRoIqrAEN/XleDF2
         U9NrqS7lgRz86ROWbK3RgrdFIdJbb4cShIEfvNvWe6paZJgVQzSFof8S51NTYdCmoYHJ
         7cKD/6zYdbErKRuJbfUYRbL6VveMylZHpmTB9S9uQ2gAruwM9QzSiHUO1mJ0Q7ia/HY1
         0caw1QuPO5/w2xldX4vNT1wRbyRJ+62aMrtW54c/gZpk55iO2S3qk16QzKPvIumNLCvq
         Z3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2p3FOaX0DS09/7QbgKGgrB1yUjM8UsdqcmOadbYKYZ4=;
        b=fjZqOaE7jHraKnunv6sEFqkbzh/mbHEYsxywO15JujdFhK70ABz4AtM484MnB60hOe
         khSiyy4o8WZ0ie3B62xMK0OSv5PQfOrOkaKtExyU3p9JnZyuNl6aIILneC8rq41MhnNP
         P3p4JiMw8DXrmKH4icV6MKVrWqg1VjRD5/F3FitFPi8m7JnR5eh1weHrF06bSCY1vQAK
         lxcfdmepCIOtZ03aK+8nZTm/oQxfR5BnzFm8qtXShBAOWvxR/f5GL8Mi6+T5uMQJEGXt
         f0Oe3r1EdTs4EdktBxMef4Is+AEs3WF0fjNAgz9Nw7Cq92ajnhW4zkHqwlJm2BHnEfJl
         J2Vg==
X-Gm-Message-State: AGi0Pua83VzkDE03GL/uzKmw2gB654jwONW7fxkw7Bj8CMkx7cKTbZFP
        Sl4g7cIHvDLITwM7ddPKHehmNSmp6LpSvL2OvVZw
X-Google-Smtp-Source: APiQypKlEVo38u/mCHo8ndYdqxa7Igd8PKqmNoc8zcvwQit4TrEJiwwRQi9dER1xnxDM3xi5f+tBbpfZhpG2T2yTgdY=
X-Received: by 2002:a17:906:29c4:: with SMTP id y4mr4004113eje.95.1588350407429;
 Fri, 01 May 2020 09:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200501092615.1143868-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200501092615.1143868-1-nicolas.iooss@m4x.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:26:36 -0400
Message-ID: <CAHC9VhSyn_+j=Qqviis7A9kQDWWWm=oXxFvTL6R-c1yUFTZTog@mail.gmail.com>
Subject: Re: [PATCH] README: add much useful information
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 5:26 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> * Add SELinux logo
> * Add a link to Travis-CI
> * Add a link to lore.kernel.org archive
> * Document that SELinux is packaged in several distributions, providing
>   links to policycoreutils package (this package requires libsemanage,
>   libselinux, libsepol, etc. so if it is packaged, most sub-projects
>   have to also be)
> * Make Fedora install command readable on GitHub without scrolling
>   horizontally and update it
> * Split installed packaged between the dependencies for the "main"
>   libraries and programs, and the bindings
>
>   - The install command line has been tested using a container from
>     image fedora:31
>
> * Document Debian dependencies
>
>   - The install command line has been tested using a container from
>     image debian:10
>
> * Document running `make test` with `./scripts/env_use_destdir`
> * Introduce "macOS" section for instructions specific to macOS.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>
> The rendered README is currently available on my GitHub repo:
> https://github.com/fishilico/selinux/blob/wip/README.md
>
>  README.md | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 3 deletions(-)

Looks nice to me, thanks Nicolas.

-- 
paul moore
www.paul-moore.com
