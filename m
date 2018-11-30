Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD37BC04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C020867
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886C020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeLAC1Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:27:24 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46744 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLAC1Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 21:27:24 -0500
Received: by mail-ot1-f54.google.com with SMTP id w25so5356070otm.13
        for <selinux@vger.kernel.org>; Fri, 30 Nov 2018 07:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slV8PhzvAtEfBot7/3wlK8g5SHf8xI2j9ZQl+SLSs2c=;
        b=P4lfqz7OHpOQBw+Ar2gXxiWqgYGxFKps90KRapzZwLnZdZU3WEnWOAqRW67BXXbIQo
         pVN8DDS0Gxs/73jUWB410jnVWrwHSOef3VnGWH6cZSalCSu7mqtKL2BfsFoKRSltyMir
         QIFcTUXuTetDEUJq+nCUeae0MDUH/docAdvdDN/Xk8iA6hMso1AGA5LMZqlgsAYxW8o4
         1pB6697EZWK7MYAo4KVItso6Zwwb1hxSja5vf6L7jEr+sLj2KxbM4uY/B2VqxzeFnOAS
         /DUZCLIW3weeNCU/i7lYo7joYdzfy273PfTIPdB7SrsCL5qfKI0qnN3NTGtbeWz2X49O
         7Blw==
X-Gm-Message-State: AA+aEWZe+NdaVGXNwJA08SnR3VNkj3PPlpsZKhCqt58Wcp+wMz1hjgHy
        3o8x5wSz8f8hqYMMctuJmUTJyykgOVRToOQVdWSw8A==
X-Google-Smtp-Source: AFSGD/VpdsAfFGsaM+INxJh7z6+OOpoBWg3N+t10M7K5Pp71GtgQNHYrgWr6OuBEnttZTNA7rKlYYaWKwY6nKCSgCFU=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr3589540otk.144.1543591064221;
 Fri, 30 Nov 2018 07:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <11581.1543590618@warthog.procyon.org.uk>
In-Reply-To: <11581.1543590618@warthog.procyon.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 30 Nov 2018 16:17:33 +0100
Message-ID: <CAFqZXNvGwH4rjdTUsiDjScxV5bkPq=gHs4w3TF-cPMBcun1U_A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 30, 2018 at 4:10 PM David Howells <dhowells@redhat.com> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> > - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> > + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
>
> It's not a bitmask, so you can't do that.  You'd need to do:
>
>         if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT ||
>             fc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
>
> or use a switch.

Damn, you're right... I should have noticed that there is '==' instead of '&' :/

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
