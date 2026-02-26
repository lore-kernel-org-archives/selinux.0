Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A73D646D
	for <selinux@vger.kernel.org>; Thu, 26 Feb 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115550; cv=none; b=nhC423zy/9KA5jhOoAY3lNNRf5f0UEvwxbq/OmFaPDhKsmx0pAGxrctwWLv7xeSaBfkx8tJOeO5//xog9fD5Ip1NPuFac0CG8bsNSF63f/Ayk+HXM8Szh+DZPpibKL1FeKVF8eBaM94y5ohdPDJZaK9BtjK8GGRm4yUksvCD75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115550; c=relaxed/simple;
	bh=odV80GJtq0mUHGhjvkQKoV2oxNxteHCidYJb/iPhJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNTcww0wlXpOMHKT4Bex0qsUNUDNBPS48/cjVmkjhYUUJggQ/n4uJDR21vBKZvPPRXROoTrgrpWxln8ZQYezimx9fqlV6Ruwm3Ns3A300MKAuM0DsJGvouZgmAOjPvy3NT/XAK/o4AfjqeYOLr/wNLuUU6EVfupSbjbK+NQnYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhHyLkXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZklsiWW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhHyLkXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZklsiWW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhHyLkXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZklsiWW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhHyLkXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZklsiWW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3ABE83F8B5;
	Thu, 26 Feb 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=lhHyLkXXlPnfPXiAdePNd0Lm4Ih3UW3RjPqXrj5XXn5HEFae1GsVqGRnITccjsr4fOZmF4
	j0Ht/6Vp2o/tWQ7Fg1st+YXTqVT7Z1vD0M7NYPH5p5V9XlPgZ8Rq3c556sgGyMr1x8EWXd
	W8Iu7X2N+vm1trLnxZjLm+jPYe1hMAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=wZklsiWWmnIkI/vz0pwmLKflEayo9HqbOPbxcGRS9pasbZQoPwx4KokCWOo7KksLO7GyEj
	jwrBEETJEFiU/DDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=lhHyLkXXlPnfPXiAdePNd0Lm4Ih3UW3RjPqXrj5XXn5HEFae1GsVqGRnITccjsr4fOZmF4
	j0Ht/6Vp2o/tWQ7Fg1st+YXTqVT7Z1vD0M7NYPH5p5V9XlPgZ8Rq3c556sgGyMr1x8EWXd
	W8Iu7X2N+vm1trLnxZjLm+jPYe1hMAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=wZklsiWWmnIkI/vz0pwmLKflEayo9HqbOPbxcGRS9pasbZQoPwx4KokCWOo7KksLO7GyEj
	jwrBEETJEFiU/DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304A93EA62;
	Thu, 26 Feb 2026 14:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KqTDC1pWoGnpEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 14:19:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5C9BA0A27; Thu, 26 Feb 2026 15:19:05 +0100 (CET)
Date: Thu, 26 Feb 2026 15:19:05 +0100
From: Jan Kara <jack@suse.cz>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
Message-ID: <hein42plwi3lhonfdvox7a267ycy3o6677ciofirpfy6vh6atz@xkltgcdlncpg>
References: <20260216150625.793013-1-omosnace@redhat.com>
 <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Tue 17-02-26 12:09:34, Jan Kara wrote:
> On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> > Restructure some of the validity and security checks in
> > fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> > denials in the audit log where hey shouldn't be.
> > 
> > Ondrej Mosnacek (2):
> >   fanotify: avoid/silence premature LSM capability checks
> >   fanotify: call fanotify_events_supported() before path_permission()
> >     and security_path_notify()
> > 
> >  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> The series looks good to me as well. Thanks! I'll commit the series to my
> tree once the merge window closes and fixup the comment formatting on
> commit. No need to resend.

Pushed the series to my tree now.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
