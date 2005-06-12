Message-Id: <200506121234.j5CCYt4G009234@turing-police.cc.vt.edu>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sat, 11 Jun 2005 19:16:11 PDT."
             <20050612021611.94597.qmail@web51501.mail.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20050612021611.94597.qmail@web51501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118579693_5642P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 12 Jun 2005 08:34:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118579693_5642P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Jun 2005 19:16:11 PDT, Park Lee said:
> If we use OpenSSH, Does it mean that we should send
> the data and its security attribute (e.g. sensitivity
> and clearance information of the data) together within
> a packet?

That of course depends on whether the protocol you're trying to secure requires
labelling each packet, or whether labelling a connection at setup is
sufficient.  This is similar, but subtly different, from the distinction
between UDP and TCP - if you're doing NFS over TCP, you still need to pass
security attributes along with each transaction...

Not that I'd actually *recommend* using OpenSSH for this - I gave it as an
example of something that *theoretically* provided low-level primitives
(basically, the ability to open up a tunnel and have some crypto protecting
against eavesdroppers and verifying the other end's identity).

OpenSSH and OpenSSL *both* suffer from the very real *practical* problem
that their connections terminate in userspace, while IPsec terminates
connections in the kernel.  While this is *not* an issue for the class of
problems that OpenSS[HL] were designed to address, it's got some *major*
issues when trying to build an MLS system out of it.

By the time you'd finish beating up the code for something else, it would look
an awful lot like IPSec *anyhow*....

> and Is there any other way to send security attribute
> first and then the date (just like in IPsec case)
> except using IPsec?

Are there any other ways? Sure.

Are there any other *reasonable* ways? Probably not.

You *could* go and write your own protocol and code to handle it and test it
and get other cryptographers to double-check your work and make sure you did
it right - or you can do what any *reasonable* programmer would do and use
the already provided and tested IPSec code. ;)



--==_Exmh_1118579693_5642P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrCvtcC3lWbTT17ARAsoyAJ0Y7Dhv55VkxY5yrluTFHIfP2FKEgCgt/72
smfSYYQs5ybQSjJWY62iU3E=
=Y4mK
-----END PGP SIGNATURE-----

--==_Exmh_1118579693_5642P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
