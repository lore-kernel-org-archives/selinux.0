Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC18C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390220746
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BscKBjTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMOva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:51:30 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42200 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMOva (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 10:51:30 -0400
Received: by mail-il1-f195.google.com with SMTP id p2so1326817ile.9
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MsDFX2TYrouWJ+hYomXOsQWQtkX7+aM/S1FF2sB8Ak=;
        b=BscKBjTkwjT9G+E2jpA75l89OF6VtYgzjbcnokCiQCHLbxNr6JT/K00tyw3BLYr5sY
         +yV3ax0MnrlSjwUxE/YT/IloiP+31URmvZ0pWuNeoSo3LxhpBbPxxhru+mfAXSHJr47d
         FLU9gRu6ecCEFpT/55UG7cX+StM9J/4Cpxjeq6fVVh8ea/MPeAS5/gguVpZuM01O3RsJ
         XPNTDW8zeBhFBJEfZAzZYa9eC99PXqMchcukMT9ojMsU7rq7Yv9Cm83q+AwzJ0h/XMp3
         a24aU7/gP8nTTqOj1lYXIOHSSg8NVxkmkrnnbc7Wl3uQwvV400K91d1wIEdVjgYk6PG8
         DH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MsDFX2TYrouWJ+hYomXOsQWQtkX7+aM/S1FF2sB8Ak=;
        b=P7hwPI+WWEM5qqJaeaZG3MTrp8KBwC3FVG6ZXrMMctoBaW0qwTtZOu+ZcewfhtaITV
         dBP4OYd0fZFjXkq9tlW8WYcit5ExZpkz/HlFyAgVFVQdoJfUGlG3zMKlGAg0fT+4P1DW
         ejzciY7xRFnRkFLoATKUO6yCyolXHNQYWA2QvjuFASz5hlNDzgF7P2WEPutm3eMpPczM
         mrZKKzR/ucgfyhoxQlEENbj2TitMlU3t0SCQF6RsbcfBXttq9t7mQhOgWpTJOxPflWW6
         rUMMTwUEHqEKOwLIHsiRMauyRowm8XfPivjr7s1k5lMPytBOda2LODt4oTJMv7UY5cE+
         UUyg==
X-Gm-Message-State: ANhLgQ1oEvJzzfK16tcTcwLSSjoN+PVZtmYDWMWfeSAai3pz/YHNxyns
        jWw4mC7HUYsQYihsrhTowOZWfier8rPAD3HfFGY=
X-Google-Smtp-Source: ADFU+vspMRFMt9UnCicA60Z9H4miLds3SlpAtt4OgtIkhz8lNqRkCXOewdisdDoTdzvri49gKstdsykTogQB6cDMUr0=
X-Received: by 2002:a92:d111:: with SMTP id a17mr13944151ilb.163.1584111089314;
 Fri, 13 Mar 2020 07:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
 <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
 <CAFqZXNsYcCQGLNYXHsEz_yw3y54mK2NO1XVk6pXtJatEn1b54w@mail.gmail.com>
 <CAFftDdpUP9BVFxZrY_ZNs2276OGuwKQaRJo_DvVLqjo073Mj1A@mail.gmail.com> <CAFqZXNu=gPM=HE7M0tgb_Bba+ih+ZSedrj=7P06i8Q7nu+KtLQ@mail.gmail.com>
In-Reply-To: <CAFqZXNu=gPM=HE7M0tgb_Bba+ih+ZSedrj=7P06i8Q7nu+KtLQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 13 Mar 2020 09:51:16 -0500
Message-ID: <CAFftDdpSmscdtrZjyjQK+ZWSDkhooka94KD4zDaeT4UpzVz3fw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     Ondrej Mosnacek <omosnace@redhat.com>
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

On Fri, Mar 13, 2020 at 9:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Mar 13, 2020 at 3:23 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Fri, Mar 13, 2020 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, Mar 12, 2020 at 10:42 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > > On Thu, Mar 12, 2020 at 3:21 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, Mar 12, 2020 at 9:59 AM William Roberts
> > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > >
> > > > > > I will fix the subject and add the Fixes: #165 to the commit when I
> > > > > > stage them if thats ok?
> > > > >
> > > > > Fixes both 165 and 204 IIUC because the real underlying issue for both was the
> > > > > fact that he was building with LTO and it was doing the wrong thing
> > > > > with hidden_def/hidden_proto.
> > > > > Otherwise works for me.  You can download the series from patchwork or
> > > > > via get-lore-mbox
> > > > > to pick up all the Acks automatically.
> > > >
> > > > I have no idea how to do that, Ill have to spend some time and
> > > > familiarize myself with it.
> > >
> > > You can simply go to
> > > https://patchwork.kernel.org/project/selinux/list/, click on any patch
> > > in the series (e.g. https://patchwork.kernel.org/patch/11430261/) and
> > > copy the address of the "series" button/link in the upper right
> > > corner. Then you just do:
> > >
> > > curl <link> | git am
> > >
> > > There is certainly a faster way to do it using the Patchwork CLI, but
> > > I never bothered to set that up :)
> >
> > Thanks, ill have to try that next time!
> >
> > >
> > > > For now I just manually added the acks and did the edits we discussed
> > > > and rebased ontop
> > > > of current master. Their was a simple conflict in libsepol/src/services.c.
> > > >
> > > > I have them staged here:
> > > > https://github.com/SELinuxProject/selinux/pull/207
> > >
> > > The CI failed because libsepol/src/services.c still includes "dso.h"
> > > in the rebased commits. You'll need to fix that first.
> >
> > I'm sitting here thinking, "I built and ran the tests, how?" Looking
> > at bash history,
> > for libselinux, not libsepol!
>
> No worries, fortunately we have CI to cover our backs :)

Why I love CI, free checking.

>
> Anyway, I just noticed that there is still a typo in the last commit's
> title ("libespol").

Agghhh, kill me now! Updated.

>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
