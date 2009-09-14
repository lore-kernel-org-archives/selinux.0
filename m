Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8E8JS3p022189
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 04:19:28 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8E8Ik5H020265
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 08:18:46 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n8E8JBWZ052093
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 10:19:11 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n8E8JAs0078270
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 10:19:11 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Mon, 14 Sep 2009 10:19:10 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090914081910.GL24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
 <20090908163628.GC24297@myhost.felk.cvut.cz>
 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
 <20090909100647.GE24297@myhost.felk.cvut.cz>
 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="asNXdz5DenlsLVVk"
In-Reply-To: <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--asNXdz5DenlsLVVk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Stephen Smalley wrote:
> The kernel MLS logic lives in security/selinux/ss/mls.c.  Determining
> the MLS level of a new subject or object is handled by
> mls_compute_sid().  Any change would have to support either model
> (inherit from source context or inherit from target context), so
> logically it would be policy-driven.  Which likely means an extension to
> the policy language and compiler.  Not an entirely trivial undertaking.

I have looked at the source code and it seems that in the said function
mls_compute_sid(), under the "case AVTAB_CHANGE:" and in the "else" path
(tclass != SECCLASS_PROCESS) the statement

mls_context_cpy_low(newcontext, scontext)

would need to be changed to

mls_context_cpy(newcontext, tcontext).

To support the original behavior, I would add a 1/0 readable/writable
file to selinuxfs, say "mls_defcontext_inherit" by mimicking the
behavior of the "enforce" file and its associated r/w functions. It
seems to me that this would suffice enough and it would avoid the need
to modify the policy language.

Would this change be acceptable?

Michal Svoboda

--asNXdz5DenlsLVVk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqt/H4ACgkQg/fU9pp1uX6m+wCgjW8B9SQ29RyaEpgU/LFT6q++
lj0AoKAFgITFqEehJbFVFJ+YJgofKDs0
=06wd
-----END PGP SIGNATURE-----

--asNXdz5DenlsLVVk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
