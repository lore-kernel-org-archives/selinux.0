Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B66C433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 05:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FBA20771
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 05:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dEX2+30a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgHNFUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNFUq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 01:20:46 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201FC061757
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 22:20:46 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id m200so4570138ybf.10
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg14DGUUTv8H89VUwzRZsbktcbP23wgUdWgjdUjfNQA=;
        b=dEX2+30aTsCAIysXdZvVJFU14uPr90OtNVrO7vOwLZJuVg1Ttkl0JjOa26DSWWRwVg
         RQhMmdjxeyMFgAAr8jTCR/nr0nymCith0gbs8dQEcNH/6YjiuFULZrdElioNOkJDXGli
         DcxQskqpumXcVMzbfls6BcagbkAcAO6FTBBX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg14DGUUTv8H89VUwzRZsbktcbP23wgUdWgjdUjfNQA=;
        b=lu7E975YKCfKjmycnuxPf3Dpv/YA/haOQPUEJHyQHqvoELmtjdNRRxrUVHulCeViI9
         WjXGsyblrJ1cfKVpH+ZdPOVBIQ0bYRKZhBIsyv3BYD6xQjVb/U2DNAL05TP+Gakx22iz
         yw3Edl7ux9mM7xwaNsMNHrk8MdM8w4fNkqZ+s48WBQKUqfHuwkEo6i6VYH+taMHfXuai
         svzokqbOfTVDjnBmlADsYl7YDcCiou1Snaagf7trk9cPem9MnE3yhq21i39EK+kWPX/r
         7rpPIDwi8g7+x2qdHw6wedNFSokmMmggYFqlLtB5esbyUdwMR//la44MsnEnrf7InzAJ
         THWw==
X-Gm-Message-State: AOAM530PIg7G1v/ZkGO3NGGwghRjPFq0mqwGcsgMTBhpShtV10vajHDG
        /avOiSRdvyzU05GXmD41PgVsPUxgrC5JgZ+/d26MbA==
X-Google-Smtp-Source: ABdhPJwigPM0o0HjqNk8MMoz9/OzJtfdk0Bfx2IUg4eJu0bnhsOEMQPPceOziV2L0FeFk2j4jIrWVKN0LZs1bVNNoJU=
X-Received: by 2002:a25:5d7:: with SMTP id 206mr1586353ybf.512.1597382445205;
 Thu, 13 Aug 2020 22:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200722090758.3221812-1-chirantan@chromium.org>
In-Reply-To: <20200722090758.3221812-1-chirantan@chromium.org>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 14 Aug 2020 14:20:33 +0900
Message-ID: <CAJFHJrr+B=xszNvdkmksG5ULPy_nKpn4_MS9_Pnq6ySkkb5y6g@mail.gmail.com>
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 22, 2020 at 6:09 PM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> fuse_init_out struct.  When this flag is set the kernel will append the
> security context for a newly created inode to the request (create,
> mkdir, mknod, and symlink).  The server is responsible for ensuring that
> the inode appears atomically with the requested security context.
>
> For example, if the server is backed by a "real" linux file system then
> it can write the security context value to
> /proc/thread-self/attr/fscreate before making the syscall to create the
> inode.
>

Friendly ping. Will this (and the next patch in the series) be merged into 5.9?

Chirantan


Chirantan
