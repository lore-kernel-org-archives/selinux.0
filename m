Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4811g6p007141
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 21:01:42 -0400
Received: from h80ad2474.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4811diA024865
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 01:01:40 GMT
Message-Id: <200605080101.k4811Gle007489@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /etc/mtab and namespaces
In-Reply-To: Your message of "Sun, 07 May 2006 23:45:45 +1000."
             <200605072345.49483.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200605072345.49483.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147050074_2578P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 07 May 2006 21:01:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147050074_2578P
Content-Type: text/plain; charset=us-ascii

On Sun, 07 May 2006 23:45:45 +1000, Russell Coker said:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190962
> I have filed a bugzilla entry requesting that /etc/mtab be made a sym-link 
> to /proc/mounts to allow df(1) to work correctly when multiple name spaces 
> are being used.

Not that simple - first all the code that uses /etc/mtab has to be fixed
to deal with the slight differences between mtab and /proc/mounts.

On my system at the moment:

/etc/mtab has:

none /proc proc rw 0 0
/dev/hda1 /boot ext3 ro,noexec,nosuid,nodev,noatime,nodiratime 0 0
none /tmp tmpfs rw,noexec,nosuid,nodev,noatime,nodiratime,size=1532M,mode=1777 0 0
/dev/mapper/rootvg-var /var ext3 rw,noexec,nodev,noatime,nodiratime,usrquota,grpquota 0 0

and /proc/mounts says:

/proc /proc proc rw 0 0
/dev/hda1 /boot ext3 ro,nosuid,nodev,noexec,noatime,nodiratime,data=ordered 0 0
none /tmp tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/rootvg/var /var ext3 rw,nodev,noexec,noatime,nodiratime,data=ordered,usrquota,grpquota 0 0

If you're *positive* that nothing in userspace cares about the differences
noted, it might be doable...  Big "if" though...


--==_Exmh_1147050074_2578P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEXphacC3lWbTT17ARAo08AJ9JlLcDYvJ6uZ1VH11y9ahb4kGcXACg+7S5
5jTBooFA5z+VH/hQEW0c6sM=
=b5GE
-----END PGP SIGNATURE-----

--==_Exmh_1147050074_2578P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
