Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HHJ7rT003630
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 13:19:07 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HHJ6ut028134
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 17:19:06 GMT
Message-Id: <200409171719.i8HHJ1tP020778@turing-police.cc.vt.edu>
To: ivg2@cornell.edu
Cc: Colin Walters <walters@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux policy discussion. 
In-Reply-To: Your message of "Thu, 16 Sep 2004 15:53:09 EDT."
             <1095364389.10058.85.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <4148A003.6080309@redhat.com> <1095295125.4231.127.camel@nexus.verbum.private> <1095302625.28466.56.camel@localhost.localdomain> <1095307503.4231.152.camel@nexus.verbum.private> <1095318426.32510.30.camel@localhost.localdomain> <1095356254.4231.188.camel@nexus.verbum.private>
            <1095364389.10058.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-702390859P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 17 Sep 2004 13:19:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-702390859P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Sep 2004 15:53:09 EDT, Ivan Gyurdiev said:
> What I want from MAC is to restrict my applications while preserving
> 100% useful functionality and being transparent. I don't want more
> restrictions on my behavior.

The problem is defining "100% useful functionality" in a way that's compatible
with system security and integrity.  Remember that for the guy attacking the
system, being able to exploit a /tmp race is "useful functionality".
Conversely, there's a *lot* of crufty broken code out there that only works
because it abuses some corner-case quirk that really *should* be fixed.

> I don't want mozilla_readhome and mozilla_writehome that are false by 
> default so I can't save a web page to my home folder.

You'll sing a different tune if some hostile Javascript saves a .rhosts in your
home directory (or any other file that will produce surprising results).
There's a reason why FTP servers have for *ages* had an 'incoming' directory
for to sandbox inbound stuff till it's possible to hand-check inbound
content.  The only security-sane way to do this is to have a directory that
Mozilla *can* write to but which isn't trusted by anything else, requiring
the user to 'cp' or 'mv' the file out in order to do anything with it.

I don't see any problem with the concept that the 'strict' policy will make you
change the way you do things slightly, if the way you used to do things were
security-unwise procedures.  In fact, I welcome the idea - if the system
prohibits my users from doing stupid things, my job gets *easier*....


--==_Exmh_-702390859P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBSxyFcC3lWbTT17ARApqHAKCt5wJgypdW+xQm/fYTIEp0eT580gCdFJfU
o2NOEgz0IzY1H/Q4GUXAuxI=
=a9nc
-----END PGP SIGNATURE-----

--==_Exmh_-702390859P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
