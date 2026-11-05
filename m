Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876622;
	b=nT1ZiKCQr/1A8UWUL8vGiow9oFfSWCHmpS+xxccID1Ap78gZIxROFyJxVIjrRoPNp3we
	 2Kld7usGhaFezfi8qEkQHHfrye+v6oUPatzZO+afHpNpwqtwz3n+BSSyznY3DTLmM2exK
	 MNGq2x730mkIPRYGh2sm5779X4PmXPXOZVCfEVx6IQiY/tlLv6FdZOsKYF+Hdka7nab/8
	 Z75S2eCqMGbWzcCnBab3i9Tb5LvKs3gWuM9SJNtcXIudlBFYMLChwKRr8V03KkYsYtahh
	 4yCluK9J7oxIWKErrCj6kCCKGFAlRVYq8srrv12B6u/BXOtpuCnqlA3yNgRo+8xpApA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876622;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=7IJD50bF3eQzbqwC7/qJclfLO2PvkEwJQv9X96dl+S8=;
	b=5d6kCwbmD+TrjOuzMdra4JQ3qauMAEjOGJfzinXvD69GHLROG5yWxUNO7RSu71+/QEZm
	 51M0SdbkkJ16LhCDVMMZK/s+IilM7e5lLPXbdDubatWM/vexPCzdDtSnr8flm/xOQ/PoU
	 Z1yAURrY5zuiro6gOkqIrKmpzMA/2JUbIVmVMMPjvpZxCTuKdxfn95ZXg6NKMlNH/v9BM
	 BFe1z+KN9adaV2feXcQmhnlAfDpAzzNzv5i4Iu6yeSrAWEBXZlcIJO2KVPm31ICqvqv3O
	 3vXNlB/bNfmgWEeiF+0IqmPQBr4q7rSx4VUm75pBmx+12zk7jTyCiHdI0gVhCv2oPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EMQHFUP8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73rmq4u8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EMQHFUP8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73rmq4u8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209E606A326
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 11:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9209E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EMQHFUP8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73rmq4u8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EMQHFUP8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73rmq4u8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C89F1F387;
	Thu,  5 Nov 2026 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793876619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IJD50bF3eQzbqwC7/qJclfLO2PvkEwJQv9X96dl+S8=;
	b=EMQHFUP8YwUcU5aINW2OsTsrRk1QCvORGfnaLYCmQ7w1/2XZmuWyvyML61Lfph65iUsfpT
	RjCYwuyKg1CyYfhUjMCiW6UeT2zYQNw47qgeiduiwOqmyN5bQIRtYLk3r2N8mAtt7AAfEf
	X+KZZRBUAkMUEiUEbkmy86I8xZX0TAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793876619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IJD50bF3eQzbqwC7/qJclfLO2PvkEwJQv9X96dl+S8=;
	b=73rmq4u8vbhlYJO10NsMnv+scuofeCQrCtJEIAOE/qka5dzKxCEP+/QZlXSm++6fwGOvNk
	/Lmv8dLHpmreKRCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EMQHFUP8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=73rmq4u8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793876619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IJD50bF3eQzbqwC7/qJclfLO2PvkEwJQv9X96dl+S8=;
	b=EMQHFUP8YwUcU5aINW2OsTsrRk1QCvORGfnaLYCmQ7w1/2XZmuWyvyML61Lfph65iUsfpT
	RjCYwuyKg1CyYfhUjMCiW6UeT2zYQNw47qgeiduiwOqmyN5bQIRtYLk3r2N8mAtt7AAfEf
	X+KZZRBUAkMUEiUEbkmy86I8xZX0TAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793876619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IJD50bF3eQzbqwC7/qJclfLO2PvkEwJQv9X96dl+S8=;
	b=73rmq4u8vbhlYJO10NsMnv+scuofeCQrCtJEIAOE/qka5dzKxCEP+/QZlXSm++6fwGOvNk
	/Lmv8dLHpmreKRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27133133F6;
	Thu,  5 Nov 2026 11:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4dJINIpi7GrCTQAAD6G6ig
	(envelope-from <fbonazzi@suse.de>); Thu, 05 Nov 2026 11:03:39 +0000
Date: Thu, 5 Nov 2026 12:03:22 +0100
From: Filippo Bonazzi <fbonazzi@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, selinux@suse.de
Subject: Re: Question about libselinux *_with_level functions
Message-ID: <auxhNtTcQa-6TS35@suse.com>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, selinux@suse.de
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4xin2xm7dh4zywf4"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
User-Agent: NeoMutt/20260406
X-Spamd-Result: default: False [-15.61 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,suse.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -15.61
X-Spam-Level: 
X-Rspamd-Queue-Id: 6C89F1F387


--4xin2xm7dh4zywf4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Question about libselinux *_with_level functions
MIME-Version: 1.0

On 2026-05-27 13:46 (UTC -0400), Stephen Smalley wrote:
>I believe this is a regression introduced by the deprecation/removal
>of /sys/fs/selinux/user,
>as used by security_compute_user(), which was formerly used by
>get_ordered_context_list*().

Hi,

Just checking the state of this. Is this planned to be fixed at some point?

Thanks,

Filippo

--=20
Filippo Bonazzi
Security Engineer                        suse.com
8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9

--4xin2xm7dh4zywf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEgldDmJR6Lb7yHXbmk3pj8Fs2RtkFAmrsYnkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEJN6Y/BbNkbZfRkH/0qEk1ly/UIRJC957u6l
yfLdl6ySAj8ZbUdqjFCLv9qdZyeX7GqKBq2dHxz2NPQt5iHRB1+ubF67cZN+0Hwj
dP7dU2mHKbMyHNLp0ikJPVlTjoOfeQj1nHY7hptgFyythWTlojWFZzxkoDjlA8Ln
gw+dKdA5BZdl/pWdGRUetBHSmmGJ34kOk0M5GWDqeqnmR7w5f0MuAD2yZMtL+m9H
YdVZ+EDtsDid50MlG4daz3ZklZqkfO55uS2cPCdrFRRF1Up4IrdJ+mLXkap6zUL2
xK7Q24wraCsEGmMXkpfimlut9g6jVb5kxG7Wb5p7r4xKtzkhH+iem5vszeWyzhme
pUE=
=ZYw4
-----END PGP SIGNATURE-----

--4xin2xm7dh4zywf4--
