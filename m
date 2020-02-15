Return-Path: <SRS0=W430=4D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7CC2BA83
	for <selinux@archiver.kernel.org>; Sat, 15 Feb 2020 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447252084E
	for <selinux@archiver.kernel.org>; Sat, 15 Feb 2020 17:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj4/bAlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBORcW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:32:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgBORcW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Feb 2020 12:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581787940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OzNcfaxGyi347QT9fYE5irugVIike/ukBTbkQ/kMbq0=;
        b=Fj4/bAlkWpx/0PFrBwoZ0qMANDyHe9VVprPyfSeuCGvgfeCPpjGf9/MSO9dNf/8quVbnW6
        viPWdmK//VbESrrdV3ozXKFhX+8SBg9M75ea48ReywYBH7VOdqZA6Q1HdmIWTNQdivRoeA
        ljLur23a4q+RtPBFztnfwOQzSff07PE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-UCRNlvtBMJOm94-6o3EtHQ-1; Sat, 15 Feb 2020 12:32:18 -0500
X-MC-Unique: UCRNlvtBMJOm94-6o3EtHQ-1
Received: by mail-oi1-f200.google.com with SMTP id d9so6314534oij.4
        for <selinux@vger.kernel.org>; Sat, 15 Feb 2020 09:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OzNcfaxGyi347QT9fYE5irugVIike/ukBTbkQ/kMbq0=;
        b=NUZvdXTyIsjP6UxqzLp6LrkFiCUoAPe6dn2omqkR09MAWcth20SGIU3ci9+KHAgCcn
         X0y50oYMRm/aoaXuiycTS7zzwpYdoBu5Oqv+C30gy1syGgyvkMIc8lxNgiMDqSXfI79Z
         6LMcrpmADPzx//MjAJOGX6WPzif5xKn+wYcz+KHC/UNfpkPHGsQhhERrjd92aT7GNlHm
         3r9UGjJ/6VG1VFojw8rPjU6aRSYmEGZLQ2FLxKykkDvfuLRoODqHMdxsmtJrsiydU6zv
         QPf10lwdTRWMtmRL8AGkzZy7ui6PMvzHjdrXlXgThM+U940VXiQpc4Idh3Rv3zTaTCDF
         DgBw==
X-Gm-Message-State: APjAAAWnzYG3qlawShcIBsHbIiqddTQsRox6P4cBlWpcBv81bPihu79G
        m6U6GZ8UMl3T0HzY1bLwghYFrrHjvtVkG4hg8ffi0SWdS1lr8GDuXgx1AiX8229eT7eOQk4KoRh
        wWc7nQUajVsdhWiKC+tmq/X4wXnsvv5LbdA==
X-Received: by 2002:a9d:729c:: with SMTP id t28mr6626791otj.66.1581787937463;
        Sat, 15 Feb 2020 09:32:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzna4GjUmkx5I+TbKOLb8T11PVmxGj7NeLmfrGtZtuKbSjUfSSTStvodVwI4LEfdrZb47jw+zb/wl/kHJkPCUY=
X-Received: by 2002:a9d:729c:: with SMTP id t28mr6626777otj.66.1581787937237;
 Sat, 15 Feb 2020 09:32:17 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 15 Feb 2020 18:32:06 +0100
Message-ID: <CAFqZXNte8PTA5E77kYtmX-1s0juzZ=MrdV0JOf9txbW9q1L46w@mail.gmail.com>
Subject: Duplicate hashtab code in libsepol vs. policycoreutils/newrole?
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Jason Zaman <jason@perfinion.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone,

I noticed that there is a duplicate hashtab.[hc] code from libsepol in
policycoreutils/newrole. Can this be deduplicated somehow? I can think
of three options:
1. link to libsepol (a bit unsafe, since hashtab symbols are not
versioned, but other programs already use non-versioned symbols form
libsepol anyway...),
2. statically link with libsepol's hashtab.o (libsepol code would be
needed in ../../libsepol to build newrole)
3. turn the newrole files into symlinks that link to libsepol ones
(similar issue as above, the symlinks would have to be substituted for
actual files when creating release archive).

If we really can't get rid of the duplicity, what should be the policy
for updating the hashtab code? Should the same changes be done
simultaneously to both copies? Or should we change only libsepol and
treat the newrole copy as mostly frozen legacy code?

The thing is, I'd like to make some small changes in them, but I'm not
sure how to handle the duplicity.

Thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

