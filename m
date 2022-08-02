Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C3C3F6B0
	for <selinux@archiver.kernel.org>; Tue,  2 Aug 2022 14:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiHBODN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiHBODD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 10:03:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B182926ACD
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 07:03:01 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3AE5720FEEE5;
        Tue,  2 Aug 2022 07:03:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AE5720FEEE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659448981;
        bh=8ACaqmu+0X1P3UydDjBYnS2si3PJp+CcaPUc0pnbams=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dF1togpiK0NhrA7hwxNBNFasRU+8MKpR2UOb6MkrMEgYe586kSD6gzaWpIhijW3TU
         9sk91eCyGtdC1hcUWAtpsvm08TJZj77erUO0I2ffJC1z+YGpJ7ATdeJo566beCJWSb
         fvQnffOCA/ED6MpmY0CuDyJJ3Zu5jcahoHpzZ29o=
Message-ID: <87618b9d-129f-5087-3010-52f5762b85f5@linux.microsoft.com>
Date:   Tue, 2 Aug 2022 10:03:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH testsuite 11/24] test_general.te: move sysadm-related
 rules into an optional block
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20220729120229.207584-1-omosnace@redhat.com>
 <20220729120229.207584-12-omosnace@redhat.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220729120229.207584-12-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> That should allow running selinux-testsuite with the sysadm module
> disabled.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/test_global.te | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te
> index aceac48..3862ee7 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -25,12 +25,21 @@ optional_policy(`
>   	dontaudit unconfined_t testsuite_domain:process { noatsecure rlimitinh siginh };
>   ')
>   
> -gen_require(`
> -	role sysadm_r;
> -')
> +optional_policy(`
> +	gen_require(`
> +		role sysadm_r;
> +	')
> +
> +	# Authorize sysadm_r for the test domains.
> +	role sysadm_r types testsuite_domain;
>   
> -# Authorize sysadm_r for the test domains.
> -role sysadm_r types testsuite_domain;
> +	# Allow the test domain to be entered from sysadm_t
> +	sysadm_entry_spec_domtrans_to(testsuite_domain)
> +
> +	# Let sysadm_t use runcon to run the test programs in various domains.
> +	#allow sysadm_t self:process setexec;
> +	#selinux_get_fs_mount(sysadm_t)
> +')

These commented out rules can probably just be removed entirely instead 
of being moved into the optional block?

-Daniel

>   
>   # Allow the test domains to access the sysadm terminal.
>   # This allows read and write sysadm ttys and ptys.
> @@ -40,17 +49,10 @@ term_use_all_terms(testsuite_domain)
>   allow testsuite_domain init_t:fd use;
>   allow testsuite_domain initrc_t:fd use;
>   
> -# Allow the test domain to be entered from sysadm_t
> -sysadm_entry_spec_domtrans_to(testsuite_domain)
> -
>   # Allow the test domains to access the test directory and files
>   # even if they are not root owned.
>   allow testsuite_domain self:capability { dac_override dac_read_search };
>   
> -# Let sysadm_t use runcon to run the test programs in various domains.
> -#allow sysadm_t self:process setexec;
> -#selinux_get_fs_mount(sysadm_t)
> -
>   # Let all test domains read test directories and files and to use test
>   # files as entry points.
>   miscfiles_read_test_files(testsuite_domain)

