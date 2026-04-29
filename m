Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3223FD14E
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469533; cv=none; b=RXlkjfXwZlS0TTtOsQDUUXU7DPUirbNMGQsmCH4n8QOmIiZMNenmCO5xgCPgDW/R39ChAju6x3uQ6Tw3G9+UHWXDx7KL1Ed3f2z2Hh7KREy/JBDiIVHQeHZ81Hpb8vWibjnYNUKLpc+4HZzkR8EXBuQkSDo8kGolhxU7XxuZyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469533; c=relaxed/simple;
	bh=T4asm63qqY8qTcoRA9z3TN/UaiEY3ZHLucVm74NOJS4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SoRcaszqmqt9CfhWMBViZ5Fn+auhMf0p/8o9fwdbF5h+VhFHg/cA8Sry60dJXwqFV10nDtsoJGW9LDaWhh3YeN0G1TqMAO6og2jBboTl+VrJoJxdgoQEApV7dOSjl0ydKeCZ5roT8MWWAsJrapsmZtMGOipzcF1U7iDFzP8/ydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJXbEbxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJXbEbxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777469530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdEJqU594wHdwSCbSYivSXwMMJ7gi6Bb81x0yF6wIdA=;
	b=MJXbEbxFP405SeKndp1xdo3og+VRuKqlovCl9V300GjJ5kesoOU4cOaKvN3/2F+qqiSrNV
	hWNvP+ji65fCmj4O8BHQyfT5ElrnOZsz3re2Cbu45nr3uJCNTm1OJpimYAtpmYwu0B+xcx
	rrGiMDcJO77D3YX4t4p69zYesO69u/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-FxxD_9m-P0GIHGoHF_YIeQ-1; Wed,
 29 Apr 2026 09:32:06 -0400
X-MC-Unique: FxxD_9m-P0GIHGoHF_YIeQ-1
X-Mimecast-MFC-AGG-ID: FxxD_9m-P0GIHGoHF_YIeQ_1777469525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9901180059A
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 13:32:05 +0000 (UTC)
Received: from localhost (unknown [10.44.48.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4476D18001CD;
	Wed, 29 Apr 2026 13:32:05 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2] libsepol: Fix memory leak in
 role_dominates_copy_callback
In-Reply-To: <20260428213444.907701-1-vmojzis@redhat.com>
References: <87zf2nsl6g.fsf@redhat.com>
 <20260428213444.907701-1-vmojzis@redhat.com>
Date: Wed, 29 Apr 2026 15:32:04 +0200
Message-ID: <87qznxsxij.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
> No changes, only added "Signed-off-by".
>
>  libsepol/src/expand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 5b2b7b03..c7978948 100644
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
> 2.53.0

