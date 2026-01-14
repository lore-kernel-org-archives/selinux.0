Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAC39C640
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404780; cv=none; b=aFj7Tc2Jm3skqfCXMjrOh3CYZDcvcsgwaI/rZ1mtPjtpec360ro+MopXRPX5SPhe8gyz5j3CU4q2b2XMfAAR6nKGZvBsuSUoV5KrWMKnoxPWVVs2VbHl/bq0cxSsAhmRosGr5dC+Bx0f64U2QgJgvWIj5R9y4OyuRF5IZzSI7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404780; c=relaxed/simple;
	bh=7hd0s3Nq/EA/IWehh64W9qPgm07ENnnFVDxB0dwtRdA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBf3GFEE0O9O5nJhExpVCRhCVZSxLDReGD1kLDw4XkDnUX52KmO29dDI8Qb9NACHhq/w0NTlnOQNfl9aNB9a5vizF1UUpm00p3phfyntC6qBFIfJonuq40cNwUlbMQ3QVxmfZ7CHe+6YHF3IVfPErWVkHXzoHF0eZ1FagCk51mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T6KzyV+d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EiHP9wUq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T6KzyV+d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EiHP9wUq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T6KzyV+d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EiHP9wUq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T6KzyV+d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EiHP9wUq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E14295CBEA
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768404776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HOVIgQnexzdGk/G+ySfsKJZHiQ45W9igScaPbY9mO44=;
	b=T6KzyV+dkLAARZm4nuaWF2a6kfIv18lM7nOZ63ztLWXLqQHfvqYgIxhV8JEFPGjm23tacm
	/AuZkMKl8xrnA2DbhWF2rXkgWGk1AI/8JmTMI9oq1pOlemSHZ8awB5v9NOE21I9XqKblrH
	TESH4nEj/jHT2CcrwrSif8D+fj9GpjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768404776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HOVIgQnexzdGk/G+ySfsKJZHiQ45W9igScaPbY9mO44=;
	b=EiHP9wUqVO40ADQJU20So+EtOu9YW+mTxnxOkgKnQEVDPM0eBdO0bfX4FXGRBaYGEvGiCX
	OGpgRs44Ankku1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768404776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HOVIgQnexzdGk/G+ySfsKJZHiQ45W9igScaPbY9mO44=;
	b=T6KzyV+dkLAARZm4nuaWF2a6kfIv18lM7nOZ63ztLWXLqQHfvqYgIxhV8JEFPGjm23tacm
	/AuZkMKl8xrnA2DbhWF2rXkgWGk1AI/8JmTMI9oq1pOlemSHZ8awB5v9NOE21I9XqKblrH
	TESH4nEj/jHT2CcrwrSif8D+fj9GpjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768404776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HOVIgQnexzdGk/G+ySfsKJZHiQ45W9igScaPbY9mO44=;
	b=EiHP9wUqVO40ADQJU20So+EtOu9YW+mTxnxOkgKnQEVDPM0eBdO0bfX4FXGRBaYGEvGiCX
	OGpgRs44Ankku1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEA9B3EA63
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 15:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sollMSi3Z2nODwAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 15:32:56 +0000
Date: Wed, 14 Jan 2026 16:32:55 +0100
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] Ignore files that vanish during relabeling if ignore_noent
 is set
Message-ID: <aWe3J9UVT9WIBiuF@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t/fGLQBw1Ql0a9q8"
Content-Disposition: inline
X-Spamd-Result: default: False [-6.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -6.40
X-Spam-Level: 


--t/fGLQBw1Ql0a9q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This happens e.g. when temporary files vanish during labeling the file
system. I don't like it that this is now in the err: handler, but
otherwise it would need to be repeated above a couple of times

Signed-off-by: Johannes Segitz <jsegitz@suse.com>
---
 libselinux/src/selinux_restorecon.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 7ef2d45d..6c55125c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -768,10 +768,15 @@ out1:
        freecon(newcon);
        return rc;
 err:
-       selinux_log(SELINUX_ERROR,
-                   "Could not set context for %s:  %m\n",
-                   pathname);
-       rc = -1;
+       if (flags->ignore_noent && errno == ENOENT) {
+    // Sometimes files gets deleted while the relabeling happens
+               goto out;
+       } else {
+               selinux_log(SELINUX_ERROR,
+                                       "Could not set context for %s:  %m\n",
+                                       pathname);
+               rc = -1;
+       }
        goto out1;
 }

--
2.52.0

--t/fGLQBw1Ql0a9q8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmlntycbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJELwn3Z0sxP1mI2kP/jqScWw4wE2W9fdTNJ1N
m86Vo+jNNmb6FIzy4f5bm+2zF9EqPzTdSRSZL/zu4Zti7xn5w5IvDhzrnDb5gfEO
zh3jT2HlZoKXRnrJyduwa7WMGsE3U4F8++M/uzeMwy60QLT+LHRgU23lQSsQQrS/
D0Vyr7Q9SfYaAcDAUzHELUOzEPuAvQ28WqNa6XWhl9gHrZceb2iEwSzGpLAyhMtD
sBXl3KlAkrZurMvIeWCLgpK2b12qtEYti4P/h+tOAud5mAQbatps91CKkYnS8HNm
9T7m5U1h2TehTEnVIpuQ6JZkrfpN9ocDlRlr91SgJfuf+8Iwp4+GDG4IJLscnCsn
rONSSqSbyjH50ZDF0dSJO1uIlsJ4S+/U40eQtEK7XR+3Js/u2muLDiRNTmfKVOkn
NW38x0yWeN2Hpls78KTKpHUFA15zdwia2PDGIdlY/ZshnOQnCkt+m+3ldF/anYuH
NigGxMY7aV/mWZo/9a7NygTGWlENSYl9u/DoAfA8dgtu8ikCKbhcgifcvqKVtt3P
HCaO6ImVDgyP8pYaUgFRPk7+PtQY+rtIxry6Cr7M0ufO9t8iqCmALm2rqR5LnqvH
3HqpU5S2ACXieTCA0K9QJqA1I6dgMOpVo96tljD/tCrZmIgP8SQZwzIPnCafXE1v
W4IhRRMn8qt5XGmD6SxG5qIa
=K7x+
-----END PGP SIGNATURE-----

--t/fGLQBw1Ql0a9q8--
