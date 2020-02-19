Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F62C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83AD24654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d25QaQ1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBSQLh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:11:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgBSQLh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 11:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582128695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8blsIc+YkOC7IVuTCtQjuZV8vsK+/Wvf7yFxY7/jyg=;
        b=d25QaQ1LkxBfbTy22d3cuf+NYg8xxnR26ygAFaQ3IClimsmvTHOoDM0gSfqnsrN1PyMPrG
        kVbH570wz59jzB2knLbRNGb+Q8LvjGM4Ed4Pa2IbeMYBnv/IYQvTFii1PsbVmMLw9dVP/X
        Va8PyZW9+iDhiJMaLC0HJY7B8YTPRZo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-L_Wu7nrqN160Vtkc6MSIRA-1; Wed, 19 Feb 2020 11:11:33 -0500
X-MC-Unique: L_Wu7nrqN160Vtkc6MSIRA-1
Received: by mail-ot1-f72.google.com with SMTP id e11so441068otq.1
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 08:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8blsIc+YkOC7IVuTCtQjuZV8vsK+/Wvf7yFxY7/jyg=;
        b=ERopT23EVYFKxQrbAAnpl+MC50kNfL+AhpA7TXrjaoc2MNLv4R1J9DKR0jf9jI4OOw
         +Ur1wg6b3e/LtGBF41C4R3dMu+weexKk/iSnuCKzNC50UjZh8ICbuAz9sMZKS9LxHtOU
         qykktH9Wx1UdIrrf784j5CxszgBio2rqi5SihFf8aZW1a9OP22eWbkZ/nc8Btepksg4v
         2V8GtEiPwWXai8Svk9p7uCl+XxsNaUKwGoVCo+iHa5J55Uhv4m7GPeSWzBB0qBuvQVX3
         aYla6OmjqZ9LkgYwSUB5HiJKjzptY5QfH6o/XRyk11UBjGpGhPgwga9WuttSSTio2bnN
         /H/Q==
X-Gm-Message-State: APjAAAXnnWRCE63IxGdJIhRjGMhkMfriKX0EeHHHTOduFRQURC9Bu6Bi
        78XjpO91KKSeJf2j6Z8p1jfcJ4ZtDkgh52+2uJBI3sFwiSXnibVGcx87xJLTxst/98BLSkkIT6R
        BqcLq7C2fhfXuJlIyGcAYixqfH+y7JBegXg==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr5131004oig.156.1582128692313;
        Wed, 19 Feb 2020 08:11:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/fcm21/YWsZcqHmucPCv6zOERdJ+/RG8GD7kpYavBrOVQcfQ0OtQCmuSmFDMHrn/VUEC8oZopt/jPghrkTWE=
X-Received: by 2002:aca:cd46:: with SMTP id d67mr5130991oig.156.1582128692052;
 Wed, 19 Feb 2020 08:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20200210160639.GA411895@stefanha-x1.localdomain> <bbcbd9a0-a036-1c1e-ed66-ac2aaca454a5@redhat.com>
In-Reply-To: <bbcbd9a0-a036-1c1e-ed66-ac2aaca454a5@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Feb 2020 17:11:21 +0100
Message-ID: <CAFqZXNsL4nC4N2XKgMmTNJGCayJ1E=ppiKCBhv2yFCt39dLWqg@mail.gmail.com>
Subject: Re: [selinux-internal] SELinux support in virtio-fs
To:     Daniel Walsh <dwalsh@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 4:29 PM Daniel Walsh <dwalsh@redhat.com> wrote:
> On 2/10/20 11:06 AM, Stefan Hajnoczi wrote:
> > Hi Dan,
> > I've CCed the public virtio-fs mailing list because SELinux support in
> > virtio-fs has been asked about recently.
> >
> > It's time to figure out what level of SELinux support will be available
> > in virtio-fs.  The file system client shares most of its code with FUSE
> > and SELinux labels on files are currently not supported in FUSE.
> >
> > It would be possible to pass through extended attributes to the
> > virtiofsd daemon running on the host.  However, passing through xattrs
> > allows the client to relabel files on the host file system and this
> > could pose a security problem.  virtiofsd already allows the client to
> > set the uid/gid and permissions, but is passing through SELinux xattrs a
> > bad idea?
> >
> > virtiofsd is in a position to mangle extended attribute names
> > ("security.selinux" -> "virtiofs.security.selinux") in order to separate
> > guest SELinux labels from host SELinux labels.
> >
> > As someone who knows very little about SELinux I'm eager to hear what
> > you think would be a good approach.  Secure containers (e.g. Kata
> > Containers) are an important use case but virtio-fs can also be used as
> > the root file system for a guest (a scenario where full SELinux support
> > is needed).
> >
> > Thanks,
> > Stefan
>
> I am traveling right now.  We should add in the SELinux team, and I will
> be able to look at this on Friday.

Cc'ing the upstream SELinux mailing list for more insight. Here is a
public archive of the full thread:

https://www.redhat.com/archives/virtio-fs/2020-February/msg00005.html

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

