Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6AAC00140
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiHXOKg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiHXOKf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 10:10:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 735B78E4C8
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 07:10:33 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3B58C212598E;
        Wed, 24 Aug 2022 07:10:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B58C212598E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1661350232;
        bh=Di0CxdT71YA4qR4oj4OtbFnvBcYAJBvnrbZsHpwvYj4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fSNWRiAnNKwfgMjUby2JqzjM0OgVBF5bpd/SxpWqSaSMf7ej/MCwU02p4YeVUo411
         xOZVWXtGXQGf+n/7CH7eciQE5FB6/709BQpQunHv6rXgSFaaScoL4boQPirz0AQplV
         gXAWF5V3m30ovLm0OQEzXBnE8253GFAlptQe0Y/k=
Message-ID: <d1f0f2c6-6716-9678-361e-4abf03e3cc6b@linux.microsoft.com>
Date:   Wed, 24 Aug 2022 10:10:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH testsuite 2/2] test_userfaultfd.te: adapt to upcoming
 Fedora policy changes
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20220824111938.567993-1-omosnace@redhat.com>
 <20220824111938.567993-3-omosnace@redhat.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220824111938.567993-3-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/24/2022 7:19 AM, Ondrej Mosnacek wrote:
> We plan to add automatic transitions for anon_inodes to the whole domain
> attribute, which would conflict with the testsuite's userfaultfd test.
> To avoid th conflict, use testsuite_domain_type_minimal() for the
> userfaultfd test domains, which doesn't add the types to the domain
> attribute.

If you spin a second version, there's a minor typo in the commit message 
("th conflict").

Regardless, for both patches:

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
