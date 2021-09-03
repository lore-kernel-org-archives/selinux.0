Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B4C433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856B66102A
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbhICGcR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345449AbhICGcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630650676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YC/rlauU/F6bmxF77VH11Mgk4hV/IwCNeLbfbf9xP5Q=;
        b=TOQpwkyAxLvlzLXRWkCbVCeCE5dtwOipp3KfMhTsZZgmgHMxaieBsuxMJzqrnQfcsL6c0N
        huctH7dsYXwGeLBp3QUFM3WJZL2yy5kmqNObe34UxLW044/QGVB8c3PH4JhLTG2UBkmogS
        9cpVbrT35Gfo9TDhAaU5Ue5gIce+bdg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-VrsLSP_FOySEgagWKuOELA-1; Fri, 03 Sep 2021 02:31:15 -0400
X-MC-Unique: VrsLSP_FOySEgagWKuOELA-1
Received: by mail-wm1-f69.google.com with SMTP id j135-20020a1c238d000000b002e87aa95b5aso2227266wmj.4
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 23:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YC/rlauU/F6bmxF77VH11Mgk4hV/IwCNeLbfbf9xP5Q=;
        b=SaFyliRs1oESUcS77i/gEXnoMSJ4DrIa10W726ZvKPFhYVFrH/Eqv1cLMPuPn1rqZL
         eM8ysHVG772gdFX2j1Bqx07pbRDipxpiWfhGcEvVJPHdl6dETqQkWAih94lTbuQ3R0gP
         lSULvA/fb/Dq1URhOPBxO2XsoReFvrMHk7vQ5cxCxOsjW9udZe6WWiLMZEqcMCy1RYRD
         bfuJgHh4gg6r6xxvwx1wnQH77AQlx/TQEaaGh/oGEza9x5pjjXlWL3orQQv6Ef2r6GmW
         4Cv05PGasrK3R8GyhByjh0O7Vp6TW10w+/JG6exG3lOOxQRP5gWbTuHqj7XAI3yhAAzA
         8WYg==
X-Gm-Message-State: AOAM531Qxws2EYNJ7yf2xAYgSUX9avUbxASnqoAf0HNHMKYVXsAD+pQk
        joKUGlM4MNDR9M6LUCvOad1Qhax9ayprGibx0D5ezpPgZKcAuTYYZqWI28QSmOF/E7trQm0YSpI
        OBFVwoQxpvooB58qz+N15TsZzHSiposGHrw==
X-Received: by 2002:adf:d193:: with SMTP id v19mr2009428wrc.377.1630650674697;
        Thu, 02 Sep 2021 23:31:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyPFJw9ZP/m1ileU46mEBJVAfh6Zf+O3xQQjDX0TV+sCc5/OMAl/XmaZX2RmznLFq2omumgxC7UK2vm0m9SxM=
X-Received: by 2002:adf:d193:: with SMTP id v19mr2009383wrc.377.1630650674468;
 Thu, 02 Sep 2021 23:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
In-Reply-To: <YTDyE9wVQQBxS77r@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Sep 2021 08:31:03 +0200
Message-ID: <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> xfstests: generic/062: Do not run on newer kernels
>
> This test has been written with assumption that setting user.* xattrs will
> fail on symlink and special files. When newer kernels support setting
> user.* xattrs on symlink and special files, this test starts failing.

It's actually a good thing that this test case triggers for the kernel
change you're proposing; that change should never be merged. The
user.* namespace is meant for data with the same access permissions as
the file data, and it has been for many years. We may have
applications that assume the existing behavior. In addition, this
change would create backwards compatibility problems for things like
backups.

I'm not convinced that what you're actually proposing (mapping
security.selinux to a different attribute name) actually makes sense,
but that's a question for the selinux folks to decide. Mapping it to a
user.* attribute is definitely wrong though. The modified behavior
would affect anybody, not only users of selinux and/or virtiofs. If
mapping attribute names is actually the right approach, then you need
to look at trusted.* xattrs, which exist specifically for this kind of
purpose. You've noted that trusted.* xattrs aren't supported over nfs.
That's unfortunate, but not an acceptable excuse for messing up user.*
xattrs.

Thanks,
Andreas

