Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9FCC35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86420842
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QrPbciMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLCwp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:52:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40686 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgBLCwo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:52:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id p3so629840edx.7
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyCC9PArtZ1yOGl2SbUhkxuR9SA5u5eZCIQOKtNea2A=;
        b=QrPbciMA+NFmHvo4LOjTE09PaQPnEvM1ECfb4jAOB6/Cj0fxgewe3Eppj152uiFp29
         IX2y8Bu06dlVjVZHhD5iNcHs18LyalStS8RFwE3FwP/NGTHqASyvMpPNoojA9lY7O2Jj
         ivMso/0kVTif37e2xL3lohqXFASy3hHNmL2F4YXpE/oT/GfVLcp+2/8f+uuKrzdWWSVl
         OIgEW6SI5fsFXLAHWl0N9bIf5NDefR/iTtl1Vz139IpNktWnFbitM4PoBdMwY8ZmGfyR
         P90VNHGTWOACJAQfgHhtssCK8mLwdPYrru+3s/mBo2cvSdPuMnh+ho2UdirmlwAyKVtv
         6Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyCC9PArtZ1yOGl2SbUhkxuR9SA5u5eZCIQOKtNea2A=;
        b=nP++K2zXjZ+TUWM8wEzwXV33lMPaab/1ChH90gFd427QGGynuB3cIFRcP9fgE84Sfy
         wQVVOSll11ZXqXZHNJztq6aoDceYcjiMhRQXQAVODI4FNvTXUpWjk4LYx8Ndj2HMxWPW
         WV5GJLfOILwn6jH9cCewb0YCczpDniJHBl12Huz6fmRAcllgIo7tEQ/ZAtGtQLKunW6U
         QCm+BCqV81Ewwbz/vmIvTbtiWUMklq/bOL2W0TFw+gpBK+vN0xyuXN+UEDXmeD51Q2nf
         pBm1oon9sNvDlHSeDCfZ/v0t9DKN4kRUvhzWAk0S42BSBsKMskgsE9PohocL4otUjknT
         UcLw==
X-Gm-Message-State: APjAAAUSBGWxFYUIyLI8T7EL4wqcLjoM+h8ZegbJixbKgYi2rPJqMo8x
        RAeNN68ExEEJLVD6cZbQ/VLPL0/4RhJ0cmvbc9j9neCJTQ==
X-Google-Smtp-Source: APXvYqwkoFlSZCf9KrmKvmngDopniC4H7l5gRGQKnsD49HUzM3lMAETG3X7Ne9OIjg1cVSS7FAykvI3djYovaervyRI=
X-Received: by 2002:a50:e108:: with SMTP id h8mr8136274edl.196.1581475962931;
 Tue, 11 Feb 2020 18:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20200203112723.405341-1-omosnace@redhat.com> <20200203112723.405341-6-omosnace@redhat.com>
In-Reply-To: <20200203112723.405341-6-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:52:32 -0500
Message-ID: <CAHC9VhS0g3YkbJHV9NeJ9Q1Jm5PEO-q4-x2zm2XoN+GjwLtyWg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] selinux: generalize evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 3, 2020 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Both callers iterate the cond_list and call it for each node - turn it
> into evaluate_cond_nodes(), which does the iteration for them.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 10 +++++++++-
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/services.c    |  6 ++----
>  3 files changed, 12 insertions(+), 6 deletions(-)

Last one, merged.  Thanks!

-- 
paul moore
www.paul-moore.com
