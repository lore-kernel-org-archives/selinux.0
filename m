Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F68443A99
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317654; cv=none; b=aOEYvw0OyNGa509jKQXd0cMmgXqjEhE0+RW3+AINtThfPUturW0JZx0heLy+AG4RPwcwMl6fc49IlSz6sUZjLKo24Dsu1T7o5F2Psmtp9WLwkiPInf7oG02y19a7QtaR+ugqPaRHCGYsUGc0VvkHy7ywhtt2N9ymXO9UGer2KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317654; c=relaxed/simple;
	bh=Kf3G34/UpJwCTJZdA98Ax975TtW5Vbga/hzMKynFJDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvKg43CyKnoAV5BBKqwUz8FKwmW5W26Su/rXLcDmwGYn47MlX0E0UOXbENUAddrZShc5IWW7IsgpQXRFSGhwyAFffpprdWFzQutHCLn9dKKDuJAdwuvwhA+reHRCwtfhdScp4gDS5gGw86v08xkw393NYzWbmYATj9ynHPZYOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=13aovfM3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cks8gJ3g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=od5aPXuG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJaALGn+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="13aovfM3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cks8gJ3g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="od5aPXuG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJaALGn+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8213E22;
	Wed, 29 Jul 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785317647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Flqn++Ke5Dbi9enI+JMsCPk2uOL1iUnIRaf47k9hwVM=;
	b=13aovfM3acYPMmSRDoJ6K45UEgco6VpGrXa491vM8z8nGRlBNAFnlIlJ9YV2ijunkRLr5C
	6GOhsdJLJRc1MRIppfOxjTI/TJWl14KQgCuz3tUcUAaFUCgVVz9NVOKzX+GKffPI16Ce76
	caN52Z7hX2N+3/82JRpryQTnwCnhpjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785317647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Flqn++Ke5Dbi9enI+JMsCPk2uOL1iUnIRaf47k9hwVM=;
	b=Cks8gJ3gAqRhl1XYXNXr6ngqzZ00A7grZqTklamNH4tua+ga+NlrK22j2b0S8Rp9oQxQgN
	VYwM1G1FJr39s5Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=od5aPXuG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xJaALGn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785317643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Flqn++Ke5Dbi9enI+JMsCPk2uOL1iUnIRaf47k9hwVM=;
	b=od5aPXuG0EqkjZDhgGlRJSLPnYa4qxSAkGdFwbUGGFNfB98I62pAnsK2sqrNXiNpECu0yX
	mqg7f446T8UrFfcTKpBUAezTW3NAGH5zJTHRjuNB6oTbuolx8pOAXeZ2Hdpk5JAwehDA6Y
	pEC8lccicrZgvFotfGcU8FJ+BoiPj+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785317643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Flqn++Ke5Dbi9enI+JMsCPk2uOL1iUnIRaf47k9hwVM=;
	b=xJaALGn+iLBgybOtzZ3ryWs8ywsf7C1hhDi9eupmV5BVQ/qITfFBTskb+tTXDoL+hRirbN
	YUxaoTExeKsaK0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CEFE779A1;
	Wed, 29 Jul 2026 09:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AC9bFQvJaWpxEAAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Wed, 29 Jul 2026 09:34:03 +0000
Date: Wed, 29 Jul 2026 11:33:54 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Stefan Schubert <schubi@suse.de>
Subject: Re: [PATCH] policycoreutils: Using vendor defined directories for
 configuration files
Message-ID: <amnJAsca-g2FYWhF@suse.com>
References: <20260728091632.1673214-1-jsegitz@suse.de>
 <CAEjxPJ79h83DFRnHUPrOqSVop6X46yEhYCQKEUyVGnaOaJ7pOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5IAHZZSh58n/X/MU"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ79h83DFRnHUPrOqSVop6X46yEhYCQKEUyVGnaOaJ7pOw@mail.gmail.com>
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:url,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -6.61
X-Spam-Level: 
X-Rspamd-Queue-Id: 7D8213E22
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action


