Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78824C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE1620714
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHqHoaoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQRqp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:46:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQRqo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 13:46:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id e19so1511102otj.7
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ScRKa8WqDRhBbAaF0XgxqrG4sYz2F7FyXGiQYpoXmc=;
        b=kHqHoaoONFKPzbJvsTHeveUBmSEb/ILBmsUNP+uCoSaIYTu6Ttcw59tvOoj/Pomovz
         IGaERxlnSEO3P4InpQ2DggMcLONxDeWo5z5f0Nzbrm+A/4Gb1ddkSnVR7xzcJTTkIXUR
         6UgcKzcmQypdgBRSUX/lE3xRud6iGRL7GuolI3824jCO1pMn2PdL29eWKofg9DobO5Y9
         ei1E+sOetrJf+4FTRK+gfdFuFNtfljYQjEqi3sNqUodmAINs9/oGj6eUtah6Ul+W5BuM
         IP2tqb+qbxLtC4moYE6aM1PHUuDUBYRzMBOiwaLLkpxO6jaDWrhx7ZKL7coTT+q0GnOi
         G1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ScRKa8WqDRhBbAaF0XgxqrG4sYz2F7FyXGiQYpoXmc=;
        b=WqtvNqrIxeB6rTgjLNoXOpDdCqDSZvLS3Dqg+etbv4mTdgXInqtIWhPOSQgoa6plZr
         twakC0VhgBZW3y8Yjyy8mhzQf5qzXZVGTT52aXjPn0lkHkK7yWNuigR9pmTmjOfcDW6b
         LWTQpz8XEqqYJ+1D+bIyqrlQshVfywmrPoLTyI5fObnzk1NwaSKiSNRKzJLES0Q1FEg4
         eqJKEgiqbo6wtIxgPpCk9FPJ7i3sn6WBPyhuAE3xKA3s25TXqG7kSjx5C57aDXzbfICg
         5owh+FIBYW8GeAo9otNowo5fat1BnZdzDkAyyGz5+qOF5y1saB0y8hgOqeT3lb/BZi8Q
         Urog==
X-Gm-Message-State: ANhLgQ0ecImynH5inb4F4D5mTl9cHgNU8WIjuYNA+cBqIT0QybplASbk
        mpj1nC4R07Zt1BIly7+GLeD2sSKOJMGLMG8iam0=
X-Google-Smtp-Source: ADFU+vtQXdxcVaIr5fXgHwFmqTSyt59m7W76PO/pI4ELVZBmebecA/kExpUelTnHvhUgcZ41jLCiPN/d5UeB3S+nYXA=
X-Received: by 2002:a9d:383:: with SMTP id f3mr334289otf.165.1584467203990;
 Tue, 17 Mar 2020 10:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
 <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com> <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
In-Reply-To: <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 17 Mar 2020 13:46:33 -0400
Message-ID: <CAEjxPJ5FB7mkMTZuyVN7pQNNO_-oibm_V5i0_2pn8-=rcMGX1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     William Roberts <bill.c.roberts@gmail.com>
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

On Thu, Mar 12, 2020 at 5:42 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
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
> For now I just manually added the acks and did the edits we discussed
> and rebased ontop
> of current master. Their was a simple conflict in libsepol/src/services.c.
>
> I have them staged here:
> https://github.com/SELinuxProject/selinux/pull/207
>
> And since their were some minor edits before they go in, ill let them
> sit a couple
> of days for any last objections. Ill merge Monday March 16 end of workday if all
> is silent.

I merged this pull request.
