Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66EBXkl027370
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 10:11:33 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p66EBWuO026431
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 14:11:32 GMT
Received: by eyh5 with SMTP id 5so2608425eyh.12
        for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2011 07:11:32 -0700 (PDT)
Subject: Re: Best base policy to use
From: Dominick Grift <domg472@gmail.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 06 Jul 2011 16:11:16 +0200
In-Reply-To: <CAJstirRb7dTEpk0eq+xP_HNBwfEcZ4BF6ftXBrtDLT50JQktHg@mail.gmail.com>
References: 
	<CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
	 <1309932598.2498.28.camel@localhost.localdomain>
	 <CAJstirRb7dTEpk0eq+xP_HNBwfEcZ4BF6ftXBrtDLT50JQktHg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-t6QDV/6y8hf90VUe1qTI"
Message-ID: <1309961490.2323.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-t6QDV/6y8hf90VUe1qTI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2011-07-06 at 08:59 -0500, Jeremiah Jahn wrote:
> semanage  makes persistent changes to a system, correct?=20

correct

> I'm still uncertain of the best way to modify a module, or at least
> make one less permissive. would it be to remove or disable a module,
> get the source, modify it, rename it, and then import it over the old
> one?=20

That is one way yes but some modules depend on other modules so it may
get a bit more complicated than that.

Generally it becomes harder to maintain.

See my suggestion below

> for example lets say I didn't want rpm_script_t to be able to
> transition into initrc_t, no matter what role it started as. Or, I
> don't want the sysadm_t to be able to do both run_init_t and rpm_t. Or
> am I completely in left field and not understanding the proper use of
> roles?

No, you can achieve that by editing the policy i believe.

I would probably fork selinux policy. El6 policy does not get much
significant updates so merging changes into your fork should not be too
much work (as opposed to Fedora)


--=-t6QDV/6y8hf90VUe1qTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk4UbQQACgkQMlxVo39jgT+w7ACfYe56bpA/zqf0LLIQg33ChN6E
VYsAn0wRPdzjPxDzI6ot6xh93LrT1orc
=wuVy
-----END PGP SIGNATURE-----

--=-t6QDV/6y8hf90VUe1qTI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
