Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9RFb70U008196
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 11:37:07 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9RFaLlX023497
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 15:36:21 GMT
Message-Id: <200610271536.k9RFactr013813@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
In-Reply-To: Your message of "Fri, 20 Oct 2006 17:00:28 +1000."
             <200610201700.31748.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com> <45377BF0.6010403@redhat.com>
            <200610201700.31748.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1161963398_3167P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 27 Oct 2006 11:36:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1161963398_3167P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Oct 2006 17:00:28 +1000, Russell Coker said:
> On Thursday 19 October 2006 23:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > If we then remove -l from newrole we are done?
> 
> Why remove it?  Why not just cease using it and leave it there for other 
> people who have different needs?

I suspect that it wouldn't fly during an eval, because even if unused, it
would be a possible avenue to bypass the evel'ed config.  You'd probably
have to add a flag of some sort someplace that said if it was permitted.
(If done inside PAM, having the .so have an option 'allow-dash-l' and
submitting for eval with it not present would probably be OK).

--==_Exmh_1161963398_3167P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFQieGcC3lWbTT17ARAhcmAKD4qJnfNsupRd9NlMXdJEC69HNUzgCggjyO
b6XnbrfIYhbYtNzRDMXfY+g=
=ZFJj
-----END PGP SIGNATURE-----

--==_Exmh_1161963398_3167P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
