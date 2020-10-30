Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C6C00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF620727
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GM8tuxKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJ3QiR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgJ3QiQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 12:38:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B36C0613CF
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 09:38:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p5so9491996ejj.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTzcxD4FqN8pyjpLrmQaS9my52uWYEUZsGs2FqI4JTM=;
        b=GM8tuxKOdOguSIXXlNG9hW18QJTOmfhobYbliLxBaT5BlmaVwQnVWOYCfUwgAVPV5C
         v4KfwqrDN1mVIUbQu7e8Y8WsdQYejtuf9oTfj1Xy0bAWEyPWPHVHjAyr+oN2ipYyQtFM
         z4prnxHIFqsILu0t/A8wcILyFLjNTxbB/+PQ4e8aUnlKU1CGnMndFwj7v4dJQoyV0Pp1
         tZlNVbxgjHa1NK7PXYTq/u1CxmU30gfeG+7UXtFOqe7kg2r+ayW0eSovLbaycCBATnpa
         NheWuIC9uY6akqcZQvzaxPq1FufCK35snW7/5xDY6so/VEk+UMvppfJKNWJusCFpEmCU
         aIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTzcxD4FqN8pyjpLrmQaS9my52uWYEUZsGs2FqI4JTM=;
        b=IBmsHWGeWOt/fiDH0O+8vIExPjFv4rZSr4/7AWMBA4+ogPxnuQqWH7ZwGYsLa7y8Lg
         nEldnCgAcLoC+T3woLTyo3PXYITj3FitFNoCnhbTtL6HJUROaMl5Ia0vbhEXWxU8ajwI
         9skF7SZOT3JSjxMVa9QYYnY33N/KReG8/gn8MNJC0TTTe8El2AYtaupGVvHm/U5wS0xW
         zjI/3LWPf+ugLYN8fFu/0bDO8zIKQfpOCvOoekPJTZ2vv0DV3EZgtI6ZEXwOmxZOC8iX
         BS+GcEZOOrDo9bm5H1Th88ugrfwNnL7b6J8KNu+shotWmUy2xpNDp30x3loia9maoDnR
         ffRg==
X-Gm-Message-State: AOAM531LcVyAqCFUYclesLDnVxOmZgIsypF5zJNM6DRRLrR57V3pz14x
        WhnYUsXqfBG9IGTEDSmPE1vcqwyibaNjlovlHNbNyxG8/9mN
X-Google-Smtp-Source: ABdhPJxMQeWEYy8Hr+ZA51g2EBJjtgYjo0RnOscAt4x8TxziKK8n7Sp6y7mHCkwHkPIL+mec545JOJ7bDpTb8hYdGv8=
X-Received: by 2002:a17:907:72cd:: with SMTP id du13mr3170197ejc.398.1604075894543;
 Fri, 30 Oct 2020 09:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
 <B129404A-41AA-4803-91CA-3F110BAE26BF@gmail.com> <CAFftDdqwLidE7bc9Z0jLmJwvvTtfWCbeGHnZ3kUMP=y5gUguEQ@mail.gmail.com>
 <CAP2OjchG4ZS0R6aQRCA3eGsf0bPOyaqKTUuVh-c9stKdSzjBKw@mail.gmail.com>
In-Reply-To: <CAP2OjchG4ZS0R6aQRCA3eGsf0bPOyaqKTUuVh-c9stKdSzjBKw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Oct 2020 12:38:03 -0400
Message-ID: <CAHC9VhSttcgxtrHWKwndChd0k74k-MHemSe16wxNGY=EHtVHGA@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Ian M <merinian@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 27, 2020 at 7:13 AM Ashish Mishra <ashishm@mvista.com> wrote:
> Hi All ,
>
> I am evaluating a use case of  SELINUX + RAMFS scenario & came across
> this thread.
>
> Can team please provide pointer on :
> a) Use of TMPFS over RAMFS for initramfs
>     As that would allow use of "fs_use_xattr"  and hence restorecon
> would not be required with "REFPOLICY"
>     Am I correct in my understanding here or am I missing any aspect ?

I'm not sure how you would use tpmfs as an initramfs as it is not a
persistent filesystem.  Perhaps there is a way to use a tmpfs as an
initramfs but I don't know how that would would work.

> b) Team input / comment on https://lwn.net/Articles/745260/
>      patch to extend initramfs archive format to support xattrs

I'm not sure how useful that would be in practice as you would still
need to load a SELinux policy before you could actually enforce any
security policy with those labels/xattrs.  We have recently added
support to manage filesystem labels when a policy isn't loaded; the
main motivation was to allow different use cases where the root
filesystem was created and labeled dynamically by the initramfs.

* https://www.paul-moore.com/blog/d/2020/01/linux_v55.html
* https://www.paul-moore.com/blog/d/2020/10/linux_v59.html

> c) Any standard way / location to derive "dependent packages " that
> should be present
>     on ROOTFS before trying to build ref-policy from
> "https://github.com/TresysTechnology/refpolicy"

Reference policy is now located at the repo below.  Generally the
SELinux policy is built offline on a build system and the resulting
SELinux policy binary artifact is loaded at runtime; building the
reference policy from source during boot would likely slow the boot
process dramatically.

* https://github.com/SELinuxProject/refpolicy

-- 
paul moore
www.paul-moore.com
