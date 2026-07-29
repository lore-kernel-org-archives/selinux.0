Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8548CD5F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332044; cv=none; b=p715+Ye7cbdDCyaEmSOHFxvWn4Ygusw3TWQXt5zOMg6rv1Xyz4AmOTGbmGPh5hmDoFAwfqlY21tPOcfcg1HVtQSwqh+kh2K0xcz4K6ReNscK/X7dIv3z3Vpe50ZJvEirrUPbAfpkQGquNyJ3GnxJ6FNG0dEuKfnXj6O2x89YL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332044; c=relaxed/simple;
	bh=+RuE9RqZQLLax0i++6ANdCw6PdT+du1SWyP9hyVgsTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga43ikGx+icv5ShWyF5fJY+fcLeLkMMZCzMVRGCTvBQc+wZwIH4vlQF0PmGcwJT4miKcciE890fObmfDPb+TDq/+2z+RpTBJK47B+u+3/x7U0kEVUJZ7ONCwkr7eERfGxk6roQuJsEjGyirMI9xJ9TSoMGrXYFfscpqGSVgiGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFztaWwb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+qzx+qdg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BaFHZbxG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mp4228ye; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFztaWwb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+qzx+qdg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BaFHZbxG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mp4228ye"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62B837B8A7;
	Wed, 29 Jul 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785332027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g7BeyxicL4iM67hGsD3sWVGhRCSmoTnNUH/NvM1ang=;
	b=mFztaWwbXM+fEfyNB9YvWCP8UVrsnHPYygL17HSkqGi0ne1fJKNFfdANV8hyCQ7a9xcbGU
	URaHuR6ccV6WsFznELqLz5ojlKDeyIMpMSAqqCfWctrl2ja9/RxsLLc75NkIJUHEw403yZ
	dFJDGYwNxaCgCk7iCQ6uAQ0dtVz4AZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785332027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g7BeyxicL4iM67hGsD3sWVGhRCSmoTnNUH/NvM1ang=;
	b=+qzx+qdgSoUCyRGNDXoWJZyEkHL30qr0koshsK6CCyl28Cshf0nb0EqQKVCBPZstq9cFVc
	iSLmEcDyKMRohkDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785332023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g7BeyxicL4iM67hGsD3sWVGhRCSmoTnNUH/NvM1ang=;
	b=BaFHZbxGR/LYe5+31xgwv5IbNKhdomAhgDD1IzP9+RtPN96aMmNFTW8e8lfEgTOaEyALhw
	fs5mxzcrnwtv4OcyKw3y1fAnv6LEJgwY97/FQWioOq1tuKtyLFDcqt2VBXr6eo8KLpJypp
	Poo8WUP9zCGqNT02Ik1fCBgjm+OLiAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785332023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g7BeyxicL4iM67hGsD3sWVGhRCSmoTnNUH/NvM1ang=;
	b=mp4228yeVxje5xNHyZLaF6E/EUc/i2xaHapvE2N9/V2tNUGwn2wFi5z8F8bO+6WeBazMKr
	LobFJYiiZyE0u4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25F6F779A1;
	Wed, 29 Jul 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVrxBzcBamrZfgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Wed, 29 Jul 2026 13:33:43 +0000
Date: Wed, 29 Jul 2026 15:33:41 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Carter <jwcart2@gmail.com>,
	Petr Lautrbach <lautrbach@redhat.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 3/3] RFC: SECURITY.md: Rough draft of codifying the
 maintainer process
Message-ID: <amoBNe4hOHVb_VaP@suse.com>
References: <20260723062355.3096648-1-jason@perfinion.com>
 <20260723062355.3096648-3-jason@perfinion.com>
 <CAEjxPJ7RsJoivrD+xr9qaC2znKkG2NxZCuMqNRRHVah6h2BwJg@mail.gmail.com>
 <CAEjxPJ7Xh0NvGJUm5YWVVJykAATGwZBHKfk=z_cSaNiG=LTkWA@mail.gmail.com>
 <CAEjxPJ6Rng2BPbZd3Gu=Tro2x=5qc_NQ=Cegf6HAohMMxxDuyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJrDdnDSLUsM50mW"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6Rng2BPbZd3Gu=Tro2x=5qc_NQ=Cegf6HAohMMxxDuyQ@mail.gmail.com>
X-Spam-Score: -4.90
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perfinion.com,vger.kernel.org,paul-moore.com,gmail.com,redhat.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:url]


--fJrDdnDSLUsM50mW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 09:06:39AM -0400, Stephen Smalley wrote:
> On Wed, Jul 29, 2026 at 8:45=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 23, 2026 at 9:30=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.=
com> wrote:
> > > > +If unsure about whether an issue is in kernel or userspace, feel f=
ree to send
> > > > +to any and the maintainers will handle it internally.
> > >
> > > I'd recommend sending to both rather than any to avoid potential loss=
/delay.
> > > We should also mention that private vulnerability reporting is now
> > > enabled on GitHub,
> > > so another option is to submit via:
> > > https://github.com/SELinuxProject/selinux/security/advisories
> >
> > We may also want to add something like the following to SECURITY.md:
> > Bugs in libsepol that only affect policy compilers (checkpolicy,
> > checkmodule, secilc) are not considered
>=20
> I would also add the semodule-utils (semodule_expand/link/package) as
> well to the list above.

Maybe don't list any components, but just state that issues that require an
attacker controlled policy source are bugs, but not security issues

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--fJrDdnDSLUsM50mW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpqATUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mkvAQAIhAb7WtiNM65VwGMnnz
k5v0J2UYYZOf9GXArvgeAGGKyvvvPlrRU48dBzMDI48PlY76hpJ/1yKJvUpQLD8A
Ud5c9f1WJDikueBv+Z8XLMAhuTqgpq8P6hZaMaz6PmELanxRsK1GjQStEWeSsr9r
755tOJB+TRoJRglsupmcG2Gi21E7wW/AAdviufbpIKuCIAQMCJSIGf/okuOLxV5X
h6BORSxkCiZ7gm1Qmeh5r1nOl1tYFIx2kDmt+BtK70sl/NbxPFxgh2w7VQB655q0
QxoNmCVECPMYDMvAC/dDlmJ6wOsXumfLkDCMpbKQlK+S3jsLCoEz/k5VoK1e/XpU
ct5bEVk2iAr8rJ/xEhGnQPCQKYp4geHOoeI5v39jRooabzcmK3jevmCjrv/60JIa
FZIJiA4xgTLKAU8eHc28XTkYG34ADuWQFgYizzhwgbxr+sUxXquTwnh03EP+iCsm
G11nIo3UYRBJGompdCVzd3Xtc2oplSn03x8oBdj2MnPBqx47N+m0lV6sb76ekWbB
8wUj+RoPq7uA8GV4ASD4pdqzKglg4xHxgOtu4CS6t9u/+FJv/Th6Sc06ftvbxp+u
azzxe3EdhnQufZeF6JdXGgRTg4Oy7hDH4gmZbArGSWzdnMb2CH+tFG2jf/sYeKiK
7q+PCgg6N5rtevU7Mnk1PwWB
=LxEL
-----END PGP SIGNATURE-----

--fJrDdnDSLUsM50mW--
