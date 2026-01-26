Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514A1D5CDE
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769392179; cv=none; b=fSjN5zh4F/n8QAONBHQDVFLo4UEghE2e5WL4Ht8eHVD3WwTi0eruXT7PUHRSvD4hta+6eMc5LJksoY4riX1hlYhw8UebX3yw4yqSRGA77TEqf8MgmXbGFXrg4dSdZYgFhSBBo0akDpZRoR9xU2eJo9kra1fVwdvckHzPJ6YA4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769392179; c=relaxed/simple;
	bh=Vilvzx+rZXgUzblx/F/L3y7AgusspHiwjYnf79Prt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoP1BSt07UmojIUmvKc+JhIQBMcEpVw8oV4o3D30gcZi1CO9SctYyBG3PmWb5igNQdwX3rwjCiOUkyspI158OXSaunE41F3Y1/4A2bTZ8DbIsQgvT8LPdqefB5sfgogNf+7xOyaykWSIbF7nLZPG/p5XkZ9NAsgUNoxIK5IbbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=kR6kXuU/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="kR6kXuU/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b71557299dso5625039eec.1
        for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 17:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769392176; x=1769996976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApC8WE2g249TeYohvYoY5SFxDWoAtFPc68lPSgjESNg=;
        b=kR6kXuU/tx7GnwXPME50nUwOJhnLSy4Xgxe87gELfG1pjWQOoVsFy2KDUKOCVJpsfD
         kj+Xbrdp4duydvbGqg2UOgwGr5LAzJ16mzPtyl/RymOXYUy5058Mpna1qujlbqzRI+CH
         HF9Dqs4MK3Qx/HqxdNGQTlLL5sXnec56oMedH4T1nHHUXj2Mp+MDtTCc8qzLZQgvPTEE
         6U2pcGjSmJoVofCq18heb3h3kORZ0atiFzECbaage+m4DftLC8mk5jgASZySnQ1fmpVL
         /lf1xU7ibfA1eVyhKao4K5xcELcMyH+RVHR2XBb2sY3Qyaf8ITSJks0QarioW904Mbza
         xG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769392176; x=1769996976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApC8WE2g249TeYohvYoY5SFxDWoAtFPc68lPSgjESNg=;
        b=mkLqrmfFv5d8/kg1gPa2eUbhU3eCrdtX+VqXPIaZoGkU6iSMOGHXPUlm0o6iXyagrZ
         QrunspcYc1xit1Rm6Ui/zMRj39kqKShhEuRb9LcWUZXsSEOGfe6+uaH1nXUvuXdGGNOO
         46OrwLCwP8ULSPqMNAs96xaTcq3fw17cHrTw/FQxSWlTWVzH+4X4iRtCisuhW4X55p3m
         1JmoYZoYc+WVHrsbr5aYPUOzJ8fWU15iv4sGsKvxRl+ktKjFZqghq70GCSOem7mADZ2V
         R0yPQgIH16eEsP38UcrNHkqWZGyX9wQROD0zsme4owZtf+CeCw5Jw37kl3gVx58USoqm
         1NGw==
X-Gm-Message-State: AOJu0YyNxRwjV0Eu17gMUYbeYd22LGv31DaPCGFaYSvj+RwAh3Qhle8P
	JXJz1QV8NfP8hBbyqxtGrbHv/rwv7SDSndvOTyP/PbElPqQXwdmG4DEtoLkneZagn7pxIJuj7mI
	IHh82
