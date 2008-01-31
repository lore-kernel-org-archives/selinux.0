Subject: Re: [patch] Tuning avtab to reduce memory usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, Joshua Brindle <method@manicmethod.com>,
        "Todd C. Miller" <tmiller@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1201813250.4568.118.camel@moss-spartans.epoch.ncsc.mil>
References: <20070823094904.1AB9.YNAKAM@hitachisoft.jp>
	 <1187874925.1451.473.camel@moss-spartans.epoch.ncsc.mil>
	 <20070824115232.5B89.YNAKAM@hitachisoft.jp>
	 <1201813250.4568.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 31 Jan 2008 16:44:09 -0500
Message-Id: <1201815849.4568.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-31 at 16:00 -0500, Stephen Smalley wrote:
> On Fri, 2007-08-24 at 11:55 +0900, Yuichi Nakamura wrote:
> > On Thu, 23 Aug 2007 09:15:25 -0400
> > Stephen Smalley  wrote:
> > > On Thu, 2007-08-23 at 09:57 +0900, Yuichi Nakamura wrote:
> > > > Following is updated patch to 2.6.22.
> > > > 
> > > > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> > > > ---
> > > >  security/selinux/ss/avtab.c       |   78 +++++++++++++++++++++++++++-----------
> > > >  security/selinux/ss/avtab.h       |   16 +++++--
> > > >  security/selinux/ss/conditional.c |    4 +
> > > >  security/selinux/ss/policydb.c    |    7 ---
> > > >  4 files changed, 73 insertions(+), 32 deletions(-)
> > > > diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.c linux-2.6.22/security/selinux/ss/avtab.c
> > > > --- linux-2.6.22.orig/security/selinux/ss/avtab.c	2007-07-09 08:32:17.000000000 +0900
> > > > +++ linux-2.6.22/security/selinux/ss/avtab.c	2007-08-23 09:30:03.000000000 +0900
> > > > +int avtab_alloc(struct avtab *h, int nrules)
> > > 
> > > nrules should be u32 too.
> > Fixed.
> > 
> > > 
> > > And you should likely test for the degenerate case (nrules == 0) and
> > > bail on it.
> > Checking nrules==0.
> > And also checking !h->htable like below in avtab_search_node etc.
> > -	if (!h)
> > +	if (!h || !h->htable)
> > 
> > Following is updated patch.
> > From: Yuichi Nakamura <ynakam@hitachisoft.jp>
> > 
> > This patch reduces memory usage of SELinux by tuning avtab. Number of
> > hash slots in avtab was 32768. Unused slots used memory when number 
> > of rules is fewer. This patch decides number of hash slots dynamically
> > based on number of rules. (chain length)^2 is also printed out in
> > avtab_hash_eval to see standard deviation of avtab hash table.
> > 
> > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> > ---
> >  security/selinux/ss/avtab.c       |   91 +++++++++++++++++++++++++++-----------
> >  security/selinux/ss/avtab.h       |   16 ++++--
> >  security/selinux/ss/conditional.c |    4 +
> >  security/selinux/ss/policydb.c    |    7 --
> >  4 files changed, 82 insertions(+), 36 deletions(-)
> 
> Hi,
> 
> I'd like to apply the equivalent changes to libsepol, if you have no
> objection (note that libsepol is LGPL rather than GPL).  A port of your
> patch to libsepol is below.  This is to reduce memory usage by
> libsepol/libsemanage when reading in modules and policies. Is that ok
> with you?
> 
>  checkpolicy/test/dispol.c               |    2 
>  libsepol/include/sepol/policydb/avtab.h |   18 ++++---
>  libsepol/src/avtab.c                    |   80 ++++++++++++++++++++++++--------
>  libsepol/src/conditional.c              |    4 +
>  libsepol/src/policydb.c                 |    7 --
>  libsepol/src/write.c                    |   11 ++--
>  6 files changed, 85 insertions(+), 37 deletions(-)

Some further fixes below, relative to the prior patch.

diff -u libsepol/src/avtab.c libsepol/src/avtab.c
--- libsepol/src/avtab.c	(working copy)
+++ libsepol/src/avtab.c	(working copy)
@@ -85,7 +85,7 @@
 	uint16_t specified =
 	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return SEPOL_ENOMEM;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -126,7 +126,7 @@
 	uint16_t specified =
 	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
@@ -158,7 +158,7 @@
 	uint16_t specified =
 	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -193,7 +193,7 @@
 	uint16_t specified =
 	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
--- libsepol/src/expand.c	(revision 2773)
+++ libsepol/src/expand.c	(working copy)
@@ -2137,6 +2138,16 @@
 	avrule_block_t *curblock;
 	int retval = -1;
 
+	if (avtab_alloc(&state->out->te_avtab, MAX_AVTAB_SIZE)) {
+		ERR(state->handle, "Out of Memory!");
+		return -1;
+	}
+
+	if (avtab_alloc(&state->out->te_cond_avtab, MAX_AVTAB_SIZE)) {
+		ERR(state->handle, "Out of Memory!");
+		return -1;
+	}
+
 	for (curblock = state->base->global; curblock != NULL;
 	     curblock = curblock->next) {
 		avrule_decl_t *decl = curblock->enabled;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
