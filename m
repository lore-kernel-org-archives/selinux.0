Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2DC433DF
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7D02072D
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESZ2E0xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHQUNf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgHQUNc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 16:13:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D21C061389;
        Mon, 17 Aug 2020 13:13:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so13436843qtn.7;
        Mon, 17 Aug 2020 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zt/7bcE3rheAEIDkdYnD+DA7k8FVJTMGh0E4kEj1Ywo=;
        b=ESZ2E0xmMQv1mWWmfIDLDh8ElbMLOrMjACpT1NtfcDZAkPcK1cx7Tqq5wJCtNEoGkv
         sNw5WzTK45vDd7RivwzHNzmA+PcKiL/XxM9Ood/DKjXdOeiydUXFP/EEfZeqmRP4bw8Z
         +io4TpeIColjCVGs36mDk0I6bxguWRgcFAL3veyxZTAvhvNBDMSmG8R8h2Kt/8bndqtQ
         jQ0MZZFuMLhLKGH0ysqarbbMykNQs6XMViTx/MXWvSd6io25Qj/YSKqPwbQh0bjRTaUF
         ZsgdSXj/DbEAmcXu8+jNw9Mig59+a3k37b+Fy3vvGyZcKxqxNeP7dIRR3NMpTm1jtFcB
         ljKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zt/7bcE3rheAEIDkdYnD+DA7k8FVJTMGh0E4kEj1Ywo=;
        b=FXY5ligulFCgMjVmI5NSv7VXHK1fLdcnAuFFvLejxLhph7Jp7U4jEcoywk6QHNs3OH
         u7w5Wg2SeuLtLyaSPWNfqXmrv59COhq7gduPYpyCOK4zJMQpOJPaPUlllK5VXVgIL2n0
         vRx1CA9WLkGKo/VhR6fNwueOBKe4skuSWeEFTcJka0SaOSZgaSZyX1ztjEYgQYmoonUW
         Wj+9FolUDjELZcT5ATXpImEJ3cn6TeU4SV9hnYm84EC0NyKegEjVdc3j63neHf/KDOR1
         W+fPunQ/oO2go3B4IqLcHn3rgEmfzCy9Lj/me2zP9UMppc8Igz1JUBVBGDxHe4M8Ye78
         ehHw==
X-Gm-Message-State: AOAM531yeubrws6Nbf1d7YIeCcO6j9s2DvmCxWKEEJYymwOkLJnP5XNw
        zN9R2tCFVedMLfbHo/GKu7uBfjKNihU=
X-Google-Smtp-Source: ABdhPJx9e+AdRduaomcbQkwct21cWv/QPycXamX0237ajy9InAmdTZJ1sTza9+t49kGyOuGVwikz1w==
X-Received: by 2002:ac8:2ab9:: with SMTP id b54mr14845227qta.323.1597695211196;
        Mon, 17 Aug 2020 13:13:31 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id 95sm19509597qtc.29.2020.08.17.13.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 13:13:30 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-4-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
Date:   Mon, 17 Aug 2020 16:13:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817170729.2605279-4-tweek@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/17/20 1:07 PM, Thiébaud Weksteen wrote:

> From: Peter Enderborg <peter.enderborg@sony.com>
>
> In the print out add permissions, it will look like:
>      <...>-1042  [007] ....   201.965142: selinux_audited:
>      requested=0x4000000 denied=0x4000000 audited=0x4000000
>      result=-13
>      scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>      tcontext=system_u:object_r:bin_t:s0
>      tclass=file permissions={ !entrypoint }
>
> This patch is adding the "permissions={ !entrypoint }".
> The permissions preceded by "!" have been denied and the permissions
> without have been accepted.
>
> Note that permission filtering is done on the audited, denied or
> requested attributes.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---

Does this require a corresponding patch to userspace?  Otherwise, I get 
the following:

libtraceevent: No such file or directory
   [avc:selinux_audited] function avc_trace_perm_to_name not defined

