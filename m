Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D28C433EF
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E316661279
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 15:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhKHPoh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhKHPoh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 10:44:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BAC061570
        for <selinux@vger.kernel.org>; Mon,  8 Nov 2021 07:41:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so64569819edd.10
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPAnnEsgfuUyM0SY/F1RDxIqwxig2YNodqFak44w9Xg=;
        b=r+6Ylj+PB6MWgAKEzHw9cbmuoCX0pLz+Ddmk3iJGNOlRmwoA+Yu0cBYnAvVdo5Er7F
         zfYo6Mu95UobIMOQ7IN6NQmEKRbY0y8LXx70qXQD/aEJOjItU2k+CxFtc+//0IQc0Xdi
         bor+fwlANrq1ENPA8bdpOmwBl7dC3fZLgpBhNo8u4uAZbg8lwKVEpS+OVgg2yLJYUdG1
         8/j+BPagNjg1AntLndv3NjyEQCsZ/zuqNr+iZYjqWqYLPmz2SmjVbQQTFO8VP9Sgtllw
         v0OnhZpWoo3lXENhu0ABv7pZILa8KSABcuUDpNSgcXnM1J1NHbx3AT3ToRGms1vlxzR4
         /P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPAnnEsgfuUyM0SY/F1RDxIqwxig2YNodqFak44w9Xg=;
        b=SyRpRyH6FYn0daVzb96ZlX2HEw/Du+8fp2kZIUNQzFmvPHC/JWG29/ER9DbESA8tfF
         SO5aRE9klO30Z49xmKs7WMr6ZePyKuTv30eUJeTDmWn5TkKJEC9bsW8gsro8IXqq3x0A
         HVwQZNI9AIlPUzonNa9eNcY1haAvampKvoeQ8OPZUT7e09cDPwW/cJabcrkfqEa1jRQu
         m18nlmLKjhQDXBkSQbHHb0IEll/NGrO1MrSGz3R8161SaHoxk/WJfm+BRsjASsjg408/
         DZcNgOJRRDhcmpPoTFb3aoZ5udt+eJHSW1yVOI5jp8cHVcrR/KsIoijBgDljb2Pgw+gW
         F5FA==
X-Gm-Message-State: AOAM530PZPlGh6mqNBgHTJkYtouj71qqjcxChkDySG7WIygygXnb10Cy
        zcb+qZgvAjNM7Bri7bntM3miuJhRCDhcZcehS2EJ
X-Google-Smtp-Source: ABdhPJwpIBiBI8JNFMXbLKTp94lndYfNb+qaJIctmuSuM4jDVlbjq8Oson1oeDuYPIPp4UQeCe0n4l0NVjQRK/5BoWM=
X-Received: by 2002:a05:6402:4255:: with SMTP id g21mr103566edb.256.1636386111052;
 Mon, 08 Nov 2021 07:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20211107142047.32727-1-richard_c_haines@btinternet.com>
In-Reply-To: <20211107142047.32727-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Nov 2021 10:41:39 -0500
Message-ID: <CAHC9VhR2mSHok8caTw37C3sXOqoMT-JOOMAWKjO90jvB-KR9RA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Add tests for sctp_socket
 transition rules
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 7, 2021 at 9:21 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This patch adds five tests for sctp_socket type_transition rules and
> setsockcreatecon(3). More tests can be added however these test the basics.
>
> Hopefully these will help testing the debated peeloff scenarios.
>
> To be able to run these tests you must:
> 1) Build a new kernel with patches from [1] and [2]. These have been
> build/tested using kernel 5.15.
> 2) Add patch [3] to the SELinux testsuite, and then this patch.
>
> Note: When adding [3] to the testsuite, there will be a one line reject:
>    patching file tests/sctp/test
>    Hunk #1 FAILED at 33.
> if using current git build. Just change line 36 to '$test_count = 85;' before
> adding this patch.
>
> [1] https://lore.kernel.org/selinux/163593840902.17756.9280314114933444317.git-patchwork-notify@kernel.org/T/#t
> [2] https://lore.kernel.org/selinux/20211104195949.135374-1-omosnace@redhat.com/
> [3] https://lore.kernel.org/selinux/20211021144543.740762-1-omosnace@redhat.com/
>
> Richard Haines (1):
>   testsuite sctp: Add tests for sctp_socket transition rules
>
>  policy/test_sctp.te              | 57 ++++++++++++++++++++++++++++++++
>  tests/sctp/sctp_client.c         | 19 +++++++++--
>  tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
>  tests/sctp/sctp_common.h         |  2 ++
>  tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
>  tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
>  tests/sctp/sctp_server.c         | 18 ++++++++--
>  tests/sctp/test                  | 57 +++++++++++++++++++++++++++++++-
>  8 files changed, 231 insertions(+), 12 deletions(-)

Thanks for helping with this Richard.

-- 
paul moore
www.paul-moore.com
