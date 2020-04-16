Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5978C2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 10:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A142D21D82
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 10:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iE8KgYys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505841AbgDPK6z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:58:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505692AbgDPK6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 06:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587034724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7zCJMhz4JdYAWVHlNwkBt/Y/yApwxSACQauMkwJ4OE=;
        b=iE8KgYysfkvVme5dAfD5fQKY2e/fBg6V1ndcE+pCq8OS65kPDkO+MfyospMbkBbvejTBGo
        UTRdgPqHm/1VZPIWnOni1UaqdfwZFQfnFfc8qTX4Q16r73Mw5QyynDmfZdrg61jtDGR4LI
        nyoOzxwradNyU4fH++pW7jz6KSsK/4A=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-XSOxYFKSM5uvXxuwb1fMhA-1; Thu, 16 Apr 2020 06:58:42 -0400
X-MC-Unique: XSOxYFKSM5uvXxuwb1fMhA-1
Received: by mail-ot1-f70.google.com with SMTP id q4so2943427otn.9
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 03:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7zCJMhz4JdYAWVHlNwkBt/Y/yApwxSACQauMkwJ4OE=;
        b=ZZ7jENs3Vd5bgwKEmj4a6vd9SKzlzxRLRbKCH41vokwAjbAfOsLjneQSHlbEyT1QdI
         xQO7XyREukapSGBvNROFDBe1meY/9jJRLwO5tp4eFHR26tH7M4hYmtHnxBvEXxHln+QX
         rzrHHRyvahMD0Q1mPbD3p8C8nwAG9J5yJy/Ynqa3LUknJG+zLi6j6d2q+HN76wwBfswT
         bMPBOGjZ4WYeIGISUCaVFFymCitqKUR1tAc5QU776Zh3NhEhse0YoGRamnkaxxiMgVcG
         4qpS2Qg8XNtSVMIrBW1DpIjQJLkXjMnnNdd7n4lSwYlw7eJ0kgueqhq1n5ltDiGFVGLV
         QfiA==
X-Gm-Message-State: AGi0PuYfAmCaiQcUshQbhQa+9yTt5nm30R0dH8GQLCp9GHRoGxV65Uhc
        kDxoid8y6CzZ73SxpmM438FfE/WCZ79/xJcGhayh6C1inmxL4PuP8lkjKdZBFgkoLNIEk8UDeZs
        GHVub6m6M8MhvX99NwiGy0p4xiyVtNWJrgQ==
X-Received: by 2002:a4a:3908:: with SMTP id m8mr16905312ooa.58.1587034721328;
        Thu, 16 Apr 2020 03:58:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLtNqJwp9chJSxGOswasuHdvWWf6XgicW+lxTJ8CWpWUzX60erdPJUDliGGzuIKv5BqVUYpPtK6M/bJGwnRtG8=
X-Received: by 2002:a4a:3908:: with SMTP id m8mr16905301ooa.58.1587034721075;
 Thu, 16 Apr 2020 03:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <158697587242.118532.14560996990720692395.stgit@chester>
In-Reply-To: <158697587242.118532.14560996990720692395.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 12:58:30 +0200
Message-ID: <CAFqZXNsTFv14wTc_aim7AZEi17rb562V=FAU8y-E82npF-Hh0g@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add capability:sys_admin to the bpf()
 related test domains
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 15, 2020 at 9:22 PM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Historically the Fedora Kernels have been built with the
> kernel.unprivileged_bpf_disabled set to 0, which skipped a
> CAP_SYS_ADMIN check in the bpf() syscall.  However, starting
> with the Fedora Rawhide v5.7-rcX kernel builds this sysctl
> is now set to 1 which is triggering a CAP_SYS_ADMIN check
> when performing bpf() operations.
>
> Add the capability:sys_admin to the BPF test domains so they can
> pass this newly triggered check.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  policy/test_binder_bpf.te    |    2 +-
>  policy/test_bpf.te           |   12 ++++++------
>  policy/test_fdreceive_bpf.te |    6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)

I have been applying a similar workaround in our RHEL testing, because
I encountered the same setting on RHEL-8. Interesting that Fedora is
doing the same thing now... Perhaps this is an unintended consequence
of the recent workflow change? Anyway, it seems better to have the
test ready to work regardless of the sysctl value, so:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

