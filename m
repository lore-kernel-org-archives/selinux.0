Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6P9kZrT019607
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 05:46:35 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6P9kYYd000720
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 09:46:35 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 25 Jul 2004 09:46:34 -0000
Date: Sun, 25 Jul 2004 10:57:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: pam-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
Subject: IDEA: /etc/pam.d/*/*
Message-ID: <20040725095739.GH3437@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

there is a minor issue of inter-dependence of packages that may
be resolved by applying the usual debian approach of 
"if-it-was-a-config-file-make-it-a-directory".

the issue is that Debian has to cater for SELinux being
installed and not installed.

openssh, login, kdm, gdm, su and several other packages all
require "session pam_selinux.so required" to be added to
their respective /etc/pam.d/XXX configurations in order for
SE/Linux to operate correctly.

Redhat is solving the issue by always enabling SE/Linux by
default.

Debian has no such luxury.

therefore, openssh etc. etc. cannot accept upstream patches
to have /etc/pam.d/ssh include that line by default, because
if you do, and pam_selinux.so is not installed, you're hosed.

one possible solution is to turn, exactly as was done with
pam.conf into pam.d several years ago, the contents of
the pam.d files into directories.

now, in this case, an ordering is required, and so the same
thing can be done as with /etc/rc?.d/* and /etc/exim4/conf.d
namely to have a number NN[N][N] at the front of the config.

what this allows people to do is to install pam, and to install
selinux, and for there to NOT be an inter-dependence between
the two, and for there NOT to have to be a special openssh-selinux
with only a single file different (a different /etc/pam.d/ssh)
and likewise for all other packages.

in other words, the contents of /etc/pam.d/ssh get split into
a directory, /etc/pam.d/ssh, as follows:

000_nonroot:
	# Disallow non-root logins when /etc/nologin exists.
	auth       required     pam_nologin.so

100_stdunix:
	# Standard Un*x authentication.
	@include common-auth

	# Standard Un*x authorization.
	@include common-account

	# Standard Un*x session setup and teardown.
	@include common-session


etc. etc.

and then, you can install a separate pam-selinux package that
blats into the mix:

800_selinux:

	session   required pam_selinux.so

reckon?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
