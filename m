Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5DAC5ACBF
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC309206B7
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMOgfkOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCMOl3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:41:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726652AbgCMOl3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 10:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584110488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L92h+kRXLOD9d67l8zvkpZyaqYMQ6oMnE8MbJrSQEmM=;
        b=AMOgfkOZW/fwFZRGwxKfUIER1QjoSityVXFKG4DO0nDDdbQAwYIHjJMK3n77ADI1u9o+/N
        B5vDux8V4mFMaXlTtx+WOlDsxeTWqq3drRIj0Okio+fHXSTuIxRoH0BEXBUpwFNFHJNTqh
        LjdJkeenuOZCPZoMA6kHcKb1sT0HTj4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-buTVdFscNSecnF77hWOGjA-1; Fri, 13 Mar 2020 10:41:23 -0400
X-MC-Unique: buTVdFscNSecnF77hWOGjA-1
Received: by mail-ot1-f71.google.com with SMTP id 79so5873379otu.19
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 07:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L92h+kRXLOD9d67l8zvkpZyaqYMQ6oMnE8MbJrSQEmM=;
        b=sg36U3VP72aOzbQToIbaFykwebyi404p+TH8iBtnJg1LLEoILRjOoLv/pmFgRviU13
         uW1X5DNW0a/rEboP9sEnyk17SFz1spauMqsicqKh5VcgcILVuGIP/wVaKFEnK002rXVi
         zCR0g7YGZBCu5oJtOLL6Pt129Kl5X/xNeAfxMi2SWykDzlhzqF0rZU1bTYf7Shsa2feh
         mQVp4K8wT3oRVT9vSn7BiGx5vGfXKPVOb40CwFs0fwhrn/f+iLDcHMjtgS2A6sVUEOtD
         vxqFzRvXK9fI7qe1x0KLbmwSNBQ7XfGvzZBH3SyNj38O9XZLf+PIjSVFGoH7AGlDhoDg
         dRxg==
X-Gm-Message-State: ANhLgQ3yZj7KiYC7DxOXDz7GAnWvmyLTLHZmgX+mcjFC1qff/iznkxsP
        xxhMeR3uAxrg8Tv7uaGikyYlkgiKuEdeJ5jTyC24W215EVBw9VakmZDhTUPgn549vTl4y4NacVE
        TEgIQ1t85Rrsku55rE19uhKOtTBQmys2fuw==
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr10714106otk.43.1584110482491;
        Fri, 13 Mar 2020 07:41:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsM5Bep+PyFRgSdnDdinrMQ5kqToMFFiRfdE6cztB6A/+stTuRvDl7S32SCBQaRgGpqzZVEbtZK/dNr6CtlkwQ=
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr10714079otk.43.1584110482187;
 Fri, 13 Mar 2020 07:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
 <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
 <CAFqZXNsYcCQGLNYXHsEz_yw3y54mK2NO1XVk6pXtJatEn1b54w@mail.gmail.com> <CAFftDdpUP9BVFxZrY_ZNs2276OGuwKQaRJo_DvVLqjo073Mj1A@mail.gmail.com>
In-Reply-To: <CAFftDdpUP9BVFxZrY_ZNs2276OGuwKQaRJo_DvVLqjo073Mj1A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Mar 2020 15:41:11 +0100
Message-ID: <CAFqZXNu=gPM=HE7M0tgb_Bba+ih+ZSedrj=7P06i8Q7nu+KtLQ@mail.gmail.com>
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

On Fri, Mar 13, 2020 at 3:23 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Mar 13, 2020 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 10:42 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Thu, Mar 12, 2020 at 3:21 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2020 at 9:59 AM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > I will fix the subject and add the Fixes: #165 to the commit when I
> > > > > stage them if thats ok?
> > > >
> > > > Fixes both 165 and 204 IIUC because the real underlying issue for both was the
> > > > fact that he was building with LTO and it was doing the wrong thing
> > > > with hidden_def/hidden_proto.
> > > > Otherwise works for me.  You can download the series from patchwork or
> > > > via get-lore-mbox
> > > > to pick up all the Acks automatically.
> > >
> > > I have no idea how to do that, Ill have to spend some time and
> > > familiarize myself with it.
> >
> > You can simply go to
> > https://patchwork.kernel.org/project/selinux/list/, click on any patch
> > in the series (e.g. https://patchwork.kernel.org/patch/11430261/) and
> > copy the address of the "series" button/link in the upper right
> > corner. Then you just do:
> >
> > curl <link> | git am
> >
> > There is certainly a faster way to do it using the Patchwork CLI, but
> > I never bothered to set that up :)
>
> Thanks, ill have to try that next time!
>
> >
> > > For now I just manually added the acks and did the edits we discussed
> > > and rebased ontop
> > > of current master. Their was a simple conflict in libsepol/src/services.c.
> > >
> > > I have them staged here:
> > > https://github.com/SELinuxProject/selinux/pull/207
> >
> > The CI failed because libsepol/src/services.c still includes "dso.h"
> > in the rebased commits. You'll need to fix that first.
>
> I'm sitting here thinking, "I built and ran the tests, how?" Looking
> at bash history,
> for libselinux, not libsepol!

No worries, fortunately we have CI to cover our backs :)

Anyway, I just noticed that there is still a typo in the last commit's
title ("libespol").

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

