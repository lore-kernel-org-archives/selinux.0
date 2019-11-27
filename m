Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8560FC432C3
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0E217D7
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zmUjUY1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfK0Un3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:43:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45907 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbfK0Un3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 15:43:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so25918715ljg.12
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EB4/knNs+vWKzG9d3D2zh6Mmu0oPU+u/O54o/0EjqA=;
        b=zmUjUY1NAZZtpJVEOvZYH7zdf6xHzO1OZ/fWXINzr1a+kNcwMsrxcil2g6QYUQaplh
         sz7UqGiuBGgWcrZqwTISa4KcKKu6xB9k1G53flFVVCV8SDNWVwMflIiNkjMPOEp46r+4
         jlER63qhgFl0P4esp5yDA4Vc1Wb7KEl6GwWO2VfYTSlSw3Dkbzjeu16XCOksA7Yry7yZ
         ob4FeYDnr9j9AHWPan6DpaAK1ZrZ3igBFBcjEoluOHyHx6WLFHwoy8KOV0+DX3BY8gJI
         jw8pVjkMzkfBsYQI6Ty8A6HmzBnLsm3fvREk+ixMR8AnFlqXP2iVwLUJ1SzwLpDX3VnP
         8hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EB4/knNs+vWKzG9d3D2zh6Mmu0oPU+u/O54o/0EjqA=;
        b=ivaFCzWiAdrYkAcl1r4zkZ1ZMMXiqLq8M52Nu3WncAb+5sxa3m3/WlZxsGjgoDV+F0
         MjKktb9S6/PJIYzhvOLBpzWZyk5Yl+haHt4NjUwSoAqWgM9jzVO3vNEqpOpsaj3iSAbh
         kJ4aEzoiR4zz1Bx7gmTlc0KesS4DwMnyaY9FS9LAp2aDQEfmtpVgMvq0Bgv519aDAHn+
         +fjdwwUGQ6o5tQRYT/9cpRmXWnDvc2NNxIOgbem2Cs2R637CRfx3FkcwbOGCKjJjomT5
         wRcBeDTYdglAEL/IfwrXFoKF8iYJvbhvs4NseyOaQA/YuFcLZIr31D/MdiASIjhNLZiy
         dS4w==
X-Gm-Message-State: APjAAAXnqx+h30QCQnMHQzUiLarCmlufzYQZvGhEPgf4XDgK+q4nBPXo
        g7XIClFgIoMpyoIKu70Xn6Rs5BmCJT+82Eu9QhO7
X-Google-Smtp-Source: APXvYqzjXXEqqJrPbjF/L4lRRk0lCD2TQ6ds+ia038SGST9wXuNmejczcknlaj5tmSeEXG5s5hFpr05YZ1fAtJmX2GA=
X-Received: by 2002:a05:651c:1ba:: with SMTP id c26mr3133429ljn.126.1574887406362;
 Wed, 27 Nov 2019 12:43:26 -0800 (PST)
MIME-Version: 1.0
References: <157486604069.70468.14139138243381994891.stgit@chester>
 <CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com>
 <574b6648-8698-65e0-23c4-5ddb096b36c6@tycho.nsa.gov> <CAFqZXNtm3H02aFTinZ0OGtezFdVJ66dQV9YXx2ABm-3z-UtWoQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtm3H02aFTinZ0OGtezFdVJ66dQV9YXx2ABm-3z-UtWoQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Nov 2019 15:43:15 -0500
Message-ID: <CAHC9VhRYebGQEPFG0FZmkjbzrbn6yewSqHrdRgLQJLpzsjZ7qA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 27, 2019 at 10:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Nov 27, 2019 at 4:24 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 11/27/19 10:21 AM, Ondrej Mosnacek wrote:
> > > On Wed, Nov 27, 2019 at 3:47 PM Paul Moore <paul@paul-moore.com> wrote:
> > >> From: Paul Moore <paul@paul-moore.com>
> > >>
> > >> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
> > >> Add kernel module tests") require the kernel-devel package on Fedora,
> > >> make sure we list that in the README.md file.
> > >
> > > Thanks, I should have thought of this when reviewing the patch :)
> > >
> > >>
> > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >> ---
> > >>   README.md |    4 +++-
> > >>   1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/README.md b/README.md
> > >> index e845df8..4352796 100644
> > >> --- a/README.md
> > >> +++ b/README.md
> > >> @@ -53,6 +53,7 @@ similar dependencies):
> > >>   * attr _(tools used by the overlayfs tests)_
> > >>   * libbpf-devel _(tools used by the bpf tests)_
> > >>   * keyutils-libs-devel _(tools used by the keys tests)_
> > >> +* kernel-devel _(used by the kernel module tests)_
> > >>
> > >>   On a modern Fedora system you can install these dependencies with the
> > >>   following command:
> > >> @@ -69,7 +70,8 @@ following command:
> > >>                  lksctp-tools-devel \
> > >>                  attr \
> > >>                  libbpf-devel \
> > >> -               keyutils-libs-devel
> > >> +               keyutils-libs-devel \
> > >> +               kernel-devel
> > >
> > > I'm wondering whether we should rather put kernel-devel-$(uname -r)
> > > here, to make sure that the right package is installed that
> > > corresponds to the running kernel version (which may not be the latest
> > > version that dnf will fetch). Or if the use of shell expansion feels
> > > too clever, then we should at last document that the command may not
> > > always install the version that is needed.
> >
> > I'm often testing kernels I build myself and not via rpm.
>
> Right, then the command would just fail... :/ But it might be slightly
> faster to realize that you can just delete the kernel-devel line from
> the command when you're running a local kernel build, than figuring
> out why the test failed to build after a successful run of the command
> (in the non-latest stock kernel scenario). But I'm fine with just
> documenting it if we want to keep it simple.

I don't feel that strongly about it either way, but one could argue
that if start versioning the kernel-devel package, why not all the
other packages?  What if you have a locally modified BPF userspace?
Infiniband?  I think you get the idea.

My opinion is that if you are going off into the weeds by replacing
the kernel or portions of your userspace, you should know well enough
how to ensure that they are properly installed ;)

-- 
paul moore
www.paul-moore.com
