Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BB4749C2
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463756; cv=none; b=G7iY/P64h9wiBVMhAfYHqASZubnsEM6v+H3NqH43TREIHNzG+8vItBnpbLSIx+DxchDG2Axb+KOVcLu+UmfWmdyNBlM17s2I0V1RJsH9JtzCzYQVUxLDVtkVemXUjswuyX0dPL+4yjnxLWhYI6GwAGFPiIzS0DKwRknR7McKj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463756; c=relaxed/simple;
	bh=FHx95X8qSVZPauwcRY8d4B9LCJY3YFZuX5TPZGtPQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K22DfBBnlTPNhYGt5pMAMS6HdKEWM9eLxdGQCQPKDpN7An2XJZ2WCmfwo8gi/O4WpeL0TYzGPP+AAQATJ0g2SOV3TNG0I15nf/B3w1NsM5iqgW+8TSywizFP7qIKuXdKH6nTwfUt3rX1j7txklwaBOI2ythkLh0V7zvfcETE5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNnmPB79; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+A7fav2r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylVAH9c2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsQr+tZl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNnmPB79";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+A7fav2r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylVAH9c2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsQr+tZl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 157121FD2F;
	Tue, 15 Sep 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789463748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoKVSPsuFIZYqAHpm3BZyK5GWcnzvTTKer+B4zsmH08=;
	b=PNnmPB792gwfrW/ic7Bc4lnBVUsyngpsxzxqqFhcV/cjMSO47m9rlfXyzwYNJYzgO72fzt
	gEiKccg0mN/NfTfKX7sW18DNAiWqd3HVxO3dqK/4VHlCg9TB4bIIBN5bfr3GpvfDjNTnfC
	jishFoqPRzyFe22AExbZXKh997sip7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789463748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoKVSPsuFIZYqAHpm3BZyK5GWcnzvTTKer+B4zsmH08=;
	b=+A7fav2r8LVqxYPqp5BXzwqfve06yAKyuvEJl/hCbArBSfdqsDfooBMfH0BCB6Z/mtPD3s
	1mgXgXv9jN8iWJDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789463744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoKVSPsuFIZYqAHpm3BZyK5GWcnzvTTKer+B4zsmH08=;
	b=ylVAH9c2AUOle+m8pr06xJ2txvzWCX5TgyQJCbAZuDHS5h68uGt6s0DSFtN+SF/fUJ6AaE
	d1jKnJIDGfzhX7os1SmszyRtNXedSdLWgYW1LX7+KiFTUjgu+1htPTTjEPnz85YeVmdzY1
	6ckM9/YQ4STGBdRxkrLEhBQixqFBrys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789463744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoKVSPsuFIZYqAHpm3BZyK5GWcnzvTTKer+B4zsmH08=;
	b=wsQr+tZl3hNy3nACw2+RKWnrXiX2FrUZBjRD7wOVq5O7F6dp4WTacxz17kY8w/uYX4XvPz
	UXtRgNeWRtR7TcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E20BE13693;
	Tue, 15 Sep 2026 09:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8vZhL78MqWoLXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Sep 2026 09:15:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47BA8A13D6; Tue, 15 Sep 2026 11:15:43 +0200 (CEST)
Date: Tue, 15 Sep 2026 11:15:43 +0200
From: Jan Kara <jack@suse.cz>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, omosnacek@gmail.com, ljs@kernel.org, jannh@google.com, 
	jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Message-ID: <j4p63tm4s6ipdlphfo7u4zg7dirgp2o2wfsxvicbdxwwdkxfit@6lyk76wfnysl>
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
 <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,google.com,suse.cz,googlemail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon 14-09-26 17:17:39, Paul Moore wrote:
> On Fri, Sep 11, 2026 at 12:38 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The selinuxfs "status" and "policy" files are read-only interfaces
> > that are also mmap'd by userspace. They are created 0444 by
> > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> >
> > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > above are rejected at the VFS layer without ever reaching the file
> > operations. Since a writable file can no longer exist, do_mmap() clear
> > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > MAP_PRIVATE writable mappings become permitted (they were previously
> > -EPERM) and CoW harmlessly to a private page, matching how
> > sel_mmap_policy() has always treated the private case.
> >
> > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > reason; leave dropping it to the pending "selinux: reject writable
> > opens of policy file, drop mmap shared/write check" patch so that the
> > patches do not conflict.
> >
> > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > cc: ljs@kernel.org
> > cc: jannh@google.com
> > cc: jack@suse.cz
> > cc: cgzones@googlemail.com
> > cc: brauner@kernel.org
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v3 implements Jan's suggestion to mark the inodes immutable rather than
> > implementing open-time checks.
> >
> >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> I'm mildly concerned about marking these files as immutable when
> neither of them is actually immutable.  Yes, userspace shouldn't be
> able to write to either, but the contents of these files *do* change.
> While it doesn't look S_IMMUTABLE should currently pose any real
> problems, I do worry about the future and an innocent looking VFS
> change causing problems with one of these files because it was assumed
> the contents of a S_IMMUTABLE file wouldn't change.

S_IMMUTABLE bit is about permission checks. I have hard time imagining
some VFS code would do some assumptions regarding data based on that. But
maybe my imagination is just lacking :).

> Unless someone can promise me that would never happen, I think I would
> prefer the !FMODE_WRITE approach taken in v2.

If you feel better that way, then sure, go for it. It works as well but
you have to separately handle truncate(2). Overall I wouldn't consider this
less fragile than using S_IMMUTABLE but it's reasonably robust as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
