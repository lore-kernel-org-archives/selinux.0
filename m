Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A4CC282CB
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A8A218DA
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JrymG7lJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBHVdc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:33:32 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36724 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBHVd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 16:33:29 -0500
Received: by mail-vk1-f194.google.com with SMTP id m13so1169653vkk.3
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9oSgnPm07vwmWODWGHcHoCNDCiBPV7B6kOG9r5qu5s=;
        b=JrymG7lJoXWsdlGvV/4XrNQKV5jFNCCv7L/CdKsF5P4YfcP2Qdm6BaAisbUTma5Sr5
         5ZEj6Lg+JfPditlcaBaxH5uT/4F4vpWUSDCUoD6rEub+eC2hLSdRykft9yOhldj1bq5D
         O2qgglxnNx7XN59JI0RXLfuJ2BB5TsBgpdRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9oSgnPm07vwmWODWGHcHoCNDCiBPV7B6kOG9r5qu5s=;
        b=AJN0EUm1W7AjwnsCcjUQ6Ao1WFa8SKPHuAW+dfpJeZKDzRv5WQjmyERo38XnpNS0be
         f3/Yv6wtmrqTtlgVND2psqNTD8Iu2355xtACCFbm6ukt6I2pEVg+cs52lhwKMU7fVJde
         FJB9AmgbtBy5B0h6DgQU4JJmwWEAX11j2eSQdBQijI+AvoTMVfH4TC3rlVppUBqjF9Rf
         zPRbVVbPhqae8XbdOD48Bg7tXLczeePikbIDiUYBlIsjB6pUtKsq+0zwvCVg4jJi8LcH
         XBrMyrrPLr+3AVQs+hT6POSwS3eSlwH3AUFvobzbFW603qQqnnw2doY2CehzNccb3t0u
         eavQ==
X-Gm-Message-State: AHQUAuaeXlu56MGhEJ2umzQ0WzML12E7FsZ3vUW0X4AFeeOgViZJjkj9
        jlGYMaxjMBBgQGDuuexnJUHFkGJCiNU=
X-Google-Smtp-Source: AHgI3IaPi3/dLJ5TkQeh9g+VKkmRSOTzcfRn9dSdVYEDxqoNJ4tBc7pqpTQrZ4YzhBzQs0/uuh13pQ==
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr9975203vkn.0.1549661607241;
        Fri, 08 Feb 2019 13:33:27 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id g65sm666792vke.31.2019.02.08.13.33.25
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 13:33:25 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id x1so2972937vsc.10
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 13:33:25 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr9843074vsd.222.1549661604836;
 Fri, 08 Feb 2019 13:33:24 -0800 (PST)
MIME-Version: 1.0
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
 <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com> <201902070230.x172UUG6002087@www262.sakura.ne.jp>
 <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
In-Reply-To: <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Feb 2019 13:33:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJm+qxgnmRjJtTuaqj6N7WP+TVF4tUm30WUmMDT3irvFg@mail.gmail.com>
Message-ID: <CAGXu5jJm+qxgnmRjJtTuaqj6N7WP+TVF4tUm30WUmMDT3irvFg@mail.gmail.com>
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@vger.kernel.org>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 8:24 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> I added Kees to the CC list. Kees, what to you think about
> ignoring security= if lsm= is specified? I'm ambivalent.

This was one of many earlier suggestions, and the consensus seemed to
be "don't mix security= and lsm=". Why would anyone use both?

-- 
Kees Cook
