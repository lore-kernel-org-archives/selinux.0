Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E56EC32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiHWUKm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiHWUKO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 16:10:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CC7C336
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 12:29:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o204so9697595oia.12
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5TZjaWzFLrGXu+eeovPu9lOyvajfWISzWjvFXLvunNw=;
        b=VeF6TtVgO7WVIlBeQUGJEjPbkW8gKFQHareiFBrUAvd+B1oBlsbxwX4tOi1eC76Hmw
         /flQwny+KF2mIR6Bh+sR7wGcqteLNjhMlAmR9GgHErwRFm+ccEbyr1P5p6xN1NVQ5iZ7
         wLqsLAt2HZQJloOR6wVNwbev4xX7AAz8EPtEWR1PGD3NGNWbv21Pbp9mCRLLQnRM0jUH
         WElsZkNJ8PtDEUCj2mpKRMUZWLuyAhREdbYvZmDm1AP1z+jSwomWDfFEe5/Lzg8pyzxu
         3sm1PEHKaR8h6GXV6Se5Iy2buykfE4Y3YDj4SoSDJvHzUfKdyOUFN1AWGYLGjN32ZaSx
         cZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5TZjaWzFLrGXu+eeovPu9lOyvajfWISzWjvFXLvunNw=;
        b=QJq5Kco7BSlFFaY2XWxEMk/IW9SLCPCcC0o2lthxviPOwZibmPUWX1tfGPUHFEP6sb
         TxhTvF0cp2OEcy1p2a+vOxPT6gAj7ZmHXK0l6WLi7X2pyyONvv+ypdr8tvA3CLDqGHgC
         sbfdS/HkWqy2AuILTfCft+vuNaXfa7uOOIPmtFHE7KSVUtloK5bDmjOJvyhytWH9HNAq
         zDIbiCsGNBfwOqOEa0jlryfeg3eiuoXNm0yluOhM4nHfmWC90rMsENifOWPS+RD9IrWc
         hgLdaay7kLuN8EsHv1A+TppiZfwT9UyBm3hSxQMvHUsZ1p3tvDymVE55Y7C9QyXsPN6s
         n38g==
X-Gm-Message-State: ACgBeo3mnMfVR6tNHv/wQCw45oGFxaEck+B1bVKxV4y2zDWUgy+Je07t
        Veo8Lm4lH6MA9SWqu0j1OiOxkLp3GFvVhRB6VyM5wu4vog==
X-Google-Smtp-Source: AA6agR6w3gQVancqIvrRF20KCsE9Xp8HwTNdo1/itUoK7iEZdEU6VgJfBaeOnqH9C0QDcI3FBofxxO51ugCLHODEvng=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr1959840oif.136.1661282973294; Tue, 23
 Aug 2022 12:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <166008319941.447963.8509896484646848800.stgit@olly> <CAFqZXNsdUtSXEsuPcGShw3deuZW8mWF8GFGX9gJ8d9Wtfd5vXQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsdUtSXEsuPcGShw3deuZW8mWF8GFGX9gJ8d9Wtfd5vXQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 15:29:22 -0400
Message-ID: <CAHC9VhTTpMpPDP+Qe84Kx8C8Uke7dn3WoUpT7ET555544eo06g@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: allow both ENOSPC and EINPROGRESS for CIPSO
 tag space errors
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 23, 2022 at 11:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:
> > If the NetLabel subsystem in the kernel is configured to apply CIPSO
> > packet labels directly to the packets instead of the sockets, the
> > kernel will return EINPROGRESS on a failed connect(2) instead of
> > ENOSPC.  This is due to differences in how the CIPSO labels are
> > applied to network traffic in the two cases and how the error
> > conditions are able to be propagated back to userspace.
> >
> > This patch allows both error codes to the relevant SCTP test cases.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  tests/sctp/test |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)

...

> This patch makes sense regardless of the pending kernel fixes, so I
> applied it now:
> https://github.com/SELinuxProject/selinux-testsuite/commit/c04b5bb4bdcf894a6de6afa0e7e24911dee8dcbf

Agreed, thanks Ondrej.

-- 
paul-moore.com
