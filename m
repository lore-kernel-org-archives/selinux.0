Message-ID: <52EA8B84.5010006@gentoo.org>
Date: Thu, 30 Jan 2014 12:27:32 -0500
From: Richard Yao <ryao@gentoo.org>
MIME-Version: 1.0
To: mthode@mthode.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52E8B7C1.1000101@mthode.org>
 <1621615.vHn06J0duj@sifl> <52E90B32.5010404@tycho.nsa.gov>
 <52E90D65.9030200@tycho.nsa.gov> <52E9331B.407@mthode.org>
 <52E97454.5060403@tycho.nsa.gov> <52E98240.5020901@llnl.gov>
 <F90298CB-DC5B-4DC9-BA64-E5C31461815D@gentoo.org> <52EA0B4F.30403@mthode.org>
 <52EA571B.6050008@tycho.nsa.gov> <52EA71F1.1040303@mthode.org>
 <52EA737C.7010802@tycho.nsa.gov> <52EA74E9.3020406@mthode.org>
 <52EA80AC.2070802@tycho.nsa.gov> <52EA86D2.104@mthode.org>
In-Reply-To: <52EA86D2.104@mthode.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CLtsFvFKrnh3mxwUl8r9wgTQWpJvKRt7i"
Cc: behlendorf@llnl.gov, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CLtsFvFKrnh3mxwUl8r9wgTQWpJvKRt7i
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 12:07 PM, Matthew Thode wrote:
> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
>> On 01/30/2014 10:51 AM, Matthew Thode wrote:
>>> On 01/30/2014 09:45 AM, Stephen Smalley wrote:
>>>> We'll have to investigate, as that obviously shouldn't be possible.
>>>> Wouldn't be allowed in enforcing mode or for any non-root process.

This is an untested conjecture, but I believe that a FUSE filesystem
could be used to trigger this in enforcing mode. If I am right, a custom
FUSE filesystem could trigger it with ease. However, I do not see what
that would accomplish beyond triggering the BUG_ON.

>> Try the attached patch.
>>
>>
> Confirmed that this fixes it :D thanks a ton for this.

This patch looks good to me. Feel free to append my Acked-by:

Acked-by: Richard Yao <ryao@gentoo.org>


--CLtsFvFKrnh3mxwUl8r9wgTQWpJvKRt7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS6ouGAAoJECDuEZm+6ExkIEYP+gLfAkLtSOw95zA0WzCQR/tN
YagdyH+xm8+snxpGx2YRNkESESQz10ipttZEu6DY8ZzflBHfQGTNYBRXJOIVU6X9
UIeRcNG5McAvFTLX5Q2ISwHPoxw2+i8Sr1oWezQScpAmgxtedgmm+yFwsgzeUlPe
jMgGRlPrWgXYW0cEog6HCIlYVD280fiGQp9HJfMVmg8NemeU1htLozvyhzIAT7YT
m6VwXUnMraYXM0eGXCp5rjK++7dvazNNvlrLetNKrNED3WwbENNtJfWytmg5EBxY
f1fT0ethjEO27vnfER2PU5OyjzTSX2IXpuxKglpP+TRGmKx4Bzd4tZ1hsxKTA8Ed
uJ/qZVdyXFJUCzJmYgK8SMa97fc718+5c+/8EvcAwDKTb9PrT5zOmqV5kg9zuXoB
8nL3/itSGxvEfeFn0WXcbC/yMXiiZddM+olwaGMI4vq0jPiqThefpgq/YgS6Pz2F
rWmIvOCw1sv1IcxE6lJeY1DiPPyYeTeZi5jEU0u/RKKrEyXNaiTomJ7sKAct3vpz
BTE1yzXbZojlk9T7s9poHOPau2RYxnDLVOz7w2o6FidiMtz28SBo9//9ba16vFwc
r0f4w4IU6rheeoS7GJJJBThKFp7+yo3GsAqm/Kb8fW+CSHWvLfP5C+SdT+2Ba7E4
/hRG+gicW5Kf32WyOpDU
=VKdk
-----END PGP SIGNATURE-----

--CLtsFvFKrnh3mxwUl8r9wgTQWpJvKRt7i--
