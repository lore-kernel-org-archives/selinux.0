Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D730569F
	for <selinux@vger.kernel.org>; Sat, 27 Jun 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782596960; cv=none; b=eCIkyNyrx8lRa5+koDlfswv6z/vUaGFKCc3o76wqI3LFhT3Fjx7hH78IVkqmSECvmC5xmQ1DyBvmB+p/O4Visryf8QG+R6dw2N79VUoYeW2JVDq7ftPRLVIjV+rrEXDj6Xf/P+54q4DHWiYyzJDInJh3JIqTh3IzvmW240UPJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782596960; c=relaxed/simple;
	bh=68nQ8F/wKOdx7sIEHXlhuv/UHvO++uJWbFGpLpQpvGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0mQQAZrxZS7qzIME/S9dIMd2hpHN9T3HHCGKfdAYy549utx2NS0bE85yr1Bbwyo6DGoIbGO1KAu1HqJAcyN6QxDw/GOpsgtOnpZNLUVTNKcVpIZCyv8+2Aymah0MT8GzSmUawQUGEQGEXYe+EB8nFM40SCv5h6rhWQa+/57QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ3TxRoa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ3TxRoa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46fe472da0dso1056390f8f.1
        for <selinux@vger.kernel.org>; Sat, 27 Jun 2026 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782596957; x=1783201757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEN9TfqaZUsPLob8cVU9eEwSlgjveH90ByGGACtMAE0=;
        b=SQ3TxRoaIAOvACJJkkP6oL4CRDz5t/sQmakEkFNvhfEI933jz+SvyIxgGl/fNZEJ+9
         fQdFFpwAUYm39WXmFC0brqjOS8b9+eCByIUvKfMRgFO97ito2VtGy2l6eFNGFnFmat7t
         MY0JdputbPNMshx+2ZzAhZtEHKGjiJDg4u/7VljEfTU/5B6dtK8M5iBOdFcDycRN7b3l
         YGPYIgLrBOoxdgMuZJPjQcwaJcMaWozn2ZGs6qSYxl/+G/xDchWWohLO+zO30O1ydLQ0
         y9b0+Fw4sVdoxojErGpzpOxvwNCUzrBV02+Rvr4WOBoU+6+J2XeZ9B1KlogbOPpxdSPy
         7qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782596957; x=1783201757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEN9TfqaZUsPLob8cVU9eEwSlgjveH90ByGGACtMAE0=;
        b=XG1RRrp0Z6iFat38MBCXRdbLVA0CPSQVc/gd91zkIvoPQCC+k0fw1kWRAY1WpBaU4e
         UEov/MNpvMi9AoPo8pwlFiC5hxuYXCFdeCc29aBe8lmnnt1PxyCbMP2Z4XwjzU7HtuH4
         6qsckS+6LxJ+tGBkpIQFc9KFUw1xYaXBfy2eCmkukiuzrWgxh4OJ5YApr2zo+Vi3dY+B
         rIjwEce2MsmQNJ7yzJjibFI0GxrOeNRRjh+ZrUBXwlnGfA9liqr9ohpGbpyX/mcxqd3d
         vg4t/qxDF6ntXsfZd/4rsPy9vCWMl1zneJeornlYbcfoZtP84H40B3u7DWv77QxR9jID
         Hz0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqtwCOQozRLw5zKchWm4CRfgxk9dEs/wrM/kOSQW1lq2fNDT3QSUapq1DK/v3G38z+Z9gFczr5D@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSBrkJnkEI8R1ozheXJPx04bDBdqwHYrz9svq9dJuiUn8caKL
	HJZoQdtu92OCzC3/fRFXM1yOTpmFpXrTfbV8mz3HFHrxZYKq8/39SatJ
