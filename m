Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h58BkoI4010732
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 07:46:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h58BkEss018654
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 11:46:14 GMT
Received: from tartarus.telenet-ops.be (tartarus.telenet-ops.be [195.130.132.46])
	by jazzswing.ncsc.mil  with ESMTP id h58BkDhY018651
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 11:46:14 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tartarus.telenet-ops.be (Postfix) with SMTP id 9DBADDBC7A
	for <selinux@tycho.nsa.gov>; Sun,  8 Jun 2003 13:46:33 +0200 (CEST)
Received: from kabel.telenet.be (D5E08CA4.kabel.telenet.be [213.224.140.164])
	by tartarus.telenet-ops.be (Postfix) with ESMTP id 539F9DBB89
	for <selinux@tycho.nsa.gov>; Sun,  8 Jun 2003 13:46:23 +0200 (CEST)
Date: Sun, 8 Jun 2003 13:46:17 +0200
From: Kurt Roeckx <Q@ping.be>
To: selinux@tycho.nsa.gov
Subject: Weird problem using latest kernel.
Message-ID: <20030608114617.GA4456@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been using 2.4.21-rc2, without patch, for a while without
problems.  Then I switched to 2.4.21-rc7 with the patch for rc6
found on http://www.coker.com.au/selinux/kern/

Using that, the first night something must have gone wrong using
updatedb, it was still running when I got back home that night,
which is ore than 12 hours after it starts.  You could hear the
hard disk going, the load was around 8, it was very unresponsive.
I just rebooted it.

The next day I had no problems, but the day after that I went to
see before I went to work and it was again still running.  This
time I started vmstat to have an idea of what's going on, and it
seems to be very heavily using the swap for some reason.

I killed updatedb and all it's children, but that didn't seem to
have helped, so I rebooted again.

After asking other people who run rc7, and searching list, nobody
else seems to have a problem, so I assumed it had to do something
with the lsm patch.  So I removed the patch and made a new
kernel.

I have no problems for 2 nights now with plain 2.4.21-rc7, didn't
have any problem with plain rc2 either, but things really don't
work very well with the lsm patched.


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
