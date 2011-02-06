Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p16AqG1Y007151
	for <selinux@tycho.nsa.gov>; Sun, 6 Feb 2011 05:52:16 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p16AqFJO020796
	for <selinux@tycho.nsa.gov>; Sun, 6 Feb 2011 10:52:15 GMT
Received: by eyh6 with SMTP id 6so1804428eyh.12
        for <selinux@tycho.nsa.gov>; Sun, 06 Feb 2011 02:52:14 -0800 (PST)
Date: Sun, 6 Feb 2011 11:52:11 +0100
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Trouble logging in through SSH
Message-ID: <20110206105154.GA2626@localhost.localdomain>
References: <4D4C8A4C.1070101@mintsource.org>
 <4D4D0B63.8070509@mintsource.org>
 <4D4D5038.2090403@gmail.com>
 <4D4E69D0.50808@mintsource.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
In-Reply-To: <4D4E69D0.50808@mintsource.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2011 at 10:28:48AM +0100, Simon Peter Nicholls wrote:
> On 05/02/11 14:27, Dominick Grift wrote:
> >By the way, these policy related questions should go to
> >refpolicy@oss.tresys.com maillist.
>=20
> Hi Dominick, thanks for your replies to my issues.
>=20
> When I hit trouble, I thought I had hit something other than regular
> policy issues, but this was incorrect. I have missing
> access_vectors, and face some other issues (due to a combination of
> recent software and non-standard file locations), but all appear to
> be surmountable through a custom policy build.

Agreed, Implementation of reference policy always requires modification to =
some extend.
Although i believe that the access vectors that you seem to be missing shou=
ld have been included with the refrence policy you are using.

>=20
> I've learned a lot in a short time, thanks in large part to reading
> some key posts in this mailing list, and my system is firmly in the
> realm of policy tweaking now. Mostly I'm twiddling booleans and
> changing file contexts to match Arch Linux at this point, with cron
> and syslog-ng the only services with issues. My "semanage permissive
> -a" functionality is broken, as the "/var/lib/selinux" path I see
> hardcoded into semanage does not exist on my system, but it was no
> bother to hand code a permissive module to get my logging working
> for now. So I can run enforcing from boot whilst I finish up, no
> problem.
>=20

Yes maillist archives ave much information. Also agree that most work is mo=
difying the labelling specifation to match your distros requirements,

As for semanage permissive -a. This requires that policy for semanage is mo=
dified to allow semanage these permissions. Redhat has this semanage policy=
 modified but it is, i believe, not done in a acceptable way to reference p=
olicy, and so reference policy has not adopted redhats solution for this. T=
he /var/lib/selinux issue may be a packaging issue.=20

> It looks like Fedora have already addressed some of the core
> refpolicy issues I've faced (problems unrelated to Arch file
> locations), but patches had not made it upstream the last time I
> checked. I'd also like to see a passenger module make it into
> refpolicy. So, I still have some outstanding refpolicy queries,
> which I'll take over to the mailing list you mention.

You can indeed borrow some of redhats solutions. Some of it is not acceptab=
le for reference policy though because it breaks policy/toolchain.
As for passenger, i started work on a module for ruby on rails and passenge=
r but i was not able to finish it. Redhat is using what i have for inspirat=
ion for a passenger policy that they are working on. So that might show up =
in the near future.

> Thanks again.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk1OfVcACgkQMlxVo39jgT+ZLgCeLC3r46/gCm/Z7ewMw4nbzEXQ
snQAn3b7B5yG6fYOpOOjUqNDqtdZFnVj
=OAul
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
