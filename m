Return-Path: <SRS0=MkDT=WP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C7C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3D1214DA
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 21:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHSVMK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfHSVMK (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 19 Aug 2019 17:12:10 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A9FA7BDB0
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 21:12:09 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id 71so2697581pld.1
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 14:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+hkHih8sHO3v35Xlj6uRke0l04RJ9vdo4xCFzeRqe0Y=;
        b=aiQ2ONMm1HPXW/BI6I19DjlTJHqyATQZLkHhSGRHHjSfK/mBeTlPCySsKt06jrx3dY
         IgVsc7PinRb+3WnGQDD/HkATkDLjjqFt8OO60W7PDKNTuNVS4sqiHW5vBBWiTvqwZDgc
         20EjKO48VhMnRiSZtlkerMs6Q6k/G7e4K018cUIdppczeH4uaKGLRunOuRcf/PK8i7bJ
         soxg5s8sFVMnqJsn+DpLE68i0LfkguJtqvULlViequ2Rn71rHMjjkCf/3kAqpBKbL4Sy
         q6z3vCtb0/VdR8xBlIbJg0x5jaX68HLHknuxr7P3jiLL4HPc+ty60GavN2fZeSkt4LG/
         uOhw==
X-Gm-Message-State: APjAAAX7Q+TKOGFgmarABMtTKvgLgzN9AEs/e15Te39wrvG/izZ60MoE
        s8eZpqyY+2UdSOnmkYgGjjzEwjJai52Y79UOoe1+rn3DyHwIc/UsAAdYt3TTmRkQshmE0GKWNzk
        UwtDdooKcC1j5XSyyP9Y27M8qM9RJwVlAAg==
X-Received: by 2002:a65:60d3:: with SMTP id r19mr21976776pgv.91.1566249128806;
        Mon, 19 Aug 2019 14:12:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYKnR/lXRyP9eJP575gpi9vU8aAGrfFBAnOqt38nzmR7FJrGT4mpxW+zngd0ZSZrOEL/p0e9of1fBUK8OHbF4=
X-Received: by 2002:a65:60d3:: with SMTP id r19mr21976749pgv.91.1566249128478;
 Mon, 19 Aug 2019 14:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190819193032.848-1-jlebon@redhat.com> <20190819200552.GB749746@brutus.lan>
In-Reply-To: <20190819200552.GB749746@brutus.lan>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Mon, 19 Aug 2019 17:11:57 -0400
Message-ID: <CACpbjYqHPx8H=9zOC7cYJuxhyz8TV6af0xBkx+oQbSdda=kmkQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>, selinux@vger.kernel.org,
        Victor Kamensky <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 19, 2019 at 3:49 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> > Going further, there are use cases for creating the entire root
> > filesystem on first boot from the initrd (e.g. Container Linux supports
> > this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
> > One can imagine doing this in two ways: at the block device level (e.g.
> > laying down a disk image), or at the filesystem level. In the former,
> > labeling can simply be part of the image. But even in the latter
> > scenario, one still really wants to be able to set the right labels when
> > populating the new filesystem.
>
> Does `echo "/" > /run/systemd/relabel-extra.d/foo.relabel` not address this?
>
> https://github.com/fedora-selinux/selinux-policy/issues/270

If one has files on multiple partitions, using systemd for this would
require keeping all the filesystems mounted across the pivot,
something we're trying very hard to avoid because it makes the bootup
process (and potentially mount hierarchy) different between the first
and subsequent boots. See more discussions about this in:

https://github.com/systemd/systemd/pull/11903

But also, asking systemd to relabel the whole system on boot isn't...
ideal. In the filesystem provisioning case I mentioned, we would be
extracting files from an OSTree repo, which already has labeling
information.

>
> If that does not do what it should do then this functionality should probably be removed?

I think the functionality on its own can be useful for a subset of use
cases. E.g. dracut modules which need to write some files outside of
/run (since that one already gets relabeled automatically)?

On Mon, Aug 19, 2019 at 4:05 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> > +     if (!selinux_state.initialized) {
> > +             /* If we haven't even been initialized, then we can't validate
> > +              * against a policy, so leave the label as invalid. It may
> > +              * resolve to a valid label on the next revalidation try if
> > +              * we've since initialized.
> > +              */
>
> If you cannot validate against a policy, then how do you know what labels to associate?

If only relabeling a few files, we can use the libselinux APIs
(`selabel_*`), fetching the file context policy from /sysroot. In the
"full filesystem reprovision" scenario, labeling information is
already part of the objects we're writing.

One might then ask, "why not just load the policy in the initrd
instead?". The answer is that this also comes with a host of issues,
and isn't very widely used in practice. See discussions about that in:

https://github.com/coreos/ignition/issues/635

Esp. this comment and onwards:

https://github.com/coreos/ignition/issues/635#issuecomment-497730774
