Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63262C2D0E4
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0481620717
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bahMHd+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKWXrc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgKWXra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Nov 2020 18:47:30 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFEC0613CF
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:47:29 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so25841155ejb.8
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2tH0J5FjG3CWEJAM78SzCWVNgxFS8dPSbJZXIrz8eA=;
        b=bahMHd+33ExZBCoE/oR5FMEwH44L39inSA9W3/K3d6bGAEZkB7v1ob5roD/5eVpdJ0
         R+d0XQDrBNNwKmyj7FajR++y38fX39bQnAMu70cGakDlYcC/tW05dSTKflWZ2uAoQW9m
         2xCdSEgInNLrNTxIFKbecjjgDab/K6ZMjJKwyzFIhhQORgKViMZWnZTGdz20711EZ5ci
         U2ly/ZtfiZq+0PY0skLkv4AYzqD+mof+cpmMKy3FSM3JxLk/gPf8GN2BxGNVXsoFg84t
         6g1MHkNlmtLw9gyrB0EbPGvW8Ijj9ZPRVocIwgwJMvyatG/WkP6v3iQP7tU7LfrtZ+GZ
         47zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2tH0J5FjG3CWEJAM78SzCWVNgxFS8dPSbJZXIrz8eA=;
        b=lOnSdQJ8x1ozraZywtuZXumsB/QNWTJp0qkTozWd1YUfyNi87gHTFSKrQnuQepMn8z
         nkPxkK/aJId/4S1lX4YjTHEVDfUiuZIa/d4EtuPboeqHcgh/lhv1BIMhbETraKGILVki
         uJNvvbW3onMKEwEzsA2GTtUCbJqqkMPInTP7V+FfY3dw2lvEhJNP8PN7+nu/r7WQc8T8
         npgjdp4GeEWHuR+fkHnwYH9+qQciB037ANZaIs+fK+n/uet1qKjDqTAh5y8+KfMKC/S8
         RCk5Xuua/cp9bJAo7sKtYQBV82++XzfWXDCG8YO0GMIczbI5uj8UIcyiFu8LqKgYhpxk
         msFQ==
X-Gm-Message-State: AOAM532e3BAe7bWycyZEZX8+C3DcT0cfPxbtwGQZVk4ns2B3O3wmE7+c
        SQJHGpue10fM6nURbX406+ukudQs5cP2loJ2yhPu
X-Google-Smtp-Source: ABdhPJz1cUzeMfwEdEEYptfkLKXDQKCaDHJLy6k80ocYA5tN4wZuhgjNHiuJKbzQ6wUqWl7pFgW3ifxoIkY/SNwNlKM=
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr1808743ejs.542.1606175248555;
 Mon, 23 Nov 2020 15:47:28 -0800 (PST)
MIME-Version: 1.0
References: <160581265397.2575.2287441525647057669.stgit@sifl> <alpine.LRH.2.21.2011201401570.20132@namei.org>
In-Reply-To: <alpine.LRH.2.21.2011201401570.20132@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 18:47:17 -0500
Message-ID: <CAHC9VhStm9LXL1cG3ATS0Z=EkJSbZ7GPLWfRwb=ZiQMJc2e8qQ@mail.gmail.com>
Subject: Re: [PATCH] lsm,selinux: pass flowi_common instead of flowi to the
 LSM hooks
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 19, 2020 at 10:02 PM James Morris <jmorris@namei.org> wrote:
> On Thu, 19 Nov 2020, Paul Moore wrote:
> > As pointed out by Herbert in a recent related patch, the LSM hooks do
> > not have the necessary address family information to use the flowi
> > struct safely.  As none of the LSMs currently use any of the protocol
> > specific flowi information, replace the flowi pointers with pointers
> > to the address family independent flowi_common struct.
> >
> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Thanks.  Seeing no further comments or objections, and given the
discussion in the previous draft of the patch, I've gone again and
merged this into selinux/next.

-- 
paul moore
www.paul-moore.com
