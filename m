Date: Wed, 19 May 2010 08:59:07 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: sds@tycho.nsa.gov, eparis@parisplace.org, mingo@elte.hu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] selinux: remove all rcu head initializations
In-Reply-To: <20100518191125.GA7014@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.00.1005190858180.640@tundra.namei.org>
References: <20100518191125.GA7014@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2010, Paul E. McKenney wrote:

> Hello!
> 
> Would you guys like to carry this patch, or should I push it up
> -tip?  If I don't hear otherwise from you, I will push it up -tip.
> The INIT_RCU_HEAD() primitive is going away in favor of debugobjects.

Are there any prerequisites for this patch?  If not, I'll take it.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
