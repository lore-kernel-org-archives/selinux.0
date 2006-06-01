Message-Id: <200606011452.k51Eqdl5003497@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>,
        Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux
In-Reply-To: Your message of "Thu, 01 Jun 2006 10:21:35 EDT."
             <1149171695.524.360.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1149161971.524.283.camel@moss-spartans.epoch.ncsc.mil> <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> <11225.1149156553@warthog.cambridge.redhat.com> <14858.1149164860@warthog.cambridge.redhat.com>
            <1149171695.524.360.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149173559_2836P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 01 Jun 2006 10:52:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1149173559_2836P
Content-Type: text/plain; charset=us-ascii

On Thu, 01 Jun 2006 10:21:35 EDT, Stephen Smalley said:

> Ok, given these considerations, I think we should just drop the unlink
> check for now, and proceed with the rest of the patch (modulo
> CodingStyle issues).

Should we put a note in Documentation/keys.txt to that effect?


--==_Exmh_1149173559_2836P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEfv83cC3lWbTT17ARAggVAKCUOZckPOR4Y1H3dTZjJXfFmZnBnACg+CwA
t87/dQWnVn8eDgs7/fn4fEs=
=N/U3
-----END PGP SIGNATURE-----

--==_Exmh_1149173559_2836P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
