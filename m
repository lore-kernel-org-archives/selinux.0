Message-ID: <4B9145A6.9020905@gmail.com>
Date: Fri, 05 Mar 2010 18:55:50 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS Now working in Fedora 12/RHEL6 in Full Desktop mode.
References: <4B91403D.6010402@redhat.com>
In-Reply-To: <4B91403D.6010402@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig489315B6202DE1EDC46DF358"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig489315B6202DE1EDC46DF358
Content-Type: multipart/mixed;
 boundary="------------000205020809020600090609"

This is a multi-part message in MIME format.
--------------000205020809020600090609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/05/2010 06:32 PM, Daniel J Walsh wrote:
> selinux-policy-3.6.32-99.fc12 on Fedora 12

Should users be able to login using gdm/gui if they are not assigned a
default level of s0?

semanage login -m -s user_u -r s1-s1 joe

I could not get that to work.

Also attached is a modification that i implemented to get MLS to "work"
on previous f13 policy versions:

> --=20
> This message was distributed to subscribers of the selinux mailing list=
=2E
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.go=
v
> with
> the words "unsubscribe selinux" without quotes as the message.


--------------000205020809020600090609
Content-Type: text/plain;
 name="mlswm.fc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mlswm.fc"


--------------000205020809020600090609
Content-Type: text/plain;
 name="mlswm.if"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mlswm.if"

## <summary>Window manager.</summary>

########################################
## <summary>
##	Role access for Window manager.
## </summary>
## <param name=3D"role prefix">
##	<summary>
##	Role prefix.
##	</summary>
## </param>
## <param name=3D"role">
##	<summary>
##	Role allowed access.
##	</summary>
## </param>
## <param name=3D"domain">
##	<summary>
##	User domain for the role.
##	</summary>
## </param>
#
interface(`mlswm_role',`
	gen_require(`
		type $1_wm_t, $1_dbusd_t, xserver_t, root_xdrawable_t;
		class x_drawable { read manage show setattr };
		class x_resource { write };
		class x_keyboard { manage freeze };
		class x_screen { setattr };
	')

	allow $3 $1_wm_t:process signal;
	allow $3 $1_wm_t:unix_stream_socket connectto;

	allow $1_wm_t self:process signal;
	allow $1_wm_t $1_dbusd_t:unix_stream_socket connectto;

	allow $3 $1_wm_t:x_drawable { read setattr };
	allow $3 $1_wm_t:x_resource write;

	allow $1_wm_t root_xdrawable_t:x_drawable manage;
	allow $1_wm_t $3:x_drawable { read manage setattr show };
	allow $1_wm_t $3:x_resource write;
	allow $1_wm_t xserver_t:x_keyboard { manage freeze };
	allow $1_wm_t xserver_t:x_screen setattr;
')

--------------000205020809020600090609
Content-Type: text/plain;
 name="mlswm.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mlswm.te"

policy_module(mlswm, 1.0.0)
# optional_policy(`
gen_require(`
	type staff_t, xdm_var_lib_t, root_xdrawable_t, xdm_t, xserver_t;
	role staff_r;
	class x_drawable { read write add_child };
	class x_client { destroy };
	class x_resource { write };
	class x_keyboard { read manage };
	class x_pointer { get_property manage set_property list_property };
	class x_screen { saver_setattr };
	class x_server { manage };
')

allow staff_t xdm_var_lib_t:file { read open };

allow staff_t root_xdrawable_t:x_drawable write;
allow staff_t xdm_t:x_client destroy;
allow staff_t xdm_t:x_drawable { read add_child };
allow staff_t xdm_t:x_resource write;
allow staff_t xserver_t:x_keyboard { read manage };
allow staff_t xserver_t:x_pointer { get_property manage set_property list=
_property };
allow staff_t xserver_t:x_screen saver_setattr;
allow staff_t xserver_t:x_server manage;

mlswm_role(staff, staff_r, staff_t)
# ')

--------------000205020809020600090609--

--------------enig489315B6202DE1EDC46DF358
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuRRbUACgkQMlxVo39jgT9SggCgnV0AoiuOweR8KU4y7pGj4rP0
8MgAnRIRCMvpjNLCkmxgWE5ya1y0cQAt
=oUgg
-----END PGP SIGNATURE-----

--------------enig489315B6202DE1EDC46DF358--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
