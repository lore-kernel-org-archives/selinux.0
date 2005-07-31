Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6VGHHgA011998
	for <selinux@tycho.nsa.gov>; Sun, 31 Jul 2005 12:17:19 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6VGAwXP018091
	for <selinux@tycho.nsa.gov>; Sun, 31 Jul 2005 16:10:58 GMT
Message-ID: <42ECF837.8010704@gentoo.org>
Date: Sun, 31 Jul 2005 19:11:35 +0300
From: Petre Rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Toby Boudreaux <selinux@tobyjoe.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: FastCGI and SELinux
References: <D3543036-7457-4441-AF34-85B0756322C8@tobyjoe.com> <DD7A8E82-4804-4477-9527-AF057B449598@tobyjoe.com>
In-Reply-To: <DD7A8E82-4804-4477-9527-AF057B449598@tobyjoe.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDD96EDEB618974AC76518DD2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD96EDEB618974AC76518DD2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Hi,

Toby Boudreaux wrote:
> Hi.
> I think I may have sent this to the wrong list earlier this week.
> Is there an SELinux list that focuses on usage versus core development?
> 
> I'm really eager to keep SELinux enabled on my Web servers, but 
> mod_fastcgi is an important requirement. Without "avc" messages to  give
> me a clue, I'm unable to figure this problem out.

to go to your policy directory and do a
make enableaudit
make load

this should provide more clues of what goes wrong.

also make sure you don't have invalid contexts (it happens when a role isn't authorized for a given type).

> 
> Thanks for any info,
> Toby Boudreaux

cheers,
peter

> 
> 
> On Jul 28, 2005, at 12:06 PM, Toby Boudreaux wrote:
> 
>> Hello, everyone. This is my first post to the list.
>>
>> I'm running a CentOS 4 server with SELinux and have been having 
>> problems getting Apache2 and mod_fastcgi to play nicely when  SELinux
>> is enabled.
>>
>> I've run all "avc" messages through audit2allow and have modified  my
>> local.te file and I've gotten the avc messages to disappear.
>>
>> Unfortunately, mod_fastcgi is still not working when SELinux is  enabled.
>>
>> I'm getting no messages, but when I turn off enforcing, mod_fastcgi 
>> works perfectly.
>>
>> I've purchased the O'Reilly book and have read much of it, but I'm 
>> still uncertain as to what the problem is and how to investigate/
>> address it.
>>
>> The core problem seems to be that any FastCGI process doesn't write 
>> data back to the IPC socket Apache is reading. Instead, it dumps  the
>> entire response into STDERR.
>>
>> I gather by the lack of "avc" messages that there are no normal 
>> domain/user conflicts.
>>
>> I've searched high and low and can't find mention of a way to get 
>> this to work, aside from disabling SELinux. I chose this OS in part 
>> *because* of SELinux, so I don't want to disable it :)
>>
>> Has anyone experienced something similar, and might you be able to 
>> point a newbie in the right direction?
>>
>> Thanks,
>> toby boudreaux

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enigDD96EDEB618974AC76518DD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC7Pg8GSBEIeh4AEYRAkKRAJ4o75mBCzfs61ERjDyLEVjy31kLpACdGk9d
EhiYxCPZxyLZbrDXdTcbM2I=
=jl0b
-----END PGP SIGNATURE-----

--------------enigDD96EDEB618974AC76518DD2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
