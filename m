Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F97AC433ED
	for <selinux@archiver.kernel.org>; Sun, 25 Apr 2021 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC761075
	for <selinux@archiver.kernel.org>; Sun, 25 Apr 2021 16:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhDYQbL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 25 Apr 2021 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYQbK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 25 Apr 2021 12:31:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7292C061574;
        Sun, 25 Apr 2021 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=aPNKubWNb9Dn9hoicNXX/XrjWTImHJ9wjB29zrOI+os=; b=Fph4OCF3XZKAAJLU90jvZCZz3V
        8I9KwfRaqw6NbLrQ0g0AGGtMkBMoYbJIU1fMMhz8KTKafhwTO12B1aMkvizWNRwuzc0XtBRrMiNew
        /aqYSK2pPYCyu951xbhVpq9pzD9491Acvd6/fNDWU7srM7Iburaf1j7zk/skfqdMQERPgHTQuKcLA
        /Q444dEGXj5KR/y4yRN/nSqtV20ZoaFOWBazHTUEwlVMwVWDOZNZ34Z5GZZWOslhUrQbe7vYR31xw
        bL+OpgiElguDzXUgCtpD+e3faPWXP1+wBeFBbX9Vbo8+iCw8gG8hIvP5nOHhzgbm5PyWGM9Ba54br
        2glDPcng==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laheL-004Tlo-Cd; Sun, 25 Apr 2021 16:30:26 +0000
Subject: Re: [PATCH v2] selinux: Corrected comment to match kernel-doc comment
To:     Souptick Joarder <jrdr.linux@gmail.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8c0fc385-405a-e7df-3750-ff7e2d939f48@infradead.org>
Date:   Sun, 25 Apr 2021 09:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/25/21 1:35 AM, Souptick Joarder wrote:
> Minor documentation update.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index ad451cf..c90f455 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -819,7 +819,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
>  }
>  
>  /**
> - * avc_update_node Update an AVC entry
> + * avc_update_node - Update an AVC entry
>   * @event : Updating event
>   * @perms : Permission mask bits
>   * @ssid,@tsid,@tclass : identifier of an AVC entry
> 


-- 
~Randy

