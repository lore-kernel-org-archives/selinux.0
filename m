Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBGK0YRb027402
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 15:00:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBGJxYjx019100
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 19:59:34 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
	by jazzswing.ncsc.mil  with ESMTP id hBGJxXSR019093
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 19:59:34 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hBGK0MU14228
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 15:00:22 -0500
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: slat makefiles
References: <200312161952.29595.carstengrohmann@gmx.de>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 16 Dec 2003 15:00:22 -0500
In-Reply-To: <200312161952.29595.carstengrohmann@gmx.de>
Message-ID: <ogt4qw0ednt.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Carsten Grohmann <carstengrohmann@gmx.de> writes:

> today I've problems to build a slat rpm with your spec file. The 
> attached patch adds $DESTDIR to some makefiles to install all files 
> to the right destination like /var/tmp/slat.../ .

Carsten,

Thank you for your efforts aimed at improving the slat installation.
I studied the patch file you sent, and I can see you are patching two
Makefile.in's that have the same date as the ones in my CVS
repository, however, I'm having trouble seeing why one would want to
add $DESTDIR into these files.  To install into /var/tmp/slat, after
installing ocaml, you should type:

    $ ./configure --prefix=/var/tmp/slat
    $ make
    $ make install

Used this way, the configure script will create a Makefile in doc with
these declarations:

    prefix = /var/tmp/slat
    datadir = ${prefix}/share
    pkgdatadir = $(datadir)/slat

As a result, it will install documents into /var/tmp/slat/share/slat,
just as it should.  

Just a few seconds ago, I used slat.spec to rebuild the RPM available at 

  http://www.ccs.neu.edu/home/ramsdell/tools/selinux/slat-1.0.1-1.i386.rpm

without any problems on a machine running Red Hat 9.0.  I built it
using RPM version 4.2 with the command:

    $ rpmbuild -ba slat.spec

What version of Linux are you using?  Perhaps the spec file is the
location of the problem, not the Makefile.in's.  Perhaps the prebuild
RPM will solve your needs.  Also, let me point out that you do not
have to install slat to use it.

If you still think there is a need for DESTDIR, I suggest we discuss
this off list, and submit a message to the list if we agree a change
is needed.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
