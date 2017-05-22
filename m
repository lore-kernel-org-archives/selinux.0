Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MGx92J007448
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 12:59:09 -0400
Received: by mail-wm0-f53.google.com with SMTP id 123so13276645wmg.1
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 09:58:55 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h33sm6256527edh.50.2017.05.22.09.58.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 May 2017 09:58:49 -0700 (PDT)
Date: Mon, 22 May 2017 18:58:47 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
Message-ID: <20170522165847.GA12310@julius.enp8s0.d30>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 09:29:10AM -0700, Chris O'Neil wrote:
> Hi, running latest RHEL 7.3 ... struggling with an SELinux issue related
> to Apache httpd that I just can't figure out.  I have always been able
> to tune policy or alter a boolean, this one has me stumped!
>=20
> What I am trying to do: I am trying to deploy a simple, 3 line CGI
> script in /var/www/cgi-bin/.  Runs fine with enforcement disabled (see
> output below).  My custom policy for Apache (see below) comes from my
> EL6 environment.
>=20
> The normal setroubleshooting tools don't help, as there is only a single
> line in audit.log (of type=3DSELINUX_ERR)
>=20
> This is not happening on latest RHEL 6.9 ...
>=20
> Might be related to systemd?  I don't see any "NoNewPrivileges"
> directives inside /etc/systemd/ though ... weird!

try grepping /usr/lib/systemd as well
also do you have "mod_selinux" enabled? because that requires a type bounds=
 as well AFAIK

>=20
> Many thanks for your help!
> -chris
>=20
>=20
> ########################################################################
> # With enforcement disabled ... all is good (as expected)
> ########################################################################
>=20
> # ls -laZ /var/www/cgi-bin/
> drwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 .
> drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..
> -rwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 ok.cgi
>=20
> # setenforce 0
> # systemctl restart httpd.service
> $ curl localhost/cgi-bin/ok.cgi
> OK
>=20
>=20
> ########################################################################
> # With enforcement enabled ... CGI script fails, all you find is a
> # single deny in /var/log/audit/audit.log
> ########################################################################
>=20
> # setenforce 1
> # systemctl restart httpd.service
>=20
> # getenforce
> Enforcing
>=20
> $ curl localhost/cgi-bin/ok.cgi
> <html><head><title>500 Server Error</title></head><body><h1>Server
> Error</h1></body></html>
>=20
> # tail /var/log/audit/audit.log | grep denied
> type=3DSELINUX_ERR msg=3Daudit(1495468154.591:121695):
> op=3Dsecurity_bounded_transition seresult=3Ddenied
> oldcontext=3Dsystem_u:system_r:httpd_t:s0
> newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
>=20
>=20
> ########################################################################
> # System details ...
> ########################################################################
>=20
> # uname -r
> 3.10.0-514.16.1.el7.x86_64
>=20
> # cat /etc/redhat-release
> Red Hat Enterprise Linux Server release 7.3 (Maipo)
>=20
> # sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy MLS status:              enabled
> Policy deny_unknown status:     allowed
> Max kernel policy version:      28
>=20
> # find /etc/ -type f | xargs grep NoNewPrivileges
> [NO OUTPUT]
>=20
> # getsebool -a | grep httpd_
> httpd_anon_write --> on
> httpd_builtin_scripting --> on
> httpd_can_check_spam --> off
> httpd_can_connect_ftp --> off
> httpd_can_connect_ldap --> off
> httpd_can_connect_mythtv --> off
> httpd_can_connect_zabbix --> off
> httpd_can_network_connect --> on
> httpd_can_network_connect_cobbler --> off
> httpd_can_network_connect_db --> on
> httpd_can_network_memcache --> off
> httpd_can_network_relay --> off
> httpd_can_sendmail --> on
> httpd_dbus_avahi --> on
> httpd_dbus_sssd --> off
> httpd_dontaudit_search_dirs --> off
> httpd_enable_cgi --> on
> httpd_enable_ftp_server --> off
> httpd_enable_homedirs --> off
> httpd_execmem --> off
> httpd_graceful_shutdown --> on
> httpd_manage_ipa --> off
> httpd_mod_auth_ntlm_winbind --> off
> httpd_mod_auth_pam --> off
> httpd_read_user_content --> on
> httpd_run_ipa --> off
> httpd_run_preupgrade --> off
> httpd_run_stickshift --> off
> httpd_serve_cobbler_files --> off
> httpd_setrlimit --> off
> httpd_ssi_exec --> off
> httpd_sys_script_anon_write --> off
> httpd_tmp_exec --> off
> httpd_tty_comm --> on
> httpd_unified --> on
> httpd_use_cifs --> off
> httpd_use_fusefs --> off
> httpd_use_gpg --> off
> httpd_use_nfs --> off
> httpd_use_openstack --> off
> httpd_use_sasl --> off
> httpd_verify_dns --> off
>=20
>=20
> # THIS IS MY GENERIC APACHE TE FILE FROM EL6 ...
>=20
> # cat myapache.te
> module myapache 0.4;
>=20
> require {
>         type httpd_t;
>         type httpd_sys_script_t;
>         type http_port_t;
>         type mysqld_port_t;
>         type rpm_var_cache_t;
>         type kernel_t;
>         class process { setpgid transition };
>         class system module_request;
>         class tcp_socket name_connect;
>         class dir { read search open getattr };
>         class file { open read getattr };
> }
>=20
> allow httpd_t rpm_var_cache_t:dir { read search open getattr };
> allow httpd_t rpm_var_cache_t:file { read getattr open } ;
> allow httpd_t mysqld_port_t:tcp_socket name_connect;
> allow httpd_sys_script_t self:process setpgid;
> allow httpd_sys_script_t http_port_t:tcp_socket name_connect;
> allow httpd_sys_script_t kernel_t:system module_request;
>=20
> #type=3DSELINUX_ERR msg=3Daudit(1495467001.822:84934):
> op=3Dsecurity_bounded_transition seresult=3Ddenied
> oldcontext=3Dsystem_u:system_r:httpd_t:s0
> newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
> # THIS STILL DOES NOT WORK! SYSTEMD ISSUE?
> allow httpd_t httpd_sys_script_t:process transition;
>=20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkjGMMACgkQJXSOVTf5
R2mKvAv+Ov6TeDo8usAAaOpRoPOo+bwLyoFdNep5pPdjpkw60vJnYhFSNnVuGBBj
w4W7nEHLigkL0mW4nI5wZxfg+WAAzqfZzpIurzzky/TAqsWfwz8yEOuE4jCzQwAv
SkKSQhpWFpzgftE9Jh9dAJV2dBpqnf9as1mGarDP8bamhAtp7wsfIQakXmaNLQ86
ZPfBjh7GcIlbVagrwlINnDuOPLeZqVeZXDVIfgAAFmfa6pkCGM2UDEv9AReYQqcc
zWQj6z9bdhEJw/hSGSzxlt5AKzwc8T6mRi143ZI3cpR5u0IMiQvSsTTU0BHYoDUM
7qM9X6/gO2yWKFle0MnmdWzJjYZmu5HpBNxJDQ4PmmTkPENcAx+zWCEpXtsRc+VC
YdFB04mZqc0u65HhSsiKlYc0cQQc3X91g2qPqlS6aU3OJZ78VVFgUyvl+DLAT7XX
XFyQs1llGhfpRbCfjsqNoIw0jAJNwjwO/v9/gjPSJgNYm9GgLLS5bTe8dGXKv+tD
Zp53DRhj
=MTsz
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
