Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA11786
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 02:51:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA09590
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 06:49:12 GMT
Received: from ultraviolet.org (freeside.ultraviolet.org [192.215.175.10])
        by jazzband.ncsc.mil  with SMTP id GAA09586 for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 06:49:11 GMT
Date: Tue, 1 Oct 2002 23:50:17 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021001235017.B28686@ultraviolet.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <20021002074201.C28663@lemuria.org>; from tom@lemuria.org on Wed, Oct 02, 2002 at 07:42:01AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seemed like make relabel would be a good idea to ensure everything is
labelled properly after all of the messing around I have done and I got
this:

home:/etc/selinux# make relabel
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]|reis=
erfs)/{print $3}'`
/usr/sbin/setfiles:  Running on a SELinux kernel, using new system calls /u=
sr/sbin/setfiles:  read 767 specifications
/usr/sbin/setfiles:  invalid context system_u:object_r:home_root_t on line =
number 86
/usr/sbin/setfiles:  invalid context system_u:object_r:games_exec_t on line=
 number 616
/usr/sbin/setfiles:  invalid context system_u:object_r:var_log_inetd_t on l=
ine number 647
/usr/sbin/setfiles:  invalid context system_u:object_r:rndc_conf_t on line =
number 759
/usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on li=
ne number 995
/usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on li=
ne number 996
/usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on li=
ne number 997
/usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on li=
ne number 998
/usr/sbin/setfiles:  invalid context system_u:object_r:vmware_user_conf_t o=
n line number 1053
/usr/sbin/setfiles:  invalid context system_u:object_r:xauth_exec_t on line=
 number 1058
make: *** [relabel] Error 1


--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2alykACgkQ9PIYKZYVAq3x7QCcD71k+Ypg7ERBrFDyEg5e446A
37kAn272KuOtmIaXuPNCftl0ybv1ExU4
=uffc
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
