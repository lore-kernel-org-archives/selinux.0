Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FFiRL9008215
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 10:44:28 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FFf3w0015657
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 15:41:03 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 9CA32C48E
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 15:43:10 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1D150t-0006Pw-Gn
	for selinux@tycho.nsa.gov; Tue, 15 Feb 2005 15:53:23 +0000
Date: Tue, 15 Feb 2005 15:53:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: sshd transition points
Message-ID: <20050215155323.GC23765@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i'm just in the process of setting up a rather paranoid selinux
environment involving sshd, on a Redhat FC3 system.

the execution of ordinary shells (/bin/bash) is banned - or at
least must be restricted / tracked by selinux.

i am running the sftp subsystem.

therein lies part of the problem - sshd appears to be running
/bin/bash for a user - in the sshd_t domain - as part of the
process of firing up /usr/libexec/ssh/sftp-server.

which is a bit weird and annoying, because what i _wanted_ to do
was to associate a user with a net_context, such that only
a particular user may sftp in from a certain IP address.

... and that's not possible, because by the time sftp-server is
being run, there's a disconnect: sftp-server is in the correct
domain but it only has a unix-domain-socket to contact a forked
sshd, which has the TCP connection open but is still running
in the domain sshd_t.

so basically, my question boils down to this:

* _should_ sshd, after a fork, be still running in sshd_t?

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
