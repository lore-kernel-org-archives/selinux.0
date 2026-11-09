Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241807;
	b=2CANTedveGOUeoeY8ubFLCLRX3n+h+GhJYt5m/0cmhAQJI65x8I8lionQMAH4wQRk5XG
	 B9DKsmBF1hwLvPzucqzGMwHEw03kwvYyEh3Xe1GQBD9QHwD8+R4tXmJG/5or550HmDtxL
	 3JODSlsEsDXMxGraNUc98ZJrZwRsYPQ3CJpqH/0/RnTg8lS5mJjUVpLHHrBR0Aib6wOr+
	 BdXsk/BE11vJLu6dDSFR2x2LCJsXs1Anw3DYw4qtV+I981BvDo/RlTSsuwmTelzJZuiPJ
	 6WHhhQbqmAz1ejZxP8j2zUIm+DXlA6sNn1hniQiweqIls7U+kd390DxwSbra9mF1k7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241807;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=P2qplvC3kS2fEEIPMPoceudRbt/LQRbAsuu1FOczDvo=;
	b=tBgE7OqJ5lPX1oas+0e6k5QGx40f0wZRRWLy8hKn/7J7oMmiVdV33069HIG7aSDzy8/s
	 sCxKMnAcPe+Qxm2EYc4GMZgjV7HWKip42XYLWVwdn3D2fa7pTIGT2eJ4QLyYs5Xs/rDs3
	 u92jvk9dBCuxHyc7q7zceSLktNqSHy4X6qoHBWmk/QynNNIS3mD82uhf7J9eC+B7DP68n
	 IJRlC+9f7WiLrOoekvot1cWeNYyobARre9JMI5uR+698KiT65umwGDwZV01UfUdc8d8Uz
	 wCraLkSfO+bAk6l9mDMeyV49mdKcvSUz0VZZAQpid4pHd/sLjHk8RWeItlrLKfZTR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nzu5tXaT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="h6IdC3/6";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZeVIfpRP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="rGQ5l/k5";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC65606EE95
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC65606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nzu5tXaT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h6IdC3/6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZeVIfpRP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rGQ5l/k5
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFF262209B;
	Mon,  9 Nov 2026 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794241804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2qplvC3kS2fEEIPMPoceudRbt/LQRbAsuu1FOczDvo=;
	b=nzu5tXaT1bNh13rK1gvD4YRtn68quuTD0s0eeKajao4MIALe+DG89kBbtbfnEnSSjUtahY
	cjUVLcnNG00ubiLRcyz9qORZy9dwnP1qyDsbflmjbblCuYoommAmz3DV81Afo0tL2X3/f9
	lifMxWONW6rJgSMrR0yNQGWj8MFSH/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794241804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2qplvC3kS2fEEIPMPoceudRbt/LQRbAsuu1FOczDvo=;
	b=h6IdC3/6wVOFYLFfY+ce1f1iS02YanAUTrSLdTRcwzLWl3hOsT9rVn0dzZlw9MhgGzpQru
	L80/+e8rcNSZVqCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZeVIfpRP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="rGQ5l/k5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794241803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2qplvC3kS2fEEIPMPoceudRbt/LQRbAsuu1FOczDvo=;
	b=ZeVIfpRPmVUKbZSuYe8GY9dwrXKblPqNbpgtgoU7xC9PkiJReoPjmhZrtF9Qnk+N81tmcx
	PGRqsBarN+8dyKJ664Tpu9Y5NTY5BnfGV06yBL2RIl1uIL7nej+l+A5AcI6H4+yUT4OCxh
	tp9Ci7rsjrOuTrIyvABARYEHZM6jmYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794241803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2qplvC3kS2fEEIPMPoceudRbt/LQRbAsuu1FOczDvo=;
	b=rGQ5l/k5mbVZ7FpghCjM3RpNZFTZ8/1Cp0FpZTW2R9/pmYCWiypIcZa98cCFrll05qjC2Z
	t4CU/aSwIdNkjxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B0B13319;
	Mon,  9 Nov 2026 16:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CoREDgv18WpCagAAD6G6ig
	(envelope-from <fbonazzi@suse.de>); Mon, 09 Nov 2026 16:30:03 +0000
