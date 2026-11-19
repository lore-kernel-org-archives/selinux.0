Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095799;
	b=NuCl/3/74Qlkt1DWKGg7nR57vnt5Xbp0hKT8N0wMgHZUIkWO3KPTcauNOS0LeuyNsBnV
	 heHgJrBDep7NFWH3EBYa3rRFV1XfxI1OgHLTvJr2evxWjhGuA6I//zy5WyJfRd6w6hlKm
	 aaJkQMjZAx+vE7fgBpcaRDodDbr0wf0BU1c1AMf0csBjE5az+BY0o75YnavyOiEH0Xq5g
	 VUpdt+SZ4og+OIP78QzlVl8T5PO1pqj5SeDYt1VxFY37aD4XBm2KZGM5qhunn41yZkDR9
	 itfihCuG81dEV0rn5oRPYQVt/odmaVKKpPm7ufVEfzkc+cWPu6S99YC/JtHEUptuBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095799;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=gBGdJbN1GF7CRaHvq48mg3PTvh9r23Pg+KF9UmzXd9s=;
	b=c+a9ffNx4MKfG/zH8xL/Zq4Boop0cA8Sxq/sZTb3wVyRkPYZE7XNdQ6FiFebmsi5wt4o
	 D0DdSU/a0pBDHITn9fVNRo1wwzFBSwmLE+gw2fMLbiWTa7bU6zzD+yNF4hUOADQbEihXB
	 tJEKeJahn2Wc9BQ2vz3cKDM/iIY5UtdxZIjXqfm65JqzUtk9S4CpWAuOyZMv+vkHMd4sd
	 yxKaGiOHP1DMkO2+79Ohb1oUtFmpHXZA/CpfZmH+q5V1lH8Esge8LOuJoHjrVHAldPPg5
	 dniLEIdmxil4H3idlXhoeNcr6FGcyQM4+9lvGsUycNZU/aIMOEQ4UBfHYdxqxP0MQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iIrbkGJn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE6606A320
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAE6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iIrbkGJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBGdJbN1GF7CRaHvq48mg3PTvh9r23Pg+KF9UmzXd9s=;
	b=iIrbkGJnkKCdmK+wu9H4QNULkgP7TmmlwUOC6rFQGU19RRCoIVCecUBTq7w4wtU3DZzmxM
	su8v1QH3KWgo90S8ofvx3x0ddI+Axn8pfaRI1TvtNeWMVXMaBDmRQBLENqfyknQliA7OMM
	5Az7IIfxhn9JU5xlxuEyAZW1ADvN04M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-iM7WdbidN5GxJZUvbsBQPg-1; Thu,
 19 Nov 2026 08:43:14 -0500
X-MC-Unique: iM7WdbidN5GxJZUvbsBQPg-1
X-Mimecast-MFC-AGG-ID: iM7WdbidN5GxJZUvbsBQPg_1795095792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A793219541AE;
	Thu, 19 Nov 2026 13:43:12 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 233CA1956041;
	Thu, 19 Nov 2026 13:43:09 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 2/2] libsemanage: escape regex metacharacters when
 substituting NSS strings
In-Reply-To: <20261119130853.858-2-stephen.smalley.work@gmail.com>
References: <20261119130853.858-1-stephen.smalley.work@gmail.com>
 <20261119130853.858-2-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:43:07 +0100
