Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA17604
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 21:49:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA00930
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:47:31 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
        by jazzband.ncsc.mil  with ESMTP id BAA00926 for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:47:25 GMT
Date: Wed, 17 Jul 2002 09:48:39 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: Paul Krumviede <pwk@acm.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: inetd and tcpd services
In-Reply-To: <37841302.1026844041@localhost>
Message-ID: <Pine.LNX.4.44.0207170948130.678-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1





On Tue, 16 Jul 2002, Paul Krumviede wrote:

> --On Wednesday, 17 July, 2002 09:07 +0800 "Rogelio M. Serrano Jr."
> <rogelio@evoworks.evoserve.com> wrote:
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > im running imapd as an inetd service. in enforcing mode i cant access the
> > mail spool directory because tcpd_t does not have permissions to lock the
> > directory. should i create a new impadd_t or give tcpd_t permissions?
>
> out of curiousity, which IMAP package are you running? i've been thinking
> of creating a domain and the policy for the cyrus version...

im using uw-imap with ssl.
>
> anyway, i'd think you would be better off with a separate domain, as
> otherwise
> other things may have unnecessary access to things such as IMAP control
> files.
>
> -paul
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9NMz+6r8UsQIvzXwRAuoOAJ0fBGwZjnmD+/EgwOFpyNP/0RhSbACfZWgF
nEoAyHAR25G2uIcbFh5t1CM=
=bGko
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
