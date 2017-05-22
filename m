Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MINs4C008925
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 14:23:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id 7so3234501wmo.1
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 11:23:54 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id y55sm8367066edb.12.2017.05.22.11.23.52
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 May 2017 11:23:52 -0700 (PDT)
Date: Mon, 22 May 2017 20:23:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
Message-ID: <20170522182350.GC12310@julius.enp8s0.d30>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <1495477109.24649.6.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
In-Reply-To: <1495477109.24649.6.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 02:18:29PM -0400, Stephen Smalley wrote:
> On Mon, 2017-05-22 at 09:29 -0700, Chris O'Neil wrote:
> > Hi, running latest RHEL 7.3 ... struggling with an SELinux issue
> > related
> > to Apache httpd that I just can't figure out.=A0=A0I have always been
> > able
> > to tune policy or alter a boolean, this one has me stumped!
> >=20
> > What I am trying to do: I am trying to deploy a simple, 3 line CGI
> > script in /var/www/cgi-bin/.=A0=A0Runs fine with enforcement disabled
> > (see
> > output below).=A0=A0My custom policy for Apache (see below) comes from =
my
> > EL6 environment.
> >=20
> > The normal setroubleshooting tools don't help, as there is only a
> > single
> > line in audit.log (of type=3DSELINUX_ERR)
> >=20
> > This is not happening on latest RHEL 6.9 ...
> >=20
> > Might be related to systemd?=A0=A0I don't see any "NoNewPrivileges"
> > directives inside /etc/systemd/ though ... weird!
>=20
> Is the filesystem mounted nosuid?

