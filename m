Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E7C61D90
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjKUBaB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 20:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUBaA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 20:30:00 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF879E3
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:29:56 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso4860036276.2
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700530196; x=1701134996; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CN2C4JUqZ3eJU9QGa9mEPtzEL1EjkKnlBKdDX7+rhwg=;
        b=MbeBwLJc8xg3wjWdrMl6SB3QOLfFxO0ytOTZATnnjxrmJiktNRi+fvqD00RvbBk5pZ
         RPt9T30v0fmG7URJ7TVz7xzUr5vt0H5B7JwMqpGP2yAlurm/phBBjNSFOzB703sTV7pN
         iUFdjWHn3hlYFEMlp1a7sXkRumZZusNBEYNZK2paYxbeAkjlZuXMg1XOmo6v7VEjd5ab
         sogEGvBu+8oRcvIdt+wWrWwkkRLeL8aPFM/4B4qeork+gElT4zrehriQ4GZGBssL0LD1
         w0Xffp1msRQUKgXhYrErgyQG3ql9QlQZnpNLhNQuN7Gb1ooGum9y5Re4SQUeS191Pf4J
         i6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530196; x=1701134996;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN2C4JUqZ3eJU9QGa9mEPtzEL1EjkKnlBKdDX7+rhwg=;
        b=uhPg9ajnbvRmghgHoMJWliPGTpfCV2YFXZAkQ3cDdhjPlIyn9I5nBGWD/VIZjzdSgg
         h+YE7khc3fylE3Raesz5+HndZjlq+UTUksb1BWhkQ5+JlpS5B0FHGn2kEd+aCXQxTv+k
         aF2RA+bQZerclynBqxD4XEt1NCGeYWW2bQsj8F+Dw6nTvRPdEl9Ph2CIbOF0kNhy1J/W
         G++Ijp1Cue6wjKwwlzjogBStAK1HXXNZuqLoUEjE33zIO/VxyGnsDviu9FmpHMbhacFA
         D0Ea9vvG0UgI7caUoQ9VPespOAFeZeMtWE6srIEpSCxiZU+vt5avDKij+i8I2gwT8wAy
         H11g==
X-Gm-Message-State: AOJu0Yxv4DXRxAJ1dxq65DePXFgD+s3ctj1X95+XDbbX7eSi6uc/LiJ7
        icMazijAmLMR4ACfZ1Hs++ya
X-Google-Smtp-Source: AGHT+IEGgcAaM306WEPv9nMcoX+SXbiZlG5msJshBMJuK3nR8wLdcb6TDxsgWEo/WzSnT5OM0WliMw==
X-Received: by 2002:a81:8b4b:0:b0:5ca:ae76:1dfb with SMTP id e11-20020a818b4b000000b005caae761dfbmr4095652ywk.20.1700530196056;
        Mon, 20 Nov 2023 17:29:56 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f4-20020ad45404000000b0066d0ab215b5sm3522693qvt.13.2023.11.20.17.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:29:55 -0800 (PST)
Date:   Mon, 20 Nov 2023 20:29:54 -0500
Message-ID: <d419ff729567246c50cf52b885e76903.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, omosnace@redhat.com
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
References: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Nov  3, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
> 
> Due to how conditional rules are written in the binary policy, the
> code responsible for loading does not know how many conditional rules
> there are before creating the avtab structure. Instead, it uses the
> number of elements in the non-conditional avtab as a hint and allocates
> the hash table based on it. In the refpolicy and default Fedora policy,
> the actual sizes of these tables are not similar (~85k vs ~10k) thereby
> creating more slots than needed and resulting in wasted memory.
> 
> This patch introduces a two-pass algorithm to calculate the conditional
> rule count before allocating the avtab nodes array. Albeit with a slight
> performance penalty in reading a portion of the binary policy twice,
> this causes the number of hash slots for the conditional array to become
> 4096 instead of 32768. At 8-bytes per slot on 64-bit architectures, this
> results in a net savings of 224 KB of heap memory.
> 
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c       | 15 ++++++++++--
>  security/selinux/ss/avtab.h       |  2 +-
>  security/selinux/ss/conditional.c | 38 ++++++++++++++++++++-----------
>  security/selinux/ss/conditional.h |  2 +-
>  4 files changed, 40 insertions(+), 17 deletions(-)

...

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 81ff676f209a..810319bf0e60 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -407,16 +408,17 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>  			return -EINVAL;
>  	}
>  
> -	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
> +	rc = cond_read_av_list(p, fp, &node->true_list, NULL, nrules);
>  	if (rc)
>  		return rc;
> -	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
> +	return cond_read_av_list(p, fp, &node->false_list, &node->true_list, nrules);
>  }
>  
> -int cond_read_list(struct policydb *p, void *fp)
> +int cond_read_list(struct policydb *p, struct policy_file *fp)
>  {
>  	__le32 buf[1];
> -	u32 i, len;
> +	struct policy_file tmp_fp;
> +	u32 i, len, nrules;
>  	int rc;
>  
>  	rc = next_entry(buf, fp, sizeof(buf));
> @@ -428,15 +430,25 @@ int cond_read_list(struct policydb *p, void *fp)
>  	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
>  	if (!p->cond_list)
>  		return -ENOMEM;
> +	p->cond_list_len = len;
> +
> +	/* first pass to only calculate the avrule count */
> +	tmp_fp = *fp;
> +	nrules = 0;
> +	for (i = 0; i < p->cond_list_len; i++) {
> +		rc = cond_read_node(p, &p->cond_list[i], &tmp_fp, &nrules);
> +		if (rc)
> +			goto err;
> +		cond_node_destroy(&p->cond_list[i]);
> +	}

I'm a concerned about all the work we have to do just to count the
conditional rules.  Other than not working with existing binary
policies, have you looked at bumping the policy version and introducing
a binary format change that would include the number of conditional
rules?

--
paul-moore.com
