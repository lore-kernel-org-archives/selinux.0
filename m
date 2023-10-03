Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE83E8FDB3
	for <selinux@archiver.kernel.org>; Tue,  3 Oct 2023 21:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjJCVHO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJCVHN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Oct 2023 17:07:13 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94023AB
        for <selinux@vger.kernel.org>; Tue,  3 Oct 2023 14:07:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4180adafdc6so9263031cf.2
        for <selinux@vger.kernel.org>; Tue, 03 Oct 2023 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696367226; x=1696972026; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+e2WBB/xTlXUjcQw4K9zxRBKJ4x1qCbCOKFnQdQRMDc=;
        b=Pd1YHk2W+XbNAE/RsUzjE66sN5whlZkREYyYyGzCi/8FsZ0VqG1oLcNF0Z9HyuJUOc
         QSMyW+adAYQ0HL7A5KhyS799hUN+0+vJ9cdSWYWDjYpq6XrTWRifVXek6P3Kmoi+IywA
         490vy+JzCiKREXLbyjYdnhJo1+B7fOcyjRlVum+xGFZSKb2qBw5xOcezHT4wRRWr8DBJ
         uzfFQiJ+iGA1BFc1PBnzIH4TZxn94ILKv81ab40eYdUQteCt9Ovsq62Lmk2VPXVeaQXn
         VBercTT9kXX0JLaFPTbJ1Wbtj2OmcJ4eqs16q4POTFDWozJMfTkX1ILuwABES2ma2Y8e
         OAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367226; x=1696972026;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+e2WBB/xTlXUjcQw4K9zxRBKJ4x1qCbCOKFnQdQRMDc=;
        b=Z9v2ghcogEQ5cEwoMGb85p0D3rDOQD4AIxr4k2itO39bSuZSgPYPV8tIeGDRH+FFO4
         X6GSgFeWrVbanl5xah66PQIkoFRcLgPZLHEDCX+bZb6krDu6q5vTsmRK09dgj7TNy8+2
         YGRbnOaH/Pqpb9s6m7KXZaI0RwQ+ziA0XbyLs1yFBGlUqSonJpjK1yxR+HfpxuuNPXnU
         ncmGLSRTOe+IQAZVE9M/0QeBRGwU2Y1bppHKIXw7QElLa7fZbxt1lAU0cVrH3qt0vjZo
         IeoR2eRU27MwIm0ah2qFZaap7hNCUUKpOK8qf053MaLZbTo/e4xWB43+DvhHR5Z8LhMk
         K4/w==
X-Gm-Message-State: AOJu0Yz6dSeFiMX5krRZD3S7aVE/a7Q+8ylddMA4uYqMFLZnseTGpgNy
        48QPD6b796+dNIiJJ1wqgFU3
X-Google-Smtp-Source: AGHT+IGDS98DTBku8+xjSEMel2utdFJvolvtXS5Lvf4v/bDkPasNJLUzk3JtrbVN5fitlbhb8Aqcyg==
X-Received: by 2002:a05:622a:393:b0:412:1e4c:e858 with SMTP id j19-20020a05622a039300b004121e4ce858mr631150qtx.36.1696367226650;
        Tue, 03 Oct 2023 14:07:06 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l17-20020ac84591000000b00419b5274381sm411129qtn.94.2023.10.03.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:07:06 -0700 (PDT)
Date:   Tue, 03 Oct 2023 17:07:05 -0400
Message-ID: <35e5e2d03267228696d78a06bfac9b73.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, omosnace@redhat.com
Subject: Re: [PATCH 2/4] selinux: refactor avtab_node comparisons
References: <20230929195617.65120-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20230929195617.65120-3-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sep 29, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
> 
> In four separate functions within avtab, the same comparison logic is
> used. The only difference is how the result is handled or whether there
> is a unique specifier value to be checked for or used.
> 
> Extracting this functionality into the avtab_node_cmp() function unifies
> the comparison logic between searching and insertion and gets rid of
> duplicative code so that the implementation is easier to maintain.
> 
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 60 deletions(-)

Thanks for doing this.  I've got a few small nits (below), but overall
I think this is a nice improvement.

> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 8751a602ead2..1cd4fed30bf7 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -96,12 +96,34 @@ avtab_insert_node(struct avtab *h, struct avtab_node **dst,
>  	return newnode;
>  }
>  
> +static int avtab_node_cmp(const struct avtab_key *key1,
> +			  const struct avtab_key *key2)
> +{
> +	u16 specified = key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +
> +	if (key1->source_type == key2->source_type &&
> +		key1->target_type == key2->target_type &&
> +		key1->target_class == key2->target_class &&
> +		(specified & key2->specified))
> +		return 0;

Normally I'd be a nice guy and fix this up during the merge, but
since I'd like a respin for other reasons I'm going to mention
this so you can fix it yourself, and learn a bit for next time ;)

Please don't needlessly indent multi-line if-conditionals.  As an
example, here is what I would have preferred to see for the above
if-statement:

  if (key1->source_type == key2->source_type &&
      key1->target_type == key2->target_type &&
      key1->target_class == key2->target_class &&
      (specified & key2->specified))
          return 0;

