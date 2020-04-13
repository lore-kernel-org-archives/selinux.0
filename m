Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F30C2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8212063A
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 17:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA8oAYbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgDMRsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:48:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387436AbgDMRsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 13:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586800117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWUTPbYWAoEUYC4XEPobf5xrH8FY2tB9rfmUCEXZteg=;
        b=gA8oAYbCjZmdRXWDhgIyQzuHpzw9GzzsOgXR4NgEZivvhKgdWYfy99I/BZBsP5xXzruzhM
        lzVmadhdGkVSYvzJBapgGfDhVuzq5w9dCsNGmtZEUZaTh/XqpTcIWV5Uso4wX9Ycp2nfqi
        5KfLID92UCV+EOU1N2UK+kQ3S/QVw8Y=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-5jw-dckAMDaY20ZRNl-RqQ-1; Mon, 13 Apr 2020 13:48:32 -0400
X-MC-Unique: 5jw-dckAMDaY20ZRNl-RqQ-1
Received: by mail-oi1-f198.google.com with SMTP id x24so8077878oie.3
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 10:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWUTPbYWAoEUYC4XEPobf5xrH8FY2tB9rfmUCEXZteg=;
        b=LZ8H0pX16DmCG1okU/zU3bextPXzVeIGPgWhvhvVHGVtH8aQg5aTl/k4Dt9inu3oUQ
         BTYe36aujVoZ6xptVa9uHDru+zXZ1SMBf1mfN8Agp+6vQDU+B/thFC2Ol2TH5AQSC8zr
         TCnXrW1W/FNZn0+71AuApHxa4cAKeeuTTP43NkwcRXWLHS+vu0jdMYCztaGEu9PgkOy1
         Vh77ojv7YazX7b4KXpyb6s+Bn+NWE2185V0VbBzN8Hz2E7vcTwtn3XPQOy5lDmmIj27O
         E+GEybBJe1edGlaRbee/1cxdxfA6v2irwsEi8VAA5z28fbafFgCFMQwph8eeuiZLGJvD
         IK4w==
X-Gm-Message-State: AGi0Pub62Piv4IjyRP2onwKRPc9D394ePj4s6spWkmy1cXUBtkJa9LsI
        PoBFe9g4JBRllTxv8G+RFERoBu4nEnQ+erFhsdwWbXiQg+PPhs2rxPaAVwFQgUiZhxtGUiOi3yt
        N69xcAsViwwE3khfrbITgSeCfQKXPwivpcA==
X-Received: by 2002:aca:b104:: with SMTP id a4mr10354674oif.103.1586800111283;
        Mon, 13 Apr 2020 10:48:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpkjPEgWlIr/mM6dltj0iYO34p6ugR7Fh9HIZMa0sINTs+ZysmbG4I/d5ro8ngkSRJtm5bNkxnSVKDwGREY50=
X-Received: by 2002:aca:b104:: with SMTP id a4mr10354663oif.103.1586800111015;
 Mon, 13 Apr 2020 10:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <202004130917.435ED43FDB@keescook>
In-Reply-To: <202004130917.435ED43FDB@keescook>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Apr 2020 19:48:19 +0200
Message-ID: <CAFqZXNtJsrSN22=NtQksOsacC=SkwKB9SLxH4NX-NMa9MUK+Jg@mail.gmail.com>
Subject: Re: Coverity: filename_trans_read_one(): Resource leaks
To:     coverity-bot <keescook@chromium.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 6:18 PM coverity-bot <keescook@chromium.org> wrote:
> Hello!
>
> This is an experimental automated report about issues detected by Coverity
> from a scan of next-20200413 as part of the linux-next weekly scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Tue Feb 18 12:27:34 2020 +0100
>     c3a276111ea2 ("selinux: optimize storage of filename transitions")
>
> Coverity reported the following:
>
> *** CID 1461665:  Resource leaks  (RESOURCE_LEAK)
> /security/selinux/ss/policydb.c: 1862 in filename_trans_read_one()
> 1856                    return rc;
> 1857            len = le32_to_cpu(buf[0]);
> 1858
> 1859            /* path component string */
> 1860            rc = str_read(&name, GFP_KERNEL, fp, len);
> 1861            if (rc)
> vvv     CID 1461665:  Resource leaks  (RESOURCE_LEAK)
> vvv     Variable "name" going out of scope leaks the storage it points to.
> 1862                    return rc;
> 1863
> 1864            rc = next_entry(buf, fp, sizeof(u32) * 4);
> 1865            if (rc)
> 1866                    goto out;
> 1867

Right, I missed the fact that str_read() may give us back an allocated
pointer even if it returns an error. I'll send a fix probably
tomorrow. And I plan to have a look at refactoring the function so it
cleans up upon error on its own (+ updating the caller accordingly).
Its current interface just begs for trouble...

Thank you for running the bot, Kees! It's cool :)

>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1461665 ("Resource leaks")
> Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
>
> Thanks for your attention!
>
> --
> Coverity-bot
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

