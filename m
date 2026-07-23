Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0341D234
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821373; cv=none; b=PFJlHI0MP9RVBfgiwcxSKgz8IUOnvBsVNENF9ZWwK3qrt0OcIeEbJvcKR8kwap49mJBvY17Vr5Xv/tRAY1kvuxie2DkaII+pzpKdE5viwXZ4ajr71sLb2NKtQCpnLLGwF4I7uohP4WVWs/RhhyrdmvXByuFInCl9Nf08mcrts/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821373; c=relaxed/simple;
	bh=+byBLPaJgL1GJdX+JpcmjcWQcc1o/3cAcP8vfddcVus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzhy1nuwLkIs9RV01Ln3NMoLStlFWjI7UM6Qm8WbXYaUE3ebIX7v/4n2Mrrm8JC4hBzdHJJSp7j+eNsJFZ0F5MFCgg51c7GER7OOkXoTUV6ZwFfxD6L3q0v6LmCZtGwuGuXacMHqMVSfNuB/eFCZnT79Yhrj0/Ok5tz1OmEPEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w8SRtH3l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4mG+aC/F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w8SRtH3l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4mG+aC/F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w8SRtH3l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4mG+aC/F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w8SRtH3l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4mG+aC/F"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47C483E83;
	Thu, 23 Jul 2026 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784821367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGnGDws65kYK4KN3qMbXBPTWjXYcf0eDRnY/iC5zxEk=;
	b=w8SRtH3lgmDX8i8+/9v+Vv2uPoBV+fPMQ7hlNY9TUj4T+4KoluWjbBSw+3LVAhZuCVar/D
	UgsZyqwWYm7iBOzwq0QD87sofIgKDAREYMeFwY2UlBA7nuIKwr4kx3O+0z+qD5WIn4p+HJ
	6SVepQiZrHPgV5/NiSJ8U9E9NUe78fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784821367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGnGDws65kYK4KN3qMbXBPTWjXYcf0eDRnY/iC5zxEk=;
	b=4mG+aC/F8dlrGaQ4RtevIUVFVk4APsdPbK9H8iXMsqlUAzS18Vg5YN59T69YYK+E1sK1Dp
	S4NTI/HhnLS20VCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w8SRtH3l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4mG+aC/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784821367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGnGDws65kYK4KN3qMbXBPTWjXYcf0eDRnY/iC5zxEk=;
	b=w8SRtH3lgmDX8i8+/9v+Vv2uPoBV+fPMQ7hlNY9TUj4T+4KoluWjbBSw+3LVAhZuCVar/D
	UgsZyqwWYm7iBOzwq0QD87sofIgKDAREYMeFwY2UlBA7nuIKwr4kx3O+0z+qD5WIn4p+HJ
	6SVepQiZrHPgV5/NiSJ8U9E9NUe78fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784821367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGnGDws65kYK4KN3qMbXBPTWjXYcf0eDRnY/iC5zxEk=;
	b=4mG+aC/F8dlrGaQ4RtevIUVFVk4APsdPbK9H8iXMsqlUAzS18Vg5YN59T69YYK+E1sK1Dp
	S4NTI/HhnLS20VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17BA0779B5;
	Thu, 23 Jul 2026 15:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hx9+BHc2YmpgMwAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Thu, 23 Jul 2026 15:42:47 +0000
Date: Thu, 23 Jul 2026 17:42:45 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jason Zaman <jason@perfinion.com>, James Carter <jwcart2@gmail.com>,
	selinux@vger.kernel.org
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
Message-ID: <amI2denYr02e5TKA@suse.com>
References: <amHW-fFHM3pw-g3y@suse.com>
 <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
 <amIxkNuNJcxhtkOR@suse.com>
 <CAEjxPJ6oS-W+5e6G-KqSr60CP+GTU3G_A6d0nLpFHQMPnqccGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dobOPCdRNDQ5OzAK"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6oS-W+5e6G-KqSr60CP+GTU3G_A6d0nLpFHQMPnqccGg@mail.gmail.com>
