Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D391DA4E;
	Fri, 13 Dec 2024 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128047; cv=none; b=d4ttfhwvovyXLTXj+Pussb/iL6MzKybBtrsABDlWlsbdR24tRc3lmPmOtwfqh+KSRT6TsjXzfqj5hqdPlsdAIEPsrBp+jSqEFJPuDbpn/YYyc6MGv5ResNFOtITt4vNG9nUtd/pfW+T3wdgHzu/lBet5gqMnK+nrvtTa+k/ZQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128047; c=relaxed/simple;
	bh=p6azuCGDAQ368IPG1UHvcab+/xjfcbSl30BEUtyq9iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/ikqZQnLhFRZd85V4Qoa833DqsuCc0Hbvd90fpR4D33LNKHHT1zsrOJK8PUk3m4jQF8tqHJBm7Ii/eVC1qb2RRGlZjPkrxCxRhsqwbKPMBDZ7xHCwE8NjLcvA5PzHQDQC/8nM+vlMPJ/bY5U2V7zmw4VYAf9ZKaeg2Wag6TE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SbB9Y4Qf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SbB9Y4Qf"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76B2A204BAAD;
	Fri, 13 Dec 2024 14:14:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76B2A204BAAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734128044;
	bh=ARhpVWdQ9m1LpYAgpdtfmoz7VO0HAepK+OcoHk5+EM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbB9Y4QfbP6hNTxKJNfvKWPyjjeOwbltLawMjY5LB1yDlVPC9LFL5fXaOGCfOODLN
	 Ft/OZ1qyYhvxmpXkjkgp18IJ6EblZDre1urAAt3nKyb0HZBPkvrQoRqMGtV7Ia3Z6u
	 TnjlXUzaXLiFlFGQSiEldDoek94xLpAiBycG88Kc=
Message-ID: <c4416dfa-ed1c-479d-9558-252775f3b8b6@linux.microsoft.com>
Date: Fri, 13 Dec 2024 17:14:03 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/22] selinux: restrict policy strings
To: cgzones@googlemail.com, selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-22-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241115133619.114393-22-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/2024 8:35 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> Validate the characters and the lengths of strings parsed from binary
> policies.
> 
>    * Disallow control characters
>    * Limit characters of identifiers to alphanumeric, underscore, dash,
>      and dot
>    * Limit identifiers in length to 128, expect types to 1024 and
>      categories to 32, characters (excluding NUL-terminator)
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   security/selinux/ss/conditional.c |  2 +-
>   security/selinux/ss/policydb.c    | 60 ++++++++++++++++++++-----------
>   security/selinux/ss/policydb.h    |  5 ++-
>   3 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index d37b4bdf6ba9..346102417cbf 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -280,7 +280,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   
>   	len = le32_to_cpu(buf[2]);
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto err;
>

It would be nice if these limits were named constants instead of magic 
numbers.  Right now it's hard to tell if all the "128"s are essentially 
the same limit referenced in different places, or if they could (in 
theory) be changed independently.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 917b468c5144..d98dfa6c3f30 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1221,8 +1221,9 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
>    * binary representation file.
>    */
>   
> -int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
> +int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len, int kind, u32 max_len)
>   {
> +	u32 i;
>   	int rc;
>   	char *str;
>   
> @@ -1232,19 +1233,35 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
>   	if (oom_check(sizeof(char), len, fp))
>   		return -EINVAL;
>   
> +	if (max_len != 0 && len > max_len)
> +		return -EINVAL;
> +
>   	str = kmalloc(len + 1, flags | __GFP_NOWARN);
>   	if (!str)
>   		return -ENOMEM;
>   
>   	rc = next_entry(str, fp, len);
> -	if (rc) {
> -		kfree(str);
> -		return rc;
> +	if (rc)
> +		goto bad_str;
> +
> +	rc = -EINVAL;
> +	for (i = 0; i < len; i++) {
> +		if (iscntrl(str[i]))
> +			goto bad_str;
> +
> +		if (kind == STR_IDENTIFIER &&
> +		    !(isalnum(str[i]) || str[i] == '_' || str[i] == '-' || str[i] == '.'))
> +			goto bad_str;
> +
>   	}
>   
>   	str[len] = '\0';
>   	*strp = str;
>   	return 0;
> +
> +bad_str:
> +	kfree(str);
> +	return rc;
>   }
>   
>   static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
> @@ -1269,7 +1286,7 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   	if (perdatum->value < 1 || perdatum->value > 32)
>   		goto bad;
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
> @@ -1315,7 +1332,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
>   		goto bad;
>   	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
> @@ -1552,12 +1569,12 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
>   
>   	ncons = le32_to_cpu(buf[5]);
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
>   	if (len2) {
> -		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
> +		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2, STR_IDENTIFIER, 128);
>   		if (rc)
>   			goto bad;
>   
> @@ -1691,7 +1708,7 @@ static int role_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>   		role->bounds = le32_to_cpu(buf[2]);
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
> @@ -1758,7 +1775,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   		typdatum->primary = le32_to_cpu(buf[2]);
>   	}
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 1024);
>   	if (rc)
>   		goto bad;
>   
> @@ -1822,7 +1839,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>   		usrdatum->bounds = le32_to_cpu(buf[2]);
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
> @@ -1871,7 +1888,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   		goto bad;
>   	levdatum->isalias = val;
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
>   	if (rc)
>   		goto bad;
>   
> @@ -1914,7 +1931,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
>   		goto bad;
>   	catdatum->isalias = val;
>   
> -	rc = str_read(&key, GFP_KERNEL, fp, len);
> +	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 32);
>   	if (rc)
>   		goto bad;

The category restriction is more tight than the sensitivity one because 
a context may have many categories?  I guess that makes sense, but it 
feels counterintuitive from a user perspective, because I feel like 
users tend to think of categories and sensitivities as essentially the 
same thing.  Would dropping the sensitivity limit to 32 to match the 
category limit make sense?

Is there a more strict limit on the number of categories a context can 
have than the U32_MAX from symtab.nprim?  Because that will allow 
exceeding the page size using too many categories regardless of length 
distinctions, which is a concern if the motivation here is about 
potential future untrusted policy loaders in a namespaced environment.

-Daniel

