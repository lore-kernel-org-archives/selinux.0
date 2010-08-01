Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71GfZvx016844
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 12:41:35 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o71GfeW7024072
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 16:41:41 GMT
Received: by eydd26 with SMTP id d26so1321038eyd.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 09:41:32 -0700 (PDT)
Message-ID: <4C55A3B2.8020207@gmail.com>
Date: Sun, 01 Aug 2010 18:41:22 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com> <4C559624.6040709@gmail.com> <4C559A84.4060004@gmail.com> <4C559F31.4070404@gmail.com> <4C55A265.6090606@gmail.com>
In-Reply-To: <4C55A265.6090606@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4076EFBD2974335B1ED81F2A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4076EFBD2974335B1ED81F2A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2010 06:35 PM, Dominick Grift wrote:
> On 08/01/2010 06:22 PM, Ralph Blach wrote:
>> To be specific, I want to run sshd on port 443, and not port 22, becau=
se
>> of all the hackers probe port 22.
>>
>> port 443 looks like httpd traffic and therefore is not really supiciou=
s.
>>
>> That is what I need to achieve so i need to modify the corenetwork
>> module to do this.
>>
>> How is this done and where is the source for the core network module?
>=20
> Try this:
>=20
> mkdir ~/mysshd; cd ~/mysshd;
>=20
> cat <<D_G >mysshd.te
> policy_module(mysshd, 1.0.0)
> gen_require(`
> type shorewall_t;
> ')
> corenet_tcp_bind_http_ports(sshd_t)
> D_G
>=20
> That custom policy module should allow sshd to bind tcp sockets to http=

> ports (including tcp:443)

Ofcourse you also have to build and install the custom module:

( below is how that is done in Fedora (RHEL5 requires that you also
install selinux-policy-devel to build a module)

make -f /usr/share/selinux/devel/Makefile mysshd.pp
sudo semodule -i mysshd.pp


>=20
> You can find source policy in the source package for your policy.
>=20
> Here is the policy browser from upstream:
> http://oss.tresys.com/projects/refpolicy/browser
>=20
>=20
>> Thanks
>>
>> Chip
>>
>>
>>
>> On 08/01/2010 12:02 PM, Dominick Grift wrote:
>>> On 08/01/2010 05:43 PM, Ralph Blach wrote:
>>>> I have discovered that ports 443 and 22 are in module tcp.
>>>>
>>>> How do i rewrite module tcp so that I can configure as I want it.
>>>>
>>>> Where do I find module tcp?
>>>>
>>>> I did a semanage port -l | grep 22 and module tcp was listed.
>>>> I did the same for port 443
>>>>
>>>> Thanks
>>
>>> ports are declared (defined) in the corenetwork module. This module i=
s
>>> part of the base module. modules that are part of the base module are=

>>> not listed with semodule -l.
>>
>>> What exactly do you want to achieve? If you are specific about your
>>> requirements we can try to help you implement it.
>>
>>>> Chip
>>>>
>>>> On 07/27/2010 08:29 PM, Jason Axelson wrote:
>>>>> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.co=
m> wrote:
>>>>>> how do I use semanage to list the policy modules.
>>>>
>>>>> Hi Chip,
>>>>
>>>>> Perhaps you are looking for "semodule -l"? That will list out all t=
he
>>>>> installed policy modules (besides base).
>>>>
>>>>> Jason
>>>>
>>>>
>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing li=
st.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.=
gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>
>>
>>
>=20



--------------enig4076EFBD2974335B1ED81F2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxVo7kACgkQMlxVo39jgT/I3wCfdY0z6AwoyAKozm1cAKElbRC9
SH4AnjVg1sfxw3c9CoXQGQ4FJB3e64ii
=5Cuv
-----END PGP SIGNATURE-----

--------------enig4076EFBD2974335B1ED81F2A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
