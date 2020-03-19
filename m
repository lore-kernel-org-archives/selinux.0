Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9437BC4332B
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693642072D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nplp6pQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSTqO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:46:14 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40744 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSTqN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:46:13 -0400
Received: by mail-il1-f194.google.com with SMTP id p12so3443302ilm.7
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBe8SPnWS1gg4xPzAlvWaH/i8zQRtSGNuOsqjNkSGM4=;
        b=nplp6pQszEGJkpZSy9o1XRCKnBSl4NiGtoA4E6adGCsEQYqR+FxnUVekVQ2ILVJlvo
         ygMORBzee+QDCvEzZKleIBy5vQwF4e8r+BDUWmKeG7jTdVMeUKYv0+6vmKLvFZvzTbMp
         0igX5/QluN6C3Ol6KPPkzBCDOd8aWTE2+W7cJSK2EGSZAkQP2u1qjwf0mLngJCb1F56k
         XjwxcwehH94M2mx51thoNrtmsIjyIueADN0lMmVOqDZspV+pTcRuI/H3rhExvIxDeWn2
         osAs5yOwGDdgDkS+exjZQIaXtD3b6b3xVouZ78y47b80BTQPQOA9HhEQyFahua0QzrVL
         Dvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBe8SPnWS1gg4xPzAlvWaH/i8zQRtSGNuOsqjNkSGM4=;
        b=hQXzXJ8odN6JHgM/CbY2E2jOBIUidXxB5K5LQ6oVd8HNuYt+uqbdu6EjfCJiM4mZhz
         PDAsKiRxbc2pNvOZ72HnMg1GUo+YQCzIWaWpWYiCovGhWNCI64kaGH5LK9b4KQ663JpN
         dFbZGFf95J8HJIgagc4guthX5DY5u74IzcXQQ0HAqeV/HzvYvhGQ9Q0T80A8I/YruPs9
         dV+cKU+qYCscBTrMyKHy0WWt82C6Il0MbLhoB6COtI0Svqy3EqsxU61QZW3x9WTRi9bO
         YQl/dslWloJEn8OZ5sBRI5hlZB0ZJCJSHB2QLND9GqkbLvZqC+YTCaH8IcM/9X+yAggm
         1W2w==
X-Gm-Message-State: ANhLgQ2SISQozEKklwJkC9eS2+MmLeNp5OhzRlpG2e7rbRs4eS9mrBOx
        BnKymwZZp6JgH/K1EhCZ0+NHEc1QcevKxMp6IOQ=
X-Google-Smtp-Source: ADFU+vsNJY87EsUpQ7/2OzPqvTc6xG+JB3S83xMeITdbNG84qmO2aTXlae6gjHpw0KQEZE420Y60U+ivDvOkl44mSvA=
X-Received: by 2002:a92:8b89:: with SMTP id i131mr4660266ild.129.1584647172706;
 Thu, 19 Mar 2020 12:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
 <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com> <CAEjxPJ5FB7mkMTZuyVN7pQNNO_-oibm_V5i0_2pn8-=rcMGX1w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5FB7mkMTZuyVN7pQNNO_-oibm_V5i0_2pn8-=rcMGX1w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 19 Mar 2020 14:46:02 -0500
Message-ID: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

FYI: Looks like I missed a dso.h in cil.c:
https://github.com/SELinuxProject/selinux/blob/master/libsepol/cil/src/cil.c#L53

Doesn't seem to be breaking anything, ill submit a patch to the mailing list.

On Tue, Mar 17, 2020 at 12:46 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 12, 2020 at 5:42 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
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
> > For now I just manually added the acks and did the edits we discussed
> > and rebased ontop
> > of current master. Their was a simple conflict in libsepol/src/services.c.
> >
> > I have them staged here:
> > https://github.com/SELinuxProject/selinux/pull/207
> >
> > And since their were some minor edits before they go in, ill let them
> > sit a couple
> > of days for any last objections. Ill merge Monday March 16 end of workday if all
> > is silent.
>
> I merged this pull request.
