Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA0C33CB6
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 09:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE04207E0
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 09:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOV5qnC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgAPJAu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:00:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725973AbgAPJAu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 04:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579165249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnPy8mcsaf04qiEz2VYIGdPmxKUaVVmknmwnIu8afHI=;
        b=dOV5qnC8k+r50SanWYZVNyOOZJ1hnijz3IEXZiVMJtgXUZvEucjmNwTjyFzt7g/5SPI9cP
        GOgR3EFrYgVEXZumfYX+YJ1JkO/VrAMlH7C4UGLHJTw61pNWD36btSSaAAJdYsR6AMqkg1
        vhagtrYp2AZm+smC+mophJFHXQ3hUu4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-U1oxxu4VM9eQ2StpfBWIUw-1; Thu, 16 Jan 2020 04:00:47 -0500
X-MC-Unique: U1oxxu4VM9eQ2StpfBWIUw-1
Received: by mail-ot1-f69.google.com with SMTP id z13so11249645otp.7
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 01:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnPy8mcsaf04qiEz2VYIGdPmxKUaVVmknmwnIu8afHI=;
        b=s5kkSO8wTomEremh+n/a5xy1Qdapl/HmOgJ3lmsHu5tVq4tBDnnyLozfwfJP34UFk+
         fCM7gEgXSmBecpOA311EgVMRsmcg5tqUOJ/EP+zhzPnQZi/s6uB7visEP9hSRSjoyTbw
         7M/OKYdHOJarA/3MbHX98psBIpFIe+BxQnWZLkCAzoGOjFKQ9A1gz5jSrk6G0yG6MSlR
         2JxVLe6znQ9dZh9MbNX220LBhaNtVpCpQ8pDhT8Y8b7CbkocYdaJaBzmpZrK0kpaAHDG
         Wh/FDQIVGa6vV1PhCuzqIv9IKku6jGgj7ABd0fShpIIL7Rzh36TTvPb6A5YFCDeEWTjU
         bDkA==
X-Gm-Message-State: APjAAAUjYfjuzaOfCinA3crhDsmeMdyhYCHKZOJ6yvfovt25JTntoZEf
        gYmZjVQMNZLYuqRf7yAFyAepv/AdebYTXNkI9nGeoO5IZO84qvHjOMNQqLc4AdLa5coEAwpxuQs
        LnbxUBynkJx7gmv80RTJSgB/533eJwAhRxw==
X-Received: by 2002:aca:f507:: with SMTP id t7mr3363517oih.156.1579165247071;
        Thu, 16 Jan 2020 01:00:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyucSkxLFLtZhdZOjgnSwHT1VQrL/u6sGoShPvG2zC8gok2t4bXO8v8tWC+L64w8dehWy2E2iXAlWGX8tBK2To=
X-Received: by 2002:aca:f507:: with SMTP id t7mr3363410oih.156.1579165244911;
 Thu, 16 Jan 2020 01:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20200114144426.355523-1-richard_c_haines@btinternet.com>
 <20200114144426.355523-2-richard_c_haines@btinternet.com> <4c43a27d-6af6-4be0-611a-9564d898ff06@tycho.nsa.gov>
In-Reply-To: <4c43a27d-6af6-4be0-611a-9564d898ff06@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Jan 2020 10:00:33 +0100
Message-ID: <CAFqZXNsqYzaaOSAuZ=1z3vrgvW8cJ0LKufEpvPdNqmrhXW5yhw@mail.gmail.com>
Subject: Re: [PATCH V5 1/1] selinux-testsuite: Add filesystem tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 15, 2020 at 10:09 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/14/20 9:44 AM, Richard Haines wrote:
> > Test filesystem permissions, setfscreatecon(3), file { quotaon } and
> > changing file context via non and name-based type_transition rules.
> >
> >  From kernels 5.5 filesystem { watch } is also tested.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> This looks good to me and passes travis-ci and testing on Fedora.
> Ondrej, how does it fare on RHEL?

Thanks for asking! Unfortunately the policy fails to build on RHEL-6
due to lack of support for filename-based transitions... That part of
the test needs to be somehow conditioned on $(MOD_POL_VERS) >= 11 and
$(POL_VERS) >= 25. After I removed the two filetrans rules, only the
expected two subtests failed, so the rest seems to be fine.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

