Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B423C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA46F20829
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoiCx99n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHMPlx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMPlu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 11:41:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2DC061757;
        Thu, 13 Aug 2020 08:41:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so4707693qtt.0;
        Thu, 13 Aug 2020 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T7OhuuwqfjmZPOHt/vuVyRTlO6DVRYXp/MrPZLRwoQM=;
        b=FoiCx99n9BHbB2/qprMvfuSCLcC6D1MR3TRY/6MiZ6/+q90nfkSd+OUiL2MrxQemZP
         8dJmX7M2iAZWx0p6pxz2uoz/DTEQAp+KS4XB1p5jnlc1bB0UyOPRVnHvzRGOjsEh2h/q
         am2l8mkSlXCYHjcHMY5gjMb08urEtd21VDfl/AuAW0tkAiIkvhpltH7xH5UGvKiBHs7F
         9xhNHs537P5PPkA4w7c0CaGqcUQ8MKtPI0v6ZzaLUh4ZWAFuJL/7hRIbTGWx817aHpkI
         4M/5Kr/jb7yiTrH5c0ZkwH+eYlDkqlmAGOtLSPk5rXbrj9WCctY872Zcvi8LY+gK/KHY
         Ghug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T7OhuuwqfjmZPOHt/vuVyRTlO6DVRYXp/MrPZLRwoQM=;
        b=ljwEjNS6POil/BM/EFPI/PxEc0291x4s2MZnbMFGwsWvTS5O/0bkEyiGLzKKwHK1s3
         Av0vBeMfzsa6y1kNRQp7Ablom+pQn/x7PIGu4QvCaKr5Mq2f0uUlhBNnKzftJnYwBo7B
         T1jkIGe2ufG+RvG9REA1TxdxNmRMVTptov95luewd22DTQ/1YFpfRVoX/vE3c5oXcIq0
         88cCqY6asdjW90C9Rta/qfPxkBQp6rGs4QKpzwdzmrQHKXTNwjW38rHn0/cBMHO/42dM
         SoulWJcRSbF6puV9Jr6vuooIJjaYnIddbFOWmez/qTyIKb/+LjJLwzcMM4nWlAf3mFaN
         +q6w==
X-Gm-Message-State: AOAM532OBphy1YK1rwpk529Al874+QLpxMH//Rntlm9CfeMbaDIFzTir
        5OZqbI0Op1r1xh7/2HnliPF/emmr
X-Google-Smtp-Source: ABdhPJzYHX15HPUyZI5txPARd3YTKU5RZQ4ENnbLf6Ya5SQ1H4KTuwzGIkbbN6P/Prxpt3diXLbLnQ==
X-Received: by 2002:aed:2825:: with SMTP id r34mr5518049qtd.321.1597333309560;
        Thu, 13 Aug 2020 08:41:49 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id y3sm7176981qtj.55.2020.08.13.08.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:41:49 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
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
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20200813144914.737306-1-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
Date:   Thu, 13 Aug 2020 11:41:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813144914.737306-1-tweek@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 10:48 AM, Thiébaud Weksteen wrote:

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

An explanation here of how one might go about decoding audited and 
tclass would be helpful to users (even better would be a script to do it 
for them).  Again, I know how to do that but not everyone using 
perf/ftrace will.


