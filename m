Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85324632E
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941363; cv=none; b=cKEZZXKNiJcxyF7Qvh8nsGzQ0Jl19IZnAJJCcMBxlT8novcX+1DNvVe7nPs3ile3MnuwemBvUXrmkN1DOe4ibfZY558o9iS3zjX33nfXs9ENVq81x7aJJAi0BlpsTUmg2A8BjiumdCZRzLvAUnkaTx6DHhk61ORqiZejAdQlI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941363; c=relaxed/simple;
	bh=GcUJvwvkBalpi8RV3oYtV2Njr6LEQWFuSvRfyk5i45U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ka8dWfPuozt4b3ypsCmxNNJdIEBe9AeY6wU/DkmU/CDVPPC6ygje0rkyl/niFDAK0PoXWtXXU6W7PHMFII/1jk6lyCTLJ6qepj7N6c6/ccZ/FS4Um/6WPi4lryxF4rT8Kxc/lOIup0/aPK68Vy+sEuY4E9ZcA2MKtv34NPp2nwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAMoo35G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAMoo35G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733941359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pf5u9XFtAPe50IJeWsbrW7zn3lFtpQYE5RL9exc88jA=;
	b=HAMoo35GONn0+3C4eYmYAX3KNkQRxfu1L63OxQ9XgVL6zOWuYkZrme947/u1mTNpRgh7Ht
	gmL8z1U4mAbaF74LxM48KY2T8tx8hFT7DmjM236oMhIkXvQluuCsf25nj4KFhvecMV/7pC
	PKLRErJK3k6jzuGT9pLg/xk015krWJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-WSV05NNQNI2mtPS53hLnJg-1; Wed,
 11 Dec 2024 13:22:35 -0500
X-MC-Unique: WSV05NNQNI2mtPS53hLnJg-1
X-Mimecast-MFC-AGG-ID: WSV05NNQNI2mtPS53hLnJg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A021E195394B;
	Wed, 11 Dec 2024 18:22:31 +0000 (UTC)
