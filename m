Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TIeWrT021301
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:40:32 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TIeVCb016897
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 18:40:31 GMT
Subject: Re: Dominance rules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: dgami@uncc.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.58.0407281623110.18839@d10systems.homelinux.com>
References: <Pine.LNX.4.58.0407281623110.18839@d10systems.homelinux.com>
Content-Type: text/plain
Message-Id: <1091126399.21971.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 14:40:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 12:55, Dhruv Gami wrote:
> Hello Everyone,
> 
> I had been playing with role dominance, and seem to be unable to get it to 
> work. From what I understood, dominance rules basically grant the same 
> permissions to the dominating role as were given to the dominating role.
> 
> I set up a test system in the following way:
> 
> 1. created 2 new roles, X_r and Y_r
> 2. in rbac, i wrote 'dominance { role X_r; role Y_r; }'

That should be:
dominance { role X_r { role Y_r; } } 
if you want to have X_r dominate Y_r.

Your statement just defined two roles that are incomparable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
