Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A39C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 16:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKIQAG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIQAF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 11:00:05 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C3213
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 08:00:04 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso20057985fac.13
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 08:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+f1SrIqzDE7n6OiU4RCeB2X8DjhdgfXB6vev0VdccM=;
        b=eou6ADHYdoCWWz1QZZThXTYoNodMD0mLnxtw+XM7yu0TqmJKir/sGtvycLRBv159h0
         OWguxkzZYh+kX8r95WLAXuSswcgWgx6JUdr6NC8FZ+TWh+6i9GF2B7+190JJscNzDvXT
         knKrPKrh3/6CF1diOHDq3DwMalnWcq64Yjnytnl2oxeLterBYw63d5qCg1YdPwDejnd4
         76aCb7tFRM1n9JITtiLjTLAj3wrlkHSgaYHpVeDld0bib1sJuF6SZni266wOpOYDxdhd
         cf/ap0S/JRMBGY/vwM34HV3uY482ThY13ouH9QFgqR1zOEkKlE2P/nNyls0x4YEXuJXs
         9NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+f1SrIqzDE7n6OiU4RCeB2X8DjhdgfXB6vev0VdccM=;
        b=BYnFSCB7+FyegDLO8pYntYTgUe5d2hZhKS3NGJibuOiI+3k7MA3dRD5iPtC6RYmgp9
         OpKNA5pGzLkiDwMI7U9EhKx91cWMmiO2yDQLExl2rMcQKRM2LZO5mjqlB3upAiSVXNyJ
         Y44+rMBWiT3EDjXiHBZ+gq1YjEbYIGGTw9S28Eb1pvzTXvX51OdfEhyGAEa6kDn1Y2fI
         v+511SSzc8WLHTqE8mHPlmBz7zkeVdagoRJKCp9PZ7nC2vdoJ75F7BjbsXV/tsvC8RSC
         honLPvv1bsbhE+g8BHC/COpJv78JEi3H5zsaeuNLpghjv2X0l1PROekkHQCTRu8odLat
         nnVw==
X-Gm-Message-State: ACrzQf3zQuxhj4s8o68iGEgi9zF6bclIv/MHVd34b87boq15veQ4Lrc3
        lUaHhchjs4on44CXPU+fHGtEbw2eLjep9ewxW5jbFiiRww==
X-Google-Smtp-Source: AMsMyM6+IRz36sPeJT+zOrNY+P8gglLBnFcVzUhr/kZMYlVsupRxX1xhE0LOTcU+AmU3ih/jcci2WCI9I0tC+2VRDxQ=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr36180712oap.172.1668009603609; Wed, 09
 Nov 2022 08:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20221109040039.732341-1-paul@paul-moore.com> <CAFqZXNsEqFT0oYcdfdrp0WgR7S022=V6oZMr0F7YgFSuVumKhg@mail.gmail.com>
In-Reply-To: <CAFqZXNsEqFT0oYcdfdrp0WgR7S022=V6oZMr0F7YgFSuVumKhg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 10:59:52 -0500
Message-ID: <CAHC9VhRTjVZM928ZfBvav+wUKVLBPLMOJgSHHUdu=EjcO=Gnxw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the sidtab context conversion indirect calls
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 4:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote
> On Wed, Nov 9, 2022 at 5:02 AM Paul Moore <paul@paul-moore.com> wrote:
> > The sidtab conversion code has support for multiple context
> > conversion routines through the use of function pointers and
> > indirect calls.  However, the reality is that all current users rely
> > on the same conversion routine: convert_context().  This patch does
> > away with this extra complexity and replaces the indirect calls
> > with direct function calls; allowing us to remove a layer of
> > obfuscation and create cleaner, more maintainable code.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/ss/services.c | 51 ++++++++++++++--------------------
> >  security/selinux/ss/services.h | 14 ++++++++--
> >  security/selinux/ss/sidtab.c   | 21 ++++++++------
> >  security/selinux/ss/sidtab.h   |  3 +-
> >  4 files changed, 45 insertions(+), 44 deletions(-)
>
> The goal of the callback abstraction was to avoid the awkward coupling
> between services.c and sidtab.c, but both ways are ugly in some way,
> so I consider it a matter of maintainer preference. So if you prefer
> this version, feel free to go with it :)

While function pointers do have their place, e.g. the network stack
and VFS, history has shown that indirect calls aren't without risk.
In addition, Linus implied that he wanted this removed, and I don't
feel strongly enough about it to argue.

Merged into selinux/next.

-- 
paul-moore.com
