Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E2C5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20232187F
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfKGMl2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:41:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388378AbfKGMl2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Nov 2019 07:41:28 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D9EF37F41
        for <selinux@vger.kernel.org>; Thu,  7 Nov 2019 12:41:27 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id e6so1936866oth.17
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 04:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz5GnPQhJGGVxDTVlk/C+T9QqPSPNb0tGaLMlciYEyE=;
        b=ZEZJKCqwY+xNoKSi+3PUC08Rh4gVRy6iAJonyD8iTsIuA8+R/F544pidPnmtx15oSF
         Gq2LsEU4gn5MXfbt8zzN3uGLKsYhOlVkmOb4mIhCrPJsXhwvh6xiktYtM9DqmrFNMB1m
         iQmJ9TPGx03l4Eyj1ncd1Fl9T59kSgE6hR7OLm2IenqN2QgYkcJ8M20R5IG75Wt5IfJC
         FLyybpTD5wcit/hOl34aupoQawhJDXcqlLA5NTT88wEvUsVhG3rs9XQTPtGG0r4qCjIb
         8aFqgDqVHjA3Z2ZBpCJDyMi/VmDldHNd503bBuxLgWuOkhWzqZBJnWSMKI6nHhPGcXz/
         vzHA==
X-Gm-Message-State: APjAAAVvaWjUoeQJZU3WSs7AjVzj2HRuyzUoTvdvIts6mTj6M715VOFN
        jtWE7lSE1Qm8wiJSori1npSzmHx+bVjhHKjajc8Yte9FViflXOreaRa11tWY4GyFiq80LvOrl05
        4h6Fh1t7umJMb0FnA8i9YSrMbNRY9sjgUUA==
X-Received: by 2002:aca:48cb:: with SMTP id v194mr3411484oia.156.1573130486932;
        Thu, 07 Nov 2019 04:41:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9Zs4SUXIg44dSeAPLUvrKtpnUnZUkZKmYusVLQqCNUtcIBXlRb8NpqBoJOkmZo2K78/Ca9XlSywYUyMDoMA4=
X-Received: by 2002:aca:48cb:: with SMTP id v194mr3411461oia.156.1573130486526;
 Thu, 07 Nov 2019 04:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20191106082634.5173-1-omosnace@redhat.com> <b8d38817-80b8-fec1-fd5d-81c4e86e1001@tycho.nsa.gov>
 <9de8f6bd-a013-934f-d22f-0b324509cb13@tycho.nsa.gov> <0a6ddbc7-faa5-5f92-cb2d-b8df1c0b4270@tycho.nsa.gov>
In-Reply-To: <0a6ddbc7-faa5-5f92-cb2d-b8df1c0b4270@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Nov 2019 13:41:15 +0100
Message-ID: <CAFqZXNvfovdHTFaPH3QA2dRyibtf8Qhd_3G3HKP2qyex5c+yhg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: cache the SID -> context string translation
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 6, 2019 at 8:48 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/6/19 2:22 PM, Stephen Smalley wrote:
> > On 11/6/19 11:11 AM, Stephen Smalley wrote:
> >> On 11/6/19 3:26 AM, Ondrej Mosnacek wrote:
> >>> Translating a context struct to string can be quite slow, especially if
> >>> the context has a lot of category bits set. This can cause quite
> >>> noticeable performance impact in situations where the translation needs
> >>> to be done repeatedly. A common example is a UNIX datagram socket with
> >>> the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> >>> when receiving log messages via datagram socket. This scenario can be
> >>> reproduced with:
> >>>
> >>>      cat /dev/urandom | base64 | logger &
> >>>      timeout 30s perf record -p $(pidof systemd-journald) -a -g
> >>>      kill %1
> >>>      perf report -g none --pretty raw | grep security_secid_to_secctx
> >>>
> >>> Before the caching introduced by this patch, computing the context
> >>> string (security_secid_to_secctx() function) takes up ~65% of
> >>> systemd-journald's CPU time (assuming a context with 1024 categories
> >>> set and Fedora x86_64 release kernel configs). After this patch
> >>> (assuming near-perfect cache hit ratio) this overhead is reduced to just
> >>> ~2%.
> >>>
> >>> This patch addresses the issue by caching a certain number (compile-time
> >>> configurable) of recently used context strings to speed up repeated
> >>> translations of the same context, while using only a small amount of
> >>> memory.
> >>>
> >>> The cache is integrated into the existing sidtab table by adding a field
> >>> to each entry, which when not NULL contains an RCU-protected pointer to
> >>> a cache entry containing the cached string. The cache entries are kept
> >>> in a linked list sorted according to how recently they were used. On a
> >>> cache miss when the cache is full, the least recently used entry is
> >>> removed to make space for the new entry.
> >>>
> >>> The patch migrates security_sid_to_context_core() to use the cache (also
> >>> a few other functions where it was possible without too much fuss, but
> >>> these mostly use the translation for logging in case of error, which is
> >>> rare).
> >>>
> >>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> >>> Cc: Michal Sekletar <msekleta@redhat.com>
> >>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >>
> >> This looks good to me and didn't trigger any issues during testing.
> >> Might want to run it by the RCU wizards, e.g. Paul McKenney, to
> >> confirm that it is correct and optimal usage of RCU.  I didn't see
> >> anywhere near the same degree of performance improvement in running
> >> your reproducer above but I also have all the kernel debugging options
> >> enabled so perhaps those are creating noise or perhaps the reproducer
> >> doesn't yield stable results.
> >
> > Rebuilding with the stock Fedora x86_64 kernel config was closer to your
> > results albeit still different, ~35% before and ~2% after.
>
> Ah, I can reproduce your ~65% result on the 5.3-based Fedora kernel, but
> not with mainline 5.4.0-rc1.  Only SELinux change between those two that
> seems potentially relevant is your "selinux: avoid atomic_t usage in
> sidtab" patch.

Hm... did you use the stock Fedora kernel RPM as the baseline? If so,
this could be because on stable Fedora releases the kernel package is
built with release config and kernel-debug with debug config, while on
Rawhide there is only one kernel package, which is built with debug
config. Under debug Fedora config the numbers are completely different
due to the overhead of various debug checks. I don't remember the
"after" value that I got when testing the patched Rawhide kernel with
the default debug config, but on stock Rawhide I got 43%, and on
Rawhide kernel rebuild with release config I got 65% again.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
