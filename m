Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962EC433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiDDVzA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386961AbiDDVjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 17:39:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592F2E08E
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 14:31:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f18so7621284edc.5
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRcZB8T+tRRvFOzVRsj0VObje4ZdujR2wKTrNI4xIok=;
        b=hsD17ZhZPYA/avCD0h1vXFG7B7yZz84BKtCbO8kiVz5w2oprqPIvnlTCQ4LOvKZ6CE
         iriKUQW2xItiF4ysOoQp9S91s7xpdBCWJhzchh/YURfwZl3Dg+BtBS4ibggRXxjtQeWU
         o8EX+2iuF0APkj67lTb5CeTn2A0TU7pPaGByvS/nIbTRKL/rLeMMn5XDcy2ldzZlREJ+
         0NY7/AN/3ns3nyPwYtXOr8EoiZLrKF/BGego+W6BXSIv5UK2fBppBjCbl2C4VJ75Frnc
         zL9947cmBn3WplbZY4cvN7kEGWORtywrJCvURz7WAsW6ChRRUeHHjDMDtL1LrfTAl64q
         CO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRcZB8T+tRRvFOzVRsj0VObje4ZdujR2wKTrNI4xIok=;
        b=4LfsJtMHhRO4luKy2n+G5Szp21fBD0HL1W9Qx88E6kBJlnxrjK7VTCl3uKz++ieRnf
         w5n5Q5GdwV7WntUvJZrgObfsnVx/AKz0wtAFgcyiK619rvyxLFKvNw+35B7Gi2GLqfS3
         z6G5r1gYIMZy+n5xlfTnaNLM9RRsKZiDaFW78ujpd00fTMNdq+gaQOliZQhPOIf0yy6L
         XZnOJ9uHkzko2yJG6Xj3QvLV7oNp+vt9qYrsmfL+q3XCLc+iT4V0w3PlXRDmVJBLqnI3
         EdQTxCoqh8T6lWR2mATBpAFqZw+K95yMFJxXQpNw8yIyzSUHmzrHFEVCenBtQaL+HGNa
         0Pmw==
X-Gm-Message-State: AOAM532hH7/33/F54imSSTp9J7Ym5pGGOAxwS1b+NtCkldjV/EUzV+r+
        9/TDeq7w0FPddHKtMIHyoqCxULnJ7OyW8En30qYAWl+vZw==
X-Google-Smtp-Source: ABdhPJxwTGeVhHQskn68X0MscJhQV5E5HZ9DPgFZ9S4Aps9Sxms8FnJq5vu6/dwYCWomacd4gEl6Wo7iCCFFFmQaRwk=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr176933edc.232.1649107878721; Mon, 04
 Apr 2022 14:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105250.148231-1-dominick.grift@defensec.nl> <20220321115054.150336-1-dominick.grift@defensec.nl>
In-Reply-To: <20220321115054.150336-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 17:31:07 -0400
Message-ID: <CAHC9VhT9mUov8M8D=7Hqu-M4-NZ20uq_ptTPmHt2uka2c3w7kw@mail.gmail.com>
Subject: Re: [PATCH v2] optional statement is not valid in if and require statement
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 21, 2022 at 7:52 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> the conditional-policy-statements chapter describes which statements
> are allowed in if statements and optional is not one of them
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: adjusts kernel_policy_language.md as well
>
>  src/kernel_policy_language.md    | 2 +-
>  src/modular_policy_statements.md | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged, thanks!

-- 
paul-moore.com
