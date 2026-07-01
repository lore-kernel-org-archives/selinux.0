Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18B3EDE54
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899562; cv=none; b=AjuLEy6GZqNIyWSvFX/AhaqaMYhNLQS5bvH5AEZVb2Z/VzYvYIEdxZM2PbVKUU7OpVM9RmwnLYktbeHvQnIYydTHDE68Ib3tMx0Kzc1Y/bPCpUsEvbrnqo0v91QwoEWNNkuR1355JLHoEx/QVrJQpVCZIrUQqcbXaI83k72m9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899562; c=relaxed/simple;
	bh=ceEp1yWHS2rI9FV3hh8oAtV9bvoPQs9rQQCGvhLiECc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWnCcEPNbc6hdQM2oAl9YjWOA+h2MvgoFtszmakzul6Rib7e5VCWoUYUt7pWnQk4vyoGBUTg+8Odgo5L2DAOIAFp6PQ/x0AIZE3JBb6KM/Q1vcbrGR28j9frHbEdoaKVSoGDshJP8eUdB7wU3r+mB5na5VV3/Qccrd+L2WCPWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/MLZ0+e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/MLZ0+e"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so1973465e9.1
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899560; x=1783504360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqbno7ujq0aZ6PN45IXpH4UapLNFI2wSOuPDyXwmuAc=;
        b=r/MLZ0+ePDGwm/FSe1ujm8J0+6z1fuALddOKz1fQ6BL7L3bt+c9SmIH91jqz/orENZ
         ziByY8TNS6ZQgJ8SBkyPSBWODj3fTxg5Mg7eG1vcky64KcYitvhAkl6ULCd3oSZVAEYq
         U1LhL4c+5TllnXq27K6LhVLH69iPG1rfCmxb5MoHUIirEpTI6dS/WD5FzU/ZduRUUV/E
         qgaF6kUzObkreHpncFp/0yem5GrMhwq5m91NQbzPOmZxFtZv1EmZckWVwCqf9bm3ffSd
         3xqMc3zoq2pWf+4mQ0UEHdJ1Tkxabipyc9wapq1GIky51FsMlv4SJiSbqGrop82TIqg5
         N3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899560; x=1783504360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oqbno7ujq0aZ6PN45IXpH4UapLNFI2wSOuPDyXwmuAc=;
        b=ooZuhbHptcRXd+gMcGOLKncF+HvYWgEjrlIHtH1cPr8F+jH2qA8QQpmTxIg68vWmU/
         iXIk9Od0LVLfm8qYhiyhLx6zXiybs/GtpjUOGmc8pmV7RYiFD1FH/NqDcnulT/7rgZ3m
         unXDTpxNVKyNIf1sb+8Y2P+kbRYE3q565e9+CB4+TT6Vmcs7X3GnzsdIosw1nogM0fQG
         UbR2udR0A/1+XcKiA9ut4oxK7XkBmzXSivmBYvm3kpCaORoXUzMvNnh8HxDnDf0VxIei
         YQ2Dod+Rp8OCUVxAIHqHm4cTIJ2JR/UCy1DZFa0+hJUGR7LAQEgYvGV5jf+SzOrh2Coa
         6whA==
X-Forwarded-Encrypted: i=1; AFNElJ/NuGDAFXYfybWSL+G6n6LsTuFRUr0PVKVT/wuPcUCCY2CuYM9o3ZEgb96phPcJlals6CXsosMT@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNg1eETD50r4xGkb7h5UrUxTR5ZpKJCtiTRfz3QmhvvU20ALa
	up+vDt5GzVIPkZc/tujGDUn0uCazTOreIXbMReH8aEcqDJ6MJUJSAiI5
X-Gm-Gg: AfdE7cnmb951XDUm0Omvufjh7SPKfnQRYlIdWxW8rlBcwfZvkCWOmvNpsg5AQNowjTq
	bzm0xM22waT7Z4UcQC4IhedIdSJO/xfc/Xoa9Gx5VszlZYAwdCMh93ADPpjnnCI8X6NjmAJeH7u
	jwlt7Hp4EDhKN/FNpp8tSTYer2BcBMQKdZRakF8ZzGiobx96sVcbS9tzW+IkyD/Fh39zA4EZTth
	2r7GF9bZxSdxDUC+clV9yYB6cFUMG0V/zvgVbZq20i93vw9IIgUz1lLcdKi2Zn9J42L/XuGTKt/
	tX8iZqE7gIriWFOsB9McE3cfT6yBqPpQzDrktPsqPqY2SIHMmlgPv36Lu8STRJ9ulJhOu3B2XEy
	c1ZTHFcyzJ+F+dyZ4249k71PoBaBZYlSVgBJE6kpgcr4mxKuFxsOZrtdKic3OxJqh4fH5LOTLsD
	qlYcy4psx+/KYQCusjleLV/QtkMrBI7Vh/NqRgAaxQU+Wxkg==
