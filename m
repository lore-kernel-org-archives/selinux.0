Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0875EC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E695A60231
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbhICG53 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347517AbhICG5V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 02:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=DmxoWER/CtV19WixMQYmzkCPLAtBZH/5mNwAnWTyax6t//tlHdpDS/Jpd5hapVVK1zZuAK
        W13UlDDi4uNL0CP6LbRQnUv8Fto5jZevBxaxxcmMHBfsSJvWshWr2YrJwzgrU9V1Ba4KWk
        pAzqXb5Edn9T2YjGtX7a7Tpb+sMnECM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-u88scp_hOKWHoymRFbI5Ig-1; Fri, 03 Sep 2021 02:56:21 -0400
X-MC-Unique: u88scp_hOKWHoymRFbI5Ig-1
Received: by mail-wm1-f69.google.com with SMTP id e33-20020a05600c4ba100b002f8993a54f8so581046wmp.7
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 23:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=VBE4L7fPRDrtiw8QjypgECF70T5eQfVnqJ9csapTWZcNU9DslM3P4g7XnV7VrwaCwf
         2yP4y/E4sf/Pd9T9Rub5MOwKOHdl7zTyu8Nesu1VM7UtHEu0uXYHU/vsG0TD3HmRW2CX
         udrHczKElIxg8rtHVD5qMWSAdAu1yizyb2J14m6bSMS3kG2kj0u2kmhyafAej2XAqmjT
         zTi0QooAn1uhEHetPgzRVJGsDRimvAuUFmI9NHZK5iwwoJs6J1ghokZTSmcWFvz7Lc07
         J+uWeIp6ALcDRfQuiLeFe9QsPK2Mbd5MBCP9Oz8eHGGNYY/YyH4u1sF+8vwAtohQtOQ0
         W9PQ==
X-Gm-Message-State: AOAM533lK+K05G17627QDPEee4m8DDEzwbCLCTZ2MDBeOo0pPceUOSpT
        A5IduEBAAHVx84aNEJN2Gpe7JERogMrFkic7zf2pHQ3a1zz89gcqILQiK8CE/7pDp5UF9RZZmsv
        Bs5cYmH36Hqr4yKITp9H9yPUAqsMoeboXzw==
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757633wms.27.1630652179801;
        Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEMgRhDhAirpF+1BwSzCXJ2JmOX/csrcn3G6xdkU4jNs0c3KyXpXRLPYTJcObTec0xa9Qcz/PI2DFfXbdCfYE=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757607wms.27.1630652179603;
 Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
In-Reply-To: <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Sep 2021 08:56:08 +0200
Message-ID: <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > xfstests: generic/062: Do not run on newer kernels
> >
> > This test has been written with assumption that setting user.* xattrs will
> > fail on symlink and special files. When newer kernels support setting
> > user.* xattrs on symlink and special files, this test starts failing.
>
> It's actually a good thing that this test case triggers for the kernel
> change you're proposing; that change should never be merged. The
> user.* namespace is meant for data with the same access permissions as
> the file data, and it has been for many years. We may have
> applications that assume the existing behavior. In addition, this
> change would create backwards compatibility problems for things like
> backups.
>
> I'm not convinced that what you're actually proposing (mapping
> security.selinux to a different attribute name) actually makes sense,
> but that's a question for the selinux folks to decide. Mapping it to a
> user.* attribute is definitely wrong though. The modified behavior
> would affect anybody, not only users of selinux and/or virtiofs. If
> mapping attribute names is actually the right approach, then you need
> to look at trusted.* xattrs, which exist specifically for this kind of
> purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> That's unfortunate, but not an acceptable excuse for messing up user.*
> xattrs.

Another possibility would be to make selinux use a different
security.* attribute for this nested selinux case. That way, the
"host" selinux would retain some control over the labels the "guest"
uses.

Thanks,
Andreas