Received: from localhost (unknown [10.45.225.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14E141956052;
	Wed, 11 Dec 2024 18:22:30 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>, Takaya
 Saeki
 <takayas@chromium.org>
Subject: Re: [RFC PATCH] libselinux: restore previous regex spec ordering
In-Reply-To: <20241211161443.51286-1-cgoettsche@seltendoof.de>
References: <20241211161443.51286-1-cgoettsche@seltendoof.de>
Date: Wed, 11 Dec 2024 19:22:29 +0100
Message-ID: <87v7vqjd0a.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Prior the recent selabel_file(5) rework regular expressions for a
> certain stem where matched in the order given by the input.
> The Reference and Fedora Policy as well as CIL and libsemanage pre-sort
> the file context definitions based on the prefix stem length, so this
> ordering was adopted.
> Do not alter the order by the input of regex specifications to retain
> backward compatibility, e.g. for Android.
>
> Reported-by: Takaya Saeki <takayas@chromium.org>
> Closes: https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+q=
dDoF+7zfyAUHEDpH9g@mail.gmail.com/
> Fixes: 92306da ("libselinux: rework selabel_file(5) database")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> **NOTE**:
> Using a pre-compiled fcontext file generated with 3.8-rc1 (3.7 and prior
> is fine) will result in vastly wrong lookup results.
> Thus all users upgrading from 3.8-rc1 **should** remove their
> pre-compiled fcontext definitions, e.g. via
>
>   rm /etc/selinux/*/contexts/files/*.bin
>
> In case this commits get applied this should be mentioned in the release
> notes for 3.8-rc2.
>

Thanks!

I've  missed this set of emails and I've already pushed 3.8-rc2 but I
will not announce it and wait for this and then release rc3.




> ---
>  libselinux/src/label_file.c | 163 +++++++++++++++++-------------------
>  libselinux/src/label_file.h |  34 +-------
>  2 files changed, 80 insertions(+), 117 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 80a7c5ab..3e35381d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -87,14 +87,14 @@ void sort_spec_node(struct spec_node *node, struct sp=
ec_node *parent)
>=20=20
>  	node->parent =3D parent;
>=20=20
> -	/* Sort for comparison support and binary search lookup */
> +	/*
> +	 * Sort for comparison support and binary search lookup,
> +	 * except for regex specs which are matched in reverse input order.
> +	 */
>=20=20
>  	if (node->literal_specs_num > 1)
>  		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct lite=
ral_spec), compare_literal_spec);
>=20=20
> -	if (node->regex_specs_num > 1)
> -		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_sp=
ec), compare_regex_spec);
> -
>  	if (node->children_num > 1)
>  		qsort(node->children, node->children_num, sizeof(struct spec_node), co=
mpare_spec_node);
>=20=20
> @@ -144,36 +144,38 @@ static int nodups_spec_node(const struct spec_node =
*node, const char *path)
>=20=20
>  	if (node->regex_specs_num > 1) {
>  		for (uint32_t i =3D 0; i < node->regex_specs_num - 1; i++) {
> -			const struct regex_spec *node1 =3D &node->regex_specs[i];
> -			const struct regex_spec *node2 =3D &node->regex_specs[i+1];
> +			for (uint32_t j =3D i; j < node->regex_specs_num - 1; j++) {
> +				const struct regex_spec *node1 =3D &node->regex_specs[i];
> +				const struct regex_spec *node2 =3D &node->regex_specs[j + 1];
>=20=20
> -			if (node1->prefix_len !=3D node2->prefix_len)
> -				continue;
> +				if (node1->prefix_len !=3D node2->prefix_len)
> +					continue;
>=20=20
> -			if (strcmp(node1->regex_str, node2->regex_str) !=3D 0)
> -				continue;
> +				if (strcmp(node1->regex_str, node2->regex_str) !=3D 0)
> +					continue;
>=20=20
> -			if (node1->file_kind !=3D LABEL_FILE_KIND_ALL && node2->file_kind !=
=3D LABEL_FILE_KIND_ALL && node1->file_kind !=3D node2->file_kind)
> -				continue;
> +				if (node1->file_kind !=3D LABEL_FILE_KIND_ALL && node2->file_kind !=
=3D LABEL_FILE_KIND_ALL && node1->file_kind !=3D node2->file_kind)
> +					continue;
>=20=20
> -			rc =3D -1;
> -			errno =3D EINVAL;
> -			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) !=3D 0) {
> -				COMPAT_LOG
> -					(SELINUX_ERROR,
> -						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
> -						path,
> -						file_kind_to_string(node1->file_kind),
> -						node1->regex_str,
> -						node1->lr.ctx_raw,
> -						node2->lr.ctx_raw);
> -			} else {
> -				COMPAT_LOG
> -					(SELINUX_ERROR,
> -						"%s: Multiple same specifications for %s %s.\n",
> -						path,
> -						file_kind_to_string(node1->file_kind),
> -						node1->regex_str);
> +				rc =3D -1;
> +				errno =3D EINVAL;
> +				if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) !=3D 0) {
> +					COMPAT_LOG
> +						(SELINUX_ERROR,
> +							"%s: Multiple different specifications for %s %s  (%s and %s).\n",
> +							path,
> +							file_kind_to_string(node1->file_kind),
> +							node1->regex_str,
> +							node1->lr.ctx_raw,
> +							node2->lr.ctx_raw);
> +				} else {
> +					COMPAT_LOG
> +						(SELINUX_ERROR,
> +							"%s: Multiple same specifications for %s %s.\n",
> +							path,
> +							file_kind_to_string(node1->file_kind),
> +							node1->regex_str);
> +				}
>  			}
>  		}
>  	}
> @@ -1637,8 +1639,9 @@ static struct lookup_result *lookup_check_node(stru=
ct spec_node *node, const cha
>  					  : (strcmp(n->literal_specs[literal_idx].literal_match, key) =3D=
=3D 0)));
>  		}
>=20=20
> -		for (uint32_t i =3D 0; i < n->regex_specs_num; i++) {
> -			struct regex_spec *rspec =3D &n->regex_specs[i];
> +		for (uint32_t i =3D n->regex_specs_num; i > 0; i--) {
> +			/* search in reverse order */
> +			struct regex_spec *rspec =3D &n->regex_specs[i - 1];
>  			const char *errbuf =3D NULL;
>  			int rc;
>=20=20
> @@ -2221,81 +2224,69 @@ static enum selabel_cmp_result spec_node_cmp(cons=
t struct spec_node *node1, cons
>  		while (iter1 < node1->regex_specs_num && iter2 < node2->regex_specs_nu=
m) {
>  			const struct regex_spec *rspec1 =3D &node1->regex_specs[iter1];
>  			const struct regex_spec *rspec2 =3D &node2->regex_specs[iter2];
> -			int cmp;
> -
> -			if (rspec1->prefix_len > rspec2->prefix_len) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUPERSET) {
> -					result =3D SELABEL_SUPERSET;
> -					iter1++;
> -					continue;
> -				}
> +			bool found_successor;
>=20=20
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_prefix_lengt=
h", iter1, iter2);
> +			if (rspec1->file_kind =3D=3D rspec2->file_kind && strcmp(rspec1->rege=
x_str, rspec2->regex_str) =3D=3D 0) {
> +				iter1++;
> +				iter2++;
> +				continue;
>  			}
>=20=20
> -			if (rspec1->prefix_len < rspec2->prefix_len) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUBSET) {
> -					result =3D SELABEL_SUBSET;
> -					iter2++;
> -					continue;
> -				}
> +			if (result =3D=3D SELABEL_SUPERSET) {
> +				iter1++;
> +				continue;
> +			}
>=20=20
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_prefix_lengt=
h", iter1, iter2);
> +			if (result =3D=3D SELABEL_SUBSET) {
> +				iter2++;
> +				continue;
>  			}
>=20=20
> -			/* If prefix length is equal compare regex string */
> +			assert(result =3D=3D SELABEL_EQUAL);
>=20=20
> -			cmp =3D strcmp(rspec1->regex_str, rspec2->regex_str);
> -			if (cmp < 0) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUPERSET) {
> -					result =3D SELABEL_SUPERSET;
> -					iter1++;
> -					continue;
> -				}
> +			found_successor =3D false;
>=20=20
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1,=
 iter2);
