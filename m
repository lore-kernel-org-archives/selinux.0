Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jADIrgMA026430
	for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2005 13:53:42 -0500 (EST)
Received: from mx4.informatik.uni-tuebingen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jADIkcQ8027368
	for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2005 18:46:38 GMT
Date: Sun, 13 Nov 2005 19:46:15 +0100
From: Andreas Bernauer <andreas.bernauer@gmx.de>
To: selinux@tycho.nsa.gov
Subject: (new?) problems installing with checkinstall
Message-ID: <20051113184615.GB3618@tierbergli.Informatik.Uni-Tuebingen.De>
Reply-To: Andreas Bernauer <andreas.bernauer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

First, I must admit I am new to SELinux.  I hope, this is the right
place to ask my question.  I could not find an answer in the mailing
list archives, the web or the UnOfficial FAQ.  If this is the wrong
place, please be so kind and point me to the right place.

I'm running Fedora Core 4 (2.6.13-1.1526_FC4smp) with SELinux in
permissive mode (and coreutils-5.2.1-48.1,
policycoreutils-1.27.2-1.2).  I want to install software using
checkinstall, which monitors the installation process and builds an
RPM out of it.  [ http://asic-linux.com.mx/~izto/checkinstall/ ]

When I do a `make install`, everything runs fine.  However, when I use
checkinstall (which creates a temporary script which in turn calls
`make install`), I get error messages like the following:

----------------------
/usr/bin/install: warning: failed to change context of /usr/doc/mutt/samples/gpg
.rc to system_u:object_r:usr_t: No such file or directory
/usr/bin/install: setting permissions for `/usr/doc/mutt/samples/pgp2.rc': No su
ch file or directory
[...]
  /usr/bin/install -c 'pgpewrap' '/usr/bin/pgpewrap'
/usr/bin/install: setting permissions for `/usr/bin/pgpewrap': No such file or d
irectory
/usr/bin/install: warning: failed to change context of /usr/bin/pgpewrap to syst
em_u:object_r:bin_t: No such file or directory
----------------------

Obviously, /usr/bin/install has problems changing the context.
However, I don't see why.  The files do exist after the installation
process, despite the error messages indicating the opposite.

My questions:  What is the reason for the error messages and how to I
stop the error from occuring?  (It also seems to slow down the
installation process)
Do I have to fix the contexts after the installation?  If yes, is
restorecon doing the job?

I would like to post some error log messages, but I could not find
any.  Neither /var/log/{messages,secure,audit} contain error messages
related to the problem.

Thank you very much in advance for any hints.

Andreas.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
