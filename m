Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5DkVXZ003913
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 08:46:33 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5DkVF9020900
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 13:46:31 GMT
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
   Russell Coker <russell@coker.com.au>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041105130959.GA2593@cip.ifi.lmu.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
	 <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com>
	 <200411031641.59816.russell@coker.com.au> <4189060A.1010003@redhat.com>
	 <1099507502.3861.11.camel@nexus.verbum.private>
	 <1099519994.3861.18.camel@nexus.verbum.private>
	 <41896085.3080407@redhat.com>  <20041105130959.GA2593@cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099661914.6373.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 08:38:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 08:10, Thomas Bleher wrote:
> One additional request, for the NSA team:
> Is it possible to accelerate the rate at which patches are merged?
> Right now splitting patches is tedious work because there is such a long
> period between the time a patch is submitted and the time it is merged
> (sometimes up to four weeks!). If patches were merged within one week of
> posting them (assuming there are no problems and objections), submitters
> would be encouraged to send smaller patches more often which would make
> review much easier.
> I would be very grateful if something could be done about this. Right
> now the changes I have in my local policy amount to at least ten
> patches, but I'm very reluctant to send them because there are still
> some patches pending and merging is work enough as it is.
> If patch merging could be sped up and some notification sent if a patch 
> was rejected, that would really rock!

Alternative proposal:  create a separate upstream policy tree used by
the major external contributors, and we'll follow along more slowly as
we have time to review and merge, e.g. see the earlier discussion
started by Joshua Brindle on upstream policy handling.  From our
perspective, the example policy has always only been an example, and we
don't want to be in the business of maintaining it forever.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
