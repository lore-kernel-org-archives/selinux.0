Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4129D27D;
	Mon, 22 Jun 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158680; cv=none; b=RT2mAjOiTKDTVOWnkzhvKFbIGa0hpzjLTdDAxRysOme5DR/xMG5dedENg0OBUSdpNF+JXxda1O1D961Yy5Rgo+14tdvDwEgXj3J5h2bYJPERP6eFlWI7HPefHlNKA8+GPvk7o+owHfFhjOKgaC5lIyazcJykflCBZM/wGCyzX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158680; c=relaxed/simple;
	bh=SR5EuA1zBcJJr9W/iJyISJDR9as7fMAGczvZ3+4ezpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6d62vEpg6kjNEbn4AFfQWIAeuh88cXrXpbfUEGf7av2AlQ35JFC2P1X3g+90jfwDIZdfvahy8kS6zlusWTkQ6BwCVk7788EC/OI9cq+YuN0oGuwEPl05EQTbX1/lDvAIhozhwD164j1OeRqx2IlouVBGPXPken8gjTQWJnPi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=DUWNz4fL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQ9LNRuq; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="DUWNz4fL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQ9LNRuq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 444C713000D0;
	Mon, 22 Jun 2026 16:04:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 16:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782158677; x=1782162277; bh=h7eSJNUI1a
	7V+JqbPIMJcwRRHejJ3fmeySBUpEQRG38=; b=DUWNz4fLQFhbDufLQ+cCtGVGtb
	W+fem9j2OZ9rk740o7+HYbgI2ZFTqRk3DQbcDXMsc0Ha1qRyGgQlfTlJRZ0vKeft
	gG/hVrjfhsAHhIPd1tej8OjHgO4uvUNhsL7fGG4sQZa4pOf+FBnUVCPnRXHT7WaS
	liBwhHK/H2md5ZmKr7Wr+3AVOzwaH0N8EgD8929xWA3Q5MiKaECDNchDR5B3zWc5
	gT9ap/0SnXX8plDJZGzgy0CdpqC1Tb7IiS7sRR9JmS+tH0RRGrcgDwTc5BQH9xoe
	s5+5STq1v6nt8FpT+A/mHrg5qLniNRU7BqhVtv7CvTNpuUJzNDT+ptcGoA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782158677; x=1782162277; bh=h7eSJNUI1a7V+JqbPIMJcwRRHejJ3fmeySB
	UpEQRG38=; b=jQ9LNRuqQo6EXAlvcGf1zYjHXSTwsS2LgAEUoIaJaC1pnx02Z6K
	NONloVAMpujo+H4AhPxosxSJfX04LDUNZ/N/UmgCoEEE6Q08Zg7tczMp+NPo/C2S
	xSTOEMs6G7EZpwJWFt/AulV19nYRwPWDpdBuTy9/1/kzPC5U377NLzxUPVIhBd3S
	aOKz5NDYLDP4oflzco0luVFiWL4hslVyQy29Q2ziZUCBlaOGe8RLkTc63melVCBE
	HkWgBhGqGrBLUjSQP2NlocXAERUBu5DIwDvE6HXSDGDgYCdu++KrvkYySO2RXYfd
	5J4/maGJ4VnRgk5jMEPbvU7AObZ1vl+OZDg==
X-ME-Sender: <xms:VJU5avRlqmXSZMU1OpHSMv2zGbdS4JmxoYidXQYyYCgyZ_8SmI29JA>
    <xme:VJU5aq0AZEgZzebLi-97QCapToqR7OR6AHt18d7vFFmYn6LvTnxiE8vKJ_w7krdwv
    78tqlRmBBabNpQ3YrhGN6EaIOdfJmax4xhH7Waz7t8sRrlWpOBT07mM>
X-ME-Received: <xmr:VJU5aksThsSYZi3FWr0cb3CcSIaDZaGSqbiCERJiL5EQ7u2jagk7QkSnzng>
X-ME-Proxy-Cause: dmFkZTGUhilqtGs0gVYFQOpks+BScZpbL2RYQShCvXjFQPT0Nq5yx4jPVvKc3nGqjZuWzM
    VDJRehrZ/0Hno4EulEex/GTxDQRNgpuS/pYWYzCEOlqY+HdndiOMTanbcCgQLrlWWluJE7
    wPXVBStU0h1hr/7uFygWJeQFYOcyOfbA69i+ikMySpZxahXnpl/fN1j/rq8iie0EnZMQgr
    yMUAZTEFJ8cKr+f/ZT9iyfvdLF7F0pDYA/8+aFlQTYyf9/iPjla3KoCEan8JyJquzCwAOj
    6NUBXoFXvnRUkKY5mdLKe6Z613WnodLW/xBVw7dnpMxOrl8nkLru5npgkMdKQ7pA6L7qfJ
    P06FHw3sGdmkocihTonKwKHhfp1fevbTBjE3gDUIaSZH0fNlLoxSSqPbJcRr8is9jmkhqe
    wcF+3CHrJ49wcacZG+CuNFGiWTO9LNlL6a0qNNTlSaggwuVdNM9cyqVQJQ/E6W7D5yKgMo
    XUs0qx9bzhXX5MXuCPnGk2hULPaY9y2l3iDzijlwRQ882Xhm5dRoxwXtjvBY9mU2rXfdzM
    6+Xn6pJ7c87NZpDrM9PGMnAoc52IFdDxVvsk9ZkodyyoHiD9+iSx/Zd2wwaS4cqlwuyap8
    sX/dh4H8ita2qZbRyLNaRvpn2ZKp/CHFXU0tf8Lm7ejHUx5Av0PWWUKmoRUQ
