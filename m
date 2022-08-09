Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1DC19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 13:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiHIN7I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiHIN7I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 09:59:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5129218368
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 06:59:07 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id DB09E210C890;
        Tue,  9 Aug 2022 06:59:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB09E210C890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660053547;
        bh=nUbgIBz5q/WSx1WifwDYi5NmE7Y3TWoIh8JNr+0qV14=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=F7c74PjtcZh0vMjy6UyXXCGbkk8iaWjepIP3zdpxITUsmGHB2PnM3BT/p95d1gHO0
         MWnUhe9iJIIDPTyA10li5c4WOFSC8mhnEw6FC1/GCfzDsn580WHVXiR/ol5Lo0awXu
         bA/xRN/73SfQ78qZztxvW2l8leju6lc/kVnJCIgA=
Message-ID: <d9bbf441-34d2-313c-33d1-3e6b886f9bd9@linux.microsoft.com>
Date:   Tue, 9 Aug 2022 09:59:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] restorecond: use strict function prototype for
 definition
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20220808173620.16760-1-cgzones@googlemail.com>
 <20220808173620.16760-2-cgzones@googlemail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220808173620.16760-2-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2022 1:36 PM, Christian Göttsche wrote:
> Clang 15 starts to complain about non strict function definitions:
> 
>      user.c:172:10: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      int start() {
>               ^
>                void
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   restorecond/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/restorecond/user.c b/restorecond/user.c
> index 47b86823..3ae3ebbb 100644
> --- a/restorecond/user.c
> +++ b/restorecond/user.c
> @@ -169,7 +169,7 @@ io_channel_callback
>     return TRUE;
>   }
>   
> -int start() {
> +int start(void) {
>   #ifdef HAVE_DBUS
>   	GDBusConnection *bus;
>   	GError *err = NULL;

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
