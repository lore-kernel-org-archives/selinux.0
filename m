Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E6CC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 19:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3963A20663
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 19:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LRI2gEwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3963A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeK1GyL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:54:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35977 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeK1GyL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 01:54:11 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so498406itj.1
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0oIAC8F8kBg9jIilXePaO8JdfRRo7IpVuEvD0Pwhc1A=;
        b=LRI2gEwBC1D4XgKRNdOsvuLeoNSD1qVop5PF+b7CV/6uPJQlOeHHnqpukjiICp6t3F
         iNCWHRLqpDha4dQyL4lvfJiKRjsyX7p5P4PrZyJM6Q5hVbxfMbbr6nfARPBa4uiJeDzq
         7qTGGmgEQjZ+KcczICT13gSw0TwDzGJzEK/GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0oIAC8F8kBg9jIilXePaO8JdfRRo7IpVuEvD0Pwhc1A=;
        b=fvIEyNYJxn2nxlVQtMNCY/2wXaWhDVvqn/PdhguaEqxH47M3IfFJWB2qtRgqCK1PI1
         rK/E/c/ysZbXhqSo1Arn+TKCRjDM7+AFAYnGk/z4kmgM14oqYQyo2vfg6hHgGJns9aG0
         XLPzISp/1O60QbUSdbPNKqfRb/4RG84hLaUftjkiPCeBRJmcy8rr0YPEDh5qEQLW9x1y
         Vh54+dH+hfR8Um6riqY7NavZ64lERSLb0zHTv19A/Pn8mncgc3ANHALrxdkhfWgM5604
         Y47+jm7eEsW5cqxtNJF1nPZPxMcqUHEx/SKfxnDdNruBo0ZsunX5eclU1+53JRlzla3A
         DRZQ==
X-Gm-Message-State: AA+aEWZcmMGg3DGIuXsas1tfIjvR3nZrCorG9i0dvROx9GGfahYVUKRh
        SjhJJSG344gqrAEM0qgi1jpfmW9CUp2T+ii8HPEa3w==
X-Google-Smtp-Source: AFSGD/WVe4SzrWPqCaC8vwbZS8ZTH3/mBylqQXLM876noXjH+dSY3yh+IaRb+1AqadKat+wbh5ASv2YDZq1SJhL3Jq0=
X-Received: by 2002:a24:e38f:: with SMTP id d137mr246508ith.69.1543348511547;
 Tue, 27 Nov 2018 11:55:11 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Nov 2018 20:55:00 +0100
Message-ID: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
Subject: overlayfs access checks on underlying layers
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <pmoore@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Moving discussion from github[1] to here.

To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
underlying layers") was added in 4.20-rc1 to make overlayfs access
checks on underlying "real" filesystems more consistent.  The
discussion leading up to this commit can be found at [2].  The commit
broke some selinux-testsuite cases, possibly indicating a security
hole opened by this commit.

The model this patch tries to follow is that if "cp --preserve=all"
was allowed to the mounter from underlying layer to the overlay layer,
then operation is allowed.  That means even if mounter's creds doesn't
provide permission to for example execute underying file X, if
mounter's creds provide sufficient permission to perform "cp
--preserve=all X Y"  and original creds allow execute on Y, then the
operation is allowed.  This provides consistency in the face of
copy-ups.  Consistency is only provided in sane setups, where mounter
has sufficient privileges to access both the lower and upper layers.

The model may not have been perfectly followed, or possibly the model
itself is flawed.  I'd like to better understand the issues here.

Thanks,
Miklos

[1]  https://github.com/SELinuxProject/selinux-kernel/issues/43#issuecomment-442148920
[2] https://marc.info/?t=152762608800002&r=1
