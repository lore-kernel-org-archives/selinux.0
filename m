Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E21C433EF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 02:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F06E611BF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 02:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhKJC4v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhKJC4u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 21:56:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0FC061766
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 18:54:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so4637987edv.1
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 18:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NrMuUd9RVmqho7c99VA37NGVpHVxkPeawl1QbeDoXI=;
        b=2yM4rCWxPInERG+QCyDMHFmNyUNbegR+jId0SiuHkE89Wzr0tDc5okBgTaud2pA4Vi
         7jf3/o3BP9LjeHm3rg+86O/H5jXKKG4MXeLKplYeNfELnniz1pvWsJtdsUkmtJTUCobj
         JtpBoi6CE8VYw1UR2Y6+BT+rp+5zLMDaThwALhgb2tgWTHt0A7mys4pTOJWBvncrnopP
         1Zssorsn+KqbkXrB4WljIaDEkW2h8T8JOFTFfZnsq/eaJ7Vs1vuI1djb2vZdQwHp3dcq
         S3n5t5MhJOrIVxpXuF35A37S6QSUtTud87vs8yLCvd4uE8Pslys0fZJG+vQ9CDkKv30q
         AJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NrMuUd9RVmqho7c99VA37NGVpHVxkPeawl1QbeDoXI=;
        b=j+AEjvczLmLzjJVmR93H8q/HXGeP51jf1klGZyahImZB9REY367DiQXIShWZDAEf+C
         YWy2WIZWbMX68H2O8PgRZ+0vV3zKnu0qUfaNwsNKBtG5xboVuWJ4eVAGSxfnVdADR9V9
         28DjQIiJoD3+uPg19HJBtWnmY4qCotrkM2EpiD4jq8EroJjKOJOaaOXE+fNSUK8yvvZM
         ZeFzPqnHm39ocZ+A8mdB4KojnxUXjFH0iUpD0HTQiRTal8IfScuJR/VSnjTO2jP6weM8
         PY6O0hC10nM/qz67ODxpADA76NsBYCH2jtCjKIHBUC097lo4bjagXR5MAKDjHMgDZl1J
         +ibQ==
X-Gm-Message-State: AOAM530GqIEF1IPPKwI+j/QuWhSxiUwYmbIDSAthYWzoqVRGxexmOceu
        STSTxcJKSS3jHmb0lAUmyOIcp+yDFqnggPLjimIA
X-Google-Smtp-Source: ABdhPJyMhmWVAj7qXRN69GjcQqzUiWUIxkvFttCjH7BDsjQ4nsZY2Yn556DuYq3kC1SVqhSOraDOadJcoRHPhTuEbs4=
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr17051941edc.93.1636512841577;
 Tue, 09 Nov 2021 18:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20211107142047.32727-1-richard_c_haines@btinternet.com>
 <20211107142047.32727-2-richard_c_haines@btinternet.com> <CAFqZXNvaChb_D4YFK6_WnXYVMZ3ZUpC4p9rDEbztOTa-Tb-znw@mail.gmail.com>
 <74823199cfc693defe0cbaca3623d8245d9454d1.camel@btinternet.com>
In-Reply-To: <74823199cfc693defe0cbaca3623d8245d9454d1.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Nov 2021 21:53:50 -0500
Message-ID: <CAHC9VhSsLenLDXcgK-PSDy6_WOzftoTANDbpaPRQKdUi=D-RPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] testsuite sctp: Add tests for sctp_socket
 transition rules
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 9, 2021 at 5:00 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The only thing I would like to see is that whichever way is
> chosen, it's documented (preferably in Documentation/security/SCTP.rst,
> but to keep Paul full of happiness & light also in the patch
> description).

/me chuckles

It probably wasn't clear in my earlier comments, but yes, I also would
like to see the approach documented under Documentation/, I just
wanted to see something in the git log too.

-- 
paul moore
www.paul-moore.com
