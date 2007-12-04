Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4Afi7W030084
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 05:41:44 -0500
Received: from ppsw-4.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4Afh44004205
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 10:41:43 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:41052)
	by ppsw-4.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.134]:25)
	with esmtp id 1IzVDf-0007SU-DP (Exim 4.63) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Tue, 04 Dec 2007 10:41:39 +0000
Message-ID: <47552ECF.4020105@martinorr.name>
Date: Tue, 04 Dec 2007 10:41:19 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_caligula-5689-1196764899-0001-2"
To: Chris PeBenito <pebenito@gentoo.org>
CC: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
References: <20071126144547.GA334@bobek.pm.i.cz>	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>	 <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>	 <20071130153024.GA13299@bobek.pm.i.cz> <1196438149.4298.43.camel@gorn>	 <47504744.9040202@martinorr.name> <1196551302.4808.6.camel@defiant.pebenito.net>
In-Reply-To: <1196551302.4808.6.camel@defiant.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-5689-1196764899-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/12/07 23:21, Chris PeBenito wrote:
> On Fri, 2007-11-30 at 17:24 +0000, Martin Orr wrote:
>> On 30/11/07 15:55, Christopher J. PeBenito wrote:
>>> On Fri, 2007-11-30 at 16:30 +0100, V=E1clav Ovs=EDk wrote:
>>>> On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wr=
ote:
>>>>>> Corresponding code is in udev_node.c, function node_symlink().
>>>>>>     if (strcmp(target, buf) =3D=3D 0) {
>>>>>> 	    info("preserve already existing symlink '%s' to '%s'", slink,=

>>>>>> target);
>>>>>> 	    selinux_setfilecon(slink, NULL, S_IFLNK);
>>>>>> 	    goto exit;
>>>>>>     }
>>>>> I'll add the rule.  Perhaps someone should send up a patch to remov=
e the
>>>>> setfilecon, and update the info message.
> Yes, thats what I was thinkin.  Since the function is node_symlink(),
> I'm guessing there is a similar function for char and block node, etc?
> Those should be checked to make sure they don't do unneeded relabeling
> too.

That's true.  And for char and block nodes, it also does a chmod to reset=

the permissions.  Apparently this is intended, because "you can't expect
that the properties of a pre-existing node are correct."

Best wishes,

--=20
Martin Orr


--=_caligula-5689-1196764899-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHVS7VZ6a/BjxtAMARAssNAJ45jL/KEmRrCZmI4n47wpq/URtWwACeNxuG
3drSQ3ACHQuYP7FOat43RVQ=
=Tc+t
-----END PGP SIGNATURE-----

--=_caligula-5689-1196764899-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
