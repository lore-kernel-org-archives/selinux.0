Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD02401A21
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371982; cv=none; b=buJX9ZECOkWSWN8or/OcVJbzg8oYfq+SpHXr1IuXjvZJLjqWgm9VssD6DpZriJpLmJfwSPM5X0G+Evfmcy88Uiup9pL7+XchhvtdbFmtwAfrRrPZ3mUbfctmxvHQCHpQyCzxSuvs+guRTTU9NabU0Z9EJ7B5CyIV4eS18jN8Zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371982; c=relaxed/simple;
	bh=HuMgLxKxoSt+qp7C94ikOA+zZYRkp7Gdi4aEQNJnmf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK4Ibq14ARn2EB9cYLYOAmDmgt/Ye4E1a81PQQzhCfp5gmyNJh7a2cjJNSzqo16UwJkFKT7QtAF+3LJv/DTNIqvMATs+suFYDNVOkVFDJVp1zCR9SgHX8H7KOkRn5OlTeqGQNzkmHDqZcVAhivF/FNqn6yz2JX9uUnh3HVHLGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPoQpYYb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3IRDB6P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jj2Lzp3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3oydmxh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPoQpYYb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3IRDB6P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jj2Lzp3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3oydmxh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DF301F84A;
	Mon, 14 Sep 2026 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789371974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4Nmn9o776zf4KZxF/pwevUhzOvOEdTIRU4UHF65IY=;
	b=cPoQpYYbYSgFvoKWtpSXKiue9klzRPlEaO/Wv5zvknKZ0+1MaOtP2pVh1xaEaacy8JmpNK
	vroOpWm8MH29JrFxK8CltriRc7FVv9TNRaFJz5X/ty8oBMzT2pcIqCS0foXZCTvkXgVrl9
	3yNVKRDBRYtXkz2uG5m2wKodnXk5QPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789371974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4Nmn9o776zf4KZxF/pwevUhzOvOEdTIRU4UHF65IY=;
	b=o3IRDB6PdqJvXdC4mAPga6osZrxIUxk4t1+jvgeS4KaqfpiH9Mr9pSHRptcUaNGEt59CfV
	YxQhbC0+mOE4/5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789371970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4Nmn9o776zf4KZxF/pwevUhzOvOEdTIRU4UHF65IY=;
	b=Jj2Lzp3G35/4qMp8zfxJFiUJNXHlquXC+YC+aU2mHhDr86wC6USHE6muDn5e/731eNnNT+
	fK2wb9r2y623eK2abyVcefAOQiYETTcZHzSk2IqKOYRnZBIOp/LXe6UIuH9w1HL08EYG4B
	3qsxirVN5k6xPjVUGXJ9//lpOchFw+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789371970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4Nmn9o776zf4KZxF/pwevUhzOvOEdTIRU4UHF65IY=;
	b=w3oydmxhJhQphg5t22ijOMhPVkD7sBjj6dPG4L1HXpqPaTzUdtZaVuJSZLNUuDs31iXKcC
	3KHOZNa/Zu1QxYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D23136A1;
	Mon, 14 Sep 2026 07:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jfa4CEKmp2qqZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 07:46:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A30D6A079B; Mon, 14 Sep 2026 09:46:05 +0200 (CEST)
Date: Mon, 14 Sep 2026 09:46:05 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jan Kara <jack@suse.cz>, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnacek@gmail.com, ljs@kernel.org, jannh@google.com, cgzones@googlemail.com, 
	brauner@kernel.org
Subject: Re: [PATCH v2] selinux: reject writable opens of status file, drop
 mmap write checks
Message-ID: <5cibrfvazvri57fwmyja6yn2av7rhwmkahhtt5c3pkvmdqi3dr@xsgh3rk3nurw>
References: <20260911145840.19039-2-stephen.smalley.work@gmail.com>
 <vacb35v2k5omae7ad5hcvtnzkciib4zcdb2kbokgd5gt377vc4@mdqmy6namwrn>
 <CAEjxPJ7nfLR2jp6DQkvxhGcNFD+=tUWvniU_MWqnBfPGUw58PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7nfLR2jp6DQkvxhGcNFD+=tUWvniU_MWqnBfPGUw58PA@mail.gmail.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,paul-moore.com,gmail.com,kernel.org,google.com,googlemail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

On Fri 11-09-26 12:14:55, Stephen Smalley wrote:
> On Fri, Sep 11, 2026 at 11:23 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 11-09-26 10:58:41, Stephen Smalley wrote:
> > > Similar to what
> > > https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the
> > > policy file, update the .open handler for the status file to reject
> > > writable opens, and update the .mmap handler to stop clearing
> > > VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
> > > truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
> > > left to another patch.
> > >
> > > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > > cc: ljs@kernel.org
> > > cc: jannh@google.com
> > > cc: jack@suse.cz
> > > cc: cgzones@googlemail.com
> > > cc: brauner@kernel.org
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Hum, so rather than having special checks in ->open, why don't you set
> > S_IMMUTABLE bit for the inodes which you really don't want anybody to
> > modify? That will block both writeable opens as well as truncate...
> 
> Great idea. I will do that in v3, drop the .open checking, but still
> remove the .mmap checking that will then be obsoleted, unless someone
> objects?

That sounds good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
