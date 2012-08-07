Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77Crlx6011819
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 08:53:48 -0400
Date: Tue, 7 Aug 2012 14:53:23 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Message-ID: <20120807125323.GD2085@telvanni>
References: <20120716161006.GA14824@telvanni>
 <50081541.3040909@redhat.com>
 <20120719144405.GB19890@telvanni>
 <201207271402.15812.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
In-Reply-To: <201207271402.15812.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2012 at 02:02:15PM +1000, Russell Coker wrote:
> Could you blog about all the details?
>=20
> I've wanted to get X access control in Debian for a while.

Sure! I'm just not sure how helpful it's gonna be, because my=20
policy is from scratch and pretty specialised for me. I'm scared=20
of the reference policy and frankly believe it's faster for me to=20
write the things I need from scratch than to find out how to do=20
this within the reference policy.

Of course I could use the reference policy as a base and write=20
only my stuff for user separation under X from scratch. But here=20
Ubuntu comes into play. I have to admit I haven't extensively=20
tested SELinux under Ubuntu, but I did look quite old. And from=20
what I read, AppArmor is the supported LSM under Ubuntu and one=20
should not expect much support for SELinux.

I need something that is either maintained actively or can be=20
maintained by myself with minimal effort. Neither applies to=20
reference policy under Ubuntu. I wouldn't want to leave Ubuntu=20
unless neccessary, so I'm writing from scratch.

Besides, I have some doubts about the underlying paradigm of a=20
security policy that gets _that_ complicated. But that's nothing=20
I really thought through so far.


Getting X11 with XSELinux was pretty easy actually. I just got=20
the source package, changed 'debian/rules' replacing the=20
'--disable-selinux' with '--enable-selinux' and build and=20
installed the package. Did 'setsebool -P xserver_object_manager=20
true' and XSELinux was good to go.

I then wrote a monolithic policy. I still use traditional linux=20
users to separate the different contexts I work with (mail,=20
browser, ...), like I have done for years. But instead of using=20
the crappy trusted/untrusted-model of the old SECURITY extension,=20
I separated the user contexts under X using SELinux.

So I specificly target only user contexts and only the X-portion=20
of access vectors. I could send you this policy, but it's messy=20
and probably useless to you.

I'm currently writing a new, modular policy targeting some system=20
daemons and separating my user contexts by SELinux without the=20
need for traditional linux users. I can tell you when it's done.=20
But again, it will be pretty specialised for my needs.

Was there anything specific you wanted to know?

Ole

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAhD8MACgkQS1FjE303ERwhBACfZDdNhAFowXwzjjUi5ClorM2/
6HAAnA3DG+6qRiik4U7/VlDD+PymZtK+
=w1OB
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
