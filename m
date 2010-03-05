Message-ID: <4B9147E4.8090104@gmail.com>
Date: Fri, 05 Mar 2010 19:05:24 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS Now working in Fedora 12/RHEL6 in Full Desktop mode.
References: <4B91403D.6010402@redhat.com> <4B9145A6.9020905@gmail.com> <4B91476E.2040004@redhat.com>
In-Reply-To: <4B91476E.2040004@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41AC435F2E9435793382DE48"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41AC435F2E9435793382DE48
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/05/2010 07:03 PM, Daniel J Walsh wrote:
> On 03/05/2010 12:55 PM, Dominick Grift wrote:
>> On 03/05/2010 06:32 PM, Daniel J Walsh wrote:
>>  =20
>>> selinux-policy-3.6.32-99.fc12 on Fedora 12
>>>     =20
>> Should users be able to login using gdm/gui if they are not assigned a=

>> default level of s0?
>>
>> semanage login -m -s user_u -r s1-s1 joe
>>
>>   =20
> I think you need to setup the homedir with this label.  Or use
> polyinstatiated homedirs.
> The homedir is probably labeled s0 so it would not be allowed.

I tried that and even than it does not work but i will try it again as
soon as i installed your latest policy.

Also i noticed last time i tried MLS policy that some modules werent
installed. I am not sure which ones, except rtkit policy.

>> I could not get that to work.
>>
>> Also attached is a modification that i implemented to get MLS to "work=
"
>> on previous f13 policy versions:
>>
>>  =20
>>> --=20
>>> This message was distributed to subscribers of the selinux mailing li=
st.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.=
gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>     =20
>>   =20
>=20



--------------enig41AC435F2E9435793382DE48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuRR+sACgkQMlxVo39jgT86YwCgmz8N3PBraa8CifuoW10QIXQq
7UMAnA3SznPnxDyz558LIu6KUGaa/qGV
=iPGc
-----END PGP SIGNATURE-----

--------------enig41AC435F2E9435793382DE48--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
