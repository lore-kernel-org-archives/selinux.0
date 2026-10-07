Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BE342523
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404089; cv=pass; b=at0hKu1qLHBzflASJc5M4rBsko0Zvv/002iu+LxQZC7M6dU7FSqjJSGfMZJiLGZXXq9weK7+LJqd6BECbse5dlKYt6l4Dg3+TCS5JeeVhECGd4UPTw0/m6c/JcXaAYMWNOK2Ipsr3OH3wsE57x/9epbQRpXX1Bv8WW8IbQR1bBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404089; c=relaxed/simple;
	bh=SoSpP8WSwH/gLmaXIUYUpzoSOKZVHLpgM5LyKeG6LH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNmLNmdibBGMseI1ar0gTekmDH85IgyxxV9oUFvffjBbZheEyKtxgV4KIYgDAukM9coxg9SwQkkN+8iEA0Avo/aqxI0m72EOphQjTUFsJDDPucM3bx/K2pb42vRmKx4QROTH/bL1+LdJO98EgJpRz/aa63p4GNimk6O6ePYJN+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfQsJNHH; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfQsJNHH"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6768403e9bbso2547985d50.1
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 13:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791404087; cv=none;
        d=google.com; s=arc-20260327;
        b=kqwywPJBYEETQyYvlI2znBkEzeb9sIqSfQS/kqIiCjAq/k9rUsCB3CxN9ElcYC8ZW4
         8pKPbQoEbsw5BlHUrgL9xgBwMmKAUMJsnjH+eEX/9oeu0mhNncXFiLdmgcWY3381D4wg
         XL/0Z2TsNhhKKxGzOwxO4HOW6QtGfKiSZR4fNoAeOqlc7PPE7kzFmK6t9dthfHckzmmM
         SaOQOOIgsLviNUKxlUGCYH3bbKVoVH3tB8r6SwE4HI67C6hLk8aWBF2Y2zkXFK86SUBV
         5DiiuFf7GWB/YtJJ25LpnfE9DEj5vsAquSpC4r1DUrUZFBzL5nZ3r7gQkZ3fNoqPuvJ/
         rvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+CGHcsSLS3zJVzOTaI344bI/xUHPzhVpipYvjPq7Uy4=;
        fh=70ac3Nu/9NXKnHlYiwlzC0S2l6TozL9UGuJMqFYgbLA=;
        b=MYMz3EMw+7R4IuHZW9rwQYXj4Fe+wzBInXaK3FY3t5FVPfbcp9FdlsEWS27NsKz5MX
         PqTcjG2mOk+N9aYP31M8V+GxexSPhvEthFZQY7pApLrf2Tp/mTcMosEOmOm+b7JccD2D
         9X/4lNeFoAqWNhPp0o3HzyRyUJTn4c/TCd86l8wfZTn2fKuDl6eXG+fKd2pZzV+d01c6
         QVYk29lz7kjaMzEWjKdQNn34ji+uVFsIU8+hkqT7mXTUPlDbf9IAFsTiBb2H/whhvsQm
         UGH6RbE4LL71nNvXamzE9Gw8Z57lgY5Ia5tS55lqqtBh3fx2STvw8nLHgD/Ea9U8xfBW
         cIlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404087; x=1792008887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+CGHcsSLS3zJVzOTaI344bI/xUHPzhVpipYvjPq7Uy4=;
        b=nfQsJNHHu2ZY2b02BLQDfGpBdDuiDtsYCn14aPKP8tRoSsqdKqpmDesN7utSj2Dq3t
         y1+dM+DeCrgnOkmMn2Yq5iuba9Uhgt6Cex+PDj6SHrxNLKV+zyiBNXZOLw117Ol8+oR7
         HrINQObwe5URO5zQifyNzwH0JFvR8CMs1WnP4rN7V2VUtOKEjt6T2n5s/201qPyvjJxQ
         UQJ1tGc+6lK3W6ss3aWUdcCpGmwJgl6g/vZ6H0+349dZTyB+E66VJT+2WZG3rmop+KRb
         PYMozD4OC0MqKr8AjCmuMij9ymMod65ozYKm732vCQKcjmUWSQAaWpZOx8ILTd9LIx2R
         EsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404087; x=1792008887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CGHcsSLS3zJVzOTaI344bI/xUHPzhVpipYvjPq7Uy4=;
        b=nzxo1oDPrpK/365KLc0Cvnuev3zagk5yBkcSY6jcHH5g07kwCIIbBMfOu43DeUY/zW
         ku/L830hK3sUzb1Qbj4ZCOZC094oH2ijSx49/PdvpPDxoOcJxKqKJQla3AqcI6pc/k/4
         fvCsnZYzCvLQXtvbPFJwJTdt12kQChuldQarePJQM5GF+WwLoT79bb3xY1RsRDbDsAiH
         M0vsAi75M3OSqPqAb+SkhbeQwpV23a2EQs7rQXSWY+nFbNzkQ4CePWSoj++cCju2ULo6
         O6TTS0fatKWb7lkiByHdUZhXkASKgr5gFsrP5zau6jJQVrxl/lhwPhfeWlGWJ/OFWpeM
         4owQ==
X-Gm-Message-State: AFq9FYL38oGceXrW4HVil/OdfXqUS+ZFbdIg6sZF2ULWteVZ1kLB5uOP
	srnQyntZut8/P5RSgXBO6OFb8vmT34RhqBVJe259XrP7V8586eFU8i28qzlFFrElWbRq5Z//RZJ
	tQMFdFUcMZrgAZxOwnoAXpFspYRyCNdLY0glS
