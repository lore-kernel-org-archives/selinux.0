Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25341
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 11:28:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB9GS1I11197
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 16:28:01 GMT
Received: from hq.caci.com (mailtest.caci.com [204.194.72.241])
        by jazzband.ncsc.mil  with ESMTP id gB9GS0f11193 for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 16:28:00 GMT
Subject: Basic Question
To: SELinux@tycho.nsa.gov
Message-ID: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com>
From: "Richard Mayo" <rmayo@caci.com>
Date: Mon, 9 Dec 2002 11:14:40 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a basic question -- it's something I've assumed, but never
explicitly checked:

When SELinux is running in permissive mode and an action is attempted that
violates the security settings, the system logs this event.
Obviously, if SELinux were running in enforcing mode this action would have
been denied, but would an entry STILL have been made in the log file?


Thanks,
Rich Mayo



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
