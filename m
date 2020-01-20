Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA668C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACC421D7E
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoJAwCIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATPkW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:40:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATPkW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 10:40:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so49398wmf.2
        for <selinux@vger.kernel.org>; Mon, 20 Jan 2020 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9Kt0OkXseJWjRPhecsaWYUh+bfSl04VNFwe355ftFQ=;
        b=NoJAwCIPl76HjFGLKWvf0SK6DPvxjxzWfzfkI4ICh5kB8LijtPKwFlnC6RXU2EaAV6
         vKcmzoOBRdtXHOp+8JFQf8SWnTPZwoi9QWB+7r3sSG18TAnSJcu9Cr5V119cyTXR8XJe
         lJv2k2h9b2h6EFJ5ramU1tzvY6IvTHSSMTJAPfciUIGZ31dH8q81oDd2WoCM0KXdX02L
         hPEqC14F7ew/5Z/7Zsj6qF/niAygZnwueTPeBfqPaqFpdK47PIPE70hTiu6xBesgdE5K
         JMZgpvPyr+Q+T8NNSXDFCZVDB0lBM/Huviq1AcESQ6+0lBCJ8yMUlDcEONHtmhroIOAQ
         8zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9Kt0OkXseJWjRPhecsaWYUh+bfSl04VNFwe355ftFQ=;
        b=PRmgAEe3N+MRWCpGS0dVuFT/ur5glWSF5XymqcN+Lt41yOy4IPTtWbZEoCEIjQBAT3
         Tm5ENEFLx+z0LCKxp5SGmHeIjGELp5GsM0shhEwNEXMe9Zjdjj8BPr1e6J7e+TfaHil2
         C94hXXgkolhrXpCyHhnI+OxIls/nqqoF4ogm7SwwpMCUlbBXcslg+7/YPrg8mZLvzsld
         w1ZOdByDRtIqMKrKGO15t/8AxD9P9X1V2kpSMxDdDW9E35E9TFhraRzAysOeu5dgg9sL
         kn7WA2zGKxk9TiVTCPMMBHv9A5ATsHNqSo3iT26ONsGLLuSzySUPxhv2tsuUCp0zod9o
         tvMQ==
X-Gm-Message-State: APjAAAVSptKfpJ89wDuyM7gU5uewbRYlezwj6Hw+vk1SHFlGdRzx1Ao/
        Zj5f1pRR68Onufibxj+tZgoqcj51YhMPbrosULc=
X-Google-Smtp-Source: APXvYqygaQRsZteqJHY8sxiCPvHBmBv3AjgXJZqxQIGV04A9/29U9h6X7/X+CS99vCHPpFv4ZcO86gyvOfMkCj0aS7Q=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr18530608wmb.143.1579534820501;
 Mon, 20 Jan 2020 07:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov> <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
In-Reply-To: <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Mon, 20 Jan 2020 10:40:09 -0500
Message-ID: <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        omosnace@redhat.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 20, 2020 at 7:52 AM Paul Moore <paul@paul-moore.com> wrote:
> This looks good to me too, thanks Stephen.  Because of the nature of
> this fix, I'm going to merge this into next now, even though we are at
> -rc7.  Since we are effectively treating this as another mount
> operation, and reusing the file:mounton permission, I don't believe
> there should be any widespread access denials on existing distros ...
> I assume you've at least tested this on Fedora and everything looked
> okay?

I did basic boot testing plus selinux-testsuite on Fedora without any issues.
I'm not sure that Linux userspace (at least shipped in distros)
besides test/sample programs is using the new system calls yet.
And since anything that performed mounts previously using mount(2)
would have required mounton permission,
I would expect anything converted to use the new system calls would
likewise have that permission already.

> It also looks like the fs tests Richard is working on includes tests
> for the move_mount() so I think we are covered as far as the
> selinux-testsuite is concerned.

Not sure since those tests were just added in the latest version of
his patches and at this point he would
be running on kernels that lack this permission check.
