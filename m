Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21247
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 10:56:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19192
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 14:54:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA19188
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 14:54:49 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09571
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 10:56:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18925
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 07:44:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA29381
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 05:44:04 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id FAA29377
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 05:44:02 GMT
Date: Fri, 20 Sep 2002 12:21:48 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE-Linux packages
Message-ID: <20020920022148.GA12250@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have compiled SE-Linux versions of all required packages (except
fileutils[1]) for Debian stable. For this, I have back ported Russell's
changes to the stable version of the package, and compiled it under
a stable chroot pbuilder. This differs from Russell's approach; Russell
preferred to recompile the unstable version for stable.

While most packages are the stable version, I have used the unstable
version of logrotate, as I have been told that the stable version
of logrotate is buggy (note that the stable version is available,
just not referenced by the Packages.gz index).

There is also a kernel-source 2.4.19, with patches for SE-Linux,
ISDN DOV, and Freeswan. Also available are prebuilt kernel images
(based on the kernel-image-2.4.19-386 source package in Debian).

Also available, but not indexed in any way are udebs of the
kernel, which might be useful in creating a SE-Linux boot
disk for SE-Linux, using Debian-installer, in the future.

There are exactly three known bugs:

[1] fileutils is not available; I cannot apply the patch cleanly
to the stable version, and the unstable version requires a version
of texinfo to build not available in stable (I might end up
disabling building the documentation, same as Russell did).

[2] The kernel-image source package is missing a build depends
on libssl-dev.

[3] If installing packages after the SE-Linux version of dpkg has
been installed, but a SE-Linux kernel is not yet booted,
/etc/dpkg/postinst.d/selinux broke badly, and I had to disable it.

These packages have not yet experienced major testing, but
I would be surprised if there are any other significant problems.
Please let me know if you observe otherwise.

The apt-get entries to use are:

deb http://www.microcomaustralia.com.au/debian/ stable selinux
deb-src http://www.microcomaustralia.com.au/debian/ stable selinux

Or, if you want to access my other packages for stable (eg. amavis,
kerberos4kth, Heimdal, etc) too:

deb http://www.microcomaustralia.com.au/debian/ stable main selinux
deb-src http://www.microcomaustralia.com.au/debian/ stable main selinux

Comments?
-- 
Brian May <bam@snoopy.apana.org.au>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
