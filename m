Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u36NFP2J020857
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 19:15:25 -0400
Received: by mail-ob0-f196.google.com with SMTP id js7so2258252obc.0
 for <selinux@tycho.nsa.gov>; Wed, 06 Apr 2016 16:15:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160406221445.GA26807@breakpoint.cc>
References: <cover.1459934322.git.pabeni@redhat.com>
 <CAHC9VhS6aJdPR6xTH2-ehikS5qvj6jFbZAUtzoBXp+WC9Ugi=Q@mail.gmail.com>
 <20160406221445.GA26807@breakpoint.cc>
Date: Wed, 6 Apr 2016 19:15:23 -0400
Message-ID: <CAHC9VhSZP1QxT-pQeHAW9m1xmyDsbFeA=9b8SdeWgS0RiDTOBA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux: avoid nf hooks overhead when not needed
From: Paul Moore <paul@paul-moore.com>
To: Florian Westphal <fw@strlen.de>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-security-module@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 James Morris <james.l.morris@oracle.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 6, 2016 at 6:14 PM, Florian Westphal <fw@strlen.de> wrote:
> netfilter hooks are per namespace -- so there is hook unregister when
> netns is destroyed.

Looking around, I see the global and per-namespace registration
functions (nf_register_hook and nf_register_net_hook, respectively),
but I'm looking to see if/how newly created namespace inherit
netfilter hooks from the init network namespace ... if you can create
a network namespace and dodge the SELinux hooks, that isn't a good
thing from a SELinux point of view, although it might be a plus
depending on where you view Paolo's original patches ;)

> Do you think it makes sense to rework the patch to delay registering
> of the netfiler hooks until the system is in a state where they're
> needed, without the 'unregister' aspect?

I would need to see the patch to say for certain, but in principle
that seems perfectly reasonable and I think would satisfy both the
netdev and SELinux camps - good suggestion.  My main goal is to drop
the selinux_nf_ip_init() entirely so it can't be used as a ROP gadget.

We might even be able to trim the secmark_active and peerlbl_active
checks in the SELinux netfilter hooks (an earlier attempt at
optimization; contrary to popular belief, I do care about SELinux
performance), although that would mean that enabling the network
access controls would be one way ... I guess you can disregard that
last bit, I'm thinking aloud again.

> Ideally this would even be per netns -- in perfect world we would
> be able to make it so that a new netns are created with an empty
> hook list.

In general SELinux doesn't care about namespaces, for reasons that are
sorta beyond the scope of this conversation, so I would like to stick
to a all or nothing approach to enabling the SELinux netfilter hooks
across namespaces.  Perhaps we can revisit this at a later time, but
let's keep it simple right now.

-- 
paul moore
www.paul-moore.com
