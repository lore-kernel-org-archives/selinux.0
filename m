Message-ID: <4227B2A1.5070904@gentoo.org>
Date: Fri, 04 Mar 2005 02:58:09 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: bjorn.padding@ifsav.nl
CC: SELinux@tycho.nsa.gov
Subject: Re: Fedora policies on Gentoo?
References: <H0000076000234b2.1109864137.server.intranet.ifsaudiovisueel.nl@MHS>
In-Reply-To: <H0000076000234b2.1109864137.server.intranet.ifsaudiovisueel.nl@MHS>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAAAA422DDF999A08F4995E0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAAAA422DDF999A08F4995E0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi Bjorn,

bjorn.padding@ifsav.nl wrote:
> Thanks for the tip Peter.
>
> My only question left is;
> Which policycoreutils && libselinux version are you running?
> I run 1.16 here and the Makefile from cvs is for 1.20
> If I try to emerge the 1.20 version of policycoreutils && libselinux, I
> get a mask
> error. Can I safely KEYWORDS='~x86' emerge them anyway?

sure. this is exactly what I do on all my (otherwise non-~x86) machines.

you can simply define

sys-apps/checkpolicy ~x86
sys-apps/policycoreutils ~x86
sys-libs/libsepol ~x86
sys-libs/libselinux ~x86

in /etc/portage/package.keywords

> Or do I modify the Makefile for 1.16?
>
> Thanks in advance...
>
> Bjorn

bye,
peter

>
> Peter wrote:
> -----------
> Hi
>
> bjorn.padding@ifsav.nl wrote:
>
>>Hi,
>>
>>I was wondering... I am currently running on Gentoo.
>>I see that there are way less existing policies on Gentoo than
>>there are on Fedora. Can I unpunished cp these policies to my
>>/etc/security/selinux/src/policy dir? The only consequence
>>That I can think of is that I might have to change some
>>./file_contexts/program/*.fc according to my Gentoo sys.
>>But other than that it wouldn't create any problem, right?
>
>
> since gentoo is all about choice, depending on your USE flags you will
> end up having programs with a different behavior than what is present in
> fedora/debian.
>
> this means that sometimes you will also have to tweak the type
> enforcement files by adding capabilities or rules that permit
> interactions between domains.
>
>
>>Somebody with some advice?
>
>
> you can use the nsa policies as a starting point. they are available
> over annon cvs. see http://selinux.sourceforge.net/devel/cvs.php3
>
> bye,
> peter
>
> --
> petre rodan
> <kaiowas@gentoo.org>
> Developer,
> Hardened Gentoo Linux
>
>
>> -----Original Message-----
>>From: 	kaiowas [mailto:kaiowas@gentoo.org]
>>Sent:	vrijdag 25 februari 2005 18:30
>>To:	BjornPadding
>>Cc:	SELinux
>>Subject:	Re: Fedora policies on Gentoo?
>>
>> << File: Re_ Fedora policies on Gentoo_.TXT >>  << File:
>
> smime_clearsigned.txt >>
>
>


--
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enigCAAAA422DDF999A08F4995E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCJ7KhGSBEIeh4AEYRAjudAJ0fPfl8g0wfFtqCeaS3zRvAtahepwCWIPZM
B59q6zns078u/iOYPBk6Fw==
=RMUg
-----END PGP SIGNATURE-----

--------------enigCAAAA422DDF999A08F4995E0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
