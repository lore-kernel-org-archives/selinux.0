Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA18577
	for <selinux@tycho.nsa.gov>; Sat, 23 Dec 2000 21:09:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id CAA00847
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 02:09:23 GMT
Received: from tisch.mail.mindspring.net (tisch.mail.mindspring.net [207.69.200.157])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id CAA00843
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 02:09:23 GMT
Received: from ix.netcom.com (user-2ive0vb.dialup.mindspring.com [165.247.3.235])
	by tisch.mail.mindspring.net (8.9.3/8.8.5) with ESMTP id VAA17165
	for <selinux@tycho.nsa.gov>; Sat, 23 Dec 2000 21:09:51 -0500 (EST)
Message-ID: <3A455AF2.A544580A@ix.netcom.com>
Date: Sat, 23 Dec 2000 21:09:54 -0500
From: Jacques Richer <jpricher@ix.netcom.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Linux setuid bug
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

It didn't look like they did _anything_ to the code beyond the changes
needed for "flask". I think this was a very clear decision on their
part.
On the other hand, using domains and roles to control process privilege
could potentially make the setuid() bug more of a bother than a major
hole.

(This does _not_ imply that I believe it should not be fixed. It clearly
needs to
happen. This is probably the reason behind the push to update their code
for a
newer operating system kernel...)

                                                Jacques Richer



You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
