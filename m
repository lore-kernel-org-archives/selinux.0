Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5RDB9xf010035
 for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2014 09:11:09 -0400
Received: by mail-qg0-f42.google.com with SMTP id e89so4423221qgf.29
 for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2014 06:11:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
Date: Fri, 27 Jun 2014 09:11:08 -0400
Message-ID: <28082020.dkL42PyBCo@sifl>
In-Reply-To: <53AD6918.8090902@tycho.nsa.gov>
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
 <53AD6072.6070608@tycho.nsa.gov> <53AD6918.8090902@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jaejyn Shin <flagon22bass@gmail.com>, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, June 27, 2014 08:52:40 AM Stephen Smalley wrote:
> On 06/27/2014 08:15 AM, Stephen Smalley wrote:
> >
> > Did you confirm that we need the synchronize_net() call at all?

I looked into a little more yesterday and it probably isn't needed for the 
netport cache as that is only ever really used at the socket level so there is 
no need to wait on any packet processing.  We might be able to get away with 
removing for the netif and netnode caches as well since we only check those 
caches once for each packet so I don't believe there is a real worry about 
consistency.  However, I'm inclined to leave it in for now and just 
consolidate the callbacks so we only call synchronize_net() once; it's still a 
performance win and we preserve any safety benefits that may be there.

Also, in the interest of full disclosure, I've never been one of those folks 
who are militant about reducing boot times, a few milliseconds here are there 
aren't a big deal to me.  At some point I may change my opinion on boot times, 
but right now that's my thinking.

> Let me phrase this differently:
> 
> 1) Does the synchronize_net() call guarantee that after the policy load
> completes (or more specifically, after the avc_ss_reset completes), all
> subsequent network permission checks will be based on the
> netif/node/port contexts defined by the new policy and not based on the
> old ones?

Essentially the synchronize_net() call is just a synchronize_rcu() call with a 
little extra work if the routing table lock is taken, so no magic 
synchronization here.  Basically as soon as the network object cache is 
flushed new lookups to the cache will start querying the policy again, the 
synchronize_net() call really just ensures that existing RCU critical sections 
will finish up before the callback complete.

> -and-
> 
> 2) Does anyone currently rely on this behavior, i.e. they make a change
> to the netif/node/port contexts in policy, load the new policy, and need
> to know that the new context assignments are being applied on every
> network operation before they can proceed safely?

I don't believe so, at least I would advise against it as there are little 
guarantees when it comes to network I/O.

-- 
paul moore
www.paul-moore.com
