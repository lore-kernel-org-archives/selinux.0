Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AJLkRb017371
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 15:21:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4AJJQ5b028858
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 19:19:26 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
	by jazzswing.ncsc.mil  with ESMTP id i4AJJQql028855
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 19:19:26 GMT
Message-Id: <200405101921.i4AJLdbm010270@turing-police.cc.vt.edu>
To: Serge Hallyn <hallyn@cs.wm.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules 
In-Reply-To: Your message of "Mon, 10 May 2004 13:32:35 CDT."
             <1084213955.17955.6.camel@serge.austin.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
            <1084213955.17955.6.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_162617846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 10 May 2004 15:21:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_162617846P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 13:32:35 CDT, Serge Hallyn said:
> Both the /proc and network restrictions are done in ways which are
> probably not acceptable to the kernel maintainers anyway.  For /proc, I
> am considering doing a simpler inode_permission on pathname based
> restriction.  This may be a part of the next version (which I have to
> put out to handle iopl() and shared memory anyway.)

Would you be open to a collaboration?  A lot of my module is stuff that I'm
re-implementing mostly because it's such a pain to stack modules,
and I have some people that want selinux+chroot, some that want
selinux+tempdir, and some that want chroot+tempdir, and nobody
seems to like the invasiveness level of the grsecurity patch..

> For network restrictions, I'm open to suggestions for another way to
> implement these.

I admit not having thought about them yet, other than to realize that it's
a messy issue... ;)

> Regarding the task_security.  One possibility would be for selinux to
> have a task_security->secondary pointer, and change get_security and
> set_security in bsdjail.c to use task_security->secondary if it found it
> was loaded under selinux.

Unfortunately, that's probably a dead end.  What you'd probably want to
do is generalize the *_alloc_security() routines to support a linked list of
structures of the form:

struct sec_mem {	struct secmem *next; int magic; void *blob};

(I seem to remember that being proposed on the LSM list, and shot down
because it was encouraging massive stacking of modules, with the resulting
composition issues...)

> Of course, another possibility which I prefer is to use the stacker lsm
> and rewrite selinux to use that  :)

Unfortunately, Stephen Smalley is right - rampant composition is generally
a bad idea.


--==_Exmh_162617846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAn9ZDcC3lWbTT17ARAhrJAKD3w92Eesd2CeemzGz6T1d7F4NPvQCdEvAu
8BOfAvmsQA1i/WFE8dpPm1k=
=xzZF
-----END PGP SIGNATURE-----

--==_Exmh_162617846P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
