Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJLNAIi024158
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 16:23:10 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJLLW3H003406
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 21:21:42 GMT
Message-Id: <200411192123.iAJLN2VL007405@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@verbum.org>, Greg Norris <haphazard@kc.rr.com>,
   SE-Linux <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Re: using procmail under SE-Linux 
In-Reply-To: Your message of "Fri, 19 Nov 2004 13:43:45 EST."
             <1100889824.15944.195.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20041119013811.GA21001@yggdrasil.localdomain> <1100837214.23707.15.camel@nexus.verbum.private>
            <1100889824.15944.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_187329901P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Nov 2004 16:23:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_187329901P
Content-Type: text/plain; charset=us-ascii

On Fri, 19 Nov 2004 13:43:45 EST, Stephen Smalley said:

> Nit:  That would be security_compute_create(), which internally consults
> type_transition rules.  security_compute_relabel() is for relabeling and
> consults type_change rules.
> 
> However, I think you would actually just use get_default_context(), and
> define appropriate entries in default_contexts for procmail.

That would probably work for a "first cut", but....

The "wrapper" plan won't work if your site uses procmail in LMTP
mode - as there it could be handed multiple recipients that end up needing to
run in different contexts.  At that point, the wrapper would need to be smart
enough to fork/exec() the "real" procmail once for each recipient, and do LMTP
to the MTA (which would require some major code refactoring, I suspect).
There's also uglyness with the procmail DROPPRIVS stuff.

(Mind you, the wrapper *will* work for the generic "invoke procmail as a
delivery aject from sendmail, and only run the user's .procmailrc as the
user, and don't use any of the advanced features" configuration - but there
*are* things that are going to require some major work/rewriting to do well
under selinux.)



--==_Exmh_187329901P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBnmQ0cC3lWbTT17ARAsw2AKDC+j9NlcR49Ey5QQ2N8rMr52dd9gCfUYLC
G9IGoFopM2A12czYiXftUkk=
=MGU5
-----END PGP SIGNATURE-----

--==_Exmh_187329901P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
