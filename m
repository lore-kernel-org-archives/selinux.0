Date: Thu, 9 Dec 2010 08:27:10 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, esandeen@redhat.com
Subject: Re: [PATCH] selinux: cache sidtab_context_to_sid results
In-Reply-To: <1291757254.3072.31.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.1012090825480.13177@tundra.namei.org>
References: <20101202210634.27460.81333.stgit@paris.rdu.redhat.com>  <alpine.LRH.2.00.1012060921230.14997@tundra.namei.org> <1291757254.3072.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Dec 2010, Eric Paris wrote:

> > This sounds a bit like a magazine cache -- should be useful.  Have you 
> > thought about making it per-cpu ?
> 
> I hadn't.  I figure that as long as we've had a single hash table lookup
> (the wrong direction for the hash table) for all CPUs holding a spinlock
> that this is such a clear win there wasn't a need for any complexity or
> space tradeoff.
> 
> If you think differently (and have a way we could benchmark the changes)
> it wouldn't be hard to do, just don't know if it's worth it....

Nope, just wondering what you thought.  It's a clear win on its own.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