Date: Mon, 9 Nov 2026 17:29:57 +0100
From: Filippo Bonazzi <fbonazzi@suse.de>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, plautrba@redhat.com, 
	omosnacek@gmail.com, jason@perfinion.com, jwcart2@gmail.com, tweek@google.com, 
	selinux@suse.de
Subject: Re: [PATCH] libselinux: apply requested level to failsafe contexts
Message-ID: <avH0IcYBB4c5TWuy@suse.com>
Mail-Followup-To: selinux@vger.kernel.org, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, tweek@google.com, selinux@suse.de
References: <20261106181033.252493-1-stephen.smalley.work@gmail.com>
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
	protocol="application/pgp-signature"; boundary="5edbsjx4q6jgwlkt"
Content-Disposition: inline
In-Reply-To: <20261106181033.252493-1-stephen.smalley.work@gmail.com>
User-Agent: NeoMutt/20260406
X-Rspamd-Queue-Id: DFF262209B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-14.11 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,perfinion.com,google.com,suse.de];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -14.11


--5edbsjx4q6jgwlkt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] libselinux: apply requested level to failsafe contexts
MIME-Version: 1.0

On 2026-11-06 13:10 (UTC -0500), Stephen Smalley wrote:
>The level-aware context lookup APIs replace the range in the starting
>context, which get_context_user() then copies into matching
>candidates. When no candidate survives, get_failsafe_context() instead
>returns the configured failsafe range unchanged. A NULL starting
>context also hits this path when the current role and type have no
>matching entry.
>
>Carry the explicitly requested level through an internal list lookup
>and apply it to the failsafe context before
>security_check_context(). Keep the configured range for ordinary
>lookups and preserve the existing ENOENT validation exception. Route
>role-and-level lookup through the same level-aware list implementation
>so it receives the fix too.
>
>Add 309 regression cases covering all three APIs, explicit and current
>starting contexts, per-user/global/missing configuration, rejected
>candidates, validation of the final range, and failure/retry at the
>new allocation steps. The test uses private configuration files and
>wraps getcon and kernel validation; no host policy is changed.
>
>Reported-by: Filippo Bonazzi <fbonazzi@suse.de>
>Fixes: https://github.com/SELinuxProject/selinux/issues/508
>Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>---
> libselinux/src/get_context_list.c     |  84 +++++-----
> libselinux/tests/.gitignore           |   1 +
> libselinux/tests/Makefile             |   7 +
> libselinux/tests/test_context_level.c | 221 ++++++++++++++++++++++++++
> 4 files changed, 273 insertions(+), 40 deletions(-)

Hi, I can confirm that this fixes the issue we originally reported on openS=
USE
Tumbleweed. Thank you very much for the fix, and please keep me in the loop=
 when
this will be published in a proper release.

Thanks,

Filippo

--=20
Filippo Bonazzi
Security Engineer                        suse.com
8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9

--5edbsjx4q6jgwlkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEgldDmJR6Lb7yHXbmk3pj8Fs2RtkFAmrx9QUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEJN6Y/BbNkbZacsH/3igXtOIJumGCNnSHK60
+r0ZQKixMsKPS6E4PzUq13RLO6hZd3soVKpumTAsirSe+H7zoc1xE44zpF0DP6zw
bNKbQEuxQ9sz2Ni+O45ftiBXXPMsUASIGxQHk8dA8VW2z4Q612SxNKp0PsDpDRN6
ByoUpwPRwbh7XOJGzFXRWbHH6xKB+S5NNOIh6IV5iKziU5cpmsa0WECnhm6buTAf
o8fqWFDp1pAlFqBWL1P5Bhz1TC8zMrNmn5yXupznxY9pH+9tijOu86ww/OT1fv4l
RyBTyu3F6WgzUKyehiTRBPW1RqFvOheI/hs3LV5lKp9OG/+mbKegnF50tu2QC26z
pKw=
=D5GY
-----END PGP SIGNATURE-----

--5edbsjx4q6jgwlkt--
