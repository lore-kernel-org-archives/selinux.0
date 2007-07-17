Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HBdW8Z009676
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 07:39:32 -0400
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HBdUbS025015
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 11:39:30 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l6HBdUIR023095
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 07:39:30 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 9C69ABEFB
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 07:39:30 -0400 (EDT)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with ESMTP id l6HBdUm4023086
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 07:39:30 -0400
Received: from oolong.mitre.org (oolong.mitre.org [129.83.162.84])
	by linus.mitre.org (8.12.11/8.12.10) with ESMTP id l6HBdUNQ021275
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 07:39:30 -0400 (EDT)
To: selinux@tycho.nsa.gov
Subject: Cannot run ldconfig in a home directory
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Jul 2007 07:39:30 -0400
Message-ID: <ogtzm1vntsd.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am playing around with the source distribution of the audit package.
I modified some code, but I don't want to install the modified version
in the usual locations, just in case I break something.  So I
configured the source distribution using:

   $ ./configure --prefix=$HOME/opt/audit

and then did the usual "make; make install".  

The audit package contains shared libraries, and the installation
scripts run ldconfig using the -n option.  This option ensures
ldconfig will not process the trusted directories (/usr/lib and /lib)
or those specified in /etc/ld.so.conf, thus allowing it to be run
by an unprivileged user; however, the current SELinux for Fedora 7
prevents this usage of ldconfig.  Setroubleshoot reports:

Summary:
SELinux is preventing /sbin/ldconfig (ldconfig_t) "search" to home
(home_root_t).

Detailed Description:
SELinux denied access requested by /sbin/ldconfig. It is not expected
that this access is required by /sbin/ldconfig and this access may
signal an intrusion attempt. It is also possible that the specific
version or configuration of the application is causing it to require
additional access.

Obviously, it is easy enough for me to disable SELinux while playing
with the audit sources, but it seems to that with this policy, if I
were working on a machine I did not control, I wouldn't be able
properly test an installation.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