X-Received: by 2002:a05:600c:8b44:b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-493c2ba5968mr15479995e9.34.1782899559390;
        Wed, 01 Jul 2026 02:52:39 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d8f5asm93522145e9.8.2026.07.01.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:52:39 -0700 (PDT)
Date: Wed, 1 Jul 2026 10:52:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <20260701105237.0a797d5c@pumpkin>
In-Reply-To: <akSrg483zJ0ii7wc@dev>
References: <aj6hVjECikvYtnED@dev>
	<20260627224914.68b506b0@pumpkin>
	<akSrg483zJ0ii7wc@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 00:54:11 -0500
Ian Bridges <icb@fastmail.org> wrote:

> On Sat, Jun 27, 2026 at 10:49:14PM +0100, David Laight wrote:
> > On Fri, 26 Jun 2026 10:57:10 -0500
> > Ian Bridges <icb@fastmail.org> wrote:
...
> > > 
> > > v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/
> > > 
> > > I didn't change the precomputation of the string size. An alternative,
> > > which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
> > > mm/memcontrol.c), is to drop the precomputation and allocate an oversized
> > > fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
> > > happy to rework the patch to adopt that alternative.  
> > 
> > That would be reasonable, the output is always exactly the same length and
> > the buffer is freed just after being allocated.
> > A comment that there are 3 + 15 strings and all are under 32 bytes so 1k
> > is plenty would suffice.
> > 
> > 	David
> >  
> 
> I didn't originally take this route because a fixed buffer bakes in an
> invariant (the whole string must stay under 1K) with nothing to enforce
> it at compile time. If more capabilities are added later, or a name grows
> longer, the string could overflow. That shows up only at runtime, as the
> seq_buf_has_overflowed() WARN, and the measured selinux-state string is
> silently truncated.

You could use '32 * (3 + NUM_CAPAPILITIES)'.
IIRC the longest is 24 characters (plus 2 for the =[01]) so that will be plenty.

	David


> 
> Thanks for the review.
> 
> Ian
> 
> > > 
> > >  security/selinux/ima.c | 40 +++++++++++++---------------------------
> > >  1 file changed, 13 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> > > index aa34da9b0aeb..cb0efa2fc1ad 100644
> > > --- a/security/selinux/ima.c
> > > +++ b/security/selinux/ima.c
> > > @@ -9,6 +9,7 @@
> > >   */
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/ima.h>
> > > +#include <linux/seq_buf.h>
> > >  #include "security.h"
> > >  #include "ima.h"
> > >  
> > > @@ -20,46 +21,31 @@
> > >   */
> > >  static char *selinux_ima_collect_state(void)
> > >  {
> > > -	const char *on = "=1;", *off = "=0;";
> > > +	struct seq_buf s;
> > >  	char *buf;
> > > -	int buf_len, len, i, rc;
> > > +	int buf_len, suffix_len, i;
> > >  
> > >  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
> > > +	suffix_len = strlen("=0;");
> > >  
> > > -	len = strlen(on);
> > >  	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> > > -		buf_len += strlen(selinux_policycap_names[i]) + len;
> > > +		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
> > >  
> > >  	buf = kzalloc(buf_len, GFP_KERNEL);
> > >  	if (!buf)
> > >  		return NULL;
> > >  
> > > -	rc = strscpy(buf, "initialized", buf_len);
> > > -	WARN_ON(rc < 0);
> > > +	seq_buf_init(&s, buf, buf_len);
> > >  
> > > -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
> > > -	WARN_ON(rc >= buf_len);
> > > +	seq_buf_printf(&s, "initialized=%d;enforcing=%d;checkreqprot=%d;",
> > > +		       selinux_initialized(), enforcing_enabled(),
> > > +		       checkreqprot_get());
> > >  
> > > -	rc = strlcat(buf, "enforcing", buf_len);
> > > -	WARN_ON(rc >= buf_len);
> > > -
> > > -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> > > -	WARN_ON(rc >= buf_len);
> > > -
> > > -	rc = strlcat(buf, "checkreqprot", buf_len);
> > > -	WARN_ON(rc >= buf_len);
> > > -
> > > -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> > > -	WARN_ON(rc >= buf_len);
> > > -
> > > -	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
> > > -		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> > > -		WARN_ON(rc >= buf_len);
> > > +	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> > > +		seq_buf_printf(&s, "%s=%d;", selinux_policycap_names[i],
> > > +			       selinux_state.policycap[i]);
> > >  
> > > -		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
> > > -			buf_len);
> > > -		WARN_ON(rc >= buf_len);
> > > -	}
> > > +	WARN_ON(seq_buf_has_overflowed(&s));
> > >  
> > >  	return buf;
> > >  }  
> >   

