Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF0C4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 10:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJMKEn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJMKEl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 06:04:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA82DEE;
        Thu, 13 Oct 2022 03:04:40 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29DA47B6033225;
        Thu, 13 Oct 2022 19:04:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 13 Oct 2022 19:04:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29DA47NY033222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Oct 2022 19:04:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp>
Date:   Thu, 13 Oct 2022 19:04:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-5-casey@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220927195421.14713-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/28 4:53, Casey Schaufler wrote:
> @@ -483,6 +491,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  {
>  	int i;
>  
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once. Landlock is one such case.
> +	 */
> +	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
> +		lsm_idlist[lsm_id++] = lsmid;
> +
> +	if (lsm_id > LSMID_ENTRIES)
> +		panic("%s Too many LSMs registered.\n", __func__);

I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.

I'm fine with using UAPI-visible constants for switching /proc/ files.
But TOMOYO does not need such constant because TOMOYO does not use /proc/ files.

Also, lsm_self_attr() will be limited for LSM modules which use /proc/ files, and
therefore I think prctl() will be already there.

> +
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);

