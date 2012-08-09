Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79Aj7BX012882
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 06:45:07 -0400
Date: Thu, 9 Aug 2012 12:45:00 +0200
From: Adam Tkac <atkac@redhat.com>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux performance depending on type count
Message-ID: <20120809104459.GA1446@redhat.com>
References: <20120807130244.GE2085@telvanni>
 <20120808204401.GA5403@telvanni>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120808204401.GA5403@telvanni>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 08, 2012 at 10:44:01PM +0200, Ole Kliemann wrote:
> I haven't tested any runtime performance just compile-time and 
> policy size.
> 
> All this is done on my old Dell D410 with a 1.73GHz Pentium M.
> 
> On Tue, Aug 07, 2012 at 03:02:44PM +0200, Ole Kliemann wrote:
> > But if there was a performance problem with a lot of types, at 
> > what number n would it start to hit hard? And how does it 
> > increase (linear, quadratic...)?
> 
> n=10000, i.e. 20000 types, 10000 attributes and a handful of 
> allows per type and attribute in one module.
> 
> compilation is okay, but inserting the said module with 
> semodule... well at 18min CPU-time I killed the process... who 
> knows what size this policy would have had...
> 
> 
> n=5000, i.e. 10000 types, 5000 attributes and a handful of 
> allows per type and attribute in one module.
> 
> inserting the module in about 5m30s walltime. policy is 13M of 
> size.
> 
> 
> n=1000, i.e. 2000 types, 1000 attributes and a handful of 
> allows per type and attribute in one module.
> 
> inserting the module in about 9s walltime. policy is 2.5M of 
> size.
> 
> 
> Apparently the runtime of inserting the module is fataly steep in 
> n. Rough estimation would be at least n^2, could be higher 
> depending on how long n=10000 would have actually taken.
> 
> > And would it be better performance-wise to run a MCS-policy with 
> > say categories c0.cn than to have types c0_t, ... cn_t?
> 
> n=10000, i.e. 10000 categories, one sensitivity and a handful of 
> mlsconstraints
> 
> inserting the module in about 8s walltime. policy is 284K of 
> size.
> 
> 
> Of course this is a very rough and inprecise testing. But I guess 
> one can say that the policy infrastructure get's into trouble 
> with high type count whereas a high category count seems to be 
> handled flawlessly.

I already wrote a patch for this and sent it to the ML some time ago. It is
currently present in Fedora git tree, you can try it and report if it speeds up
your operations with SELinux.

http://pkgs.fedoraproject.org/cgit/libsepol.git/plain/libsepol-rhat.patch

Regards, Adam

-- 
Adam Tkac, Red Hat, Inc.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
