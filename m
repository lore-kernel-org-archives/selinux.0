Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27328AB11
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549194; cv=none; b=pmwrI8tR7MKITjbvf3GgZaKbduc8U35DsbxjQ8XwSNb1+a7/n1s2Dywf9kMJrIr/4J7vEZKuhptsZ8WXh/4UcEVLJYQWqUnZuaKFqQKW+EwthVgRoVQHaB9MA7vZDfjf6Lo6Mpdqh91sMzv2j6RLuSkor+Fz6N/x/1bCO8NAH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549194; c=relaxed/simple;
	bh=NTGdQwYachs5YVluGqjRl5Ql2stjNV23U8La/4nWthE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3XkhbZcOr8ctjpuVem8HroZ+nSqB2It6C66UjWk/yDax1zRbRdF8bLl3AzP0QSO+TAadz1hRs/ASJWU0sdgN96UxtYYE6YYL3pM7I+4qf/gTIlsVIB09ajJ7wL9JcZLTGT+8Q9sfghOu2aIh+yMchr6ygPve8cUjLmbd7EldzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJIITOZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJIITOZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24xjC96tE+eQs3UCiP3ZUbztb7Peo94Cr9dUChqbDJQ=;
	b=bJIITOZSVMiXKJC8m4JiAaopYNl6sq2pDzQwrngcjTKadnFodcKPykaTeaqUNu7HOjLFxL
	tLYFbBHTZKwmHrmjIbk00u8jA21b0IC1+lyAUayhtdvWbHqGYxF51z9qM8GGzKpJl+JPge
	+wc3CMTvWQeRRTMjR+OboNMIS8Tx69s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-6-H6MZWLMIWClsTVCG2qjg-1; Tue,
 10 Jun 2025 05:53:02 -0400
X-MC-Unique: 6-H6MZWLMIWClsTVCG2qjg-1
X-Mimecast-MFC-AGG-ID: 6-H6MZWLMIWClsTVCG2qjg_1749549181
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4417180136B;
	Tue, 10 Jun 2025 09:53:00 +0000 (UTC)
Received: from localhost (unknown [10.44.32.151])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 291BE19560A3;
	Tue, 10 Jun 2025 09:52:59 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>, James
 Carter
 <jwcart2@gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: prioritize local literal fcontext
 definitions
In-Reply-To: <20250530123048.53419-1-cgoettsche@seltendoof.de>
References: <20250530123048.53419-1-cgoettsche@seltendoof.de>
Date: Tue, 10 Jun 2025 11:52:58 +0200
Message-ID: <87sek7exdx.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For literal file context definitions respect overrides from homedirs or
> local configurations by ordering them first.
>
> Also retain the order regarding the file kind for backward
> compatibility.
>
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Reported-by: Paul Holzinger
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
> Suggested-by: James Carter <jwcart2@gmail.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>



> ---
> v2: drop ordering based in file type, thanks Jim
> ---
>  libselinux/src/label_file.c       | 5 +++--
>  libselinux/src/label_file.h       | 7 +++++--
>  libselinux/src/selinux_internal.h | 2 ++
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 5d73fb84..61a9ddb6 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *mmap_=
area, const char *path, str
>  	return 0;
>  }
>=20=20
> -static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool vali=
dating,
> +static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool vali=
dating, uint8_t inputno,
>  				  struct literal_spec *lspec, const struct context_array *ctx_array)
>  {
>  	uint32_t data_u32, ctx_id;
> @@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_area *m=
map_area, bool validating,
>  	int rc;
>=20=20
>  	lspec->from_mmap =3D true;
> +	lspec->inputno =3D inputno;
>=20=20
>=20=20
>  	/*
> @@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>  		node->literal_specs_alloc =3D lspec_num;
>=20=20
>  		for (uint32_t i =3D 0; i < lspec_num; i++) {
> -			rc =3D load_mmap_literal_spec(mmap_area, validating, &node->literal_s=
pecs[i], ctx_array);
> +			rc =3D load_mmap_literal_spec(mmap_area, validating, inputno, &node->=
literal_specs[i], ctx_array);
>  			if (rc)
>  				return -1;
>  		}
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 67db78e5..d1a0713a 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -96,6 +96,7 @@ struct literal_spec {
>  	char *regex_str;			/* original regular expression string for diagnostic=
s */
>  	char *literal_match;			/* simplified string from regular expression */
>  	uint16_t prefix_len;			/* length of fixed path prefix, i.e. length of t=
he literal match */
> +	uint8_t inputno;			/* Input number of source file */
>  	uint8_t file_kind;			/* file type */
>  	bool any_matches;			/* whether any pathname match */
>  	bool from_mmap;				/* whether this spec is from an mmap of the data */
> @@ -367,8 +368,9 @@ static inline int compare_literal_spec(const void *p1=
, const void *p2)
>  	if (ret)
>  		return ret;
>=20=20
> -	/* Order wildcard mode (0) last */
> -	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind=
);
> +	/* Order by input number (higher number means added later, means higher=
 priority) */
> +	ret =3D spaceship_cmp(l1->inputno, l2->inputno);
> +	return -ret;
>  }
>=20=20
>  static inline int compare_spec_node(const void *p1, const void *p2)
> @@ -754,6 +756,7 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>  			.regex_str =3D regex,
>  			.prefix_len =3D prefix_len,
>  			.literal_match =3D literal_regex,
> +			.inputno =3D inputno,
>  			.file_kind =3D file_kind,
>  			.any_matches =3D false,
>  			.lr.ctx_raw =3D context,
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 964b8418..3fe7d4c3 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *stream)
>  # define unlikely(x)			(x)
>  #endif /* __GNUC__ */
>=20=20
> +#define spaceship_cmp(a, b)		(((a) > (b)) - ((a) < (b)))
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --=20
> 2.49.0

