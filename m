Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F2392831;
	Wed,  1 Jul 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885258; cv=none; b=X9Eot1CQFgGQdojhPSwRY0BibLo4rBsgGiriXYa2DoN4TcDag6V8nB+biJ/gjgEJzH4Hy4+1Ui7cyGahiaaapuyz9uKM8ki379+kUdy65dQ5C+Dp70GrZ0uehy9O2OqhGw7pk2SdgmlJE8B9w7Cw5EcNyUgRXQ65EEy/fWs1BYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885258; c=relaxed/simple;
	bh=G9FmRNQaGeDF30yOlsxIhmhnqhoroDO9fziYdG0YmwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lit7FgeIv88OAnqTLTzXT+y+/MHocHz1oCcaVQfcsE9QUNZcFvC03JhxujwJpwxlyuqPExHpOn4dKEyWDzDShhdJD2O35bh+HO670GfdGTal5q/cDQuPIXIGPnXO+rpk25E8HQgRDgflkf0h7i+F5yq6zSHqzEziwRcGh5Tustw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=g7OjKefD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQUcLv42; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="g7OjKefD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQUcLv42"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 7EBDA13000C0;
	Wed,  1 Jul 2026 01:54:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Jul 2026 01:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782885254; x=1782888854; bh=3Ulh/2Kege
	xKG2peKySArAtakyx82NioPY6leOKwzLY=; b=g7OjKefDOaFWBoEFNkKioKN0aL
	ysSJKH0XMxRyH9x2h5mKCdoExDXECHF4Axv7urNWvoLsYoMk+EEOvtCiifPhzrt9
	QvjF9BZa19VVjZ/Ny5ryjj7K9JX0qXEQB+vP1d6nQCBm6zgm91aZpSx1VH7Uw3Rg
	OFb+R7cM4Sc8lgSNF4Izw9FZCL9tmXKtN4oVYWzpsHPE7wa1MID8iASzhi0ov+Bx
	/eVfPl7EalDQyaf8PPEDWuIadg6FspVEdsb0XnCTCglmYBtfJQYT1DMSz++n7rZ5
	Vy3g1nHlIPJ1HZ0d+evF0qtKQ3nHiLDPQEZYFsFHBDqibk7U0CcLQtyOdM7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782885254; x=1782888854; bh=3Ulh/2KegexKG2peKySArAtakyx82NioPY6
	leOKwzLY=; b=QQUcLv42oP3+rMPdLMPazn3VqU+SarGGu7qd+QAp6XezEyxVKHG
	dLiHStuzOA32s6KtfUdr29QYpWeitT4K5PTOnbRtLDbndezIIynRvL6789N5JrKA
	l1vCTvtbCB8yINJDmDqlrxlG5cjIof1GJzL1itJ9xdNOh9V9aKcbSvwh/7t6xkhG
	BD6QUZwSRe/PnkK+FR78NIpUrq5HVeLhNmqDOWl8YosNrVzr6n2NOV1XVZPRWi+5
	+ySKpGX4UI/8qGqh/EVB+8d5W5ghq0rQ36L/KPGSU7NTHy8rTrM/OCKM6XO6awGo
	TPdTomYQd/qLCj3L8JEV7Xh7ZLJtdJnPYgA==
X-ME-Sender: <xms:hqtEauJJo2C6PqO6S9ii8SWrNhlAc_bchAW-6WfrwsV8OBg01u3Yjg>
    <xme:hqtEagPhjERn7Kgjrzw5oNh3gznvITBl9usODhZVrahB7XMHSrSMn-4nXl197YGu-
    WCnuT0E4vJoTPfHKPYd208h14mTWjiEqnhRDNi4wMb1IyZeZ7xFMw>
X-ME-Received: <xmr:hqtEaunbwj7qGDaaltwPyS7q_L9CEuMX54uyZxMoqzVJ4rDALpLeIOu2vAI>
X-ME-Proxy-Cause: dmFkZTF2pJgt7bSh6SnJ+ci38TUbsjZwTtwuaGfhf6c0pyXqbOuD4GbHLZnYsgdj4tl1Um
    uc5NoLALq69Pux30uMKCM1Rc9o6lGVTDdumX2u6lfb+EvBFMfucBQMsl7RdFFtV6FuwttP
    LwXriz4C/+Phx60Zynpd+w/QK2WKCXyFpeT1tVz7m2u3R7QTr3tj+TcB9JCiOxyDGOLhgA
    VPfkRC0If6AD8MM3rY3kNqwQPGFC3gt0rY1EbawIXzl2Dj/POYkxeMvRB/HDv0rmp/N6bI
    1bCiGKvZbeXO6EZyiS8WPrw3tt5e2sl/ViOa7NGHVFr5iwcAeAoler6tL4WoERNHZdqKiA
    nvF2SkgcVMCKsWejlgkelwcsHoRdFU2VW58YTGZF+YAwafhvoohToIoCQS+AxWmzLNvTri
    E9R+fmtfHLj1HIxeQgshGQv7Q/lWTRJW07sEMlfR6HTkBkbly0pzRwZJ9RO7d5QZgwKV9c
    du4FuM8B2StuARonIzEK+NMRMR3dGcxfHqoLa3Tj5cEZC9UPycF7RaBDqebDwXomNQZZvz
    hD7GXFKtD/Wmm2UiJfs3GluJjMFJMDwXDIMv4m6zih6l01o2wF3DvArCBbHg870hlfB/7m
    FTp9cLZcwKwfvS1Rpl7YR3QiJjM9FA+uuMZ/AAqjrHggtZW/W9kFdth5SzMw
