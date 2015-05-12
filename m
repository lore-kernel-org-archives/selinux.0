Message-ID: <55520569.8030306@redhat.com>
Date: Tue, 12 May 2015 15:51:37 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov> <5551F7F4.5050907@redhat.com>
 <5551F886.40100@tycho.nsa.gov>
In-Reply-To: <5551F886.40100@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kaiQiTHWkINF6UhnSbr8cO39HfJr41kEW"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kaiQiTHWkINF6UhnSbr8cO39HfJr41kEW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/12/2015 02:56 PM, Stephen Smalley wrote:
> BTW, in trying to test these scenarios, I did a yum remove
> selinux-policy-targeted at one point and was surprised to find that I
> couldn't subsequently do a yum install selinux-policy-targeted.  It
> would always fail.  Ultimately I found that if I created an empty
> /etc/selinux/targeted/contexts/files/file_contexts file and then tried
> installing it, it would work.  So I guess rpm -i fails if there is no
> file_contexts file?  That doesn't seem right.
>=20

That's correct. rpm does a verification of a transaction and one of the
steps is to check files labels. It uses selinux_file_context_path() to
get a file path and if it can't open this file, it fails as it can't
confirm whether contexts are ok or not. Empty file_contexts file means
that there's no conflict.

If you want to skip this check, you can use:

rpm -i --nocontexts ...
or
yum install --setopt=3Dtsflags=3Dnocontexts

or just reboot and install selinux-policy-targeted with disabled SELinux.=


Petr
--=20
Petr Lautrbach



--kaiQiTHWkINF6UhnSbr8cO39HfJr41kEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVUgVpAAoJEGOorUuYLENzi40P/RjIpu9DyFNGoMG8VMQLaSuT
xn0NwcdyyuIWemLG4wgmpfFNYKeXPCrEPEh8Q5wm5dWbZJl31O/uWYDTplr0TUFr
8jIwu6szr3uX4QmnuSqm5WRF7pXpLjwLpo1lHfr2D1FVcZMe9NnQrF9oNJLZiByC
x62hjXgQShmMb6p4qS/vB7P0gs7x6e1eUT8wvOO8iCmqF3iIiu80jb3ZCZGn4hXS
xdCFQoUg/U55jUTlRSkIg+QBHgCZVGnwZb810n1zOj5HRojUxLTSihcEsTDgM8/p
8pBZsEOlxQ3kXKgKz84Lu4QloAIc4E2NsTePlWRn3U6JOLlVFicbT51UMnl/N2Fo
SZ708t7m2d0JB5YZpRWg71eDnz4QZUl8JJEnohGPs/+j1/r451QiuyNnCbTMOcdB
dx59npymDcTdP+yY0fPNZ61HZUkx7P6MztuqhMTAVxVAUbm4RcI25JGhcmcJ8k0X
8UIjfLA90gcdhK5fQZ05qgn9o/ZN2KxSLtbB6BfzQkkz1AShcV+k28/l5WzntmRM
AZs3FoeMHdkQ8uWpLkWmZXi1kbOqD/+bTVX78JOBQ9AkPtmRN8ni0zZmw/rjV4Wg
d0NJdd4a2Ri4ZjpayHporqsSGjN/37tM8TvTnFHzNsuaSwo+MeSIzLRW7iaBRTTR
krDRen0pg48JDRecqqcy
=Wa77
-----END PGP SIGNATURE-----

--kaiQiTHWkINF6UhnSbr8cO39HfJr41kEW--
