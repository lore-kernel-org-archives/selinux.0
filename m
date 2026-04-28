Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BD344D9B
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354447; cv=none; b=eKkxwgLeLptZbU5P5qpLo+ftz6u8fJYganZC5k/d6azwcuLzeBzQNDoIi9f+A2/Wcyk6BoaB6cs+AjXK1ncD6XIeWIWtCTg1a4F4Lkw2u5Ksen47d6W3RR99smVJC4k/f6ZVOwxHfK9i6SUe5AjEYU6OPvsdxtph298wTXswBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354447; c=relaxed/simple;
	bh=UFfnU9bA/keuYoWZ+SXDbKQin9YQHqC8bbVvY4LiSmQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H57CXap6ku37pLmjqy9mQ2zHkY5JZZWSTXTyIeLF5M5s6BLKXCuZgveCG7l0quwNE35ub2PPH3U6yI5aRSI8bVv+cqgRCBNsQxeT573hAMIYNxykoxqci741DO/JT7733oNlc9OWacCxzE9L4hve58M9kSTY6e8oegC+X4Xj/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxlF9qkr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxlF9qkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777354444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QyL+kijBnXiHob1OK1jaSq0xpKH23qDjFhajh5RZ40=;
	b=hxlF9qkrtbeMDEcgOepxOgmdCEBT1286Pi+J8SmXOWxEzS74ksMcNjqYfJrdj+jfOfxIG3
	rnv2LgylHw7HhS2Y/MGDt/KtHBtQ0+YaFbh47pM+WcqLaopM7Cmb3rLkz/C5bdlz/QRAFA
	Zczs1NsWAsU2RGujcVfo8G+mUT4SQ2Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-4jz6_WAqOJOh6yf3OWVOoQ-1; Tue,
 28 Apr 2026 01:34:02 -0400
X-MC-Unique: 4jz6_WAqOJOh6yf3OWVOoQ-1
X-Mimecast-MFC-AGG-ID: 4jz6_WAqOJOh6yf3OWVOoQ_1777354441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A9B41800473
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 05:34:01 +0000 (UTC)
Received: from localhost (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D74CB19560AB;
	Tue, 28 Apr 2026 05:34:00 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol: Fix memory leak in role_dominates_copy_callback
In-Reply-To: <20260317211105.2485247-1-vmojzis@redhat.com>
References: <20260317211105.2485247-1-vmojzis@redhat.com>
Date: Tue, 28 Apr 2026 07:33:59 +0200
Message-ID: <87zf2nsl6g.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Vit Mojzis <vmojzis@redhat.com> writes:

> Free memory allocated by map_ebitmap in case ebitmap_union fails.
>
> Fixes:
>   Defect type: RESOURCE_LEAK
>   libsepol-3.10/src/expand.c:828:2: alloc_arg: "map_ebitmap" allocates memory that is stored into "mapped.node".
>   libsepol-3.10/src/expand.c:68:3: alloc_arg: "ebitmap_set_bit" allocates memory that is stored into "dst->node".
>   libsepol-3.10/src/ebitmap.c:420:2: alloc_fn: Storage is returned from allocation function "malloc".
>   libsepol-3.10/src/ebitmap.c:420:2: assign: Assigning: "new" = "(ebitmap_node_t *)malloc(24UL)".
>   libsepol-3.10/src/ebitmap.c:437:3: assign: Assigning: "e->node" = "new".
>   libsepol-3.10/src/expand.c:831:3: leaked_storage: Variable "mapped" going out of scope leaks the storage "mapped.node" points to.
>   \#   829|   		return -1;
>   \#   830|   	if (ebitmap_union(&new_role->dominates, &mapped))
>   \#   831|-> 		return -1;
>   \#   832|   	ebitmap_destroy(&mapped);
>   \#   833|
>

Missing Signed-of-by tag.

> ---
>  libsepol/src/expand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index ed912b57..72804f60 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -827,8 +827,10 @@ static int role_dominates_copy_callback(hashtab_key_t key __attribute__ ((unused
>  
>  	if (map_ebitmap(&role->dominates, &mapped, state->rolemap))
>  		return -1;
> -	if (ebitmap_union(&new_role->dominates, &mapped))
> +	if (ebitmap_union(&new_role->dominates, &mapped)) {
> +		ebitmap_destroy(&mapped);
>  		return -1;
> +	}
>  	ebitmap_destroy(&mapped);
>  
>  	return 0;
> -- 
> 2.52.0

