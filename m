Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A061C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB5207FC
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL6hDFg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHDUTr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgHDUTq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 16:19:46 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F791C06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 13:19:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id a19so13698487qvy.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=65gFqFF/0EoaykjwaYQMhyD3hfLMImpEWdJz3wVW5zM=;
        b=lL6hDFg6hWUvj5R+5uhEEpJ3Bz0zUmZK0Tr4oujgPQdzWtuGqUHD70UIuJEFmdPeh2
         7gj6yy9X6feTosgJTCAOhmK8UH1U8lJRTSAi2gkDyHcPygsjudPUWUGzLgiJb25oDZ4D
         xm4is4k1vQ70ZnY1tY3R0oc31e85tGfkgd4F7RiRkM/pwmutLOgHW+bk5Pc2R+rHgzDs
         jfx8e7LCRJ8o7piJMbZJkvazjw1UYWHwvGVtenomQs70cIbvjoRXb08sRdk5WAnj4O6O
         W+QBklg8vP7RxN8DBQWFdKb8sPOnv6/cdgSKU18bViEIjdFlEsrE1iCmnt6tIUNEcBvV
         i8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=65gFqFF/0EoaykjwaYQMhyD3hfLMImpEWdJz3wVW5zM=;
        b=lJUsMMMJJBepAQ/XTpMZXo6Dv/wHRBq8i4ZJyWoqh780SnPFhE7v5yu2P8w8SncL8r
         X8rAzMVFEhsbdzBwHBJKKooiNLipjOb1Wrh5d4tonEgW5xUkNc30kW6YBngmXskI7ZN5
         VHGkJlxs1glwQfR/99QqgWUj2IiDZbzaIVLxZNhYRGuq3OaVZd+uZVLgt917TWl+vrzr
         AnfcvepyXJb7vALiQsxxGNL/yTQYzGrgtkX0KpuiiqFtur9Ug848JIkxo5ZIEklChxeJ
         EJf1fHKDMq0lppJnbGEnSJlZ8rRpTafvRzwDIpg0y73jfef8VbxKF7HANQCnlmRU64bq
         weCg==
X-Gm-Message-State: AOAM532/1fHL5gO+AgMyIguZNhCa2e3QeEKW2zAhSMGCthMoP8iXgPeF
        yb5WUeFeOf1bxpiA21leplg=
X-Google-Smtp-Source: ABdhPJygJ622+XAQNMTPwIcLlpqylwaDGy2T0Tb6739ty+cZxAYIveeFwVMJEUD+aj9i/wEBEZULqg==
X-Received: by 2002:ad4:4302:: with SMTP id c2mr107020qvs.246.1596572385822;
        Tue, 04 Aug 2020 13:19:45 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id d16sm22552334qkk.106.2020.08.04.13.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 13:19:44 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: move policy commit after updating selinuxfs
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
References: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <a1111b69-23a4-e885-e3a3-aea2613a82d2@gmail.com>
Date:   Tue, 4 Aug 2020 16:19:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/4/20 9:53 AM, Stephen Smalley wrote:

> With the refactoring of the policy load logic in the security
> server from the previous change, it is now possible to split out
> the committing of the new policy from security_load_policy() and
> perform it only after successful updating of selinuxfs.  Change
> security_load_policy() to return the newly populated policy
> data structures to the caller, export selinux_policy_commit()
> for external callers, and introduce selinux_policy_cancel() to
> provide a way to cancel the policy load in the event of an error
> during updating of the selinuxfs directory tree.  Further, rework
> the interfaces used by selinuxfs to get information from the policy
> when creating the new directory tree to take and act upon the
> new policy data structure rather than the current/active policy.
> Update selinuxfs to use these updated and new interfaces.  While
> we are here, stop re-creating the policy_capabilities directory
> on each policy load since it does not depend on the policy, and
> stop trying to create the booleans and classes directories during
> the initial creation of selinuxfs since no information is available
> until first policy load.
>
> After this change, a failure while updating the booleans and class
> directories will cause the entire policy load to be canceled, leaving
> the original policy intact, and policy load notifications to userspace
> will only happen after a successful completion of updating those
> directories.  This does not (yet) provide full atomicity with respect
> to the updating of the directory trees themselves.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to my previous one,
> https://patchwork.kernel.org/patch/11698505/. Although this does
> not ensure atomicity when updating the selinuxfs directoty tree,
> I suspect it will solve Daniel's original bug because systemd/dbusd
> won't get the policy load notifications until the kernel is done
> updating selinuxfs and therefore won't try to re-read selinuxfs
> in the middle of it (because libselinux caches the class/perm
> mappings and only flushes on a reload).

Recognizing that re-basing the selinux namespace patches on top of these 
two patches might be painful, I went ahead and did so; the result can be 
found here:

https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns-rebase

The two patches that required manual fix-ups were the first one 
("selinux: rename selinux state to ns (namespace)") and the third one 
("selinux: dynamically allocate selinux namespace"). The rest re-based 
without conflicts.  The resulting tree built, booted, passed the 
selinux-testsuite, and I could successfully follow the instructions to 
create a new namespace and load a policy into it. As before, the child 
namespace won't be usable if you switch it to enforcing mode since we 
haven't yet revived the per-namespace support for inode and superblock 
security blobs and it is still very unsafe to use in its current form.


