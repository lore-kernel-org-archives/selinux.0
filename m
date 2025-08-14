Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527328B7D0
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171222; cv=none; b=Oj2cs0Ib//H7n2c0XVIGpcTjHjO+aWUKrV8DJXOZWHgImh7kfHjePqJipzQZfMceNtAiM6kC81/69Dx12oLIQO/oBxU199/iuavmZO+EK4zuvUcUY9eT/XTDr0p2CMiPYicEBuT5szgqrwrENIB4nSc+pVlahWvfitgrWcdpU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171222; c=relaxed/simple;
	bh=8OGF908ntYCbQXkbjE9tmYFEhsESj7VNH5YPooOxzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiWFIDEZf85r8YnJQmbPC2vaBHd2zm4BFOJlgqj3c4bTcQPcdnATELNAC6/ZqcSaGVjsyxy4VZ536u9r837lpOHpPGcveVcIV7MTnx+O1E82YTAOaUb/6J3YyicCiZ2Q3ZntsVdrhGp6h8OGS1SrLgNpxlZR2aaYVxyGi7xN57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HO0OcpRO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMVtGJJO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HO0OcpRO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMVtGJJO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HO0OcpRO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMVtGJJO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HO0OcpRO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMVtGJJO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00B951F458;
	Thu, 14 Aug 2025 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755171219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g4IZjbsA2SbNT88FhoIMYzLgAjX+PED6nqI2Pi4TRQ=;
	b=HO0OcpRO47vE0hJ6GjfSdusf9xJl5eOFbf4ygw7dzGDmY3adH8tnNWD+scT/NEsNqzeATJ
	DcYKlD9xoqXHJZyTVruVlOSOXHbb+07kppPAir22Ajv7cEjl3SggcjznYJZ/VCDI2xcsfD
	vMxPIYBFpae2d+YNAWaIQmIEv9OgYd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755171219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g4IZjbsA2SbNT88FhoIMYzLgAjX+PED6nqI2Pi4TRQ=;
	b=QMVtGJJOQZuyQ01omg/U9gn2E8dtVdBOZKgPQYwwJopCnUul3ftKtXwgZstQYQssGF9fvJ
	1e5+SFDlANBGmjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755171219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g4IZjbsA2SbNT88FhoIMYzLgAjX+PED6nqI2Pi4TRQ=;
	b=HO0OcpRO47vE0hJ6GjfSdusf9xJl5eOFbf4ygw7dzGDmY3adH8tnNWD+scT/NEsNqzeATJ
	DcYKlD9xoqXHJZyTVruVlOSOXHbb+07kppPAir22Ajv7cEjl3SggcjznYJZ/VCDI2xcsfD
	vMxPIYBFpae2d+YNAWaIQmIEv9OgYd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755171219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2g4IZjbsA2SbNT88FhoIMYzLgAjX+PED6nqI2Pi4TRQ=;
	b=QMVtGJJOQZuyQ01omg/U9gn2E8dtVdBOZKgPQYwwJopCnUul3ftKtXwgZstQYQssGF9fvJ
	1e5+SFDlANBGmjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD018136AE;
	Thu, 14 Aug 2025 11:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RwvGNZLJnWhHRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 14 Aug 2025 11:33:38 +0000
Date: Thu, 14 Aug 2025 13:33:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove remainders of reiserfs
Message-ID: <20250814113337.GD22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250813100053.1291961-1-dsterba@suse.com>
 <aJyQcAyOrp45D84g@casper.infradead.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyQcAyOrp45D84g@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Aug 13, 2025 at 02:17:36PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 13, 2025 at 12:00:52PM +0200, David Sterba wrote:
> > +++ b/Documentation/admin-guide/laptops/laptop-mode.rst
> > @@ -61,7 +61,7 @@ Caveats
> >    Check your drive's rating, and don't wear down your drive's lifetime if you
> >    don't need to.
> >  
> > -* If you mount some of your ext3/reiserfs filesystems with the -n option, then
> > +* If you mount some of your ext3 filesystems with the -n option, then
> 
> Should this be updated to ext4?  ;-)
> 
> > @@ -587,7 +587,7 @@ Control script::
> >  					FST=$(deduce_fstype $MP)
> >  				fi
> >  				case "$FST" in
> > -					"ext3"|"reiserfs")
> > +					"ext3")
> 
> ... uh.  Maybe much more significant work is needed ;-)
> 
> > +++ b/Documentation/arch/powerpc/eeh-pci-error-recovery.rst
> > @@ -315,7 +315,6 @@ network daemons and file systems that didn't need to be disturbed.
> >     ideally, the reset should happen at or below the block layer,
> >     so that the file systems are not disturbed.
> >  
> > -   Reiserfs does not tolerate errors returned from the block device.
> >     Ext3fs seems to be tolerant, retrying reads/writes until it does
> >     succeed. Both have been only lightly tested in this scenario.
> 
> "Both" is now orphaned with the removal of ReiserFS.  And the ext3
> sentence has an implicit reference to "errors returned from the block
> device" that is now missing.  A wider change is needed here.

Yes, the ext3 mentions stand out in the documentation. I don't think it
could be changed to ext4 in all places, there's a mix of historical
references, quotes and 'scripts in documentation'.
