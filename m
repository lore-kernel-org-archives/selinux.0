Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5TJpRsd024981
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2010 15:51:27 -0400
Received: from hrndva-omtalb.mail.rr.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5TJoZUG023125
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2010 19:50:35 GMT
Date: Tue, 29 Jun 2010 14:52:10 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
        kaigai@ak.jp.nec.com
Subject: selinux testsuite
Message-ID: <20100629195210.GA14549@hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a little note to announce that the selinux testsuite is now up as a
git tree at kernel.org.  You can fetch it using

	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite

The README shows how to run.

Many thanks to Stephen for keeping it running so nicely and allowing me
to post it.  I intend to test against Fedora regularly-ish, and to start
seeing how best to nudge it to work against Debian and Ubuntu in the next
month or so.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
