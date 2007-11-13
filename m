Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lADJjicb003089
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 14:45:44 -0500
Received: from mail1.exo2.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lADJjbKY014285
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 19:45:37 GMT
From: Steven Harp <steven.harp@adventiumlabs.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: pcscd and serial readers
Date: Tue, 13 Nov 2007 13:38:46 -0600
References: <200711131027.14488.steven.harp@adventiumlabs.org> <1194981952.13737.8.camel@gorn>
In-Reply-To: <1194981952.13737.8.camel@gorn>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711131338.47288.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 13 November 2007, you wrote:
> On Tue, 2007-11-13 at 10:27 -0600, Steven Harp wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> > The pcscd policy (daemon for smart card readers) handles USB 
> > readers fine, but balks--for me--when a serial port reader is 
> > configured (the daemon quietly dies).  
> > 
> > Module rev 1.1.0 includes a line:
> >  term_dontaudit_use_unallocated_ttys(pcscd_t)
> > 
> > Should this perhaps be:
> >  term_use_unallocated_ttys(pcscd_t)
> > ?
> 
> Sounds like it.  Did the serial reader start working when you allowed
> the access?
> 
> -- 
> Chris PeBenito

Yes: this permission seems to satisfy it.  An alternative here
might be to assign a special label to the designated serial 
port, (e.g. ttyS1) that would dedicate it to pcscd--we don't
move these old readers around too often. Not sure what else that
might break, or whether the policy author had such a label
in mind...

# Steve Harp  <steven.harp@adventiumlabs.org>


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHOf1HPcFX9H2zuSkRApD/AJ0dDHBFZvsDWeJQhKRbv3u42rVuQgCcDr+Y
IIPIbsHbok4/g3Da4GFE0bw=
=VdnM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
