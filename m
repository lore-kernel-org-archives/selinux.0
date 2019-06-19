Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B162C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE28208CB
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1Uij9qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfFSFVo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:21:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40207 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfFSFVo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:21:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so4318157pgj.7
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnOqvWjPX5IbJJFzwD9Xt1qYIOijAoiwIm/thRUZWwc=;
        b=h1Uij9qhR+SkHQa/tBFdMQXnbLZ9WcwwVEcR5lXm4yVcgQnpENhiXPbBoeuKyiiFeW
         vb20L/u6Vylqm2ODOnktoUFpLW+2QpBdW7HzWbMQ0zWO2xgD27BQx5avHV+n6TXNfZ88
         fkHTURKbxlEAPpiXVBbAYbJCKQFYxWM9iyrB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnOqvWjPX5IbJJFzwD9Xt1qYIOijAoiwIm/thRUZWwc=;
        b=Grrd//Bk8OYihMSuFKflyI4CO5Bm611CHxQFhPuGUFORhYmQuIzNlvcq7Eaq1Tnyld
         e3JfL2zlY/LavYLOoEmcog0FDyps+9BeDf3D8BJ00aaD4xKZMJbrToObey9a0lnZmZM5
         2c9mCyYfCKmepN6PkVeVYcsY8OijtjS7ZQEzyrBXht8G0YejDlrsMHydwkSLXey2VA0e
         o/vxQfIhrPy88fx5nRhXmPKj2tGy8WT1bLMV42LOmV8M/bItZ5CjfSFCmD69Uku4gI60
         d3u9fR1JQeEYnhgqCKuTIybR3ho1GfJWE/oBo94LNuI1sLIHks+YHhjqZIKD/2UyqJHu
         S11w==
X-Gm-Message-State: APjAAAVqEaildmAoNotdpTDIe5dtFzC2mp/EDKF+eh501wGf3Czuouyr
        +gAZhHzBUVB4r9bhpQQmy5s7bA==
X-Google-Smtp-Source: APXvYqwWhmLepNizk5R0HTpFVbT2Vs/WJH1SyOx3MXnrC8pd/YgHuOFXFhvTkklhXPEc74QUE8A2Wg==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr121895436pfn.138.1560921703954;
        Tue, 18 Jun 2019 22:21:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm26419635pfk.72.2019.06.18.22.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:21:43 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:21:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
Message-ID: <201906182214.6DC4C1DB9@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
> Patches 0004-0014 replace system use of a "secid" with
> a structure "lsmblob" containing information from the
> security modules to be held and reused later. At this
> point lsmblob contains an array of u32 secids, one "slot"
> for each of the security modules compiled into the
> kernel that used secids. A "slot" is allocated when
> a security module registers a hook for one of the interfaces
> that uses a secid or a security context. The infrastructure
> is changed to use the slot number to pass the correct
> secid to or from the security module hooks.

I found 14/25 in your git tree. Very satisfying to see all the
scaffolding vanish for process_measurement() :)

I like this progression in 4-14; I find it much much easier to review.
My only complaint is the variable names. I think I'd prefer "blob" over
"le" or "l", which are both contain very little information about what
they are.

-- 
Kees Cook
