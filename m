Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21229C433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E581D20809
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ARQB8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgG3WdZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3WdZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 18:33:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F2C061574
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:33:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so27223201qkb.1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bJz2ehHOkBi4BvEV2dM1dUQXVOfMFmdz1qYBJfx+GDc=;
        b=g6ARQB8a06QUxX4vvnH8ZbWP9ZyKyBHFbw+PvRD7NZ6GopuUQOet9IsmeCvsJzUyhp
         MSwSlDl++kzx+SGo9YhHAwZWlWqGUXk+0XfncyqAZ0ewsMQDrzcul/R2tBZDK3dx+TjP
         zFigO+ajhW7viZ4qXA7EFB54s+jbPgTO7OlAK2PqtTjmxF9eM2n2vyNDPZiouUW6bQQn
         PzRBYc+CduhA33QljqD7vlOTVz2VE0VuggeFy/Zm3IxeFniQhnbMKjYn82tnf6Gn5HAd
         u7+bY3W7EL1aIMCQPuvuBB/Ot6mYcd3rpVr3YoB0/DPh8FME2JGLLlB4M3uKTN0Y22ID
         9uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bJz2ehHOkBi4BvEV2dM1dUQXVOfMFmdz1qYBJfx+GDc=;
        b=lOyyn1vPAZwgJflR6qcbyEvqsd/NwknpTPlxRgWZLwhgXDse9OtK/eJMt8JJoC3zgl
         wZt5a8AA8D9auk0RdWKdBP4S5PwOcTGJAB4irI/oF/HzHCSCZGQwzTdlDM0nX+Yv5GUg
         NVoUkolyicvBzNllMBFHPcO2ih1iCe2JlXeCu3Y8mkJolqXEVLj6g+LjoHvJrr7LZS/v
         aD3SdqASa13lAqeCbYL4Unri/Mq637LKeDzdplgK+SWQ4vzJ1mrNgXfc2DWlEHXDlwCK
         Ss40xXaiXBJEC4wcj3+AuGyKnx+xsXf/o3SI5jLz9RhkR/09SRfnu8rp630vNfHUQJqr
         ZerQ==
X-Gm-Message-State: AOAM530GAuk4+1uRryPPMISragjDY0iku6I0wx+DfHJ6KDjE+CNdRHhy
        /0cPSKw4OywrsIoWRjmRR+0h37XJ+LU=
X-Google-Smtp-Source: ABdhPJx0UhOx7Fi5QsPRNcxkwtGxVfwyX5WrajtO9F1amMaaI/41dxWvm7yGHXQAb4z5UjIcuhPbEw==
X-Received: by 2002:a37:a906:: with SMTP id s6mr1397765qke.320.1596148403558;
        Thu, 30 Jul 2020 15:33:23 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id b2sm5715023qto.82.2020.07.30.15.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 15:33:23 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: encapsulate policy state, refactor policy
 load
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200730220905.60088-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <208642b5-b046-a26f-09d1-9e05377cefe7@gmail.com>
Date:   Thu, 30 Jul 2020 18:33:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730220905.60088-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/20 6:09 PM, Stephen Smalley wrote:

> Encapsulate the policy state in its own structure (struct
> selinux_policy) that is separately allocated but referenced from the
> selinux_ss structure.  The policy state includes the SID table
> (particularly the context structures), the policy database, and the
> mapping between the kernel classes/permissions and the policy values.
> Refactor the security server portion of the policy load logic to
> cleanly separate loading of the new structures from committing the new
> policy.  Unify the initial policy load and reload code paths as much
> as possible, avoiding duplicated code.  Make sure we are taking the
> policy read-lock prior to any dereferencing of the policy.  Move the
> copying of the policy capability booleans into the state structure
> outside of the policy write-lock because they are separate from the
> policy and are read outside of any policy lock; possibly they should
> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>
> These changes simplify the policy loading logic, reduce the size of
> the critical section while holding the policy write-lock, and should
> facilitate future changes to e.g. refactor the entire policy reload
> logic including the selinuxfs code to make the updating of the policy
> and the selinuxfs directory tree atomic and/or to convert the policy
> read-write lock to RCU.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> @@ -2098,10 +2104,12 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>   
>   static void security_load_policycaps(struct selinux_state *state)
>   {
> -	struct policydb *p = &state->ss->policydb;
> +	struct policydb *p = &state->ss->policy->policydb;
>   	unsigned int i;
>   	struct ebitmap_node *node;
>   
> +	read_lock(&state->ss->policy_rwlock);
> +

Oops, should have moved the dereferencing of policy after taking the 
read-lock here; fixed it everywhere else I think but missed this one.  
Will fix in the next version but will wait for other comments on this 
version.

> @@ -2132,112 +2200,58 @@ static int security_preserve_bools(struct selinux_state *state,
>    */
>   int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   {
<snip>
>   	/*
>   	 * Convert the internal representations of contexts
>   	 * in the new SID table.
>   	 */
>   	args.state = state;
> -	args.oldp = policydb;
> -	args.newp = newpolicydb;
> +	args.oldp = &state->ss->policy->policydb;
> +	args.newp = &newpolicy->policydb;
>   
>   	convert_params.func = convert_context;
>   	convert_params.args = &args;
> -	convert_params.target = newsidtab;
> +	convert_params.target = &newpolicy->sidtab;
>   
> -	rc = sidtab_convert(oldsidtab, &convert_params);
> +	rc = sidtab_convert(&state->ss->policy->sidtab, &convert_params);

Should sidtab_convert() be called while holding policy read-lock since 
we are passing state->ss->policy->policydb via the args field of 
convert_params and using it within the callback?  I think it happens to 
be safe currently by virtue of the fact that nothing else can write to 
it since selinuxfs is holding its semaphore during the entire policy 
reload but it seems inconsistent. However, if we do take policy 
read-lock across the call, then sidtab_convert() needs to use GFP_ATOMIC 
allocations instead of GFP_KERNEL.