> -			}
> +			for (uint32_t i =3D iter2; i < node2->regex_specs_num; i++) {
> +				const struct regex_spec *successor =3D &node2->regex_specs[i];
>=20=20
> -			if (cmp > 0) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUBSET) {
> +				if (rspec1->file_kind =3D=3D successor->file_kind && strcmp(rspec1->=
regex_str, successor->regex_str) =3D=3D 0) {
>  					result =3D SELABEL_SUBSET;
> -					iter2++;
> -					continue;
> +					iter1++;
> +					iter2 =3D i + 1;
> +					found_successor =3D true;
> +					break;
>  				}
> -
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "regex_str", iter1,=
 iter2);
>  			}
>=20=20
> -			/* If literal match is equal compare file kind */
> -
> -			if (rspec1->file_kind > rspec2->file_kind) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUPERSET) {
> -					result =3D SELABEL_SUPERSET;
> -					iter1++;
> -					continue;
> -				}
> +			if (found_successor)
> +				continue;
>=20=20
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1,=
 iter2);
> -			}
> +			for (uint32_t i =3D iter1; i < node1->regex_specs_num; i++) {
> +				const struct regex_spec *successor =3D &node1->regex_specs[i];
>=20=20
> -			if (rspec1->file_kind < rspec2->file_kind) {
> -				if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUBSET) {
> -					result =3D SELABEL_SUBSET;
> +				if (successor->file_kind =3D=3D rspec2->file_kind && strcmp(successo=
r->regex_str, rspec2->regex_str) =3D=3D 0) {
> +					result =3D SELABEL_SUPERSET;
> +					iter1 =3D i + 1;
>  					iter2++;
> -					continue;
> +					found_successor =3D true;
> +					break;
>  				}
> -
> -				return rspec_incomp(node1->stem, rspec1, rspec2, "file_kind", iter1,=
 iter2);
>  			}
>=20=20
> -			iter1++;
> -			iter2++;
> +			if (found_successor)
> +				continue;
> +
> +			return rspec_incomp(node1->stem, rspec1, rspec2, "regex", iter1, iter=
2);
>  		}
>  		if (iter1 !=3D node1->regex_specs_num) {
>  			if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUPERSET) {
>  				result =3D SELABEL_SUPERSET;
>  			} else {
> -				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str left remn=
ant in stem %s\n", fmt_stem(node1->stem));
> +				const struct regex_spec *rspec1 =3D &node1->regex_specs[iter1];
> +
> +				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex left remnant =
in stem %s entry %u: (%s, %s, %s)\n",
> +					    fmt_stem(node1->stem),
> +					    iter1, rspec1->regex_str, file_kind_to_string(rspec1->file_kind=
), rspec1->lr.ctx_raw);
>  				return SELABEL_INCOMPARABLE;
>  			}
>  		}
> @@ -2303,7 +2294,11 @@ static enum selabel_cmp_result spec_node_cmp(const=
 struct spec_node *node1, cons
>  			if (result =3D=3D SELABEL_EQUAL || result =3D=3D SELABEL_SUBSET) {
>  				result =3D SELABEL_SUBSET;
>  			} else {
> -				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex_str right rem=
nant in stem %s\n", fmt_stem(node1->stem));
> +				const struct regex_spec *rspec2 =3D &node2->regex_specs[iter2];
> +
> +				selinux_log(SELINUX_INFO, "selabel_cmp: mismatch regex right remnant=
 in stem %s entry %u: (%s, %s, %s)\n",
> +					    fmt_stem(node1->stem),
> +					    iter2, rspec2->regex_str, file_kind_to_string(rspec2->file_kind=
), rspec2->lr.ctx_raw);
>  				return SELABEL_INCOMPARABLE;
>  			}
>  		}
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index c7fe3a48..7e999ce8 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -123,7 +123,7 @@ struct spec_node {
>  	uint32_t literal_specs_num, literal_specs_alloc;
>=20=20
>  	/*
> -	 * Array of regular expression specifications (ordered from most to lea=
st specific)
> +	 * Array of regular expression specifications (order preserved from inp=
ut)
>  	 */
>  	struct regex_spec *regex_specs;
>  	uint32_t regex_specs_num, regex_specs_alloc;
> @@ -369,38 +369,6 @@ static inline int compare_literal_spec(const void *p=
1, const void *p2)
>  	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind=
);
>  }
>=20=20
> -static inline int compare_regex_spec(const void *p1, const void *p2)
> -{
> -	const struct regex_spec *r1 =3D p1;
> -	const struct regex_spec *r2 =3D p2;
> -	size_t regex_len1, regex_len2;
> -	int ret;
> -
> -	/* Order from high prefix length to low */
> -	ret =3D (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2->prefi=
x_len);
> -	if (ret)
> -		return ret;
> -
> -	/* Order from long total regex length to short */
> -	regex_len1 =3D strlen(r1->regex_str);
> -	regex_len2 =3D strlen(r2->regex_str);
> -	ret =3D (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Order for no-duplicates check.
> -	 * Use reverse alphabetically order to retain the Fedora ordering of
> -	 * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
> -	 */
> -	ret =3D strcmp(r1->regex_str, r2->regex_str);
> -	if (ret)
> -		return -ret;
> -
> -	/* Order wildcard mode (0) last */
> -	return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->file_kind=
);
> -}
> -
>  static inline int compare_spec_node(const void *p1, const void *p2)
>  {
>  	const struct spec_node *n1 =3D p1;
> --=20
> 2.45.2

