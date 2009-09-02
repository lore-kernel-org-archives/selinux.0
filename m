Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n82DxIDR023251
	for <selinux@tycho.nsa.gov>; Wed, 2 Sep 2009 09:59:18 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n82E0Xgo027620
	for <selinux@tycho.nsa.gov>; Wed, 2 Sep 2009 14:00:34 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: "zheyeung" <zheyeung@gmail.com>
Subject: Re: I cannot change my shell context
Date: Wed, 2 Sep 2009 21:59:06 +0800
Cc: "fedora-selinux-list" <fedora-selinux-list@redhat.com>,
        "selinux" <selinux@tycho.nsa.gov>
References: <200909021107080933047@gmail.com>
In-Reply-To: <200909021107080933047@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4622421.AuIoI5JPiq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200909022159.10594.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart4622421.AuIoI5JPiq
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In Fedora users run unconfined, which, from my understand, means more or le=
ss=20
without restrictions imposed by SELinux.
Thus changing to sysadm_r shouldn't be necessary in the first place.

That you cannot change the context probably is because that context isn't=20
defined by the policy.

> hi , every body ,I install selinux-policy-targeted in my F11,and run in
> enforce mode. now I want to change selinux context of /tmp/test,but=20
> failed.I thought current shell domain was unconfined_t. then I intend to
> change my shell context to root:sysadm_r: sysadm_t ,but also failed. my
> project team plan to develop selinux policy for our system based on
> selinux-policy.src.rpm. I guess is  this package have not been developed?
> If it has been developed ,why I cannot change to sysadm_r: sysadm_t?
>
> -------------------------------------------------------------------------=
=2D-
>-
>
> [root@localhost ~]# ls -lZ /tmp/testselinux
> root root unconfined_u:object_r:user_t:user_tmp_t: s0 /tmp/testselinux
>
> [root@localhost ~]#chcon unconfined_u:object_r:mytest_t /tmp/testselinux
> chcon:failed to change context of '/tmp/testselinux' to
> 'unconfined_u:object_r:testselinux: s0 : permission denied
>
> ## here mytest_t defined in myapp.pp,which has successfully loaded by
> "semodule -i myapp.pp"
>
> [root@localhost ~]# newrole -r sysadm_r -t sysadm_t
> unconfined_u:unconfined_r:unconfined_t: s0 is not valid context
>
> [root@localhost ~]# semanage login -m -s root -r s0-s0:c0.c1023 root
>
> after reboot, graphic terminal cannot run. audit says that
> system_u:system_r: xdm_t require "read" permission for
> system_u:object_r:httpd_sys_content_t.
>
> [root@localhost ~]# id
> context=3D root:unconfined_r:unconfined_t: s0-s0:c0-c1023
>
> [root@localhost ~]#  newrole -r sysadm_r -t sysadm_t
> failed to exec shell: permission denied
> 2009-09-02
>
>
>
> zheyeung

--nextPart4622421.AuIoI5JPiq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqeei4ACgkQ1sXw8/2VziRj9gCeIScxY9ow9VTY9/R15N5Pxf/v
i90AoNa+OF7BhZ/FcefkC0Xx+ZPf7Tpc
=2fJ8
-----END PGP SIGNATURE-----

--nextPart4622421.AuIoI5JPiq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
