Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C26C433FE
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 07:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76DD61355
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 07:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhINHwZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhINHwI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 03:52:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7692C0613B6
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 00:50:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1409616wme.0
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQQsBMV/KZRW/W+H2x46A5MmwVr95aBTpydU/d7M2HU=;
        b=AAjpTdBAhVY5A9abSR3cTV0Gdf/FJZyO4h7UFY9WJwTTbhzLUwas+aaaisHVDEj0k+
         ENHa2/XA9Mh2s5Ju3ON8/Lr5RW6LWd3ohSieGKtfbUJ47Vc42IuhCmLZJUmoKwTBFKxb
         +bjPrKYIZkiMEdJdpuEkMzKp73uofCIQ3mFPnmebzxvzF7NnwHurzMaqZNWz8I5lslyt
         MwP9IP4i3ckQpDiU1NsEbEfrIfu+EHbyC4T7IFlehCsRhQlU+a42wNfzrSHEAoZ1ug1a
         Lgg3to8Ga84J1iDwwtOzDEq3E03H69BSe27MxiDm+iRzgoochO9W329XnnM2IUPaSk2/
         2hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fQQsBMV/KZRW/W+H2x46A5MmwVr95aBTpydU/d7M2HU=;
        b=2lYSKsLC8jM8wgeUyTZRJ+2jvlh/OtCcsqa3nx8MEocGq+dRQJ+LkD9Ov2JlXmfSbb
         vxRfzCXdEa4xApKW4mbxIKek6zaxpW9bQvhmJFOcvcCE7K+iUSUUMyogAYKtpL5mZtC/
         8/HqD7/tPVR5TRdeisLG4IjF8QEZ/lZTRJ9ZFipRAAZcCSlw7DaYlSmixV/a1B+Hlm1Z
         vbb2RxqzzTvHgnONJ87HsFMiWbib/Aw+oW5fQNLS+Hday41ldcxbzGMxpaEj9zX+Mins
         n3MVyqRUw0qdLx2/m1Uc4R7oVgf76bhuoQwuVbTGds1m3lDa4swQmPKpl1sZj5Mv2RxP
         fJyA==
X-Gm-Message-State: AOAM533z2mn6ndodNeRWCeHN3jXU2hc0BZKH7QH5qKIHmORPHuR3LJbg
        VI6/SAd57cy0Nx9JT58iEYmwdw==
X-Google-Smtp-Source: ABdhPJygFgkHfp5lL4CsS4GMWPjddGH6Owu9/1fa7A2NoDH5ihup042p3PzAjCG2K9U9bJGYvkjbsg==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr619819wmc.85.1631605811109;
        Tue, 14 Sep 2021 00:50:11 -0700 (PDT)
Received: from [10.16.0.69] (host.78.145.23.62.rev.coltfrance.com. [62.23.145.78])
        by smtp.gmail.com with ESMTPSA id r27sm9531178wrr.70.2021.09.14.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:50:10 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI
 breakage
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antony Antony <antony.antony@secunet.com>,
        Christian Langrock <christian.langrock@secunet.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@strace.io>,
        linux-api@vger.kernel.org
References: <20210912122234.GA22469@asgard.redhat.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <9ce148b0-7694-83f7-0d04-546e2cae9500@6wind.com>
Date:   Tue, 14 Sep 2021 09:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912122234.GA22469@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le 12/09/2021 à 14:22, Eugene Syromiatnikov a écrit :
> Commit 2d151d39073a ("xfrm: Add possibility to set the default to block
> if we have no policy") broke ABI by changing the value of the XFRM_MSG_MAPPING
> enum item, thus also evading the build-time check
> in security/selinux/nlmsgtab.c:selinux_nlmsg_lookup for presence of proper
> security permission checks in nlmsg_xfrm_perms.  Fix it by placing
> XFRM_MSG_SETDEFAULT/XFRM_MSG_GETDEFAULT to the end of the enum, right before
> __XFRM_MSG_MAX, and updating the nlmsg_xfrm_perms accordingly.
> 
> Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
> References: https://lore.kernel.org/netdev/20210901151402.GA2557@altlinux.org/
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
