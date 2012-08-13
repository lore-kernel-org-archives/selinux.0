Message-ID: <1344861329.25589.16.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Mon, 13 Aug 2012 08:35:29 -0400
In-Reply-To: <20120810213845.GQ2296@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810213845.GQ2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 23:38 +0200, Ole Kliemann wrote:
> On Tue, Aug 07, 2012 at 03:02:44PM +0200, Ole Kliemann wrote:
> > And would it be better performance-wise to run a MCS-policy with 
> > say categories c0.cn than to have types c0_t, ... cn_t?
> 
> I can measure a performance impact here too using a test analog 
> to the one used to measure the attribute-spam.
> 
> With 10000 categories:
> 
> I reside in system_u:system_r:unconfined_t:s0.
> I run the script. Average walltime is about 6.67sec.
> 
> 
> $ runcon -l s0:c0.c9999
> 
> Now I'm system_u:system_r:unconfined_t:s0:c0.c9999.
> I rerun the script. Average walltime is about 39sec.
> 
> Ouch! :-/
> 
> 
> $ runcon -l s0:c0.c999
> Now I'm system_u:system_r:unconfined_t:s0:c0.c999.
> I rerun the script. Average walltime is about 7.89sec.
> 
> 
> With 1000 categories:
> 
> system_u:system_r:unconfined_t:s0               6.53sec
> system_u:system_r:unconfined_t:s0:c0.c9         6.63sec
> system_u:system_r:unconfined_t:s0:c0.c99        6.73sec
> system_u:system_r:unconfined_t:s0:c0.c999       7.89sec
> 
> That's almost 19% increase still at full range!
> 
> 
> But several points:
> 
> It's different than with attribute-spam. There is no lag, no 
> CPU spikes in kworker threads. It's just a smooth increase in 
> runtime, even at 10k. 
> 
> It only matters in what range you run. You seldom will be running 
> something in the full range. The results for c0.c9 will be the 
> most realistic for everyday usage. There is no big difference 
> measurable. (At this point variance comes into play, would need 
> bigger data base to say something.)
> 
> The test script is kind of far away from everyday usage. 
> 
> 
> So bottom line is: Unless one goes berserk with 10k running in 
> full range, this looks like no problem.
> 
> 
> I attached both versions.

I wonder how much of that time is spent on the chcon calls (i.e.
getxattr + setxattr) vs the actual accessing of the files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
