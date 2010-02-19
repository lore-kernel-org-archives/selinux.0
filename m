Message-ID: <4B7F004A.9040909@gmail.com>
Date: Fri, 19 Feb 2010 22:19:06 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "Justin P. mattock" <justinmattock@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com>	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com> <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil> <4B7EDC9A.40801@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2755C8D8B4D08D020CDCD5A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2755C8D8B4D08D020CDCD5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/19/2010 10:08 PM, Alan Rouse wrote:
> setsebool -P xserver_object_manager=3Don

Leave that to off to keep thing as simple as possible for now.

As for your other AVC denials i am willing to compare those to Fedoras'
settings. Maybe tomorrow.

But as far as policy goes it is a continuous process. So it will take
much time to fix all policy issues and it will "never" be perfect.

I would be helpful if you could enclose raw avc denials.


--------------enigC2755C8D8B4D08D020CDCD5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt/AFIACgkQMlxVo39jgT/hrQCdGcl85c1JxvdGfoOqgsWvHoU+
ojYAoLhfOlZE80N4IiPUH9Jic5/MyU0V
=tzvY
-----END PGP SIGNATURE-----

--------------enigC2755C8D8B4D08D020CDCD5A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
