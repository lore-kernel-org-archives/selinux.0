Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D728C433FE
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 21:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJLVWs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJLVWr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 17:22:47 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6A11B2F4
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 14:22:45 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MnllX3JxtzMpvW1;
        Wed, 12 Oct 2022 23:14:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MnllV5LYyzMppqp;
        Wed, 12 Oct 2022 23:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609272;
        bh=XmjSicC4hYC+1A7pG8Edb0BlTaLN98y6T76Fm2lChYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BijU0W5dbOqFEFzsl42HfXcLOIRcNx7g0Klz4LVSfmnZqFAy4Qxx0wt6JRLC7LiiN
         +paCvtyQ0UpEOMj55k8K0WeVinscf7pla44LU2QUC3Q+/R7J0K4nrI+g5Hs28jfKYk
         edyM/vBF0Q2h4ZfnwsFxrXizYQ0cf3wTkI9lwI0M=
Message-ID: <b5ddec1b-c086-9421-bc64-cdb59324594d@digikod.net>
Date:   Wed, 12 Oct 2022 23:14:30 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 01/39] LSM: Identify modules by more than name
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-2-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927195421.14713-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Please Cc me for the next versions.


On 27/09/2022 21:53, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> a single member, which is the name of the module. Change the
> security_add_hooks() interface to use this structure. Change
> the individual modules to maintain their own struct lsm_id and
> pass it to security_add_hooks().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

[...]

> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index f8e8e980454c..fc7b69c5839e 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>   	.lbs_superblock = sizeof(struct landlock_superblock_security),
>   };
>   
> +struct lsm_id landlock_lsmid __lsm_ro_after_init = {
> +	.lsm      = LANDLOCK_NAME,

Please only use one space after ".lsm". This applies for other commits 
as well.

This command will do the trick:
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --tree-filter 
"clang-format-14 -i security/landlock/*.[ch]" v6.0-rc7..
