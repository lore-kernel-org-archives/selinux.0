Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJGaXZ010924
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:16:36 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJGWsx020468
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:16:32 GMT
Subject: Re: Patch: small fix for sudo
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041026092350.GB24672@rom.cip.ifi.lmu.de>
References: <20041026092350.GB24672@rom.cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099077320.12321.90.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:15:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2004-10-26 at 05:23, Thomas Bleher wrote:
> Attached patch fixes one duplicate permission which is already in
> newrole_domain() and moves the exec type declaration out of the macro.
> The old policy generated types like staff_sudo_exec_t which is wrong, I
> think.
> 
> Please apply.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
