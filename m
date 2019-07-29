Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E5C76186
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD782073F
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfG2Vf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:35:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47239 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfG2Vfz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 17:35:55 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 227AF5646F6
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 23:35:51 +0200 (CEST)
Received: by mail-ot1-f48.google.com with SMTP id n5so64173612otk.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 14:35:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXHXPi9OoZPPb+MNtOJrIBTBsUzgfmoPk6ztXtp7B2WrHBVQPd4
        jHmILOoizw1sOaNSYxWBCLVeztMEa8hwU0m5RFw=
X-Google-Smtp-Source: APXvYqyeWcdVEvikjna9dL2l7qxm0awD5wa4nA7Yh/IJaouzIfHZJapBonSn0Vr4JexuT+PjdGEwUkACURV6B0n1d1U=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr77726484otp.189.1564436150167;
 Mon, 29 Jul 2019 14:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190311222442.49824-1-xunchang@google.com> <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
 <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com>
 <32330df5cf5c0daf1de03c049637694856aa69c9.camel@btinternet.com> <CAJfZ7=k0+EyUxWALx9ZU_O4AEkKWP0Bfr=eTf8Z=52s-PXYg5w@mail.gmail.com>
In-Reply-To: <CAJfZ7=k0+EyUxWALx9ZU_O4AEkKWP0Bfr=eTf8Z=52s-PXYg5w@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 29 Jul 2019 23:35:39 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nRKLpBXmJW8Hg6at-0nfs34_VAoVohv4PHi0vZQZBpFg@mail.gmail.com>
Message-ID: <CAJfZ7=nRKLpBXmJW8Hg6at-0nfs34_VAoVohv4PHi0vZQZBpFg@mail.gmail.com>
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context matches
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        xunchang <xunchang@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 29 23:35:51 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 28, 2019 at 8:30 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Jul 24, 2019 at 5:39 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > On Tue, 2019-07-23 at 22:06 +0200, Nicolas Iooss wrote:
> > > On Wed, Jun 19, 2019 at 4:45 PM Stephen Smalley <sds@tycho.nsa.gov>
> > > wrote:
> > > > On 3/11/19 6:24 PM, xunchang wrote:
> > > > > We used to hash the file_context and skip the restorecon on the
> > > > > top
> > > > > level directory if the hash doesn't change. But the file_context
> > > > > might
> > > > > change after an update; and some users experienced long
> > > > > restorecon
> > > > > time as they have lots of files under directories like
> > > > > /data/media.
> > > > > Therefore, we try to skip unnecessary restores if the file
> > > > > context
> > > > > relates to the given directory doesn't change.
> > > > >
> > > > > This CL is the first step that factors out a lookup helper
> > > > > function
> > > > > and returns an array of matched pointers instead of a single one.
> > > > > The old loopup_common function is then modified to take the first
> > > > > element in the array.
> > > > >
> > > > > This change has already been submitted in android selinux branch.
> > > > > And
> > > > > porting it upstream will make these two branches more consistent
> > > > > and
> > > > > save some work for the future merges.
> > > >
> > > > There were some changes to this patch before it landed in AOSP, so
> > > > they
> > > > aren't quite consistent.  Do you want to submit the final patch?
> > >
> > > Hello,
> > >
> > > What are the states of this patch and the one which has been posted
> > > in
> > > April (
> > > https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
> > > )?
> > > I do not follow what happens in Android but if the patches have been
> > > modified there, it seems a good idea to post the modified patches to
> > > selinux@vger.kernel.org.
> > >
> > > Thanks,
> > > Nicolas
> >
> > Once upon a time Android changed the way restorecon(8) works by
> > replacing the per-mountpoint security.restorecon_last attribute with a
> > per-directory security.sehash attribute computed from only those file
> > contexts entries that partially match the directory.
> >
> > To achieve this Android produced the first three patches that are
> > mentioned in Tianjie Xu reply to this thread (One specific to Android
> > (for their version of restorecon), and two that are common to upstream
> > SELinux if implementing per-directory attributes).
> >
> > The V4 patches I've sent [1], will implement the upstream version of
> > restorecon(3) supporting per-directory attributes. Plus it also
> > resolves "the requirement for caller to have CAP_SYS_ADMIN to call
> > setxattr" problem mentioned by Tianjie Xu.
> >
> > However, to implement my patches [1], you need first to install the two
> > common patches [2] and [3] that Android have already installed and sent
> > to selinux@vger.kernel.org (read my cover letter patch for details).
> >
> > I think what Stephen is eluding to in his initial email, is that one of
> > the patches submitted to Android and the corresponding patch to this
> > list [2] are slightly different, and that the Android team should
> > resolve this before any merging can take place. The differences I've
> > detected are listed at the end of this email.
> >
> > Hope this clarifies the situation.
> >
> > Richard
> >
> > [1]
> > https://lore.kernel.org/selinux/20190706152115.8490-1-richard_c_haines@btinternet.com/T/#u
> > [2]
> > https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
> > [3]
> > https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
>
> Thanks for your explanation. This indeed clarified the understanding I
> have of these patches and I agree with merging the 2 patches you used
> as a base of your 2 patches. I have created a Pull Request for this,
> https://github.com/SELinuxProject/selinux/pull/172 , and will merge it
> tomorrow if nobody disagrees.
>
> Thanks,
> Nicolas

... Merged.
Thanks,
Nicolas

