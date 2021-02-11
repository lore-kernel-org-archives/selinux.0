Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC9C433E6
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B4F64D9C
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 16:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBKQft (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhBKQdr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 11:33:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2FC061756
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 08:32:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id b9so10934721ejy.12
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4256LvFpqrjJWxaCLTjmivG0mWQTVKA8Bzu5/DQPbA=;
        b=tFpohbmgZGg4MQpbdAo0AKvocbpdtyRxf13vfA+L6tzIIB5fCkBdfXgDj0mGZaidTB
         wJKuRF6BnmBr/f/jTRkSASCQgTjvC5tFUN22ksT4Vxa/xuGOVBzSc5+da63YKtUHGQz0
         lGqbtM2Ab030ZvHFq/f4YF3YIpf4T/g477H4RmptG48hhjcLP8zjtO16e+IF8fr4fQ3V
         qx5SbrTVWnXVbjR/W4so3+BrBC1KsX1vM2djXvzJWOqayGLEoGCTitEH29tm17ZpjFp7
         pAzhRWVbaohSChSA2F+CtQnqz9VJ7QV0lXiSrw/CpxKJM0GMttLlOw2gbYMVlaG7LXAO
         4hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4256LvFpqrjJWxaCLTjmivG0mWQTVKA8Bzu5/DQPbA=;
        b=DGY8so+zUYLwDJUtnObfslRwkwTE4PXrsoz36lEG3LRlr5v4AfJzRxlVxFGnrwA8xS
         WgfditBzWnCtky8ktuoRbrF+voOzzL1Xj8+WFzjnC9FnJD6yuqnVA8sINvX+xw7jNYko
         YvUoyN9gX6dgCpiFk1ceW2h4g25BBYSQ74+Bus/thJoXB6EhGLeoWOmGTHlgeFd6hrad
         VCOH2Gx2+sL/KK8RwjGK57zy/AAxB762KqqLJF9XtoLw5SDm5zSzlu8HgrWGBDy9sM28
         yMqwuOdN4SEeWtWrjtlnUiOjFIYSOLZg4qdOfJkqIk2J9ayLAQluAuzQC/nT0ls+cTsX
         mZfg==
X-Gm-Message-State: AOAM530XC3zGs4FijWrCBnz2fxCm4qTIau/tIP3Dqc+XwPHVZ+m0hyJY
        cKAZaHIwIp8WDhkVLeA++pbW+up0uV1GydtS1yAM
X-Google-Smtp-Source: ABdhPJxYQ438Z9wm2ZtfF0roQWuh5mUn58vDjkODPItVE19H9pc9j1rgBNa0AbgJ4ibX8j2m4e1lcHTPZ/sU32bMDmU=
X-Received: by 2002:a17:906:35d9:: with SMTP id p25mr9200468ejb.398.1613061172254;
 Thu, 11 Feb 2021 08:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20210209200233.GF3171@redhat.com> <CAHC9VhQYE3ga53AiK2r-568_=2U0BJe+L4g9U_J0dLinzJqXYA@mail.gmail.com>
 <20210211140147.GA5014@redhat.com>
In-Reply-To: <20210211140147.GA5014@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Feb 2021 11:32:41 -0500
Message-ID: <CAHC9VhS=GkB2JbSz++iTygGzb2Ze6WVKuj5rnNaNVTN=p7=dCQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow context mounts for unpriviliged overlayfs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     selinux@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 11, 2021 at 9:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, Feb 10, 2021 at 06:50:57PM -0500, Paul Moore wrote:
> > On Tue, Feb 9, 2021 at 3:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Now overlayfs allow unpriviliged mounts. That is root inside a non-init
> > > user namespace can mount overlayfs. This was added in 5.10 kernel.
>
> Actually this is being added in 5.11 kernel (and not 5.10 kernel).
>
> Paul, can you please fix this while committing. If you want me to
> report, let me know.

Good to know, thanks for the clarification.  As far as updating the
commit description, while I generally prefer the patch author to make
changes (my personal opinion is that maintainers should have as light
a touch as possible outside the mechanical work of merging), this is
pretty minor and I can fix that up if you want.  Regardless, we've
likely got ~2.5 weeks before it really matters anyway :)

-- 
paul moore
www.paul-moore.com
