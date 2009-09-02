MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libselinux: disable refcounting in the userspace AVC
Date: Wed, 2 Sep 2009 09:35:46 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com>
In-Reply-To: <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil>
References: <4A9DE7FE.9000008@tycho.nsa.gov> <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Cc: "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> 
> On Tue, 2009-09-01 at 23:35 -0400, Eamon Walsh wrote:
> > The userspace AVC currently has refcounted SID's.  This patch strips
> out
> > the refcounting under the following justifications:
> >
> > 1.  Managing the refcounts by calling sidput() and sidget() as
> > appropriate is a difficult and bug-prone task for users of the
> library.
> >
> > 2.  The userspace AVC doesn't currently make use of the refcounts to
> > reclaim unused SID's unless avc_cleanup() is explicitly called.
> >
> > 3.  The kernel itself no longer uses refcounting for it's own SID's.
> 
> Just to clarify on this point:  Early on we had discussed introducing
> refcounting of kernel SIDs to enable reclaiming unused ones, but this
> became less important once the user/kernel interface was converted
from
> passing SIDs to passing security contexts.  In that case we were
> dealing
> with a global (wrt a system) resource and kernel memory, whereas in
the
> userspace AVC we are only dealing with a per-object-manager SID table
> and the application's virtual memory.
> 

So is the purpose of the patch just to remove unnecessary complication
in the userspace sidtab? Will this affect multithreaded applications
that share a sidtab? 

IIRC sepostgres reimplemented its sidtab and avc because our current one
wasn't very friendly to multithread/multiprocess object managers.

