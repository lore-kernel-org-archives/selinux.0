Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81K5KrT024255
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:05:21 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81K5Jeu016200
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 20:05:19 GMT
Date: Wed, 1 Sep 2004 18:47:18 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, debian-dpkg@lists.debian.org
Cc: scott@netsplit.com
Subject: Re: dpkg and selinux
Message-ID: <20040901174718.GE4400@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <1094004762.6901.68.camel@descent.netsplit.com> <20040901101921.GC5882@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040901101921.GC5882@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

a summary follows of the discussions of dpkg between scott and myself
(my thanks to scott for taking the time to read what i wrote yesterday,
 and for responding).

- dpkg needs in some way to set up the selinux file contexts of each
  and every file, directory, symlink and inode of a package it installs.

  if it does not do this, the default permissions are likely to be
  incorrect, such that the program is highly unlikely to work.

- russell's "postinst.d" patch is _one_ way to achieve this desired
  result: after files are unpacked, the list of files / directories
  of the package is taken and the selinux contexts are set on all
  those files and directories.

- dpkg "postinst" scripts, or more likely the /etc/init.d/* startup
  scripts MAY, in some unlikely cases, need to be modified to set
  permissions on files, directories or symlinks that they create
  INSIDE the "postinst" script or INSIDE their /etc/init.d/XXXX
  script.

  such modifications have, to date, found to be extremely rare.

  one recent example is, however, /etc/init.d/xfs which creates
  the directory /tmp/.font-unix and it is necessary to use
  restorecon to reset the permissions correctly on that directory.

- the proposed dpkg "trigger" system which scott kindly explained is
  an optimisation of the number of times that things like
  scrollkeeper-update, ldconfig, update-menus etc are called by
  package postinst scripts, to reduce these down to the absolute
  minimum [zero or one, at the end of a dpkg run].

- the dpkg "trigger" design would have to be stretched in order to
  fit selinux in, but should that be done, the resultant design
  could then also deal with "updatedb / locate" and other things
  that need to know what files a package has added or removed from
  a debian system.

- russell's "postinst.d" system is sufficiently confusingly similar
  to "triggers" such that it could end up being abused.

consequently, in short, it's probably best to patch dpkg's
"tarobject()" function to set the SE/Linux file permissions,
and to have those permissions preserved as the unpacked
archive is then moved into place.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
