Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF2ECE58C
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6C72173B
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJGTWC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:22:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58264 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfJGTVz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 15:21:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4D76E72CC6C;
        Mon,  7 Oct 2019 22:21:53 +0300 (MSK)
Received: by imap.altlinux.org (Postfix, from userid 705)
        id 3882C4A4AE9; Mon,  7 Oct 2019 22:21:53 +0300 (MSK)
Date:   Mon, 7 Oct 2019 22:21:53 +0300
From:   Michael Shigorin <mike@altlinux.org>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] non-gcc-specific exception.sh
Message-ID: <20191007192153.GB19655@imap.altlinux.org>
References: <20191007132020.GG4928@imap.altlinux.org>
 <CAJfZ7==pXUGZ_tEz0PuCR8-P2jm9hjO7vD4R++y2BHeBR_++LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfZ7==pXUGZ_tEz0PuCR8-P2jm9hjO7vD4R++y2BHeBR_++LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 07, 2019 at 06:27:29PM +0200, Nicolas Iooss wrote:
> > please find attached the patch to (hopefully) improve
> > self-surgery script that uses gcc-specific -aux-info now.
> > Should help clang, icc and the like (in my case there's
> > no proper gcc port for the target platform just yet).
> How did you test this patch? On my system (Arch Linux x86-64),
> I get the following differences in the generated list of
> functions, for libselinux:
> 
> +select
> +pselect
> -selinuxfs_exists

selinuxfs_exists is declared as just int, not external int, and
gets filtered out with awk one-liner within the original script.

I've spotted select/pselect and have paid some attention to
zeroing the diff *but* overlooked the <stdin> filter in the
script from libselinux-2.9 tagged tree I started looking at.
Evgeny suggested doing something about the changed source
marker format either, shame on me for distracting.

> This is because /usr/include/sys/select.h contains "extern int select
> (int __nfds, fd_set *__restrict __readfds," and "extern int pselect
> (int __nfds, fd_set *__restrict __readfds,", and because
> libselinux/include/selinux/selinux.h contains "int
> selinuxfs_exists(void);" without "extern". Your patch therefore
> changes things in a way that seems unintended.

Will this one do better?  Looks a bit messy though[1]:

gcc -E -I../include -xc ../include/selinux/selinux.h |
  awk -F '[ (]' '/^#/{p=0} \
    /^# .*selinux\/selinux\.h/{p=1} \
    /^extern int/{if(p==1){print $3}}'

> As the regular expression you sent is quite fragile a possible
> way of preventing issues such as the differences I found is
> to try using both methods (-aux-info and -E) in a "make test"
> target and fail with a fatal error when they do not produce
> the same output (this fatal error would be caught by a
> continuous-integration system, which would make the developers
> aware of something wrong).

Good test for those who have it handy, my primary intent was
to be able to at least build without (not-yet-ported) gcc.

> Moreover, please send your patch inline, if possible (for example with
> "git send-email"), and add a "Signed-off-by:" line as documented in
> https://github.com/SELinuxProject/selinux/blob/master/CONTRIBUTING.md#contributing-code.

Thank you for the review and suggestions, please have a look
at the proposed handler replacement; if it's ok I'll arrange
it as a commit and hopefully figure out the test tomorrow,
getting sleepy by now...

---

[1] start/end patterns don't cut it for me given repetitions:

sed -n '/^# .*selinux\/selinux\.h/,/^#/{s/^extern int \(\w*\) *(.*$/\1/p}'

skips e.g. security_deny_unknown given gcc's output
but works fine with somewhat differing lcc's one.

-- 
š---- WBR, Michael Shigorin / http://altlinux.org
šš------ http://opennet.ru / http://anna-news.info
