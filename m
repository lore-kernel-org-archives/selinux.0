Return-Path: <SRS0=ZbKt=YF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5AAC4360C
	for <selinux@archiver.kernel.org>; Sat, 12 Oct 2019 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692D4206A1
	for <selinux@archiver.kernel.org>; Sat, 12 Oct 2019 16:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfJLQ54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:57:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35101 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfJLQz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Oct 2019 12:55:56 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DE935564685
        for <selinux@vger.kernel.org>; Sat, 12 Oct 2019 18:55:51 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id 60so10568372otu.0
        for <selinux@vger.kernel.org>; Sat, 12 Oct 2019 09:55:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUFVD3KMRGGL1R/ev00O0OL70CmZaeUry1l94LameJex0OqCFx8
        e/e6yOfz8EYDGtvzMD1qLRz3bRKN36mE9w5u32M=
X-Google-Smtp-Source: APXvYqx2iWV18fBeS6KU+xAFwCPPXQjTTz0eyYtLRQQG57ozZ+zddP+9x2UabrWtdvCQJyRFMG+nk6sIv4BHjbzmenU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr9119347otk.321.1570899350794;
 Sat, 12 Oct 2019 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191007132020.GG4928@imap.altlinux.org> <CAJfZ7==pXUGZ_tEz0PuCR8-P2jm9hjO7vD4R++y2BHeBR_++LA@mail.gmail.com>
 <20191007192153.GB19655@imap.altlinux.org>
In-Reply-To: <20191007192153.GB19655@imap.altlinux.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 12 Oct 2019 18:55:39 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kYpc3Y1EHHycGeQSqCoptyNAyEcx4=ZDP=O8NEKJQnyg@mail.gmail.com>
Message-ID: <CAJfZ7=kYpc3Y1EHHycGeQSqCoptyNAyEcx4=ZDP=O8NEKJQnyg@mail.gmail.com>
Subject: Re: [PATCH] non-gcc-specific exception.sh
To:     Michael Shigorin <mike@altlinux.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 12 18:55:52 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 7, 2019 at 9:21 PM Michael Shigorin <mike@altlinux.org> wrote:
>
> On Mon, Oct 07, 2019 at 06:27:29PM +0200, Nicolas Iooss wrote:
> > > please find attached the patch to (hopefully) improve
> > > self-surgery script that uses gcc-specific -aux-info now.
> > > Should help clang, icc and the like (in my case there's
> > > no proper gcc port for the target platform just yet).
> > How did you test this patch? On my system (Arch Linux x86-64),
> > I get the following differences in the generated list of
> > functions, for libselinux:
> >
> > +select
> > +pselect
> > -selinuxfs_exists
>
> selinuxfs_exists is declared as just int, not external int, and
> gets filtered out with awk one-liner within the original script.
>
> I've spotted select/pselect and have paid some attention to
> zeroing the diff *but* overlooked the <stdin> filter in the
> script from libselinux-2.9 tagged tree I started looking at.
> Evgeny suggested doing something about the changed source
> marker format either, shame on me for distracting.
>
> > This is because /usr/include/sys/select.h contains "extern int select
> > (int __nfds, fd_set *__restrict __readfds," and "extern int pselect
> > (int __nfds, fd_set *__restrict __readfds,", and because
> > libselinux/include/selinux/selinux.h contains "int
> > selinuxfs_exists(void);" without "extern". Your patch therefore
> > changes things in a way that seems unintended.
>
> Will this one do better?  Looks a bit messy though[1]:
>
> gcc -E -I../include -xc ../include/selinux/selinux.h |
>   awk -F '[ (]' '/^#/{p=0} \
>     /^# .*selinux\/selinux\.h/{p=1} \
>     /^extern int/{if(p==1){print $3}}'
>
> > As the regular expression you sent is quite fragile a possible
> > way of preventing issues such as the differences I found is
> > to try using both methods (-aux-info and -E) in a "make test"
> > target and fail with a fatal error when they do not produce
> > the same output (this fatal error would be caught by a
> > continuous-integration system, which would make the developers
> > aware of something wrong).
>
> Good test for those who have it handy, my primary intent was
> to be able to at least build without (not-yet-ported) gcc.
>
> > Moreover, please send your patch inline, if possible (for example with
> > "git send-email"), and add a "Signed-off-by:" line as documented in
> > https://github.com/SELinuxProject/selinux/blob/master/CONTRIBUTING.md#contributing-code.
>
> Thank you for the review and suggestions, please have a look
> at the proposed handler replacement; if it's ok I'll arrange
> it as a commit and hopefully figure out the test tomorrow,
> getting sleepy by now...

Hello,
I wanted to spend some time testing different approaches before
replying. Your awk command works fine, but I am wondering whether its
complexity is needed at all. For example, why not directly grab the
"extern int" lines in selinux.h (using sed -n s/.../.../p). This would
work well with libselinux and avoid using awk for this simple task,
but not for libsemanage... or it could, with:

    cat ../include/semanage/*.h | \
    sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p'

Actually, the main reason why it is currently not possible to migrate
from "gcc -aux-info and awk" to "cat | sed" is caused by the fact that
the file generated by "gcc -aux-info" adds "extern" before all
function prototypes. Adding "extern" directly to the prototypes of all
exported functions in header files seems to be required in order to
use something else than "gcc -aux-info" to generate the glue code that
handles exception in Python bindings.

Therefore I suggest the following approach:
1. add "extern" to all exported functions in libselinux and
libsemanage public headers (I can send a patch for this tomorrow if
you don't want to do this)
2. change exception.sh to use something else than "gcc -aux-info" to
generate the glue code
3. add something so that "make test" compares the result of "$CC
-aux-info" (if $CC is gcc-compatible) with the new way to find
functions, in order to report differences in the generated glue code.
This could for example consist in adding some code in exception.sh
such that "./exception.sh test" performs this check.

Would this suit you?

By the way, I found out that libsemanage generates glue code for
select() and pselect() too, as it does not filter the output of "gcc
-aux-info". This is a bug that needs to be fixed.

Thanks,
Nicolas

