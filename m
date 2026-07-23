Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933145D18D
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820131; cv=none; b=rFpDZaKkHMc2mIEaa6CBfdoj2OnkrHdm59vFQLOC3o+LGRkI92vC/Nimw5o2T6Iojm4JLzBGhoQ3bSAgzk0iWER/hssZQOSMcdhfyQzjReXU71nC2YQRhhQZtYkT+47PnSkYspvJIxbioe62REtS7B9rteN8hV5Pw0UTWb/C0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820131; c=relaxed/simple;
	bh=7If6tWUN9/T66vevtfOE5ah7L7LDMc5sCIyB4AEk7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm9WVdGyjOQS6DBFAPc2VLVY8DEl96TO87wOJnlb2gyRSntoKXFI6ugkZAmUvmfu15RjGPEgXOTZ9QxCBMwoHBVog4dzTpytL8csBs3wPk0ydN5ZmO5Rjm4mvoouATEAe0BysB54k1LVghGuAmMo9PwQ+vbOvWr4hjrJLJptMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EB6txBGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nua0qHBr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gUoHtJ8Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7ddZ+i1x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EB6txBGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nua0qHBr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gUoHtJ8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ddZ+i1x"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB8F93E7B;
	Thu, 23 Jul 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784820115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svH4YAqM+lwBKUsTb1XJbJAbyAd+zS7OVmExooNhZcA=;
	b=EB6txBGQQI6etQIUvsroJrbYGDHHZrnEP7XdJ72NZrkZoMUXjHKaAe2OFEpejmF7xsAsm5
	EijC/22i7U/raOw2Jf0dTGnbsNR9Px7TcWI99xii7cCvD6L5p+5wVMHQcoFaQeztCrz6Dt
	UwXP035t6VsbgjIlLne28P+asGeX+8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784820115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svH4YAqM+lwBKUsTb1XJbJAbyAd+zS7OVmExooNhZcA=;
	b=nua0qHBrLWJc8cMYuI+W/eX5Ep8J3vRXy2v+jlFf+psRy+Et0cM8xKe2Jg9mAUB3a6U0tY
	a0XrSTzDHewXscCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784820113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svH4YAqM+lwBKUsTb1XJbJAbyAd+zS7OVmExooNhZcA=;
	b=gUoHtJ8QNN7ePVjtQxVckTMdgbB6uAOm4lL9zQK5pw/ThVPp49G/fNVWvHtuTI1eLnIjLX
	qqG3HWJqDP4CMZ0NXVdILaWqnbUVvpwd1sApkF/+51t37n8FHpHHwWuj1E9c0H4m1ax1Go
	4wyqQwoiNBsAuSyvj5psV/nXQ6JYhLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784820113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svH4YAqM+lwBKUsTb1XJbJAbyAd+zS7OVmExooNhZcA=;
	b=7ddZ+i1xBUryfM21tKSvqZFmgcePA+3eXDd7CJUAxWHWi3yBo3ulVO0YmXK3aqBWkAOTx5
	e2OIJHBNIh7h8lDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0B92779B5;
	Thu, 23 Jul 2026 15:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dFzOKZExYmoeHwAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Thu, 23 Jul 2026 15:21:53 +0000
Date: Thu, 23 Jul 2026 17:21:52 +0200
From: Johannes Segitz <jsegitz@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
Message-ID: <amIxkNuNJcxhtkOR@suse.com>
References: <amHW-fFHM3pw-g3y@suse.com>
 <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfldnkXGgwSNfQYl"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
X-Spamd-Result: default: False [-6.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain,text/x-patch];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:url,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.40
X-Spam-Level: 


--sfldnkXGgwSNfQYl
Content-Type: multipart/mixed; boundary="W+gUvfl1O/C7og4l"
Content-Disposition: inline


--W+gUvfl1O/C7og4l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:55:48AM -0400, Stephen Smalley wrote:
> On Thu, Jul 23, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> >
> > All other failures are handled gracefully. Directory cycles can e.g.
> > happen on BTRFS filesystems with subvolumes. Skip them and continue
> > instead of exiting
>=20
> This is a user-visible behavior change so we should note it; restorecon -R
> on a tree with a bind mount of an ancestor will now complete with rc 0 and
> only a WARNING rather than aborting with ELOOP.

