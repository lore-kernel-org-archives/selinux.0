Subject: Re: writing rules to disallow a domain to read particular files
From: Colin Walters <walters@verbum.org>
To: jsingh@ensim.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1098017660.2740.33.camel@jsingh.india.ensim.com>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Bc7zGqGY2+570TGoZyEo"
Date: Sun, 17 Oct 2004 12:35:22 -0400
Message-Id: <1098030922.15741.20.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Bc7zGqGY2+570TGoZyEo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 18:24 +0530, Jaspreet Singh wrote:

> The higher goal is to support (site) virtualization e.g.
>=20
> apart from /home/users I want to have /home/virtual/siteNum/home/users
>=20
> and now based on the access writes of users of a particular site I want
> them to access services like apache. so that apache cant access
> /home/virtual/siteNum/home/users/public_html/files.html

I think I see.  Ok.  There are two broad approaches.  First is to go
with full_user_role for each user.  Let's say that you have three users:
jaspreet, bob, and manoj.  You have three sites: foocom, barcom, bazcom.
You want jaspreet to have control over foocom and barcom, bob to control
barcom, and manoj to control foocom and bazcom.

macros/program/apache_macros.te:
define(`httpd_virtual_subdomain',`
type httpd_$1_content_t, file_type, sysadmfile;
r_dir_file(httpd_t, httpd_$1_content_t)
# Also may want to define types for CGI scripts, etc here
')

define(`user_virtual_access',`
rw_dir_create_file($1, httpd_$2_content_t)
allow $1_t httpd_$2_content_t:{ file lnk_file } { relablelfrom relabelto };
')

domains/misc/local.te:
full_user_role(jaspreet)
full_user_role(bob)
full_user_role(manoj)
httpd_virtual_subdomain(foocom)
httpd_virtual_subdomain(barcom)
httpd_virtual_subdomain(bazcom)
user_virtual_access(jaspreet_t, foocom)
user_virtual_access(jaspreet_t, barcom)
user_virtual_access(bob_t, barcom)
user_virtual_access(manoj_t, foocom)
user_virtual_access(manoj_t, bazcom)

users.te:

user jaspreet roles { jaspreet_t };
user bob roles { bob_t };
user manoj roles { manoj_t };

That should do the trick.

> But, this would be computationally more complex to something like a role
> based approach.

Right, so the second approach would be:

domains/misc/local.te:
full_user_role(foocom_webmaster)
full_user_role(barcom_webmaster)
full_user_role(bazcom_webmaster)

users.te:

user jaspreet roles { foocom_webmaster_t barcom_webmaster_t };
user bob roles { barcom_webmaster_t };
user manoj roles { foocom_webmaster_t bazcom_webmaster_t };

This is a lot simpler from the policy side, but your users will have to
be aware of newrole.

> Now, I know only login method can assign roles , so what about the
> non-login sessions ???

You can use newrole to change between allowed roles, for example:
$ id
uid=3D500(jaspreet) gid=3D500(jaspreet) groups=3D500(jaspreet) context=3Dja=
spreet_u:foocom_webmaster_r:foocom_webmaster_t
$ $EDITOR /home/virtual/foocom/jaspreet/hi.html
$ newrole -r barcom_webmaster_t
Password for jaspreet: xxxxx
$ id
uid=3D500(jaspreet) gid=3D500(jaspreet) groups=3D500(jaspreet) context=3Dja=
spreet_u:barcom_webmaster_r:foocom_webmaster_t
$ $EDITOR /home/virtual/barcom/jaspreet/hi.html

> and one more thing which came to my mind was (may be irrelevent to the
> context) ... What if I "mount  --bind" contents of a directory to
> multiple places and give different file tags to the different mount
> points .. will the selinux system work properly in this scenario ( coz
> it wont in case of LIDS which rely upon ACLs)

During initial file labeling, SELinux ignores bind mounts.  Because it
labels the actual inodes instead of attempting to use runtime pathname-
based access, it doesn't matter if a program traverses to an inode via a
bind mount, it still has the same label.


--=-Bc7zGqGY2+570TGoZyEo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcp9JOIkJWWp2WGURAmHCAJ4ugLWFArAhICeiXMJuJ9y1O+8G8QCfYoAa
z3z7ad2U0S9w6c6CLTHZwas=
=GcFX
-----END PGP SIGNATURE-----

--=-Bc7zGqGY2+570TGoZyEo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
