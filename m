Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v738C4VW027037
 for <selinux@tycho.nsa.gov>; Thu, 3 Aug 2017 04:12:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UHILFEID10.oob.disa.mil (Postfix) with SMTP id 3xNN7h27TWz1MNTM
 for <selinux@tycho.nsa.gov>; Thu,  3 Aug 2017 08:12:00 +0000 (UTC)
Received: from UHIL19PA13.eemsg.mil (unknown [192.168.14.17])
 by UHILFEID10.oob.disa.mil (Postfix) with ESMTP id 3xNN7h1T6Pz1MNTL
 for <selinux@tycho.nsa.gov>; Thu,  3 Aug 2017 08:12:00 +0000 (UTC)
Date: Thu, 3 Aug 2017 10:11:52 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Paul Moore <pmoore@redhat.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov,
 Mel Gorman <mgorman@suse.de>
Message-ID: <20170803081152.GC12521@dhcp22.suse.cz>
References: <20170802105018.GA2529@dhcp22.suse.cz>
 <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

[CC Mel]

On Wed 02-08-17 17:45:56, Paul Moore wrote:
> On Wed, Aug 2, 2017 at 6:50 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > Hi,
> > while doing something completely unrelated to selinux I've noticed a
> > really strange __GFP_NOMEMALLOC usage pattern in selinux, especially
> > GFP_ATOMIC | __GFP_NOMEMALLOC doesn't make much sense to me. GFP_ATOMIC
> > on its own allows to access memory reserves while the later flag tells
> > we cannot use memory reserves at all. The primary usecase for
> > __GFP_NOMEMALLOC is to override a global PF_MEMALLOC should there be a
> > need.
> >
> > It all leads to fa1aa143ac4a ("selinux: extended permissions for
> > ioctls") which doesn't explain this aspect so let me ask. Why is the
> > flag used at all? Moreover shouldn't GFP_ATOMIC be actually GFP_NOWAIT.
> > What makes this path important to access memory reserves?
> 
> [NOTE: added the SELinux list to the CC line, please include that list
> when asking SELinux questions]

Sorry about that. Will keep it in mind for next posts
 
> The GFP_ATOMIC|__GFP_NOMEMALLOC use in SELinux appears to be limited
> to security/selinux/avc.c, and digging a bit, I'm guessing commit
> fa1aa143ac4a copied the combination from 6290c2c43973 ("selinux: tag
> avc cache alloc as non-critical") and the avc_alloc_node() function.

Thanks for the pointer. That makes much more sense now. Back in 2012 we
really didn't have a good way to distinguish non sleeping and atomic
with reserves allocations.
 
> I can't say that I'm an expert at the vm subsystem and the variety of
> different GFP_* flags, but your suggestion of moving to GFP_NOWAIT in
> security/selinux/avc.c seems reasonable and in keeping with the idea
> behind commit 6290c2c43973.

What do you think about the following? I haven't tested it but it should
be rather straightforward.
---
>From 6d506a75da83c0724ed399966971711f37d67411 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 3 Aug 2017 10:04:20 +0200
Subject: [PATCH] selinux: replace GFP_ATOMIC | __GFP_NOMEMALLOC with
 GFP_NOWAIT

selinux avc code uses a weird combination of gfp flags. It asks for
GFP_ATOMIC which allows access to memory reserves while it requests
to not consume memory reserves by __GFP_NOMEMALLOC. This seems to be
copying the pattern from 6290c2c43973 ("selinux: tag avc cache alloc as
non-critical").

Back then (before d0164adc89f6 ("mm, page_alloc: distinguish between
being unable to sleep, unwilling to sleep and avoiding waking kswapd"))
we didn't have a good way to distinguish nowait and atomic allocations
so the construct made some sense. Now we do not have to play tricks
though and GFP_NOWAIT will provide the required semantic (aka do not
sleep and do not consume any memory reserves).

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 security/selinux/avc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 4b4293194aee..b2c159e832b6 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -346,27 +346,26 @@ static struct avc_xperms_decision_node
 	struct avc_xperms_decision_node *xpd_node;
 	struct extended_perms_decision *xpd;
 
-	xpd_node = kmem_cache_zalloc(avc_xperms_decision_cachep,
-				GFP_ATOMIC | __GFP_NOMEMALLOC);
+	xpd_node = kmem_cache_zalloc(avc_xperms_decision_cachep, GFP_NOWAIT);
 	if (!xpd_node)
 		return NULL;
 
 	xpd = &xpd_node->xpd;
 	if (which & XPERMS_ALLOWED) {
 		xpd->allowed = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->allowed)
 			goto error;
 	}
 	if (which & XPERMS_AUDITALLOW) {
 		xpd->auditallow = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->auditallow)
 			goto error;
 	}
 	if (which & XPERMS_DONTAUDIT) {
 		xpd->dontaudit = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_ATOMIC | __GFP_NOMEMALLOC);
+						GFP_NOWAIT);
 		if (!xpd->dontaudit)
 			goto error;
 	}
@@ -394,8 +393,7 @@ static struct avc_xperms_node *avc_xperms_alloc(void)
 {
 	struct avc_xperms_node *xp_node;
 
-	xp_node = kmem_cache_zalloc(avc_xperms_cachep,
-				GFP_ATOMIC|__GFP_NOMEMALLOC);
+	xp_node = kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT);
 	if (!xp_node)
 		return xp_node;
 	INIT_LIST_HEAD(&xp_node->xpd_head);
@@ -548,7 +546,7 @@ static struct avc_node *avc_alloc_node(void)
 {
 	struct avc_node *node;
 
-	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC|__GFP_NOMEMALLOC);
+	node = kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
 	if (!node)
 		goto out;
 
-- 
2.13.2

-- 
Michal Hocko
SUSE Labs
