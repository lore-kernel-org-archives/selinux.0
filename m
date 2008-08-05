Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75EWMZE018699
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:32:22 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m75EWLSF022532
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 14:32:21 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: "Xavier Toth" <txtoth@gmail.com>
Subject: Re: Question about newrole
Date: Tue, 5 Aug 2008 22:32:03 +0800
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
References: <200808052155.18105.linuxweb@gmx.net> <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>
In-Reply-To: <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1247261.RzYyUzpRGc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808052232.03624.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart1247261.RzYyUzpRGc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks.
That seems to help quite a bit.
I now get some messages. For example it seems that newrole wants to=20
read /etc/shadow directly.
Will check those messages and play around with the policy.

On Tuesday 05 August 2008 22:17:19 Xavier Toth wrote:
> On Tue, Aug 5, 2008 at 8:55 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
> > Hi folks,
> >
> > I'd like to ask about a problem I am experiencing with newrole.
> > When I use newrole in permissive-mode I have no problems changing the
> > role. Also I don't get any audit-messages.
> > But when I switch to enforcing-mode I cannot use newrole, it keeps
> > telling me "incorrect password for root", although it clearly is correc=
t.
> > I suspect a problem in interaction between newrole and unix_chkpwd, but
> > am not entirely sure about it.
> >
> > Problem is that I don't get any audits from SELinux, only errors in
> > auth.log from unix_chkpwd:
> > check_pass; user unknown
> > password check failer for user (root)
> >
> > I am working with the latest reference-policy, adjusted here and there =
to
> > fit the needs of my distro.
> >
> > Thanks for any suggestions.
> >
> > Dennis
>
> You can try using `semodule -DB` to turn off the dontaudits and see if
> you get any AVCs then.



--nextPart1247261.RzYyUzpRGc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYZGMACgkQ1sXw8/2VziRp1gCdFdMqP6EpEd7OUAJM7QdfyvuC
J80An3ysUyIYIfzWFgJaMNuif95Z3/0L
=2WVk
-----END PGP SIGNATURE-----

--nextPart1247261.RzYyUzpRGc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
