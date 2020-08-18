Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F9C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2708206DA
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 14:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK0zJUSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHRObR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHRObQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 10:31:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D793EC061389;
        Tue, 18 Aug 2020 07:31:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so9617671qvl.4;
        Tue, 18 Aug 2020 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TzqE+tyL5aGg6xlW2ONAsC0NqtfbBXzQuRMgmljCc4k=;
        b=SK0zJUSyeNPBM4oImN1woiBOODwZiMi41tD0bEyRXGENcv368SINra19YGAaUvNr0l
         zMvAXCV0KqHUXOFUT0zoft+kgHxkF7BNJV9VwQyeeESiW1PTLZc0teq7NkPM7MXFQTYQ
         /RxHfx157ww+L0GjCzqq/97HnNAuJURsVDnGgXqwiC/mxCZea1JAYfHIPnN6il/hChze
         KXPrxjqnWos2zBwxJqlUsnPqoSZpQhkof2wD+rnFpgg2ODPq9hxZR/ccS8nvTW6YCEty
         K9vRkI4K1qCd3qISw0ugmCF/4QyMx93y87GYSj1PnSz+/JLwwtWTPQnA+IspgCFv6qO7
         BkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TzqE+tyL5aGg6xlW2ONAsC0NqtfbBXzQuRMgmljCc4k=;
        b=NsGpbboT5soqya4O/AE3NPs0UMOvZRe+r/QSFpuLYFu1PenJ8fGPCDVKb3YVPNNSEx
         b97nTcLlpRWt23JOTXuSjI9MApxlIjxufNIOFmMlZU6XOF5c8XsOr/hWM48XPcCl+z0b
         iTBHLQt3y8LxF+SO1tljAHNTm4SDDz+u73HQLPUgqjCO2nWlXeLmzYZUw8L647kh1Nfc
         aeOP11qhmOA/RgGi7Xeq2d7gT7w4gKfaAzfeyBxosDJJh1uZFD5qhkCaZDbN5qfGcY2L
         WVM5WoFFVFxsANgS8G4jH6UBKmmxxDAmiAIeoapwx/75FZV5qUQKt45D+J2t2zmaZUwb
         kHGg==
X-Gm-Message-State: AOAM530GnyuGkYC6Mt3IJ63xjWJOMfbFTylnzwIxGd8iGNmZdUV/IOln
        pvzxCLwVEsdVsfcDrsTmfT4rdwLM528=
X-Google-Smtp-Source: ABdhPJyeVwGeUwUxFb1DDk+fW340fA8n7CZkB9x+DzXfUwvOxvfIPK9WFiUMd94hagxksGE2I/8uYA==
X-Received: by 2002:ad4:46f4:: with SMTP id h20mr19825336qvw.85.1597761074176;
        Tue, 18 Aug 2020 07:31:14 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id n6sm19008051qkh.74.2020.08.18.07.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:31:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] selinux: add tracepoint on audited events
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-2-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <08b8b541-d558-d290-9593-a8cf18a40c1e@gmail.com>
Date:   Tue, 18 Aug 2020 10:31:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817170729.2605279-2-tweek@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/17/20 1:07 PM, Thiébaud Weksteen wrote:

> The audit data currently captures which process and which target
> is responsible for a denial. There is no data on where exactly in the
> process that call occurred. Debugging can be made easier by being able to
> reconstruct the unified kernel and userland stack traces [1]. Add a
> tracepoint on the SELinux denials which can then be used by userland
> (i.e. perf).
>
> Although this patch could manually be added by each OS developer to
> trouble shoot a denial, adding it to the kernel streamlines the
> developers workflow.
>
> It is possible to use perf for monitoring the event:
>    # perf record -e avc:selinux_audited -g -a
>    ^C
>    # perf report -g
>    [...]
>        6.40%     6.40%  audited=800000 tclass=4
>                 |
>                    __libc_start_main
>                    |
>                    |--4.60%--__GI___ioctl
>                    |          entry_SYSCALL_64
>                    |          do_syscall_64
>                    |          __x64_sys_ioctl
>                    |          ksys_ioctl
>                    |          binder_ioctl
>                    |          binder_set_nice
>                    |          can_nice
>                    |          capable
>                    |          security_capable
>                    |          cred_has_capability.isra.0
>                    |          slow_avc_audit
>                    |          common_lsm_audit
>                    |          avc_audit_post_callback
>                    |          avc_audit_post_callback
>                    |
>
> It is also possible to use the ftrace interface:
>    # echo 1 > /sys/kernel/debug/tracing/events/avc/selinux_audited/enable
>    # cat /sys/kernel/debug/tracing/trace
>    tracer: nop
>    entries-in-buffer/entries-written: 1/1   #P:8
>    [...]
>    dmesg-3624  [001] 13072.325358: selinux_denied: audited=800000 tclass=4
>
> The tclass value can be mapped to a class by searching
> security/selinux/flask.h. The audited value is a bit field of the
> permissions described in security/selinux/av_permissions.h for the
> corresponding class.
>
> [1] https://source.android.com/devices/tech/debug/native_stack_dump
>
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Suggested-by: Joel Fernandes <joelaf@google.com>
> Reviewed-by: Peter Enderborg <peter.enderborg@sony.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

