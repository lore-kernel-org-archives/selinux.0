Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GLa3La022299
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 17:36:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8GLYMLY008913
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:34:22 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8GLYLsG008910
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:34:22 GMT
Date: Tue, 16 Sep 2003 22:36:01 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: 2.6.0 selinux reiserfs labeling
Message-ID: <20030916213601.GR8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Works. I can even still read the files :-)

I'll reboot it in the morning and make sure the
disk still mounts, but that seems rather likely.
If the patch was going to screw the pooch, it
would have done it during the setfile operation.

I can't see that a root reiserfs should present
any different problems, but I'll probably run that
test explicitely in a week or so when I've time to
clear another test machine.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