If selinux also uses that message for that scenario then i find that confus=
ing since the message, to me, implies that the issue can be find by adding =
a type bounds, but i don't think that would work for nosuid mounted slices
>=20
> >=20
> > Many thanks for your help!
> > -chris
> >=20
> >=20
> > #####################################################################
> > ###
> > # With enforcement disabled ... all is good (as expected)
> > #####################################################################
> > ###
> >=20
> > # ls -laZ /var/www/cgi-bin/
> > drwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 .
> > drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 ..
> > -rwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0
> > ok.cgi
> >=20
> > # setenforce 0
> > # systemctl restart httpd.service
> > $ curl localhost/cgi-bin/ok.cgi
> > OK
> >=20
> >=20
> > #####################################################################
> > ###
> > # With enforcement enabled ... CGI script fails, all you find is a
> > # single deny in /var/log/audit/audit.log
> > #####################################################################
> > ###
> >=20
> > # setenforce 1
> > # systemctl restart httpd.service
> >=20
> > # getenforce
> > Enforcing
> >=20
> > $ curl localhost/cgi-bin/ok.cgi
> > <html><head><title>500 Server Error</title></head><body><h1>Server
> > Error</h1></body></html>
> >=20
> > # tail /var/log/audit/audit.log | grep denied
> > type=3DSELINUX_ERR msg=3Daudit(1495468154.591:121695):
> > op=3Dsecurity_bounded_transition seresult=3Ddenied
> > oldcontext=3Dsystem_u:system_r:httpd_t:s0
> > newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
> >=20
> >=20
> > #####################################################################
> > ###
> > # System details ...
> > #####################################################################
> > ###
> >=20
> > # uname -r
> > 3.10.0-514.16.1.el7.x86_64
> >=20
> > # cat /etc/redhat-release
> > Red Hat Enterprise Linux Server release 7.3 (Maipo)
> >=20
> > # sestatus
> > SELinux status:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0enabl=
ed
> > SELinuxfs mount:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/sys/fs=
/selinux
> > SELinux root directory:=A0=A0=A0=A0=A0=A0=A0=A0=A0/etc/selinux
> > Loaded policy name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0targeted
> > Current mode:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
nforcing
> > Mode from config file:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0enforcing
> > Policy MLS status:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0enabled
> > Policy deny_unknown status:=A0=A0=A0=A0=A0allowed
> > Max kernel policy version:=A0=A0=A0=A0=A0=A028
> >=20
> > # find /etc/ -type f | xargs grep NoNewPrivileges
> > [NO OUTPUT]
> >=20
> > # getsebool -a | grep httpd_
> > httpd_anon_write --> on
> > httpd_builtin_scripting --> on
> > httpd_can_check_spam --> off
> > httpd_can_connect_ftp --> off
> > httpd_can_connect_ldap --> off
> > httpd_can_connect_mythtv --> off
> > httpd_can_connect_zabbix --> off
> > httpd_can_network_connect --> on
> > httpd_can_network_connect_cobbler --> off
> > httpd_can_network_connect_db --> on
> > httpd_can_network_memcache --> off
> > httpd_can_network_relay --> off
> > httpd_can_sendmail --> on
> > httpd_dbus_avahi --> on
> > httpd_dbus_sssd --> off
> > httpd_dontaudit_search_dirs --> off
> > httpd_enable_cgi --> on
> > httpd_enable_ftp_server --> off
> > httpd_enable_homedirs --> off
> > httpd_execmem --> off
> > httpd_graceful_shutdown --> on
> > httpd_manage_ipa --> off
> > httpd_mod_auth_ntlm_winbind --> off
> > httpd_mod_auth_pam --> off
> > httpd_read_user_content --> on
> > httpd_run_ipa --> off
> > httpd_run_preupgrade --> off
> > httpd_run_stickshift --> off
> > httpd_serve_cobbler_files --> off
> > httpd_setrlimit --> off
> > httpd_ssi_exec --> off
> > httpd_sys_script_anon_write --> off
> > httpd_tmp_exec --> off
> > httpd_tty_comm --> on
> > httpd_unified --> on
> > httpd_use_cifs --> off
> > httpd_use_fusefs --> off
> > httpd_use_gpg --> off
> > httpd_use_nfs --> off
> > httpd_use_openstack --> off
> > httpd_use_sasl --> off
> > httpd_verify_dns --> off
> >=20
> >=20
> > # THIS IS MY GENERIC APACHE TE FILE FROM EL6 ...
> >=20
> > # cat myapache.te
> > module myapache 0.4;
> >=20
> > require {
> > =A0=A0=A0=A0=A0=A0=A0=A0type httpd_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0type httpd_sys_script_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0type http_port_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0type mysqld_port_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0type rpm_var_cache_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0type kernel_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0class process { setpgid transition };
> > =A0=A0=A0=A0=A0=A0=A0=A0class system module_request;
> > =A0=A0=A0=A0=A0=A0=A0=A0class tcp_socket name_connect;
> > =A0=A0=A0=A0=A0=A0=A0=A0class dir { read search open getattr };
> > =A0=A0=A0=A0=A0=A0=A0=A0class file { open read getattr };
> > }
> >=20
> > allow httpd_t rpm_var_cache_t:dir { read search open getattr };
> > allow httpd_t rpm_var_cache_t:file { read getattr open } ;
> > allow httpd_t mysqld_port_t:tcp_socket name_connect;
> > allow httpd_sys_script_t self:process setpgid;
> > allow httpd_sys_script_t http_port_t:tcp_socket name_connect;
> > allow httpd_sys_script_t kernel_t:system module_request;
> >=20
> > #type=3DSELINUX_ERR msg=3Daudit(1495467001.822:84934):
> > op=3Dsecurity_bounded_transition seresult=3Ddenied
> > oldcontext=3Dsystem_u:system_r:httpd_t:s0
> > newcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0
> > # THIS STILL DOES NOT WORK! SYSTEMD ISSUE?
> > allow httpd_t httpd_sys_script_t:process transition;
> >=20
> >=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkjLLIACgkQJXSOVTf5
R2lXawv/TVpjtPSa3e5v36wPLJEkKkae/Jown0jm9fDifU8prrtZLf+WD7o1CFPM
RMIt1iRqNgAy3RajYn3c84oA9FNa4sn1YWuu3rMhl2zUm0bHUTM2jK87VtTXuZKa
DQMq6bH8CJ6vsofbhjJLMZi7+CA5H79Bey6dmdHvMjliOhrB+jDlllV5aa9qCR4Y
9+1b2gUSPrr0qCKYftFHLqL/rj4lGSODng89Jxlyw/vG4hBYUCnJbZPO5ZoYDNuj
GocfOSbXkFKEVyCh/HF8jR94s7VpK0UKwuqIY5bv2ovGXzCPas6YQjqnJzR5pzam
wFLtg/Jk/RrdFC2DS614F8PzGarSpjG8A5DkDrR+ZK82BSyuQaVBjaRdLh5B+m1p
9sRYOTF9h192enkhBy7qsg15FqOxgJminLQ9SD74z5RRRW90pEOXSttQp5LjWZbl
pCGfpbYQbG++gKvnyJj79jmHdqT6uCq5fpR0x2W+gp1VWw7BojWVTwrH7ygIh5ao
Oo2A1P45
=Yfm4
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
