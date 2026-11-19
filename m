Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095779;
	b=yrdRODwuQ3VrthGOy65tlI9f2/N5XGVSCzOSwOp8+Pe971hT9UB+6PSU5WA9tOX/ZWde
	 ndyT7odNV64Pne3tFjhU3fAqwfh9S5NY0QjYnZr64GAnwYV6nNAUskhulZJ2gcH44XA0Y
	 9rE0qkYu9BHbyLHDPULi9POmcyW4/Lh3V/KIBJdax8tyCXlX+Nyd3bWBakSVnQ0rXU4HD
	 dp20+mXSwCwY2XrAVRX3bsGM8gUXBeHgbLZU74RfMdr8ywzXgdK9AysrrAE2GIrZtRtRH
	 SWBBHbRxiHnipzdis+FoNHOfO8keRqW7PBfpLVzouLXl5SqRYyye0H38EWtTUbJaSPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095779;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=fLvrLfHh/BRFEzH086IMNWIjcHVbF+yOHy5vCiFhtRw=;
	b=Cej++UboeqoulauFEb2Ats7zM/yMrkP0ik/iWl2D+wHTlFse57P/P4e1Y3yOWubQ3/QK
	 JIzrofnje9jzDGuu+B3SaNCVEwRQy+4pB6ZYHSfJGbQtv2M1UBEJqlzw6FvOzIeImCTFc
	 zKm/xcIjiiVdCpHv+Exgh00K8Ve16UlD+Dpw+hzL6+iKKsVTSTwj2DNa6/N16SogZcA3X
	 U5GVI51MpLeHvh5zbDbRrNkBuraMf2qoN7hJW3A5rJr9BsteAN1kPHgX6Wdcn9/6ldeRT
	 4WVEplglhRFxfhlypSGVvz2dttYo2bs+x8u2K8j2hxTCRCMCjTyeDD9HhcGEb0MlJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jF5GxxLt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A360A262C
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC2A360A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jF5GxxLt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLvrLfHh/BRFEzH086IMNWIjcHVbF+yOHy5vCiFhtRw=;
	b=jF5GxxLtud0XrH9dFDN3CDoTHTClV7487052FQTuxiPVhiD49WVubXOXq/wDt4pUJgtAQe
	qLWKf2ZrnExE+texQVYrh74Hs5793dIY3uL+n6FgDVMuvrAlEOYD9jniYJEIYOKQ6u03mF
	DpBYhJBHDy2JBC0BYjVJI0Dm9Nlriz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-nmwc7YJlN56QIpdIrHSdfg-1; Thu,
 19 Nov 2026 08:42:53 -0500
X-MC-Unique: nmwc7YJlN56QIpdIrHSdfg-1
X-Mimecast-MFC-AGG-ID: nmwc7YJlN56QIpdIrHSdfg_1795095772
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7609F1956064;
	Thu, 19 Nov 2026 13:42:51 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDC811956041;
	Thu, 19 Nov 2026 13:42:48 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: prevent file-context injection via
 crafted NSS strings
In-Reply-To: <20261119130853.858-1-stephen.smalley.work@gmail.com>
References: <20261119130853.858-1-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:42:46 +0100
Message-ID: <pjd7bi9vsx5.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
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

> genhomedircon substitutes NSS-supplied strings verbatim into
> file_contexts.homedirs: pw_dir for the HOME_ROOT and HOME_DIR
> templates, and on the %group login mapping path gr_mem[i] / pw_name
> for the "# Home Context for user %s" comment and the USER /
> %{USERNAME} templates. check_line() only validates that the last
> whitespace-separated token is a valid context, so a crafted home
> directory or username can inject file-context lines that will be used
> by subsequent restorecon/setfiles invocations and other labeling
> operations. In directory-backed deployments (LDAP/AD/FreeIPA) the
> passwd/group source is not root-equivalent, and every libsemanage
> commit regenerates this file if semanage.conf does not contain
> usepasswd=False.
>
> Reject values containing whitespace or control characters at both
> pw_dir entry points and for the user name in add_user(), and while
> here also apply the existing absolute-path check to the HOME_ROOT
> enumeration. Regex metacharacters still over-match ("john.smith"
> matches "johnXsmith") but escaping those is left as follow-on work
> since it changes existing behavior.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libsemanage/src/genhomedircon.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index b0482f0e..2ef923ce 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -43,6 +43,7 @@
>  #include <assert.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -313,6 +314,15 @@ out:
>  	return rc;
>  }
>  
> +static bool is_fc_safe(const char *str)
> +{
> +	for (const unsigned char *p = (const unsigned char *)str; *p; p++) {
> +		if (isspace(*p) || iscntrl(*p))
> +			return false;
> +	}
> +	return true;
> +}
> +
>  static int prefix_is_homedir_role(const semanage_user_t *user,
>  				  const char *prefix)
>  {
> @@ -576,6 +586,12 @@ static int get_home_dirs(genhomedircon_settings_t *s, semanage_list_t **out)
>  			continue;
>  		if (!semanage_list_find(shells, pwbuf->pw_shell))
>  			continue;
> +		if (pwbuf->pw_dir[0] != '/' || !is_fc_safe(pwbuf->pw_dir)) {
> +			WARN(s->h_semanage,
> +			     "user %s has an invalid home directory, ignoring",
> +			     pwbuf->pw_name);
> +			continue;
> +		}
>  		int len = strlen(pwbuf->pw_dir) - 1;
>  		for (; len > 0 && pwbuf->pw_dir[len] == '/'; len--) {
>  			pwbuf->pw_dir[len] = '\0';
> @@ -1201,6 +1217,17 @@ static int add_user(genhomedircon_settings_t *s,
>  		}
>  	}
>  
> +	if (!is_fc_safe(name)) {
> +		/*
> +		 * On the %group path this is gr_mem[i] or pw_name from NSS
> +		 * and reaches a comment line and the USER / %{USERNAME}
> +		 * substitutions unquoted; skip rather than let it inject
> +		 * file-context lines.
> +		 */
> +		WARN(s->h_semanage, "invalid user name \"%s\", ignoring", name);
> +		return STATUS_SUCCESS;
> +	}
> +
>  	int retval = STATUS_ERR;
>  
>  	char *rbuf = NULL;
> @@ -1263,10 +1290,12 @@ retry:
>  		pwent->pw_dir[len] = '\0';
>  	}
>  
> -	if (pwent->pw_dir[0] != '/') {
> +	if (pwent->pw_dir[0] != '/' || !is_fc_safe(pwent->pw_dir)) {
>  		/* an empty (or otherwise relative) home directory would
>  		 * turn the HOME_DIR template into a regex that matches
> -		 * everything, e.g. "/.+", so refuse to use it */
> +		 * everything, e.g. "/.+", and whitespace or control
> +		 * characters would let the passwd entry inject additional
> +		 * file-context lines, so refuse to use it */
>  		WARN(s->h_semanage,
>  		     "user %s has an invalid home directory \"%s\", ignoring",
>  		     name, pwent->pw_dir);
> -- 
> 2.47.3

