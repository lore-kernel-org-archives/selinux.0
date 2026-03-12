Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C873375C5
	for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339051; cv=none; b=arQZG0bYzAFi+O2S/QUQRPudjE00n0mtTMw0Y0w7p/eVkwy4SnaM12BsGHqyJeTEBOSdF5F72rWJixQYVJntkd3dRP9ItPC5q8yPiG9QbEx51Xn67xaUKClOd7HXnxLumYCFx6YhJnG6+q/IFJMECc8lBHUWpL2h22891BAJnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339051; c=relaxed/simple;
	bh=ACMgbms2OBnQn7eSwfS9l2lT2lt6vCVAgI9oBG5Zha0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PwGxfA+ZPRRSbB+ZuHW0OmxL6kAlTpepM36NedJI6rLnYOpwew1yRzCtcl/o/KM9uuTHXTewluPmx7SxA8aPJdTRDmxbH/h5CnlgX8UGeH0wb+szhsFkXYhh6sIar8miyslpH2Mr6GFJTwRwo3pVis2n9ZOS1cbCtzvE0q1qXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DaV9pO6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIZe3MdC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DaV9pO6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sIZe3MdC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DaV9pO6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIZe3MdC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DaV9pO6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sIZe3MdC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27BD24D79B;
	Thu, 12 Mar 2026 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773339044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UQmvqb2SNkyQqv56oA52LeiM2dvfhHNo6eRMm0UeohA=;
	b=DaV9pO6PUONAbakZEDiEPmQtL/5/rZ/RFnCXigNPHn9c75VMynqGg3UqGK8OvJcvOVWA4o
	rNGl2lDsYhKhLRaj4qDOPx+y7Mipns4PrnNPnK8/d2mWeWM9j9LW1+0uBXjqqkMKDHw1Ck
	5y5kB/2JGAkialVD7jmQ0OV2ZBfbWO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773339044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UQmvqb2SNkyQqv56oA52LeiM2dvfhHNo6eRMm0UeohA=;
	b=sIZe3MdCbl17BtxZAb6m3QpuoZ69UUCtOkNbz8zhTEJsUvfi/3sQIeLXldbEl28NHOQ2nc
	WYZbB67B5HR+wZCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DaV9pO6P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sIZe3MdC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773339044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UQmvqb2SNkyQqv56oA52LeiM2dvfhHNo6eRMm0UeohA=;
	b=DaV9pO6PUONAbakZEDiEPmQtL/5/rZ/RFnCXigNPHn9c75VMynqGg3UqGK8OvJcvOVWA4o
	rNGl2lDsYhKhLRaj4qDOPx+y7Mipns4PrnNPnK8/d2mWeWM9j9LW1+0uBXjqqkMKDHw1Ck
	5y5kB/2JGAkialVD7jmQ0OV2ZBfbWO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773339044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UQmvqb2SNkyQqv56oA52LeiM2dvfhHNo6eRMm0UeohA=;
	b=sIZe3MdCbl17BtxZAb6m3QpuoZ69UUCtOkNbz8zhTEJsUvfi/3sQIeLXldbEl28NHOQ2nc
	WYZbB67B5HR+wZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFA3D400D5;
	Thu, 12 Mar 2026 18:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cfT0N6MBs2kEXwAAD6G6ig
	(envelope-from <fbonazzi@suse.de>); Thu, 12 Mar 2026 18:10:43 +0000
Date: Thu, 12 Mar 2026 19:10:42 +0100
From: Filippo Bonazzi <fbonazzi@suse.de>
To: selinux@vger.kernel.org
Cc: selinux@suse.de
Subject: Question about libselinux *_with_level functions
Message-ID: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
Mail-Followup-To: selinux@vger.kernel.org, selinux@suse.de
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qvnz37d7pffidyvd"
Content-Disposition: inline
User-Agent: NeoMutt/20250905
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 27BD24D79B
X-Spam-Flag: NO
X-Spam-Score: -6.11
X-Spam-Level: 


--qvnz37d7pffidyvd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Question about libselinux *_with_level functions
MIME-Version: 1.0

Hi all,

While looking into an openSUSE SELinux bug report[0] I ended up looking at =
the
*with_level functions of libselinux:

     int get_ordered_context_list_with_level(const char *user, const char *=
level, const char *fromcon, char ***list);
     int get_default_context_with_level(const char *user, const char *level=
, const char *fromcon, char **newcon);

The function names and the man page seem to suggest that these functions sh=
ould
apply the provided level parameter to the context. However, in my testing w=
ith
libselinux-3.10, this does not happen: both functions return the context wi=
thout
an applied level.

Simple example:

     char *seuser =3D "unconfined_u";
     char *level =3D "s0-s0:c0.c1023";
     char *newcon_with_level =3D NULL;
     char *newcon_without_level =3D NULL;
     get_default_context_with_level(seuser, level, NULL, &newcon_with_level=
);
     get_default_context(seuser, NULL, &newcon_without_level);
     printf("With: %s\n", newcon_with_level);
     printf("Without: %s\n", newcon_without_level);

> With:    unconfined_u:unconfined_r:unconfined_t:s0
> Without: unconfined_u:unconfined_r:unconfined_t:s0

newcon_with_level and newcon_without_level should be different, but they are
identical.

It looks to me like the implementation of get_ordered_context_list_with_lev=
el()
is just not fully handling the level parameter. The parameter is only used =
to
get to define the newfromcon parameter, but the level information is then
stripped anyway by the call to get_ordered_context_list().

Am I misunderstanding something?

Thank you,

Filippo

P.S. I previously reported this issue on Github [1] in a bit less detail, b=
ut I
hope to get better answers asking this directly here.

[0] https://bugzilla.suse.com/show_bug.cgi?id=3D1259191
[1] https://github.com/SELinuxProject/selinux/issues/508

--=20
Filippo Bonazzi
Security Engineer                        suse.com
8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9

--qvnz37d7pffidyvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEgldDmJR6Lb7yHXbmk3pj8Fs2RtkFAmmzAaEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEJN6Y/BbNkbZPGEH/jUFB8rEKdtJr3bho0Yb
G76Oe/H5avTXwFqJW88V6UN8V7AEUWoeUzcN32w9CO9v+da2CT5peGiHsNSCNHwR
EyLSdaE1tLr3qOGBLTK7tS3F5PWrBvUSqT7RhZXtMONrhaRECMKGO3C7V4eTnK7c
1lHPp2gdYWCWR5BjMXTfXOD2Xataw5Z/H3GvUeZ6/uE8sKVo4r1auQrnz3MWvlSK
kLrkVB7ouLKEL9RKgaLeI9n4T24V4ibB6Rt9jIck3rMi1yMf7XxWFVCqTVpn0pLr
QVSC+MsfIXCsypzBSX95kcPo1fDpN3gHKO+d/JPXSsQ+SC6EHMTOta/QYL2hOW6u
bmQ=
=+9mo
-----END PGP SIGNATURE-----

--qvnz37d7pffidyvd--
