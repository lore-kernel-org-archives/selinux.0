Date: Wed, 2 Dec 2015 22:37:46 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202213745.GE1028@x250>
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
 <20151202194715.GC1028@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20151202194715.GC1028@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Dec 02, 2015 at 08:47:15PM +0100, Dominick Grift wrote:
> 
> Those are good questions but i do not see how they are directly related
> to the question whether systemd --user should be a selinux user space object
> manager or not (in my view it obviously should but i am not trusted by
> systemd maintainers, walsh is trusted and walsh gave systemd maintainers
> the impression that systemd --user does not have to be an selinux object
> manager) I strongly suspect that is wrong.
> 

The problem is that i sincerely do not know what to do, and i am worried
about this. I would like confirmation about whether or not systemd
- --user needs to be an object manager for consistency in selinux enabled
systems.

If someone can tell me with confidence that it does not then i will
accept that. If someone can tell me with confidence that systemd --user
needs to be an user space object manager because else it will "break
selinux" then I am worried that redhat will not acknowledge that simply
because its not on their agenda.

It is going to take a long time before redhat will be able to produce
any half useful support for systemd --user for confined users, and even
when they get to that point i am afraid they will still leave that gap
simply because i am afraid that its not an priority to them.

In the mean time we might be stuck with this inconsistency.

All Mr. Walsh had to do was tell Mr. Poettering. Hold that commit for
now while i double check whether its desired or not. Instead he gave the
go-ahead to remove code I rely on in a blink of an eye.

If he was right by determining that systemd --user does not need to be
an selinux object manager then i will apologize to him.

If it turns out that it really did not make sense for him to support the
removal of that code then i am sincerely disappointed.

02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWX2SlAAoJENAR6kfG5xmcvd0L/1ZQP0uJoo931bXDIulR/xaY
eH6cPytluJVETS9gNiQTFYVTIIWUdegjaDbE0cW/sHJCHiBcksPc9fXlv30vC4CL
wad26KVMsRZLydxmM/K9IKak/AtRSu4tqmWK/UqXhBOGqMDWLYCJzcSebTC3w/wY
+GlxBMuSczN1a6iSYUSak1fyn47SC1hekGIcd7HE3KEzqI1e+lodC+npV/fn0a6D
9uefujVZZxGM8jxQcU1zaT0SoLNjC8UTMsGXRLc7BRkbE1OgJsE8xIkekPOGSw6k
dsGC4WUMbC+ExU0gLltprdgmpxJpIMsI9jy8yO6PqXaEwbk0MxTcA2OlafChhfJ9
yG0f5cfG6NW3CDQmVf/6WOYzqfE/KAaq8VomPpNRb2HXDPRnOIPbTuSLmMhSGBsB
FuSmuKasrdE+XzfWOE3PM+XkpsDg5QJVsuyP8+t+hcSuSE1oqZeoXflhe5CZtJL8
ma8tHOsZvWG2MzqY17NPgcEZMlqixWeebX+zQUVabA==
=uhHm
-----END PGP SIGNATURE-----
