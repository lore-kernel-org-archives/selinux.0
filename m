Message-ID: <421F608F.8030201@gentoo.org>
Date: Fri, 25 Feb 2005 19:29:51 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: bjorn.padding@ifsav.nl
CC: SELinux@tycho.nsa.gov
Subject: Re: Fedora policies on Gentoo?
References: <H000007600022dad.1109356372.server.intranet.ifsaudiovisueel.nl@MHS>
In-Reply-To: <H000007600022dad.1109356372.server.intranet.ifsaudiovisueel.nl@MHS>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3E9F627107C9262F506F90D9"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E9F627107C9262F506F90D9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi

bjorn.padding@ifsav.nl wrote:
> Hi,
>
> I was wondering... I am currently running on Gentoo.
> I see that there are way less existing policies on Gentoo than
> there are on Fedora. Can I unpunished cp these policies to my
> /etc/security/selinux/src/policy dir? The only consequence
> That I can think of is that I might have to change some
> ./file_contexts/program/*.fc according to my Gentoo sys.
> But other than that it wouldn't create any problem, right?

since gentoo is all about choice, depending on your USE flags you will
end up having programs with a different behavior than what is present in
fedora/debian.

this means that sometimes you will also have to tweak the type
enforcement files by adding capabilities or rules that permit
interactions between domains.

> Somebody with some advice?

you can use the nsa policies as a starting point. they are available
over annon cvs. see http://selinux.sourceforge.net/devel/cvs.php3

bye,
peter

--
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig3E9F627107C9262F506F90D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCH2CTGSBEIeh4AEYRAk16AJ4kaBAk94nzI53QXiplLhq6gYcE7gCggJET
jkVTz6ii8y3NgqQme2AwlZc=
=DJXD
-----END PGP SIGNATURE-----

--------------enig3E9F627107C9262F506F90D9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
