Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4U1SfgA024432
	for <selinux@tycho.nsa.gov>; Sun, 29 May 2005 21:28:41 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4U1Mgg6005837
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 01:22:42 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 011EFBF7C
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 02:22:50 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DcZ7w-0007Iw-HB
	for selinux@tycho.nsa.gov; Mon, 30 May 2005 02:31:36 +0100
Date: Mon, 30 May 2005 02:31:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: gentoo/hardened
Message-ID: <20050530013136.GA28006@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i've just installed gentoo/hardened on a laptop, and i wanted to run
Xorg on it.

bearing in mind the warnings about gentoo/hardened not having
"workstation" capability, i noted these and carried on, happy in the
knowledge that i would be able to sort it out.

... then i found out what chris had done.

chris - i hope you don't mind me saying this...

... but you have made a _lot_ of work for yourself, and for
people like myself who would be happy to contribute / get
things working.

what chris has done is, rather than create (for example, as one
possible way forward) a gentoo_hardened define and comment out
blocks of code is... he's started from the sf.net cvs policy
and REMOVED entire sections from the gentoo released selinux
policy (including a large number of booleans).

that makes it _really_ difficult for me - or anyone else - to follow
what's gone on, and to add stuff in, because you first have to identify
the "missing" stuff, and then add in what you need.  maybe.  because
if you copy the sf.net policy files into a gentoo/hardened policy,
you find that they are out-of-date (missing defines, macros, even
missing flasks!)

so, i have a plea and a question:

* chris, would you _please_ consider tracking the sf cvs more closely,
  and submitting more patches to this list, rather than diverging?

* to the people maintaining selinux cvs, would you consider adding a
  define gentoo_hardened as well as a gentoo_selinux or consider
  anything else - _anything_ - that would make it possible to consider
  sf.net cvs the "authoritative" and central repository of selinux
  policy for all distros?

pooling resources and expertise in this complex area is the only _sane_
way forward.  massive forking of selinux policy on a per-distro basis is
a good way to ensure that expertise and volunteers are difficult to come
by.

... of course, as always, you are entirely at liberty to completely
ignore anything and/or everything i say: i am paid by no-one and answer
to no-one - i just want this stuff to be easier and for it to succeed.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
