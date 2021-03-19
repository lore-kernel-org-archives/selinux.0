Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47258C433E6
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113D064F3B
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCSNao (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhCSNa3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 09:30:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D983C061761
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:30:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g25so5498441wmh.0
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqxxjU+wnwYGxcIxMIjRQhxf9BngsTqESHU7cWQvFn8=;
        b=hstLdqtNpgte2teshQgLp4jcH+bAmgbWUC1tt01NDEu34dQlqudsRenJKjc3dvabkk
         uE9W+PdVJ5wsu55q7PkkVzpWVJPTth//+Jv8/CIYw2rXsAVyiY/SNMnA40kb1xuOKUU0
         tuhwAZq2VMMJg6IScvK7TtCXGBIN28yf5aCd0z/YixVCT3Z5/83hg8TEj+gY6c8dQHmo
         fEj4uRxgA25iQY9bz36/erSl983strDL4wd11vc6Iht1qz3XAXYqijHCa3LSR36XiHFm
         A+/ZzfcroSa/1vuzqSxnUXwPW3M4MZ8X8/Z2HiVegSeGZB7h5JUMwcyr+DzODbfHR9VI
         MJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqxxjU+wnwYGxcIxMIjRQhxf9BngsTqESHU7cWQvFn8=;
        b=WckgCcQPzCrt8iq1W0vrPdi+0hq+nTaRJhvZ0OikI96e0NpUYCYOyDn+zJoy3euCq7
         +Elx7oLlD8OF2MzQGB0fhcFMzgsFzraexEVSx/YRjuCxoxhycuFCiDiLoBfNWU+L3glV
         Ut4p5PDwA28r+cpxPjbeNGM3Z4ws/UAbQtnbbtocYFz29q+cQ2xtHdOOi3wYhKiEacST
         3vw8ASSxHCDh+Gxs/zEFw4Zqxkwd/jpzo9fEYUnQmPwridkooFNH3Y09FT/r2FzZRx3K
         rAT25RlRH7KOvwnACO1AGHMB7pfZkYjG6UxEjGS6LJtvSWT4FlofQe5lT6HLkzErT2Fu
         q/Cw==
X-Gm-Message-State: AOAM532D9v+Zz4SUu4d99b2Y4o3qYzByTD9PsYcTLljwnq3cVkuyCbQx
        k3mtjMaes4+gDr6banPH7R55OFBJtaMTUg==
X-Google-Smtp-Source: ABdhPJzYvk8uCKPJKGOQFMvJG0I07hajcvaqheb9rFcjVgyB2PxJHrRQCRGH+Q0cFo4RWSKNO9F2Tg==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr3765734wmg.37.1616160627793;
        Fri, 19 Mar 2021 06:30:27 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id j13sm7731425wrt.29.2021.03.19.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:30:27 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:30:23 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: vsock: Set SID for socket returned by
 accept()
Message-ID: <YFSnb/kGpn7xPPR8@google.com>
References: <20210319130541.2188184-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319130541.2188184-1-dbrazdil@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 19, 2021 at 01:05:41PM +0000, David Brazdil wrote:
> For AF_VSOCK, accept() currently returns sockets that are unlabelled.
> Other socket families derive the child's SID from the SID of the parent
> and the SID of the incoming packet. This is typically done as the
> connected socket is placed in the queue that accept() removes from.
> 
> Reuse the existing 'security_sk_clone' hook to copy the SID from the
> parent (server) socket to the child. There is no packet SID in this
> case.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: <stable@vger.kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
> Tested on Android AOSP and Fedora 33 with v5.12-rc3.
> Unit test is available here:
>   https://github.com/SELinuxProject/selinux-testsuite/pull/75
> 
> Changes since v1:
>   * reuse security_sk_clone instead of adding a new hook
> 
>  net/vmw_vsock/af_vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5546710d8ac1..bc7fb9bf3351 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
>  		vsk->buffer_size = psk->buffer_size;
>  		vsk->buffer_min_size = psk->buffer_min_size;
>  		vsk->buffer_max_size = psk->buffer_max_size;
> +		security_sk_clone(parent, sk);
>  	} else {
>  		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
>  		vsk->owner = get_current_cred();
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