X-ME-Proxy: <xmx:VJU5agiU-IMzRorXy5u88GboSx4DoB65lJ-r_fPPTU5qFFlPRmNPdw>
    <xmx:VJU5al_1woCx2Wfz5EI7Rg5ES8EaNfuxotxphCjTX6DsjCTfkgks4Q>
    <xmx:VJU5ajvx8gW-iRuFzY4XYQeN2AZ2HKbnTqmdVPdHeRiFEXNcRWcC6g>
    <xmx:VJU5appGzoE18s58Xor-iJD0gqAxtmktBolnX8tMkBNglbvxXa8WtA>
    <xmx:VJU5ai74fciEdMos7jOByUzo8aKdd_tKMrxIDLEG3m03oYLQUMpEA_B_>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 16:04:36 -0400 (EDT)
Date: Mon, 22 Jun 2026 15:04:34 -0500
From: Ian Bridges <icb@fastmail.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <ajmVUvURpXKLjYLo@dev>
References: <ajlN94VO7BYNUTAy@dev>
 <20260622175301.6a36756b@pumpkin>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622175301.6a36756b@pumpkin>

On Mon, Jun 22, 2026 at 05:53:01PM +0100, David Laight wrote:
> On Mon, 22 Jun 2026 10:00:07 -0500
> Ian Bridges <icb@fastmail.org> wrote:
> 
> > In preparation for removing the deprecated strlcat() API[1], replace the
> > strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> > seq_buf, which tracks the write position and remaining space internally.
> > 
> > The seven open-coded WARN_ON(rc >= buf_len) truncation checks become a
> > single seq_buf_has_overflowed() check after the string is built. The
> > kzalloc() and its exact-size computation are unchanged, so the
> > measurement string passed to IMA is unchanged.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Ian Bridges <icb@fastmail.org>
> > ---
> >  security/selinux/ima.c | 35 ++++++++++++++---------------------
> >  1 file changed, 14 insertions(+), 21 deletions(-)
> > 
> > diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> > index aa34da9b0aeb..3d81093d16aa 100644
> > --- a/security/selinux/ima.c
> > +++ b/security/selinux/ima.c
> > @@ -9,6 +9,7 @@
> >   */
> >  #include <linux/vmalloc.h>
> >  #include <linux/ima.h>
> > +#include <linux/seq_buf.h>
> >  #include "security.h"
> >  #include "ima.h"
> >  
> > @@ -21,8 +22,9 @@
> >  static char *selinux_ima_collect_state(void)
> >  {
> >  	const char *on = "=1;", *off = "=0;";
> > +	struct seq_buf s;
> >  	char *buf;
> > -	int buf_len, len, i, rc;
> > +	int buf_len, len, i;
> >  
> >  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
> >  
> > @@ -34,33 +36,24 @@ static char *selinux_ima_collect_state(void)
> >  	if (!buf)
> >  		return NULL;
> >  
> > -	rc = strscpy(buf, "initialized", buf_len);
> > -	WARN_ON(rc < 0);
> > +	seq_buf_init(&s, buf, buf_len);
> 
> That is silly, you need the length of the buffer not the length of a string
> that is the expected length of the output.
>

Is buf_len not the correct value to use here? buf_len is passed as the size
argument to the earlier kzalloc() call (not shown in the patch diff) that
allocates buf.

> >  
> > -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > +	seq_buf_puts(&s, "initialized");
> > +	seq_buf_puts(&s, selinux_initialized() ? on : off);
> >  
> > -	rc = strlcat(buf, "enforcing", buf_len);
> > -	WARN_ON(rc >= buf_len);
> > +	seq_buf_puts(&s, "enforcing");
> > +	seq_buf_puts(&s, enforcing_enabled() ? on : off);
> >  
> > -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	rc = strlcat(buf, "checkreqprot", buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > +	seq_buf_puts(&s, "checkreqprot");
> > +	seq_buf_puts(&s, checkreqprot_get() ? on : off);
> 
> That lot would be easier to read as a seq_printf() - with %d and
> kill 'on' and 'off'.

This is a good suggestion, I'll use this approach in the v2.

> Why does 'security' code so often look like c**p.
> 
> 	David
> 
> >  
> >  	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
> > -		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> > -		WARN_ON(rc >= buf_len);
> > -
> > -		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
> > -			buf_len);
> > -		WARN_ON(rc >= buf_len);
> > +		seq_buf_puts(&s, selinux_policycap_names[i]);
> > +		seq_buf_puts(&s, selinux_state.policycap[i] ? on : off);
> >  	}
> >  
> > +	WARN_ON(seq_buf_has_overflowed(&s));
> > +
> >  	return buf;
> >  }
> >  
> 
