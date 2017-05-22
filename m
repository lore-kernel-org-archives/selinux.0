Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MHZZAS022185
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 13:35:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id 7so2252128wmo.1
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 10:35:18 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id t57sm9677591edb.28.2017.05.22.10.35.13
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 May 2017 10:35:14 -0700 (PDT)
Date: Mon, 22 May 2017 19:35:12 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
Message-ID: <20170522173512.GB12310@julius.enp8s0.d30>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <20170522165847.GA12310@julius.enp8s0.d30>
 <70193b55-19dd-58ad-1883-ba94dda52066@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <70193b55-19dd-58ad-1883-ba94dda52066@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 10:16:55AM -0700, Chris O'Neil wrote:
>=20
>=20
> On 05/22/2017 09:58 AM, Dominick Grift wrote:
> > On Mon, May 22, 2017 at 09:29:10AM -0700, Chris O'Neil wrote:
> >> Hi, running latest RHEL 7.3 ... struggling with an SELinux issue relat=
ed
> >> to Apache httpd that I just can't figure out.  I have always been able
> >> to tune policy or alter a boolean, this one has me stumped!
> >>
> >> What I am trying to do: I am trying to deploy a simple, 3 line CGI
> >> script in /var/www/cgi-bin/.  Runs fine with enforcement disabled (see
> >> output below).  My custom policy for Apache (see below) comes from my
> >> EL6 environment.
> >>
> >> The normal setroubleshooting tools don't help, as there is only a sing=
le
> >> line in audit.log (of type=3DSELINUX_ERR)
> >>
> >> This is not happening on latest RHEL 6.9 ...
> >>
> >> Might be related to systemd?  I don't see any "NoNewPrivileges"
> >> directives inside /etc/systemd/ though ... weird!
>=20
> >=20
> > try grepping /usr/lib/systemd as well
> > also do you have "mod_selinux" enabled? because that requires a type bo=
unds as well AFAIK
>=20
> Dominick, I did find the "NoNewPrivileges" directive inside of
> /usr/lib/systemd/system/systemd-importd.service ... commented it out,
> rebooted just to be safe ... no luck ... same problem as before, same
> message in /var/log/audit/audit.log.  Also tried changing the value from
> "Yes" to "No" and rebooting, that didn't help.

Yes that only applies to systemd-importd (which i suppose no one uses at le=
ast not with selinux enabled)

>=20
> $ curl localhost/cgi-bin/ok.cgi
> <html><head><title>500 Server Error</title></head><body><h1>Server
> Error</h1></body></html>
>=20
> # tail /var/log/audit/audit.log | grep denied
> type=3DSELINUX_ERR msg=3Daudit(1495473331.188:183):
> op=3Dsecurity_bounded_transition seresult=3Ddenied
> oldcontext=3Dsystem_u:system_r:httpd_t:s0
> newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
>=20
> Confirmed I do not have "mod_selinux" enabled ... this is a pretty
> vanilla deployment of RHEL 7 and Apache httpd

Are you using any other "exotic"/non-default apache modules? (i suppose not=
 since you already said its pretty vanilla)

