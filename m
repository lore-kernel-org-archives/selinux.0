Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08C30B53C
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063260; cv=none; b=ZHGoM5mIHLUnvpmFCAypgEv8Vt/aWA98oMzuC+qer3DRiYiYuIWdJJDDrVcnJfH0/iFpumFuAa3KWwSLV2SHab0q1ynJi189B2WQr6D282qMa7jluszpJy2dFwFHM2d6dVLkZR8RA8IW1OeLZTFKBp49fcW/Cybkh22yUf0B620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063260; c=relaxed/simple;
	bh=6QeAqybwtn14hp3RuoADZ07hm0sn5o44RWbSCGSb0jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BfbU0je9gfoP57iw+BxuVhu0Tx6en4VHzzx/4RIVEdAm3E9uZ13ILUd8+w9OjmoHL9Hr+3Y/kOMhBppdxlF+yJaxKi1i7WZy2OPnXf3mdqKqlnwrZaoBfHnnbMnvpkDFh4lsrnTlPdx8/Vsdd6X67woGXkVF91lHTWZgszYWeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=rU+5xH8H; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="rU+5xH8H"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4B8AC240101
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 22:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1777063256; bh=DuESwJRXs5gJbWYn/cCWIb4GFXUWNOpwb3iMbLNbCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=rU+5xH8HLi+Q0hUG7ia6P/4EEFxWN383KQX7aLvyvAS8rjflIXSw4abbCvwl2bR5Z
	 4IxyQxLiV9jTjQTnUU7CBBMBFPV1wiFIbXtZZ0bpKahR79Y6VexTyQJ2hxQVxUMS32
	 D+/miTLy7EimBSq60/4894vSld4B7Asc//DMmQE7+73POVlw3yAniPJdofw+rvBpEr
	 ZwcinUx5qe0F9g/TY3lIUmc1zt2HsJlchmj1ZtiT5xRxYp7riQqT/pdiMghTUKKeKv
	 6/YOgVq9flQohQv8mr1Tn4YEpuDCunClPhIKmwqltZL/tr45l01QNH5vJJbYfg5+Qt
	 O+IjweyqvdEZQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g2PxM6Dm1z9rxG;
	Fri, 24 Apr 2026 22:40:55 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH v3] libsepol: policydb_read(): use a static string for
 policydb_str
In-Reply-To: <20260403065618.2172556-2-nvraxn@posteo.uk> (Rahul Sandhu's
	message of "Fri, 03 Apr 2026 06:56:31 +0000")
References: <20260403065234.2172150-2-nvraxn@posteo.uk>
	<20260403065618.2172556-2-nvraxn@posteo.uk>
Date: Fri, 24 Apr 2026 20:40:56 +0000
Message-ID: <86eck4852p.fsf@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Ping

On Fri Apr 03, 2026 at 07:56 AM BST, Rahul Sandhu wrote:
> We know the maximum possible size of policydb_str at compile time; it's
> POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
> As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
> avoiding an extra allocation.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
> ---
>  libsepol/src/policydb.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> v3: fix authorship mess
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 9760b164..8d290d86 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>  	unsigned int i, j, r_policyvers;
>  	uint32_t buf[5], nprim;
>  	size_t len, nel;
> -	char *policydb_str;
> +	char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];
>  	const struct policydb_compat_info *info;
>  	unsigned int policy_type, bufindex;
>  	ebitmap_node_t *tnode;
> @@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>  		return POLICYDB_ERROR;
>  	}
>  
> -	policydb_str = malloc(len + 1);
> -	if (!policydb_str) {
> -		ERR(fp->handle, "unable to allocate memory for policydb "
> -		    "string of length %zu", len);
> -		return POLICYDB_ERROR;
> -	}
>  	rc = next_entry(policydb_str, fp, len);
>  	if (rc < 0) {
>  		ERR(fp->handle, "truncated policydb string identifier");
> -		free(policydb_str);
>  		return POLICYDB_ERROR;
>  	}
>  	policydb_str[len] = 0;
> @@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>  		if (i == POLICYDB_TARGET_SZ) {
>  			ERR(fp->handle, "cannot find a valid target for policy "
>  				"string %s", policydb_str);
> -			free(policydb_str);
>  			return POLICYDB_ERROR;
>  		}
>  	} else {
>  		if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
>  			ERR(fp->handle, "invalid string identifier %s",
>  				policydb_str);
> -			free(policydb_str);
>  			return POLICYDB_ERROR;
>  		}
>  	}
>  
> -	/* Done with policydb_str. */
> -	free(policydb_str);
> -	policydb_str = NULL;
> -
>  	/* Read the version, config, and table sizes (and policy type if it's a module). */
>  	if (policy_type == POLICY_KERN)
>  		nel = 4;

-- 
Rahul Sandhu
