Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25833689A
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793770; cv=none; b=qsqmC1n1DlYnaSwiK4ta71YUYN/t4A+IPFhxBi/3uyvMuITRYm7F5mN5ogox71YUYnsyblOW4gL2GIzX9EEzbvLnIThOv17YyfagPRWqPAHiNObdkUQ/laYclu5o0RdFYuTzDNkNigjcywsYP4kIp+XqECxPHt2G/TbDZ6SFgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793770; c=relaxed/simple;
	bh=skSbXLO0TNb+JTQusHIhoHMpHpAC2Gm1NDj34T7b+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF3GLH27X3WkF46Ihjy6r5gfBm7Z+jLt/T52ZcvhWL/1FpKlfSUPAY1jZjbsnV4fAEK1Ok0goFZLNmWM6DlGDXJHIiTOzooM2Fwt3nzI41WdajKgOi9ddADbWz0PLF0tNK4HAWGqejzCaPFGkQS9cS8Rv2hf32zTrayb/02gk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=02axbpsd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2DQXc0U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CSgG4HjZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/qZqpL54; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="02axbpsd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2DQXc0U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CSgG4HjZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/qZqpL54"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 332C63E09;
	Thu, 23 Jul 2026 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784793766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SmK1vzj2uc3nyI/tpUoDSvC8uln6mmd39tjQWCd3J4=;
	b=02axbpsdnAPasQqfGcsox4Cv/kZLAb3G48EVMANjqqtfDhhxHWMgsD4WL2szxweGBQJ95V
	rljgXXiS2nIfXQw0zoivuK9zZmFiVYuzbhdrKebOzweaSv6E+3s/BFqIBWRt/vkLasIVyo
	ahujeTT8L6XYPqste1iIYseIMqztOb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784793766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SmK1vzj2uc3nyI/tpUoDSvC8uln6mmd39tjQWCd3J4=;
	b=E2DQXc0UDPJ5WCUxXrHMn0WMHaV36qrXDTh7N/X7YGqrxolARm3bJtruvndrVfMNC8zHtm
	sanhw28EWX9m+TBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CSgG4HjZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/qZqpL54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784793764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SmK1vzj2uc3nyI/tpUoDSvC8uln6mmd39tjQWCd3J4=;
	b=CSgG4HjZCni4HfWOX8WD2CrF6w8T1cdb6aMx7EhNuM0v62ND4ETpeFzr35mvPCPe73yNgE
	5vPIvNFJ/sLp3Na39pka1R0sWRZ7HL98aPUJQLsqPXZoVA3dYD49cb1h7czyF8ywA+XUey
	WD9OAB/AwCNlan1UlejUCAKDgBznuus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784793764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SmK1vzj2uc3nyI/tpUoDSvC8uln6mmd39tjQWCd3J4=;
	b=/qZqpL54wqaUW1MhXt9sXs3rwZ01WlLRPXPTSfbMnSo3VsDWJ8hZixew/6Ci5Ze+Yzxw6t
	OWLBwyr0hZEbyPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19B3A779B5;
	Thu, 23 Jul 2026 08:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J6D3BKTKYWoUaQAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Thu, 23 Jul 2026 08:02:44 +0000
Date: Thu, 23 Jul 2026 10:02:38 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux(8): note on conflicting configurations
Message-ID: <amHKntgLQ83bbQUi@suse.com>
References: <al8eYnGraP-hoCCm@suse.com>
 <87mrvj9gd0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F/Vdx/7dy7wPQUg1"
Content-Disposition: inline
In-Reply-To: <87mrvj9gd0.fsf@redhat.com>
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:url,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -6.61
X-Spam-Level: 
X-Rspamd-Queue-Id: 332C63E09
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action


--F/Vdx/7dy7wPQUg1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 05:46:51PM +0200, Petr Lautrbach wrote:
> Johannes Segitz <jsegitz@suse.de> writes:
>=20
> > setting SELINUX=3Ddisabled while having selinux=3D1
> > results in a non-booting system. Document this
> > here in a note
> >
> > Signed-off-by: Johannes Segitz <jsegitz@suse.de>
> > ---
> >  libselinux/man/man8/selinux.8 | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinu=
x.8
> > index 5842150b..17df2a99 100644
> > --- a/libselinux/man/man8/selinux.8
> > +++ b/libselinux/man/man8/selinux.8
> > @@ -50,6 +50,15 @@ regardless of what is set in the
> >  .I /etc/selinux/config
> >  file.
> >
> > +.B NOTE:
> > +When setting a conflicting configuration like
> > +.B SELINUX=3Ddisabled
> > +in
> > +.I /etc/selinux/config
> > +while having
> > +.B selinux=3D1
> > +on the kernel boot options will result in a non-bootable system.
> > +
> >  The
> >  .I /etc/selinux/config
> >  configuration file also controls what policy
> > --
> > 2.55.0
>=20
> It seems to work for me on CentOS Stream 10:

Interesting. We got this reported on an older SLES and carried the patch
since then. I just reproduced on a current system and there it also doesn't
happen, so please disregard this patch

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=FCrnberg, Ge=
rmany
www.suse.com, Gesch=E4ftsf=FChrer: Jochen Jaser, Andrew McDonald, Abhinav P=
uri, (HRB 36809, AG N=FCrnberg)


--F/Vdx/7dy7wPQUg1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmphyp4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mzgoQAMATf+CjE03MIdN+45Mt
BTh16g22dZJIqvgdXdztzK5t/D1cYP6xQGMzr6X/Lf1j6TpasM8pSl5yd/T+kF/o
eD55Xn4AdOT+B19K7uUkVFYFc1Fs/tWwoNoCuBFWsJumVXOxZhUSOlYTcTHOfn2X
/5LYssqbCQ4972dTlrEw0c8DHZs9TbRzp37sMf4MQL674pDjWfAsWu7VjPCNcHRD
O2ON5uOaYos7ncM18rMTkEYj7L8HKTxlgC64Y6p5VZ98bjIWhtB6eokkN+TuyhUA
goR/dcLegWvs1XCAt1Ob1T3nOgKlfq2P+SF2f+x01KW4OgZORf8LNoUz63n9tapZ
NBBJ9N9Pv+Iivfg5lDF4GetKiEI7evd7weDLaUZKGDBVr1oaaEi4V16lpv3jTETq
19UgfP8mdGv9oOJgSmBxbz60/tslmTsZd4SgLo+NnKAuAaBnR/gzGBlcvJZQVdRf
hAPqssjorG3wt1uShdpY41k22r/Sf+X1eT1f1ke6hXCwA04o3ybjUmpSa+SOAUZX
7NKKxvBHuzh5wbiEaaOq5kwkpU2iQGkYjRu/opnArO9rVijcBD/M+jxPd+Q5/EkD
grABCe0fqaaCOoKaowK9QRAWNSe/qa+5nlBoqwVpX6tfpY5kVCsdWaYxNKK0E56u
EDFoGpb/h+FpLGrbexQ8Zep4
=9SY6
-----END PGP SIGNATURE-----

--F/Vdx/7dy7wPQUg1--
