Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3HHoXZ016391
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 12:17:50 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3HHnJZ004835
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:17:49 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA3HGsnr022188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 11:16:54 -0600
To: selinux@tycho.nsa.gov
Subject: SELinux capable UML's (bonus: root_fs creation on Debian)
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Wed, 03 Nov 2004 11:16:54 -0600
Message-ID: <87mzxysvi1.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi folks,

	I've been trying to play with SELinux, but the current state
 of affairs made it impossible to run my laptop in enforcing mode (and
 still get work done). I then tried wotk with UML instances that ran
 SELinux, and found there was nothing out of the box that would help
 me. So, I have put together a recipe for setting up a SELinux uml
 environment, 
 <URL:http://www.golden-gryphon.com/software/security/selinux-uml.xhtml>

	This is a recipe, giving step by step instructions, patches,
 and scripts, and I will try to keep it updated with newer releases
 (though it seems that the need for extra works is rapidly
 diminishing).

	I hope this document shall be useful. I find that this is
 useful for running services on an otherwise insecure box, since in a
 number of real world situations, a machine can not be run in
 enforcing mode, possibly because it needs to run applications and
 services for which MAC policy has not yet been written. The
 traditional solution of running services (like bind, postfix,
 sendmail) in a chroot jail does not come close to the isolation
 provided by a virtual machine running SELinux.

	Even if the host were running SELinux, a secure UML would
 still be of value, because of its utility as a honey pot, with secure
 tty logging - since the logging is performed on the host system, the
 logging would be invisible to any attacker.  Just sniffing the
 network doesn't help since that traffic is encrypted. So, you need to
 capture keystrokes by running something on the honeypot. This is
 problematic since the logging mechanism on a non-UML compromised
 honey pot may be discovered, scaring off the attacker.

	The UML kernel runs in an entirely different host address
 space from its processes (making it less vulnerable to some forms of
 attacks), and has no access to the underlying hardware.

	manoj
-- 
The number of computer scientists in a room is inversely proportional
to the number of bugs in their code.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
