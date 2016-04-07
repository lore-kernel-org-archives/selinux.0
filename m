Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u372rTZh004708
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 22:53:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id h6so6966622ywc.1
 for <selinux@tycho.nsa.gov>; Wed, 06 Apr 2016 19:53:27 -0700 (PDT)
Date: Thu, 7 Apr 2016 05:53:14 +0300
From: Leon Romanovsky <leon@leon.nu>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Subject: Re: [RFC PATCH v2 08/13] ib/core: IB cache enhancements to support
 Infiniband security
Message-ID: <20160407025314.GA20789@leon.nu>
Reply-To: leon@leon.nu
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-9-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1459985638-37233-9-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2016 at 02:33:53AM +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>=20
> Cache the subnet prefix and add a function to access it. Enforcing
> security requires frequent queries of the subnet prefix and the pkeys in
> the pkey table.
>=20
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
> ---
>  drivers/infiniband/core/cache.c     |   36 +++++++++++++++++++++++++++++=
+++++-
>  drivers/infiniband/core/core_priv.h |    3 ++
>  include/rdma/ib_verbs.h             |    1 +
>  3 files changed, 39 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index cb00d59..83cf528 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -925,6 +925,26 @@ int ib_get_cached_pkey(struct ib_device *device,
>  }
>  EXPORT_SYMBOL(ib_get_cached_pkey);
> =20
> +int ib_get_cached_subnet_prefix(struct ib_device *device,
> +				u8                port_num,
> +				u64              *sn_pfx)
> +{
> +	unsigned long flags;
> +	int ret =3D 0;

It is not needed, just return 0 directly.

> +	int p =3D port_num - rdma_start_port(device);
> +
> +	if (port_num < rdma_start_port(device) ||
> +	    port_num > rdma_end_port(device))
> +		return -EINVAL;
> +
> +	read_lock_irqsave(&device->cache.lock, flags);
> +	*sn_pfx =3D device->cache.subnet_prefix_cache[p];
> +	read_unlock_irqrestore(&device->cache.lock, flags);
> +
> +	return ret;
> +}

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBcuaAAoJEORje4g2clinF9UQAI6k38W0TaLAWF1fCH6rOphY
9VvaJ1SA74/eNyUgxlHWoQHbOF2anw33r3yVhMMaW71WR8ZsZHOcHBYy1ZZhfOjF
xWFS7vsmf42UTSALdqzhNpgezbcbaNMGtcRL3T4gZj82lPnMePnyeCL/1hO26cwo
0qDKvLA013/MAU6HMk6y2XXyJ2/x+PF8YfEfwfRRBo1W5LL6HLkIZLHJwTDIkrtW
fW1Yl1wXGN5crUbfJDwLPrpqCIpsG+LG2jlKFtkV5HlZUtX9nObHnyk84iJDhGlY
K7NpWKDkM2cCMxlAPhUyWKzI99EHSOO5s+MWB4ZKZxM8NgSMqamOzIpZH55DNIRl
COln528I9TR2zGeExT1/YIJh9/oql2ywxnr4GxHpNDpfisPiAzI+mAkgjR5SPXmx
Pdg93DKliIsK4sObpyhDaHQVOYB3LuM4SkeVvOdunyrKlKWrPro0zPfuokkvnBFy
Z7LesirOJKfM9j2isOp48UL09dWALlW0OZzPLDdl6PlGAG9tENODTYwLlmaKuEWI
q784aYIwqNz/96sDv53wcdNMhokhUu6Fl7bikxnqjnVF3K7KmW1g2HMrIuBhNIfY
+bYGOB8JvxbDLrRal3ElhtsusZv3Gotn44l74CC4BPz5oKAwOWw8V1/k8sC9+8b/
WjhViFn3bQpr8YMcO9Zq
=3+4P
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
