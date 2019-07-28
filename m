Return-Path: <SRS0=3sNC=VZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6CC7618F
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 18:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187C12075B
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 18:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfG1Sav (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Jul 2019 14:30:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44809 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1Sav (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Jul 2019 14:30:51 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DC7ED5646AC
        for <selinux@vger.kernel.org>; Sun, 28 Jul 2019 20:30:46 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id u15so43796148oiv.0
        for <selinux@vger.kernel.org>; Sun, 28 Jul 2019 11:30:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUjzHu5yJdmZDOBwc74PMlL9tSclbjUnfYsmg+tJ+L7sEPToEml
        ikD+L1rIHsDDQKETpvCVriEJq8arAAI/RTL+1HQ=
X-Google-Smtp-Source: APXvYqyuoLax2UIJIKo1Eax1yXM3iWtOfFuAVF8TqT1vPAewYVTxg9lffAF58OJ4aZpMjAzqvhhtmZnnyrDLdx1DoJc=
X-Received: by 2002:aca:6104:: with SMTP id v4mr53766504oib.172.1564338645795;
 Sun, 28 Jul 2019 11:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190311222442.49824-1-xunchang@google.com> <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
 <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com> <32330df5cf5c0daf1de03c049637694856aa69c9.camel@btinternet.com>
In-Reply-To: <32330df5cf5c0daf1de03c049637694856aa69c9.camel@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 28 Jul 2019 20:30:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k0+EyUxWALx9ZU_O4AEkKWP0Bfr=eTf8Z=52s-PXYg5w@mail.gmail.com>
Message-ID: <CAJfZ7=k0+EyUxWALx9ZU_O4AEkKWP0Bfr=eTf8Z=52s-PXYg5w@mail.gmail.com>
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context matches
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        xunchang <xunchang@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 28 20:30:47 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 24, 2019 at 5:39 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Tue, 2019-07-23 at 22:06 +0200, Nicolas Iooss wrote:
> > On Wed, Jun 19, 2019 at 4:45 PM Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On 3/11/19 6:24 PM, xunchang wrote:
> > > > We used to hash the file_context and skip the restorecon on the
> > > > top
> > > > level directory if the hash doesn't change. But the file_context
> > > > might
> > > > change after an update; and some users experienced long
> > > > restorecon
> > > > time as they have lots of files under directories like
> > > > /data/media.
> > > > Therefore, we try to skip unnecessary restores if the file
> > > > context
> > > > relates to the given directory doesn't change.
> > > >
> > > > This CL is the first step that factors out a lookup helper
> > > > function
> > > > and returns an array of matched pointers instead of a single one.
> > > > The old loopup_common function is then modified to take the first
> > > > element in the array.
> > > >
> > > > This change has already been submitted in android selinux branch.
> > > > And
> > > > porting it upstream will make these two branches more consistent
> > > > and
> > > > save some work for the future merges.
> > >
> > > There were some changes to this patch before it landed in AOSP, so
> > > they
> > > aren't quite consistent.  Do you want to submit the final patch?
> >
> > Hello,
> >
> > What are the states of this patch and the one which has been posted
> > in
> > April (
> > https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
> > )?
> > I do not follow what happens in Android but if the patches have been
> > modified there, it seems a good idea to post the modified patches to
> > selinux@vger.kernel.org.
> >
> > Thanks,
> > Nicolas
>
> Once upon a time Android changed the way restorecon(8) works by
> replacing the per-mountpoint security.restorecon_last attribute with a
> per-directory security.sehash attribute computed from only those file
> contexts entries that partially match the directory.
>
> To achieve this Android produced the first three patches that are
> mentioned in Tianjie Xu reply to this thread (One specific to Android
> (for their version of restorecon), and two that are common to upstream
> SELinux if implementing per-directory attributes).
>
> The V4 patches I've sent [1], will implement the upstream version of
> restorecon(3) supporting per-directory attributes. Plus it also
> resolves "the requirement for caller to have CAP_SYS_ADMIN to call
> setxattr" problem mentioned by Tianjie Xu.
>
> However, to implement my patches [1], you need first to install the two
> common patches [2] and [3] that Android have already installed and sent
> to selinux@vger.kernel.org (read my cover letter patch for details).
>
> I think what Stephen is eluding to in his initial email, is that one of
> the patches submitted to Android and the corresponding patch to this
> list [2] are slightly different, and that the Android team should
> resolve this before any merging can take place. The differences I've
> detected are listed at the end of this email.
>
> Hope this clarifies the situation.
>
> Richard
>
> [1]
> https://lore.kernel.org/selinux/20190706152115.8490-1-richard_c_haines@btinternet.com/T/#u
> [2]
> https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
> [3]
> https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/

Thanks for your explanation. This indeed clarified the understanding I
have of these patches and I agree with merging the 2 patches you used
as a base of your 2 patches. I have created a Pull Request for this,
https://github.com/SELinuxProject/selinux/pull/172 , and will merge it
tomorrow if nobody disagrees.

Thanks,
Nicolas

