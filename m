Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE02C433DB
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 02:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFA164ECA
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 02:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTC6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 21:58:25 -0500
Received: from namei.org ([65.99.196.166]:53842 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBTC6Y (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 19 Feb 2021 21:58:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id B195967;
        Sat, 20 Feb 2021 02:55:54 +0000 (UTC)
Date:   Sat, 20 Feb 2021 13:55:54 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
In-Reply-To: <161377734508.87807.8537642254664217815.stgit@sifl>
Message-ID: <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
References: <161377712068.87807.12246856567527156637.stgit@sifl> <161377734508.87807.8537642254664217815.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 19 Feb 2021, Paul Moore wrote:

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56ac..39d501261108d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		u32 secid;
>  		size_t added_size;
>  
> -		security_task_getsecid(proc->tsk, &secid);
> +		security_task_getsecid_subj(proc->tsk, &secid);
>  		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;

Can someone from the Android project confirm this is correct for binder?

-- 
James Morris
<jmorris@namei.org>

