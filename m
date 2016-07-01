Date: Fri, 1 Jul 2016 23:48:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH 02/12] selinux: Create policydb version for Infiniband
 support
Message-ID: <20160701204813.GE4750@leon.nu>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-3-git-send-email-danielj@mellanox.com>
 <20160630150140.GB22107@yuval-lap.uk.oracle.com>
 <20160701125043.GD4750@leon.nu>
 <DB6PR0501MB2261C7D467873122250A1F3EC4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
In-Reply-To: <DB6PR0501MB2261C7D467873122250A1F3EC4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2016 at 01:49:49PM +0000, Daniel Jurgens wrote:
> On 7/1/2016 7:50 AM, Leon Romanovsky wrote:
> > On Thu, Jun 30, 2016 at 06:01:42PM +0300, Yuval Shaia wrote:
> >> On Thu, Jun 23, 2016 at 10:52:48PM +0300, Dan Jurgens wrote:
> >>
> >>>  				if (rc)
> >>>  					return rc;
> >>>  				break;
> >>> +			case OCON_PKEY: {
> >> Is "{" needed?
> > No, I agree, need to remove.
> The { is needed here, unless the variable sbn_pfx is defined at function =
scope.

Daniel,
It will be better to avoid this one time variable, it doesn't add too
much benefit to the code.

> >
> >>> +				__be64 *sbn_pfx =3D (__be64 *)nodebuf;
> >>> +				*sbn_pfx =3D cpu_to_be64(c->u.pkey.subnet_prefix);
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXdtcNAAoJEORje4g2clinUpoP/i+enYWCUrV9WSZaF8X0z0zz
0Wnxr2U8hVvl72ozEiWECU/47XZDt9wfrY5difl50xRaTny2q1ilJekvTZiEwXSm
tjxG6u+TziMau/P0FDtSF7wa1/zqRmYdDCl7ImUg5DNMPZ8+lVWrC5IgKBzmKKjG
CTrzUGrSJbwq2Y2f3WSMZ5fcBoFnKVoyCeyvfnSBRe2fh2s+1LBjah+1d4+g6Bpk
fGeAL+r5iHoho7JRUEaDZprnRTfSLkXsAXdzkDfrVaizGrMdZZgLjsTv1iRDVYxL
AS97jdhz1eEuknc4+ipWIW8NL122pnIA/iIXEkkl79/+jFz18soJpFP3efLCXwDH
LdukFmHv+O8AaJ9AZRfXMRXrAARizKtM9R5IGoxZADe5/Vc9JXXavP2A8jk5KIUz
7XW+QiFV4u8u/GIc4lvaLEX3CeD+et5bc6/JUizZX8bDusuyuV5ujkRsrQgcu8/O
Zw/KQEWbVZhzPMJ5RQSY6sjVaLW+Z2LszG8kbclKhoObvFcsthI9/qcN2vTix1ts
cY1iMgjptTVaFXHzkmjb5Y1plr7OhlL4cFm11YhHZYXQDgyEd2CK9J/O/h01V6+a
7s2DQmRXPwxaRELQUE5yYQ0f+dZoDvz4gm2OroMYRjZjnMNk4POnRtyt8GdDnzhQ
AwuTAJDkGgTFZjbqmDAG
=EmnS
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