> > The implication of this change is that SID's (basically malloc'ed
> copies
> > of security contexts) will persist in the AVC's SID table until the
> next
> > call to avc_destroy().  This presents the potential for increased
> memory
> > usage, but in practice I don't believe this will be an issue.  ABI
> > compatibility is preserved: the avc_cleanup(), sidput(), and
sidget()
> > calls are changed to no-ops.
> >
> > Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> > ---
> >
> >   avc.c          |  122
+++++++--------------------------------------
> ------------
> >   avc_internal.h |   11 -----
> >   avc_sidtab.c   |   42 -------------------
> >   avc_sidtab.h   |    2
> >   4 files changed, 16 insertions(+), 161 deletions(-)
> >
> >
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index f0e2d33..1c62fa3 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -71,8 +71,6 @@ int avc_context_to_sid_raw(security_context_t ctx,
> security_id_t * sid)
> >   	int rc;
> >   	avc_get_lock(avc_lock);
> >   	rc = sidtab_context_to_sid(&avc_sidtab, ctx, sid);
> > -	if (!rc)
> > -		(*sid)->refcnt++;
> >   	avc_release_lock(avc_lock);
> >   	return rc;
> >   }
> > @@ -97,13 +95,8 @@ int avc_sid_to_context_raw(security_id_t sid,
> security_context_t * ctx)
> >   	int rc;
> >   	*ctx = NULL;
> >   	avc_get_lock(avc_lock);
> > -	if (sid->refcnt>  0) {
> > -		*ctx = strdup(sid->ctx);	/* caller must free via
> freecon */
> > -		rc = *ctx ? 0 : -1;
> > -	} else {
> > -		errno = EINVAL;	/* bad reference count */
> > -		rc = -1;
> > -	}
> > +	*ctx = strdup(sid->ctx);	/* caller must free via freecon
*/
> > +	rc = *ctx ? 0 : -1;
> >   	avc_release_lock(avc_lock);
> >   	return rc;
> >   }
> > @@ -123,24 +116,14 @@ int avc_sid_to_context(security_id_t sid,
> security_context_t * ctx)
> >   	return ret;
> >   }
> >
> > -int sidget(security_id_t sid)
> > +int sidget(security_id_t sid __attribute__((unused)))
> >   {
> > -	int rc;
> > -	avc_get_lock(avc_lock);
> > -	rc = sid_inc_refcnt(sid);
> > -	avc_release_lock(avc_lock);
> > -	return rc;
> > +	return 1;
> >   }
> >
> > -int sidput(security_id_t sid)
> > +int sidput(security_id_t sid __attribute__((unused)))
> >   {
> > -	int rc;
> > -	if (!sid)
> > -	    return 0;
> > -	avc_get_lock(avc_lock);
> > -	rc = sid_dec_refcnt(sid);
> > -	avc_release_lock(avc_lock);
> > -	return rc;
> > +	return 1;
> >   }
> >
> >   int avc_get_initial_sid(const char * name, security_id_t * sid)
> > @@ -505,57 +488,8 @@ static int avc_insert(security_id_t ssid,
> security_id_t tsid,
> >   	return rc;
> >   }
> >
> > -/**
> > - * avc_remove - Remove AVC and sidtab entries for SID.
> > - * @sid: security identifier to be removed
> > - *
> > - * Remove all AVC entries containing @sid as source, target, or
> > - * create_sid, and remove @sid from the SID table.
> > - * Free the memory allocated for the structure corresponding
> > - * to @sid.  After this function has been called, @sid must
> > - * not be used until another call to avc_context_to_sid() has
> > - * been made for this SID.
> > - */
> > -static void avc_remove(security_id_t sid)
> > -{
> > -	struct avc_node *prev, *cur, *tmp;
> > -	int i;
> > -
> > -	for (i = 0; i<  AVC_CACHE_SLOTS; i++) {
> > -		cur = avc_cache.slots[i];
> > -		prev = NULL;
> > -		while (cur) {
> > -			if (sid == cur->ae.ssid || sid == cur->ae.tsid
||
> > -			    sid == cur->ae.create_sid) {
> > -				if (prev)
> > -					prev->next = cur->next;
> > -				else
> > -					avc_cache.slots[i] = cur->next;
> > -				tmp = cur;
> > -				cur = cur->next;
> > -				avc_clear_avc_entry(&tmp->ae);
> > -				tmp->next = avc_node_freelist;
> > -				avc_node_freelist = tmp;
> > -				avc_cache.active_nodes--;
> > -			} else {
> > -				prev = cur;
> > -				cur = cur->next;
> > -			}
> > -		}
> > -	}
> > -	sidtab_remove(&avc_sidtab, sid);
> > -}
> > -
> >   void avc_cleanup(void)
> >   {
> > -	security_id_t sid;
> > -
> > -	avc_get_lock(avc_lock);
> > -
> > -	while (NULL != (sid = sidtab_claim_sid(&avc_sidtab)))
> > -		avc_remove(sid);
> > -
> > -	avc_release_lock(avc_lock);
> >   }
> >
> >   hidden_def(avc_cleanup)
> > @@ -745,15 +679,8 @@ static void avc_dump_query(security_id_t ssid,
> security_id_t tsid,
> >   {
> >   	avc_get_lock(avc_lock);
> >
> > -	if (ssid->refcnt>  0)
> > -		log_append(avc_audit_buf, "scontext=%s", ssid->ctx);
> > -	else
> > -		log_append(avc_audit_buf, "ssid=%p", ssid);
> > -
> > -	if (tsid->refcnt>  0)
> > -		log_append(avc_audit_buf, " tcontext=%s", tsid->ctx);
> > -	else
> > -		log_append(avc_audit_buf, " tsid=%p", tsid);
> > +	log_append(avc_audit_buf, "scontext=%s tcontext=%s",
> > +		   ssid->ctx, tsid->ctx);
> >
> >   	avc_release_lock(avc_lock);
> >   	log_append(avc_audit_buf, " tclass=%s",
> > @@ -844,11 +771,6 @@ int avc_has_perm_noaudit(security_id_t ssid,
> >   		avc_cache_stats_incr(entry_misses);
> >   		rc = avc_lookup(ssid, tsid, tclass, requested, aeref);
> >   		if (rc) {
> > -			if ((ssid->refcnt<= 0) || (tsid->refcnt<= 0)) {
> > -				errno = EINVAL;
> > -				rc = -1;
> > -				goto out;
> > -			}
> >   			rc = security_compute_av_flags_raw(ssid->ctx,
tsid-
> >ctx,
> >   							   tclass,
requested,
> >   							&entry.avd);
> > @@ -911,11 +833,6 @@ int avc_compute_create(security_id_t ssid,
> security_id_t tsid,
> >   	avc_entry_ref_init(&aeref);
> >
> >   	avc_get_lock(avc_lock);
> > -	if (ssid->refcnt<= 0 || tsid->refcnt<= 0) {
> > -		errno = EINVAL;	/* bad reference count */
> > -		rc = -1;
> > -		goto out;
> > -	}
> >
> >   	/* check for a cached entry */
> >   	rc = avc_lookup(ssid, tsid, tclass, 0,&aeref);
> > @@ -950,8 +867,6 @@ int avc_compute_create(security_id_t ssid,
> security_id_t tsid,
> >
> >   	rc = 0;
> >   out:
> > -	if (*newsid)
> > -		(*newsid)->refcnt++;
> >   	avc_release_lock(avc_lock);
> >   	return rc;
> >   }
> > @@ -960,22 +875,15 @@ int avc_compute_member(security_id_t ssid,
> security_id_t tsid,
> >   		       security_class_t tclass, security_id_t *newsid)
> >   {
> >   	int rc;
> > +	security_context_t ctx = NULL;
> >   	*newsid = NULL;
> >   	avc_get_lock(avc_lock);
> > -	if (ssid->refcnt>  0&&  tsid->refcnt>  0) {
> > -		security_context_t ctx = NULL;
> > -		rc = security_compute_member_raw(ssid->ctx, tsid->ctx,
> tclass,
> > -						&ctx);
> > -		if (rc)
> > -			goto out;
> > -		rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
> > -		if (!rc)
> > -			(*newsid)->refcnt++;
> > -		freecon(ctx);
> > -	} else {
> > -		errno = EINVAL;	/* bad reference count */
> > -		rc = -1;
> > -	}
> > +
> > +	rc = security_compute_member_raw(ssid->ctx, tsid->ctx,
> tclass,&ctx);
> > +	if (rc)
> > +		goto out;
> > +	rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
> > +	freecon(ctx);
> >   out:
> >   	avc_release_lock(avc_lock);
> >   	return rc;
> > diff --git a/libselinux/src/avc_internal.h
> b/libselinux/src/avc_internal.h
> > index e9e5772..53610e8 100644
> > --- a/libselinux/src/avc_internal.h
> > +++ b/libselinux/src/avc_internal.h
> > @@ -16,17 +16,6 @@
> >   #include "callbacks.h"
> >   #include "dso.h"
> >
> > -/* SID reference counter manipulation */
> > -static inline int sid_inc_refcnt(security_id_t sid)
> > -{
> > -	return sid->refcnt = (sid->refcnt>  0) ? sid->refcnt + 1 : 0;
> > -}
> > -
> > -static inline int sid_dec_refcnt(security_id_t sid)
> > -{
> > -	return sid->refcnt = (sid->refcnt>  0) ? sid->refcnt - 1 : 0;
> > -}
> > -
> >   /* callback pointers */
> >   extern void *(*avc_func_malloc) (size_t) hidden;
> >   extern void (*avc_func_free) (void *)hidden;
> > diff --git a/libselinux/src/avc_sidtab.c
> b/libselinux/src/avc_sidtab.c
> > index dab5c4e..3ca1d1f 100644
> > --- a/libselinux/src/avc_sidtab.c
> > +++ b/libselinux/src/avc_sidtab.c
> > @@ -67,53 +67,13 @@ int sidtab_insert(struct sidtab *s,
> security_context_t ctx)
> >   	hvalue = sidtab_hash(newctx);
> >   	newnode->next = s->htable[hvalue];
> >   	newnode->sid_s.ctx = newctx;
> > -	newnode->sid_s.refcnt = 0;	/* caller should increment */
> > +	newnode->sid_s.refcnt = 1;	/* unused */
> >   	s->htable[hvalue] = newnode;
> >   	s->nel++;
> >         out:
> >   	return rc;
> >   }
> >
> > -void sidtab_remove(struct sidtab *s, security_id_t sid)
> > -{
> > -	int hvalue;
> > -	struct sidtab_node *cur, *prev;
> > -
> > -	hvalue = sidtab_hash(sid->ctx);
> > -	cur = s->htable[hvalue];
> > -	prev = NULL;
> > -	while (cur) {
> > -		if (sid ==&cur->sid_s) {
> > -			if (prev)
> > -				prev->next = cur->next;
> > -			else
> > -				s->htable[hvalue] = cur->next;
> > -			avc_free(cur);
> > -			s->nel--;
> > -			return;
> > -		} else {
> > -			prev = cur;
> > -			cur = cur->next;
> > -		}
> > -	}
> > -}
> > -
> > -security_id_t sidtab_claim_sid(struct sidtab *s)
> > -{
> > -	int i;
> > -	struct sidtab_node *cur;
> > -
> > -	for (i = 0; i<  SIDTAB_SIZE; i++) {
> > -		cur = s->htable[i];
> > -		while (cur) {
> > -			if (!cur->sid_s.refcnt)
> > -				return&cur->sid_s;
> > -			cur = cur->next;
> > -		}
> > -	}
> > -	return NULL;
> > -}
> > -
> >   int
> >   sidtab_context_to_sid(struct sidtab *s,
> >   		      security_context_t ctx, security_id_t * sid)
> > diff --git a/libselinux/src/avc_sidtab.h
> b/libselinux/src/avc_sidtab.h
> > index 620a335..29b5d8b 100644
> > --- a/libselinux/src/avc_sidtab.h
> > +++ b/libselinux/src/avc_sidtab.h
> > @@ -26,8 +26,6 @@ struct sidtab {
> >
> >   int sidtab_init(struct sidtab *s) hidden;
> >   int sidtab_insert(struct sidtab *s, security_context_t ctx)
hidden;
> > -void sidtab_remove(struct sidtab *s, security_id_t sid) hidden;
> > -security_id_t sidtab_claim_sid(struct sidtab *s) hidden;
> >
> >   int sidtab_context_to_sid(struct sidtab *s,
> >   			  security_context_t ctx, security_id_t * sid)
> hidden;
> >
> >
> >
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
