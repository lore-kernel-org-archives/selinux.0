Subject: Re: chfn/passwd
From: Colin Walters <walters@redhat.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <4088d1b8.2a5.1877.956371590@internode.on.net>
References: <4088d1b8.2a5.1877.956371590@internode.on.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-avpCi44IABcVfKEBCzO1"
Message-Id: <1082727010.6575.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 09:30:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-avpCi44IABcVfKEBCzO1
Content-Type: multipart/mixed; boundary="=-E1A3LE7aUTpbHipiUvc9"


--=-E1A3LE7aUTpbHipiUvc9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-23 at 04:20, keen@internode.on.net wrote:
> Hi, I am running the December release on a 2.6.2 kernel on a
> FC1. I have realised normal users could not change their
> finger name as well as changing password under enforcement
> mode.

I remember fixing a bug like this in the FC2 policy a few weeks ago,
maybe it was also in the upstream policy.  After mining my email a bit,
here's the patch I came up with at the time.  Not sure if you're running
into the same problem, you'd need to post the exact AVC messages.



--=-E1A3LE7aUTpbHipiUvc9
Content-Disposition: attachment; filename=chfn-policy.patch
Content-Type: text/x-patch; name=chfn-policy.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjkuMi9kb21haW5zL3Byb2dyYW0vcGFzc3dkLnRlfgkyMDA0LTAzLTMxIDE1
OjUyOjI3LjAwMDAwMDAwMCAtMDUwMA0KKysrIHBvbGljeS0xLjkuMi9kb21haW5zL3Byb2dyYW0v
cGFzc3dkLnRlCTIwMDQtMDQtMDIgMTE6MTk6NDAuOTAyNTI1NjU2IC0wNTAwDQpAQCAtNzIsNyAr
NzIsNyBAQA0KIA0KIHBhc3N3ZF9kb21haW4ocGFzc3dkKQ0KIHBhc3N3ZF9kb21haW4oc3lzYWRt
X3Bhc3N3ZCkNCi1iYXNlX3Bhc3N3ZF9kb21haW4oY2hmbiwgYGF1dGhfY2hrcHdkLCBldGNfd3Jp
dGVyJykNCitiYXNlX3Bhc3N3ZF9kb21haW4oY2hmbiwgYGF1dGhfY2hrcHdkLCBldGNfd3JpdGVy
LCBwcml2b3duZXInKQ0KIGNhbl9zZXRmc2NyZWF0ZShjaGZuX3QpDQogYWxsb3cgY2hmbl90IHNl
bGY6cHJvY2VzcyB7IHNldHJsaW1pdCB9Ow0KIA0K

--=-E1A3LE7aUTpbHipiUvc9--

--=-avpCi44IABcVfKEBCzO1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiRphOIkJWWp2WGURAldXAJ497U6WAtmvDxnd0S4pLiYitfYh8QCcDluM
mOP77IzUhUVuMujylWUhllg=
=tJjp
-----END PGP SIGNATURE-----

--=-avpCi44IABcVfKEBCzO1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
