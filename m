Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j33N9kDo025360
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 19:09:46 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j33N7rSQ022852
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 23:07:53 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j33N7s7j007452
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 19:07:54 -0400 (EDT)
Subject: Re: /dev/pts/x use denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
In-Reply-To: <1112569241.21383.37.camel@cobra.ivg2.net>
References: <1112569241.21383.37.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 19:13:51 -0400
Message-Id: <1112570031.23944.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-03 at 19:00 -0400, Ivan Gyurdiev wrote: 
> Strange denials:
> 
> /dev/pts/2 has context: sysadm_tmp_t.
> Those happen intermittently, but I can't figure out when exactly.
> I am logged in as a regular user, but su-ed to root. Usually accompanied
> by a dac_override.

It's sometimes followed by a dac_override - not all the time.
Here's something reproducible:

If I su to root, launch tvtime/mplayer/whatever, then make load
the selinux policy, I get use denial on /dev/pts. Then if I launch
the same program - no use denial. Then I make load the policy again,
launch program, and I get a use denial.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
