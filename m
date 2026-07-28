Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0443D564B
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221891; cv=none; b=aW6jD6qSrhyYbHPr2GV2xkHtOhnM85xyNlwV5GbHTvx5Y5oyfZbe9sDLbSFSMRLz7J3nxX/uAkRKGt1jfdp2kCIogvJEGCKRCwsr0wG1xOBkPNVaeVbq3ImXoFsDPcnu1kVpLMTmxAw+ekB7a7ksZQhiGs3gbukSBeN/jrwfOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221891; c=relaxed/simple;
	bh=w9MfclOfZo9O85pRkuqapuH6OuugcddUdO4nbElnnFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMhXWQ/MUB7n6IOi67IhOB/L5OKfxOeTKp9aBaJHwJaRvTAQokUGb+4pED9YWIVHBXakaTJnOMY5kypwtBR4BW+85HDBbajJfZVOhbfVPOqZY76++k+fLieLkQWg57dntF/d2aP2as4Ek6joR4T7Apv/QI6FpNYOEuW/VblmTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qSBi8DJG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HUEmGXE1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v3wCiTbU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t4o33obK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qSBi8DJG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUEmGXE1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v3wCiTbU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t4o33obK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DA957BEDD;
	Tue, 28 Jul 2026 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785221880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6oiGXA0YL0AMzbGBTdyDJpDzKXV7GhYlH2KeWHhwU=;
	b=qSBi8DJGz9+Tb7tsGJUZWil3XsgCWkXlgTJO7MAyQ4B1cUQ/QIVKt/9eWaGuLl9Nf8rGYe
	WAOHUBRCGRTcKgm1zAzjxo+5PpMYzU3vR5r1ONfDIVN7i+g6ZShK6Jeq1r3dt1n4gShlxd
	KKc0ctC8dD8FDKqHDT55CPPAF/7hAnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785221880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6oiGXA0YL0AMzbGBTdyDJpDzKXV7GhYlH2KeWHhwU=;
	b=HUEmGXE1kTUgMwhLP8TtVlDoD6a6LcU2OgMzgjNRs0NbX722nuePtYceHcYmB7Z/S8KURI
	8vtJZ10LqMNNd4DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v3wCiTbU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t4o33obK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785221876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6oiGXA0YL0AMzbGBTdyDJpDzKXV7GhYlH2KeWHhwU=;
	b=v3wCiTbUudrn3Sb7M5WPujVlxmN+wwagmfYX3wC2w5UPKjDMPxM7Yzgt4Ju+CXMiy/g+0p
	zbS2dW661exfM4a42gFMNS/ZPT7lObbSH/VJfksQrWfwRfiuEF484fEoBBz1xEfJrS5ZwD
	KUfPZeSRVJS62nLbHypkJDrTmdYxu6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785221876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/6oiGXA0YL0AMzbGBTdyDJpDzKXV7GhYlH2KeWHhwU=;
	b=t4o33obK34e4IiRLhEfvdNQzzz1ZN9TUPSmTRU7rX4oYKeNeqobff7qm33xIG/1fESHPs4
	7qGkSlkE3p9V0sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61B7D779B1;
	Tue, 28 Jul 2026 06:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7kB/FvRSaGqgWgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 28 Jul 2026 06:57:56 +0000
Date: Tue, 28 Jul 2026 08:57:40 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH v3] selinux_restorecon: Do not exit on directory cycles
Message-ID: <amhS5EdGrT9NBIyH@suse.com>
References: <20260727124757.787026-1-jsegitz@suse.de>
 <CAEjxPJ5GOSRAKiSi5Je0b_Us6tJrDZ8dfRhgpJLp5MjzJjYGtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4MQ8Rzmy6XrO+/WG"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ5GOSRAKiSi5Je0b_Us6tJrDZ8dfRhgpJLp5MjzJjYGtw@mail.gmail.com>
X-Spam-Score: -6.61
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7DA957BEDD
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO


--4MQ8Rzmy6XrO+/WG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 09:35:19AM -0400, Stephen Smalley wrote:
> On Mon, Jul 27, 2026 at 8:53=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> >
> > All other failures are handled gracefully. Directory cycles can e.g.
> > happen on BTRFS filesystems with subvolumes. Skip them and continue
> > instead of exiting
> >
> > Signed-off-by: Johannes Segitz <jsegitz@suse.de>
> > ---
> >  libselinux/src/selinux_restorecon.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 30f1b836..fdefc92c 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *ar=
g)
> >                 if (is_dir) {
> >                         if (descend && walk_is_cycle(state, ent_sb.st_d=
ev,
> >                                                      ent_sb.st_ino)) {
> > -                               selinux_log(SELINUX_ERROR,
> > +                               selinux_log(SELINUX_WARNING,
> >                                             "Directory cycle on %s.\n",
> >                                             ent_path);
> >                                 close(ent_fd);
> > -                               close(rd_fd);
> > -                               errno =3D ELOOP;
> > -                               state->error =3D -1;
> > -                               state->abort =3D true;
> > -                               goto finish;
> > +                               if (rd_fd >=3D 0)
> > +                                       close(rd_fd);
>=20
> As before, you don't need the if (rd_fd >=3D 0) test here because this
> is under an if (descend...)
> so it is a tautology. And i thought you were going to explicitly note
> the change in behavior via
> e.g. a man page update or similar?

yes, I might have gotten carried away that I finally beat git send-email
into submission that I sent the wrong patch ... v4 will be there in a sec,
sorry

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--4MQ8Rzmy6XrO+/WG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpoUuMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mGYIP/Rau2yh86jvo9WcR+9rZ
rIugNFN5toPz2aTQmrayRtpF/64C2rLM/ler+XbNIdQt5j0F6R64bKDO5QPkgPVx
dzbI6WkJBcNeIs0jcznU61QFn/zls/IAOdVKipgIW3XAeQq2OtPUxml3lKzugBgP
+7K/77QtAl998wlHPrxRb94oU1OtplCt3Obayg9z4royU2CjaRXDEM+TgSsw+ft8
3vkKR/wO8bpMFMDeKBOv9mcbbb8Ap1XwBkjZKZPV13NU1GUQvFEzhVP/wscbbt69
4lfEU9llsREHWWCcEu1th3EJrFMefoP1gUS8z4Y5iEQF+hkQjiTm8DE5K2e8HzNM
g5Cp0yIwwI+h5zpVqY+ehX4x0XNB8UQqm0lbhtNZxBQOlOxIezTcKkTkSkol+blV
yGvNNdfE/XUUIgTovDPW1xQhXnkUyjeRla0F/uNuyWBYVCL0I2/PDMvUaZSs7Vyu
2nLkyR6QSOiqOkGr6yvdrtrTONzkEMdx1KHeBE44msk5BvWAknDYX++NiCepq1Z4
ost8ll6axLY8Wx07F8uicWHmTY8BBRHbPFZe7bCRBC6SGP/FiIjEQ1w3mU9AIcj/
43J91Stcxzicy82oFc5nzcmv6JoRoF3W6XwGYxFdrvUpLbhT6bObS0rsiVADPlVm
cpSSMwSWmvUfsh7Xjr4zIFYC
=HPZL
-----END PGP SIGNATURE-----

--4MQ8Rzmy6XrO+/WG--
