Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC03C43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9548C208E4
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9548C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeK0Tuz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:50:55 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39286 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeK0Tuz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 14:50:55 -0500
Received: by mail-oi1-f174.google.com with SMTP id i6so6976811oia.6
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 00:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxInqpUY0tzTENRt7OklcR13FU/hUxoCdecuPFE5K9I=;
        b=tRkx3KH09nO4V2CAldr9aEP6RD3q3w05H+b8g6JuPE8+JR8CEMk64ci+N6Q8DbAwnb
         x36mqdf+M1qYuZxbqRzaKx7SQJs2sio99jlmpDvvmQ8mv0smXX4F3evlKUv3oqP/GphZ
         mPk9F/6VivSsniDRlHe6ILhCXC9ZIbH1y7hq6PNFUYnjW1r1iaSPIFFJo3ZHEL4RqAd6
         CPN3EymhqmFcqxceWWw0PNACt5ixVdzIoHCrAYALqmz/txEL7Y+0fF5sj/lc2xEKTW3A
         7sNLtN6cVorliGx0XxIALxZMH2fBCHQREgKBe7FpoZOOu/wXpQp96ZBVeryZNneSJXxQ
         W+yA==
X-Gm-Message-State: AGRZ1gL0/otNHV/eL9a7V2zetYTxGfwpFBMOx86lXDtcCyjo3u0etVdM
        iQPHNBrC7MkIqvqGm7PkvaZhu0YVJ9Ztb5WcKeMHaQ==
X-Google-Smtp-Source: AJdET5darKZhyZ35FybUFkCiBgNYl0Dq+wRJNqNA3nod7GDZeJmP4MnP8R9eck5Fay+y1tsv1bMmm5C5XvEf77jSgAg=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr16608642oix.246.1543308824219;
 Tue, 27 Nov 2018 00:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au>
In-Reply-To: <20181127115246.00967523@canb.auug.org.au>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Nov 2018 09:53:32 +0100
Message-ID: <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 1:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Paul,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   security/selinux/hooks.c
>
> between commit:
>
>   0472421f47a9 ("vfs: Remove unused code after filesystem context changes")
>
> from the vfs tree and commit:
>
>   2cbdcb882f97 ("selinux: always allow mounting submounts")
>
> from the selinux tree.
>
> I fixed it up (the former removed the function updated by the latter -
> I am not sure if there are further changes necessary) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Hm... seems that there was some massive overhaul in the VFS code right
at the wrong moment... There are new hooks for mounting now and the
code that our commit changes is now here:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131

It seems that the logic is still the same, just now our patch (or the
VFS one) needs to be updated to change the above line as such
(untested pseudo-patch):

- if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
+ if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))

Thanks for the heads up, Stephen!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
