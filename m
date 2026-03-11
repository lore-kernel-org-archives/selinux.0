Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D334D93C;
	Wed, 11 Mar 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259074; cv=none; b=MREy0gm9xVUtuGs8gpJYqPmXI0MzYNXdeReRwlNTsoeoji8vUOa19L76JnqbjugGzk58zf6HDheCnpqwEzKU7j+Ds1OOJ+/lb530gpAAaE2DwnkcghKR3koTVQV7Rw4yXj3BibU45DVyVAnvEpP6KIRZMG/m10LWp6jImmEyVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259074; c=relaxed/simple;
	bh=C/RJm1XcMZfzEl62uGg7VhyG8du/kJPlhR3d5Crfw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDa5vRu6PJjNMdkzPXj30khz+iKroGVYSjPNgwIb7TaVyRZJlktoNbY14wRgZg45FyUy8S7dD2ra2xE2Bpelg2hYrFCIRpOYkQ+fI7T8V1tMhuIywxAla8cxu7ON2fyc2alN892ASl7AgFsrwEYhFy4v+B8F+yvnl6jzDVv84r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVl5skXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVl5skXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D283C4CEF7;
	Wed, 11 Mar 2026 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773259073;
	bh=C/RJm1XcMZfzEl62uGg7VhyG8du/kJPlhR3d5Crfw/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVl5skXq5uziY9IXOd/6iaSzAKPTxijnhvsX6/7CJSl2Voy+dMe8q5YwuKTi2FUpp
	 DBUmmCwEwGY00adIjnV3mBtC1bEie4gPqpo3/my9SKLHhkYmumgFAZhUnJ8aQrOOOT
	 1CxAPzOZ1p3+Ov3VPFmyeuOeA7i9ZemUWVUdGyWSJAKE5eR4/wp2Q8TAgeBTqlr0ga
	 fW6A6HBaDSJ9QkL1KASacUTjLZJlwhgYwAzbIWgzFCHfIepXu6TL5ar9Dnys+sQPQL
	 OHW/U8fUMkSGbT1TxlxnU7PcbwLoyAtq8iKpvhHrFsCUlFrC9vshciVqysd+GZbaFo
	 zLm293U7uBTYg==
From: Simon Horman <horms@kernel.org>
To: antony.antony@secunet.com
Cc: Simon Horman <horms@kernel.org>,
	evitayan@google.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	herbert@gondor.apana.org.au,
	paul@paul-moore.com,
	devel@linux-ipsec.org,
	davem@davemloft.net,
	nakam@linux-ipv6.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	stephen.smalley.work@gmail.com,
	steffen.klassert@secunet.com,
	selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chiachangwang@google.com,
	omosnace@redhat.com,
	corbet@lwn.net,
	dsahern@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [ipsec-next,v6,12/14] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
Date: Wed, 11 Mar 2026 19:57:31 +0000
Message-ID: <20260311195731.1147919-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <migrate-state-v6-12-9df9764ddb9e@secunet.com>
References: <migrate-state-v6-12-9df9764ddb9e@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration

This patch adds a new netlink method to migrate a single xfrm_state.
Unlike the existing migration mechanism (SA + policy), this supports
migrating only the SA and allows changing the reqid.

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 4b29ab92c2a7..ae2a1cf2311a 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -683,11 +683,17 @@ struct xfrm_migrate {
>  	xfrm_address_t		new_daddr;
>  	xfrm_address_t		new_saddr;
>  	struct xfrm_encap_tmpl *encap;
> -	struct xfrm_user_offload *xuo;
> +	struct xfrm_user_offload xuo;

[ ... ]

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 2f23ca5b62a9..de8b038fc08c 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4642,6 +4642,19 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
>  	return 0;
>  }
>
> +/* Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
> + * from the existing SA unchanged.
> + */
> +static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
> +				  const struct xfrm_state *x)
> +{
> +	mp->smark                  = x->props.smark;
> +	mp->new_reqid              = x->props.reqid;
> +	mp->nat_keepalive_interval = x->nat_keepalive_interval;
> +	mp->mapping_maxage         = x->mapping_maxage;
> +	mp->new_mark               = x->mark;
> +}
> +
>  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		 struct xfrm_migrate *m, int num_migrate,
>  		 struct xfrm_kmaddress *k, struct net *net,
> @@ -4680,7 +4693,10 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  			x_cur[nx_cur] = x;
>  			nx_cur++;
>  			mp->encap = encap;
> -			mp->xuo = xuo;
> +			if (xuo)
> +				mp->xuo = *xuo;
                                     ^^^^
>  			xfrm_migrate_copy_old(mp, x);
>

What happens to mp->xuo when xuo is NULL?

The xfrm_migrate structure changed its xuo field from a pointer
(struct xfrm_user_offload *xuo) to an embedded value
(struct xfrm_user_offload xuo).

In xfrm_migrate(), when the xuo parameter is NULL (PF_KEY path via
pfkey_migrate, or XFRM_MSG_MIGRATE without XFRMA_OFFLOAD_DEV), the
'if (xuo) mp->xuo = *xuo' branch is skipped, leaving mp->xuo with
uninitialized stack data.

Both callers declare 'struct xfrm_migrate m[XFRM_MAX_DEPTH]' on the
stack without zeroing:

net/key/af_key.c:pfkey_migrate() {
    struct xfrm_migrate m[XFRM_MAX_DEPTH];
    ...
    err = xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
                       k.local && k.remote ? &k : NULL, net,
                       NULL, 0, NULL);
}

net/xfrm/xfrm_user.c:xfrm_do_migrate() {
    struct xfrm_migrate m[XFRM_MAX_DEPTH];
    ...
    err = xfrm_migrate(&sel, dir, type, m, n, k, net, encap, xuo, extack);
}

The uninitialized mp->xuo.ifindex is later read in
xfrm_state_migrate_create() and xfrm_state_migrate_install():

net/xfrm/xfrm_state.c:xfrm_state_migrate_create() {
    ...
    /* configure the hardware if offload is requested */
    if (m->xuo.ifindex && xfrm_dev_state_add(net, xc, &m->xuo, extack))
        goto error;
}

net/xfrm/xfrm_state.c:xfrm_state_migrate_install() {
    ...
    if (xfrm_state_add(xc) < 0) {
        NL_SET_ERR_MSG(extack, "Failed to add migrated state");
        if (m->xuo.ifindex)
            xfrm_dev_state_delete(xc);
        ...
    }
}

If the stack garbage contains a non-zero ifindex value,
xfrm_dev_state_add() will be called with random ifindex and flags,
potentially causing spurious hardware offload attempts or migration
failures.

Previously, 'mp->xuo = xuo' unconditionally set the pointer to NULL in
these paths, which was then properly checked as 'if (m->xuo)'.

Should mp->xuo be zero-initialized when xuo is NULL, either by adding
'else memset(&mp->xuo, 0, sizeof(mp->xuo))' after the if-block, or by
zero-initializing the m[] arrays in the callers?
