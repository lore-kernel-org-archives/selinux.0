Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7JL3XAB003865
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 17:03:33 -0400
Date: Fri, 19 Aug 2016 23:03:27 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: sepolicy and setools4
Message-ID: <20160819210326.fyfxoz6y3sk24rfw@rhel-at-redhat.localdomain>
References: <20160819153528.GA21357@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160819153528.GA21357@meriadoc.perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 19, 2016 at 11:35:28PM +0800, Jason Zaman wrote:
> Hi all,
> 
> I've been trying to finally get rid of the last users of setools3 since
> its basically on life support. I have a lot of things fixed locally but
> not quite in good enough shape to submit.
> 
> Sepolicy currently is the thing that uses setools3 and everything else
> mostly goes via sepolicy. It boils down to sepolicy.info() and
> sepolicy.search() which are C-wrappers to setools3. Those two methods
> have a very open-ended and confusing API, and are just very thin
> wrappers around setools. It seems to me that we'd be better off updating
> most things that use it to instead use setools4 directly.
> 
> I have fixed .info() already (although still untested) so .search() is
> the main problem. It takes dictionaries of stuff and returns
> dictionaries of stuff and what exactly is in the dictionaries is not
> that clear.
> 
> How many users outside of the tree are there for sepolicy directly? If
> the only users are in the tree, I'd much rather kill off
> sepolicy.search() and go directly to setools. Is that an option?
> 
> slawrence mentioned on IRC that setroubleshoot might use sepolicy but
> wasnt entirely sure. Even if it does, does it use .search() and .info()?
> or does it only use all the other methods from it?

It uses search(), info() and few other methods as well.

However there are already two branches. One is considered as stable for
and uses python2. I'd expect that this branch will depend on
setools3 and SELinux userspace <= 2.5.

As for the second development branch, I'd say that it can be simply
ported to use setools4 directly instead of sepolicy.

Petr


> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
Petr Lautrbach
SELinux Solutions
Red Hat

Better technology. Faster innovation. Powered by community collaboration.
See how it works at redhat.com.
