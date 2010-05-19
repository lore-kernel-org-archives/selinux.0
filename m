Date: Tue, 18 May 2010 17:00:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, eparis@parisplace.org, mingo@elte.hu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] selinux: remove all rcu head initializations
Message-ID: <20100519000019.GM2302@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20100518191125.GA7014@linux.vnet.ibm.com>
 <alpine.LRH.2.00.1005190938400.1028@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1005190938400.1028@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2010 at 09:39:03AM +1000, James Morris wrote:
> On Tue, 18 May 2010, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > Would you guys like to carry this patch, or should I push it up
> > -tip?  If I don't hear otherwise from you, I will push it up -tip.
> > The INIT_RCU_HEAD() primitive is going away in favor of debugobjects.
> > 
> 
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next-queue

Thank you, I have removed it from my tree.

							Thanx, Paul

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
