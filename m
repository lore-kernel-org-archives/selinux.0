Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AAFC10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DF4206E2
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0xW+S2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCMLD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:03:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgCMLD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 07:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584097435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UYs7bmn9cNnUmddyXMdiHcwqrWrdlo67xaexxjXLYAA=;
        b=Q0xW+S2XaBMb/4pnUYN4iOMb/rMozlcHciS/QZMe1sxm/UCfOhCdfAjbB23K1EF6lwD4Wd
        agtjSdsaATwqkQKQ2Hib7GsiDi7lPHzm2zPWKcYkz9ji+1k9TIcB1ula4nHBcdP20W2l/A
        nl86WdB4mIv/jGXiddTwhD3+7tfVfcM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-b3qZUaxxOhW6yPnH7BDprA-1; Fri, 13 Mar 2020 07:03:46 -0400
X-MC-Unique: b3qZUaxxOhW6yPnH7BDprA-1
Received: by mail-oi1-f198.google.com with SMTP id a13so5043156oii.23
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 04:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYs7bmn9cNnUmddyXMdiHcwqrWrdlo67xaexxjXLYAA=;
        b=mnAGNWw2cSFeg2K82qJvZybaKSshT7VffMjxCib8dRzA9g9qBDj92e9VePq9UDzAtq
         IwJ1JeSg7TOCWDMaaNScHn+QUtEwO3TIdCwjyVOjthy1kQexhfAHJLt75rvpv/wIWJdB
         9AfoO/fAsDCm3ajhQ0TmFazexH2Eh+VNGW6DAJph4Nt4DgA/jck7NyNO9300Quod+BiV
         H0y5OT73/CCBSPGKg05SGadcUdjNd08gi/SSezyP2scNO/JBPxUFr8dudWZu8v7ImrTF
         FTRZP6ROd7z2rMsu2dopGNeMJ7DAViRmltwsno6Gqsx56zQEhsdSj7FLtv3fjHcDQAco
         Sv1w==
X-Gm-Message-State: ANhLgQ1/Qfe/Z4aUxI7fE/rORL9MxWq1bJe5/5UHriKUnVhGtymeAr1/
        OWEGZHRoL5ic3BlvyH7753PeEQheNZNEmoNpDKZhmsD8zo3Mn9+ypxL7e0R6m1dXgrYHAo4CCnp
        G8V99EJ5/2CHahupqxSdMBox+zf2HdLcGFQ==
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr10034949oto.367.1584097425201;
        Fri, 13 Mar 2020 04:03:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvm0wd1Vp1mekwuN0/kdR7rjSKjI1HADsTcAvjbLpB0kLsIewVDc7Oo2QpLroLMOw1CVB3Pkl7H23cfoAe8Mmw=
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr10034915oto.367.1584097424914;
 Fri, 13 Mar 2020 04:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com> <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
In-Reply-To: <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Mar 2020 12:03:34 +0100
Message-ID: <CAFqZXNsYcCQGLNYXHsEz_yw3y54mK2NO1XVk6pXtJatEn1b54w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 10:42 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Mar 12, 2020 at 3:21 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 9:59 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > I will fix the subject and add the Fixes: #165 to the commit when I
> > > stage them if thats ok?
> >
> > Fixes both 165 and 204 IIUC because the real underlying issue for both was the
> > fact that he was building with LTO and it was doing the wrong thing
> > with hidden_def/hidden_proto.
> > Otherwise works for me.  You can download the series from patchwork or
> > via get-lore-mbox
> > to pick up all the Acks automatically.
>
> I have no idea how to do that, Ill have to spend some time and
> familiarize myself with it.

You can simply go to
https://patchwork.kernel.org/project/selinux/list/, click on any patch
in the series (e.g. https://patchwork.kernel.org/patch/11430261/) and
copy the address of the "series" button/link in the upper right
corner. Then you just do:

curl <link> | git am

There is certainly a faster way to do it using the Patchwork CLI, but
I never bothered to set that up :)

> For now I just manually added the acks and did the edits we discussed
> and rebased ontop
> of current master. Their was a simple conflict in libsepol/src/services.c.
>
> I have them staged here:
> https://github.com/SELinuxProject/selinux/pull/207

The CI failed because libsepol/src/services.c still includes "dso.h"
in the rebased commits. You'll need to fix that first.

>
> And since their were some minor edits before they go in, ill let them
> sit a couple
> of days for any last objections. Ill merge Monday March 16 end of workday if all
> is silent.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

