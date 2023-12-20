Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBE225CA
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0XuKL2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703074866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3T16SGVJgPmqkBuXyXl/Gdsqv8sv03aSTziemiQ6LP4=;
	b=c0XuKL2uKHjBdFLc/CgWX+2+EPcYRQS88e3MPlXblNapRittRvNfR/5saQz2smWkBRz9qS
	YS2GcUeuK7ED46sx/z5uYZQVMS8bqb2hC0eo889HqgF+as+UNl98mgj1IWYCoMljXw8uns
	U04yIUsJplB1PdwOfkE0GsUOXMPWFpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-0-TVDtIPOfeebNwabgDx2Q-1; Wed, 20 Dec 2023 07:21:05 -0500
X-MC-Unique: 0-TVDtIPOfeebNwabgDx2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B581D85A58A;
	Wed, 20 Dec 2023 12:21:04 +0000 (UTC)
Received: from localhost (unknown [10.45.224.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C258492BC6;
	Wed, 20 Dec 2023 12:21:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Subject: Re: ANN: SELinux userspace 3.6
In-Reply-To: <bea94ac8b2feca19ef51ad271e56ff88617614e1.camel@suse.de>
References: <87bkaurtrk.fsf@redhat.com> <878r5yrsnc.fsf@redhat.com>
 <bea94ac8b2feca19ef51ad271e56ff88617614e1.camel@suse.de>
Date: Wed, 20 Dec 2023 13:21:03 +0100
Message-ID: <87o7elxdxs.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Cathy Hu <cahu@suse.de> writes:

> Hi,
>
> thanks for the new userspace release. I was just packaging it for
> opensuse when I saw that the signing key changed.
>
> Could someone confirm if that is correct? I am just a bit unsure since
> the new key has no signatures from people that I frequently see on this
> mailinglist.
>
> New key (almost no signatures):
> https://keyserver.ubuntu.com/pks/lookup?search=3D1BE2C0FF08949623102FD256=
4695881C254508D1&fingerprint=3Don&op=3Dindex
>
> Old key (lots of signatures):
> https://keyserver.ubuntu.com/pks/lookup?search=3DE853C1848B0185CF42864DF3=
63A8AD4B982C4373&fingerprint=3Don&op=3Dindex
>

Thanks for checking signatures!

This is correct.

It's signed by me - Petr Lautrbach <lautrbach@redhat.com> known as
bachradsusi on github and the public key could be found at

https://github.com/bachradsusi.gpg

This key is signed by
E853C1848B0185CF42864DF363A8AD4B982C4373 Petr Lautrbach
<plautrba@redhat.com> which is signed by other guys.


The key used for signing release tar balls is the same key as I used for
signing the release commit:

# git show --show-signature -s 3.6
tag 3.6
Tagger: Petr Lautrbach <lautrbach@redhat.com>
Date:   Wed Dec 13 15:47:30 2023 +0100

Release 3.6
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEG+LA/wiUliMQL9JWRpWIHCVFCNEFAmV5xAIACgkQRpWIHCVF
CNG+Cw/+Ie5771Z4TzUYNHrjz7cKHI3PMzD4QmfyXNfFAvRK8u4QeGDwiPA/7pQe
FS9RMMgbm7AQUndg6v4wTF3qgoAFnBXX3cwiYZLVESQ08sLGwFDILei+P9r+9rmQ
d7H3sHodZ+M5883qb1NASe9S5uMCq07eeMkgZJ/m6qnyhK5hYvXLRejgXppn+6Sv
mP6B1Weqh7WyHHOA6stFr2TvH1Nc5/2hwe9hbzxk/m0C6wf9JMk40tdN/AqLKg/9
RA5IDFt2AHGHciAlXWJaIkc6jKKGgDjOd2Cb3MyIHDQ8LDyhSENRYfKp5n2N6v3Z
i5lZSqF9Mgvj6lOVlxK5p+hxSG6OheqRLB5852peAUtZH1oyF9zaMcAOfXaIR/1i
3bKO9RDn+dlrXA//xRGMIcgxBk7h/AjFVEUJPW52z83lMUqM+kDVj6WbwnLZswTy
3WCy26KKDIl2HbhyCzjtmuVMUF/kVn32WR/zzP2UzD4wj0bCRpF02YbHdX5e9SMi
8n0VDR3RM82KrTZkNWZKwkEKXNETSfCX5g/L6BZl21jREKF2GKc9T2zwjXwwGaHr
VarC0FHwW/ZXH/7pCTDbDc30BK6HsPKtoqmpUQWskWfG2hq97P8RcM/i6t0vyYX6
KdD2Xk4iNXLXQNmU6EGKvEev8FOrvdu58hsBnm9ePTyckfoiNTE=3D
=3DH3ax
-----END PGP SIGNATURE-----

commit 97fa708d867ecb26e8d1c766760947f8e3b9e59a (HEAD -> main, tag: semodul=
e-utils-3.6, tag: selinux-sandbox-3.6, tag: selinux-python-3.6, tag: selinu=
x-gui-3.6, tag: selinux-dbus-3.6, tag: secilc-3.6, tag: restorecond-3.6, ta=
g: policycoreutils-3.6, tag: mcstrans-3.6, tag: libsepol-3.6, tag: libseman=
age-3.6, tag: libselinux-3.6, tag: checkpolicy-3.6, tag: 3.6, origin/main, =
origin/HEAD)
gpg: Signature made Wed Dec 13 14:46:22 2023 UTC
gpg:                using RSA key 1BE2C0FF08949623102FD2564695881C254508D1
gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owne=
r.
Primary key fingerprint: B868 2847 764D F60D F52D  992C BC39 05F2 3517 9CF1
     Subkey fingerprint: 1BE2 C0FF 0894 9623 102F  D256 4695 881C 2545 08D1
Author: Petr Lautrbach <lautrbach@redhat.com>
Date:   Wed Dec 13 15:46:22 2023 +0100

    Update VERSIONs to 3.6 for release.
=20=20=20=20
    Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>


# gpg2 --fingerprint --verify checkpolicy-3.6.tar.gz.asc checkpolicy-3.6.ta=
r.gz
gpg: Signature made Wed Dec 13 14:47:30 2023 UTC
gpg:                using RSA key 1BE2C0FF08949623102FD2564695881C254508D1
gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owne=
r.
Primary key fingerprint: B868 2847 764D F60D F52D  992C BC39 05F2 3517 9CF1
     Subkey fingerprint: 1BE2 C0FF 0894 9623 102F  D256 4695 881C 2545 08D1



>
>
> On Wed, 2023-12-13 at 17:09 +0100, Petr Lautrbach wrote:
>> Petr Lautrbach <lautrbach@redhat.com> writes:
>>=20
>> Ups.
>>=20
>> It 3.6 release, not 3.6-rc2
>>=20
>>=20
>>=20
>> > Hello!
>> >=20
>> > The 3.6 release for the SELinux userspace is now available at:
>> >=20
>> > https://github.com/SELinuxProject/selinux/wiki/Releases
>> >=20
>> > Thanks to all the contributors, reviewers, testers and reporters!
>> >=20
>> > User-visible changes
>> > --------------------
>> >=20
>> > * dispol: add option to display users, drop duplicate option to
>> > display booleans,
>> > =C2=A0 show number of entries before listing them
>> >=20
>> > * libsepol: struct cond_expr_t `bool` renamed to `boolean`
>> > =C2=A0 The change is indicated by COND_EXPR_T_RENAME_BOOL_BOOLEAN macro
>> >=20
>> > * cil: Allow IP address and mask values to be directly written
>> >=20
>> > * cil: Allow paths in filecon rules to be passed as arguments
>> >=20
>> > * Add not self support for neverallow rules
>> >=20
>> > * dispol: Add the ability to show booleans, classes, roles, types
>> > and type attributes of policies
>> >=20
>> > * Improve man pages
>> >=20
>> > * libselinux: performance optimization for duplicate detection
>> >=20
>> > * dismod: add options: --actions ACTIONS, --help
>> >=20
>> > * dispol: add options: --actions ACTIONS, --help
>> >=20
>> > * checkpolicy: Add the command line argument -N, --disable-
>> > neverallow
>> >=20
>> > * Introduce getpolicyload - a helper binary to print the number of
>> > policy reloads on the running system
>> >=20
>> > * man pages: Remove the Russian translations
>> >=20
>> > * Add notself and other support to CIL
>> >=20
>> > * Add support for deny rules
>> >=20
>> > * Translations updated from
>> > =C2=A0 https://translate.fedoraproject.org/projects/selinux/
>> >=20
>> > * Bug fixes
>> >=20
>> > Development-relevant changes
>> > ----------------------------
>> >=20
>> > * ci: bump Fedora to version 39
>> >=20
>> > * Drop LGTM.com and Travis CI configuration
>> >=20
>> > Shortlog of the changes since 3.5 release
>> > -----------------------------------------
>> > Bruno Victal (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc: Use versioned DocBook public id=
entifier.
>> >=20
>> > Cameron Williams (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add CPPFLAGS to Makefiles
>> >=20
>> > Cathy Hu (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy/manpage.py: make output determ=
inistic
>> >=20
>> > Christian G=C3=B6ttsche (115):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Add not self support for neve=
rallow rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add not-self neverallow su=
pport
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: add tests for not self =
neverallow rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: add tests for minus sel=
f neverallow rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: rename struct member
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: update cond_expr_t struct =
member name
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: rename bool indentifiers
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: rename bool identifiers
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: rename bool identifiers
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage/tests: rename bool identifi=
ers
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: fix memory leak in semanag=
e_user_roles
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dispol: add output functions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: set CFLAGS for pip installa=
tion
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: drop unused token CLONE
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: reject condition with bool=
 and tunable in
>> > expression
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: only set declared permissi=
on bits for wildcards
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: dump non-mls validatetrans ru=
les as such
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate some object contexts
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate old style range tran=
s classes
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: check low category =
is not bigger than
>> > high
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: reject XEN policy w=
ith xperm rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: skip invalid cat
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: drop message for uncommon err=
or cases
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: drop duplicate newline in sep=
ol_log_err() calls
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: replace sepol_log_err() by ER=
R()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: replace log_err() by ERR()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add option to skip checkin=
g neverallow rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dismod: misc improvements
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: free initial sid names
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: check for overflow in put_ent=
ry()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/fuzz: more strict fuzzing of b=
inary policies
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setsebool: improve bash-completion scri=
pt
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setsebool: drop unnecessary linking aga=
inst libsepol
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_expand: update
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_link: update
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_package: update
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_unpackage: update
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: introduce getpolicylo=
ad
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate: use fixed sized int=
egers
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hashtab: update
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: use identical type to=
 avoid implicit
>> > conversion
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: expand: check for memory allo=
cation failure
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: ebitmap: avoid branches for i=
teration
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage/tests: use strict prototypes
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: update CIL generation for tri=
vial not-self rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: update selabel_partia=
l_match
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: misc label cleanup
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: drop obsolete optimization =
flag
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: drop unnecessary warning ov=
errides
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setfiles: do not issue AUDIT_FS_RELABEL=
 on dry run
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: constify selabel_cmp(3) par=
ameters
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: simplify zeroing allocation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: use type safe union a=
ssignment
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: avoid regex serialization t=
runcations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: parameter simplifications
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: use correct type for =
backend argument
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update string_to_mode()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: fix logic for building andr=
oid backend
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: avoid unused function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: check for stream rewind fai=
lures
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: simplify internal selabel_v=
alidate prototype
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: drop include of inter=
nal header file
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: free elements on read_spec_=
entries() failure
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: set errno on label lookup f=
ailure
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject avtab entries with inv=
alid specifier
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avtab: check read counts for =
saturation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: add round-trip tests
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux/utils: update getdefaultcon
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: cast to unsigned char for c=
haracter handling
>> > function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: introduce reallocarray(3)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate default type of tran=
sition is not an
>> > attribute
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate constraint depth
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: more strict validation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject unsupported policy cap=
abilities
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use str_read() where appropri=
ate
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: adjust type for saturation ch=
eck
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: enhance saturation check
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate the identifier for i=
nitials SID is valid
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop LGTM.com configuration
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop Travis CI configuration
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: ignore unavailable interpreters
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci: bump Fedora to version 39
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update Python binding
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update Python installation on Debian
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: update run-scan-build
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule_link: avoid NULL dereference o=
n OOM
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: set number of target names
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: fix memory leak in customiz=
able_init()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid leak in OOM branch
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid memory corruption on re=
alloc failure
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: update policy capabilities ar=
ray
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 github: bump action dependencies
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate common classes have =
at least one
>> > permissions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: include length squared in has=
htab_hash_eval()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use DJB2a string hash function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: use DJB2a string hash fun=
ction
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: use DJB2a string hash funct=
ion
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newrole: use DJB2a string hash function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid fixed sized format buff=
er for xperms
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid fixed sized format buff=
er for xperms
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate conditional type rul=
es have a simple
>> > default type
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: use correct type to avoid tru=
ncations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dismod: avoid duplicate ini=
tialization and fix
>> > module linking
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject invalid class datums
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/fuzz: handle empty and non ker=
nel policies
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: reject linking modules with n=
o avrules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: simplify string formatting
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy/dispol: misc updates
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: constify tokenized input
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: avoid integer overflow in add=
_i_to_a()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: extended permission formattin=
g cleanup
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: validate empty common classes=
 in scope indices
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: update const qualifier of p=
arameters in man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: always set errno on context=
 translation failure
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: state setexecfilecon(3) set=
s errno on failure
>> >=20
>> > Dominick Grift (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: fixes filecon example
>> >=20
>> > Huaxin Lu (4):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: add check for calloc in che=
ck_booleans
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: add check for strdup in st=
rings_list_add
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc: add check for malloc in secilc
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: add check for category value =
before printing
>> >=20
>> > Huizhao Wang (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: compatible with the use of=
 EUID
>> >=20
>> > James Carter (53):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol/cil: add support for p=
refix/suffix filename
>> > transtions to CIL"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: add prefi=
x/suffix support to
>> > module policy"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: add prefi=
x/suffix support to
>> > kernel policy"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol: implement new module =
binary format of
>> > avrule"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "libsepol: implement new kernel =
binary format for
>> > avtab"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move file=
name transition rules
>> > to avrule"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move file=
name transitions to
>> > avtab"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "checkpolicy,libsepol: move tran=
sition to separate
>> > structure in avtab"
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Fix class permission veri=
fication in CIL
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Use isinstance() instead of typ=
e()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Remove the Russian transla=
tions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gui: Remove the Russian translations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Remove the Russian translat=
ions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Remove the Russian translat=
ions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: Remove the Russian transla=
tions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Remove the Russian translatio=
ns
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcstrans: Remove the Russian translatio=
ns
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policycoreutils: Remove the Russian tra=
nslations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Remove the Russian translations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Remove the Russian translations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restorecond: Remove the Russian transla=
tions
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox: Remove the Russian translations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semodule-utils: Remove the Russian tran=
slations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Do not automatically install Russian tr=
anslations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Changes to ebitmap.h to fix c=
ompiler warnings
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Do not call ebitmap_init =
twice for an ebitmap
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add notself and other sup=
port to CIL
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Use ERR() instead of log_err()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Add notself and other keyw=
ords to CIL
>> > documentation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/test: Add notself and other tests
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Parse and add deny rule t=
o AST, but do not
>> > process
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_list_is_empty mac=
ro
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_tree_node_remove =
function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Process deny rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add cil_write_post_ast fu=
nction
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Export the cil_write_post_ast=
 function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/secil2tree: Add option to write =
CIL AST after post
>> > processing
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/test: Add deny rule tests
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Add deny rule to CIL docum=
entation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Remove support for role do=
minance rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: Fix the version number for th=
e latest exported
>> > function
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/tests: Update the order of nev=
erallow test results
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Use struct cil_db * inste=
ad of void *
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Refactor and improve hand=
ling of order rules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Allow IP address and mask=
 values to be directly
>> > written
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Update syntax for IP addre=
sses and nodecon
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Refactor Named Type Trans=
ition Filename
>> > Creation
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Allow paths in filecon ru=
les to be passed as
>> > arguments
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 secilc/docs: Fix and update the documen=
tation for macro
>> > parameters
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Add pointers to datums to=
 improve writing out
>> > AST
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Give warning for name tha=
t has different flavor
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Do not allow classpermiss=
ionset to use
>> > anonymous classpermission
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: Clear AST node after dest=
roying bad filecon
>> > rule
>> >=20
>> > Jeffery To (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Fix get_os_version exc=
ept clause
>> >=20
>> > Juraj Marcin (8):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move transition t=
o separate structure
>> > in avtab
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move filename tra=
nsitions to avtab
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: move filename tra=
nsition rules to
>> > avrule
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: implement new kernel binary f=
ormat for avtab
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: implement new module binary f=
ormat of avrule
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: add prefix/suffix=
 support to kernel
>> > policy
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libsepol: add prefix/suffix=
 support to module
>> > policy
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol/cil: add support for prefix/su=
ffix filename
>> > transtions to CIL
>> >=20
>> > Masatake YAMATO (10):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: add --help option
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: delete an unnecessary empty line
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: handle EOF in user interaction
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: add --actions option for non-in=
teractive use
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: add --help option
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: delete an unnecessary empty line
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: handle EOF in user interaction
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispol: add --actions option for non-in=
teractive use
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod: print the policy version only i=
n interactive mode
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dismod, dispol: reduce the messages in =
batch mode
>> >=20
>> > Ondrej Mosnacek (4):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: include more parameters in=
 the module checksum
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts/ci: install rdma-core-devel for=
 selinux-testsuite
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: stop translating deprecated i=
ntial SIDs to strings
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsepol: add support for the new "init=
" initial SID
>> >=20
>> > Petr Lautrbach (9):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: improve format strings for prop=
er localization
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Drop hard formating from locali=
zed strings
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 semanage: Drop unnecessary import from =
seobject
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: update python.pot
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update translations
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6-rc1 for release.
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6-rc2 for release.
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy: port to dnf4 python API
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update VERSIONs to 3.6 for release.
>> >=20
>> > Sergei Trofimovich (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libsemanage: fix src/genhomedircon.c bu=
ild on `gcc-14` (`-
>> > Werror=3Dalloc-size`)
>> >=20
>> > Stephen Smalley (2):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux,policycoreutils,python,semod=
ule-utils: de-brand
>> > SELinux
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy,libselinux,libsepol,policyc=
oreutils,semodule-
>> > utils: update my email
>> >=20
>> > Topi Miettinen (1):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sepolicy: clarify manual page of sepoli=
cy interface
>> >=20
>> > Vit Mojzis (12):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/chcat: Improve man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/audit2allow: Add missing options=
 to man page
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/semanage: Improve man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/audit2allow: Remove unused "debu=
g" option
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policycoreutils: Add examples to man pa=
ges
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Improve man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox: Add examples to man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checkpolicy: Add examples to man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: Add examples to man pages
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Fix template for confi=
ned user policy
>> > modules
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python/sepolicy: Add/remove user even w=
hen SELinux is
>> > disabled
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python: Harden more tools against "rogu=
e" modules
>> >=20
>> > wanghuizhao (3):
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: migrating hashtab from poli=
cycoreutils
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: adapting hashtab to libseli=
nux
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libselinux: performance optimization fo=
r duplicate detection
>>=20
>>=20
>
> --=20
> Cathy Hu <cahu@suse.de>
> SELinux Security Engineer
> GPG: 5873 CFD1 8C0E A6D4 9CBB F6C4 062A 1016 1505 A08A
>
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146
> 90461 N=C3=BCrnberg
>
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich
> (HRB 36809, AG N=C3=BCrnberg)

