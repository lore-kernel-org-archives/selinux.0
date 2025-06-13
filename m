Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F9191F8C;
	Fri, 13 Jun 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824129; cv=none; b=IDG1KWHvq71/r1qaqUOGO2JdDodWnJ9mtAmpm1gYSk1PHF2ajsWBJgfVtpSf8atRBwNxfyMJmWpdl9WQbOdFAbZO9NRQIoOYu9UtRcTaD5gJYt+ET2lR/jpE07j3JdPezBkSts1q2YwZoxgPERVJsyaj9MBpGyICGplq4t6lsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824129; c=relaxed/simple;
	bh=v/xoININJFp/RvAJxPK6UdCzG11l+2Z2W/DSk4lYLco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2h0+vvWGk0tizs5N8y9crsH9r7AVXXihpaHbd0UQWtc/vPNePX1/ikozXSP2dMG0kJLvIAgAvvl8tDokrYWTosWyphRPVj0qebiQw4xStoPDMfKgibWQKl4TpmYcnAhy/h6NJb0HHJDYjta1x2OpyDsj4A/0QeJC9v1pQ3bJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rupWDzGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rupWDzGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE50C4CEE3;
	Fri, 13 Jun 2025 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749824128;
	bh=v/xoININJFp/RvAJxPK6UdCzG11l+2Z2W/DSk4lYLco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rupWDzGKqAcn8gsaE8FvV5MlLv1j3oaYAqzHsimUmHTvOOUZLLX5nQz5CVSbrr4d4
	 V5wWWiEZZfMsKZ1Gal8y+jNNR53pXIKncmzI72ErwKQZnYKQPiMbVSs/OT8Ab1+MpG
	 4J3xpNlXRSRI0fNPb7N0Mp1uIG4inf0AZhLzDri9tENTypvykI8Rjp2itKG/CdbtMG
	 6uIokmTxRE1wXKK9VHdPA2tY8Bxnnkyv8mIduikLrM2ErRU3xZaZy5YKDM42kZiqxL
	 Pr3jXj9gHsH/UIyk2QjnS04nTl5//Z5pl3Zrp9glX3djf9BwKzGN4+iQJ4zfI1jKEm
	 1BXJN+bb6xogQ==
Date: Fri, 13 Jun 2025 15:15:25 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 27/42] selinux: introduce task_obj_perm()
Message-ID: <20250613141525.GG414686@horms.kernel.org>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-28-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610172226.1470741-28-stephen.smalley.work@gmail.com>

On Tue, Jun 10, 2025 at 01:21:58PM -0400, Stephen Smalley wrote:
> Introduce task_obj_perm() for namespace-aware permission checking
> between two tasks using the objective SID for both tasks and
> without assuming that either task is current.
> 
> Convert the permission checks of this form in the hook functions
> to use this new helper.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

...

> +int task_obj_has_perm(const struct task_struct *s,
> +		      const struct task_struct *t,
> +		      u16 tclass, u32 requested,
> +		      struct common_audit_data *ad)
> +{
> +	const struct cred *cred;
> +	const struct task_security_struct *tsec;
> +	struct selinux_state *state;
> +	u32 ssid;
> +	u32 tsid;
> +	int rc;
> +
> +	state = current_selinux_state;
> +	rcu_read_lock();
> +	tsec = task_security(s);
> +	if (tsec)
> +		ssid = tsec->sid;
> +	else
> +		ssid = SECINITSID_UNLABELED;

Hi Stephen,

Above it is assumed that tsec may be NULL...

> +	rcu_read_unlock();
> +
> +	do {
> +		tsid = task_sid_obj_for_state(t, state);
> +
> +		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
> +		if (rc)
> +			return rc;
> +
> +		cred = tsec->parent_cred;

... but here tsec is dereferenced without explicitly checking if it is not
NULL. I'm wondering if this is safe, e.g. due to the call to avc_has_perm().

Flagged by Smatch.

> +		if (!cred)
> +			break;
> +
> +		rcu_read_lock();
> +		tsec = selinux_cred(cred);
> +		ssid = tsec->sid;
> +		state = tsec->state;
> +		rcu_read_unlock();
> +	} while (cred);
> +
> +	return 0;
> +}

...