X-Gm-Gg: AYBFou3l7Xmvknf8lt8g1HcU/SRh/FZHssnu+PtXzd1L41jTzBXQGfb2Lti7ta6Wnqt
	QQT5jGWlg+UvzL5yvaRfge/+Tc/EaVePI395WDH7+LUroBvSJQNIW7dkXrPJOi0ukkHm6LPTP1F
	rTZFs58MwRKgU62eCEruucxWERp1kM2pLcQw7QzlfMlx4huXm44uKnuNFL1e20KKLYw3aneQ11b
	dD41eQrZM/bnI7xex2ElPQcBmOGGKf3vFebeG+Z1nI5HvQEX6Y9SkFAcd0ObsRGwDotU0EUVGG7
	NHS/q584owd5sqsda/yadz7+Jm5ctNzV1kssfIMGcxVlSgsoLBKMh8jgP7NWBap77Q==
X-Received: by 2002:a05:690e:168b:b0:677:d93e:ee69 with SMTP id
 956f58d0204a3-6790a2973cbmr2245502d50.94.1791404086742; Wed, 07 Oct 2026
 13:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com> <20261006130215.128405-11-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-11-jjanasek@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Oct 2026 16:14:35 -0400
X-Gm-Features: AclHuK9lYmTWuQ5VQBxIGPv25ljnN5NTo6UC1dyzNX8QjhcqHWaGUeP1TCgHbg8
Message-ID: <CAEjxPJ6tpzhZn7_KdK+BUZjuAamoeXFVKSAYRU-tzJY6zYUXTg@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 10/17] libsepol: add context resolution from
 policy values and SIDs
To: jan janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:08=E2=80=AFAM jan janasek <jjanasek@redhat.com> wr=
ote:
>
> Add sepol_values_to_context_string()/sepol_values_to_context_record()
> to build a security context string or sepol_context_t from raw
> user/role/type values plus an optional MLS range string, without the
> caller ever touching context_struct_t.
>
> Add sepol_sid_table_t, an opaque wrapper around sidtab_t
> (sepol_sid_table_new/load_isids/set_opaque/free), so callers can load
> and install a policy's initial-SID table without including
> policydb/sidtab.h directly.
>
> Add sepol_policydb_sid_to_context_string()/_record() to resolve a SID
> to a context using only a given sepol_policydb_t, without requiring a
> process-global active policydb/sidtab via sepol_set_policydb()/
> sepol_set_sidtab().
>
> Assisted-by: LLM Cursor
> Signed-off-by: Jan Janasek <jjanasek@redhat.com>
> ---

> diff --git a/libsepol/include/sepol/sid_table.h b/libsepol/include/sepol/=
sid_table.h
> new file mode 100644
> index 00000000..64d08fc7
> --- /dev/null
> +++ b/libsepol/include/sepol/sid_table.h
> @@ -0,0 +1,43 @@
> +#ifndef _SEPOL_SID_TABLE_H_
> +#define _SEPOL_SID_TABLE_H_
> +
> +#include <sepol/policydb.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Opaque SID table for use with the security server helpers (sepol_sid_=
to_context,
> + * sepol_context_to_sid, etc.) without exposing sidtab_t.
> + */
> +
> +typedef struct sepol_sid_table sepol_sid_table_t;
> +
> +extern sepol_sid_table_t *sepol_sid_table_new(void);
> +
> +/*
> + * Frees a SID table created by sepol_sid_table_new(). If this table is
> + * currently installed as the process-global active table (via
> + * sepol_sid_table_set_opaque()), it is automatically uninstalled first,
> + * so subsequent calls into the security server helpers (sepol_sid_to_co=
ntext,
> + * sepol_context_to_sid, etc.) will not dereference the freed table.
> + */
> +extern void sepol_sid_table_free(sepol_sid_table_t *tab);
> +
> +extern int sepol_sid_table_load_isids(sepol_sid_table_t *tab,
> +                                     sepol_policydb_t *policydb);
> +
> +/*
> + * Installs tab as the process-global active SID table used internally b=
y
> + * the security server helpers (sepol_sid_to_context, sepol_context_to_s=
id,
> + * etc.). Only one table can be active at a time; calling this again wit=
h
> + * a different table replaces the previous one as the active table.
> + */
> +extern int sepol_sid_table_set_opaque(sepol_sid_table_t *tab);

set_opaque() reads oddly; _install() or _activate() would say what it does.

> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index fdd84078..a44eb395 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -127,6 +128,18 @@ int sepol_set_sidtab(sidtab_t *s)
>         return 0;
>  }
>
> +/*
> + * Returns the sidtab currently installed via sepol_set_sidtab(), or NUL=
L
> + * if none is active. Used internally (e.g. by sepol_sid_table_free()) t=
o
> + * detect whether a given sidtab is the one actually in use, since
> + * sepol_set_sidtab() can be called directly and bypass any bookkeeping
> + * done by higher-level wrappers such as sepol_sid_table_set_opaque().
> + */
> +sidtab_t *sepol_get_sidtab(void)
> +{
> +       return sidtab;
> +}

Defined with no prior prototype; -Wmissing-prototypes flags it from a
top-level build.
Declare in src/private.h or similar.
