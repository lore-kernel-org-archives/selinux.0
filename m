Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4OIKPLP027065
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2013 14:20:25 -0400
From: Paul Moore <pmoore@redhat.com>
To: Eric Paris <eparis@redhat.com>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 0/2] Fix the SELinux dynamic network access controls
Date: Fri, 24 May 2013 14:20:23 -0400
Message-ID: <2018143.PsiGxnXVKA@sifl>
In-Reply-To: <20130524181430.24022.15997.stgit@localhost>
References: <20130524181430.24022.15997.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 24, 2013 02:16:16 PM Paul Moore wrote:
> A bump to v2 to incorporate Sergei's minor comment on the previous
> patchset.  I've also gone ahead and dropped the "RFC" from the
> patchset as I didn't see any significant comments/concerns from
> anyone.
> 
> ---
> 
> Paul Moore (2):
>       selinux: fix the labeled xfrm/IPsec reference count handling
>       xfrm: force a garbage collection after deleting a policy

Hi Dave, Eric,

I think we need to get this in for 3.10, assuming no objections from either 
one of you, who wants to pull it into their tree?

-Paul

P.S. Technically this could also be -stable material but I'm not pushing for 
that as this isn't really a panic issue, just a nuisance.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
