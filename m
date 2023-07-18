Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DCC0015E
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGRWCG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGRWBk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:40 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76831BF5
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635857af3beso25514246d6.0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717684; x=1692309684;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGKUUeN2n3dLjiGz+5O+JqepftZ1VAcXJq+8NvA1EVE=;
        b=RbnJ+IOHqbT2TKTtSBpBMW4C0ByTCzV1VRxozZEvAF108KeOgc556eXV4TwKq2DYzf
         UbBygsD0+0WVPEnnMdoHq3nn1j/Q3B8JWIcMJWZY4YSH1hJ92aRHTEZMhdwx85KBvnJr
         +A3oLeLTQBJMSVvtp8/s7pg90W8xZZKtos6AF1qRG4MwiihX1lx+qbu5/IVmWuosya7j
         sZToCvuYx+NsakyogzHDaJzMtnyOAwSI7KrgAgC0IeayAlCkMUGFC1wS2IEh+gdEwYtM
         PBuWcCJ2HdythI6WxD+4ca5SnwwN1rHrjKz00Am/qrKhvwAnoKBVyMLl9vnuyzd0vSBy
         VaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717684; x=1692309684;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGKUUeN2n3dLjiGz+5O+JqepftZ1VAcXJq+8NvA1EVE=;
        b=VMpizad4WgfSsfFhb6Eok31KzBJZtxSEnmzoxwQnLnIuOVCce6FToj8LbR23TiDt1G
         5fY+jSukHqVtm63mis48wA9pK2uAnpAMhdAf5Y+WzKQ3AGZotIC6umI1sJ8Y/lk4BjPi
         neAoIFZbjZamO0T2WNig/dM+uyE9vaYOJmVMMI0hQ9vwX5XA9gxpIG/4xlRuFLhMjWwV
         caDD8oTmuVvuWyGQyHUFBKkPEgpb1ZbZ6LTrNiadijRX1njeOUdJ/f+Dtony38TJObpe
         kmEajP69fiR9RAs/zTIulkvnaXXeVC3LQ1A29jN6ECYTZDqnI2EsXEMzNjbrg9j9cWl9
         r0ew==
X-Gm-Message-State: ABy/qLYhxKCXoqewmv1mLSmKHVZihog3vypUKz4aNk6QWCvI9J1rEsZH
        Wl+Jjf0EV05J1K4jkAUD6g3w
X-Google-Smtp-Source: APBJJlGjV50daVlpT3yTfxIAcW4s0P80KMTU0/gPNhojY4VuQk2MuZSJVt9IVzRSm9ZIL+hBbsktLA==
X-Received: by 2002:a0c:f201:0:b0:62f:eb99:edc with SMTP id h1-20020a0cf201000000b0062feb990edcmr776824qvk.6.1689717684321;
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q10-20020a0ce20a000000b0062b35b691cdsm121280qvl.93.2023.07.18.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:23 -0400
Message-ID: <7301f8baddb16f3e9e06a27172d6cecd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 13/20] selinux: selinuxfs: avoid implicit conversions
References: <20230706132337.15924-13-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-13-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use umode_t as parameter type for sel_make_inode(), which assigns the
> value to the member i_mode of struct inode.
> 
> Use identical type for loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

No declaration of iterators inside loops please.

--
paul-moore.com
