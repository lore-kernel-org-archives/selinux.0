Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36132F747
	for <selinux@vger.kernel.org>; Tue, 17 Feb 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326580; cv=none; b=IsB6hGZDn4o+vCLqraJRbLHCYpqMSgHoQChS92pqd6AJGVbXTXLVYJDiTVxsXF0aIbJQyUt1QN3Sm3JU7D+c/yMMPF7lhbElMoUtSYT5QpLu1MYyP1gCTiYaB5wRfciZ4faIjGcB6LIU7QpdxX+xkpP57Wya6bsG8LczvC2ZIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326580; c=relaxed/simple;
	bh=NE/5LCZzD5YpZaWhjqr+V8JtlSALaRPBoGa6uKJyxTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM32GFCZKCFaK95gN8j1lIS9hUqo33EXY0Nr6PyWgP2HMnBYoBascey9RlzabcUBwfEWWEAiccB31XTfabLJgQBLiSdtpmZAOgoJnaJPQm+QeAJby0TcaSOPp8HnhshKBsVE+QQl080eK+0KIS2Ghk0fh8eeT4uC+6S8aIFkxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/boOSMj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/jN8nR+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/boOSMj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/jN8nR+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/boOSMj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/jN8nR+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/boOSMj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/jN8nR+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30F4F5BCE6;
	Tue, 17 Feb 2026 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771326577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTcxvKkWfZyMBzgLOkORKhbu36AO8Bpt/QgZrBLtsYA=;
	b=l/boOSMj7Ev8+4RuvK5lNLKoHW2ZswakwBQ6CAUTQ6b9KlyiLtt94BayLkBv4HCGmMsU/s
	sqfHLKeTtF8tXjtjvAiJEJh8bB8speq9fsEGHy17hwEGs+icKdYnxNdNsGzDRPIFy9ktEL
	huWxuXSPkjaunOOWX/MGrwGUAg/+zR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771326577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTcxvKkWfZyMBzgLOkORKhbu36AO8Bpt/QgZrBLtsYA=;
	b=6/jN8nR+4r5WFIlsgTtZr0iAM3Rc4Q4VnTmeO7HM6NudWlO9hmUxg9cU2Hg/UNka4J0i4l
	qV8vZJSSySGQyDAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="l/boOSMj";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="6/jN8nR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771326577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTcxvKkWfZyMBzgLOkORKhbu36AO8Bpt/QgZrBLtsYA=;
	b=l/boOSMj7Ev8+4RuvK5lNLKoHW2ZswakwBQ6CAUTQ6b9KlyiLtt94BayLkBv4HCGmMsU/s
	sqfHLKeTtF8tXjtjvAiJEJh8bB8speq9fsEGHy17hwEGs+icKdYnxNdNsGzDRPIFy9ktEL
	huWxuXSPkjaunOOWX/MGrwGUAg/+zR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771326577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTcxvKkWfZyMBzgLOkORKhbu36AO8Bpt/QgZrBLtsYA=;
	b=6/jN8nR+4r5WFIlsgTtZr0iAM3Rc4Q4VnTmeO7HM6NudWlO9hmUxg9cU2Hg/UNka4J0i4l
	qV8vZJSSySGQyDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B46293EA65;
	Tue, 17 Feb 2026 11:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ItgbLHBMlGmoDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Feb 2026 11:09:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2FE24A08CF; Tue, 17 Feb 2026 12:09:34 +0100 (CET)
Date: Tue, 17 Feb 2026 12:09:34 +0100
From: Jan Kara <jack@suse.cz>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
Message-ID: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
References: <20260216150625.793013-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 30F4F5BCE6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> Restructure some of the validity and security checks in
> fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> denials in the audit log where hey shouldn't be.
> 
> Ondrej Mosnacek (2):
>   fanotify: avoid/silence premature LSM capability checks
>   fanotify: call fanotify_events_supported() before path_permission()
>     and security_path_notify()
> 
>  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
>  1 file changed, 23 insertions(+), 27 deletions(-)

The series looks good to me as well. Thanks! I'll commit the series to my
tree once the merge window closes and fixup the comment formatting on
commit. No need to resend.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
