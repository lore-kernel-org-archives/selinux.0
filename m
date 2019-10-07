Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888ECE58E
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2703421871
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJGQ1p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:27:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40218 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfJGQ1p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 12:27:45 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F27C55646F4
        for <selinux@vger.kernel.org>; Mon,  7 Oct 2019 18:27:41 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id e11so11514634otl.5
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 09:27:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWzIHh59itPXR3rj4GJcwWoEtb2uYN7BrW9ULlag6yDRCbzIon+
        ib4bD4HqsKfffHAqPB5xOn3UGF/F4nTTHiDAmgA=
X-Google-Smtp-Source: APXvYqwXG72FSfjq8KNQStkathsJMG7uCE8dNKLCz3DyXR5RIqmP7NgoT9nbouLJ5JBt0YjinmVuJrgmVZtgjqZvg+Q=
X-Received: by 2002:a9d:e92:: with SMTP id 18mr22232162otj.321.1570465660971;
 Mon, 07 Oct 2019 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191007132020.GG4928@imap.altlinux.org>
In-Reply-To: <20191007132020.GG4928@imap.altlinux.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 7 Oct 2019 18:27:29 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==pXUGZ_tEz0PuCR8-P2jm9hjO7vD4R++y2BHeBR_++LA@mail.gmail.com>
Message-ID: <CAJfZ7==pXUGZ_tEz0PuCR8-P2jm9hjO7vD4R++y2BHeBR_++LA@mail.gmail.com>
Subject: Re: [PATCH] non-gcc-specific exception.sh
To:     Michael Shigorin <mike@altlinux.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct  7 18:27:42 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 7, 2019 at 3:20 PM Michael Shigorin <mike@altlinux.org> wrote:
>
>         Hello,
> please find attached the patch to (hopefully) improve
> self-surgery script that uses gcc-specific -aux-info now.
> Should help clang, icc and the like (in my case there's
> no proper gcc port for the target platform just yet).
>
> --
>  ---- WBR, Michael Shigorin / http://altlinux.org
>   ------ http://opennet.ru / http://anna-news.info

Hello,
How did you test this patch? On my system (Arch Linux x86-64), I get
the following differences in the generated list of functions, for
libselinux:

+select
+pselect
-selinuxfs_exists

This is because /usr/include/sys/select.h contains "extern int select
(int __nfds, fd_set *__restrict __readfds," and "extern int pselect
(int __nfds, fd_set *__restrict __readfds,", and because
libselinux/include/selinux/selinux.h contains "int
selinuxfs_exists(void);" without "extern". Your patch therefore
changes things in a way that seems unintended.

I nevertheless agree that making the build system use clang when
CC=clang is a good idea. As the regular expression you sent is quite
fragile, a possible way of preventing issues such as the differences I
found is to try using both methods (-aux-info and -E) in a "make test"
target and fail with a fatal error when they do not produce the same
output (this fatal error would be caught by a continuous-integration
system, which would make the developers aware of something wrong).

Moreover, please send your patch inline, if possible (for example with
"git send-email"), and add a "Signed-off-by:" line as documented in
https://github.com/SELinuxProject/selinux/blob/master/CONTRIBUTING.md#contributing-code.

Thanks,
Nicolas