X-Gm-Gg: AfdE7ckKi1ZZFd5t4DtGiK0S/GqbKzZjs8NftVAHK1BKiHxfVsdLsZ7YOI8gudIxwjk
	bwtfoAf2uXz17JAyrJ6Bo1EH+4uOsgQfs2nwjyJjqOJfpB9M9mJtBo8C60K7S9UrfOKNhm0mXru
	TQEsjmNTeFImwAJhkP1pTMtGANkAf1bdEW19brnzcmADDYcRiHB7cw0ah4m4e1vk6t3q5vWu3x0
	VXUztGvHVOr976im7F/8Tk5K0pQifQDh4OwVXfKDtOeXZ86fpbqUtUZeIbLQazF7HsGP6z39ZvN
	cEplukRwz7M4+dGGJNll71hwPqiSAPnUKGYUXGqYGZoDQUCrE6hkPpEApT8hD6wcQ8H1wc37iLR
	8wdQuMnFkxp+ThIEfPYg4xkFgHPb0gSw41x6L1lR3qXr5FE0K9dWqBKeQMZjwDyGcCVxwKoHYOR
	HiGbn5LKIVJKVWfCu1J0sVys046Q3JyRDi031a26N0dsIJCQ==
X-Received: by 2002:a05:6000:2484:b0:46f:5d62:d914 with SMTP id ffacd0b85a97d-46f5d62db15mr10310672f8f.12.1782596956934;
        Sat, 27 Jun 2026 14:49:16 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472de944719sm158151f8f.2.2026.06.27.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:49:16 -0700 (PDT)
Date: Sat, 27 Jun 2026 22:49:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <20260627224914.68b506b0@pumpkin>
In-Reply-To: <aj6hVjECikvYtnED@dev>
References: <aj6hVjECikvYtnED@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 10:57:10 -0500
Ian Bridges <icb@fastmail.org> wrote:

> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> seq_buf, which tracks the write position and remaining space internally.
> 
> Each field is written with seq_buf_printf() using a "=%d;" format, which
> removes the open-coded "=1;"/"=0;" constants. The seven per-append
> WARN_ON(rc >= buf_len) truncation checks are replaced by a single
> seq_buf_has_overflowed() check after the string is built.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> Changed in v2: replace the v1 seq_buf_puts() pairs with seq_buf_printf()
> using a "=%d;" format, which drops the open-coded "=1;"/"=0;" constants.

Did you verify that all the values are 0/1 otherwise a !! prefix might
be needed.

> 
> v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/
> 
> I didn't change the precomputation of the string size. An alternative,
> which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
> mm/memcontrol.c), is to drop the precomputation and allocate an oversized
> fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
> happy to rework the patch to adopt that alternative.

That would be reasonable, the output is always exactly the same length and
the buffer is freed just after being allocated.
A comment that there are 3 + 15 strings and all are under 32 bytes so 1k
is plenty would suffice.

	David

> 
>  security/selinux/ima.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index aa34da9b0aeb..cb0efa2fc1ad 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/vmalloc.h>
>  #include <linux/ima.h>
> +#include <linux/seq_buf.h>
>  #include "security.h"
>  #include "ima.h"
>  
> @@ -20,46 +21,31 @@
>   */
>  static char *selinux_ima_collect_state(void)
>  {
> -	const char *on = "=1;", *off = "=0;";
> +	struct seq_buf s;
>  	char *buf;
> -	int buf_len, len, i, rc;
> +	int buf_len, suffix_len, i;
>  
>  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
> +	suffix_len = strlen("=0;");
>  
> -	len = strlen(on);
>  	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> -		buf_len += strlen(selinux_policycap_names[i]) + len;
> +		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
>  
>  	buf = kzalloc(buf_len, GFP_KERNEL);
>  	if (!buf)
>  		return NULL;
>  
> -	rc = strscpy(buf, "initialized", buf_len);
> -	WARN_ON(rc < 0);
> +	seq_buf_init(&s, buf, buf_len);
>  
> -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> +	seq_buf_printf(&s, "initialized=%d;enforcing=%d;checkreqprot=%d;",
> +		       selinux_initialized(), enforcing_enabled(),
> +		       checkreqprot_get());
>  
> -	rc = strlcat(buf, "enforcing", buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	rc = strlcat(buf, "checkreqprot", buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
> -		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> -		WARN_ON(rc >= buf_len);
> +	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> +		seq_buf_printf(&s, "%s=%d;", selinux_policycap_names[i],
> +			       selinux_state.policycap[i]);
>  
> -		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
> -			buf_len);
> -		WARN_ON(rc >= buf_len);
> -	}
> +	WARN_ON(seq_buf_has_overflowed(&s));
>  
>  	return buf;
>  }

