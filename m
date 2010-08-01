Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71Gi34q016995
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 12:44:03 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o71Ghwoe005484
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 16:43:59 GMT
Received: by eydd26 with SMTP id d26so1321426eyd.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 09:44:01 -0700 (PDT)
Message-ID: <4C55A44F.4030803@gmail.com>
Date: Sun, 01 Aug 2010 18:43:59 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com> <4C559624.6040709@gmail.com> <4C559A84.4060004@gmail.com> <4C559F31.4070404@gmail.com> <4C55A265.6090606@gmail.com> <4C55A3B2.8020207@gmail.com>
In-Reply-To: <4C55A3B2.8020207@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA87725F863A6ECC6629CC06"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA87725F863A6ECC6629CC06
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2010 06:41 PM, Dominick Grift wrote:
> On 08/01/2010 06:35 PM, Dominick Grift wrote:
>> On 08/01/2010 06:22 PM, Ralph Blach wrote:
>>> To be specific, I want to run sshd on port 443, and not port 22, beca=
use
>>> of all the hackers probe port 22.
>>>
>>> port 443 looks like httpd traffic and therefore is not really supicio=
us.
>>>
>>> That is what I need to achieve so i need to modify the corenetwork
>>> module to do this.
>>>
>>> How is this done and where is the source for the core network module?=

>>
>> Try this:
>>
>> mkdir ~/mysshd; cd ~/mysshd;
>>
>> cat <<D_G >mysshd.te
>> policy_module(mysshd, 1.0.0)
>> gen_require(`

>> type shorewall_t;

And this needs to be ..

type sshd_t;

=2E. instead

>> ')
>> corenet_tcp_bind_http_ports(sshd_t)
>> D_G
>>
>> That custom policy module should allow sshd to bind tcp sockets to htt=
p
>> ports (including tcp:443)
>=20
> Ofcourse you also have to build and install the custom module:
>=20
> ( below is how that is done in Fedora (RHEL5 requires that you also
> install selinux-policy-devel to build a module)
>=20
> make -f /usr/share/selinux/devel/Makefile mysshd.pp
> sudo semodule -i mysshd.pp
>=20
>=20
>>
>> You can find source policy in the source package for your policy.
>>
>> Here is the policy browser from upstream:
>> http://oss.tresys.com/projects/refpolicy/browser
>>
>>
>>> Thanks
>>>
>>> Chip
>>>
>>>
>>>
>>> On 08/01/2010 12:02 PM, Dominick Grift wrote:
>>>> On 08/01/2010 05:43 PM, Ralph Blach wrote:
>>>>> I have discovered that ports 443 and 22 are in module tcp.
>>>>>
>>>>> How do i rewrite module tcp so that I can configure as I want it.
>>>>>
>>>>> Where do I find module tcp?
>>>>>
>>>>> I did a semanage port -l | grep 22 and module tcp was listed.
>>>>> I did the same for port 443
>>>>>
>>>>> Thanks
>>>
>>>> ports are declared (defined) in the corenetwork module. This module =
is
>>>> part of the base module. modules that are part of the base module ar=
e
>>>> not listed with semodule -l.
>>>
>>>> What exactly do you want to achieve? If you are specific about your
>>>> requirements we can try to help you implement it.
>>>
>>>>> Chip
>>>>>
>>>>> On 07/27/2010 08:29 PM, Jason Axelson wrote:
>>>>>> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.c=
om> wrote:
>>>>>>> how do I use semanage to list the policy modules.
>>>>>
>>>>>> Hi Chip,
>>>>>
>>>>>> Perhaps you are looking for "semodule -l"? That will list out all =
the
>>>>>> installed policy modules (besides base).
>>>>>
>>>>>> Jason
>>>>>
>>>>>
>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing l=
ist.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa=
=2Egov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>>
>>>
>>
>=20
>=20



--------------enigEA87725F863A6ECC6629CC06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxVpE8ACgkQMlxVo39jgT9YWgCfcZnENRboZ759br7HGpSYoZtw
0V8AoJQlt7Lav+wpnjKFPViKbQmtUseq
=B+Qo
-----END PGP SIGNATURE-----

--------------enigEA87725F863A6ECC6629CC06--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