Okay, I can write something up. But in general you would be fine with the
behavior change?

> Missing Signed-off-by line and the patch still doesn't apply for me
> (did you send it using git send-email and against current selinux/main?)
> but also see comment below on the code.

I start feel like an idiot. The first time I used this old repo with the
wrong branch, but this time I made sure it applies, but didn't use
git send-mail.

I did
# git format-patch -1 HEAD
0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch

which for me then applies:
# git checkout main
Already on 'main'
Your branch is up to date with 'origin/main'.
# git rev-parse --short HEAD
84d424b8
# git am 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
Applying: selinux_restorecon: Do not exit on directory cycles

Maybe my manual inclusion in the mail breaks it? I attach it now to the
mail

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg,=
 Germany
www.suse.com, Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abh=
inav Puri, (HRB 36809, AG N=C3=BCrnberg)


--W+gUvfl1O/C7og4l
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
Content-Transfer-Encoding: quoted-printable

=46rom 9155f98c8dec5b275ee0429cc19c9b42d8c3c8b5 Mon Sep 17 00:00:00 2001
=46rom: Johannes Segitz <jsegitz@suse.de>
Date: Thu, 23 Jul 2026 10:48:40 +0200
Subject: [PATCH] selinux_restorecon: Do not exit on directory cycles

All other failures are handled gracefully. Directory cycles can e.g.
happen on BTRFS filesystems with subvolumes. Skip them and continue
instead of exiting
---
 libselinux/src/selinux_restorecon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_r=
estorecon.c
index 30f1b836..fdefc92c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *arg)
 		if (is_dir) {
 			if (descend && walk_is_cycle(state, ent_sb.st_dev,
 						     ent_sb.st_ino)) {
-				selinux_log(SELINUX_ERROR,
+				selinux_log(SELINUX_WARNING,
 					    "Directory cycle on %s.\n",
 					    ent_path);
 				close(ent_fd);
-				close(rd_fd);
-				errno =3D ELOOP;
-				state->error =3D -1;
-				state->abort =3D true;
-				goto finish;
+				if (rd_fd >=3D 0)
+					close(rd_fd);
+				prune_pathbuf(state);
+				continue;
 			}
=20
 			if (state->sfsb.f_type =3D=3D SYSFS_MAGIC &&
--=20
2.55.0


--W+gUvfl1O/C7og4l--

--sfldnkXGgwSNfQYl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCgA5FiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmpiMZAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJELwn3Z0sxP1mcGcP/3DkT0VlK12ISDd3rJAG
3fbgDATSOpZZEPNMU0mKQMy8Spx+alazu86472J0Nlmw3C/MVXb9S36zrrvMhhWk
6PlpeqM+udtcRpvB6+/UEfeR4JAK5+CvOnA98zjujtC3TCDDzf/tq7RDJoW9Q9WZ
2hbhGVvWqMICfe/fHl6ZvpviY6OUiPp+mHYzr9Crz4s5CkvW9HnviAnhjN2P+3y6
WlqdUGSlBrveLv4Z5RnyZ8F3LK2xMxEAO+2cOR+O77TQCGfzND4dGoBBO+x4OPRQ
vaFqG4LQIPcp++/bC/2lxsVxEV1gk5EfuN5wt0y7GoJIjcLcEa7u2C7/eFdxclnH
ammTFVazagSPS/vYpMZfCn4uvi0QrmxXh8ayUl7iaC/GQNRap8Z/CGGiKgz1B+q9
MlfW1g2xGi38q6PzExn7h7WQsqFS1fV5jYmMhXZPh163pxIuZ3txjVOMhfZ0yQeS
q3QCaqffhjQ6q9ml2HCP0LZj6M5XVprxXBWZt5wxt/HB/UQtSMNES2k5pW2PVbg/
ripl/pNfvMjs7Zd40o0gkD5WHVKKrdpsiP9clsJXksU7uS42h0E+I+OYAfA3xCFp
Dk7SF39soqKeLwBrNScxENEeW25XqOC259O6JMNti4XJnFkP+B6V4JZNBXpLI6xa
2iGDnfZYi4V/tdYPH0+/Fbzs
=1Oyw
-----END PGP SIGNATURE-----

--sfldnkXGgwSNfQYl--