X-ME-Proxy: <xmx:hqtEak7zvyEBdjYYZcq_U2QuaQEUdkk4X5M7mL3WDaU5xJcmS8EgyA>
    <xmx:hqtEai1qx1avrzSeb_C7i0moLaNeQBeyN2gpoEItcJvdU52_P-Y3iw>
    <xmx:hqtEavHAsXiBJZfjY0GhtHXisAQF-pxLlrS7IEjfaqd7hikEO4rpcA>
    <xmx:hqtEahg7chsm4PfUcNgA2-odaaRUvc-61vq5vEXC0i-_7Mo8IBPmbg>
    <xmx:hqtEagyf4_8qTha5c1KhxIv6jvXJbBu4IsuhbzK2Yo4CJNthBdKJnZg4>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 01:54:13 -0400 (EDT)
Date: Wed, 1 Jul 2026 00:54:11 -0500
From: Ian Bridges <icb@fastmail.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <akSrg483zJ0ii7wc@dev>
References: <aj6hVjECikvYtnED@dev>
 <20260627224914.68b506b0@pumpkin>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627224914.68b506b0@pumpkin>

On Sat, Jun 27, 2026 at 10:49:14PM +0100, David Laight wrote:
> On Fri, 26 Jun 2026 10:57:10 -0500
> Ian Bridges <icb@fastmail.org> wrote:
> 
> > In preparation for removing the deprecated strlcat() API[1], replace the
> > strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> > seq_buf, which tracks the write position and remaining space internally.
> > 
> > Each field is written with seq_buf_printf() using a "=%d;" format, which
> > removes the open-coded "=1;"/"=0;" constants. The seven per-append
> > WARN_ON(rc >= buf_len) truncation checks are replaced by a single
> > seq_buf_has_overflowed() check after the string is built.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Ian Bridges <icb@fastmail.org>
> > ---
> > Changed in v2: replace the v1 seq_buf_puts() pairs with seq_buf_printf()
> > using a "=%d;" format, which drops the open-coded "=1;"/"=0;" constants.
> 
> Did you verify that all the values are 0/1 otherwise a !! prefix might
> be needed.

Yes. selinux_initialized(), enforcing_enabled() and checkreqprot_get()
all return bool, and selinux_state.policycap[] is a bool array.
checkreqprot_get() always returns 0. The others read bool fields that
are written only by normal assignment (WRITE_ONCE() or
smp_store_release()), which normalizes the stored value to 0 or 1. So
"%d" prints "0" or "1", the same as the old ? "=1;" : "=0;" mapping, and
no !! is needed.

> 
> > 
> > v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/
> > 
> > I didn't change the precomputation of the string size. An alternative,
> > which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
> > mm/memcontrol.c), is to drop the precomputation and allocate an oversized
> > fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
> > happy to rework the patch to adopt that alternative.
> 
> That would be reasonable, the output is always exactly the same length and
> the buffer is freed just after being allocated.
> A comment that there are 3 + 15 strings and all are under 32 bytes so 1k
> is plenty would suffice.
> 
> 	David
>

I didn't originally take this route because a fixed buffer bakes in an
invariant (the whole string must stay under 1K) with nothing to enforce
it at compile time. If more capabilities are added later, or a name grows
longer, the string could overflow. That shows up only at runtime, as the
seq_buf_has_overflowed() WARN, and the measured selinux-state string is
silently truncated.

Thanks for the review.

Ian

> > 
> >  security/selinux/ima.c | 40 +++++++++++++---------------------------
> >  1 file changed, 13 insertions(+), 27 deletions(-)
> > 
> > diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> > index aa34da9b0aeb..cb0efa2fc1ad 100644
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
> > @@ -20,46 +21,31 @@
> >   */
> >  static char *selinux_ima_collect_state(void)
> >  {
> > -	const char *on = "=1;", *off = "=0;";
> > +	struct seq_buf s;
> >  	char *buf;
> > -	int buf_len, len, i, rc;
> > +	int buf_len, suffix_len, i;
> >  
> >  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
> > +	suffix_len = strlen("=0;");
> >  
> > -	len = strlen(on);
> >  	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> > -		buf_len += strlen(selinux_policycap_names[i]) + len;
> > +		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
> >  
> >  	buf = kzalloc(buf_len, GFP_KERNEL);
> >  	if (!buf)
> >  		return NULL;
> >  
> > -	rc = strscpy(buf, "initialized", buf_len);
> > -	WARN_ON(rc < 0);
> > +	seq_buf_init(&s, buf, buf_len);
> >  
> > -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > +	seq_buf_printf(&s, "initialized=%d;enforcing=%d;checkreqprot=%d;",
> > +		       selinux_initialized(), enforcing_enabled(),
> > +		       checkreqprot_get());
> >  
> > -	rc = strlcat(buf, "enforcing", buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	rc = strlcat(buf, "checkreqprot", buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> > -	WARN_ON(rc >= buf_len);
> > -
> > -	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
> > -		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> > -		WARN_ON(rc >= buf_len);
> > +	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
> > +		seq_buf_printf(&s, "%s=%d;", selinux_policycap_names[i],
> > +			       selinux_state.policycap[i]);
> >  
> > -		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
> > -			buf_len);
> > -		WARN_ON(rc >= buf_len);
> > -	}
> > +	WARN_ON(seq_buf_has_overflowed(&s));
> >  
> >  	return buf;
> >  }
> 
