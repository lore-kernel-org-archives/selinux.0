Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC1BC433E0
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486DD2074F
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8nFTwB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgG0TEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgG0TEV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 15:04:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D998C061794;
        Mon, 27 Jul 2020 12:04:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so7158117qtq.8;
        Mon, 27 Jul 2020 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EC8zOFncLg9/ysdu+4AVfhbwIPv/GZuMddAqKzwsK50=;
        b=s8nFTwB06aWxIw0M4Qne/g67EQxVuSLuN0jAVjjFbeIiz7sbGe76pmRQFPHcAauQqn
         dEh9LPwMZMdnGYzhJGj67KPXBkfNz9RhTWvANp9G7E955VCa98N6AjCqA09D8ctAMu5Z
         IUed0je+TYyFSs7Qm/75+9K2//EMqRbW6DzbYEt+sdpt/B0EJdh5l4+Ah7N+x32hnPkj
         DSB4ED1P6KuZcn2PY9usLwRKaY6FNPtMg45uCBZpKgkzRpQSi4t6iFRbAJ9Y625zJmzr
         0GTagE/KIQ8OWhnaGremgV2+z/o4hMXOsR5uOPwpAqCq66+9wREQVn3J9m0K9LhSdI5B
         5hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EC8zOFncLg9/ysdu+4AVfhbwIPv/GZuMddAqKzwsK50=;
        b=OeVGDI3QwESk2BE14kVlwEdNr7GUcKoE+TqXwFeUKccwxsbjhWmGl1/xQ9iITTR69Q
         9exg1WiFyakqfvtRuB0VwtVSO/B7L1gEoL5tieFuUmNJrnPoyT6sgMUC+GxI3n2+nsGy
         djosJCJlDWgSkomsH94LpKDwyuIg8C1ONGpnUDwdcHKCgiFLFfxU29qYPijaOtSMpJQR
         I/08J8PmnAG7BHBi2tYGUff5aEWLErBU3mhfEL2KwvNEgtpmYx/5Mil9vJkJ1reLFTO8
         KI5Zea/8/3EBm9tBGT149/MUkUcAFqHx102ktEj7bzJFkOusFc+79mpUDVxhyHuX9taJ
         Ek5A==
X-Gm-Message-State: AOAM531/yLX97V+V+iQH/Sd/k3hGjdgzmNJc2mU82dW1L83FlkBqoOdm
        mB10Pyzcr1D0j+vPh38Hgjo=
X-Google-Smtp-Source: ABdhPJzzq1YnJnkKBN4VwnD0P3fR4BceTpVszjvHhG6SQcqO7kIwdi6a1Djd6weNjvvT1vFxx2ykNA==
X-Received: by 2002:ac8:47c8:: with SMTP id d8mr22141686qtr.32.1595876660456;
        Mon, 27 Jul 2020 12:04:20 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id e61sm15772530qtd.20.2020.07.27.12.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:04:20 -0700 (PDT)
Subject: Re: [PATCH v19 20/23] Audit: Add new record for multiple process LSM
 attributes
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, linux-audit@redhat.com,
        sds@tycho.nsa.gov
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-21-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <15b96494-c4ca-bf2f-0158-d28183d51aef@gmail.com>
Date:   Mon, 27 Jul 2020 15:04:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724203226.16374-21-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/24/20 4:32 PM, Casey Schaufler wrote:

> Create a new audit record type to contain the subject information
> when there are multiple security modules that require such data.
> This record is linked with the same timestamp and serial number.
> The record is produced only in cases where there is more than one
> security module with a process "context".
>
> Before this change the only audit events that required multiple
> records were syscall events. Several non-syscall events include
> subject contexts, so the use of audit_context data has been expanded
> as necessary.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> ---
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index c7d213c9f9d8..930432c3912e 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -672,11 +672,13 @@ static inline struct audit_buffer *xfrm_audit_start(const char *op)
>   
>   	if (audit_enabled == AUDIT_OFF)
>   		return NULL;
> +	audit_stamp_context(audit_context());
>   	audit_buf = audit_log_start(audit_context(), GFP_ATOMIC,
>   				    AUDIT_MAC_IPSEC_EVENT);
>   	if (audit_buf == NULL)
>   		return NULL;
>   	audit_log_format(audit_buf, "op=%s", op);
> +	audit_log_lsm(NULL, false);

Notice that the audit_log_start() call above specified GFP_ATOMIC. But 
your audit_log_lsm() uses GFP_KERNEL. You'll either need to always use 
GFP_ATOMIC in audit_log_lsm() or pass in the gfp flags there.  Make sure 
you test with CONFIG_DEBUG_ATOMIC_SLEEP=y and check your dmesg output.