X-Spam-Score: -5.11
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 47C483E83
X-Spamd-Result: default: False [-5.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,perfinion.com,gmail.com,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.com:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO


--dobOPCdRNDQ5OzAK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:38:24AM -0400, Stephen Smalley wrote:
> On Thu, Jul 23, 2026 at 11:21=E2=80=AFAM Johannes Segitz <jsegitz@suse.de=
> wrote:
> >
> > On Thu, Jul 23, 2026 at 10:55:48AM -0400, Stephen Smalley wrote:
> > > On Thu, Jul 23, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@suse=
=2Ede> wrote:
> > > >
> > > > All other failures are handled gracefully. Directory cycles can e.g.
> > > > happen on BTRFS filesystems with subvolumes. Skip them and continue
> > > > instead of exiting
> > >
> > > This is a user-visible behavior change so we should note it; restorec=
on -R
> > > on a tree with a bind mount of an ancestor will now complete with rc =
0 and
> > > only a WARNING rather than aborting with ELOOP.
> >
> > Okay, I can write something up. But in general you would be fine with t=
he
> > behavior change?
>=20
> I am (although other maintainers are free to disagree).

okay, I'll prepare an updated version with wording that addresses this and
=2E..

> > > Missing Signed-off-by line and the patch still doesn't apply for me
> > > (did you send it using git send-email and against current selinux/mai=
n?)
> > > but also see comment below on the code.
> >
> > I start feel like an idiot. The first time I used this old repo with the
> > wrong branch, but this time I made sure it applies, but didn't use
> > git send-mail.
> >
> > I did
> > # git format-patch -1 HEAD
> > 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
> >
> > which for me then applies:
> > # git checkout main
> > Already on 'main'
> > Your branch is up to date with 'origin/main'.
> > # git rev-parse --short HEAD
> > 84d424b8
> > # git am 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
> > Applying: selinux_restorecon: Do not exit on directory cycles
> >
> > Maybe my manual inclusion in the mail breaks it? I attach it now to the
> > mail
>=20
> Yes, unfortunately mail clients are unforgiving of inline patches
> these days so we recommend
> using git send-email,
> https://github.com/SELinuxProject/selinux/wiki/Contributing#contributing-=
code

=2E.. will set this up. My mail setup is bit unusual, because of this I
avoided it until now, but I agree that it makes reviewing easier

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--dobOPCdRNDQ5OzAK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpiNnUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mXygQAJn8r75k4WxNK8fc/9Vy
6xB4i7rtrtT4rUfPfnB7bUrLgVWDKUMgjW07Bb7caUsoAbiyWGBdACRl8+Heytcp
sSS4ijAs/8KEfrbGNBcHU5QLmMjJSZw3svZmavemJFSiZ/0LYI3U84p92Lr8dJmr
YT5wok2L1rSax8TOwUigeYmhuM9UbiinSVHoe3MBpDUucSpjvkk7MTVeN46Zzq57
2859mwMsxmQmufE2YEjeRFNyPBnhcs1KKPcTzJ7AXE3Ft7vitoEjEdHB04kS7Vqb
JTkcaAdurw66L0JJFkluHT4IfWpgtXJTqwDsFmFgKRQ6qbxdEYU5XLktIlMV4SR2
OZKH/NRs1WON3gT9RM1ynqj28iEQbr8uTsvTs3Upm2RIAZRBH0tfg4/MgUhz7ly9
6/RbW9erZu0nUbt+LJZugJzhpdO99fMmrDSnJDLMIjH2w4wwydFx+iHYXt90/15F
Nr/hLsTOG7r44x013klZJEIQXW86Zt1O5/yW94LWMRXXLZUkSJB9+Tt4C6CRw104
mhd8jlHR8Vt8En3N9O3NEAHJBHUEE5wqIkn4OVWSGOYoohsLKlug7Nllh9xkmb/+
4FWWE+cIxd48afJEi9WzlJX1K0A9FSaAVTPl2FLJc293sxM0aJ0xgSg5wNiczovM
qOgsSsS6ntM96CBE1j/R9FEI
=wneA
-----END PGP SIGNATURE-----

--dobOPCdRNDQ5OzAK--
