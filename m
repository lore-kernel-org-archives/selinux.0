Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6JLP4Ha009205
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 17:25:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6JLP3DW015230
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 21:25:03 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6JLP2eN015227 for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 21:25:03 GMT
Subject: my SELinux 2.5 policy tree
From: Colin Walters <walters@verbum.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058649692.2233.17.camel@columbia>
Mime-Version: 1.0
Date: 19 Jul 2003 17:21:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd like to announce the availability of my 2.5 SELinux policy tree;
this is where I'll do development work.  The Debian packages will only
be updated infrequently.

I've been using the "arch" revision control system to maintain it: 
http://arch.fifthvision.net/

Arch is really cool, and if you are at all interested in a RCS better
than CVS, it is very much worth checking out.  Arch is especially ideal
for the kind of situation we have with the various SELinux policies (the
NSA's, Russell's, and mine at least), which are strongly characterized
by asynchronous distributed development and repeated merging.

In particular you should use the "tla" implementation of arch, whose
homepage is:
http://regexps.srparish.net/www/

After you've got it installed, here's how to download my policy tree:

$ tla register-archive walters@debian.org--2003-debian http://arch.verbum.org/arch-debian
$ tla get walters@debian.org--2003-debian/policy--debian--1.0

After that you can update it with (in the policy directory):

$ tla update --in-place .

I should note that tla 1.0 is fairly limited; the development version
has many new features and cleanups that make it much more pleasant to
use.  Hopefully the 1.1 release will be out soon.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
