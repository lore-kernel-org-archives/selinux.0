Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7M9XATr017898
	for <selinux@tycho.nsa.gov>; Sat, 22 Aug 2009 05:33:10 -0400
Received: from mail-ew0-f207.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7M9YH61025308
	for <selinux@tycho.nsa.gov>; Sat, 22 Aug 2009 09:34:18 GMT
Received: by ewy3 with SMTP id 3so1360264ewy.42
        for <selinux@tycho.nsa.gov>; Sat, 22 Aug 2009 02:33:08 -0700 (PDT)
Date: Sat, 22 Aug 2009 11:33:05 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: SELinux: Invalid object class mapping, disabling SELinux support.
	(XACE)
Message-ID: <20090822093304.GA2530@notebook3.grift.internal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just want to report that it seems SELinux support gets disabled with the Intel Xorg driver (in rawhide)

[root@notebook3 ~]# grep -i selinux /var/log/Xorg.0.log
(II) Loading extension SELinux
SELinux: Invalid object class mapping, disabling SELinux support.

(**) |-->Screen "Builtin Default intel Screen 0" (0)
(**) |   |-->Device "Builtin Default intel Device 0"
(==) No monitor specified for screen "Builtin Default intel Screen 0".
(II) LoadModule: "intel"
(II) Loading /usr/lib64/xorg/modules/drivers/intel_drv.so
(II) Module intel: vendor="X.Org Foundation"
(II) intel: Driver for Intel Integrated Graphics Chipsets: i810,


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqPu1AACgkQMlxVo39jgT96zgCfbyGxhNTeVRWLBo0vsTg4GnuL
60wAoK8jKnZb2JmSKuYBloCmQENTOm3B
=mUsN
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
