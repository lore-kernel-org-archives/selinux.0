Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A9C433E1
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957E82072D
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM/nc4nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHQUQb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHQUQa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 16:16:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E7C061389;
        Mon, 17 Aug 2020 13:16:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so8456539qvb.0;
        Mon, 17 Aug 2020 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mQx+fbQmT+1EgP70ieKWRjPUs6RmQ8tZtrxojwR/uWk=;
        b=NM/nc4nJZy1iiJGzonqS+Dy0ZNXqznNIAF92ubQ1Uhi7iP2yUMY5gLPiADCNzJDMki
         HbHwC5e2ZgQz6RpG9pwRgFlErzFYBJOjK7xT8Ta70Rw9wqWN5GGJjLcxuhQ7RpRzNvgw
         u3hqsq+erFtFZA72IBc9O7V/ZjyFHWETyn/Ym+mVVqezHlk05HlQfvj8tt/x78s6z8US
         MfRxe42Jv8kAnEASwrT/duqJlJWCp95v8P3cLH6xnehVWQnoq2j0TAiqvsOUoGz4KCJG
         gdZroCzeI2rDVVnZ6sh8RuZa3N20//dqh5azI9IS1BXwfL5X0mH7dW58pOgoZBO9y2xQ
         wQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mQx+fbQmT+1EgP70ieKWRjPUs6RmQ8tZtrxojwR/uWk=;
        b=oH3XEHXOGml1PZmpkpcYKr2gc2VssPc7baD4k09y0l5NEH+B7U3O7rXZvp6MiRN5Ek
         dxZlU1Jj6BsP1M6TBlQD3lu0Z5EGU2KXWJsdbb15xeOnPX7ctruh8OQlEoZgwtyNnEW4
         b8nKA2qaDrV38dieMT4iCKDBFsN8UmB6AWn24YiE1TDqHtkEnED2jm0IDN5PRLvQ8SgN
         EK0BJVsLGVeDWd4AFo/1h4QEp771tvDfE2MCy9C1oO5vgm21dtqGZrkbd1g2sy0IliiS
         HLM4+6uzWUa15AZPq2Rh8h21aoJufo0Feicc2sC9ATQy/4AdfKQbATqh+p4p8A5dI7is
         nXOg==
X-Gm-Message-State: AOAM532SNa9Sp6k2LCqDpvisIh9uBl660W30LxAq0O/vt38fZ5QFPXAy
        rkm4iEz4SnvVfX8cfk7oVwOGMjYTcdI=
X-Google-Smtp-Source: ABdhPJxnWbTgWhvO6SgB2BW2St4DBhERb+V3Zog82ZrZRFy3VQYe18bLAGXrNvOkqUG8pULy2tBKqw==
X-Received: by 2002:ad4:54b2:: with SMTP id r18mr16054029qvy.92.1597695389472;
        Mon, 17 Aug 2020 13:16:29 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id o2sm18206353qkh.102.2020.08.17.13.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 13:16:29 -0700 (PDT)
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
Message-ID: <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com>
Date:   Mon, 17 Aug 2020 16:16:28 -0400
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
>   include/trace/events/avc.h | 11 +++++++++--
>   security/selinux/avc.c     | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7de5cc5169af..d585b68c2a50 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -695,6 +695,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>   	audit_log_format(ab, " } for ");
>   }
>   
> +
>   /**
>    * avc_audit_post_callback - SELinux specific information
>    * will be called by generic audit code

Also, drop the spurious whitespace change above.


