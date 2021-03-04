Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DEC433E6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2C064F69
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCDUZ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCDUZi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 15:25:38 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1BC061574
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 12:24:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hs11so51999210ejc.1
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 12:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPrVi2v6wu0KJ8nmV1Ec2C7k8Xl1Ijz9JOj28MZ3qsY=;
        b=fJGyajwqAwFPpn4/5itHXZawblJMRVhRPNqckaWcwffDzS4KAg/lijZoknJksj6QpB
         /UWWKBnx8Vnpl6F3cXbiS0ixxlJcNmR9SRFceYKCAomNg23nUqxRluw1bHmpYHmp6xdW
         u0RxfUgZ4SVpIXdgSIR7ZUMg6wrVbqgEQcpIp7wONblQIZldbaAHdGOgW0892tPPweiE
         6P5hq0oqW25FAtIMoe2mSj5QJFan6xzlB0kTxT3QglAwvforVcG4dXcpwa85BYgSRquN
         z4suno7EQSVvkkkYDU8mb/ghB+22rs2Oh7+vI8W8xH67Km1SZL/VE54oaARQbuqNOMVh
         CKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPrVi2v6wu0KJ8nmV1Ec2C7k8Xl1Ijz9JOj28MZ3qsY=;
        b=YfHA2t0gt+5503jPKMz6vWiXIFGoD8xPXE6QkrzpY97HI/cEjLR5Wz9WKiOAAr6AQC
         gGy8hCjfwdjys39t0VRlsQ+lIQzx7HYZJo5Ya3ewx0j5VBVvFqEYPwu4C5FDI7JcAAIn
         u+0dYW0C52bMUGc4IWHfVgSkDk938dsqIr/FA7NJvFYE5o35sFBBZmGd9OrnjT26X2KA
         iW+YyrowdfaAvVxSjXZb/bmkKp3BzX+Cay0MgL1NWrYMIJQwN0aNN6RURUJmlvB0DvsU
         L5l+4PwCQWKwk2zAsjEtrAYk/Vcol2TXHaxcut/XaBJFKVSAqUD+gWhI4BLQPDsgh+wu
         MXig==
X-Gm-Message-State: AOAM533RPmbNuOvtQbYym99YEXrmFgh6KrF8lljY0EqnFYJVkR24VmmP
        K7HithDsHOfjHxgXwKfWWez8ijH2Uuo0h9kwaARfSwp+w9d8
X-Google-Smtp-Source: ABdhPJwyC47x9XDCbxGuwCaIpVq3rmoPoWmcuCaUeRYMV1t+01UyIHYCqtt/NGSA/QWWAzfpgjTb/EtjiAa/S/MBVaE=
X-Received: by 2002:a17:906:2bd6:: with SMTP id n22mr6197806ejg.91.1614889496670;
 Thu, 04 Mar 2021 12:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20210302172114.443689-1-omosnace@redhat.com> <CAFqZXNs7JsX7GJ8P4OOaQo0LbA6Q+4MQA8YicUBB=9Mf3q3Pww@mail.gmail.com>
In-Reply-To: <CAFqZXNs7JsX7GJ8P4OOaQo0LbA6Q+4MQA8YicUBB=9Mf3q3Pww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 15:24:45 -0500
Message-ID: <CAHC9VhTsfiw+dK08_YJki5uWMxEfCLAKAZXz4ksKuFnYhwYVww@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/3] perf_event: fixes and cleanups
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Mar 2, 2021 at 6:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > See individual patches for details.
> >
> > Ondrej Mosnacek (3):
> >   perf_event: measure CPU 0 rather than CPU 1
> >   perf_event: fix wrong use of perf_event_open(2) API
> >   perf_event: fix CAP_SYS_ADMIN references
> >
> >  tests/perf_event/perf_event.c | 18 +++++++++++-----
> >  tests/perf_event/test         | 39 ++++++++++++++++++++++-------------
> >  2 files changed, 38 insertions(+), 19 deletions(-)
> >
> > --
> > 2.29.2
>
> These are now merged as well, and we have a green CI again \o/  (At
> least in my fork; CI on upstream master is still running.)

Things are looking good on both my x86_64 and aarch64 test systems too - thanks!

-- 
paul moore
www.paul-moore.com
