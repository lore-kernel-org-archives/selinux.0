Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FGL6AG004879
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 12:21:06 -0400
Received: from nm1-vm0.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p8FGL4Bx003655
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:21:05 GMT
Message-ID: <1316103664.93555.YahooMailClassic@web87008.mail.ird.yahoo.com>
Date: Thu, 15 Sep 2011 17:21:04 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: CIL compiler 
To: Steve Lawrence <slawrence@tresys.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the Initial SID fix. It works fine.

I've been experimenting with CIL using a basic base policy (similar to mdp) and blocks to build binary policy files. I've checked these with apol and loaded them with only two issues found so far:

1) The 'booleanif' does not expand the AV or TYPE rules into the binary. apol does not list anything under 'Conditional Expressions' and the policy will not load.

2) The 'optional' sections are not expanded into the binary when the dependencies are resolved. The policy is still loadable.

I also notice that as the CIL dev team work through the changes, the policy requirements change slightly. For example the allow rule format changed because of the permission set changes and the roles for object_r need to be fully defined. These are not an issue - just noting them in case others are testing CIL as well.

Richard



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
