Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DDBC4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3D206F7
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgI2SAl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:00:41 -0400
Received: from verein.lst.de ([213.95.11.211]:41188 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2SAl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 29 Sep 2020 14:00:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E781267373; Tue, 29 Sep 2020 20:00:37 +0200 (CEST)
Date:   Tue, 29 Sep 2020 20:00:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, Ian Kent <raven@themaw.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Message-ID: <20200929180037.GA12447@lst.de>
References: <20200921163011.GZ3421308@ZenIV.linux.org.uk> <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com> <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net> <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com> <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com> <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com> <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com> <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net> <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com> <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 10:23:50AM -0700, Linus Torvalds wrote:
> On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > OK, so it seems that reverting comes out as the best choice here.
> 
> Yeah.
> 
> > BTW, I'm looking at rw_verify_area() and I see this "If (ppos)" check
> > and the comment above it... And then I look at autofs_write(), which
> > passes &file->f_pos, while ksys_write() passes file_ppos(file)
> 
> Ok, that doesn't matter for the security_file_permission() issue, but
> yes, autofs is doing the traditional thing, and it's pointless. Using
> file_ppos(file) isn't an option since it's an inline to read_write.c,
> but it could just pass in NULL these days and avoid that too.
> 
> So how about we just do the appended patch? Can whoever sees this
> problem just verify, even though it looks trivially correct...

This looks sensible to me.  I'd throw in a

/* only for autofs, don't use in new code */

near the export, but users of these kind of functions tend to be
blind copy and paste code anyway, so the comment probably isn't
even read by the relevant parties..