At some point in the future (hopefully soon, but my review backlog
is daunting at the moment) we'll have some automated tools to help
identify problems like this, but we're not there quite yet.

> +	if (key1->source_type < key2->source_type)
> +		return -1;
> +	if (key1->source_type == key2->source_type &&
> +		key1->target_type < key2->target_type)
> +		return -1;
> +	if (key1->source_type == key2->source_type &&
> +		key1->target_type == key2->target_type &&
> +		key1->target_class < key2->target_class)
> +		return -1;
> +	return 1;
> +}
> +
>  static int avtab_insert(struct avtab *h, const struct avtab_key *key,
>  			const struct avtab_datum *datum)
>  {
>  	u32 hvalue;
>  	struct avtab_node *prev, *cur, *newnode;
> -	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +	int cmp;
>  
>  	if (!h || !h->nslot || h->nel == U32_MAX)
>  		return -EINVAL;
> @@ -110,23 +132,11 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur;
>  	     prev = cur, cur = cur->next) {
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class == cur->key.target_class &&
> -		    (specified & cur->key.specified)) {
> -			/* extended perms may not be unique */
> -			if (specified & AVTAB_XPERMS)
> -				break;
> +		cmp = avtab_node_cmp(key, &cur->key);
> +		/* extended perms may not be unique */
> +		if (unlikely(cmp == 0 && !(key->specified & AVTAB_XPERMS)))
>  			return -EEXIST;
> -		}

I'm generally not a big fan of the unlikely()/likely() macros unless
it is a rather extreme case, please don't add one here.

> -		if (key->source_type < cur->key.source_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type < cur->key.target_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class < cur->key.target_class)
> +		if (cmp <= 0)
>  			break;

I wonder if we should put the `cmp <= 0` (no match) check first since
that will probably the more common case, right?  Or am I thinking of
this backwards?

>  	}
>  
> @@ -148,7 +158,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
>  {
>  	u32 hvalue;
>  	struct avtab_node *prev, *cur;
> -	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +	int cmp;
>  
>  	if (!h || !h->nslot || h->nel == U32_MAX)
>  		return NULL;
> @@ -156,19 +166,8 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur;
>  	     prev = cur, cur = cur->next) {
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class == cur->key.target_class &&
> -		    (specified & cur->key.specified))
> -			break;
> -		if (key->source_type < cur->key.source_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type < cur->key.target_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class < cur->key.target_class)
> +		cmp = avtab_node_cmp(key, &cur->key);
> +		if (cmp <= 0)
>  			break;
>  	}
>  	return avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalue],
> @@ -183,7 +182,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  {
>  	u32 hvalue;
>  	struct avtab_node *cur;
> -	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +	int cmp;
>  
>  	if (!h || !h->nslot)
>  		return NULL;
> @@ -191,20 +190,10 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  	hvalue = avtab_hash(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur;
>  	     cur = cur->next) {
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class == cur->key.target_class &&
> -		    (specified & cur->key.specified))
> +		cmp = avtab_node_cmp(key, &cur->key);
> +		if (cmp == 0)
>  			return cur;
> -
> -		if (key->source_type < cur->key.source_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type < cur->key.target_type)
> -			break;
> -		if (key->source_type == cur->key.source_type &&
> -		    key->target_type == cur->key.target_type &&
> -		    key->target_class < cur->key.target_class)
> +		if (cmp < 0)
>  			break;

See the ordering comment/question above in avtab_insert().  I'm
reasonably confident in the search case there will be more misses
than hits.

>  	}
>  	return NULL;
> @@ -213,27 +202,19 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  struct avtab_node*
>  avtab_search_node_next(struct avtab_node *node, u16 specified)
>  {
> +	struct avtab_key tmp_key;
>  	struct avtab_node *cur;
> +	int cmp;
>  
>  	if (!node)
>  		return NULL;
> -
> -	specified &= ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +	tmp_key = node->key;
> +	tmp_key.specified = specified;
>  	for (cur = node->next; cur; cur = cur->next) {
> -		if (node->key.source_type == cur->key.source_type &&
> -		    node->key.target_type == cur->key.target_type &&
> -		    node->key.target_class == cur->key.target_class &&
> -		    (specified & cur->key.specified))
> +		cmp = avtab_node_cmp(&tmp_key, &cur->key);
> +		if (cmp == 0)
>  			return cur;
> -
> -		if (node->key.source_type < cur->key.source_type)
> -			break;
> -		if (node->key.source_type == cur->key.source_type &&
> -		    node->key.target_type < cur->key.target_type)
> -			break;
> -		if (node->key.source_type == cur->key.source_type &&
> -		    node->key.target_type == cur->key.target_type &&
> -		    node->key.target_class < cur->key.target_class)
> +		if (cmp < 0)
>  			break;

Another ordering spot.

>  	}
>  	return NULL;
> -- 
> 2.41.0

--
paul-moore.com
