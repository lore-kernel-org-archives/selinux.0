Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v646YgY3019283
 for <selinux@tycho.nsa.gov>; Tue, 4 Jul 2017 02:34:42 -0400
Date: Tue, 4 Jul 2017 09:34:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Dan Jurgens <danielj@mellanox.com>, dan.carpenter@oracle.com,
 dledford@redhat.com, selinux@tycho.nsa.gov, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Subject: Re: [PATCH] IB/core: Fix static analysis warning in
 ib_policy_change_task
Message-ID: <20170704063435.GA1528@mtr-leonro.local>
References: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhQcSfuMxZoAiTW8c-MNf6m0gLk_xArC7HkjR+5ZJgtgPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <CAHC9VhQcSfuMxZoAiTW8c-MNf6m0gLk_xArC7HkjR+5ZJgtgPA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 03, 2017 at 07:03:54PM -0400, Paul Moore wrote:
> On Fri, Jun 30, 2017 at 11:15 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> > From: Daniel Jurgens <danielj@mellanox.com>
> >
> > ib_get_cached_subnet_prefix can technically fail, but the only way it
> > could is not possible based on the loop conditions. Check the return
> > value before using the variable sp to resolve a static analysis warning.
> >
> > Fixes: 8f408ab64be6 ("selinux lsm IB/core: Implement LSM notification
> > system")
> > Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/infiniband/core/device.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 631eaa9..dabd9f9 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -376,7 +376,8 @@ static void ib_policy_change_task(struct work_struct *work)
> >                         WARN_ONCE(ret,
> >                                   "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
> >                                   ret);
> > -                       ib_security_cache_change(dev, i, sp);
> > +                       if (ret)
>
> Should this be "if (!ret)"?

You are right, It should.

Thanks

>
> > +                               ib_security_cache_change(dev, i, sp);
> >                 }
> >         }
> >         up_read(&lists_rwsem);
>
> --
> paul moore
> www.paul-moore.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAllbNvsACgkQ5GN7iDZy
WKftRA/+LDnqyAdcldRnkQa//Lp0m17QoAVLRo3OQyIhQO7oZ22CaBJkXZ7JdibU
jCgYxPMFIlqle63irLn/T0k3zwpBJ3WpX6q30dCqrVIiGP8mRkQNwZvxd3FLUaqK
b5VO6LLJWkCoWBaZ/yV4c9BIwUuNO4185S2VsV9tA8kFrUmCxlSx6BNBBCJqR9Xn
U11vdUFE7qEwfq+8Vviz1eJ3kBXKXvqBBrTXm6DfUzLxZxna9VooOYSxijt1goil
ztNvArUc81z8mqS+1JBHbEtXFPtV+ifh0iLqjrmrSpy3E5BnAGC847N4KzeMFlfr
hvJbkMWRMsTy+FnOFtlxK3m1c8x3MCniHMEcC44HHWBYvk+wc7HAmYAdzYAZxNbq
mlon/SZIjfxnWpWmitcYoRpY6TDjq8BH3H+BcP42MNJwA5doYlbzzup8E1kbRR1z
9TvvIRVtCsbVmWksNB/qxN4510n7rsio23sDu1Fm/J23PNNI3GmLFfGY7/Z+SXdc
mcuOVxQGr2qD5K7rOKPBCnerwDBcZy0kqOpHF2CpwTRV5Y9s3jPa9FcDr13lxN9l
B7gFF8MykRD4oSsTM1xc6tTyo7d9xmXSLWUDGupHVxETsFLbJrgg1k2lAh9SLnAT
uHWoxxJS3z7yLRz05GhPecay2hpDo4xSGtosYCzjPAuheJlrY/0=
=Fzj6
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
