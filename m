Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r53FBgev015038
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2013 11:11:42 -0400
From: Paul Moore <pmoore@redhat.com>
To: David Miller <davem@davemloft.net>, selinux@tycho.nsa.gov
Cc: netdev@vger.kernel.org, omoris@redhat.com, pwouters@redhat.com
Subject: Re: [PATCH v3 0/2] Fix the SELinux dynamic network access controls
Date: Mon, 03 Jun 2013 11:11:38 -0400
Message-ID: <8410550.MlrVbe5Pkl@sifl>
In-Reply-To: <20130531.173108.2170873839229968113.davem@davemloft.net>
References: <20130529173336.31888.29695.stgit@localhost> <20130531.173108.2170873839229968113.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 31, 2013 05:31:08 PM David Miller wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Wed, 29 May 2013 13:36:18 -0400
> 
> > Take #3 ... two changes here: the first is a simple reordering of the
> > two patches and the second is stripping the SELinux patch (2/2 in this
> > patchset) of everything but the bare bones changes needed to fix the
> > problem in the 3.10-rcX tree.
> 
> Series applied, but longer term I'd like to see this handled by generation
> counts or similar during lookup time.
> 
> Doing a GC every policy delete hurts policy delete performance, something
> we worked really hard to make as light weight as possible given the
> constraints.

Thanks for pulling in the fixes for 3.10-rcX.

I promise to take a look at changing our approach to detecting an active 
labeled IPsec configuration for future releases.  I need to cleanup our 
labeled IPsec code anyway, it is in need of some TLC (you saw some of the 
changes in the earlier version of this patchset).

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
