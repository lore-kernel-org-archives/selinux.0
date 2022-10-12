Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20983C4332F
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJLVSh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJLVSg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 17:18:36 -0400
X-Greylist: delayed 98 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 14:18:36 PDT
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05363FF8FE
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 14:18:35 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MnlrB4xJZzMpyjd;
        Wed, 12 Oct 2022 23:18:34 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Mnlr96dLbzMpqBK;
        Wed, 12 Oct 2022 23:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609514;
        bh=DMhwYjWL6d1PAGaMxTIgGylIFY9xHl+u4l11I3u63VU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sa2FGycxEG4zDO/NzLxkCWr8Zd4RR4v/UZS6ki/Scg5cKVyrdvvqc6mfXxotNYa3U
         yRh3FgH0VVeTCm0m+FJNyjTzdx0qqwQnqRUkwZ9oJiHHx7utMCpJ+E8I+6FpS5KbqF
         9OSeOhewRXQ21B1NVcA6GfGtKGtEWDI568Ih6LLc=
Message-ID: <58adb9d6-3199-00b9-5883-804d5934b024@digikod.net>
Date:   Wed, 12 Oct 2022 23:18:33 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 09/39] LSM: Add the lsmblob data structure.
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-10-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927195421.14713-10-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 27/09/2022 21:53, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the security
> modules built into the system that would use secids if
> active. The system assigns the module a "slot" when it
> registers hooks. If modules are compiled in but not
> registered there will be unused slots. The slot number
> is added to the lsm_id structure.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> A new structure audit_lsm_rules is defined to avoid the
> confusion which commonly accompanies the use of
> void ** parameters.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

[...]

> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index 1242c61c9de4..adbe941370f3 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -27,6 +27,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>   struct lsm_id landlock_lsmid __lsm_ro_after_init = {
>   	.lsm      = LANDLOCK_NAME,
>   	.id       = LSM_ID_LANDLOCK,
> +	.slot     = LSMBLOB_NOT_NEEDED,

Please only use one space after ".slot"
