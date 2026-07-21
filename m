Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74DE4302FF
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618605; cv=none; b=atcBh+ynduPJbHzmRGwbBggWNg0cDWV6KxZeEOgW2+hEQ3iuHJnqSny/gZsHOuHZggrjnagdp8iKLX3COmEqHqiyJaiNx6BQp6Q1cDrFAVj98rhJx3xVrN1EijY/x8EzUubT5DQy6QeTkn8CCe5wrPsTn6/8+XGY1nwHQUFsQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618605; c=relaxed/simple;
	bh=ir1RPBBYEQRgKXEwIFzjITZ7Cllwfaz4/emC/4oRwvs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZdnTiaw0s/s0u2m8sP6Fpmjvfu6qZji2P4BRkEBowkhgAtjs1D5cuRLiyvI1+ybeFiCd03KnCrxlv8CX8bv+7CeLX7dt5S4ulRxT1Hc4P31bCX2ls86k4QBjQwatE7pPkT76GLbzceEY3tsnNDqSy15na0SO9KvedX8WMQjhfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V81Mx9eF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNvKv+am; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V81Mx9eF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNvKv+am; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V81Mx9eF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNvKv+am";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V81Mx9eF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNvKv+am"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1703D7A464
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784618600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ir1RPBBYEQRgKXEwIFzjITZ7Cllwfaz4/emC/4oRwvs=;
	b=V81Mx9eF4NmsyqvBgisu+1Tm+B/x9/L1+5M56s4hwc5T2fIPDX+uyktZWJuRYmtEDhcsZo
	ErtRkZlOtGDBah9tdm8dVDKZLoFRgPO7xoTkBMh4VXCvFQ+wQ4tJcyrXclh3NLsvS45oJ7
	pUjFqJnAs4hXZxGhduqrECfCtfBnSbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784618600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ir1RPBBYEQRgKXEwIFzjITZ7Cllwfaz4/emC/4oRwvs=;
	b=PNvKv+amuRvhh6HNIYGmeUBCfyVMsT/BmTrPccn1YwWuq+h8WpUoo+JpzUqSTIeh3UCzp0
	+9BOc3Db4qvNUQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784618600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ir1RPBBYEQRgKXEwIFzjITZ7Cllwfaz4/emC/4oRwvs=;
	b=V81Mx9eF4NmsyqvBgisu+1Tm+B/x9/L1+5M56s4hwc5T2fIPDX+uyktZWJuRYmtEDhcsZo
	ErtRkZlOtGDBah9tdm8dVDKZLoFRgPO7xoTkBMh4VXCvFQ+wQ4tJcyrXclh3NLsvS45oJ7
	pUjFqJnAs4hXZxGhduqrECfCtfBnSbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784618600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ir1RPBBYEQRgKXEwIFzjITZ7Cllwfaz4/emC/4oRwvs=;
	b=PNvKv+amuRvhh6HNIYGmeUBCfyVMsT/BmTrPccn1YwWuq+h8WpUoo+JpzUqSTIeh3UCzp0
	+9BOc3Db4qvNUQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3A72779AA
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEcvOmceX2pOGQAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 07:23:19 +0000
Date: Tue, 21 Jul 2026 09:23:14 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux(8): note on conflicting configurations
Message-ID: <al8eYnGraP-hoCCm@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g44LhI1Z+n8Snoxm"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.38 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -6.38


--g44LhI1Z+n8Snoxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

setting SELINUX=disabled while having selinux=1
results in a non-booting system. Document this
here in a note

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/man/man8/selinux.8 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 5842150b..17df2a99 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -50,6 +50,15 @@ regardless of what is set in the
 .I /etc/selinux/config
 file.

+.B NOTE:
+When setting a conflicting configuration like
+.B SELINUX=disabled
+in
+.I /etc/selinux/config
+while having
+.B selinux=1
+on the kernel boot options will result in a non-bootable system.
+
 The
 .I /etc/selinux/config
 configuration file also controls what policy
--
2.55.0

--g44LhI1Z+n8Snoxm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpfHmIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mUuMP/30wNgq2QrTE92+prY4n
tcKGqn/EiDYd/sqerQ4NCmqKPfb7Ly57rWG9xO206fxuzhnYF6UlyHZyoj6evTGD
U19ccV6+Nps+YlWe+5UWxYibyy3/7FtFODyNTCl9Bfc1PzDJAWa2vxJvOHR9obcP
iNYwFlN7BuauYEJsX5ZPVvhe3OvROcWoHvLM52kAtxqOlT/hqgBKQ77DfeDyL7Ma
hDx+i2SA9r3olRqsxJZ3n7rQP2yt+ABCFa3/qNmrC9YB01d60UIzDaaLk+RQDqG3
9XlVU6k1dzIKzpidHbBS66QtQ3cfuD2uyQgz6aqwEOjs9XwZyaqQqzKAFdUqRVPu
WTU4U8l2sLSC5FL4OYE8KhskEkeQ001AOpoVvhPVurUmZk+zXwJm8MlDxWT5nucv
6/8d8T9MvjEzkBcygfgIS7YfhQicfJ9WuNyRLQnWOPTfpGkCd9V+czpO793uiU7l
iiFToKHW6qx2Ap8Y6e3VSCfIqzJ6F+F4uLpIBnlruHpCOXgIsUKIKEIYnTX/bQ+U
DLfyfp7EBbzzulDKz1tff/o4FW5mb/TmMOUxh5UOQGOW60c17y1eZ0oZV1FA+jKU
BnTgD+HoRSw9g9eKQC9nfEzOfa4BwaGRQx+HivYDqsrDDZzLIFTG/Bnkg7iU/uOB
ts0xKi++6hwAyTaH5Qh45Grs
=ApLp
-----END PGP SIGNATURE-----

--g44LhI1Z+n8Snoxm--
