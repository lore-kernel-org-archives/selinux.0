Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B0306499
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938282; cv=none; b=lHswwrPZBvHxakJi4yZIfJt0PootK8mIHFc/e7wiyCkqqYyD+YllpEOXOJnOLjBoDnPFmH77U01duV8540V3IAvvi249v/pgpaiLQ9bPHHyd6s+UDK5t6lon7V11jmBN7ColiCuYTcDTpmJqsi4H/b8C4Y7ql2q3NfgqU9QH6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938282; c=relaxed/simple;
	bh=iQ5IhtZgLm+rkc5eoGm9hIH3ZDzmZomFvTPndZ9kpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbFfKlhV9vQ06jisku48NNjxcAFMvRMySihVqNgoeeujeK7hh8JOxJCUlbhKlHbt24uG0seeqYgfcSkObU8Le4BlYWQK5wxy15siwx0xcyet5pBUEHgLE4iduOSPMRSfCqOWGK39qCGAIAGQ028F+URgTYgrO/v+oKw8EOPSE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmxpPNSW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEi3LbcT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmxpPNSW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEi3LbcT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmxpPNSW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEi3LbcT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmxpPNSW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEi3LbcT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C438E1F8C3;
	Mon, 15 Sep 2025 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=hmxpPNSWXjFF1DnaMfFj7+DlM0YR/P+WlnCiH/AxdZ1GVJSjerp6IjD/Qtmt0BXrTj4+pC
	vM4NNlSRpZuDvOtR5wOJbB6Cm6LTE+CoLmBxNaDIAZQgUBz83L1afT/5cNN9hBHrE5BnKC
	p+8nI8Wm9Abe3fjt5ymtfQw0xB3OEu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=BEi3LbcTVi2SoGRRq/V+s2scC0X9YCA2Ao5RhziYUzXgIT5PCllg+OQ3aqOoLtylq0Yc0i
	zC5HJ7TAkWz33CDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757938278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=hmxpPNSWXjFF1DnaMfFj7+DlM0YR/P+WlnCiH/AxdZ1GVJSjerp6IjD/Qtmt0BXrTj4+pC
	vM4NNlSRpZuDvOtR5wOJbB6Cm6LTE+CoLmBxNaDIAZQgUBz83L1afT/5cNN9hBHrE5BnKC
	p+8nI8Wm9Abe3fjt5ymtfQw0xB3OEu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757938278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=BEi3LbcTVi2SoGRRq/V+s2scC0X9YCA2Ao5RhziYUzXgIT5PCllg+OQ3aqOoLtylq0Yc0i
	zC5HJ7TAkWz33CDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B184B1368D;
	Mon, 15 Sep 2025 12:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLNwKWYCyGg4NAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Sep 2025 12:11:18 +0000
Date: Mon, 15 Sep 2025 14:12:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH 2/2] ima_{conditionals,policy}: Handle policy required to
 be signed
Message-ID: <aMgCkNQlZ147Mm7w@yuki.lan>
References: <20250912073210.47637-1-pvorel@suse.cz>
 <20250912073210.47637-3-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912073210.47637-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