Message-ID: <pjd4iddvswk.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> genhomedircon substitutes the Linux user name into the USER and
> %{USERNAME} placeholders and the home directory into HOME_DIR and
> HOME_ROOT verbatim. These land in the regular-expression field of a
> file-context line, so a "." in "john.smith" or "/srv/home.d" matches
> any character, and a hostile passwd source can supply a value to widen
> a homedir template so that arbitrary system paths receive
> user_home_dir_t and similar contexts on the next relabel. This is
> weaker than the line-injection primitive addressed by the previous
> patch, but it is the same untrusted-input path.
>
> Backslash-escape the PCRE metacharacters in these values before
> substitution. Add a name_re field alongside name so the un-escaped
> form is still available for the "# Home Context for user %s" comment
> and the find_user() equality check, and so the fallback entry can keep
> its intentional "[^/]+" / "[0-9]+" regexes. The home field has no
> other consumers so it stores the escaped form directly. \Q..\E is not
> used because a "\E" in the input would terminate it.
>
> The visible behavior change is that a user "john.smith" now only
> matches its literal home directory, not "johnXsmith"; that was always
> the intent and matches how libselinux's label_file compares literal
> prefixes.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libsemanage/src/genhomedircon.c | 74 ++++++++++++++++++++++++---------
>  1 file changed, 55 insertions(+), 19 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 2ef923ce..8afffab9 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -106,6 +106,7 @@
>  
>  typedef struct user_entry {
>  	char *name;
> +	char *name_re;
>  	char *uid;
>  	char *gid;
>  	char *sename;
> @@ -323,6 +324,24 @@ static bool is_fc_safe(const char *str)
>  	return true;
>  }
>  
> +static char *fc_regex_escape(const char *s)
> +{
> +	static const char meta[] = "\\^$.[]|()*+?{}";
> +	size_t len = strlen(s);
> +	char *out = malloc(2 * len + 1);
> +	char *p = out;
> +
> +	if (!out)
> +		return NULL;
> +	for (; *s; s++) {
> +		if (strchr(meta, (unsigned char)*s))
> +			*p++ = '\\';
> +		*p++ = *s;
> +	}
> +	*p = '\0';
> +	return out;
> +}
> +
>  static int prefix_is_homedir_role(const semanage_user_t *user,
>  				  const char *prefix)
>  {
> @@ -963,7 +982,8 @@ static int write_username_context(genhomedircon_settings_t *s, FILE *out,
>  				  const genhomedircon_user_entry_t *user)
>  {
>  	const replacement_pair_t repl[] = {
> -		{ .search_for = TEMPLATE_USERNAME, .replace_with = user->name },
> +		{ .search_for = TEMPLATE_USERNAME,
> +		  .replace_with = user->name_re },
>  		{ .search_for = TEMPLATE_USERID, .replace_with = user->uid },
>  		{ .search_for = TEMPLATE_ROLE, .replace_with = user->prefix },
>  		{ NULL, NULL }
> @@ -977,7 +997,7 @@ static int write_user_context(genhomedircon_settings_t *s, FILE *out,
>  			      const genhomedircon_user_entry_t *user)
>  {
>  	const replacement_pair_t repl[] = {
> -		{ .search_for = TEMPLATE_USER, .replace_with = user->name },
> +		{ .search_for = TEMPLATE_USER, .replace_with = user->name_re },
>  		{ .search_for = TEMPLATE_ROLE, .replace_with = user->prefix },
>  		{ NULL, NULL }
>  	};
> @@ -1022,13 +1042,14 @@ static int name_user_cmp(const void *arg1, const void *arg2)
>  	return strcmp(key, semanage_user_get_name(*val));
>  }
>  
> -static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
> -			   const char *u, const char *g, const char *sen,
> -			   const char *pre, const char *h, const char *l,
> -			   const char *ln, const char *hd_role)
> +static int push_user_entry(genhomedircon_user_entry_t **list, bool escape,
> +			   const char *n, const char *u, const char *g,
> +			   const char *sen, const char *pre, const char *h,
> +			   const char *l, const char *ln, const char *hd_role)
>  {
>  	genhomedircon_user_entry_t *temp = NULL;
>  	char *name = NULL;
> +	char *name_re = NULL;
>  	char *uid = NULL;
>  	char *gid = NULL;
>  	char *sename = NULL;
> @@ -1044,6 +1065,9 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
>  	name = strdup(n);
>  	if (!name)
>  		goto cleanup;
> +	name_re = escape ? fc_regex_escape(n) : strdup(n);
> +	if (!name_re)
> +		goto cleanup;
>  	uid = strdup(u);
>  	if (!uid)
>  		goto cleanup;
> @@ -1056,7 +1080,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
>  	prefix = strdup(pre);
>  	if (!prefix)
>  		goto cleanup;
> -	home = strdup(h);
> +	home = escape ? fc_regex_escape(h) : strdup(h);
>  	if (!home)
>  		goto cleanup;
>  	level = strdup(l);
> @@ -1072,6 +1096,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
>  	}
>  
>  	temp->name = name;
> +	temp->name_re = name_re;
>  	temp->uid = uid;
>  	temp->gid = gid;
>  	temp->sename = sename;
> @@ -1087,6 +1112,7 @@ static int push_user_entry(genhomedircon_user_entry_t **list, const char *n,
>  
>  cleanup:
>  	free(name);
> +	free(name_re);
>  	free(uid);
>  	free(gid);
>  	free(sename);
> @@ -1109,6 +1135,7 @@ static void pop_user_entry(genhomedircon_user_entry_t **list)
>  	temp = *list;
>  	*list = temp->next;
>  	free(temp->name);
> +	free(temp->name_re);
>  	free(temp->uid);
>  	free(temp->gid);
>  	free(temp->sename);
> @@ -1166,10 +1193,11 @@ static int setup_fallback_user(genhomedircon_settings_t *s)
>  				homedir_role = prefix;
>  			}
>  
> -			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
> -					    FALLBACK_UIDGID, FALLBACK_UIDGID,
> -					    seuname, prefix, "", level,
> -					    FALLBACK_NAME, homedir_role) != 0)
> +			if (push_user_entry(&(s->fallback), false,
> +					    FALLBACK_NAME, FALLBACK_UIDGID,
> +					    FALLBACK_UIDGID, seuname, prefix,
> +					    "", level, FALLBACK_NAME,
> +					    homedir_role) != 0)
>  				errors = STATUS_ERR;
>  			semanage_user_key_free(key);
>  			if (u)
> @@ -1336,10 +1364,11 @@ retry:
>  	}
>  
>  	retval =
> -		push_user_entry(head, name, uid, gid, sename, prefix,
> +		push_user_entry(head, true, name, uid, gid, sename, prefix,
>  				canonical_home ? canonical_home : pwent->pw_dir,
>  				level, selogin, homedir_role);
>  	free(canonical_home);
> +
>  cleanup:
>  	free(rbuf);
>  	return retval;
> @@ -1593,10 +1622,12 @@ static int write_context_file(genhomedircon_settings_t *s, FILE *out)
>  		}
>  
>  		for (h = homedirs; h; h = h->next) {
> +			char *hd_re = fc_regex_escape(h->data);
>  			char *temp = NULL;
>  
> -			if (asprintf(&temp, "%s/%s", h->data, FALLBACK_NAME) <
> -			    0) {
> +			if (!hd_re || asprintf(&temp, "%s/%s", hd_re,
> +					       FALLBACK_NAME) < 0) {
> +				free(hd_re);
>  				retval = STATUS_ERR;
>  				goto done;
>  			}
> @@ -1608,20 +1639,23 @@ static int write_context_file(genhomedircon_settings_t *s, FILE *out)
>  						   s->fallback) !=
>  			    STATUS_SUCCESS) {
>  				free(temp);
> +				free(hd_re);
>  				s->fallback->home = NULL;
>  				retval = STATUS_ERR;
>  				goto done;
>  			}
> -			if (write_home_root_context(
> -				    s, out, homeroot_context_tpl, h->data) !=
> -			    STATUS_SUCCESS) {
> +			if (write_home_root_context(s, out,
> +						    homeroot_context_tpl,
> +						    hd_re) != STATUS_SUCCESS) {
>  				free(temp);
> +				free(hd_re);
>  				s->fallback->home = NULL;
>  				retval = STATUS_ERR;
>  				goto done;
>  			}
>  
>  			free(temp);
> +			free(hd_re);
>  			s->fallback->home = NULL;
>  		}
>  	}
> @@ -1678,11 +1712,13 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
>  	}
>  
>  	s.fallback->name = strdup(FALLBACK_NAME);
> +	s.fallback->name_re = strdup(FALLBACK_NAME);
>  	s.fallback->sename = strdup(FALLBACK_SENAME);
>  	s.fallback->prefix = strdup(FALLBACK_PREFIX);
>  	s.fallback->level = strdup(FALLBACK_LEVEL);
> -	if (s.fallback->name == NULL || s.fallback->sename == NULL ||
> -	    s.fallback->prefix == NULL || s.fallback->level == NULL) {
> +	if (s.fallback->name == NULL || s.fallback->name_re == NULL ||
> +	    s.fallback->sename == NULL || s.fallback->prefix == NULL ||
> +	    s.fallback->level == NULL) {
>  		retval = STATUS_ERR;
>  		goto done;
>  	}
> -- 
> 2.47.3

