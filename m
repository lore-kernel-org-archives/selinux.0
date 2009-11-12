Date: Thu, 12 Nov 2009 12:47:09 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux@tycho.nsa.gov
Subject: Re: MCS read only cats
Message-ID: <20091112114709.GS28630@myhost.felk.cvut.cz>
References: <C72056E1.AFD7E%csellers@tresys.com>
 <200911121413.31687.russell@coker.com.au>
 <20091112075857.GO28630@myhost.felk.cvut.cz>
 <200911122213.49287.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gIHggtDV96iaw8wO"
In-Reply-To: <200911122213.49287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gIHggtDV96iaw8wO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Russell Coker wrote:
> That will work too.  Lots of things will work, you just have to decide
> which is most appropriate given your security goals.  If anyone has
> given much thought to implementing read-only files with MCS they don't
> seem to have written about it publicly, so this is all new.

Okay then I will implement this and see how it works.

> One Unix UID can have multiple SE Linux contexts.  The mapping of Unix
> account name to UID doesn't have to be 1:1.  But if you have multiple
> Unix accounts with the same UID then tools start to break.

Uh. They may not break that much but it will still give those people 2
accounts to use, be it usernames or selinux users; the UID is the least
relevant here. In fact, the beauty of MCS is that I could map everyone
to UID 0 and data access protection would still work as expected. Some
apps tend to derive usernames for audit purposes from getuid(), though,
so that would be a minor annoyance.

> Another possibility to consider is to give some file types an
> exclusion for read checks in the constraints.  That would mean that
> anyone could read them if the TE rules permit but MCS levels constrain
> write access.

Fair enough, but actually I need to provide three levels of access,
"none", "read only" and "full". The low/high range trick works here, but
I wonder if it would still be applicable if I wanted for example to add
a "create and append only" in between.

Michal Svoboda

--gIHggtDV96iaw8wO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr79bwACgkQg/fU9pp1uX6gZwCfXWb5qVV5+nALWw4gD9UcwFj2
SPsAoKC+t0wf9tGrGQ2h77+qajSy339Y
=eHxO
-----END PGP SIGNATURE-----

--gIHggtDV96iaw8wO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
