Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E318455A
	for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482081; cv=none; b=bpnoGVoCeDGrYwhBUcOO+tdMNBj3mqibJP3gnVPnj0rcOkQgdMcvWrbSMVpeRFcGVsRn5bPU7CEp8CKU69W95YjMIO1EeHwtxGk79SphDhocX8H77dXdwRuUtIGHCKVwrQzpdtjFYsZAMHWFRAeP0z3b67KzJ564ba8c5fUAxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482081; c=relaxed/simple;
	bh=DwsXprmYBYXaqIaJDtUFUDpYbjAjmOw9Kt1upatYUNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdrQfjoEsbTYuam3WR1zcc2q/1+mYhORo6/+oWVbYgS4foX5iKN55ZlqEThEVjV2VcONl8ORP+2cits47i3j3wDVez2KoZL0wpA4tmTXPeqXig8MH/rZVGZWIIp4zu7JT9ZsCPza/++Wob7tV357QqMOww5GcZMkQF/MJ5GMblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=cqnRSOl0; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="cqnRSOl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1723482070;
	bh=DwsXprmYBYXaqIaJDtUFUDpYbjAjmOw9Kt1upatYUNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cqnRSOl0xqAXgOS9VXn1cpO9h/XeL/O+MpJPTZilzL6qzgYQm/8UGO1YuWdBHIGgz
	 IAVQ8D3A/tlxTxkxG1lc3f2GJLnXZM0Gkw2bVbpPmAOX7m0uhLicH2doCFO5enGqtT
	 dH4TN4JTNdkQ+GleLWfPq0lp7XmV81/U7nqys+3g=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id D4E949A905;
	Mon, 12 Aug 2024 19:01:10 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol/cil: Allow dotted names in aliasactual rules
In-Reply-To: <20240812165633.49121-1-jwcart2@gmail.com> (James Carter's
	message of "Mon, 12 Aug 2024 12:56:33 -0400")
References: <20240812165633.49121-1-jwcart2@gmail.com>
Date: Mon, 12 Aug 2024 19:01:10 +0200
Message-ID: <87wmklzne1.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Carter <jwcart2@gmail.com> writes:

> The function cil_gen_alias() is used to declare type, sensitivity,
> and category aliases and the function cil_gen_aliasactual() is used
> to assign an alias to the actual declared name.
>
> Commit e55621c03 ("libsepol/cil: Add notself and other support to CIL")
> added "notself" and "other" as reserved words. Previously, a check
> was made in cil_gen_aliasactual() to ensure that the "self" reserved
> word was not used. With the notself patch this function was upgraded
> to call cil_verify_name() to verify that the other reserved words
> were not used as well. This change prevents the use of dotted names
> to refer to alias or actual names that are declared in blocks.
>
> The check for a reserved word being used is not needed because that
> check will be done for both the alias and the actual name when they
> are declared.
>
> Remove the call to cil_verify_name() and allow dotted names in
> aliasactual rules.
>
> Reported-by: Dominick Grift <dominick.grift@defensec.nl>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Thank you.

> ---
>  libsepol/cil/src/cil_build_ast.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 56dac891..6884f12c 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -3174,16 +3174,6 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
>  		goto exit;
>  	}
>  
> -	rc = cil_verify_name(db, parse_current->next->data, flavor);
> -	if (rc != SEPOL_OK) {
> -		goto exit;
> -	}
> -
> -	rc = cil_verify_name(db, parse_current->next->next->data, flavor);
> -	if (rc != SEPOL_OK) {
> -		goto exit;
> -	}
> -
>  	cil_aliasactual_init(&aliasactual);
>  
>  	aliasactual->alias_str = parse_current->next->data;

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
