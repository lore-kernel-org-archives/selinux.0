Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TJ5crT021513
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 15:05:38 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TJ5bCb017969
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 19:05:37 GMT
Subject: Re: Dominance rules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: dgami@uncc.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1091126399.21971.156.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.58.0407281623110.18839@d10systems.homelinux.com>
	 <1091126399.21971.156.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1091127906.21971.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 15:05:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 14:40, Stephen Smalley wrote:
> On Wed, 2004-07-28 at 12:55, Dhruv Gami wrote:
> > 2. in rbac, i wrote 'dominance { role X_r; role Y_r; }'
> 
> That should be:
> dominance { role X_r { role Y_r; } } 
> if you want to have X_r dominate Y_r.
> 
> Your statement just defined two roles that are incomparable.

BTW, I knew that your question looked familiar.  See the thread starting
at http://marc.theaimsgroup.com/?l=selinux&m=104486000625733&w=2


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
