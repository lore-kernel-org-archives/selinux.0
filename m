Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBBC05027
	for <selinux@archiver.kernel.org>; Fri, 10 Feb 2023 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjBJIgy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBJIgx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Feb 2023 03:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1E2F783
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 00:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676018161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L27DuQ1MngnuHokATQEJWqv4GVJGZWk6Rgrqes130fM=;
        b=FeWl2/fKWbGh6/M3OqO1gNU+5RvVUh19UF1wUEF3+obWBomALeG0cQ8tPLiUCaosp3H3cN
        nJq81pwv/eSmWuJbrEgTjI83vG6K+IhyMNOubk0fuan+2G/Z85s2opQq2pAUH3EwSox1xA
        qjsxWgqHMJI7OssEB1A5zNalQMcunjs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-C-blqRgwNh2wbAMke4LzeQ-1; Fri, 10 Feb 2023 03:35:58 -0500
X-MC-Unique: C-blqRgwNh2wbAMke4LzeQ-1
Received: by mail-pj1-f71.google.com with SMTP id l18-20020a17090add9200b00230f60889d6so2162701pjv.3
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 00:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L27DuQ1MngnuHokATQEJWqv4GVJGZWk6Rgrqes130fM=;
        b=BUuu5x0x4ZHvvnjaNe6ueci6ATeY8SPPPpvFv/wgSlMjBYPZkPCmEHtN1mQa78JpSP
         TNGesOnLIILwIYx0koLytTTjgnBShE0VujEgfJCyU4DccZwaCeFfBJcd+rNk5k/eUWVe
         1X1/aNdX6EK6xfq58PEy1iUDTA8tCSFUavKeuhEDY9MP0X0rYiA7qWauK2GOtCpdl/3A
         q3UJ7upVxoQBDXr+kYC22rJY6ywBVBOfLUYEgd0J3qkmizyRwajkbjebAdiZOpefV+/0
         EHCmDLmGwFyq1yu53WjSr76l+z8WQLYuFgSm0p7Gk+U/i5KrOVX6Xqih5+/41fXv7POC
         hGbA==
X-Gm-Message-State: AO0yUKUWSwhVk2IO0IWB4HWSa2/7JSBnjM5nDy5Uki7+ZOCI6fa/BFjZ
        fhBVCriDmN6WD/vIUxniHz205qEGq6+MNZuJ12VDlOCe3QknsxpyatIX4mK5ENkVULcY1abSpKf
        lIaSnKsv32ujKTt4tWqnpC/T7o5Bama3XN6LPJpLHwMW9
X-Received: by 2002:a62:52c5:0:b0:5a7:c883:3d7a with SMTP id g188-20020a6252c5000000b005a7c8833d7amr2654367pfb.3.1676018157316;
        Fri, 10 Feb 2023 00:35:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8tTMs8TRfHs1ZhThkqu3/o7yfHip+DSn7bCeimDFLOkiHRIyPz+Q86gFFX5zC2OK/mexg8fsBPdYQGcAJRxbc=
X-Received: by 2002:a62:52c5:0:b0:5a7:c883:3d7a with SMTP id
 g188-20020a6252c5000000b005a7c8833d7amr2654365pfb.3.1676018157042; Fri, 10
 Feb 2023 00:35:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
In-Reply-To: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 10 Feb 2023 09:35:45 +0100
Message-ID: <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> Hi all,
>
> I just noticed a selinux-testsuite failure in the tests/file test:
>
> # Test 8 got: "512" (file/test at line 103)
> #   Expected: "0"
> #  file/test line 103 is: ok( $result, 0 );
> file/test ................... Failed 1/16 subtests
>
> Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> in test_sigiotask.c is failing due to a recent Rawhide change to
> undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> information on the Kconfig option.
>
> I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> turning it off is a good idea, but it does mean we need to adjust the
> selinux-testsuite.

I noticed that in our CI yesterday and had a brief look. Unfortunately
I don't (yet) fully understand the terminal device voodoo being done
in test_sigiotask.c and I don't have any idea how to make it work
without TIOCSTI. So the best fix for now seems to be to use the
dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
be broken currently:

# sysctl dev.tty.legacy_tiocsti
# sysctl -w dev.tty.legacy_tiocsti=1
sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
#

I will look into fixing it...

> Also, as a note to the Fedora folks who will see this, maybe don't
> tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
> test failures late in the -rc7 stage doesn't do wonders for my sanity
> ;)

When new configs are added upstream, AFAIK, they are set to the
default value in the Fedora configs and marked as "pending". The
Fedora kernel maintainer (Justin Forbes) then at some point goes
through all pending configs and sets them to a value he deems best.
This time it happened around -rc7; I'm not going to speculate why or
if it's the usual practice. I recommend raising this on
kernel@lists.fedoraproject.org - Justin is always open to suggestions
and he might be able to accomodate this expectation.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

