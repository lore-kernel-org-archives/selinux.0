Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E514D8CE
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437596; cv=none; b=nlyzvD+VjjzzF+out6DVVW5I605g3qv4j2hocmzvDnRSOxQsvib/n9nusikYyvjgUpjhym6YzsOi9dHnNehIVxRVurJnTLF5splAnv+cFS04FbRanBNYri7xaPxOEKpf1lekiwhhiTLIZ6anWbKmVfwTM9/Ih3YX6yg9AqLED2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437596; c=relaxed/simple;
	bh=Nn5d34YltUhHwCWLpteRyHLZLMrHmmzxddJ4NnWKkGo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WirDuBlA+K7HISh2zsiHCrOt8SjB+GbFOmSetZGfejl4MrgmBwmfbD5oq+r52J60LE5/k6xC10XJO9cmGSQvg/G+F1WnV9GMZBbA7AqUVAXRdl3od2I9m1y9/kgZI6ENngRMCywSMz37oyx132r1St34LCdiCP2hJd/KTamblrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRXX2kYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRXX2kYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734437593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htQArtASkTIUWWWT+IzlXb6VIIubo2a7QOoxVch8sk0=;
	b=LRXX2kYlNHMVN5ZICVzQej8nhkCqR2oIkSSwRd4fuX/rugrwx9xSPa8YtOt1zAAvyBbQdX
	LWiUotDyzNqseaGT/O2V0PqYBEWhGONxud0JQ4+/P/fBOkVUqBbpB95eWQkGlFgEY+yvVh
	azl3h+p5RFzdo6ZZZdlE6mFL4NOEwcU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-OBS-JiEAMsOTcUEgyYH6cg-1; Tue,
 17 Dec 2024 07:13:11 -0500
X-MC-Unique: OBS-JiEAMsOTcUEgyYH6cg-1
X-Mimecast-MFC-AGG-ID: OBS-JiEAMsOTcUEgyYH6cg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EDCB19560B5
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:13:11 +0000 (UTC)
Received: from localhost (unknown [10.45.224.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8501A1955F41
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:13:10 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH v2] sepolgen-ifgen: allow M4 escaped filenames
In-Reply-To: <20240827113150.1843304-1-lautrbach@redhat.com>
References: <20240819182123.1037607-2-lautrbach@redhat.com>
 <20240827113150.1843304-1-lautrbach@redhat.com>
Date: Tue, 17 Dec 2024 13:13:09 +0100
Message-ID: <871py6zewa.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Petr Lautrbach <lautrbach@redhat.com> writes:

> When a file name in type transition rule used in an interface is same as
> a keyword, it needs to be M4 escaped so that the keyword is not expanded
> by M4, e.g.
>
> -	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, "interface")
> +	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, ``"interface"'')
>
> But sepolgen-ifgen could not parse such string:
>
>     # sepolgen-ifgen
>     Illegal character '`'
>
> This change allows M4 escaping inside quoted strings and fixed described
> problem.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2254206
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

If there's no objection I would like to merge before tomorrows rc3.

Petr



> ---
>
> change to v1:
>
> - use ``"..."'' instead of "``..''" - sugested in https://github.com/SELinuxProject/selint/pull/291 by
>   @cgzones
>
> - controls right number of openning and closing quotes
>
>  python/sepolgen/src/sepolgen/refparser.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> index e261d3f78f87..c8a3eb54d679 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -486,7 +486,7 @@ def p_interface_call_param(p):
>                              | nested_id_set
>                              | TRUE
>                              | FALSE
> -                            | FILENAME
> +                            | quoted_filename
>      '''
>      # Intentionally let single identifiers pass through
>      # List means set, non-list identifier
> @@ -1027,6 +1027,11 @@ def p_optional_semi(p):
>                     | empty'''
>      pass
>  
> +def p_quoted_filename(p):
> +    '''quoted_filename : TICK quoted_filename SQUOTE
> +                       | FILENAME
> +    '''
> +    p[0] = p[1]
>  
>  #
>  # Interface to the parser
> -- 
> 2.46.0

