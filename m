Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FAC001B0
	for <selinux@archiver.kernel.org>; Thu, 10 Aug 2023 15:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjHJPFg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjHJPFf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Aug 2023 11:05:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827F826A0
        for <selinux@vger.kernel.org>; Thu, 10 Aug 2023 08:05:32 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id D6ECA20FCD54;
        Thu, 10 Aug 2023 08:05:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6ECA20FCD54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691679932;
        bh=Xo8aQtbkQeSYxX8g6cLDMCr8lQbGAI/abJZUjQczm4Y=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=cOYbobPsvO+PL/nhzX5YlQ0cGzFOQAKDXcxpzi13Am0/FaGIQK/xnlJtv3X0heVrT
         5E2537qk8kiii/bPYw5d3HhRwh3sTV/cuKf7A/A0AxLwEAXSA9GBOtJ8gKk+tQerjh
         IGool/v10Ghjbq+ZTTnnTIchSadXdlZya3+Lqnk0=
Message-ID: <15e9c16a-6ed5-f5e6-f821-e8f22de68ef8@linux.microsoft.com>
Date:   Thu, 10 Aug 2023 11:05:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 9/9 v4] secilc/docs: Add deny rule to CIL documentation
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20230809210157.112275-1-jwcart2@gmail.com>
 <20230809210157.112275-10-jwcart2@gmail.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20230809210157.112275-10-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/9/2023 5:01 PM, James Carter wrote:
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v4: Remove the "*Where" section, since the notself patch series moves all
>      of that to beginning of the access vector section before talking about
>      specific rules.
> 
>   secilc/docs/cil_access_vector_rules.md | 41 +++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>

