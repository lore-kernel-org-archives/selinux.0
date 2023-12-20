Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C620B04
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wGHyCipb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hLX0R9vk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDfRQZAG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VAL/k3mY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA5EB22142;
	Wed, 20 Dec 2023 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703066141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H4wUkmLjVkLlVyCUbtgvDjh0SjAmyyjj8XQ4YOkcKjA=;
	b=wGHyCipbfpXIpSVWnowl/nQ0c9YBu7dYHBGgCF7Ji2SmUycXrWvdSIgVKKr88HP3poZr6B
	YVjC4y0wtIbNbX5D6Kj2AN6bbluhxQ9SKDq7SFxvcaIXIDcbe+yogyvr+3jcpw1gu0eJ3a
	lifZc7QFhauotBp/kMgsrB6i/11NYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703066141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H4wUkmLjVkLlVyCUbtgvDjh0SjAmyyjj8XQ4YOkcKjA=;
	b=hLX0R9vk0yGCtOkENohkn5l4/Fn/2X4WJEtCCxLhoBqZ5UrKkmq9K7bCTpNuhSSZbfKrCu
	NDCK+7S9Xt59dlAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703066140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H4wUkmLjVkLlVyCUbtgvDjh0SjAmyyjj8XQ4YOkcKjA=;
	b=HDfRQZAGDZlCEDnvAtlNoLD9TetvjM4vfKqRiKlQUw+sO7wx9BUtmUJ6K9Bjhsu4bVMtFH
	0r1r3LLAqnatL3xDRRyP7qbY/8IgVxo/Zag4EKjFoj3wD6RRQ2DVxUhvexQRxE/kLGbNCQ
	6dU63JhS59VKqXBSHivwTiGmLumnXO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703066140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H4wUkmLjVkLlVyCUbtgvDjh0SjAmyyjj8XQ4YOkcKjA=;
	b=VAL/k3mY45aWdmz1B5DZjVlB2o0av6qPp1tfD0wOZ7FbEL9pYyELa7ZQwB0LJH7+9+7rFg
	TPb9ROwsbmUdZpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D062913722;
	Wed, 20 Dec 2023 09:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O1OlMRy6gmXWXwAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 20 Dec 2023 09:55:40 +0000
Message-ID: <bea94ac8b2feca19ef51ad271e56ff88617614e1.camel@suse.de>
Subject: Re: ANN: SELinux userspace 3.6
From: Cathy Hu <cahu@suse.de>
To: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Date: Wed, 20 Dec 2023 10:55:35 +0100
In-Reply-To: <878r5yrsnc.fsf@redhat.com>
References: <87bkaurtrk.fsf@redhat.com> <878r5yrsnc.fsf@redhat.com>
Autocrypt: addr=cahu@suse.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Rvt1D9U3y7I4WHs72W+j"
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-1.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_TWO(0.00)[2];
	 SEM_URIBL(3.50)[ubuntu.com:url];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.70
X-Spam-Flag: NO


--=-Rvt1D9U3y7I4WHs72W+j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the new userspace release. I was just packaging it for
opensuse when I saw that the signing key changed.

Could someone confirm if that is correct? I am just a bit unsure since
the new key has no signatures from people that I frequently see on this
mailinglist.

New key (almost no signatures):
https://keyserver.ubuntu.com/pks/lookup?search=3D1BE2C0FF08949623102FD25646=
95881C254508D1&fingerprint=3Don&op=3Dindex

Old key (lots of signatures):
https://keyserver.ubuntu.com/pks/lookup?search=3DE853C1848B0185CF42864DF363=
A8AD4B982C4373&fingerprint=3Don&op=3Dindex

Thanks!

Kind regards,

Cathy


