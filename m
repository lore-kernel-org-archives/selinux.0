Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n83ExanU018908
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 10:59:36 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n83EwvID022376
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 14:58:58 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: "Remmolt G. Zwartsenberg" <remmolt@zwartsenberg.eu>
Subject: Re: I cannot change my shell context
Date: Thu, 3 Sep 2009 22:59:22 +0800
Cc: selinux@tycho.nsa.gov
References: <CIEOKAFOMGPNJIPMMMAHAEDJCCAA.remmolt@zwartsenberg.eu>
In-Reply-To: <CIEOKAFOMGPNJIPMMMAHAEDJCCAA.remmolt@zwartsenberg.eu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1277748.cToS2NObgI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200909032259.29605.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart1277748.cToS2NObgI
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sorry, but I seem to be missing your point.

> i use python as middleware between Windows and Linux partitions.
> the only 'root' account is used by cron (and 2 64 bit Intel Xeons, of
> course)
>
> All users scream for windows, this is why i hate userspace issues,
> especially @ Shell.
>
> ~remmolt
>
> -----Oorspronkelijk bericht-----
> Van: owner-selinux@tycho.nsa.gov
> [mailto:owner-selinux@tycho.nsa.gov]Namens Dennis Wronka
> Verzonden: Wednesday, September 02, 2009 3:59 PM
> Aan: zheyeung
> CC: fedora-selinux-list; selinux
> Onderwerp: Re: I cannot change my shell context
>
>
> In Fedora users run unconfined, which, from my understand, means more or
> less
> without restrictions imposed by SELinux.
> Thus changing to sysadm_r shouldn't be necessary in the first place.
>
> That you cannot change the context probably is because that context isn't
> defined by the policy.
>
> > hi , every body ,I install selinux-policy-targeted in my F11,and run in
> > enforce mode. now I want to change selinux context of /tmp/test,but
> > failed.I thought current shell domain was unconfined_t. then I intend to
> > change my shell context to root:sysadm_r: sysadm_t ,but also failed. my
> > project team plan to develop selinux policy for our system based on
> > selinux-policy.src.rpm. I guess is  this package have not been developed?
> > If it has been developed ,why I cannot change to sysadm_r: sysadm_t?
> >
> > -------------------------------------------------------------------------
> >-
>
> -
>
> >-
> >
> > [root@localhost ~]# ls -lZ /tmp/testselinux
> > root root unconfined_u:object_r:user_t:user_tmp_t: s0 /tmp/testselinux
> >
> > [root@localhost ~]#chcon unconfined_u:object_r:mytest_t /tmp/testselinux
> > chcon:failed to change context of '/tmp/testselinux' to
> > 'unconfined_u:object_r:testselinux: s0 : permission denied
> >
> > ## here mytest_t defined in myapp.pp,which has successfully loaded by
> > "semodule -i myapp.pp"
> >
> > [root@localhost ~]# newrole -r sysadm_r -t sysadm_t
> > unconfined_u:unconfined_r:unconfined_t: s0 is not valid context
> >
> > [root@localhost ~]# semanage login -m -s root -r s0-s0:c0.c1023 root
> >
> > after reboot, graphic terminal cannot run. audit says that
> > system_u:system_r: xdm_t require "read" permission for
> > system_u:object_r:httpd_sys_content_t.
> >
> > [root@localhost ~]# id
> > context= root:unconfined_r:unconfined_t: s0-s0:c0-c1023
> >
> > [root@localhost ~]#  newrole -r sysadm_r -t sysadm_t
> > failed to exec shell: permission denied
> > 2009-09-02
> >
> >
> >
> > zheyeung
>
> Geen virus gevonden in het binnenkomende-bericht.
> Gecontroleerd door AVG - www.avg.com
> Versie: 8.5.409 / Virusdatabase: 270.13.76/2343 - datum van uitgifte:
> 09/03/09 05:50:00

--nextPart1277748.cToS2NObgI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqf2dEACgkQ1sXw8/2VziQoQgCfZApEJ4KuCA2cazKAN09gxMnD
ZZ8An1DyeiLcRjZkgH34/q+1FHfBK7GU
=FSi3
-----END PGP SIGNATURE-----

--nextPart1277748.cToS2NObgI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
