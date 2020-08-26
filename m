Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EFC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D8B2080C
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9r2Jt4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgHZMuA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgHZMt7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:49:59 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59725C061574;
        Wed, 26 Aug 2020 05:49:59 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u24so1380112oic.7;
        Wed, 26 Aug 2020 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T25WQv3ojJsvp0cUA7/bFzow+dOFqG8TcJqudwPS8Ck=;
        b=M9r2Jt4MOONXPJmGuvp2bXRT5rYmoi/jifgzU/DP+1hL/xMrn0eQbwBxkSrnwxDcyk
         5vqeBnTSsYKYnMjtxkOxmA6fjvZ2cxr54/rUVbjtvGWmrDnEcfSRxcFjHLN3A78rGPcp
         DtFfObU6K50X3Z+P09n64wZP8ruDrQL0ZfuMc1at40685Bth/e4My2gZRlff24tzd2+b
         mPLbYdHr+WOLGkwhso5X8hev6VAN1/WqJah+nLXAYhjX9R/r/twoKfFAZoVl2x98n+Dg
         s0s6+4hIVqwcgmRD2cC4ov749QBgGBhBPyXXzKEUiNTkreRvxy0vI/33P7csKTp+Bhik
         L0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T25WQv3ojJsvp0cUA7/bFzow+dOFqG8TcJqudwPS8Ck=;
        b=QsVFk9G8p519YbbLS2oVpKYvJ0Uq+BMFl9nK44wCkrkqByCsOdR7uO5aU8vNrvC9EV
         bS1zPvSI8gquObTbaGFhCizYOSk4LLjME57PJKDLEQbx3+C2CJz6YcWFTrHKarg/v240
         G62bxWqQ2PXb2dGqOVZ1U8caf1C7q7F6VPnEyLBxexCykcNNsrt9oLCFvnlOk2wkOnrX
         tGjNcSA9MCzDfbhYdmjtoNxutZUBmaSRv3Q4xeVsHV9uDxr38WEOLOsB1Mqfgua8iiXM
         3Z0mWMiZkc1guxqr+sNCfQ2yo2Ms268EDxTKp0TvboQg3mLSipI+Fr88yWztJnYikCA+
         BNZA==
X-Gm-Message-State: AOAM530jqLlOOf7PQBLXVr4b96Mzq2LzqzxiDqXSGd02YBXqOMIIlhBj
        MeRP4rSx+Xgeio3tsFkcvZG4qeV7snTSI8uARxxZwynZQWU=
X-Google-Smtp-Source: ABdhPJybYUo1ib0fZd0hbVAde7TS9TC8SAeT3Hi8Qkmqusc201zL7JCl2TYxmJF5UZlccaKgd/MqSubCExC3h/hxT8g=
X-Received: by 2002:a05:6808:310:: with SMTP id i16mr2879397oie.160.1598446198754;
 Wed, 26 Aug 2020 05:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200826113148.GA393664@mwanda>
In-Reply-To: <20200826113148.GA393664@mwanda>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 08:49:47 -0400
Message-ID: <CAEjxPJ45hfBr6S1jT3iSOcSiccfWWFcqJC-q9R5qbRndT_DNCA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix error handling bugs in security_load_policy()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 7:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There are a few bugs in the error handling for security_load_policy().
>
> 1) If the newpolicy->sidtab allocation fails then it leads to a NULL
>    dereference.  Also the error code was not set to -ENOMEM on that
>    path.
> 2) If policydb_read() failed then we call policydb_destroy() twice
>    which meands we call kvfree(p->sym_val_to_name[i]) twice.
> 3) If policydb_load_isids() failed then we call sidtab_destroy() twice
>    and that results in a double free in the sidtab_destroy_tree()
>    function because entry.ptr_inner and entry.ptr_leaf are not set to
>    NULL.
>
> One thing that makes this code nice to deal with is that none of the
> functions return partially allocated data.  In other words, the
> policydb_read() either allocates everything successfully or it frees
> all the data it allocates.  It never returns a mix of allocated and
> not allocated data.
>
> I re-wrote this to only free the successfully allocated data which
> avoids the double frees.  I also re-ordered selinux_policy_free() so
> it's in the reverse order of the allocation function.
>
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I guess this wasn't against current selinux next branch?

patching file security/selinux/ss/services.c
Hunk #1 succeeded at 2145 (offset 18 lines).
Hunk #2 succeeded at 2263 (offset 39 lines).
Hunk #3 succeeded at 2303 with fuzz 1 (offset 47 lines).
Hunk #4 succeeded at 2323 (offset 42 lines).

But otherwise it looked good to me.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
