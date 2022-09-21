Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D5C6FA82
	for <selinux@archiver.kernel.org>; Wed, 21 Sep 2022 19:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUTL3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUTL2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Sep 2022 15:11:28 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635E45FAD3
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 12:11:27 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id r136-20020a4a378e000000b004755953bc6cso1039878oor.13
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C6JfGK1tBYgjb4fy17yxr7GLC0kh0NNF0V5iaM+9QGU=;
        b=Ni2c+BqoOXeS3nLSTxnjeIjcIa2qayOkxe0nWKz2o3hNaJ4/dDAy2e/ekHyVdlTRHo
         NJAFT+GSxHgfe60MX7+4dv9rnEFGT/GNpPGh+CZKzvOYgmBu0bThCPZcL4MhjpjAVmHd
         ex/YcmN4jAsk2KLJl6WLOJbMOg/5V+IXwM6YJ6uOnn6fxpOFhDWJBH9CFQ/32jQgNn6N
         7r4T4AemZdTWg0tRbjDEIgeSD08peVGMn6HfqXqhdyZ9OAm7O6sOwoHAVm/A525Hckxk
         VW0Vc/m1CCiED0f23i/Dd2lfqxIZEvWVKvqQCJK+1I2snDJmDLqtxYD8mtzv4dxq3SO1
         crPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C6JfGK1tBYgjb4fy17yxr7GLC0kh0NNF0V5iaM+9QGU=;
        b=cX4BKBf6Jq/7n0bl9SRkAB91jwpApaMHGyFU/3vMkiGhm8sOpdSkSkIXyteBPe1Je7
         R/w89ky2scJyLFMEGpRUym+kstKKBFWB6bijCSJsKqaTP35Dh3TEwL/902YEUreFEePI
         HfzOpps9+aaPzrVcdKbTXupgCP412RWWHLdPuzbRer1xRzsxG29A28QubbN7tG2bEs2n
         hsGq2EZUAs7Kbd5Rmpl1r4Om7KTL3uB+YZgxb5BWUtbfZj0IXzV3D6uftzOnaQw88bgm
         fXoPO0qiO8ZKH/VWMSOyPmxPK5n3VzTHvuUS9WPxNqKjNrv2INelmZO+2NHAbsMEgl5v
         WEiA==
X-Gm-Message-State: ACrzQf15S2hUxQPFQLlY0pd9o8hvodSLsKA8LJBiEv4GQt2B+GWOto5l
        zTm2B34L0K1j1cN2gDSXWcqKjd8gZUfLt5JJtYlI
X-Google-Smtp-Source: AMsMyM61l9THiW+6SygkYyTbi79WLho61206Yyq1f6KpS4f7ypFiMkAPdxN9c6wB5+ow1AG+GzLerVDYl7fO/TDqlqc=
X-Received: by 2002:a4a:ae85:0:b0:44b:4ac7:9e10 with SMTP id
 u5-20020a4aae85000000b0044b4ac79e10mr11108383oon.24.1663787486605; Wed, 21
 Sep 2022 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
In-Reply-To: <20220921185426.1663357-2-jeffxu@chromium.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Sep 2022 15:11:15 -0400
Message-ID: <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     jeffxu@chromium.org
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 21, 2022 at 2:54 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
> mode, it is useful to disable logging from permissive domain, so audit
> log does not get spamed.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
> Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
> Tested-by: Jeff Xu<jeffxu@chromium.org>
> ---
>  security/selinux/Kconfig | 10 ++++++++++
>  security/selinux/avc.c   |  9 +++++++++
>  2 files changed, 19 insertions(+)

I'm sorry, but I can't accept this into the upstream kernel.
Permissive mode, both per-domain and system-wide, is not intended to
be a long term solution.  Permissive mode should really only be used
as a development tool or emergency "hotfix" with the proper solution
being either an adjustment of the existing policy (SELinux policy
booleans, labeling changes, etc.) or the development of a new policy
module which better fits your use case.

-- 
paul-moore.com
