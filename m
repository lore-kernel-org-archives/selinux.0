Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1BD1HGe003090
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 08:01:17 -0500
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n1BD1GAP023186
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 13:01:16 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: Dominick Grift <domg472@gmail.com>
Subject: Re: Question about su
Date: Wed, 11 Feb 2009 21:01:02 +0800
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200902111650.39754.linuxweb@gmx.net> <1234349196.13112.16.camel@notebook1.grift.internal>
In-Reply-To: <1234349196.13112.16.camel@notebook1.grift.internal>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1378070.JT2zXBiYj3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200902112101.05913.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart1378070.JT2zXBiYj3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks. This info helped a lot.
So user_u is for regular users that are just supposed to do stuff with what=
=20
the system offers. Anything else, like installing stuff is loaded off to us=
ers=20
that are at least staff_u or above.

It's something one has to get used to, especially the part of newrole-ing=20
first and afterwards using su.

On Wednesday 11 February 2009 18:46:36 Dominick Grift wrote:
> On Wed, 2009-02-11 at 16:50 +0800, Dennis Wronka wrote:
> > What use is su if a normal user after running su is still
> > user_u:user_r:user_t and thus has no permissions to do stuff?
>
> user_t is an unprivileged user domain.
>
> > Sure, he's root, but as because of SELinux that alone isn't worth much,
> > as being user_u still limits the user's options pretty much.
>
> user_t should not use root. user_t is confined to this domain. It is not
> designed to "user" domain transition.
>
> > Is there anything I misunderstand here? I don't think there should be an
> > automtic transition from user_r to sysadm_r, and newrole-ing this doesn=
't
> > work as user_u doesn't have the sysadmin-role.
>
> staff_t is the domain that can use root by first running newrole -r
> sysadm_r and then su.
>
> > So, what the heck is the use of su on a SELinux-system?
>
> It works but just not for user_t. Map users that should be able to
> "user" domain transition to privileged roles to the staff_u SELinux user
> group.
>
> hth ,Dominick
>
> > Thanks and best regards,
> > Dennis
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.


--nextPart1378070.JT2zXBiYj3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmSzBEACgkQ1sXw8/2VziSQtACggWitnhtbfjk54mO5+7mq415n
BAsAnijBB5nYGZNcx9wYuKyWp0euhI+9
=pKnr
-----END PGP SIGNATURE-----

--nextPart1378070.JT2zXBiYj3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
