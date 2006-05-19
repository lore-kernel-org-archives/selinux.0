Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4J79ADS028584
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 03:09:10 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4J799fP028939
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 07:09:09 GMT
Message-Id: <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: Is SELinux appropriate for my use?
In-Reply-To: Your message of "Fri, 19 May 2006 05:05:17 +0900."
             <446CD37D.1020500@gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <446A0CE9.6020708@gmail.com> <200605171558.43653.russell@coker.com.au>
            <446CD37D.1020500@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148022504_4259P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 May 2006 03:08:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1148022504_4259P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <13183.1148022485.1@turing-police.cc.vt.edu>

On Fri, 19 May 2006 05:05:17 +0900, Tetsuji Maverick Rai said:

> What if apache's permission is set so that it isn't allowed to execute
> most commands?    But actually most commands (i.e. even cat, ls) can be
> dangerous, because it will display files containing mysql password.   So
> does SELinux exist to prevent attackers from executing these "usual"
> programs with http server's permissions(role)?   If so, I can understand
> a bit....actually I understand this is secure.

Remember - the design of SELinux is that *nothing* is permitted, unless
there's something in the policy that specifically says it's allowed.
So Apache can't even run /bin/cat unless there is a rule that says something
in httpd_t context (apache) is allowed to run bin_t binaries (bin_t includes
most common binaries).  However, /bin/ls *isn't* a bin_t, there's a separate
ls_exec_t for it, so things like ftpd can be restricted to be able to
run /bin/ls, but not other things in /bin.

(Aside for the list - anybody know why ftp.te in the 2.2.40 strict policy has:

corecmd_exec_bin(ftpd_t)
corecmd_exec_sbin(ftpd_t)
# Execute /bin/ls (can comment this out for proftpd)
# also may need rules to allow tar etc...
corecmd_exec_ls(ftpd_t)

I know why ftpd's traditionally need /bin/ls - what are exec_bin and
exec_sbin there for?)

--==_Exmh_1148022504_4259P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEbW7ocC3lWbTT17ARArzPAJwKthbxHhrpO//JWFgsBuDfbBZcDwCghtxJ
YUDcw8NUtfSXv/DfUvOIdwo=
=tKDu
-----END PGP SIGNATURE-----

--==_Exmh_1148022504_4259P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
