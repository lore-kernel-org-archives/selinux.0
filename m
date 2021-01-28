Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D098DC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A470964DD3
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA1DLd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 22:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhA1DLW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 22:11:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51DC061573
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:10:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a10so5627798ejg.10
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXZhc8HAdhzeLNKuQcMCyUH6CSX25ydBy/uH4T84/WQ=;
        b=sECvCe6yvAT81igr2R8XdvkPHq2Qr8Wz8cXsWaUIsufuDOOH0vvrm1XqL2ngsymN+P
         HjJepL3NdcoFq7+hFC5+REqujO3nkdxBg55DkJ1ApqO9KQY5S8bLV3XdYXDfVlI3V7H9
         C3WVIKzu5KNCAkoq40oaYgz1suEogoxx610kwVCvoTaUj6MUnf6cp8xTVIr4TkgaRcZy
         tD3ru2IeNJnoO2MoT9c5y9hwTNm+1GpRVJ+TCKiZQ7OPQZ8BKaSGmf7eZV9Xg7MGpMfa
         5mNeVrZ+xecwcKZSpHsz6VX4ZA+nSvjl6MTZFzTpSOZxH3kCG5CPTH0T53p0Z01QepSg
         UNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXZhc8HAdhzeLNKuQcMCyUH6CSX25ydBy/uH4T84/WQ=;
        b=RfQM+FWXVGfOGPfB4Gk/nDNOX4sFP4QKJ5DDZBCMxSubkW9muQRELHhQtJgXxEQB+R
         EojIBIjEQzyY95G8CtYX0OmqB8IzP71AqTASim0DONTWGaPROlBE3P0Micbih8TEy+Jl
         Y5Tz1C2h2ZC+5+k7pPxFaJa6ji8xZ0atjcr5cY5nB5P0EnS4egJjylJqa9Wr/WhHzj6e
         sTpZuPycC7hgCcpWpLEwjYJAFdynTiyja/XLPr4nQPWDdRyfh+Z6D6IYgjIt0LbAK+w7
         9FXaVy80nX7+sQ8l/kUhNN3g77mDMHk16N8SHhYWZn59gIZ39DoLpB9/9Jm5gi3Bua/Z
         BHdw==
X-Gm-Message-State: AOAM532JfGgbHo6sKYcCBKSWiLvM7OoQeb/6hOFnqQftgBNfAmDWJJn7
        phIcL7OS/6ykCT+NbBW6UsKHYrEqY6bBGvzB70sLwvUyWS5p
X-Google-Smtp-Source: ABdhPJwYei5pob0GTFc/tEMyO4tzmEGMuDzRoYslPOLUrT1csbbJ6YTDsg0iBk//yZpgJg+hAWjcpaEsWzZDJ4zRd+c=
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr8906857ejc.488.1611803433259;
 Wed, 27 Jan 2021 19:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125132805.12146-1-richard_c_haines@btinternet.com>
In-Reply-To: <20210125132805.12146-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:10:22 -0500
Message-ID: <CAHC9VhRw1Ow7ve-kMORKPKYLwdWsjj5v-LFkKnRYH6_d6LLJxg@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Fix document links
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 25, 2021 at 8:28 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Fix navigation links and supporting text.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/configuration_files.md       | 12 ++++++------
>  src/implementing_seaware_apps.md |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)

Merged, thanks Richard.

-- 
paul moore
www.paul-moore.com
