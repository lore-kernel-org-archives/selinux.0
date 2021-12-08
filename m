Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2793FC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhLHUJf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhLHUJ0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:09:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA8C0617A1
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:05:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so12164804edq.7
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyhnCg5Yhn5Q5XF9PilFYLTcYK462QKISfPjPdQPtcM=;
        b=U0jWxNoCj75r5GmeeEiECUx1igwgV4h7j9c3UaUFJWzC6qubCbqmo3HwPOE9WJ1T2c
         T5QBaFrKzJSqt8cbQGxZPKHhsGljbqNqjzC16X4LeorbHbOPQGDoxBu09xN6foHcMz/b
         UFOSRD6pNn0YIGTLZ3CWdVh6TBN8SvvIDLGGc2rzB9IBwze+cAt+x2oYcQGXY3TpLZta
         iy+DkMgcD43S+/dGoWaoVivisgo/FqZTcq6YPBx6qjoDcOqpFeCIZYpqbLKUfJej2Gy3
         2I3wT66JqpcGcjZpvPswjRVlmIyn9MRskRnimVtVtI1REIf8NoH1l2jiaIXI8aHxQCeZ
         ipmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyhnCg5Yhn5Q5XF9PilFYLTcYK462QKISfPjPdQPtcM=;
        b=J8x8ulHJsblaTRUu5LKeyTWAeTOXBkqE7/ADSlgkxOiJRSHIagZpJ+f33YCXm5d8a8
         AoBCWA8yc7N2i6v1FLBsLNqJ7ZU4Y2NFog6nehKZdCFQj7y9ibi2rZOjDhYTVcF4phxo
         zTeHiT609bgjGp6V/P6JxsG7j0KpIunkOoR5EkNEg1Fo6WaDk38o5j30sXSL84JkKkMv
         fHUtf76LQQCtS3hBSSMxvsfjKJxEhIfTw1dEc7f9egBhNg2kwTXab/GdYbQjycR4meUn
         Q1V91CFSujfYSW0q8of5qGFygZvgn91WznLzNymVM6n2qiaSdcHwc9MXSS5I/7mZP/Oc
         ugHQ==
X-Gm-Message-State: AOAM533ATUwHtODRQXFzvVmwNYqNrt9TmoGM0I2OJaObCga0xKEDVTeA
        9g6Y64X22p7Ai6EKiqJCxi+k4Qe1NuACWKhVpnGWLOm2PA==
X-Google-Smtp-Source: ABdhPJzzMN5+BYgBqYCGgnW99i1clv9ENQRXesQseZW3PVms8zCyppue01W/munr48LtxFuf4eKiZ2cvHznfW3wwmB4=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr9765268ejb.104.1638993952368;
 Wed, 08 Dec 2021 12:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-2-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-2-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:05:41 -0500
Message-ID: <CAHC9VhR_B2gc4VcMgvfgfqY4rJ36CN=qkjVs458EDBVkX7hm0Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] notebook: Minor formatting fixes
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/bounds_rules.md                |  2 +-
>  src/class_permission_statements.md |  2 +-
>  src/libselinux_functions.md        | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)

Merged, thanks Richard.

-- 
paul moore
www.paul-moore.com
