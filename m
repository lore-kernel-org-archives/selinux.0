Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FDFC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557652073E
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vch0gyOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCMOXK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:23:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46951 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 10:23:10 -0400
Received: by mail-io1-f67.google.com with SMTP id v3so9481719iom.13
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tDDyaZpKiskfOmR6wnKZD/0q7B0CvN9TBTmsKjyoTY=;
        b=Vch0gyOz8z1K/P9zWSCNMZV/6NSO4xTRHhBgRzqC4hKLKbQWdx6ddkPzLnj0PGIueM
         NObLn1Q89tIV0XtR7GWcMYSacVwOyw0KwZuGA8CMrf5cylkiuipL+kkDUBFLkWyjIocX
         kKEd1ew5EQ5SFl5LE6um+q5N9Go78nQuc1Lmzp8ZZ1LjHVePvPMx2hjwnhL3j0gymfb6
         INmyE3IB4etimiycqUHCQOwR0eXMyzFjaQgS6u2qpN3w+TbeOJWUhmxTs8x4RRTJDqCP
         /rPWibrbij0cGKreOo+rs9/Aosw975tEdKZ+yDlkzPQwN/vj5esoQxByHAE7rAeeVjgY
         bOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tDDyaZpKiskfOmR6wnKZD/0q7B0CvN9TBTmsKjyoTY=;
        b=dEEkWoEK3o3SW5TxYT92j2NqIzHBZTq6RABH4L3N2mcEzY/J7E+EQkQ81vB8EFtj8e
         FD31UzzZ2V6hnZEQQQ7Juq9TtxPDjsFlZPl/ISiIjZZhlHl87bVit33RfoGwW3VnBO5T
         0MScupBgfHHX0GrtXgNFpLR4+N8TVYCI+BZEHedvqzEJjot7q0u1jIxEPFwwWioXoEme
         ThCq9OMtj7HXz56aK/vdiy8giHx9RDubteBRSTr0wnarci15kPpAd2o8MMcMvUXxos3w
         JirtALm+NnS84XhDp7YsdI2CRgma4CXBrtEdEDazermmEp3VmVGtEm5hi2yCPoWQk72k
         ep3Q==
X-Gm-Message-State: ANhLgQ20wpxKal6OwJwZjoSxF0OdW32qUdOO2o9Hp2y2jomTTpuR0iOD
        Kuw632c13t2YM5kSumn1Z7i7hX2IJyKJU6mdbDY=
X-Google-Smtp-Source: ADFU+vvGnrrUyLe9aaaK6E/y1SUM83zQxAZqNTPWe6NaB4Ewdo5T142UqZrtG5+Y2AINI4sxQwPTFGbRZBDm9Kda7p0=
X-Received: by 2002:a02:604b:: with SMTP id d11mr12831023jaf.61.1584109389450;
 Fri, 13 Mar 2020 07:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
 <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com> <CAFqZXNsYcCQGLNYXHsEz_yw3y54mK2NO1XVk6pXtJatEn1b54w@mail.gmail.com>
In-Reply-To: <CAFqZXNsYcCQGLNYXHsEz_yw3y54mK2NO1XVk6pXtJatEn1b54w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 13 Mar 2020 09:22:57 -0500
Message-ID: <CAFftDdpUP9BVFxZrY_ZNs2276OGuwKQaRJo_DvVLqjo073Mj1A@mail.gmail.com>
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

On Fri, Mar 13, 2020 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Mar 12, 2020 at 10:42 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Thu, Mar 12, 2020 at 3:21 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Mar 12, 2020 at 9:59 AM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > I will fix the subject and add the Fixes: #165 to the commit when I
> > > > stage them if thats ok?
> > >
> > > Fixes both 165 and 204 IIUC because the real underlying issue for both was the
> > > fact that he was building with LTO and it was doing the wrong thing
> > > with hidden_def/hidden_proto.
> > > Otherwise works for me.  You can download the series from patchwork or
> > > via get-lore-mbox
> > > to pick up all the Acks automatically.
> >
> > I have no idea how to do that, Ill have to spend some time and
> > familiarize myself with it.
>
> You can simply go to
> https://patchwork.kernel.org/project/selinux/list/, click on any patch
> in the series (e.g. https://patchwork.kernel.org/patch/11430261/) and
> copy the address of the "series" button/link in the upper right
> corner. Then you just do:
>
> curl <link> | git am
>
> There is certainly a faster way to do it using the Patchwork CLI, but
> I never bothered to set that up :)

Thanks, ill have to try that next time!

>
> > For now I just manually added the acks and did the edits we discussed
> > and rebased ontop
> > of current master. Their was a simple conflict in libsepol/src/services.c.
> >
> > I have them staged here:
> > https://github.com/SELinuxProject/selinux/pull/207
>
> The CI failed because libsepol/src/services.c still includes "dso.h"
> in the rebased commits. You'll need to fix that first.

I'm sitting here thinking, "I built and ran the tests, how?" Looking
at bash history,
for libselinux, not libsepol!

>
> >
> > And since their were some minor edits before they go in, ill let them
> > sit a couple
> > of days for any last objections. Ill merge Monday March 16 end of workday if all
> > is silent.
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
