Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF67AEB64DD
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHDCUt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjHDCUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:20:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769D44B6
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:20:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76cc4d495deso82387385a.0
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2A36zt8dtnUsg87k3ceorvznxtuCwHOmRsl0P1K6nwY=;
        b=N0BWOx5xPWYxS9PxUFdtLS4cw5T3sFIsMtKd2GEATm8atWxZBq3P1+f4HUTX6mAyFG
         3eDMxZrMtqAb4ujfCn/BP1UMLiLl5FYYvOoQ5458QnOVckzDwZuCOiqPTltvt3KLjvfR
         i4MIhDWPmpCVmUe/jSJjljQ7n2ANHn/P2kK7IsVcSc43nnToFx4VM3mWcZYXjLOKfApS
         l99Fz/6pYmn3iJYoe3pirq2LMfcXSzVwN7tlfnPl+PMLSXbBfIdcNkAMjqY6NlXo07rF
         LFjPBH9/meWOHnQiIrpq+R7ImukUjyFFAwQYWzn8abGuhYU0Cmcv3vFd7HkVYABqps6m
         YYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A36zt8dtnUsg87k3ceorvznxtuCwHOmRsl0P1K6nwY=;
        b=aobgb2kPnfj0r7Oh8t8bu/MROYIY+J4ZlGhHup294Mp6sq0E0WoTm3Hk5yl1hwMuGh
         qkO8cstFRX2zTkn7K8Em2tatQXPSvkXc0EUA0gDxUnSAHaHVPHMioH3EMfMOOekKxqnr
         fTC7pFF7RK6ACjQu8qNqugupzQ8dv3P8G9HE3A3m2txQ/ZUBoocWkJXbnbkk0tastB1v
         muXtbUNmvjvtY6MsNfJ8WsOuwgEWKUVOEEk1vi4E9NlRKKcNdtcUufXLdw04cuTdlmki
         LOlCa7V+iIGYG4MFejB/uUwI8HpBdQbOPAnFtWbXY9MBGzW7kL/+eWrRr+wlhMRYhT7P
         1KMw==
X-Gm-Message-State: AOJu0YzFHFwV8mfpIW2ejJoYQIVU/TfTgFSyqmmJ5acwUgRyNYovhHKt
        TLZUjqjU3o8TdKsnus9aUzTQ
X-Google-Smtp-Source: AGHT+IEoS88Nucw/4DRDM1C9crvDnwJ/fmssK0XqeIvUgd7B/L/Y8iNMK64eDiDoVp+iR9EB4n8dqQ==
X-Received: by 2002:a05:620a:290b:b0:76c:cd15:a8b5 with SMTP id m11-20020a05620a290b00b0076ccd15a8b5mr771476qkp.21.1691115624509;
        Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b0076c60b95b87sm332562qkf.96.2023.08.03.19.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:23 -0400
Message-ID: <e109fc2da07fe92eecda62781201be05.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] selinux: avoid implicit conversion in nlmsgtab code
References: <20230728155501.39632-8-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-8-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use an unsigned type as loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/nlmsgtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 2ee7b4ed43ef..2f8fab949633 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -153,7 +153,8 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
>  
>  static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, size_t tabsize)
>  {
> -	int i, err = -EINVAL;
> +	u32 i;
> +	int err = -EINVAL;

I understand wanting to make 'i' unsigned, but I think unsigned int
is a better fit for an iterator and array index.

>  	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
>  		if (nlmsg_type == tab[i].nlmsg_type) {
> -- 
> 2.40.1

--
paul-moore.com
