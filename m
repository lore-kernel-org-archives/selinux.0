Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD189C761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaR7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCaR7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 13:59:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C31252369D
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:58:50 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 799B020FFC9F;
        Fri, 31 Mar 2023 10:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 799B020FFC9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680285497;
        bh=SGeTlQ8+JRaKzXPnKYzAJn4AiTYNT3gQae+7QQTAnV0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=e0QfJIbZkq5vC7QkNS2zZYrIF4/9KjzxZrlwcJXEGPKtuz4+MNrh79GSBA1dejHUU
         4Fvo0lcH93nvwmnHmrjWlC/qjb01bgsGNvF9gyhwXiBNgk7ZfUdPLAXj7Zg9tQ+cjY
         r9lDR/zsKSdpQ6IuC0PZ3Ym8HS9gbp9weJ7ctLyE=
Message-ID: <361e270e-ff0f-681b-5354-fc8fe98bb26c@linux.microsoft.com>
Date:   Fri, 31 Mar 2023 13:58:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] checkpolicy: add option to skip checking neverallow
 rules
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20230331173442.101678-1-cgzones@googlemail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20230331173442.101678-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/31/2023 1:34 PM, Christian Göttsche wrote:
> Add the command line argument `-N/--disable-neverallow`, similar to
> secilc(8), to checkpolicy(8) and checkmodule(8) to skip the check of
> neverallow rule violations.
> 
> This is mainly useful in development, e.g. to quickly add rules to a
> policy without fulfilling all neverallow rules or build policies with
> known violations.

I think it might be helpful to print a quick warning along the lines of 
"Warning: neverallow checking is disabled, compiled policy may violate 
neverallow rules" or similar when the flag is set, just to double-check 
against accidental misuse.

-Daniel

