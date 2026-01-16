Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F793659E4;
	Fri, 16 Jan 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584876; cv=none; b=WOFGlR/ejVLhTjQ0O0ls5P1lueVgZ8wjKMwCyiPynzeppWLIPErE8crw0HOQGJ3dbbHYREgncqemW1ARLm/TBm1TOx21sEH8ANYaWuFFGkOYFic+9wT0oBdUtlWaQQNnPpgSHxrZCAyGPeOdx3EtQZnr/+ZoV/CUHXeJAwOv4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584876; c=relaxed/simple;
	bh=tW+pXBbf1FaC0DdH6PTKuBemFpJhgTCV+xbHZHEoXvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+1/rGD/VSvj5OkDBEvYsWViXAgBdiqundp/Makff9DIXUimMF/TgHlk5cKUP8Fto0tTw0/z3Xv7EXb3C4J4q3gPUV8fraPgqHu6YrUKah/m6y7xqkLUNid6OCKfdmSON/nxMis79WsMxbYWKAx0OnRee3KDBJt8+W+UIPOR3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=Gkqk6P7i; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="Gkqk6P7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1768584870; bh=++L8AmxWJW5XF+3W/tPJtaaUaZ08UCxfveW0kEMxJzY=;
	h=From:Message-ID:From;
	b=Gkqk6P7i9oAWlbKwHF1iZiN66S0HPkHIt6HbExlanmWxLzbhLPNU/jrJ+IQRchfqO
	 Al3YIxXZWxY4V+KI8yjs2FBSciTBclpY6Qa0NI7vRWkjwOCzrD8fAbfJWC35pnGG5W
	 ADbzyTsFKaGUa2N0LH9Cid3Hzb1d0y7fxL3r39yI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 31529C0BEB;
	Fri, 16 Jan 2026 18:34:30 +0100 (CET)
Date: Fri, 16 Jan 2026 18:34:29 +0100
From: Willy Tarreau <w@1wt.eu>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>, security@kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Suspected off-by-one in context_struct_to_string()
Message-ID: <aWp2pZqZ1mJ2zFLN@1wt.eu>
References: <aWlLs1o5gk7k5osk@1wt.eu>
 <CAJ2a_DeFC5Z2VKXoDDkKmhcB8cft_ZtU1UtriPX292q4GRyh-A@mail.gmail.com>
 <CAEjxPJ4ct1tWUs14C7Hdj=xZBK08qJ4XMfqZ_SAAq2=icMXm5w@mail.gmail.com>
 <aWpZsLEVc0lQ5kxO@1wt.eu>
 <CAEjxPJ6xyngQaWGiih+LkJ=C7yvJYMEp7Nr92tzC+hVJy0R3PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ6xyngQaWGiih+LkJ=C7yvJYMEp7Nr92tzC+hVJy0R3PQ@mail.gmail.com>

On Fri, Jan 16, 2026 at 11:58:30AM -0500, Stephen Smalley wrote:
> On Fri, Jan 16, 2026 at 10:30 AM Willy Tarreau <w@1wt.eu> wrote:
> > But then *who* is responsible in all this chain
> > for allocating the room for the trailing zero that is being appended
> > at the end ?
> >
> > Or is this the last +1 of this block maybe ?
> >
> >      *scontext_len += strlen(sym_name(p, SYM_USERS, context->user - 1)) + 1; // ':'
> >      *scontext_len += strlen(sym_name(p, SYM_ROLES, context->role - 1)) + 1; // ':'
> >      *scontext_len += strlen(sym_name(p, SYM_TYPES, context->type - 1)) + 1; // \0 ?
> >
> > I'm asking because nothing is really clear, and if it happens to work as
> > intended, it's not super clear why.
> 
> Yes, it is that last +1.

OK so that was the trickiest to spot (comments are mine above).

> Historically, originally the MLS support was
> a Kconfig option and the entire
> mls_*() parts were compiled out altogether if MLS was disabled. In
> that situation, the context
> ended with the type name and thus counting the NUL aka '\0' byte there
> made sense. Later the MLS
> support was changed to be dynamically determined at policy load time,
> but that function still returns 0
> if MLS is disabled so the NUL byte is still counted in the type name
> length computation above.

I'm fine with this.

> Happy to split it out into its own line and move after the mls_*()
> funciton if it would be easier to read.

I think that what's mostly missing is a comment before the construction
explaining the expected output format, and another comment saying that
the +1 cover the following delimiter for the first fields, and the
trailing zero for the last one, and that mls_*() include the needeed
delimiter. That way the calculation would look like it obviously
matches expectations.

Thanks for taking the time to explain, now we're certain there's no
issue and next time we get this report again we won't doubt anymore.

Willy
