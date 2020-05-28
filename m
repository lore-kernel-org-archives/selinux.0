Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52969C433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CCC207BC
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="x+Grdw/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406987AbgE1UWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406966AbgE1UV7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 16:21:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026EC08C5C6
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 13:21:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x29so130380qtv.4
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=GV+Qsg1Fyd6NyrOGxMNKBqTkS0T9D0Tnem2tebwVejc=;
        b=x+Grdw/6vVe5dyb5rIirdT/ZcnVbazYu9CeyipSKcVkQOfVTVQ/E70pk9bdB4A7lpR
         VMiGQIkbmoRotFvF5RTptQFWppI5atWwX0pIapV3Snt0KKRAeFAElVLMZ13PEPkNbtSW
         +MY6MCvfyJ+mqSzS3ht4kmUjBq0ObfHNEaVo8TMdMr5atMgB54BJXAwDpNT/zlKoMzV4
         XwDYoKSuuKJJZJBdGEO3AGVO9cqME3kPUL8NZnxnDZyKCFthxn+3jpu8/1QLXY8d6Gqc
         cnQocI32nsqG7DpHJJywztzTxKbN1db/G/b2zR0zNxJa/cPQgCFImrZLJtCNHbh5Em56
         kZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GV+Qsg1Fyd6NyrOGxMNKBqTkS0T9D0Tnem2tebwVejc=;
        b=ie5DDWpz7uo1fx55Tch9sNyuenPgmsZt9/6mhUwf24dBoU8/q1jydowWdpOADNfCrh
         pzQy/w/5/8CKY3OyRaIzSUTiydB5zLjhpLt/h3IuUZvi6WkjCjbkBgPE8295z6AZR6eh
         EEY4ACdR/OMY/XnDvtXStrKe8dNtgCGyrV+L7J1tPcQcDvPvBddm09d6CT541EROwY5g
         10qMKe5O1RT18hrkHo7C/DffV+oMAWEhBnqFyrnSWGMIGb4V11Zq7VRnWXqX2TL5sLdq
         m6cNPk63kkbRv8Xyr+ntxIIgItFcLOV+8npYGudIrXbSrcuzNS7xiLm7fesKQpNwDHpt
         g04w==
X-Gm-Message-State: AOAM531Gc0OOLNEvTDbOCaF64TNY+2+Kwnihbo4XU4nf35lFL630akZE
        buRV+vnKqDa/uQziuYND+0ocL/woy7/l96OS/J3CtFhss8c=
X-Google-Smtp-Source: ABdhPJzdkij5gzluO42c+ytdSkvqMLkIv4C3P8uzDQ70ftmbVy15KB8OA9DTVczfaVy4hwJ9KNyYiqc/5BgPBipZTrM=
X-Received: by 2002:ac8:7ca:: with SMTP id m10mr2808781qth.86.1590697317686;
 Thu, 28 May 2020 13:21:57 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Thu, 28 May 2020 16:22:43 -0400
Message-ID: <CAGeouKFLVVb2JnxNrEaRKBUVhr9QwOu006awo5Zwqt2Lydpsng@mail.gmail.com>
Subject: Interests in usability enhancements to .../scripts.py?
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, before generating and submitting a patch, I wanted to gauge
interest in usability improvements to

    .../python/sepolicy/sepolicy/templates/script.py

I've added these changes to the "myPolicy.sh" generated for the policy
I'm working on and have found them useful for knowing why things fail
and stopping further processing when things fail. For example, the
default template has the line

    make -f /usr/share/selinux/devel/Makefile TEMPLATEFILE.pp || exit

I've changed this to (line split in email for clarity)

    make -f /usr/share/selinux/devel/Makefile TEMPLATEFILE.pp || \
    { echo "Make failed, exiting."; exit 1; }

and have added similar errors checks after other commands, e.g., after semodule:

    /usr/sbin/semodule -i CDTml.pp || { echo "semodule failed,
exiting."; exit 1; }

and so on: I don't see any point in building the RPM, e.g., if
creating the man pages fails, and the error messages give me a much
clearer indication of what has gone wrong (less verbiage to wade
through).

I've also added command line options to specifically make the PP, RPM,
manpages, etc., so that if I determine that the problem was something
other than a policy error, I can skip directly to just building the
next bits.

One reason for not just generating and submitting a patch is that I
will have to pull out other personal usability changes I've made that
I do not believe will be of general interest, so rather than doing
that work I wanted to gauge interest first.

Thoughts?

Thanks,

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP
