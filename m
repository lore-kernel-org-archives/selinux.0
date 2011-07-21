Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6LLXTUM029869
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2011 17:33:29 -0400
Received: from oproxy3-pub.bluehost.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p6LLXSON010667
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2011 21:33:29 GMT
Received: from localhost ([127.0.0.1] helo=box559.bluehost.com)
	by box559.bluehost.com with esmtpa (Exim 4.69)
	(envelope-from <rarob@travelinglightfarm.net>)
	id 1Qk0s4-0004qG-F4
	for selinux@tycho.nsa.gov; Thu, 21 Jul 2011 15:33:28 -0600
Message-ID: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
Date: Thu, 21 Jul 2011 17:33:28 -0400
Subject: PythonSELinux binding problem
From: rarob@travelinglightfarm.net
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  I'm using the python selinux bindings to determine if SELinux is
disable/permissive/enforcing.  The following snippet of code works just
fine on RH5 and F10 regardless of the SELinux mode, but fails with an
error on F11/12/13 and RH6 if SELinux is disabled.

$ python -c 'import selinux ; print selinux.security_getenforce()'

Under RH5 and F10 I correctly get the -1/0/1 returns for
disabled/permissive/enforcing, as specified in the man pages for
'security_getenforce'.  Under F11/12/13 and RH6 for permissive and
enforcing I get the correct return values, but if the system is in
disabled mode instead an OSError is thrown for 'No such file or
directory'.  I haven't look at the source for the underlying
security_getenforce() system call, but I suspect is is assuming that the
/selinux pseudo filesystem is populated (as in permissive/enforcing mode),
and is not handling the case where that pseudo filesystem is empty.

For now I've got my python calls wrapped in try/except blocks treating any
exception as SELinux in disabled mode.

I wasn't sure where the best place to log this as a bug is, either for the
libselinux-python package or libselinux itself.

-Rob



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
