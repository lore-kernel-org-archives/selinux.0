Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBF8I0LH006993
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 03:18:00 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBF8HwMa006181
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 08:17:59 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.4/8.14.4) with ESMTP id oBF8Hobp031318
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 09:17:50 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id oBF8JaIa060823
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 09:19:37 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 15 Dec 2010 09:17:49 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Unit testing userspace
Message-ID: <20101215081749.GF18729@myhost.felk.cvut.cz>
References: <4D067B2F.2050000@manicmethod.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
In-Reply-To: <4D067B2F.2050000@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Joshua Brindle wrote:
> to test is_selinux_enabled() you'd need to mock the fopen() and read()
> functions

You need to realize how much important mocking is. It's not about
mocking the system calls. Instead, it should be used rigorously in all
the tests.

Example: IMO the problem with is_selinux_enabled is that it tries to do
too much in one block of code. To effectively test all the paths through
that function you would get crazy in simulating the right conditions.

Now consider this variant instead:

int is_selinux_enabled(void) {
    if (is_selinux_filesystem_mounted()) {
        return !no_policy_loaded();
    }
    else {
        return 0;
    }
}

int is_selinux_filesystem_mounted() {
    return selinux_mnt || filesystem_detected_the_long_way();
}

int no_policy_loaded() {
    ... the stuff with getcon (notice it is currently duplicated)
}

...

Now each of those isn't too hard to test given you can mock the result
of the individual sub-functions! (And the logical or one liner is so
brutally simple & obvious that it even does not need any testing.)

Given this I would seriously consider a framework that gives this
ability, otherwise you are stuck with doing it manually through
#define's and that would seriously discourage people to unit-test. They
will black-box-test or integration-test instead which will not cover all
the nuances of the function logic and is likely to miss half of the
corner cases, improper assumptions, etc., ie. bugs.

Michal Svoboda


--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk0Iea0ACgkQg/fU9pp1uX75JgCeKXiIKL2I3cDS2RECPe+RANvj
vM4An3MWuClfjNLgNMClbopAbIPCuy0e
=gkgQ
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
