Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FCECAAA1
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 20:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH3UK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiH3UKy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 16:10:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6748EBD
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:10:51 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11f34610d4aso8642783fac.9
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qJlLpOkELPi/QHoI5MOqP2NXG1iWQCH2fEv8e9Ssxoo=;
        b=xxEodV7a1e7/J/CC+G/b+UaD2Ii0/Rn30BjWnLmnHXaqxBbJn27dTX5+BSX6y2T0VC
         600IGhnHSDehtxBC5L8x9dLnBArvX53kytinB+b/jGnGVCVUS6T2E6Tc5ilPu6cFI71+
         502VF3G+Bep6f5sAH+kr0v2hYHzzsysrsYYKAfmYJEK+0VAyw/bUPTe6WuaNI6F8Nue4
         BVO8z6ThCYrr8+HaYvlCZ2FMVbZTODrKqx22p0S3vziQ0cbciSBGRpVvwLRB/mT45d8d
         la+wIdrLeEcfxsMJNYYJlHi+yiXYFQqhpgwl7P4jtf7+CdlAuwpy+NQqrluhn0DiqfLi
         EFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qJlLpOkELPi/QHoI5MOqP2NXG1iWQCH2fEv8e9Ssxoo=;
        b=0NS55Zb8K+cWFYuogTn3ZWr0YGTWJ6bAcxb4Uxg892qk6oQmRcGNMHBfr9qcGB8+sE
         zqUVGnb2CLdwKdMCNApXIHpFvQ4D0DFk7KrsdCtoSPL+cmRQAcRnRs0+7iZYX0SHd/q6
         K6b2MLmuiQAJ06VaQwi1FhrBHD6zKXbCzdTP4nz8fBEvCL64JNp5Yu0NL74aIFoPtIKI
         98pNY2G7wSGBnGtj+GC4fZkkitfR0NO/cUdE0Ovtv6XbiBR2AUc36lp5Qe+D/sD5rM29
         h+jMsV4pnYj6z5qimqb9eu9ONJlUWPiTviS2mCkhW0Nm0fn0GbUmpWE8g1HOBl9g+V59
         HSwA==
X-Gm-Message-State: ACgBeo2mzaE2fGGG9JdxvEncaQ4dS0fUvYhzkP3TzKxAUWsQsv8e1jD+
        KKI0l6mIwKTe2cSzXJE54zGUDsi0c/npygKhOVbI
X-Google-Smtp-Source: AA6agR7feW5/dLGJw4vAhaYoiUlA13S/ZyDm4jHFn05WI9FtjAPitCZNc7BF6TEeUYC8sgScaZjEpWOJ3swzuHG2cYU=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11313980oao.136.1661890250283; Tue, 30
 Aug 2022 13:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com> <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
 <CAHC9VhRtLEg-xR5q33bVNOBi=54uJuix2QCZuCiKX2Qm6CaLzw@mail.gmail.com> <20220826084354.a2jrrvni6mf7zzyw@wittgenstein>
In-Reply-To: <20220826084354.a2jrrvni6mf7zzyw@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:10:39 -0400
Message-ID: <CAHC9VhR=+vVzx1-sKO=UxZyNG6J4-8q+WfxTmHPqxBFbs2-mtw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 26, 2022 at 4:44 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Aug 19, 2022 at 02:50:57PM -0400, Paul Moore wrote:
> > On Tue, Aug 16, 2022 at 6:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Jul 8, 2022 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Since userfaultfd doesn't implement a write operation, it is more
> > > > appropriate to open it read-only.
> > > >
> > > > When userfaultfds are opened read-write like it is now, and such fd is
> > > > passed from one process to another, SELinux will check both read and
> > > > write permissions for the target process, even though it can't actually
> > > > do any write operation on the fd later.
> > > >
> > > > Inspired by the following bug report, which has hit the SELinux scenario
> > > > described above:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> > > >
> > > > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > > > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > Resending as the last submission was ignored for over a year...
> > > >
> > > > https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/
> > > >
> > > > I marked this as RFC, because I'm not sure if this has any unwanted side
> > > > effects. I only ran this patch through selinux-testsuite, which has a
> > > > simple userfaultfd subtest, and a reproducer from the Bugzilla report.
> > > >
> > > > Please tell me whether this makes sense and/or if it passes any
> > > > userfaultfd tests you guys might have.
> > > >
> > > >  fs/userfaultfd.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > VFS folks, any objection to this patch?  It seems reasonable to me and
> > > I'd really prefer this to go in via the vfs tree, but I'm not above
> > > merging this via the lsm/next tree to get someone in vfs land to pay
> > > attention to this ...
> >
> > Okay, final warning, if I don't see any objections to this when I make
> > my patch sweep next week I'm going to go ahead and merge this via the
> > LSM tree.
>
> Makes sense,
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Merged into lsm/next, thanks all.

-- 
paul-moore.com
