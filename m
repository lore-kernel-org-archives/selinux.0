Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6018C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE80207DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sTsz8jAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYSNN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYSNM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 14:13:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C80C061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 11:13:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l2so11763078eji.3
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRAghVbAjHWqxC9aopTjVyH6vkz03jnDAQP6On6JAoc=;
        b=sTsz8jAl7gfoRPvkhgTXj4JXIjeTL61a1JvtzFCSN+OpbyGt85hNIEsPiQBmYJPrwv
         c3K4IPiodzPuguskFbhAJ/P5dancnoaLWDXjbHxlYtkIAP4Z0Nvdrj0dvmyPjyudkLjH
         uhta+M1L+wi/xsaAfjiW2Dtm1T93I9Fcp7EfbX+Fya/PLoaBZsThCQ4SNFzepgFystBy
         Js7PApE0a7dLhmuFi7jpsgYu72j64M8iHmk90dSIAOsqP2slhDZdEZpr7Zb2VI2ux8Rg
         05txi/lgDVXAKNSFVuMe7zNOvoyJ+TM+t6fyKARHc26uNZ662IMEbFAnfgG013N+PYjy
         33Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRAghVbAjHWqxC9aopTjVyH6vkz03jnDAQP6On6JAoc=;
        b=TvkPI786UjQbl0r81jjug/ltstU5TnjpUgETExP1AX3rh+HOjqkx8IsUvSepZPViyI
         inmGIAQ14yAf74S5s8LwkVeJgPMbL02lIw+ZmOUiefVNBY83SL0d+7ZvzTp6cXNf+nsd
         JaD9AJwmysTesf5rl9XYks5PPt+PsTasBdHSWH/MPovPZHhatrerZ1VyI/Am7vCmuPgU
         E6HE9ZxulSwy3//PPDXqK87zBhykVznTraaK9Z04AeAsb5N+v3wxBjQa/DwJcBlLyHPY
         qtZSSxxGhLNwibLHM932LrQXCmzsfoARdTYaSGw5VkWxu6kJsP7Wo6AkpkUYGFOQJv2u
         BU/A==
X-Gm-Message-State: AOAM531Dqr+PaV7hPlo/zQmB+vlZCP6zwjD/PVcZuHNJLZcEjuQwBZei
        qE8GYlRjxiHK8j7yzSplOqP4N4ntEzTo/9YpmhX7
X-Google-Smtp-Source: ABdhPJwQF0TQl5C3HtTT3U37dSL3Qm43Tk8qPijzUjescrG/tOv3c3A9mwKmKhcRJqPGzOl+fWXPKl2TXxd5MUcAR94=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr11576837ejp.178.1598379188395;
 Tue, 25 Aug 2020 11:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200825125130.GA304650@mwanda> <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
 <20200825141242.GT5493@kadam> <CAHC9VhRn17jYSWo2oUobn=7uHv7G=HD0QRJZZgQhR10UGBU7=Q@mail.gmail.com>
 <20200825150252.GU5493@kadam>
In-Reply-To: <20200825150252.GU5493@kadam>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 14:12:57 -0400
Message-ID: <CAHC9VhQ6LL9T8MJEQgsr1Ye5zG9shADP1Eso+XaFwd6Ff51L2w@mail.gmail.com>
Subject: Re: [bug report] selinux: encapsulate policy state, refactor policy load
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 11:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Aug 25, 2020 at 10:16:27AM -0400, Paul Moore wrote:
> >
> > Patches are welcome :)
> >
>
> Good.  Patches coming up tomorrow.  :)

Just in case there was ever any doubt, bug reports are good, patches
are almost always better :)  Don't ever be afraid to send us patches,
even if it isn't the "right" fix, having a patch to serve as a
starting point can be a great help.

-- 
paul moore
www.paul-moore.com
