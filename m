Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5315BC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B92074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="daYf3/dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHXPWw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgHXPSq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:18:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0804CC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 08:18:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so12384397eje.10
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRgxx3tSppOhQm2AF9dKudiK1eoIPsBzHjrzxWNccQc=;
        b=daYf3/dPe/PnYYkrooX/rVmS45t4DA1QFjn9WvpYZOaB8t57g+JFujh8yuBib99jR4
         vIzEO8EqlnsRyjNE722w2uOeme8bRViAs//bphEqVnkGvOB+DgBmQyrQI1/9+x879wL4
         bADN+z6UF5CuSKuZR8GVYupOcvSR6uTSfO12ISaYS5IkOdjgE+v2sNl3rmK2F/9tP613
         iDdTyq2Dc+evvSRTGjW1qNGLY4NdTOhfH8g8HLKrlktkavSzDuxdAIAj4stgjSYFBjKA
         t/pX/pU6F98XXnweKZqDNkuQFqq00RPBPdzjxeUAY1nYrefcfHVv7Hv7wk7ooijsVycC
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRgxx3tSppOhQm2AF9dKudiK1eoIPsBzHjrzxWNccQc=;
        b=dVoOPZIlC+/oaP0+9dnp+4oLZzshZYVEvXfk5ELmqiQYpY0i2D1vNvwONCfgUkx1eP
         zXYsO8tbd2VW10L/CwanfCaiU/+nhtWzbfY3k5MzDt68L4W2c3PDRSPfbf2K/qNGP2fg
         sc5cfW4aWxyaRAGlHRauwsXO0D7M1mY4D6YKeCgUakXt89e0VJG7jr1cMhCig5pISAh4
         7AKpfihxgnKt8ln1NbpIokMJlAytHE6eiP7ohZw8m7kK4cd8VcjJSXf+hYtlfRpAOiGV
         wf0yeCh3AMl3evS/H8o3nvu93NrSo7sKpkkbqYkyZ6bQN2n7sc7hki1LsBY5vHnY+GQp
         GUVA==
X-Gm-Message-State: AOAM532Wetk/zR8YQQZzjEcOMx7bal0yNGVAe7s1HQEqh6WXeNOJVBbY
        0Qc1SA8dkNT2mHFd23/ndmEJODV6+wO2cEzlyGP5
X-Google-Smtp-Source: ABdhPJzEcj2wnnrEKoEv1PPbTejxVV5BfnUX9z1HWRRCCDAss73M+rPmLz2mKoZoQ9jbxRk7R0BEPxTD5pf7AG6nhCs=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr5890079ejm.488.1598282323578;
 Mon, 24 Aug 2020 08:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200809162212.193739-1-richard_c_haines@btinternet.com>
 <CAHC9VhTP+A3mGO_1nVz4Q-WtEBNubAGO_gysR7L-_OOqFRazZw@mail.gmail.com> <4588336e487610f41187718629369aeadbd651d3.camel@btinternet.com>
In-Reply-To: <4588336e487610f41187718629369aeadbd651d3.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 11:18:32 -0400
Message-ID: <CAHC9VhStYMc0KMo9hQat8GF64ToK+j7=5603gd=T62oXTd9Brg@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Convert terminology.md to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 11:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-08-24 at 09:40 -0400, Paul Moore wrote:
> > On Sun, Aug 9, 2020 at 12:22 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > >  src/terminology.md | 349 +++++++++++++++++++++++++++++++--------
> > > ------
> > >  1 file changed, 243 insertions(+), 106 deletions(-)
> >
> > Merged.
> >
> > I wasn't sure how I was going to like the changes to the
> > abbreviations
> > table, but I think it still looks okay and it's more consistent with
> > the rest of the doc.  Thanks Richard.
>
> Just to let you all know that I've converted the remaining sections to
> markdown. I'll send the updates in small batches (A-Z) over the next
> week or so.

Thanks!

-- 
paul moore
www.paul-moore.com
