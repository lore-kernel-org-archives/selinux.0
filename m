Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A343441E
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618280; cv=none; b=c9jcp8bvYnRtS0hfDr6XhC542F75b0BmH3F16Z6tkROT9oONiNoKSF552JzAqZtlxHosgsjZ8sMO6Kx8A7ynAsqpqwDzYLAU/nPWUakix17nGRmC36etRtivqIJzB7ghG61EEAtjCLk7IUHTXwUY2IPKYDvinZD+6zANgSc2Frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618280; c=relaxed/simple;
	bh=ZC7NcYmkQK7YMQgiXOlMITKO7uPm2Np08hdrm5eVFmI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N4J07mkQLNnhIx3ko32Bef12IlaRL9l5OPIYQzUM+xtEoC5rPFOlpOP3voKXT+CTVECvv5JDtscyvu/e0EjKIvYGMdvVG9cawJ4994T3sRJNF690R18GrKxKQPelx9dbEC80yXZVri6VptD26YrKjm2TKuk1T1eZSkkL2BxQniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1qpx4a7+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3wY+Jv7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1qpx4a7+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3wY+Jv7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1qpx4a7+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3wY+Jv7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1qpx4a7+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3wY+Jv7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D9263E37
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784618276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=n2JJfr0tKX5v5eW9cX3rQfi0SDefSwLxnZhYOnELJ/w=;
	b=1qpx4a7+CHvQCU1G09l23xMRWjzG4rfOXa7+LPByX32WFMguxLpTrB057Q2mTSYQVPIbka
	N2upBNYW1oOseRRm4kyKIWXmXZnZO1CzQfcA8X1urD7Mligl9BCGiTZIMbMtVvrEGo63Dd
	hpP4j1ik2+0Ol6jIzUSjW9sWnLGskFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784618276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=n2JJfr0tKX5v5eW9cX3rQfi0SDefSwLxnZhYOnELJ/w=;
	b=H3wY+Jv75E5l/4aCBLNlUe2sgwi4h1evVIXF/M1rII7pB3cv6bkQe8PHebZZm16qwwxNU/
	CylhuYCF1xEBOhAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784618276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=n2JJfr0tKX5v5eW9cX3rQfi0SDefSwLxnZhYOnELJ/w=;
	b=1qpx4a7+CHvQCU1G09l23xMRWjzG4rfOXa7+LPByX32WFMguxLpTrB057Q2mTSYQVPIbka
	N2upBNYW1oOseRRm4kyKIWXmXZnZO1CzQfcA8X1urD7Mligl9BCGiTZIMbMtVvrEGo63Dd
	hpP4j1ik2+0Ol6jIzUSjW9sWnLGskFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784618276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=n2JJfr0tKX5v5eW9cX3rQfi0SDefSwLxnZhYOnELJ/w=;
	b=H3wY+Jv75E5l/4aCBLNlUe2sgwi4h1evVIXF/M1rII7pB3cv6bkQe8PHebZZm16qwwxNU/
	CylhuYCF1xEBOhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29956779AA
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NavTCCQdX2pMFAAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:17:56 +0000
Date: Tue, 21 Jul 2026 09:17:54 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux_restorecon: Do not exit on directory cycles
Message-ID: <al8dIlPQqf4eHINW@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFmEVop9rhr4+ied"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Score: -6.40


--CFmEVop9rhr4+ied
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All other failures are handled gracefully. Directory cycles can e.g.
happen on BTRFS filesystems with subvolumes. Skip them and continue
instead of exiting

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/src/selinux_restorecon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 7ef2d45d..33d315a2 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -883,13 +883,12 @@ loop_body:

                switch (ftsent->fts_info) {
                case FTS_DC:
-                       selinux_log(SELINUX_ERROR,
+                       selinux_log(SELINUX_WARNING,
                                    "Directory cycle on %s.\n",
                                    ftsent->fts_path);
                        errno = ELOOP;
-                       state->error = -1;
-                       state->abort = true;
-                       goto finish;
+                       fts_set(fts, ftsent, FTS_SKIP);
+                       continue;
                case FTS_DP:
                        continue;
                case FTS_DNR:
--
2.55.0

--CFmEVop9rhr4+ied
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpfHSIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mvg8P/R4cWcd12HK+Apvi+fXI
Q6b1GFWJD2wuhyXCDE2iWhlnvZJ1hTNPHPkahNASSqCzOny4oLrn0mywY5bwOH/j
PXh1hVXFHG6/6eir8TmCYNyjP8dB0HLwhVnRtnlpQnN2EpCF5WoiMvbmaVaCIRpk
Wm88lokSh5y3qhYKocp2KBXvywwPBg+cajm4ECpDm82QHYr7iLURR5xfVHsaBn4H
xciXyCuX3sRRbPWZhDzUOKTYfKjjb2T1px1SF/zd5XfJcaqPRa+ijNZI2JHIJCK0
oIJ6jnQjDnkLVuZCDz15fZFkGbRkAXiE5YKwSm1wxt06v52lgYU04eLh1UNhqAsj
QRqm7VQSWEpQrZuOSpkVl9XR8vju2gBgxT0q8mpHD9obB+yM+zj3Rk56aEei27/R
C0w1ZBYTdzxPrVp6daDt6tLlGUgkwrzAvPNuuZN3BgoeN5ZGoj/fTIPWnKvnYHS4
pkCx7BF+n5J/GaK4rj9NM3If0h1wzo/X2v9zDY4ZNcxtKG27yEugSONpSBRnYLu0
5EX6ODgmcr+cg1So6/vFTs26MToVQZgQgu6BvlXTqgz3gtIz/t7ZB4oKUm6s5Zw5
tIjdvpaaVuvE7AKqnp46IutEqNC3FNt+PrlcY7awZA3VbDSXBWyFY2HWPYe9uX34
s5trLG4ZpJ5htvmWXH6YK1nQ
=ULU2
-----END PGP SIGNATURE-----

--CFmEVop9rhr4+ied--
