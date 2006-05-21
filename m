Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4L3mJPF011540
	for <selinux@tycho.nsa.gov>; Sat, 20 May 2006 23:48:19 -0400
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4L3mII5024471
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 03:48:18 GMT
Message-Id: <200605210347.k4L3lwl9012271@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
Subject: Re: Is SELinux appropriate for my use?
In-Reply-To: Your message of "Fri, 19 May 2006 23:54:27 +1000."
             <200605192354.31161.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <446A0CE9.6020708@gmail.com> <446CD37D.1020500@gmail.com> <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
            <200605192354.31161.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148183277_32020P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 20 May 2006 23:47:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1148183277_32020P
Content-Type: text/plain; charset=us-ascii

On Fri, 19 May 2006 23:54:27 +1000, Russell Coker said:
> On Friday 19 May 2006 17:08, Valdis.Kletnieks@vt.edu wrote:
> > (Aside for the list - anybody know why ftp.te in the 2.2.40 strict policy
> > has:
> >
> > corecmd_exec_bin(ftpd_t)
> > corecmd_exec_sbin(ftpd_t)
> > # Execute /bin/ls (can comment this out for proftpd)
> > # also may need rules to allow tar etc...
> > corecmd_exec_ls(ftpd_t)
> >
> > I know why ftpd's traditionally need /bin/ls - what are exec_bin and
> > exec_sbin there for?)
> 
> Traditionally ftp servers (IE the wuftpd) has supported "get file.gz" and
> "get directory.tar.gz" and the FTP server would have to execute programs 
> from /bin and /usr/bin accordingly.  This means that for the full ftpd 
> functionality corecmd_exec_bin is required.

OK.. so exec_bin is there because nobody has done the work to tag tar/zcat
similar to the existing tagging of /bin/ls.

> Incidentally I still don't think that we need separation of sbin_t and bin_t.  
> The choice of which programs go in which directories is rather arbitrary and 
> is not based on security criteria.  We have no expectation that sbin_t and 
> bin_t will have different integrity (the system integrity entirely depends on 
> the integrity of both those types) and we also expect that there is no secret 
> data labeled with either of those types.  So it seems to me that making 
> sbin_t and ls_exec_t both aliases for bin_t would be the correct thing to do.

I agree that sbin_t and bin_t should be merged - the original bin vs sbin
distinction was that "user stuff in bin, stuff used by admins in sbin". But
then stuff like 'ping' ended up in sbin and blurred things.

I'm not sure if ls_exec_t should go - the alternative is to also tag 'tar'
and 'zcat' and whatever else is needed by FTP servers that support the
automagic .tar.gz stuff.

> PS  Valdis, if you want to send email to me directly then you need to send it 
> through a mail server on a fixed IP address.  My mail server will reject 
> connections from any machine that is in a dialup range.

Darn.  I thought I taught my laptop to DTRT if it realized it was at home
on DSL.   Wonder what I busticated.

--==_Exmh_1148183277_32020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEb+LtcC3lWbTT17ARAmTQAJwP8N8wM7pEKGkxlC5Wsu4CXWqyEwCgyMKK
k5wQvrHYs9kKAFvJj3/EE40=
=Gd9q
-----END PGP SIGNATURE-----

--==_Exmh_1148183277_32020P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
