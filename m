Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225071CA85
	for <selinux@vger.kernel.org>; Sun, 16 Jun 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563472; cv=none; b=cFbcgSVBB5pQ5OGP65a8i+XHFTifP5omtaD91EavaeRX8y5uC6UpsD51NTD9sXWSKrETcStUduMht35llEwHdDOG0NuYXYLWX2MVMPHJx6GUnN+88S0BbO2swsCy4q+FMTlKZJ+D27THJSLchcx1wAdlAvjRybJV7cXJgDWK3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563472; c=relaxed/simple;
	bh=ccHDW3R28j3vpn6vA9jWigiKi77CB/NwAj+ne/crsn8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RtujmodkGRV2fsmfheuDfVzCaE/wsfA3jLiSWUPpm0XAa+6yi34u+vj84dBn1NfQM/gLBoy8eVJt5cOH+GgIF8uWqmxFV1vmmMYE3zQ6BeWH+z+a+qoFZApS4t4igYWyRPj3K791hfasaGmsbgCbBViDu1TAeYGizZFn7zEcVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cpSM3jgx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cpSM3jgx"
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1718563458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2BfW7P3Ys6Sg/rZU4+K8hHn6B7snEkbropxSviTRCA=;
	b=cpSM3jgxp/XA7+mrA24tyc/WvACS2IxoYThsjIQSwGshs0ugUSYuMOztLb4NbJHXppEywC
	8N8U2JZqfTzXOgHp61Ai07ZFfn3/9goTvmME/GMjVj4lsIdOMYuAGYzRRpfIXQ/shclHl/
	ZFOg0KAm4JfqWnDNvKUjKN+iNFZTkhT0S+qU+E2xXqe9It9io6hGoubCk9yK1X7HbuudqJ
	KSJpwYxw4I7Uj3aR0yIq1eSb21fw2QDXNnJuE8/luMwIoaLnx7OwMeHp6nCd6umTIdyRGj
	yvmGSvxnYGBc4rVytjrQcX+x6PQHXm/FKIrDrmhiope/kbsVd0KlqHNzI9/PCg==
Date: Sun, 16 Jun 2024 20:44:18 +0200
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Subject: Re: [PATCH] libsepol: check scope permissions refer to valid class
In-Reply-To: <CAJ2a_Dfbh9JTDQfSHV=0HAcP7QnuNqLquhwuLc2TWhTGN9Dhpw@mail.gmail.com>
References: <20240615132525.36358-1-cgoettsche@seltendoof.de>
 <CAJ2a_Dfbh9JTDQfSHV=0HAcP7QnuNqLquhwuLc2TWhTGN9Dhpw@mail.gmail.com>
Message-ID: <33ac8211c1bb038e8ed535e83937f01d@seltendoof.de>
X-Sender: cgoettsche@seltendoof.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

> From: Christian Göttsche <cgzones@googlemail.com>
> 
> Validate that the permission maps in the scope index refer to a valid
> class datum.  Otherwise since commit 52e5c306 ("libsepol: move 
> unchanged
> data out of loop") this can lead to a NULL dereference in the class
> existence check during linking.
> 
> Reported-by: oss-fuzz (issue 69655)
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/src/policydb_validate.c
> b/libsepol/src/policydb_validate.c
> index 9746f562..0216410c 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1467,6 +1467,8 @@ bad:
> 
>  static int validate_scope_index(sepol_handle_t *handle, const
> scope_index_t *scope_index, validate_t flavors[])
>  {
> +       uint32_t i;
> +
>         if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_classes_scope,
> &flavors[SYM_CLASSES]))
> @@ -1483,8 +1485,10 @@ static int validate_scope_index(sepol_handle_t
> *handle, const scope_index_t *sco
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_cat_scope, 
> &flavors[SYM_CATS]))
>                 goto bad;
> -       if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)

Since classes should not have gaps, this could be a simple off-by-one, 
cause class_perms_len is 0-based while nprim is 1-based. So

     scope_index->class_perms_len >= flavors[SYM_CLASSES].nprim

might suffice, but I am unable to test currently though.

> -               goto bad;
> +
> +       for (i = 0; i < scope_index->class_perms_len; i++)
> +               if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> +                       goto bad;
> 
>         return 0;
