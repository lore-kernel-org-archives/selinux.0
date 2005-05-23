Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NI3QgA009970
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 14:03:26 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NHwXhG013504
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 17:58:34 GMT
Message-Id: <200505231758.j4NHwkxZ020399@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Kurt Wall <kwall@kurtwerks.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit 
In-Reply-To: Your message of "Mon, 23 May 2005 18:14:22 BST."
             <20050523171422.GQ8953@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com> <20050522202555.GR10156@lkcl.net> <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu>
            <20050523171422.GQ8953@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116871125_3973P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 23 May 2005 13:58:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1116871125_3973P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 May 2005 18:14:22 BST, Luke Kenneth Casson Leighton said:

>  there _is_ no "start" option or "stop" option to the service
>  startup scripts.  if the script dies, the service is assumed to have
>  died: the signal is caught by depinit (all signals are caught by
>  depinit) and an "action" script e.g. /etc/depinit/sig_chld is called.
>  
>  if you _want_ the service to stop, you get depinit to automatically
>  send increasingly aggressive levels of signals to the "service" script.
> 
>  there _is_ no stupid numbering schemes - not the stupid symlinks, and
>  not the stupid runlevels.

This is actually irrelevant (mostly) as far as SELinux is concerned..

>  everything is _named_.  properly.

Again, mostly irrelevant..

>  the present policy - init.te, initrc.te - is therefore going
>  to be mostly irrelevant.

Actually *looking* at the .te's shows that *most* of it will, in fact,
still be applicable for *any* init-replacment.  The *important* part is
that the policy address things like "can the init-process access these
resources?" and "can the init-process launch the MTA process and have that
transition to the proper domain?" (domain-auto-trans does a *lot* of the
heavy lifting here - for instance, domains/program/mta.te contains:

domain_auto_trans(initrc_t, sendmail_exec_t, sendmail_t)

So as long as your depinit starts off in something that can get to initrc_t,
the kernel doesn't *CARE*.  I if an initrc_t fork/exec a sendmail_exec_t, and
it transitions to the needed domain.

Hell, I suspect that if you just put a:

/sbin/depinit --	system_u:object_r:initrc_exec_t

in file_contexts, 98% of it will Just Work.


--==_Exmh_1116871125_3973P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCkhnVcC3lWbTT17ARAmGsAKCCK2TDRB3wKKluD8MsL100psFopQCgn9O5
dMrChcI/MM3Gc72FigSeJUQ=
=U0oy
-----END PGP SIGNATURE-----

--==_Exmh_1116871125_3973P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