>=20
> Thanks!
> -chris
>=20
> >=20
> >>
> >> Many thanks for your help!
> >> -chris
> >>
> >>
> >> ######################################################################=
##
> >> # With enforcement disabled ... all is good (as expected)
> >> ######################################################################=
##
> >>
> >> # ls -laZ /var/www/cgi-bin/
> >> drwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 .
> >> drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..
> >> -rwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 ok.=
cgi
> >>
> >> # setenforce 0
> >> # systemctl restart httpd.service
> >> $ curl localhost/cgi-bin/ok.cgi
> >> OK
> >>
> >>
> >> ######################################################################=
##
> >> # With enforcement enabled ... CGI script fails, all you find is a
> >> # single deny in /var/log/audit/audit.log
> >> ######################################################################=
##
> >>
> >> # setenforce 1
> >> # systemctl restart httpd.service
> >>
> >> # getenforce
> >> Enforcing
> >>
> >> $ curl localhost/cgi-bin/ok.cgi
> >> <html><head><title>500 Server Error</title></head><body><h1>Server
> >> Error</h1></body></html>
> >>
> >> # tail /var/log/audit/audit.log | grep denied
> >> type=3DSELINUX_ERR msg=3Daudit(1495468154.591:121695):
> >> op=3Dsecurity_bounded_transition seresult=3Ddenied
> >> oldcontext=3Dsystem_u:system_r:httpd_t:s0
> >> newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
> >>
> >>
> >> ######################################################################=
##
> >> # System details ...
> >> ######################################################################=
##
> >>
> >> # uname -r
> >> 3.10.0-514.16.1.el7.x86_64
> >>
> >> # cat /etc/redhat-release
> >> Red Hat Enterprise Linux Server release 7.3 (Maipo)
> >>
> >> # sestatus
> >> SELinux status:                 enabled
> >> SELinuxfs mount:                /sys/fs/selinux
> >> SELinux root directory:         /etc/selinux
> >> Loaded policy name:             targeted
> >> Current mode:                   enforcing
> >> Mode from config file:          enforcing
> >> Policy MLS status:              enabled
> >> Policy deny_unknown status:     allowed
> >> Max kernel policy version:      28
> >>
> >> # find /etc/ -type f | xargs grep NoNewPrivileges
> >> [NO OUTPUT]
> >>
> >> # getsebool -a | grep httpd_
> >> httpd_anon_write --> on
> >> httpd_builtin_scripting --> on
> >> httpd_can_check_spam --> off
> >> httpd_can_connect_ftp --> off
> >> httpd_can_connect_ldap --> off
> >> httpd_can_connect_mythtv --> off
> >> httpd_can_connect_zabbix --> off
> >> httpd_can_network_connect --> on
> >> httpd_can_network_connect_cobbler --> off
> >> httpd_can_network_connect_db --> on
> >> httpd_can_network_memcache --> off
> >> httpd_can_network_relay --> off
> >> httpd_can_sendmail --> on
> >> httpd_dbus_avahi --> on
> >> httpd_dbus_sssd --> off
> >> httpd_dontaudit_search_dirs --> off
> >> httpd_enable_cgi --> on
> >> httpd_enable_ftp_server --> off
> >> httpd_enable_homedirs --> off
> >> httpd_execmem --> off
> >> httpd_graceful_shutdown --> on
> >> httpd_manage_ipa --> off
> >> httpd_mod_auth_ntlm_winbind --> off
> >> httpd_mod_auth_pam --> off
> >> httpd_read_user_content --> on
> >> httpd_run_ipa --> off
> >> httpd_run_preupgrade --> off
> >> httpd_run_stickshift --> off
> >> httpd_serve_cobbler_files --> off
> >> httpd_setrlimit --> off
> >> httpd_ssi_exec --> off
> >> httpd_sys_script_anon_write --> off
> >> httpd_tmp_exec --> off
> >> httpd_tty_comm --> on
> >> httpd_unified --> on
> >> httpd_use_cifs --> off
> >> httpd_use_fusefs --> off
> >> httpd_use_gpg --> off
> >> httpd_use_nfs --> off
> >> httpd_use_openstack --> off
> >> httpd_use_sasl --> off
> >> httpd_verify_dns --> off
> >>
> >>
> >> # THIS IS MY GENERIC APACHE TE FILE FROM EL6 ...
> >>
> >> # cat myapache.te
> >> module myapache 0.4;
> >>
> >> require {
> >>         type httpd_t;
> >>         type httpd_sys_script_t;
> >>         type http_port_t;
> >>         type mysqld_port_t;
> >>         type rpm_var_cache_t;
> >>         type kernel_t;
> >>         class process { setpgid transition };
> >>         class system module_request;
> >>         class tcp_socket name_connect;
> >>         class dir { read search open getattr };
> >>         class file { open read getattr };
> >> }
> >>
> >> allow httpd_t rpm_var_cache_t:dir { read search open getattr };
> >> allow httpd_t rpm_var_cache_t:file { read getattr open } ;
> >> allow httpd_t mysqld_port_t:tcp_socket name_connect;
> >> allow httpd_sys_script_t self:process setpgid;
> >> allow httpd_sys_script_t http_port_t:tcp_socket name_connect;
> >> allow httpd_sys_script_t kernel_t:system module_request;
> >>
> >> #type=3DSELINUX_ERR msg=3Daudit(1495467001.822:84934):
> >> op=3Dsecurity_bounded_transition seresult=3Ddenied
> >> oldcontext=3Dsystem_u:system_r:httpd_t:s0
> >> newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
> >> # THIS STILL DOES NOT WORK! SYSTEMD ISSUE?
> >> allow httpd_t httpd_sys_script_t:process transition;
> >>
> >>
> >>
> >=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkjIUwACgkQJXSOVTf5
R2mrlAwAlDUUoSiXbNNpfeequV8kdXC5R4iqhXEW7P+0kwTffqCaK2R5dSACU5fC
ImXNTlhHg1Ru5dYHSMM3q70qPv0MGyE6BKNaVXMYf6A0HYbwBZoGJk947lkDTC8n
e/mTAOEfHui82avfjZV95MPDxKeeDJ6LvUgNyWquJJtnj0TEQOdC+KB06+/7BP2s
wYYcSyKTxgFU6USCdBFyrsLJ4PO8fBSvC1+mWperOe/xq5oRxlqKcmBt1L+HOgyI
bBLwiOGVg8Dp7GDoZZyCIyvjNjWKv884TZNsGLnJSK7rw+oZ67pCaTgD3Fvnawrm
g+x6U4MmTneSfwf9PgV1zts7FkC7QxH2yYoEa76YMYYHn1zC1dcbnz59kgqhqD1t
gOsfIWoGOPfSyY4fm5NCzAEQROTOce1+SlnelCwKx1eRYbQ24/z7aXEgh6B7xn2t
DdwTS4wLjqieljXtKAeGLnW43Gq0lOFUTGPV9RSYgPFUlwnQA7QWCBg0S6MECBEu
ahI5a9Ch
=8rMT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
