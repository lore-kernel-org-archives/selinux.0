Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5PNsOZB027083
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2013 19:54:24 -0400
Message-ID: <51CA2D5E.5010501@schaufler-ca.com>
Date: Tue, 25 Jun 2013 16:53:02 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
CC: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 0/9] Labeled networking patches for 3.11
References: <20130625211306.5057.31329.stgit@localhost>
In-Reply-To: <20130625211306.5057.31329.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/25/2013 2:18 PM, Paul Moore wrote:
> Nothing new here, all of these patches have been posted before.  I'm
> posting these patches again for two reasons:
>
>  1. Remind Eric he still hasn't merged them into the SELinux tree
>  2. Send notice that I've pushed the patches to my -next tree so
>     they should be in the next spin of linux-next
>
> I was hoping that there patches would have hit linux-next by now via
> the SELinux tree but that hasn't happened so I'm going to do it via
> my labeled networking tree (all the patches are labeled networking
> related anyway).

No objection from this end, but I'm curious about the motivation
for the changes as they affect the LSM interface.

>
> For those who like their patches via git, here is the lblnet-next
> tree:
>
>  * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
>
> Enjoy,
> -Paul
>
> ---
>
> Paul Moore (9):
>       selinux: fix problems in netnode when BUG() is compiled out
>       lsm: split the xfrm_state_alloc_security() hook implementation
>       selinux: cleanup and consolidate the XFRM alloc/clone/delete/free code
>       selinux: cleanup selinux_xfrm_policy_lookup() and selinux_xfrm_state_pol_flow_match()
>       selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()
>       selinux: cleanup some comment and whitespace issues in the XFRM code
>       selinux: cleanup selinux_xfrm_decode_session()
>       selinux: cleanup the XFRM header
>       selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()
>
>
>  include/linux/security.h        |   26 ++
>  security/capability.c           |   15 +
>  security/security.c             |   13 -
>  security/selinux/hooks.c        |   11 +
>  security/selinux/include/xfrm.h |   45 ++--
>  security/selinux/netnode.c      |    2 
>  security/selinux/xfrm.c         |  453 +++++++++++++++++----------------------
>  7 files changed, 264 insertions(+), 301 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
