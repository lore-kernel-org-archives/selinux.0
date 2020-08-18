Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B700C433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E580E2076E
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmNUdyoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHROgS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgHROgQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 10:36:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF1C061389;
        Tue, 18 Aug 2020 07:36:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h21so15226530qtp.11;
        Tue, 18 Aug 2020 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=syhPrpLTPHGhoYCnb/fg8zFy22s+NxIbyYHX8Ztv01w=;
        b=OmNUdyoZDA22FDYkRlFJ3PIH5KUQy3b7jRKfV1A484eoPSzMYGpbkByudOtTWqnlVs
         Zqy0LeHyINxDHcwW7cUmf5kaLo0GeHjBlk5vNKn3oaEapDWAaGamgOeLPXXDdgv3JRPy
         ri7R+foR2CSogVbRC1zhqT4mF1wCnC5LbP6AHdrhKPsAQkNZ55IoZRmfvWYt3IExfR1w
         dpPvSwzL0LpbuqbuSF7J9uenNga/m5PXkNCoRrPI9d7Bq5pGjZU47l+xSE5CmFittFa7
         lesLuPvx+DMaTPcLnkI0ErHhcNWMEUT2BLI+9kGnYto0BNiz1bMSXcZaPBdLDEr2lCw8
         d+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=syhPrpLTPHGhoYCnb/fg8zFy22s+NxIbyYHX8Ztv01w=;
        b=QhpTyJ1Yt2OovowAHxr+sC0RCSip8isogzBtpEfRj2Mbe039U07HH270tavnRvHvcp
         +b6+eReFPQF8TZMvdMGv1XiblpOX4G95KubE0iYBv61iBYP9256tmU04ZDDXcFWpFtY2
         nGrPip5PwSabHY8ww2nY5NzFueEAdwobYaH53jEqNVc6gFSWVHUcNvmMJr3gEK6qYTKI
         0tLt3tF7WKciS/D3cZ2FQd8mkp78/Ltx7iKJY6G+l1STVX3ZfxZ5eHrl/sFpfjjdk7yk
         N2roLHYxNZzhffHjL87Z/Wn70QEUo3bWIY2ICS+eLvXxkgYW6xMpaCD8MCD/ABFosw+8
         yYPQ==
X-Gm-Message-State: AOAM533IcjCXXB7MqxCX8N1RyPs1GIFAjxF5xsNcFwsiC5LX7pxElgUG
        cdDbpdqJglyk638cxk1Uu+Hm485Hq4Q=
X-Google-Smtp-Source: ABdhPJxqtZaQZ/NZc09+LZNhiAxXCqW04nX9QHTT0qrRX6H4n4LXuQ4iOzSwoX4+mlqX06AxGQjTVw==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr17771209qtr.206.1597761373332;
        Tue, 18 Aug 2020 07:36:13 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id o47sm24550478qtk.19.2020.08.18.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:36:12 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] selinux: add basic filtering for audit trace
 events
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-3-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <15e3043b-f858-541a-dd2d-7ae60b9e9822@gmail.com>
Date:   Tue, 18 Aug 2020 10:36:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817170729.2605279-3-tweek@google.com>
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
> This patch adds further attributes to the event. These attributes are
> helpful to understand the context of the message and can be used
> to filter the events.
>
> There are three common items. Source context, target context and tclass.
> There are also items from the outcome of operation performed.
>
> An event is similar to:
>             <...>-1309  [002] ....  6346.691689: selinux_audited:
>         requested=0x4000000 denied=0x4000000 audited=0x4000000
>         result=-13
>         scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>         tcontext=system_u:object_r:bin_t:s0 tclass=file
>
> With systems where many denials are occurring, it is useful to apply a
> filter. The filtering is a set of logic that is inserted with
> the filter file. Example:
>   echo "tclass==\"file\" " > events/avc/selinux_audited/filter
>
> This adds that we only get tclass=file.
>
> The trace can also have extra properties. Adding the user stack
> can be done with
>     echo 1 > options/userstacktrace
>
> Now the output will be
>           runcon-1365  [003] ....  6960.955530: selinux_audited:
>       requested=0x4000000 denied=0x4000000 audited=0x4000000
>       result=-13
>       scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>       tcontext=system_u:object_r:bin_t:s0 tclass=file
>            runcon-1365  [003] ....  6960.955560: <user stack trace>
>   =>  <00007f325b4ce45b>
>   =>  <00005607093efa57>
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> Reviewed-by: Thiébaud Weksteen <tweek@google.com>
> ---
>   diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index b0a0af778b70..7de5cc5169af 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -705,35 +705,39 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>   {
>   	struct common_audit_data *ad = a;
>   	struct selinux_audit_data *sad = ad->selinux_audit_data;
> -	char *scontext;
> +	char *scontext = NULL;
> +	char *tcontext = NULL;
> +	const char *tclass = NULL;
>   	u32 scontext_len;
> +	u32 tcontext_len;
>   	int rc;
>   
> -	trace_selinux_audited(sad);
> -
>   	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
>   				     &scontext_len);
>   	if (rc)
>   		audit_log_format(ab, " ssid=%d", sad->ssid);
>   	else {
>   		audit_log_format(ab, " scontext=%s", scontext);
> -		kfree(scontext);
>   	}
I guess technically you should drop the { } above since it is reduced to 
a single statement body.
>   
> -	rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
> -				     &scontext_len);
> +	rc = security_sid_to_context(sad->state, sad->tsid, &tcontext,
> +				     &tcontext_len);
>   	if (rc)
>   		audit_log_format(ab, " tsid=%d", sad->tsid);
>   	else {
> -		audit_log_format(ab, " tcontext=%s", scontext);
> -		kfree(scontext);
> +		audit_log_format(ab, " tcontext=%s", tcontext);
>   	}
Ditto.

