Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14084
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 12:34:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA26125
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 17:34:28 GMT
Received: from mailhub.iastate.edu (mailhub.iastate.edu [129.186.1.102])
	by jazzband.ncsc.mil  with ESMTP id RAA26121
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 17:34:25 GMT
Message-ID: <3A9FD9A4.D05B301E@iastate.edu>
Date: Fri, 02 Mar 2001 11:34:28 -0600
From: Mark Slagell <ms@iastate.edu>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Adding users
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi all,

Just tried adding a new user, the first one besides those that were in
place when installing SELinux. Did useradd -m username, then added the
relevant info to policy/users and to /etc/security/default_context. 
When logging the user on for the first time it would prompt with the
correct default context, but then say "That security context is invalid"
regardless of whether the default was used or something else entered. 
Tried doing "make install" in the policy directory, no effect. Then
rebooted and everything was fine, the new user could log in normally.

Surely the reboot shouldn't have been necessary (this ain't Windows) -
what did I miss?

  Mark



-- 
"If once a man indulges himself in murder, very soon he comes to think
little of robbing; and from robbing he next comes to drinking and
Sabbath-breaking, and from that to incivility and procrastination."
                -- Thomas De Quincey (1785 - 1859)

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
