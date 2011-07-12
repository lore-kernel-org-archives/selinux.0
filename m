Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6CFTCHs024913
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 11:29:12 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6CFTBwW006647
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 15:29:12 GMT
Received: by ewy8 with SMTP id 8so1864537ewy.12
        for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 08:29:11 -0700 (PDT)
Subject: Re: SELinux and CGI scripts
From: Dominick Grift <domg472@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: selinux@tycho.nsa.gov
Date: Tue, 12 Jul 2011 17:28:55 +0200
In-Reply-To: <1310483032.4294.26.camel@mattotaupa>
References: <1310483032.4294.26.camel@mattotaupa>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gV+DSCdnhOpAQ5jKQ1p/"
Message-ID: <1310484549.2647.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gV+DSCdnhOpAQ5jKQ1p/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2011-07-12 at 17:03 +0200, Paul Menzel wrote:

>         [=E2=80=A6]
>=20
>         $ sudo cat /var/log/audit/audit.log | audit2allow -l -m local
>        =20
>         #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D httpd_sys_script_t =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         allow httpd_sys_script_t devlog_t:sock_file getattr;
>         allow httpd_sys_script_t net_conf_t:file getattr;
>         allow httpd_sys_script_t user_home_dir_t:dir search;
>        =20
>         #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D httpd_t =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         allow httpd_t httpd_sys_script_t:process { siginh rlimitinh noats=
ecure };
>=20
> But I want to make sure first, what the recommended way is.



> 1. Am I right, that the default behavior is very strict and that
> allowing exceptions for certain programs is needed?

The system script domain has only limited access yes. I would probably
not modify the system script domain but instead create a new script
domain tailored to your scripts requirements using the
apache_content_template() and then extend that your your scripts
requirements.

> 2. What is the reason that `getattr` is not by default allowed for
> scripts having the `httpd_sys_script_t` attribute(?)?

Basically "least privilege" i guess. If the system script isnt not
supposed to be able to "sysnet read config" then there is no need to
allow it to get attributes of files with type netconf_t. Same for
"logging_send_syslog_msg", if the script is not supposed to be able to
send syslog msgs then no need to allow it to get attributes of the
devlog_t sock file.

> 3. If you have time, do you think the above exceptions sound
> sane/secure?

I guess your we webapp may at some point want to connect to the network.
(because its trying to read resolv.conf (probably?)

Besides that it seems your webapp wants to send messages to syslog.

It also seems to want to search user home directories (why? what
business does it have there?)

The following does not have to be allowed:

allow httpd_t httpd_sys_script_t:process { siginh rlimitinh
noatsecure };

> 4. Is there a write up how to configure SELinux on Web servers?
>=20

Google for "Fedora managing confined services"
>=20
> Thanks,

Here is what a module would look like:

mkdir ~/myapp; cd ~/myapp
echo "policy_module(myapp, 1.0.0)" apache_content_template(myapp)
sysnet_read_config(httpd_myapp_script_t)
logging_send_syslog_msg(httpd_myapp_script_t)" > myapp.te

make -f /usr/share/selinux/devel/Makefile myapp.pp
sudo semodule -i myapp.pp
chcon -t httpd_myapp_script_exec_t /path/to/myapp.cgi

if your app is supposed to be able to search user home dirs then you can
try:

setsebool -P httpd_enable_homedirs on

> Paul
>=20
>=20
> [1] https://secure.wikimedia.org/wikipedia/en/wiki/Common_Gateway_Interfa=
ce
> [2] http://ikiwiki.info/

--=-gV+DSCdnhOpAQ5jKQ1p/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk4caDcACgkQMlxVo39jgT/SxgCgqmKZppnUL92cEhX0ZnVYJkeZ
3ZYAmwQbxnWGL55xBGxuZ74DUVYzYwGg
=RZv4
-----END PGP SIGNATURE-----

--=-gV+DSCdnhOpAQ5jKQ1p/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
