Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB618C001E0
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGRWBo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGRWBi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914621BCB
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40388dc19ecso853051cf.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717681; x=1692309681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jPmFRD6HAvOvApo7bLEAbR/mPngPunSQTE6IrY5h7mc=;
        b=T+N3DepxpqqALJTBpS9PpizBAQqOUm3EiHM7GmQfzH0kNCCAe8JTwjULvwwLu3qN+X
         AXl9JxXSRdyV5tz4nPRngAURXKRGpdf9+/NJeATKpeNb+ujHJoRuPoz5dDkZ9WHA3H5p
         iE07Q7YneDwJ2i9MWJU0EesoOaWNU/YP0yN9Pou93eJllcP7XHzZRsdfbQC774DLLJPD
         jIcjyIGC/VMdwGh9vNwJ3YLBRcsM+uJWfgQe5iUKLv/otjhi7Rado5E2QQ1AAgvqXjFX
         GjpHZRixe0OyFOEsiAs75DR3iK0YdBX4/YPSGO+bZ+640Wi8inRos/zwkM6qD3QiD+ZD
         D/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717681; x=1692309681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPmFRD6HAvOvApo7bLEAbR/mPngPunSQTE6IrY5h7mc=;
        b=HIanxeBZfxj+LvyztK0EK/e9yy8hObFnBLBcLovrqqVLyxdhgQLfUHdgqMFK1Ktn0F
         OON/7lnaZt8+aFzxqujEYqQIsdmjn8UiGyZ1H8B7bnwU6lFmv/zHAryNEjhN8DOVui9D
         DJ2Wq+YTi88fm4tLFlKzdrJhLcHeW2+ozcmiBpVsXrpaWche5zwvPkKghtI4JhCu7nRP
         daZnX4u9dNz+69vlQ3CbxouZ+bb9KFi4o37Vwr2DK+eyRwq7n39KZApJrcg4vmPy1Bdo
         ZSSKQaARR2qIwpU1i2yfS8wxV/kHuXUkhjYR3t1J9Bo30BXV/HhDzfY5PK3C6b6EaK0t
         3a0g==
X-Gm-Message-State: ABy/qLbAKcKujtt1WpsR1PCgsQX1oAW3yusBWRMZdB8HNMhej9Rpsr8R
        VEH6IoZSI88peCon0ryBW8qx
X-Google-Smtp-Source: APBJJlFdK8Q1TtqIq+sJcPmUgNNd9z5p+54MhqsfYo5ixQmX2vMA44Se9JK9TfbtSMwVEgzASve0wA==
X-Received: by 2002:a05:622a:193:b0:400:9847:59f6 with SMTP id s19-20020a05622a019300b00400984759f6mr573173qtw.13.1689717681697;
        Tue, 18 Jul 2023 15:01:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8464e000000b00403f1a7be90sm907937qto.88.2023.07.18.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:21 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:20 -0400
Message-ID: <1baf124726770d3fe90916b5f8826e70.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 10/20] selinux: netif: avoid implicit conversions
References: <20230706132337.15924-10-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-10-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type sel_netif_hashfn() returns.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
