Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6JL0BHa009146
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 17:00:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6JKx7FB029491
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 20:59:07 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6JKx7GD029488
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 20:59:07 GMT
Subject: experimental SEDebian 2.5 packages
From: Colin Walters <walters@verbum.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058648176.681.14.camel@columbia>
Mime-Version: 1.0
Date: 19 Jul 2003 16:56:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've created Debian packages of the SELinux 2.5 bits, and my policy. 
This is still experimental, please don't deploy it on production
systems.  That being said, most of it seems to work for me, and I can
boot in enforcing mode with a base Debian installation.

Before you install these; note that I doubt I am going to have time to
continuously keep up with all the rapid changes that happen in Debian
unstable.  This means you have to be very careful when upgrading to
ensure that a .selinux package isn't removed.  I recommend you put all
the .selinux packages on hold after you've installed them.

In summary, while I'm interested in hearing feedback on these packages,
if you are new to SELinux, and especially if you are not an experienced
Debian user, I recommend you stick with Linux 2.4 and Russell's packages
for now (http://www.coker.com.au/selinux).

With all that out of the way: Just put the following in your
/etc/apt/sources.list:

deb http://web.verbum.org/debian/ experimental/

(The above URI will probably change once these packages stop being
experimental).

At least today, doing a simple apt-get upgrade should get you the
.selinux versions of everything except coreutils; one solution to this
is to go into aptitude and select the .selinux version of coreutils
manually.  I'll try to upgrade to the latest coreutils later today, but
again I can't guarantee that I'll be able to track sid, so please
double-check that you have the .selinux versions installed.

Comments appreciated!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
