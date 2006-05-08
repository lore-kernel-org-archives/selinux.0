Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48KWfxd030517
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 16:32:41 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48KWetw002125
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 20:32:41 GMT
Message-Id: <200605082032.k48KWXIl030673@turing-police.cc.vt.edu>
To: Janak Desai <janak@us.ibm.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pam_namespace
In-Reply-To: Your message of "Mon, 08 May 2006 09:44:24 EDT."
             <445F4B38.9080808@us.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <200605051623.25533.russell@coker.com.au> <200605071928.22799.russell@coker.com.au> <200605080107.k4817awO007711@turing-police.cc.vt.edu> <200605081328.02493.russell@coker.com.au>
            <445F4B38.9080808@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147120353_2623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 08 May 2006 16:32:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147120353_2623P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 May 2006 09:44:24 EDT, Janak Desai said:
> >>The problem is that the pam_namespace is still running in a system context,
> >>but since an earlier pam_selinux called setexeccon(), when namespace
> >>does an exec, it gets parked in the user context that pam_selinux intended
> >>to inflict on the actual user login...
> >That's easy to solve, just call setexeccon(NULL) before doing the exec.  As a
> >child process is used for this (if exec fails it calls exit(1)) there is not
> >even any need to save the old value of the execcon.
> Yes, that's exactly what I was going to do. Late last week, I was 
> distracted by non pam_namespace
> related tasks, but hopefully I can test and post an updated patch today.

I grabbed the updated patch, and tested.  The script now runs in local_login_t for logins from
the console:

May  8 16:21:38 turing-police LOGIN[30328]: called with args /tmp /tmp/tmp.system_u:object_r:staff_tmp_t_valdis uid=0(root) gid=0(root) groups=10(wheel),967(valdis) context=system_u:system_r:local_login_t:SystemLow-SystemHigh

I still need to test my script with gdm - that was broken (my fault) last time
I tried it...

--==_Exmh_1147120353_2623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEX6rhcC3lWbTT17ARAlK1AJ0ZCr5TXxuEmq2e3wUzBAdc3bAL0ACdGQc4
Ju35S3cRKaF2EiNnEJHLDW8=
=OFWY
-----END PGP SIGNATURE-----

--==_Exmh_1147120353_2623P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
