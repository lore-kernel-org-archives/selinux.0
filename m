Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509B3E0725
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796930; cv=none; b=DSebsTsWjm1ofSpsG/haBey10kTQHHMy+zlkft0xtY08BMcwBSenaixgi6rE9M567ix/rkeDs0tx9gzJA9nK1OLMp6kuSPfxL441Pb+RAbYO05D05f2wLchJvB4JEquFYcd4QrPUm5zBNcbsjdwcHVUQXlIqLsbjBiDy6Aw6Hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796930; c=relaxed/simple;
	bh=x3UP6kq0JXKnmkCkqUbqaIk/W82IK7a739x/B2vYVKI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fofMhKChmWuNcMc0a1lZ1CWGw8t8mQ2V5lHIoGyYCcLUHj4rRKOWIRccg2zW+jRrw60YgnIhdNxfpOLUDB//EpBLByeqhRR9Nj+6OigoMVBXyowc4Qejl65hP1N0epU1k1g2PEY5DYjszJDeuy2xRDmfGP7VNCPcd3emWDXMU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKw5rRei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nFoIx6yq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKw5rRei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nFoIx6yq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKw5rRei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nFoIx6yq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKw5rRei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nFoIx6yq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9C517AFA7
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784796926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1bkGu88ULFdhmQgq/v3tqqw5w5hoUq+Kv6XdoU7kBXk=;
	b=zKw5rRei2QJbqCSVuaQfu0t384YZTrHFQMdf9Jzm/gISIMLuqeeUSeyYFxSk5hmG7H9xqt
	6yTdi8qWMjyFaAP5pLSAMUnZaq6EbtI5l2HBfDpZfzHRFRHwbd6yqhWxVTvzKzaZeJqF4E
	MYe/wSB0yPeglWSwYnorVUTxI89u068=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784796926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1bkGu88ULFdhmQgq/v3tqqw5w5hoUq+Kv6XdoU7kBXk=;
	b=nFoIx6yqsWym4CMG2PoiLFtBgYDp5tkK1aRbpVF4El3K/WKJWG1UBP5u9SSit1ma+FZ7Bp
	7fkkkDGi3eaBoeBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zKw5rRei;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nFoIx6yq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784796926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1bkGu88ULFdhmQgq/v3tqqw5w5hoUq+Kv6XdoU7kBXk=;
	b=zKw5rRei2QJbqCSVuaQfu0t384YZTrHFQMdf9Jzm/gISIMLuqeeUSeyYFxSk5hmG7H9xqt
	6yTdi8qWMjyFaAP5pLSAMUnZaq6EbtI5l2HBfDpZfzHRFRHwbd6yqhWxVTvzKzaZeJqF4E
	MYe/wSB0yPeglWSwYnorVUTxI89u068=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784796926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1bkGu88ULFdhmQgq/v3tqqw5w5hoUq+Kv6XdoU7kBXk=;
	b=nFoIx6yqsWym4CMG2PoiLFtBgYDp5tkK1aRbpVF4El3K/WKJWG1UBP5u9SSit1ma+FZ7Bp
	7fkkkDGi3eaBoeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 926A5779B5
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vqhmIv7WYWpYHgAAD6G6ig
	(envelope-from <jsegitz@suse.de>)
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:55:26 +0000
Date: Thu, 23 Jul 2026 10:55:21 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux_restorecon: Do not exit on directory cycles
Message-ID: <amHW-fFHM3pw-g3y@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2ge1TXGe/h8bouZ"
Content-Disposition: inline
X-Spam-Score: -6.61
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A9C517AFA7
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO


--y2ge1TXGe/h8bouZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All other failures are handled gracefully. Directory cycles can e.g.
happen on BTRFS filesystems with subvolumes. Skip them and continue
instead of exiting
---
 libselinux/src/selinux_restorecon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 30f1b836..fdefc92c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *arg)
                if (is_dir) {
                        if (descend && walk_is_cycle(state, ent_sb.st_dev,
                                                     ent_sb.st_ino)) {
-                               selinux_log(SELINUX_ERROR,
+                               selinux_log(SELINUX_WARNING,
                                            "Directory cycle on %s.\n",
                                            ent_path);
                                close(ent_fd);
-                               close(rd_fd);
-                               errno = ELOOP;
-                               state->error = -1;
-                               state->abort = true;
-                               goto finish;
+                               if (rd_fd >= 0)
+                                       close(rd_fd);
+                               prune_pathbuf(state);
+                               continue;
                        }

                        if (state->sfsb.f_type == SYSFS_MAGIC &&
--
2.55.0

--y2ge1TXGe/h8bouZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmph1vkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mCCgP/jrWoqZRJHCN13vpINua
OUgffskwlxNaXJEyrn34WMkQFSG4XuqX6XaLX8ubqBe0xfLdnnPCXUAhri691ILY
evRpqkqSkJOHQh+mGtuDmyyRY5CRn3oe56ud1yhnHz4yjqz2A4+Wzh1U/5wYVD5S
W8j/o6HQf0/lPhHOIA+pPO7VYV1Nz5XrccwZjM9Mxmb1TSwda6WPLVTTTeveZlxy
gEC2sk7lIuR2ZQjBQ/LOnw5m6CpekJYQNWJ7ZJAXSbaWLiTAw2z82G9HjK29nKBW
srYAmkgHTx4L6QBYbK+dG/Ip+IQ2obC1dPBUmqLYYJjQO0hAT2Eod1QQbxWG8O/N
TSKmVafO4L7nXQKTDoKbrTS5T2+9+IfQI7cXHKlnFaidAuw8Mz6SfOgsTbQTFnKc
m+oXK4dbempvwLm85W7M6soO3X6QoIpFG8ADgTfRgs91QNmFy4AKbTuV5VWnwrVB
gYuhBnsG1dFVXovCzEvbrxAVplYR372fci9nglHqkWK9DZUFD9C396k/io3q+Rn2
YQ6g4+v6BzZdJqQwz6hFRI7Fg376C7Tv8KGVjbAGZBwjJNW+pEpKFZCdqKFFhweo
7NeRjxWgpdibLV8zZd1G2/GnHAfOjrp2VtQ0ox/PNtV1fa47je+RPJbHsrmoXO5e
PosrT2mUh3gCCS+QtJn1oWNW
=+PhR
-----END PGP SIGNATURE-----

--y2ge1TXGe/h8bouZ--
