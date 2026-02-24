Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA13A0E99
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945148; cv=none; b=tgLM71krW7eWaYywmvM9SNq7SBUiJsTiQwkYH+Kq0gybQyVuqWiNG4jiECz/wcsk6hUletjADE7jKo5vI/4gonz5J4KUTApBxMujoPH2/R7QsStL18K+jGJgcrXS1kn8lbdTVgBUXxh8mtwIIfCgqVZ+QzoWX/AwUzLB41cvaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945148; c=relaxed/simple;
	bh=IbQr8UKhKqmHH1wbnLW0iV5cJVpNxUwmxaBBBspdtqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysb6DG1vsjEIlYlWouqFsOm4/gGJ+9ffv7HBo7SwKoavyHR/j4KwWE8jtymMMxDAra7uV6w1PiYXNIbaLBhqR/IWK1IM5Ic2SxPUghWQz4js99wcAzga9S9YoBtN6ZsfWIqB9ypuHIFRVWNipAJWW8F3YjJIN1Sy1y4z3Hhadzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NH3oTHoq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8AIfK4B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NH3oTHoq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S8AIfK4B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NH3oTHoq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8AIfK4B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NH3oTHoq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S8AIfK4B"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A377F5BCE9;
	Tue, 24 Feb 2026 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771945145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+REox0L2o6BS8Jz0OP3WDWZg8gT4PHYB4QsCQ9mQj/c=;
	b=NH3oTHoqEW3jazckapqjjQQkuzpf5Wv7Y7ZNXH0coQ56yGZSSffFMKcxZjwO5YCV8hXiHC
	5NLySYhEnoAn6Nx1Ada74wbs3i/Zr5uiloxgv7Da9+1Wy3BbJUy6htZPpnGGltqFhoAwWb
	jmFU1Rh/Obv+vnjxF+M6ncWkvSBnMYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771945145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+REox0L2o6BS8Jz0OP3WDWZg8gT4PHYB4QsCQ9mQj/c=;
	b=S8AIfK4BQ6pefqAPnwHADr58VfSdAQP9PzVKI+XgvoBe48OQZk78wqIBlK5OS5mui0CWSP
	+iqwG6yBs6OEs5BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NH3oTHoq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S8AIfK4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771945145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+REox0L2o6BS8Jz0OP3WDWZg8gT4PHYB4QsCQ9mQj/c=;
	b=NH3oTHoqEW3jazckapqjjQQkuzpf5Wv7Y7ZNXH0coQ56yGZSSffFMKcxZjwO5YCV8hXiHC
	5NLySYhEnoAn6Nx1Ada74wbs3i/Zr5uiloxgv7Da9+1Wy3BbJUy6htZPpnGGltqFhoAwWb
	jmFU1Rh/Obv+vnjxF+M6ncWkvSBnMYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771945145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+REox0L2o6BS8Jz0OP3WDWZg8gT4PHYB4QsCQ9mQj/c=;
	b=S8AIfK4BQ6pefqAPnwHADr58VfSdAQP9PzVKI+XgvoBe48OQZk78wqIBlK5OS5mui0CWSP
	+iqwG6yBs6OEs5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 832593EA68;
	Tue, 24 Feb 2026 14:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id huQHH7m8nWlWbAAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 24 Feb 2026 14:59:05 +0000
Date: Tue, 24 Feb 2026 15:59:04 +0100
From: Johannes Segitz <jsegitz@suse.de>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] Ignore files that vanish during relabeling if
 ignore_noent is set
Message-ID: <aZ28uLmUa4nn3HAa@suse.com>
References: <aWe3J9UVT9WIBiuF@suse.com>
 <f4f9d222-6d93-4fe4-a3c5-94abf58def03@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hY8i2x6UAahQQAk7"
Content-Disposition: inline
In-Reply-To: <f4f9d222-6d93-4fe4-a3c5-94abf58def03@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A377F5BCE9
X-Spam-Flag: NO
X-Spam-Score: -6.61
X-Spam-Level: 


--hY8i2x6UAahQQAk7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply, was on long term sick leave

On Wed, Jan 21, 2026 at 04:25:19PM +0100, Vit Mojzis wrote:
> does this still happen with https://github.com/SELinuxProject/selinux/com=
mit/54c79a74f5b9154762abaadf8194665598b24115
> applied?

no, doesn't happen with that, thanks

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=FCrnberg, Ge=
rmany
Gesch=E4ftsf=FChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 3=
6809, AG N=FCrnberg)

--hY8i2x6UAahQQAk7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmmdvLgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJELwn3Z0sxP1mydAP/0bCYT1KFFqmFIr9U8Yc
Dn/oMXxmwGqYsZVDMRHWLlw18VfxS2nZ+SSrZOsRqcKKx7jlf0pS77Ps8IcgtX6S
+AxonxBDEYRrie58cZS/E+v++Nc4LGiawRBPCzqoaASXxFuLCWq/VKDGSOeEjINo
D5WXxCO50vrI73mIskThvsrtvHXShkgq2gwgxpGafod/7Q8DpWslH/LLKwgGDqwx
LCERGl0D55Es7sX2XhkjD04O7y2fGDBjOrv96gUOiLu2HazX5mqA2HFulyZ6eRtj
pJIPk0Tw5QrFW+hcvY5U+UfQuJw0x53pkJOFgGGy7J7tSK14IhRMSdWiE8x/8m8D
ZBvwQjrae6G4MVj72E+8ecRABond4mjgYd5gv16MAmhBamZoGrAAr5iE8/iwZc8J
HGa+YhiAtwaX8Lfwm2mWQ41qgW6KwfqGwcalhS7OcHi34a/hrJ5NM4i0PDmxFlRg
xM1bc4FLt47DkixkQLj7Mv+gFWl3JUAiCXSQ/mb94FZrl9uDXRSzV7Lvmso3rn64
fJPsloTN0z47jZEw+6oqNbDTk1VYa5aplg9SiywTKtsT0lMkwGcd9geINWcmCX2t
CM3qWSzjB5GZsSRe+7OLFOU4KbRgIJ2GsBEI7dT3bNs9nUDU/2ZZ5HsFWv7m+EQZ
GYe8oFukvhsLqqEHfXgws3oY
=DZ9C
-----END PGP SIGNATURE-----

--hY8i2x6UAahQQAk7--
