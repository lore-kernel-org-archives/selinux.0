Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j322NQDo017125
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 21:23:26 -0500 (EST)
Date: Fri, 1 Apr 2005 20:20:01 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] tighten fetchmail policy
Message-ID: <20050402022001.GA13742@yggdrasil.localdomain>
References: <20050330014646.GA19610@yggdrasil.localdomain> <1112387676.9437.31.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112387676.9437.31.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 01, 2005 at 03:34:36PM -0500, James Carter wrote:
> Merged, except for this little bit.
> Better to use r_file_perms and allow the lock permission, unless there
> is a good reason not to allow lock.

OK, I'll stick with the macros in the future unless there's a solid 
reason to avoid doing so.  Thanx!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
