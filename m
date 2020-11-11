Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED3DC388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6EB206D9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKVPF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:15:05 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34413 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVPE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 16:15:04 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7EEE856124E
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 22:15:01 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id l36so3528038ota.4
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 13:15:01 -0800 (PST)
X-Gm-Message-State: AOAM532SJNdaMF5YG16QVnVNeaIsdboOavcWA9BZuluzlAjP3HeNJEPz
        KV4j/G58iUxiVyuuZ6S8b65vjEQzfqzFyMXyt4E=
X-Google-Smtp-Source: ABdhPJxIdOUBNQ7wSTTjjbFL9whBLbHnLk4LLsIzU1TnTSR5q0Keipiy3SXAM9kxgP4h0kZDUf+JmnekcRr1ScIncuo=
X-Received: by 2002:a9d:123:: with SMTP id 32mr16355609otu.279.1605129300460;
 Wed, 11 Nov 2020 13:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20201102094310.484837-1-omosnace@redhat.com> <20201102101710.GA210822@localhost.localdomain>
 <CAFqZXNvK=t4zGaLQzP-u-sbrM8KWBX3P7evUqTqcNKHEcYN+QQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvK=t4zGaLQzP-u-sbrM8KWBX3P7evUqTqcNKHEcYN+QQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 11 Nov 2020 22:14:49 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k4KXw_gX9QQp9pWZnL3CfGeNxn7jwq7LrZPg45s6zVUA@mail.gmail.com>
Message-ID: <CAJfZ7=k4KXw_gX9QQp9pWZnL3CfGeNxn7jwq7LrZPg45s6zVUA@mail.gmail.com>
Subject: Re: [PATCH userspace] ci: bump Fedora image version to 33
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov 11 22:15:02 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 12:12 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Nov 2, 2020 at 11:17 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > On Mon, Nov 02, 2020 at 10:43:10AM +0100, Ondrej Mosnacek wrote:
> > > The testsuite will soon be switching to testing multiple filesystems,
> > > which exposes a bug in F32 image's kernel. Since Fedora 33 has been
> > > released recently and the testsuite runs just fine on it, just bump the
> > > image version to avoid the bug.
> > >
> > > This commit also fixes the script to read out the Fedora image version
> > > from environment variables instead of using hard-coded values.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Would it make sense to use Rawhide images from the link bellow?
> >
> > https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud/x86_64/images/
> >
> > I think Paul already asked for it in past but I'm not sure what was the outcome.
>
> It is possible and already being used for the testsuite CI. However,
> it is a bit harder to get to work reliably and there is always the
> possibility of rawhide being randomly broken. It would require some
> more extensive updates to the scripts (including a couple fixes from
> my pending patches for the testsuite CI), so IMHO it should be done as
> a separate patch (if at all).

Hi, the patch looks good, but it does not fix everything: e2fsprogs,
jfsutils and dosfstools also need to be added to
scripts/ci/fedora-test-runner.sh, like what
https://github.com/SELinuxProject/selinux-testsuite/commit/d4e507f78a1784334611421cdfa3683a8214b22d
documented. Do you want to submit a patch about this?

Anyway, for updating the Fedora image version to 33 : Acked-by:
Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

