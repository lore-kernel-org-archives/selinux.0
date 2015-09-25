Date: Fri, 25 Sep 2015 18:21:35 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: selinux network control question
Message-ID: <20150925162134.GC29665@x250>
References: <20150925151543.GA29665@x250>
 <560567F4.8010800@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <560567F4.8010800@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 25, 2015 at 11:27:48AM -0400, Stephen Smalley wrote:
> On 09/25/2015 11:15 AM, Dominick Grift wrote:
> > I am trying to clean up my network policy module but some things are
> > unclear. Could anyone shine some light (or correct me) on the below:
> > 
> > 1.
> > network interface labels are no longer checked in any scenario (secmark,
> > netlabel, labeled-ipsec) and the netif isid is no longer used.
> > 
> > So i can remove my netif types and associate the netif isid with a
> > context reserved for unused isids?
> 
> netif SIDs are used by the egress/ingress permission checks (which are only active if using peer labeling).
> 

Thanks, It is clear now. I was not paying attention, and after thinking
about it some more and looking up some things it became clear.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWBXSKAAoJENAR6kfG5xmcZxgL/jGeQBtQmUC2nZQpeZBZROvk
IXfn8eWtrqu1lYX3BFtRs08R8jGYDVeUoWIx0qGwRGPHc+43/k4VJYLzokmRWNN8
HCz0alXakwaM3ArL4O/y7hq2w9hYkVSF9+9wu1lYH8X0n50op9UrUWHLdORYe84m
ib/UeoD7fF5AVLHqcKZQh7+pqcDmTZNLcYfncPX1tq8CtebV08Lk6txwPrG/muH2
BJ0mYko+PUt48SwvV/KiHjcHEDHCuvk8ngik0ccD1Mv65SkNpq0v9uA8j/ZKEBA3
aGwLe1JLFk68Ul5wMCZQzKO0NjUSV1cLpIwc8Dp6aqBIWXjmzzuntEVyLpxvEFMV
x2c0zx55WxwQ7xeHKFaiD4DbHvmCwxuvlm4/IHigmbHFrLELQv/HHt2FTcRh38uQ
17rvo0UNOoYp8ZgK08ysIwEEmmpJHAbl3qJFUFwmlTOkSOUu7xcVPK8Z0J8gG/YK
9SWtEkOqRr2z8f+yQeZzQvfiNkmsY4tqWqWWWr1rGQ==
=bngt
-----END PGP SIGNATURE-----
