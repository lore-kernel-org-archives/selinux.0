Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541A5C11D35
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 16:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7BB21775
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 16:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upksjd7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgBXQXQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:23:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45173 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXQXQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 11:23:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so9452131oic.12
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IR+2xljMxFjY62hOuVr0Epd+wr6vG4hKFAOf8CypPg=;
        b=Upksjd7FbFdK9yajF16V4mpZlfwiTgc+XqnRzJuiVWZq7OoJ1BOr0g7HxjwvTVgbCU
         NI1ra27xTQghZv5yuFDImzpPJ4jwLSnAgWSABX2quU9bf6rEcZvUds5mLNZ0klrJTtBh
         6oXQ93iYkUpvuIwpa/7T7Z9M89BUpwD4Kmd7tgA/8A8IC2Yvc0hCRo3DEIMH4GTqtQ/V
         124cFc19w4BUMloFiG1A8hH5h6JDhOfzXW4YCzDwoIshwe0LziEENm9AEwUHhW3a6MZW
         pqdUbbl3ULOvjx0aXuafvk8urtLdoBUdHtB6LKFMTKmmqUyuEZd6CPO4lFxGPEKMZtAI
         oq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IR+2xljMxFjY62hOuVr0Epd+wr6vG4hKFAOf8CypPg=;
        b=lAw35E3iagVmmst9pAB1kwf2763RqTzzlAgqz1HRpqpai2T68d5ojjaVsh6vg+SjS0
         Fn8CKnYsuUv35L33ppDSutfhyFZPINWi+jxKVWtQYQXktNCunvfC05lB8u2eyLA8gq/W
         KxtcM57dVk3jlNRZuW0xRvkK+lckZxKErm2GBbIFFs+M/p4fao6dAs+ww77+ACC6eR/d
         gfjrqjN5bwWm138aO0pj+Y/FCAq1mKRovAmUN74oX3ZWx0fH/tEmrB+5zK4s1QDWarLt
         dl9e/qV3fCX6nxjNr6O1cQed195ejh9EclNyNQaBEgpmV6e/xX+tiPfutf99CjLxmvVE
         v38w==
X-Gm-Message-State: APjAAAWok5UtN/ZCf/G7kEk/NCo7WgSR9fLDTXLda6pEsPeXg/BLNSyV
        3WER9ZfgvrlPMcN5glWbwLUfeE4LKWQfKEMJNLQ=
X-Google-Smtp-Source: APXvYqzOblJxwE475m6tLkC4DQbXO4jl4gUsqS/OoP8lLI9amiq/OUV5jSZoSJjfeCfjnDgXLaNdP+L+Lorlh7Zgowc=
X-Received: by 2002:a54:4086:: with SMTP id i6mr13173753oii.65.1582561395740;
 Mon, 24 Feb 2020 08:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200224141524.407114-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Feb 2020 11:24:37 -0500
Message-ID: <CAEjxPJ6PjYs0G8_3jpPHFzte2ex_viPz7ebadPs0WT+P6js=Kg@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 9:15 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> 2) There is an nfs kernel bug where the top-level mounted directory shows
>    up with unlabeled_t initially, then later gets refreshed to a
>    valid context. policy/test_filesystem.te contains allow rules to
>    bypass this as the bug is marked as closed - not fixed.

I don't think you should allow these since it is a bug that should be
fixed (just because they chose to close it without fixing doesn't mean
it isn't a bug).
I think nfs just needs to call nfs_setsecurity() or at least
security_inode_notifysecctx() on the root inode when using native
labeling before it is first used in any call to permission or exposed
to userspace.
