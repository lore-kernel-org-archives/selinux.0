Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662BC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6829B20854
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 01:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftz3vAOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCTBIX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:08:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33426 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTBIW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 21:08:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so717527qtb.0
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+unOuo1mX3fkyRYAJ1Pv0pCHI8FdqCB3Lt5o0/MxSA=;
        b=ftz3vAOItNUPB19t2IsH2RRgdaFDw37nf4RWwHkKjDqEGS5sDr+alr+tGkXFvUAhlM
         o/94GvbUvunEfL3Nv3UR3yTgKc2J+zR3V8w0GR3uL3kQP0cggjawmJxeMp6LG+ILv7vl
         5XW9+Pf/c7Rrd4lefr7PPatI3ORrxu4wpJW3ielDSoWPE6HE1EyoX2lBB2MnLqPBA4kC
         ol+6Fm2oKcUtWjzZHvilnAaykr7DpLn05sfJ8HVcDgMmvBCv6+hf9S0Rj00FywF4e6HW
         GWYhXK2QVdsZCHK18opBA0Qg0vIPVZr3zI++dOUlcsKJxTKHB1KgXw3kC0ehRVM+QKjF
         2Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+unOuo1mX3fkyRYAJ1Pv0pCHI8FdqCB3Lt5o0/MxSA=;
        b=ENg8kDQqat6yOtawugqFcAoGICMPpHVfRBppHXfvFvcNkzKK7qfc1Cn+puT7KaJ2Hg
         KH1p2EMmp+S/D4MkUw4Lv8pafiFW9X7ME5ekGN6HPKRMg1KxZ/wI5a05mtgiRQ6bkR5I
         /iRQrkZi24BPlMZuI/q8GxRa/UHT6jRUyRJuQPXVP+lKuarX1+rqQe8kYFew8FZVj+fW
         qgTQFjCa+5iZ6HHk7cMdS5TvZJA/8r89aWROkC5LyqfxyE7CeOOdiIiYUwO7ASg/4ScN
         4puqF1eF/Hg/qGYSZM1wUUIK/rAAwyBsbuVV+GvClzfwP103fxfzfFTvC12O9xg/IhQv
         bs0A==
X-Gm-Message-State: APjAAAUIf3Yg8mJ1NVtKuKnLMSWEhZEE31/lmFzHxinDfH4WOTEOROR3
        wy5IfMpLxsfTX2iDqo8fBZxVyBPfiM4YjKipt89cvQ==
X-Google-Smtp-Source: APXvYqzYf/oV5fb36yvzTx2+u/7HxEU5KWubEgJAgXMHVGE2kWQP5pzIcGUu29qE7brXUVtaR2ziXp9xoHwdyk4Ooaw=
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr4661004qtj.349.1553044101698;
 Tue, 19 Mar 2019 18:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
 <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
 <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
 <CAHC9VhT_OWOU97C2NeDq8TWQzsu74V7maLWSXPhBFUKwrTvtCA@mail.gmail.com> <CAHRSSEwM+XXxzxabmiPBEt=t80Jes16yjJhHhsOtGy4meYu2mw@mail.gmail.com>
In-Reply-To: <CAHRSSEwM+XXxzxabmiPBEt=t80Jes16yjJhHhsOtGy4meYu2mw@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Mar 2019 18:08:10 -0700
Message-ID: <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul,

Looking at a snippet of the test output:

    Service Provider read_consumed: 8
    Service Provider command: BR_NOOP
    Service Provider command: BR_FAILED_REPLY  <-------------- the txn
failed as expected.
    Manager read_consumed: 8
    Manager command: BR_NOOP
    Manager command: BR_TRANSACTION_COMPLETE
    not ok 3
        <--------- but for some reason didn't exit(103)
    #   Failed test at ./test line 56.

It looks like the test script expects test_binder to fail with
exit(103) after processing the Server Provider commands. It's not
clear why it didn't, since the return of a BR_FAILED_REPLY for that
transaction should have executed this code (line 392 of
test_binder.c):

    if (cmd == BR_FAILED_REPLY ||
        cmd == BR_DEAD_REPLY ||
        cmd == BR_DEAD_BINDER) {
        fprintf(stderr,
                  "Failed response from Service Provider using Managers FD\n");
        exit(103);
    }

Could this be an issue with the test? At least it doesn't look like a
transaction is succeeding when it shouldn't.

-Todd

On Tue, Mar 19, 2019 at 5:15 PM Todd Kjos <tkjos@google.com> wrote:
>
> [...]
>
> > > Is there a public dashboard where I can take a look at those binder failures?
> >
> > Not really.  I send test results to a not-yet-publicized mailing list,
> > but there is more detail in the GitHub issue below (my last comment
> > has the verbose test output):
> >
> > * https://github.com/SELinuxProject/selinux-kernel/issues/46
> >
>
> Ok, so it looks like something was introduced that causes binder to be
> too permissive (test 3 transaction succeeded when failure is
> expected). I don't know of any recent binder changes that could have
> caused that.
>
> It will take me a while to set up this test environment. Is this easy
> for you to run? Any chance of bisecting or at least trying a few
> versions to narrow it down? Here's a list of the recent patchset -- it
> would be useful to know which caused it (or if none of them did):
>
> 9e98c678c2d6a Linux 5.1-rc1
> ...
> 26528be6720bb binder: fix handling of misaligned binder object
> bde4a19fc04f5 binder: use userspace pointer as base of buffer space
> c41358a5f5217 binder: remove user_buffer_offset
> db6b0b810bf94 binder: avoid kernel vm_area for buffer fixups
> 7a67a39320dfb binder: add function to copy binder object from buffer
> 8ced0c6231ead binder: add functions to copy to/from binder buffers
> 1a7c3d9bb7a92 binder: create userspace-to-binder-buffer copy function
> ...
> 1c163f4c7b3f6 (tag: v5.0) Linux 5.0
>
> Thanks,
>
> -Todd
