Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7CFC433EF
	for <selinux@archiver.kernel.org>; Fri, 21 Jan 2022 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380585AbiAUNWP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:22:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233333AbiAUNWN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jan 2022 08:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642771332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3dFKG2R/ESGkmz4vIgT7IkeQd1FRp+76f5JU8Ltz7yo=;
        b=MZfue3Pke8HjxmJaSHmkZsVw/NWDqLqbtF3tFjnjVlxCquP7NA4QC+dwIFvK6Pr5j6R6vd
        xCha7bNXyFlW4qJPZeaQOEN+8nyJgc95vqAxChIar9ma/KzWU02K+WmgOlnCUfrjIxuhpg
        /9ge2ZtugAo3d7SySo0u2VjOI/d/ZAU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-menYTLXNNnqT-XFEI5SeBA-1; Fri, 21 Jan 2022 08:22:11 -0500
X-MC-Unique: menYTLXNNnqT-XFEI5SeBA-1
Received: by mail-yb1-f199.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso3792535ybg.15
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 05:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dFKG2R/ESGkmz4vIgT7IkeQd1FRp+76f5JU8Ltz7yo=;
        b=0EcWqwbtoahDVBwT00a+gevku4o4CFcK68qHDW3/0/DGViCHEip/Idd1kDvRDtN71T
         iTyCOpzqIV8uusiyZqCRGM5ytkbrHiiIo7IfGj/FtkjmOr3Q7Jg/YIEEV3PaYBvalhVq
         kNuDCGIkkXkKY7oIKo8vPuvd+K22hOhofOXZyqJQ6jpk7aUdoAVAuPJOR3uCmNypdW6I
         G65H76I/5oo+Tr3zRLCrX/cTjReCEayCGOm4JCmmcGVMg5U0fJky+H/QMT8l6Peq+ha2
         nPaRkmvEYvfEP4dTXEH1cG/2drkU5aA/uPs6VQ9AwGaxBxR5W0ai5FSraECuF2mxPj4Y
         VawA==
X-Gm-Message-State: AOAM532ZL0mMk4x5Bh3L9qKJ25UA/uFGZdnf3Pwd1qTl7Cb/q3S8iioS
        auiD6idp0aB6quu+RC14kcrJY34A9r6ZmQefWYBD2ozZ0JGX+edMywW3Ixp7GClz3kgLsnvmpFS
        ckDwDj8QrQw8aqiJuLEt7m9t5jOBhaWcdrQ==
X-Received: by 2002:a25:3294:: with SMTP id y142mr6417879yby.426.1642771330754;
        Fri, 21 Jan 2022 05:22:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy707OD+LsvbJ5+4Iilq7HHm1VzJ8je0Y7p1qXnciMPQnti6NSLemD+6igaN7y/49kmViuty4HZq0aQr4hys8Q=
X-Received: by 2002:a25:3294:: with SMTP id y142mr6417854yby.426.1642771330551;
 Fri, 21 Jan 2022 05:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-3-omosnace@redhat.com>
 <CAP+JOzSnr2xrZ=2_B2XVVtvb4fiz4dW1JBEhDfKZrjwbjzEA4w@mail.gmail.com>
In-Reply-To: <CAP+JOzSnr2xrZ=2_B2XVVtvb4fiz4dW1JBEhDfKZrjwbjzEA4w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Jan 2022 14:21:59 +0100
Message-ID: <CAFqZXNsw_i_rarut8kciLVKJiOM1e4e6cizpVk8bZSTZEjgdiw@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 2/5] semodule,libsemanage: move module
 hashing into libsemanage
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 20, 2022 at 10:52 PM James Carter <jwcart2@gmail.com> wrote:
> On Thu, Jan 13, 2022 at 6:36 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The main goal of this move is to have the SHA-256 implementation under
> > libsemanage, since upcoming patches will make use of SHA-256 for a
> > different (but similar) purpose in libsemanage. Having the hashing code
> > in libsemanage will reduce code duplication and allow for easier hash
> > algorithm upgrade in the future.
> >
> > Note that libselinux currently also contains a hash function
> > implementation (for yet another different purpose). This patch doesn't
> > make any effort to address that duplicity yet.
> >
> > The changes here are only refactoring, no functional change is done
> > here. A new libsemanage API function semanage_module_compute_checksum()
> > is provided and semodule is made to use it for implementing its
> > hash_module_data() function.
> >
> > Note that the API function also returns a string representation of the
> > hash algorithm used, which is currently unused by semodule. The intent
> > is to avoid ambiguity and potential collisions when the algorithm is
> > potentially changed in the future. I could add the hash algorithm to the
> > semodule output, but doing so might break tools parsing the exisiting
> > format. (RFC: Should I change it anyway?)
> >
>
> So that it would be a part of the hash string returned by
> hash_module_data() in semodule.c?

Yes. I imagine something like
"sha256:0123456789abcfdef0123456789abcfdef0123456789abcfdef0123456789abcfdef"
as used in the checksum file for the module changes detection.

> I would want to hear from people who use the hashes before I would
> want to change anything.

Yep, I guess this is mainly a question for Petr, who was in contact
with the team requesting this feature. Petr?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