X-Gm-Gg: AZuq6aLXm0NE6RNKQ1d6ZyUrg7cgvvwZdFw4ZlrR/jU47FClSJPBeDaG9iF9Lm+J7rv
	GUrppRtTGhulbXWPD3unjYojLdnriu4iQ353A9ArZO8/MI/m9NdQESSQAk7ISs+wU/zOUFblmrX
	o8Lo4qpQwnws0sagepw5UQFPfES39FpnUIvnqdOGwxCd3xwDKaaSFJsmFwZ0Kpij/f1KMfWJ8gy
	/qDCYYj2Gg2Jy363NJXEtYaGrBE+wysEza9tFgTwYII2Jc0CnX5ZJ8xbnsz7Dp7DeLW9BmqgiEy
	xcQXDM3QkyTo9qn3BzIHKR4sfMO1b0iVCpQnXEbBvPF6IKocMtiZs7rlQv89WbFSdZ297uDSFAl
	TvJOXh20b3sTMlwoRG0whtxMnLr4BQaI/+4c8yoKMT/TSX4zQd/vvh6ahQUth6JV1cVQ5fj1HlM
	TPaBjM7DfobhDwj4UGEDHN/iHWP805eh3f93mUkJV2w3kdRIzJgsp4qxNKMQ==
X-Received: by 2002:a05:7300:cd99:b0:2b0:4ae1:b4ae with SMTP id 5a478bee46e88-2b764508f38mr973136eec.24.1769392176413;
        Sun, 25 Jan 2026 17:49:36 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b73a6c31basm11400935eec.9.2026.01.25.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:49:36 -0800 (PST)
Date: Sun, 25 Jan 2026 17:49:35 -0800
From: Jason Zaman <jason@perfinion.com>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol: Fix potential use of an uninitialized value in
 link.c
Message-ID: <aXbIL76tL87cMEfV@anduin.perfinion.com>
References: <20260122185243.86209-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122185243.86209-1-jwcart2@gmail.com>

On Thu, Jan 22, 2026 at 01:52:43PM -0500, James Carter wrote:
> The fields in struct missing_requirement are not assigned a value
> in the case where a class is required but not in scope for an
> optional block. This results in the use of an uninitialized value
> in  print_missing_requirements(). The fields of the struct are
> assigned correctly when the permission of a class is not in scope.
> 
> Assign values to the fields of the struct missing_requirement when
> exiting early because the class is not in scope. Use 0 for the
> permission index and only print the class name in
> print_missing_requirements() if the permission index is 0.
> 
> Reported-by: oss-fuzz (issue 472084713)
> Signed-off-by: James Carter <jwcart2@gmail.com>
Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied.
> ---
>  libsepol/src/link.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index da65257a..188b4020 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1987,6 +1987,9 @@ static int is_decl_requires_met(link_state_t * state,
>  
>  
>  		if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
> +			req->symbol_type = SYM_CLASSES;
> +			req->symbol_value = i + 1;
> +			req->perm_value = 0;
>  			return 0;
>  		}
>  
> @@ -2109,20 +2112,22 @@ static void print_missing_requirements(link_state_t * state,
>  	    cur->branch_list->module_name : "BASE";
>  
>  	if (req->symbol_type == SYM_CLASSES) {
> -
>  		struct find_perm_arg fparg;
> +		class_datum_t *cladatum = p->class_val_to_struct[req->symbol_value - 1];
>  
> -		class_datum_t *cladatum;
> -		cladatum = p->class_val_to_struct[req->symbol_value - 1];
> -
> -		fparg.valuep = req->perm_value;
> -		fparg.key = NULL;
> -		(void)hashtab_map(cladatum->permissions.table, find_perm, &fparg);
> +		if (req->perm_value == 0) {
> +			ERR(state->handle, "%s's global requirements were not met: class %s",
> +				mod_name, p->p_class_val_to_name[req->symbol_value - 1]);
> +		} else {
> +			fparg.valuep = req->perm_value;
> +			fparg.key = NULL;
> +			(void)hashtab_map(cladatum->permissions.table, find_perm, &fparg);
>  
> -		ERR(state->handle,
> -		    "%s's global requirements were not met: class %s, permission %s",
> -		    mod_name,
> -		    p->p_class_val_to_name[req->symbol_value - 1], fparg.key);
> +			ERR(state->handle,
> +				"%s's global requirements were not met: class %s, permission %s",
> +				mod_name,
> +				p->p_class_val_to_name[req->symbol_value - 1], fparg.key);
> +		}
>  	} else {
>  		ERR(state->handle,
>  		    "%s's global requirements were not met: %s %s",
> -- 
> 2.52.0
> 
> 
