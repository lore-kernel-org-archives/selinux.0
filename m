Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBGAF3Ns007361
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 05:15:03 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBGAF1NH003839
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 10:15:02 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.4/8.14.4) with ESMTP id oBGAEtjm044671
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 11:14:55 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id oBGAGWTR022028
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 11:16:32 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 16 Dec 2010 11:14:53 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: type bounds for files?
Message-ID: <20101216101452.GB1975@myhost.felk.cvut.cz>
References: <20101215203720.GH18729@myhost.felk.cvut.cz>
 <4D095C98.5050106@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
In-Reply-To: <4D095C98.5050106@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

KaiGai Kohei wrote:
> > Is this a known behavior? What is the sense in typebounding file types?
> Yes, it is known. We had a similar discussion before:
>   http://marc.info/?l=selinux&m=126771862818496&w=2

I see. Unfortunately the selinux symposium pdf link at the end of the
message is broken. Do you have another link to that file?

I have also a few questions. Suppose that
 1) dom_A bounds dom_B
 2) file_A bounds file_B
 3) dom_A has a set of rights S1 for file_A
 4) dom_B has a set of rights S2 for file_B

What is then the resulting masked set for dom_B wrt file_B? S1 cap S2?

And does this principle (how?) extend to chained bounds (ie. A bounds B
which in turn bounds C).

And does it (semantically or otherwise) matter what kind of file_type
the file_A is? For example, is 'typebound tmp_t file_B' the same as
'typebound http_user_data_t file_B'?

Michal Svoboda

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk0J5pwACgkQg/fU9pp1uX4YiACeJ2QubEbqH6GcpyPlQhceDVkX
2ZoAoK3gKby729y5EpQsc4LJ7M2tjJFN
=+6M4
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
