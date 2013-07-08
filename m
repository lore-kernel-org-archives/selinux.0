Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r68GUO5d005597
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2013 12:30:40 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so5772582qae.20
        for <selinux@tycho.nsa.gov>; Mon, 08 Jul 2013 09:30:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Waiman Long <waiman.long@hp.com>, Eric Paris <eparis@parisplace.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Chandramouleeswaran, Aswin" <aswin@hp.com>,
        "Norton, Scott J" <scott.norton@hp.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2 v5] SELinux: Reduce overhead of mls_level_isvalid() function call
Date: Mon, 08 Jul 2013 12:30:17 -0400
Message-ID: <2187595.WquvNei6zx@sifl>
In-Reply-To: <51D6FE08.8030904@hp.com>
References: <1370886908-65256-1-git-send-email-Waiman.Long@hp.com> <51B70EE4.5030209@tycho.nsa.gov> <51D6FE08.8030904@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, July 05, 2013 01:10:32 PM Waiman Long wrote:
> On 06/11/2013 07:49 AM, Stephen Smalley wrote:
> > On 06/10/2013 01:55 PM, Waiman Long wrote:

...

> >> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> > 
> > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> Thank for the Ack. Will that patch go into v3.11?

[NOTE: I add the SELinux list to the CC line, for future reference, be sure to 
send your SELinux patches there.]

Your patch looked reasonable to me and Stephen ACK'd it so I went ahead and 
pulled the 1/2 patch into my lblnet-next tree.  It is probably an abuse of the 
system, but as you noted it in the description, it does have an impact on 
socket creation so it isn't completely unrelated ;)

If you don't want me to include your patch let me know and I'll drop it.

Now, being in my lblnet-next tree means pretty much nothing in terms of 
actually getting upstream, but it will at least get the patch into tomorrow's 
spin of the linux-next tree.  I think is a good thing as it allows you to say 
"my patch has been in linux-next for the past X weeks!" whenever Eric gets 
around to merging patches again.

Here are the details for the lblnet-next tree:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
 * http://git.infradead.org/users/pcmoore/lblnet-2.6_next

Also, a snapshot of what currently resides there:

Paul Moore (9):
      selinux: fix problems in netnode when BUG() is compiled out
      lsm: split the xfrm_state_alloc_security() hook implementation
      selinux: cleanup and consolidate the XFRM alloc/clone/delete/free code
      selinux: cleanup selinux_xfrm_policy_lookup() ... 
      selinux: cleanup selinux_xfrm_sock_rcv_skb() ... 
      selinux: cleanup some comment and whitespace issues in the XFRM code
      selinux: cleanup selinux_xfrm_decode_session()
      selinux: cleanup the XFRM header
      selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()

Waiman Long (1):
      SELinux: Reduce overhead of mls_level_isvalid() function call

 include/linux/security.h        |   26 ++
 security/capability.c           |   15 +
 security/security.c             |   13 -
 security/selinux/hooks.c        |   11 +
 security/selinux/include/xfrm.h |   45 ++--
 security/selinux/netnode.c      |    2
 security/selinux/ss/ebitmap.c   |   20 ++
 security/selinux/ss/ebitmap.h   |    2
 security/selinux/ss/mls.c       |   22 +-
 security/selinux/ss/mls_types.h |    2
 security/selinux/xfrm.c         |  453 ++++++++++++++++---------------------
 11 files changed, 291 insertions(+), 320 deletions(-)

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
