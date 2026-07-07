Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEA395AF2
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433691; cv=none; b=ONpzvK5RCZ/DjBO8H4gEjHxyddGEftiah2aXY2r2qxxIUnzDGHLm19nV+wprCAKqqrqzkJVjyHkmKmm1Hxr4digWLEsESKgOVoM5sTX8t2hyY6wxI/xuEHJjFhiG5ix8txJwRjapXJikx8ZLeBg49V/Je9bKqa0mgLUI4DctDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433691; c=relaxed/simple;
	bh=M1sU6g+HUzK0+Dx5g9Ufug4vk3KnUX0rgOgaj20HBfY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UwnyHaxNmSHEmTLuM6WDPYInw2I31v+r6TLuQsGtOok+4lFXPZIZlGWI34HSxW9wqNHE0JoO0NLyqHAy17tyz3kgwyd9e5voi4ZeOSRLaE3uYb4VdoEqP5VVe13RKxwUuL6qBX9Ng0adqmKb9JEdIm59qFfm9akV2V/GAVBS2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CS4droEJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXsUDObN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CS4droEJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXsUDObN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CS4droEJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXsUDObN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CS4droEJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXsUDObN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F23575B84
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783433688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oWFg5Qb7c5CkrPVtqSxNEgivUsCdOlYJdff/6VV+gN8=;
	b=CS4droEJwZs5RQsELjdgmiFDh8yRQel8XTUUrZkEf1hMNGXMjBGRLue99ODwFAi2kgubvr
	SDAF6S6dkrjEFu9jyoTXs/mIdDfMiKB7g5qMJO599/nmYCi1PfglTuaPeKJzdD4nWpi7TH
	d7Okdz09ovzsgkUhe9+nM2JqMer1JQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783433688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oWFg5Qb7c5CkrPVtqSxNEgivUsCdOlYJdff/6VV+gN8=;
	b=wXsUDObNmzto3rrdBrnp0pPrrgwHeNxKe07kOPMxp8ut91I/+IkI1oHSceco2q6OqVB8VB
	WaNpKZAHQ2Zs2GAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CS4droEJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wXsUDObN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783433688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oWFg5Qb7c5CkrPVtqSxNEgivUsCdOlYJdff/6VV+gN8=;
	b=CS4droEJwZs5RQsELjdgmiFDh8yRQel8XTUUrZkEf1hMNGXMjBGRLue99ODwFAi2kgubvr
	SDAF6S6dkrjEFu9jyoTXs/mIdDfMiKB7g5qMJO599/nmYCi1PfglTuaPeKJzdD4nWpi7TH
	d7Okdz09ovzsgkUhe9+nM2JqMer1JQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783433688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oWFg5Qb7c5CkrPVtqSxNEgivUsCdOlYJdff/6VV+gN8=;
	b=wXsUDObNmzto3rrdBrnp0pPrrgwHeNxKe07kOPMxp8ut91I/+IkI1oHSceco2q6OqVB8VB
	WaNpKZAHQ2Zs2GAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A574779AE
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 14:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YnoXBdgJTWqCWwAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 14:14:48 +0000
Date: Tue, 7 Jul 2026 16:14:42 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
Message-ID: <ak0J0hw9jz0txZn8@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c1REVQ0WcNJBgecE"
Content-Disposition: inline
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F23575B84
X-Spam-Score: -6.61


--c1REVQ0WcNJBgecE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This key can be downloaded from
https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xee166bcead56e034bfb33add7bf729d5e7c81fa0

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 SECURITY.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index 2a7ce5b3..4cc17f53 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -40,6 +40,8 @@ the issue as quickly as possible and shorten the disclosure window.
 * Steve Lawrence, slawrence@tresys.com
 * William Roberts, bill.c.roberts@gmail.com
 * Ondrej Mosnacek, omosnace@redhat.com
+* Johannes Segitz, jsegitz@suse.de
+  *  (GPG fingerprint) 250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66

 ### Resolving Sensitive Security Issues

--
2.54.0

--c1REVQ0WcNJBgecE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpNCdIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mfRQP/2AQJ/PqF1K+iRF7KTYy
mY4sgPUr8/WAs3+9025tEi8zcvmX+Zs/VgKmJPQ/txax6rLvbHycXG667jYMFSRx
jB4e7zkaN3jo5lF2Y1xeylyN8h7tFPi8AE+9GFZbeuhCxCLSdX8cwPcPhT1cnYGY
nvXdjDA6GaAwpYxt+WJ/e+4OPiwpOc18RrWCJ1olZX7tmqJ6PwMGxrgNQFB3azA/
8ukpobKz6PBOc5qYfZNc8WaykiJTaeDhHIXR2xX4i5RjPwuVYYlXkUB71+4yDoca
065CK6xbQRPEG8wTSa+HBe3NKnB28EraUDch26Kfj4M+d3x9m6wDeYTRDRmuacA1
Fo0c00WDqWN8GQZlg6S5HjadGqG3cxt6NgwSoeFkC90krEe6aUYYmuIJ+y/bADnP
2ANvai4s0sr1YhVfDX+9at9Pp1mmTXEVbbI2yB5FJ7zxfLNHPAq8u1OGlma5Vhc0
4lVRE/IW61txgNoG/4aNLVkA+S8eEKO/Kji8Pj2CzYRf0EZU042cdNlBbuJom4rh
NWkvbLJGVswigNca+kYKlSyVSrrZzIufq8WQMnRijCP8UzlvURr6VzbHA5TMv/At
GAREzOlCJDqUWdZukBHtV9dpGp5jg9+fXY1XUPgv6xAtFHrZu2ucz7CxO9QIzrOr
1jJfEhCBdJj9VWtpDzrHoSF+
=/Hx6
-----END PGP SIGNATURE-----

--c1REVQ0WcNJBgecE--
