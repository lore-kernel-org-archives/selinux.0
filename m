Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA68C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 04:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4735B20786
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 04:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azFK3jdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgHTEyY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTEyW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 00:54:22 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA6C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 21:54:22 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a1so503412vsp.4
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5fnoIw/HtIS+1PMeDAQs4rLe2MrYpu0dyGew2ajk+s=;
        b=azFK3jdFq2IQyGmFHG9Z4pZXFZpDDZlfy9j60Bqz2Wy8ZwcbXy0OilyaXRvh2KNz6j
         MIuUvqpCPm+T7U3/VK738MJSofm7WfKBo/7VoYOecsvFJsjGV241tuG06ldIkWWCdg55
         FTDAi+wsw5nYcOLR2oLpnplKYjim4h4p79HVVSMn6cfPbmL5+NfdJHSVAnW4bjrhoICV
         1zDwZ9TNLz7rZufBhm3R8HChAkiNOqaktNQnPfkA7+GFwR1PrfYOWod2UZ9FQx9fRCGV
         gqGUEuR8UnwfOHVUUkq6ADuAAngW4yx2NKmtWhCVZE6US3vDAj3kDe6SwVqKehh/j5BX
         ngIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5fnoIw/HtIS+1PMeDAQs4rLe2MrYpu0dyGew2ajk+s=;
        b=US/7z6V6ozUg7aswWbLaBKUdSPGBNmSPuRQ0Ucn0kalv2IoqKdAlaU6LwOYNknQRYI
         +5zn78czY8yiByreXDIsMkgJTjjAEyFpXDF8Q7XJ/putK+vpt74qVambfYRcQnAUuEpF
         4Na5BX71j0RLNEeyxdOwBMb3fHqXgJJIcB50eZUwmneYmyfE0Z0adpQWuTH89Wb/miep
         l/fA7iqC4VHGV0mYFqnQrqRVKDxfk/5v/drUJMjkbbysy+Al4PQkVqm9KcZHY5SYsrVj
         jtf0A/T4OrXm9mi1Ar02PTNpOc2IcK6XHM4god+nShKdbHJNRrCy6wZSfLOgmxb8ahvK
         RBxQ==
X-Gm-Message-State: AOAM530jXa9aGQ3n1Ww5XQW35DIuc/9lZeYhd6NUsHEaeVGPHJqoiqBD
        4zym82jh0kchXsVBn2zLAOx3exy+mWaO3/rtn93Eo7tK4m1w2tc6
X-Google-Smtp-Source: ABdhPJxJXW/SnMjp8FUHupA1xd3l3wrG/HB4OlMfzIxyKL5Pv9tYOD/+CDNsD9QFWUXTNlCvGXiy7eQi45DNcKlCdjg=
X-Received: by 2002:a67:e45:: with SMTP id 66mr864761vso.191.1597899261430;
 Wed, 19 Aug 2020 21:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 10:24:10 +0530
Message-ID: <CA+G9fYu9ZH2H3Ey---OJU1__5RNDAat3=ZOW6=PVViJ3tRD1RQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid dereferencing the policy prior to initialization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 19 Aug 2020 at 19:15, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Certain SELinux security server functions (e.g. security_port_sid,
> called during bind) were not explicitly testing to see if SELinux
> has been initialized (i.e. initial policy loaded) and handling
> the no-policy-loaded case.  In the past this happened to work
> because the policydb was statically allocated and could always
> be accessed, but with the recent encapsulation of policy state
> and conversion to dynamic allocation, we can no longer access
> the policy state prior to initialization.  Add a test of
> !selinux_initialized(state) to all of the exported functions that
> were missing them and handle appropriately.
>
> Fixes: 461698026ffa ("selinux: encapsulate policy state, refactor policy load")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

The reported problem has been solved after applying this patch on top
of Linux next 20200819 tag.

Test log,
https://lkft.validation.linaro.org/scheduler/job/1687070#L317

- Naresh
