Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFEBiIi022961
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:11:44 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFEAHvq019291
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 14:10:18 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Amy L Herzog <aherzog@mitre.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <20041112184232.GK15243@golconda.mitre.org>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
Content-Type: text/plain
Message-Id: <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 09:07:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-12 at 13:42, Amy L Herzog wrote:
> Sorry to jump in a bit late on this. For our information flow analysis
> tools, our instinct is to simply expand the LTS we build from the
> policy to include the 'process dyntransition' permission (with a
> write-like flow, just like the current 'process transition'
> permission). Although it would be fairly easy to collapse domains that
> have full dynamic transition permissions to one another, doing so
> wouldn't affect the truth of any information flow assertions
> (i.e. system security goals) in the system.

Hmm...I think it will have to be a "read write" flow, i.e. equivalence
required, particularly given the possibility of per-thread contexts
introduced by this change (one thread may switch to a different context
while another is still running in the old one).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
