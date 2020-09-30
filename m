Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96683C2D0A8
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 05:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55099206DB
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 05:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3FuW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 01:50:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50181 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgI3FuW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 01:50:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 166B05C0112;
        Wed, 30 Sep 2020 01:50:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Sep 2020 01:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        Mp9EqWJ4lUoNUl6c9m7THxG0vTK6pHSVa8wUIjwah7U=; b=ankom8DyIiQ+f5GR
        QbMxnDP32vp7AOWdPOGsbegp24fY9xujXYyST4xC5PqMredoKwSfBruFjMUWvroy
        81hY4WDA8m7bI3nJ5awlRThuRS1wqr5/5JKnxKAI2K4g4d7Do5dN17YjogWo1Gs0
        dX42MvKifQ3q/YSbym/YnYvR00pf41h3hCjCHbAHoWvsdrc+nPCynPGfHtc02NMG
        rouFrA57rHcneLWSA1d1fDqlxNH6SHoNKCCYQVOhTYnfhib6T4daJ0tEoMpwjdTx
        XFCGoFCLAlnqFOLyGl1S7AsfPR/SSGMCCRBXkOb+yu4C/4Uj5dKFmajOTTZtBSBO
        KaDGjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Mp9EqWJ4lUoNUl6c9m7THxG0vTK6pHSVa8wUIjwah
        7U=; b=B2KqN8M7C517SqGwaazCflnXDlSHILOVG5C8VgaxEvKEUpnrKMg78jFOn
        9edzsSp1/5A+GiqjCnlpvmdX3Q0S1TlbeCKTRhhUNeQBgT75u1+IVJ3fi98vDjUs
        KPA0HuGR/KTM+m7sDFAHY1y2q+NI3gjrflPZ21pdQpb+Mwb43/roFtv/DcVsA4zf
        1ab2o6WHDctFZdzWCqdBQDEebbOfrev8GKdRxrSPUlCQv5BAsDtkrPxZQdrYVnwD
        47QNr6tgwN7UJ5M2LXBkog2A79BvLhI7kJL/HP7qINqXJjIz9bK3usp+TBjfzBxC
        5dSTrQ1rvRMcr94RmMOFs8FipBo5Q==
X-ME-Sender: <xms:nBx0X4aTOnM93Ew87NG_-a2PVhUZi7xgXN3Ozsup3JTeBMvDVG2ixg>
    <xme:nBx0XzZQ-StDGA1JJH6WnjNSJy_0tWqCv5tl3TAX-MyYBvOMMOvoeLlbx6kXeG8hc
    1V-0ObgYWQ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduvddurdeggedruddvkedrvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:nBx0Xy8DYHRV0h7iRBTc76RoNdetRvIRDm5jEkMQZGWE82eK31aZNg>
    <xmx:nBx0XyoB9cUUjsu-ehms1pgoXOMdGOkatBVqxsKgmqGzneUXKz3qbw>
    <xmx:nBx0Xzr_WCNwqQ0AZtbgzbYvYXCn3C55yLm9T2tO70oT77yYwiVD5g>
    <xmx:nRx0X0DKnl8WVFm1qYbMnz_GwfgNV1BdVsuBfI0_w-d_lqs6jxnhOQ>
Received: from mickey.themaw.net (unknown [121.44.128.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id 489FA3280059;
        Wed, 30 Sep 2020 01:50:17 -0400 (EDT)
Message-ID: <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
From:   Ian Kent <raven@themaw.net>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Date:   Wed, 30 Sep 2020 13:50:14 +0800
In-Reply-To: <20200929180037.GA12447@lst.de>
References: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
         <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
         <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
         <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
         <20200929180037.GA12447@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-09-29 at 20:00 +0200, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 10:23:50AM -0700, Linus Torvalds wrote:
> > On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <
> > omosnace@redhat.com> wrote:
> > > OK, so it seems that reverting comes out as the best choice here.
> > 
> > Yeah.
> > 
> > > BTW, I'm looking at rw_verify_area() and I see this "If (ppos)"
> > > check
> > > and the comment above it... And then I look at autofs_write(),
> > > which
> > > passes &file->f_pos, while ksys_write() passes file_ppos(file)
> > 
> > Ok, that doesn't matter for the security_file_permission() issue,
> > but
> > yes, autofs is doing the traditional thing, and it's pointless.
> > Using
> > file_ppos(file) isn't an option since it's an inline to
> > read_write.c,
> > but it could just pass in NULL these days and avoid that too.
> > 
> > So how about we just do the appended patch? Can whoever sees this
> > problem just verify, even though it looks trivially correct...
> 
> This looks sensible to me.  I'd throw in a
> 
> /* only for autofs, don't use in new code */
> 
> near the export, but users of these kind of functions tend to be
> blind copy and paste code anyway, so the comment probably isn't
> even read by the relevant parties..

I'll build a patched kernel and give it a whirl.

Ian

