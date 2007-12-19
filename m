Message-ID: <476988ED.4070003@martinorr.name>
Date: Wed, 19 Dec 2007 21:11:09 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_caligula-9512-1198098677-0001-2"
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chris PeBenito <pebenito@gentoo.org>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Xorg modprobe denials
References: <47673B12.6040205@tycho.nsa.gov>	 <1197949627.4790.4.camel@defiant.pebenito.net>	 <1197984841.7967.5.camel@moss-spartans.epoch.ncsc.mil> <1197986223.7967.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197986223.7967.17.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-9512-1198098677-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/12/07 13:57, Stephen Smalley wrote:
> On Tue, 2007-12-18 at 08:34 -0500, Stephen Smalley wrote:
>> On Mon, 2007-12-17 at 22:47 -0500, Chris PeBenito wrote:
>>> Based on the other kernel messages, I'm guessing that the insmod
>>> succeeded despite the tty and capability denials?  If so I suppose we=

>>> can dontaudit it.
>> I don't think we want to dontaudit the capability denials.
>=20
> And just to note, denials from insmod can be triggered either by
> userspace activity of insmod or by the module initialization code of th=
e
> loaded module.

I find that on an SMP machine I need both the sys_nice capabability and
setsched on kernel_t to load modules.

This is because stop_machine() is called by sys_init_module(), so it make=
s
sense to me to add these to kernel_load_module().

Index: policy/modules/kernel/kernel.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/kernel/kernel.if	(revision 2560)
+++ policy/modules/kernel/kernel.if	(working copy)
@@ -330,6 +330,9 @@

 	allow $1 self:capability sys_module;
 	typeattribute $1 can_load_kernmodule;
+
+	allow $1 self:capability sys_nice;
+	kernel_setsched($1)
 ')

 ########################################

--=20
Martin Orr


--=_caligula-9512-1198098677-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHaYjxZ6a/BjxtAMARAtsPAJ97SE73yay9/XQtLnY0OAch7tBkEgCgqVs6
3wmpvs0+Ey2gUQdiu6qOawQ=
=YHCK
-----END PGP SIGNATURE-----

--=_caligula-9512-1198098677-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