On Wed, 2023-12-13 at 17:09 +0100, Petr Lautrbach wrote:
> Petr Lautrbach <lautrbach@redhat.com> writes:
>=20
> Ups.
>=20
> It 3.6 release, not 3.6-rc2
>=20
>=20
>=20
> > Hello!
> >=20
> > The 3.6 release for the SELinux userspace is now available at:
> >=20
> > https://github.com/SELinuxProject/selinux/wiki/Releases
> >=20
> > Thanks to all the contributors, reviewers, testers and reporters!
> >=20
> > User-visible changes
> > --------------------
> >=20
> > * dispol: add option to display users, drop duplicate option to
> > display booleans,
> > =C2=A0 show number of entries before listing them
> >=20
> > * libsepol: struct cond_expr_t `bool` renamed to `boolean`
> > =C2=A0 The change is indicated by COND_EXPR_T_RENAME_BOOL_BOOLEAN macro
> >=20
> > * cil: Allow IP address and mask values to be directly written
> >=20
> > * cil: Allow paths in filecon rules to be passed as arguments
> >=20
> > * Add not self support for neverallow rules
> >=20
> > * dispol: Add the ability to show booleans, classes, roles, types
> > and type attributes of policies
> >=20
> > * Improve man pages
> >=20
> > * libselinux: performance optimization for duplicate detection
> >=20
> > * dismod: add options: --actions ACTIONS, --help
> >=20
> > * dispol: add options: --actions ACTIONS, --help
> >=20
> > * checkpolicy: Add the command line argument -N, --disable-
> > neverallow
> >=20
> > * Introduce getpolicyload - a helper binary to print the number of
> > policy reloads on the running system
> >=20
> > * man pages: Remove the Russian translations
> >=20
> > * Add notself and other support to CIL
> >=20
> > * Add support for deny rules
> >=20
> > * Translations updated from
> > =C2=A0 https://translate.fedoraproject.org/projects/selinux/
> >=20
> > * Bug fixes
> >=20
> > Development-relevant changes
> > ----------------------------
> >=20
> > * ci: bump Fedora to version 39
> >=20
> > * Drop LGTM.com and Travis CI configuration
> >=20
> > Shortlog of the changes since 3.5 release
> > -----------------------------------------
> > Bruno Victal (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc: Use versioned DocBook public ide=
ntifier.
> >=20
> > Cameron Williams (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add CPPFLAGS to Makefiles
> >=20
> > Cathy Hu (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy/manpage.py: make output determi=
nistic
> >=20
> > Christian G=C3=B6ttsche (115):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Add not self support for never=
allow rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add not-self neverallow sup=
port
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: add tests for not self n=
everallow rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: add tests for minus self=
 neverallow rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: rename struct member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: update cond_expr_t struct m=
ember name
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: rename bool indentifiers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: rename bool identifiers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: rename bool identifiers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage/tests: rename bool identifie=
rs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: fix memory leak in semanage=
_user_roles
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dispol: add output functions
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: set CFLAGS for pip installat=
ion
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: drop unused token CLONE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: reject condition with bool =
and tunable in
> > expression
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: only set declared permissio=
n bits for wildcards
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: dump non-mls validatetrans rul=
es as such
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate some object contexts
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate old style range trans=
 classes
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: check low category i=
s not bigger than
> > high
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: reject XEN policy wi=
th xperm rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: skip invalid cat
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: drop message for uncommon erro=
r cases
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: drop duplicate newline in sepo=
l_log_err() calls
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: replace sepol_log_err() by ERR=
()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: replace log_err() by ERR()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add option to skip checking=
 neverallow rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dismod: misc improvements
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: free initial sid names
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: check for overflow in put_entr=
y()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/fuzz: more strict fuzzing of bi=
nary policies
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setsebool: improve bash-completion scrip=
t
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setsebool: drop unnecessary linking agai=
nst libsepol
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_expand: update
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_link: update
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_package: update
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_unpackage: update
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: introduce getpolicyloa=
d
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: use fixed sized inte=
gers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hashtab: update
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: use identical type to =
avoid implicit
> > conversion
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: check for memory alloc=
ation failure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: ebitmap: avoid branches for it=
eration
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage/tests: use strict prototypes
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: update CIL generation for triv=
ial not-self rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: update selabel_partial=
_match
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: misc label cleanup
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: drop obsolete optimization f=
lag
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: drop unnecessary warning ove=
rrides
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setfiles: do not issue AUDIT_FS_RELABEL =
on dry run
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: constify selabel_cmp(3) para=
meters
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: simplify zeroing allocation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: use type safe union as=
signment
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: avoid regex serialization tr=
uncations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: parameter simplifications
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: use correct type for b=
ackend argument
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update string_to_mode()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: fix logic for building andro=
id backend
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: avoid unused function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: check for stream rewind fail=
ures
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: simplify internal selabel_va=
lidate prototype
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: drop include of intern=
al header file
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: free elements on read_spec_e=
ntries() failure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: set errno on label lookup fa=
ilure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject avtab entries with inva=
lid specifier
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avtab: check read counts for s=
aturation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add round-trip tests
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: update getdefaultcon
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: cast to unsigned char for ch=
aracter handling
> > function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: introduce reallocarray(3)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate default type of trans=
ition is not an
> > attribute
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate constraint depth
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: more strict validation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject unsupported policy capa=
bilities
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use str_read() where appropria=
te
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: adjust type for saturation che=
ck
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: enhance saturation check
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate the identifier for in=
itials SID is valid
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop LGTM.com configuration
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop Travis CI configuration
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: ignore unavailable interpreters
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci: bump Fedora to version 39
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update Python binding
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update Python installation on Debian
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: update run-scan-build
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_link: avoid NULL dereference on=
 OOM
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: set number of target names
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: fix memory leak in customiza=
ble_init()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid leak in OOM branch
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid memory corruption on rea=
lloc failure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: update policy capabilities arr=
ay
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 github: bump action dependencies
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate common classes have a=
t least one
> > permissions
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: include length squared in hash=
tab_hash_eval()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use DJB2a string hash function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: use DJB2a string hash func=
tion
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: use DJB2a string hash functi=
on
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newrole: use DJB2a string hash function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid fixed sized format buffe=
r for xperms
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid fixed sized format buffe=
r for xperms
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate conditional type rule=
s have a simple
> > default type
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use correct type to avoid trun=
cations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dismod: avoid duplicate init=
ialization and fix
> > module linking
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject invalid class datums
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/fuzz: handle empty and non kern=
el policies
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject linking modules with no=
 avrules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: simplify string formatting
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dispol: misc updates
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: constify tokenized input
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid integer overflow in add_=
i_to_a()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: extended permission formatting=
 cleanup
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate empty common classes =
in scope indices
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update const qualifier of pa=
rameters in man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: always set errno on context =
translation failure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: state setexecfilecon(3) sets=
 errno on failure
> >=20
> > Dominick Grift (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: fixes filecon example
> >=20
> > Huaxin Lu (4):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: add check for calloc in chec=
k_booleans
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: add check for strdup in str=
ings_list_add
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc: add check for malloc in secilc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: add check for category value b=
efore printing
> >=20
> > Huizhao Wang (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: compatible with the use of =
EUID
> >=20
> > James Carter (53):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol/cil: add support for pr=
efix/suffix filename
> > transtions to CIL"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: add prefix=
/suffix support to
> > module policy"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: add prefix=
/suffix support to
> > kernel policy"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol: implement new module b=
inary format of
> > avrule"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol: implement new kernel b=
inary format for
> > avtab"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move filen=
ame transition rules
> > to avrule"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move filen=
ame transitions to
> > avtab"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move trans=
ition to separate
> > structure in avtab"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Fix class permission verif=
ication in CIL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Use isinstance() instead of type=
()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Remove the Russian translat=
ions
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gui: Remove the Russian translations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Remove the Russian translati=
ons
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Remove the Russian translati=
ons
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: Remove the Russian translat=
ions
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Remove the Russian translation=
s
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcstrans: Remove the Russian translation=
s
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policycoreutils: Remove the Russian tran=
slations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Remove the Russian translations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Remove the Russian translations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: Remove the Russian translat=
ions
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox: Remove the Russian translations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule-utils: Remove the Russian trans=
lations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Do not automatically install Russian tra=
nslations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Changes to ebitmap.h to fix co=
mpiler warnings
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Do not call ebitmap_init t=
wice for an ebitmap
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add notself and other supp=
ort to CIL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Use ERR() instead of log_err()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Add notself and other keywo=
rds to CIL
> > documentation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/test: Add notself and other tests
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Parse and add deny rule to=
 AST, but do not
> > process
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_list_is_empty macr=
o
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_tree_node_remove f=
unction
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Process deny rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_write_post_ast fun=
ction
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Export the cil_write_post_ast =
function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/secil2tree: Add option to write C=
IL AST after post
> > processing
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/test: Add deny rule tests
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Add deny rule to CIL docume=
ntation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Remove support for role dom=
inance rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Fix the version number for the=
 latest exported
> > function
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: Update the order of neve=
rallow test results
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Use struct cil_db * instea=
d of void *
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Refactor and improve handl=
ing of order rules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Allow IP address and mask =
values to be directly
> > written
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Update syntax for IP addres=
ses and nodecon
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Refactor Named Type Transi=
tion Filename
> > Creation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Allow paths in filecon rul=
es to be passed as
> > arguments
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Fix and update the document=
ation for macro
> > parameters
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add pointers to datums to =
improve writing out
> > AST
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Give warning for name that=
 has different flavor
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Do not allow classpermissi=
onset to use
> > anonymous classpermission
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Clear AST node after destr=
oying bad filecon
> > rule
> >=20
> > Jeffery To (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Fix get_os_version exce=
pt clause
> >=20
> > Juraj Marcin (8):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move transition to=
 separate structure
> > in avtab
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move filename tran=
sitions to avtab
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move filename tran=
sition rules to
> > avrule
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: implement new kernel binary fo=
rmat for avtab
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: implement new module binary fo=
rmat of avrule
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: add prefix/suffix =
support to kernel
> > policy
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: add prefix/suffix =
support to module
> > policy
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: add support for prefix/suf=
fix filename
> > transtions to CIL
> >=20
> > Masatake YAMATO (10):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: add --help option
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: delete an unnecessary empty line
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: handle EOF in user interaction
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: add --actions option for non-int=
eractive use
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: add --help option
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: delete an unnecessary empty line
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: handle EOF in user interaction
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: add --actions option for non-int=
eractive use
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: print the policy version only in=
 interactive mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod, dispol: reduce the messages in b=
atch mode
> >=20
> > Ondrej Mosnacek (4):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: include more parameters in =
the module checksum
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts/ci: install rdma-core-devel for =
selinux-testsuite
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: stop translating deprecated in=
tial SIDs to strings
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: add support for the new "init"=
 initial SID
> >=20
> > Petr Lautrbach (9):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: improve format strings for prope=
r localization
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Drop hard formating from localiz=
ed strings
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semanage: Drop unnecessary import from s=
eobject
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: update python.pot
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update translations
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6-rc1 for release.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6-rc2 for release.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy: port to dnf4 python API
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6 for release.
> >=20
> > Sergei Trofimovich (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: fix src/genhomedircon.c bui=
ld on `gcc-14` (`-
> > Werror=3Dalloc-size`)
> >=20
> > Stephen Smalley (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux,policycoreutils,python,semodu=
le-utils: de-brand
> > SELinux
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libselinux,libsepol,policyco=
reutils,semodule-
> > utils: update my email
> >=20
> > Topi Miettinen (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy: clarify manual page of sepolic=
y interface
> >=20
> > Vit Mojzis (12):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/chcat: Improve man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/audit2allow: Add missing options =
to man page
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/semanage: Improve man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/audit2allow: Remove unused "debug=
" option
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policycoreutils: Add examples to man pag=
es
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Improve man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox: Add examples to man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Add examples to man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Add examples to man pages
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Fix template for confin=
ed user policy
> > modules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Add/remove user even wh=
en SELinux is
> > disabled
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Harden more tools against "rogue=
" modules
> >=20
> > wanghuizhao (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: migrating hashtab from polic=
ycoreutils
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: adapting hashtab to libselin=
ux
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: performance optimization for=
 duplicate detection
>=20
>=20

--=20
Cathy Hu <cahu@suse.de>
SELinux Security Engineer
GPG: 5873 CFD1 8C0E A6D4 9CBB F6C4 062A 1016 1505 A08A

SUSE Software Solutions Germany GmbH
Frankenstrasse 146
90461 N=C3=BCrnberg

Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)




--=-Rvt1D9U3y7I4WHs72W+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmWCuhcACgkQBioQFhUF
oIpsgQ/6Ao2/ZgKEOO4aWcpthIu8YCaSvfRYtwWRvG5eHcMB7FtDFtDf8x8iHDpu
lfiwPof1paYoY2YDb8aPPCmRtCQVK3U+p47TurZ+HCKlJNbjasSuZ6rPoTPplz8m
Gfd7JQuY2HpStYT8/NtmdKDWCwJCwnUVvLmW0fx1KSqKzUt5rfpsYFVRkM9ENf86
YY51YaWiSEju5YPvLAhcgEvzBfQI2EiuRi4qvFgvxn/yXsnWOZfIK/pv0qJxsA41
lgpBXh9m1+VY75qWiovV7TSNzTsBYnbeZh+C2VdXkBGZIzjbXySt0w1AXCqcYdqc
3xaK5toXLDnNrVtgZmFHW8B7of9W5yrxGog9kPIYlhg1cH8mrakMzSTbNCp2jtgl
xJjqYamHX9TNN48n/HojGvCiDN9q2R8lPsqzANh4aiFW0RJ7MjwydLdAauVfb3vk
hoKXCCrGp6JG21WesOwxg75wfVD645tznBOq/sabvUmzWTPb070lIgXula85rV5B
3Bk9AARyjmODlOjF8TNPsxCdTA5D3Yf44n1RZUHSVwJxIyWukCXMwfmvu8qvQRp8
4Z/j1qozMn0mOO9LDfMLpMfrrD49yQFlpDAdrgATt9QcNMK5v4zkvEuvoPmBqb5q
HMr42ZqN0nhnph1n94woQHgnRZRpncwruYzoKREgbUxsXxX785U=
=N5qC
-----END PGP SIGNATURE-----

--=-Rvt1D9U3y7I4WHs72W+j--
