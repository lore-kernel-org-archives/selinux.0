Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F368FC00A89
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950B620825
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5fPMOwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKEJ5Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgKEJ5P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 04:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604570235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8B9VC+FuZEmflqqpNoC+DV3vii/FWs00ZsCYr2ugNM=;
        b=P5fPMOwV2Ep3XjqnV1BH/lfYO37QRWmxbFghmTKjJYeCOz21rSKn0jMgwDd1vJY8K/5Qt6
        TYzeWm4quHXgxep1haI8znaMGhuQ1uDL4hK9caLV05recvdce2SMEWq5kHfODM1atMRFi2
        v0DtxiSc7VeyPFpjvGzi4+SR4ts2Rdw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-AXTNNzU5Mt6aB6rdq5KAkQ-1; Thu, 05 Nov 2020 04:57:12 -0500
X-MC-Unique: AXTNNzU5Mt6aB6rdq5KAkQ-1
Received: by mail-lj1-f200.google.com with SMTP id s25so216298ljm.4
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 01:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8B9VC+FuZEmflqqpNoC+DV3vii/FWs00ZsCYr2ugNM=;
        b=Rdqnr3SJr20pk8dCQa3PNUTbK61SDq5rVbl5xL1fOXIOJInaFJiY1EqcXFXoaYcz3Q
         Ak0H8iX7ZLRKJpnEj0/WxWGKy63kYc5bE2XkJ9toRJ0a1qa39NddEoutepjnMuqIYy9t
         ctQ3a3zp0RAC2i+81QbAI1GkJ2Uh44z2BUWWuzpierj4Cp6uPjAlqTudsqwb5cWETbsC
         rbuBw5QAPlHQ4rEc3i+yaYIQFDkPcFw9APfJqEmkITf56sg7EWyjwm4v6F66lYtPa1WN
         SMRGSUZnhYzn9HAsUJiaJiTNifJ3yZj/JZd8lq3VVYJeyQOFhKP4WnCDKv2LOXeoDIcm
         QXyA==
X-Gm-Message-State: AOAM530f2HaFNnDrT8K+dRsPid57vuYRnzkRYjwXbYC5T0J3u3oWJJQq
        /tEa7EFcUHsOV6+FnAS9+84LjPD4GvkAoVtjpT/IUXg5Z85l/wdUzVBGbKyGn3jXBshW5QULF6g
        ccs/9lrSvrzj+lA/dVTBvMPbEtsUwO3B9Rw==
X-Received: by 2002:a19:f605:: with SMTP id x5mr650448lfe.39.1604570230430;
        Thu, 05 Nov 2020 01:57:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZGSs74DS7DsqlVUNkrYMHRcKvBmzOhyoC+lWmYSWruhT6Q/ZA2eReJt8lKOK/kzzLD4frjNMhVDhCZFfNXHo=
X-Received: by 2002:a19:f605:: with SMTP id x5mr650441lfe.39.1604570230185;
 Thu, 05 Nov 2020 01:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20201104164913.11536-1-richard_c_haines@btinternet.com> <20201104164913.11536-2-richard_c_haines@btinternet.com>
In-Reply-To: <20201104164913.11536-2-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 10:56:59 +0100
Message-ID: <CAFqZXNvYBYUp3u3YtSAOMKFqdL_e+O=hPTQhPJnRdeyYq_k0ww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Reduce sctp test runtime
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 5:49 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Use the Linux audit services to look for specific events and trigger
> the correct test exit code.
>
> This is useful for tests that fail on a socket timeout where they
> hang around for x seconds before exiting. The audit service will detect
> the event as it occurred based on AVC entry scontext= and optionally, a
> regex (e.g. "denied.*\\{ recv \\}") entry.

I have mixed feelings about this approach, because then the tests
won't be able to detect a bug where an audit record would be produced,
but the message would be delivered anyway (a few moments later). OTOH
the massive speedup is very tempting... :)

One possible alternative could be to calibrate how long it takes
between sending and receiving an SCTP message on the given system at
the beginning of the test, multiply the max value by some factor (1.5?
2?), and use it as the timeout. But then this wouldn't help in cases
where the latency just spikes very high occasionally... (which I think
is what happens in cases of the random failures we have been seeing
sometimes)

Another option would be to run the tests asynchronously, but that
comes with its own set of problems...

Paul, Stephen, any thoughts?

>
> Without this patch sctp tests take ~2.6 min, with patch ~4 secs.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  README.md                              |  5 +-
>  policy/test_sctp.te                    |  1 +
>  tests/sctp/Makefile                    |  2 +-
>  tests/sctp/sctp_asconf_params_client.c | 51 ++++++++++++-
>  tests/sctp/sctp_client.c               | 52 ++++++++++++--
>  tests/sctp/sctp_common.c               | 99 ++++++++++++++++++++++++++
>  tests/sctp/sctp_common.h               | 11 +++
>  tests/sctp/test                        | 50 ++++++-------
>  travis-ci/run-testsuite.sh             |  1 +
>  9 files changed, 237 insertions(+), 35 deletions(-)
[...]

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

