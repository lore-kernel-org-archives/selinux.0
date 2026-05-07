Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746013A783C;
	Thu,  7 May 2026 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145156; cv=none; b=quISsd6iGRG3+dpPg4wUVCrZB9ZrNPtPMDi4Mz90vG1Ub0sxBzDn3mChs+vJjKB49IQL6t7VgiKj8Q/ZoeHybHuglV+LJECB1f7iukW1zWmebDz5S9I6CXVB9EcFTcc1hwoqIGKoYiXxmFcXllAWNLk8aMPH4Or/XLJFB61d5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145156; c=relaxed/simple;
	bh=TpAH4ly1JvzSBPKPKez3qwvO9mLMoA6jZXSQAGqWwJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTsZ6r9BugahesEqzrru2EZvXkhxS+RGuY7doDGRpKBYvE1qSo1q2KgRZQs8AkHAHY3QVhZqjC8DQBgo8H1yxitonzldGmW3sXaSPoyPXQPp+MjWouGNzUqGXQo/WNmdEAzjkX+IugEnguW2ZcJcMehFqYkYRZdxxmRnQKcCJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HLiDjvEU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HLiDjvEU"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1E093207BE;
	Thu,  7 May 2026 11:12:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L46hcP1uUZqt; Thu,  7 May 2026 11:12:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 57AB320538;
	Thu,  7 May 2026 11:12:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 57AB320538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778145142;
	bh=a5m+ellgDoNWmkgUOHOlkJbkKAnPK7OIv3NtKD+YVYM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HLiDjvEURj3ZZ5A52+qlzNbT0c1HHlrFlaa2Mo1fbn9Oq41ZlKIroh4agYnqsua7y
	 uBaXUIB8zf1JT/WTbjrvL706dDIh2Jjp5K3MGfp+w4bNgQ3/yKFMoaACsgV7w8ijyF
	 84yv0YVMbs4c3K9tf4jSFR9J8ol123aQCic+Rouxp10zN4nnbFvL2ryW/gfI8p3BO1
	 J23gzwFfy+qrwJRKjNdjVnF/1O5Pkmd6WpAxLV04OqZvT286YAi+0dScTxfAn9LPGl
	 2p0dFeYwvu8VSAUVp7GSTulZmTX9xgs1iuiBc8m3x6QV6oDOo1fspXvyfvKh0AGZwE
	 55JgJBLiohkiQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 11:12:20 +0200
Received: (nullmailer pid 1495340 invoked by uid 1000);
	Thu, 07 May 2026 09:12:19 -0000
Date: Thu, 7 May 2026 11:12:19 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide NAKAMURA
	<nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next v8 12/14] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <afxXc2T3lOWuhyvq@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-12-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-12-4578fb016965@secunet.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, May 05, 2026 at 06:34:29AM +0200, Antony Antony wrote:
> Add a new netlink method to migrate a single xfrm_state.
> Unlike the existing migration mechanism (SA + policy), this
> supports migrating only the SA and allows changing the reqid.
> 
> The SA is looked up via xfrm_usersa_id, which uniquely
> identifies it, so old_saddr is not needed. old_daddr is carried in
> xfrm_usersa_id.daddr.
> 
> The reqid is invariant in the old migration.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ---
> v7->v8: - removed the unknown-flags validation block
> v6->v7: - add flags field to xfrm_user_migrate_state (based on Sabrina's feedback)
>   - add XFRM_MIGRATE_STATE_NO_OFFLOAD (bit 0): suppresses offload
>   - omit-to-inherit; mutually exclusive with XFRMA_OFFLOAD_DEV
>   - zero-initialize struct xfrm_migrate m[XFRM_MAX_DEPTH]
>   - add struct xfrm_selector new_sel to xfrm_user_migrate_state
>   - add XFRM_MIGRATE_STATE_UPDATE_SEL: derive new selector
>     from SA addresses when old selector is a single-host match
> v5->v6: - (Feedback from Sabrina's review)
>   - reqid change: use xfrm_state_add, not xfrm_state_insert
>   - encap and xuo: use nla_data() directly, no kmemdup needed
>   - notification failure is non-fatal: set extack warning, return 0
>   - drop state direction, x->dir, check, not required
>   - reverse xmas tree local variable ordering
>   - use NL_SET_ERR_MSG_WEAK for clone failure message
>   - fix implicit padding in xfrm_user_migrate_state uapi struct
>   - support XFRMA_SET_MARK/XFRMA_SET_MARK_MASK in XFRM_MSG_MIGRATE_STATE
> v4->v5: - set portid, seq in XFRM_MSG_MIGRATE_STATE netlink notification
>   - rename error label to out for clarity
>   - add locking and synchronize after cloning
>   - change some if(x) to if(!x) for clarity
>   - call __xfrm_state_delete() inside the lock
>   - return error from xfrm_send_migrate_state() instead of always returning 0
> v3->v4: preserve reqid invariant for each state migrated
> v2->v3: free the skb on the error path
> v1->v2: merged next patch here to fix use uninitialized value
>   - removed unnecessary inline
>   - added const when possible
> ---
>  include/net/xfrm.h          |  16 ++-
>  include/uapi/linux/xfrm.h   |  21 ++++
>  net/xfrm/xfrm_device.c      |   2 +-
>  net/xfrm/xfrm_policy.c      |  19 +++
>  net/xfrm/xfrm_state.c       |  29 +++--
>  net/xfrm/xfrm_user.c        | 281 +++++++++++++++++++++++++++++++++++++++++++-
>  security/selinux/nlmsgtab.c |   3 +-
>  7 files changed, 357 insertions(+), 14 deletions(-)

...

> +static unsigned int xfrm_migrate_state_msgsize(const struct xfrm_migrate *m,
> +					       u8 dir)
> +{
> +	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
> +		(m->encap ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0) +
> +		(m->xuo ? nla_total_size(sizeof(struct xfrm_user_offload)) : 0) +
> +		(m->new_mark ? nla_total_size(sizeof(struct xfrm_mark)) : 0) +
> +		(m->smark.v ? nla_total_size(sizeof(u32)) * 2 : 0) + /* SET_MARK + SET_MARK_MASK */

xfrm_smark_put() checks (m->v | m->m), maybe you should
do (m->smark.v | m->smark.m) here.

> +		(m->mapping_maxage ? nla_total_size(sizeof(u32)) : 0) +
> +		(m->nat_keepalive_interval ? nla_total_size(sizeof(u32)) : 0) +
> +		(dir ? nla_total_size(sizeof(u8)) : 0); /* XFRMA_SA_DIR */
> +}

Also, the function is not really readable.

> +
> +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> +				   const struct xfrm_migrate *m,
> +				   u8 dir, u32 portid, u32 seq)
> +{
> +	int err;
> +	struct sk_buff *skb;
> +	struct net *net = &init_net;

This is wrong. I know we had this in the tree for ages, but I now have
a fix in ipsec/testing for it. We need to make this namespace aware.