--5IAHZZSh58n/X/MU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 11:00:25AM -0400, Stephen Smalley wrote:
> On Tue, Jul 28, 2026 at 5:27=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> > +       error =3D econf_getKeys(key_file, SECTIONPROCS, &key_number, &k=
eys);
> > +       if (error !=3D ECONF_SUCCESS) {
> > +               printf("\nCannot read group %s: %s\n",
> > +                      SECTIONPROCS,
> > +                      econf_errString( error ));
>=20
> Do you want to print this message even for ECONF_NOKEY?
> Previously we ignored missing sections silently.

I think it would be benefitial, but I don't feel strongly about this. If
you prefer ECONF_NOKEY can also be excluded

> >  static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
> >  {
> > +#ifdef VENDORDIR
> > +       load_checks_with_vendor_settings(pc, npc, fc, nfc);
> > +       return;
> > +#endif
> >         FILE *fp =3D fopen(CONF, "r");
> >         char buf[255], *bufp;
> >         int buf_len, section =3D -1;
>=20
> This code doesn't pass make check-format; can fix on merge if desired.

Depending on the decision on ECONF_NOKEY I'll do it if I need to resend a
v2

> > diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils=
/sestatus/sestatus.conf.5
> > index acfedf6f..01f8051d 100644
> > --- a/policycoreutils/sestatus/sestatus.conf.5
> > +++ b/policycoreutils/sestatus/sestatus.conf.5
> > @@ -8,7 +8,7 @@ The \fIsestatus.conf\fR file is used by the \fBsestatus=
\fR(8) command with the \
> >  .sp
> >  The fully qualified path name of the configuration file is:
> >  .RS
> > -\fI/etc/sestatus.conf\fR
> > +\fI/etc/sestatus.conf\fR or \fI<vendordir>/sestatus.conf\fR if it is n=
ot available
>=20
> This says "or" but econf_readDirs() will merge the two - should say layer=
ed.

I talked to Stefan and he intentionally used or here because of
https://github.com/uapi-group/specifications/blob/main/specs/configuration_=
files_specification.md#masking

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--5IAHZZSh58n/X/MU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmppyQEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1m8TwQAK1XnJ9UVqNhvDL4cpRo
hVIi4beUJdXry4Z781Xky68wd2GgaD5JGgmE4KccYGOZf7h1nuw111XZV2aBxjcc
MNNp/8fKw19tM3mBTxXIm/Jc0Z8b/jA8mXERZ0M1Z1Fgr40R5P4NYjc5V66Ldiue
qjeCMAaFlmIwO2hNwyFdwIVh3cK7EOwZEuObXJTjsa/6zCoj8Q4V+VV01hsfVott
z6TQe2/Fo1nkBP2UmPJJl4aKyDVF1W2PihHDWyUnqMO6LWCrEb1RvEdEIVhmBhBI
uJ0ArPX6DlnT3sjbgSlcr0aQeQzgniMI+A/GbliKVb06m2qatLKMYhFmRwmgXscb
/ejj4ZGL/05TfY8EbiWZjJhEiPzgAVmoGbdg7dPdYk+pUpjwxDJGmwm8j/Yy5Y3a
iwzUPetlms/hmeAyrzeFMlhFZLSVd41S6c1vgOhUbCF+16RM5/vzWad8aIZQ3mn3
AW1bjXPXcwLAhabNOKvaBr7hn+qNBZ5r5N2TwmTKIaRJ5FaIjc0TU4Pa+r/3XrzE
DaODx1Gef3RV7ojnAonY2WDebezSeHhxCf59SJTnkVWLmRwdg9ronGwow1G2seY8
c9IRx3dl1w/wRA5mtGvybf1keqWanuhz+ymuL4pvz9f3otbzXF2S1czBe9jpdBx6
x6zj7uT4BRMCCjhr5TCX9YNt
=mD2G
-----END PGP SIGNATURE-----

--5IAHZZSh58n/X/MU--
