Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OCMmrT025687
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:22:48 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OCM3MZ000300
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:22:03 GMT
Message-Id: <200408241222.i7OCMfoj019594@turing-police.cc.vt.edu>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive" 
In-Reply-To: Your message of "Tue, 24 Aug 2004 11:15:20 +0200."
             <20040824091520.GE11911@rom.cip.ifi.lmu.de>
From: Valdis.Kletnieks@vt.edu
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net>
            <20040824091520.GE11911@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1567746551P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 24 Aug 2004 08:22:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1567746551P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Aug 2004 11:15:20 +0200, Thomas Bleher said:

> This inserts a special line into the file_contexts file for every cdrom
> found on the system (according to proc).
> I am however not sure how a proper solution would look like; do we want
> to make policy that system dependant?

The concept that "all cdrom devices need a context foo_t" isn't at all system
dependent.  The actual names of the devices are by necessity system dependent -
on my Dell Latitude C840 laptop, the CD is /dev/hdb.  Across the hall, I have a
Dell 2650 rack-mount server - with a CD at /dev/hda.  Obviously, some hinting
will be required to get the hd* labeled right... ;)

> Maybe we need a tool like genhomedircon for devices.

At least under Fedora's version of pam, you can probably extract some
useful hints from /etc/security/console.perms (for more than just cdroms,
in fact).

Somebody not of the RedHat/Fedora persuasion will have to research if that
file has any useful info in other distros....

--==_Exmh_-1567746551P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBKzMRcC3lWbTT17ARAsr1AKDx05PxT8cR5NVZbTpHXhVoNjnHuQCfT7aq
0SxRRaEkkMqqZZc7GRiSzD4=
=+jOX
-----END PGP SIGNATURE-----

--==_Exmh_-1567746551P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
