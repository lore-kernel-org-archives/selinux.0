Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D0C433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC88920738
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeyuePHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgEUIu7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 04:50:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728407AbgEUIu7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590051055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjB7AnQHw4NFRDvsov8Q9OXrWX9fQxfIqeAVoK4tn6o=;
        b=NeyuePHvnZIor0/fPF8WxIhwF7dqPMl0pM3psBzQ59LfV47P/s+RCJwX/HNiTORCyeGECi
        gOVwJlGkTmLuuefvCzaMUW5K9QB1RRjy3tM8IKZD8jR1MqzhR4siQGoE6FFfg8b8EmVK6L
        omaVdAhwFeX5Bd9gS9uapTfK/KEcR/Q=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ZMIVP_XyOMiIfhFjG6nIHg-1; Thu, 21 May 2020 04:50:51 -0400
X-MC-Unique: ZMIVP_XyOMiIfhFjG6nIHg-1
Received: by mail-oo1-f72.google.com with SMTP id s23so3083488ook.7
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 01:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjB7AnQHw4NFRDvsov8Q9OXrWX9fQxfIqeAVoK4tn6o=;
        b=MU2AfYcxb1XRsCOBDuvrTtoZXX/FRk/kRflClRWIDw+2sTi3wMKYLAnQH27n0obGit
         r0PxQ/elQ2499NxDfpR8JtFHixLznec0QGdFzXiwvhf4TLb89zVNij2QCQJ609wEfvzI
         VfBPk8/85Ej3iHIbHM1fnfhCbpQOWtiHXIg5tOj3Tt8mgQeCZ786KSeuBmwbsOnAuCmH
         LLHu6S77Xg/b9OYmVVBU96WJ8ozbV6+NjmWMk8RSDwoT9OEqyiQiWIpmvFKAwJ4Oatez
         Xu/QL6IXydcjtVDil4/+yhUo89MOtQvvGraGr1BZlgx32MMmp0japP6PR0tANMy79jVC
         +6hw==
X-Gm-Message-State: AOAM53377YaRhDWg874DqWJiQD+g1t/pycYy5H8yWixsWhnA+V4izvJj
        BYsuKIuJqgx1xt9xaRnxVP/nLgZYVG2CbYtXfICvMFR6DcyXiPyMUUi+dLA7lGrvEiCi5KaabGH
        SVtSAH4+wgh6VEC/WjfldmQqJOTihu1XQ6Q==
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr6348864otb.66.1590051050162;
        Thu, 21 May 2020 01:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEV0OELCPGyxqkXpiTde6Wz52RJk188BrlubrYZ8m7ivG539iIHyAVtPwrYHg+qHCYx+9WzToB9tYM7ZJEfy0=
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr6348858otb.66.1590051049882;
 Thu, 21 May 2020 01:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
In-Reply-To: <20200520163421.27965-2-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 May 2020 10:50:38 +0200
Message-ID: <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> The current Travis CI runs the userspace tooling and libraries against
> policy files, but cannot test against an SELinux enabled kernel. Thus,
> some tests are not being done in the CI. Travis, unfortunately only
> provides Ubuntu images, so in order to run against a modern distro with
> SELinux in enforcing mode, we need to launch a KVM with something like
> Fedora.
>
> This patch enables this support by launching a Fedora32 Cloud Image with
> the SELinux userspace library passed on from the Travis clone, it then
> builds and replaces the current SELinux bits on the Fedora32 image and
> runs the SELinux testsuite.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

From the text above I infer that this patch is intended against the
userspace repo, right?

If so, I don't quite see the usefulness of running the
selinux-testsuite on every userspace change... It is mainly intended
for testing the kernel and only a small part of its running time is
spent on running (i.e. testing in a sense) the SELinux userspace
programs. Not to mention that in your patch it runs with the userspace
shipped in Fedora and not the version from the given commit...

However, it could be very useful if this was added to the testsuite's
CI instead so that it can verify that the testsuite patches don't
break something. But note that you'd need to modify the script a bit
to copy over the testsuite snapshot being tested to the VM and run
that, instead of the current master.

Anyway, thank you for working on this! I never realized that it could
be so easy to run a Fedora VM from Travis. If I find some time maybe I
can find some more ways to use this... For example we could run the
Fedora/RHEL SELinux userspace tests from [1] after installing (not yet
sure how) the userspace built from the currently tested userspace repo
commit.

[1] https://src.fedoraproject.org/tests/selinux/tree/master

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

