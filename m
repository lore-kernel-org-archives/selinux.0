Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8F6WskM026276
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 02:32:55 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8F6YH5G025938
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 06:34:18 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n8F6WiIi043040
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 08:32:44 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n8F6WhJt076708
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 08:32:44 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 15 Sep 2009 08:32:42 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090915063242.GM24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
 <20090908163628.GC24297@myhost.felk.cvut.cz>
 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
 <20090909100647.GE24297@myhost.felk.cvut.cz>
 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
 <20090914081910.GL24297@myhost.felk.cvut.cz>
 <1252930803.13634.1002.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
In-Reply-To: <1252930803.13634.1002.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Stephen Smalley wrote:
> I don't think so - the problem with selinuxfs tunables is that they
> can't be changed atomically with a policy change, and this is a property
> that should be tied to a particular policy.  For the same reason,
> properties like handle_unknown and permissive domains are defined in the
> policy itself rather than being selinuxfs tunables.

There have been things like compat_net, why can't the inheritance be
done on the same basis and must be part of the policy instead?

Anyway, I've been looking at the policy loader code, and it seems that
the easiest way to incorporate this into the policy would be to blend it
with the config field (which is presently used for MLS and
handle_unknown flags), perhaps by defining a flag like CATEGORY_INHERIT
and to check for it right after ALLOW_UNKNOWN and REJECT_UNKNOWN are
processed. This flag would then go to struct policydb and would be
checked for in the mls_compute_sid function (I can see direct usage of
the policydb global variable in that very function, so I guess it
shouldn't be a problem).

Perhaps there could also be an upgrade of the policy version number and
a check for the policy being loaded just to prevent random values being
present in that bit.

There would also need to be a change in libsepol and checkpolicy to
reflect this; perhaps checkpolicy could accept an additional command
line argument (as it does with handle_unknown), and a new field defined
in libsepol's policydb_t and further processed in its write.c.

Michal Svoboda

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqvNQoACgkQg/fU9pp1uX6mZwCfaqb9LFxHTM//rX7Sb1dauQNx
HWAAoLZ/wGVLXcOjdz9r1+EnZnpN2MJp
=CY+e
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
