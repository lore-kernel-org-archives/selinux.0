Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02794D98FC
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646911; cv=none; b=sxFV943h1s2U2BN96zLKTBSrNADZFKu8Zu07J/w6p2866R0RTLf8DhA4Ekd1LRFuU9GKD71+uH0mi7de5RyF8DfOqZd35vCL4z2gZx6/G3eJUM+8r+salQMEy2JP8PN1CK26OzLcpx4qcdCnGm1ByCHJQKxIe9sXDDJ5k6HDXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646911; c=relaxed/simple;
	bh=KI6Ns9kW2sQ36lKMoQwzQkq0fKkAHF24P3aFRT2riBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4GKlxv6RGe//CpGTRlVawFjJpXFek2PR40cjUrGsO26fgh/itMQVvn+Trn16fnA5J5GfnnD5OfVrrM6hP5BsMih11+nIF0EZ69jRFj8n/ICd6sB4nJHhJAT94c6BRfYj4WpjH06NPEBDXHaamPfMGU1uCoCW6tUqM3xVQ+Sl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HHcck9xX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tBUWIFfV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HHcck9xX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tBUWIFfV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HHcck9xX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tBUWIFfV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HHcck9xX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tBUWIFfV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F2657A5AC;
	Tue, 21 Jul 2026 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784646907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++Nv4tPxP1g3bVytNARpCFQQJ/hn7aZ+e/rTa2m65j8=;
	b=HHcck9xXTlxJ0nAV15gm5QfMmgj3loYvyVR/GzJCHIcoeBJ50s+/BXjjqVwv0RYeDs6AVE
	hxMet3Ohv0PrhBQ1fx11OQUqIcIR0HkoHiEx4FgLWAbWwFkVxOnqOWg7h+iZ395Y37UXX0
	VzwpfhPq8mveggmLonyF4JS4Ruuh0rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784646907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++Nv4tPxP1g3bVytNARpCFQQJ/hn7aZ+e/rTa2m65j8=;
	b=tBUWIFfVFzVIbOYejT2gUb3D85K+5sE8QdNDjj7n5DHi9KXH14zXTCiqpqKjz/tYPSB3r9
	qRxoBgarwPcxSmAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HHcck9xX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tBUWIFfV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784646907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++Nv4tPxP1g3bVytNARpCFQQJ/hn7aZ+e/rTa2m65j8=;
	b=HHcck9xXTlxJ0nAV15gm5QfMmgj3loYvyVR/GzJCHIcoeBJ50s+/BXjjqVwv0RYeDs6AVE
	hxMet3Ohv0PrhBQ1fx11OQUqIcIR0HkoHiEx4FgLWAbWwFkVxOnqOWg7h+iZ395Y37UXX0
	VzwpfhPq8mveggmLonyF4JS4Ruuh0rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784646907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++Nv4tPxP1g3bVytNARpCFQQJ/hn7aZ+e/rTa2m65j8=;
	b=tBUWIFfVFzVIbOYejT2gUb3D85K+5sE8QdNDjj7n5DHi9KXH14zXTCiqpqKjz/tYPSB3r9
	qRxoBgarwPcxSmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74445779AA;
	Tue, 21 Jul 2026 15:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T6oIG/uMX2oldgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 21 Jul 2026 15:15:07 +0000
Date: Tue, 21 Jul 2026 17:15:06 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
Message-ID: <al-M-kE18Q7okHxy@suse.com>
References: <al8dIlPQqf4eHINW@suse.com>
 <CAEjxPJ7+=671kRb2fxSgZsyDuysDatMamUZT_vtFkug6_5x2nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dYgyMg3amqf5faLq"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7+=671kRb2fxSgZsyDuysDatMamUZT_vtFkug6_5x2nQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8F2657A5AC
X-Spam-Flag: NO
X-Spam-Score: -6.61
X-Spam-Level: 
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org


--dYgyMg3amqf5faLq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 09:54:28AM -0400, Stephen Smalley wrote:
> On Tue, Jul 21, 2026 at 3:23=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> >
> > All other failures are handled gracefully. Directory cycles can e.g.
> > happen on BTRFS filesystems with subvolumes. Skip them and continue
> > instead of exiting
> >
> > Signed-off-by: Johannes Segitz <jsegitz@suse.de>
>=20
> This doesn't apply on selinux/main.

Sorry, had a repo still with branch "master", will send both again tomorrow

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--dYgyMg3amqf5faLq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpfjPobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mx14P/iiGoPDFsSJXOj/6BPBK
IyWY12lvmHuJLz/7Cj1q3VabhDlQBOgOPnNmArQpoa/Wdf/NiuKC9sPQEjifOOin
BPN1LMQmBFGs37Ovxngps6n8Umsmora2bIvfRANFmUekIXAYlsPKp6inRZEC1uWv
Y4ur6Ljh9QHxOxkVp+hHDwaJ/s+YxkiOhp9YAV0x9VeIWeP0NnEPdVUtvjDachbM
dAzYlABojZ5vdQoPTEXoxFUSxmFmc4MNdhy2wOuJMz6ABW5hxBVfnLqfRCONOzsz
Iuff+NhWDwPehYaf7OSe4TNvekbL1/vvBqLPxr9MpnEbQ5JnOMhUXxI2qsjKcjU6
guaYyb4IXWb6AlVn0odkODYTYrTGSCYslW+ebcstROhmiHtttKBueyPjThgZM4D7
ZiPGaR/W90dmGx0mc1wSpB+/1VlH3xTINoUq54MShFa6EZ0ijtU0Mkyq/0sBzo/M
d23oPgYJIEkLhyoVmzl+ohNJDNVMdnTaq8b7IQSO+jD9dFdPjFKHw+ya7SVCAgHj
WLiM+QG5mxXvbfXEKNu4Yt3cVhNjg3zEkMlWlEkwbq+4WwTSa7iZ6N2mMfDgYKzm
FRDXq9bpn86YYfG92iNvmhJeMpJ8RdAjHlpZ/ph+r5poZ/t7XPJ8R9l8eXncsHmd
r2aWnABYW1ywV/ufOcdSI1AQ
=WpD/
-----END PGP SIGNATURE-----

--dYgyMg3amqf5faLq--
