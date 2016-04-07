Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37LB5RB014622
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 17:11:05 -0400
Received: by mail-yw0-f193.google.com with SMTP id o63so13104076ywe.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Apr 2016 14:11:03 -0700 (PDT)
Date: Fri, 8 Apr 2016 00:10:56 +0300
From: "leon@leon.nu" <leon@leon.nu>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 09/13] ib/core: Enforce PKey security when
 modifying QPs
Message-ID: <20160407211056.GD12844@leon.nu>
Reply-To: leon@leon.nu
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-10-git-send-email-danielj@mellanox.com>
 <20160407163100.GA5808@leon.nu>
 <DB5PR05MB11113874870EBBE896E0D601C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
In-Reply-To: <DB5PR05MB11113874870EBBE896E0D601C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2016 at 09:02:43PM +0000, Daniel Jurgens wrote:
> On 4/7/2016 11:31 AM, Leon Romanovsky wrote:
> > On Thu, Apr 07, 2016 at 02:33:54AM +0300, Dan Jurgens wrote:
> >=20
> >> +	if (sec->qp =3D=3D sec->qp->real_qp) {
> >> +		/* The caller of this function holds the QP security
> >> +		 * mutex so this list traversal is safe
> >> +		*/
> >=20
> > Did the comment below pass checkpatch.pl?
>=20
> It did.
>=20
> >> +		list_for_each_entry(shared_qp_sec,
> >> +				    &sec->shared_qp_list,
> >> +				    shared_qp_list) {
> >=20
> > Is this list always needed to be protected by lock?
> > In general, I prefer to see lock/unlock operations near protected code.
> > Otherwise, it is hard to follow all lock/unlock paths.
>=20
> The mutex is required, and I'm not sure how to push it lower safely.
> Consider the situation where a QP is being modified concurrently with an
> open_shared_qp. Unless the lock is held the entire time for each
> operation open_shared_qp could check permission using a ib_qp_security
> struct in a partially modified state, i.e. there could be a mix of new
> and old settings for the port/pkey index/alternate path.  Shared QPs use
> the port and pkey setting for the underlying real QP with the shared qp
> q_security.

Common flow is to do everything in one place:
1. lock
2. check permissions
3. change
4. release lock

Your flow is much broader.
1. lock
2. check permission
3. do work
4. change
5. do work
6. release lock.

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBszgAAoJEORje4g2clinNKgP/0qMQlhd4RS6mCRkAXk+g0OO
2CkMZ6MqzsbtWAHI08dsXpOl/iX/ZH9yKLllwpLPGcRpBQFh2QX+nxg3Pj5gBw/P
QKrSyc9EEZUh1/cPWLMP0KWs03fbe3mqwTXWFYcEJNZwJRyIsd8qLYZgqUOuUnV6
Ty0g4MvSF6Wlf4uqflPHga5PSGgHSJl7yWk5kS208k1TJeEGph3CFxRmtMyZ+dXW
SKSJBanxvgT4yDWG3us45779GSvNyQ+n9wWtUFk7MQkRRj8wCRWsh50IIskpZ3pH
+/Y+T7l+cvqMBmrwKePgDOfhskEpH8cx3utdfdopNlNyFgdkPScw+F07Epmbb7si
d/THPslrUF/aOmTkoHluiVSTfZlrVuQ/Rul5XFIy1qTipg1zWnuXPE4u7x1uyFdH
sBVKO9z+yyg9YqVnMgyKcUPAB1tl++7lETT3I49HwoK0SnRfd/8s+OSpZ5em/hzo
fL/JfSy4/sPSuSEpMGPCxVTqkYflQs+dPj55hJQsvzb9PmPyDSWAMbJ4pbcuMNyD
gfufLMuGQljEe9LMdx50DdqXJdpv7wfygrbsNbFTLLqafTgUExxW6mrnC0121kjL
3eD4MrdJQEE8es+Be0LHSDBSRig0mRjScqmToFkhohRZYxWBEx7WJ7OY1j5cR2mH
613pczeUjTPpXAxePbFI
=mrD4
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
