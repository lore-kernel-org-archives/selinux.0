Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD31CC43334
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 12:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiGSMCP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiGSMBj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 08:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2813546DAA
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658231921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=De98tKfoGZkgTvxJ1luQwLffukzQTqu11TKaXTsayHo=;
        b=NqFTIEFKToiRFOIaonzqPAfriErKRO9Mv7aeZwOK7ivKF0zpAy01eSj5gXKSOm3waZnjN1
        EO4OaBicbrolnowTnde9scaOucxQaejb4fw1cAfqu3X1V9L3ls0obyXe+6g1ZBYAOeeEn2
        gKHq5G6feqge9YqcAqJjXd+Db/G/CQ8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-wyr2dXYTMoS7NRgLEgjAXg-1; Tue, 19 Jul 2022 07:58:40 -0400
X-MC-Unique: wyr2dXYTMoS7NRgLEgjAXg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-31e62f7b377so2307167b3.17
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 04:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De98tKfoGZkgTvxJ1luQwLffukzQTqu11TKaXTsayHo=;
        b=rpHwQbjiBn6OPO/CtjOzllExfIAyjHboqpamsywgZxw2GentUk2WuhOEjYWoH80imq
         1ye1UrmcQ2K5DbK+dwYIr/JnnGkfYwJPPzJD+upLmjlIhgl5MuLf7FO85vMv4CqlwtRL
         fEiB4QyequyiRM3lJBZw8PiKEKyR1nJC+Irr/kKiF2dteUSYqiF9OceuLCMkVGnafQuG
         0VK6KKjuSO3f4huaxlnaotccxGKDfoU2DSMHxDYiKuNeox3AXz8pWuWlYpmtO+e18byG
         OF7nROceM3Mt5LYh9AhZyqVuBXG37VV32q9iJJd6Ggqhyw6bVrkefgzsH1SyGIXuWFvh
         9pWA==
X-Gm-Message-State: AJIora9QQQmQuNJegUPBBSZEeMf2+MRUINXddxd6/wNUKvoe8idfPfpp
        7CxBYCZJorZ73bVh8/nmKL196eVTJLe2NOepBy6b4J5IPj15r/7KBoGfzjrmLpHEonG0f6xJjil
        sf5SHI4IksLPnpzlnXatongZxL/VC2RgnFA==
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id i4-20020a5b0c84000000b006706c6f4028mr5952894ybq.196.1658231919414;
        Tue, 19 Jul 2022 04:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upNwQNspN7J+puh03LjF18LBNM1JlUDMWV79J7mZ0XDXDATP7cpVk/VizJqYebWPLm7M0U+K1GcoX4Yuhc4IQ=
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id
 i4-20020a5b0c84000000b006706c6f4028mr5952880ybq.196.1658231919247; Tue, 19
 Jul 2022 04:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
In-Reply-To: <165818338297.423746.2325119921845739520.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Jul 2022 13:58:28 +0200
Message-ID: <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> Rework the SCTP tests slightly to remove two assumptions which are
> not always guaranteed to be true (below).  This should have not any
> affect on the current test suite or released kernels, but it will
> help ensure that the test suite continues to work with upcoming
> kernel releases.
>
>  * Do not rely on IP options attached to a socket.  Depending on the
>    kernel configuration, the on-the-wire packet labels may be
>    generated on a per-packet basis as opposed to a per-socket basis.

Could you expand a bit on why this would be a problem? It's not clear
to me how switching to per-packet would break the tests. (Maybe I'm
just not thinking about it hard enough, but ideally the commit message
would explain the problem to me so I don't have to :)

>
>  * Ensure the kernel's SCTP association state is properly reset by
>    restarting the SCTP test server between tests which require it.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/sctp/sctp_client.c         |   22 +-
>  tests/sctp/sctp_common.c         |   42 +++++
>  tests/sctp/sctp_common.h         |    2
>  tests/sctp/sctp_peeloff_client.c |   21 +-
>  tests/sctp/sctp_peeloff_server.c |   20 +-
>  tests/sctp/sctp_server.c         |   28 +--
>  tests/sctp/test                  |  352 ++++++++++++++++++++++++++++----------
>  7 files changed, 332 insertions(+), 155 deletions(-)
[...]


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

