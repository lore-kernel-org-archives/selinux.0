Date: Fri, 6 Jun 2008 22:47:49 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/3] SELinux: open code load_mutex
In-Reply-To: <1212754289.2763.169.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0806062247320.30306@us.intercode.com.au>
References: <Xine.LNX.4.64.0806061856160.25093@us.intercode.com.au>
 <Xine.LNX.4.64.0806061858010.25093@us.intercode.com.au>
 <1212754289.2763.169.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Jun 2008, Stephen Smalley wrote:

> 
> On Fri, 2008-06-06 at 18:58 +1000, James Morris wrote:
> > Open code load_mutex as suggested by Andrew Morton.
> > 
> > Signed-off-by: James Morris <jmorris@namei.org>
> 
> This is technically correct, but I believe that load_mutex is actually
> obsolete and can be completely removed.  Note that
> security_load_policy() is only called from selinuxfs while holding
> sel_mutex there, which is required in order to synchronize with boolean
> manipulation.  load_mutex is a leftover from before the age of policy
> booleans.

Ok, that should be a separate patch, I think.

> 
> > ---
> >  security/selinux/ss/services.c |   21 +++++++++------------
> >  1 files changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index e8ec54d..d06df33 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -71,10 +71,7 @@ int selinux_policycap_openperm;
> >  extern const struct selinux_class_perm selinux_class_perm;
> >  
> >  static DEFINE_RWLOCK(policy_rwlock);
> > -
> >  static DEFINE_MUTEX(load_mutex);
> > -#define LOAD_LOCK mutex_lock(&load_mutex)
> > -#define LOAD_UNLOCK mutex_unlock(&load_mutex)
> >  
> >  static struct sidtab sidtab;
> >  struct policydb policydb;
> > @@ -1456,17 +1453,17 @@ int security_load_policy(void *data, size_t len)
> >  	int rc = 0;
> >  	struct policy_file file = { data, len }, *fp = &file;
> >  
> > -	LOAD_LOCK;
> > +	mutex_lock(&load_mutex);
> >  
> >  	if (!ss_initialized) {
> >  		avtab_cache_init();
> >  		if (policydb_read(&policydb, fp)) {
> > -			LOAD_UNLOCK;
> > +			mutex_unlock(&load_mutex);
> >  			avtab_cache_destroy();
> >  			return -EINVAL;
> >  		}
> >  		if (policydb_load_isids(&policydb, &sidtab)) {
> > -			LOAD_UNLOCK;
> > +			mutex_unlock(&load_mutex);
> >  			policydb_destroy(&policydb);
> >  			avtab_cache_destroy();
> >  			return -EINVAL;
> > @@ -1475,7 +1472,7 @@ int security_load_policy(void *data, size_t len)
> >  		if (validate_classes(&policydb)) {
> >  			printk(KERN_ERR
> >  			       "SELinux:  the definition of a class is incorrect\n");
> > -			LOAD_UNLOCK;
> > +			mutex_unlock(&load_mutex);
> >  			sidtab_destroy(&sidtab);
> >  			policydb_destroy(&policydb);
> >  			avtab_cache_destroy();
> > @@ -1485,7 +1482,7 @@ int security_load_policy(void *data, size_t len)
> >  		policydb_loaded_version = policydb.policyvers;
> >  		ss_initialized = 1;
> >  		seqno = ++latest_granting;
> > -		LOAD_UNLOCK;
> > +		mutex_unlock(&load_mutex);
> >  		selinux_complete_init();
> >  		avc_ss_reset(seqno);
> >  		selnl_notify_policyload(seqno);
> > @@ -1499,12 +1496,12 @@ int security_load_policy(void *data, size_t len)
> >  #endif
> >  
> >  	if (policydb_read(&newpolicydb, fp)) {
> > -		LOAD_UNLOCK;
> > +		mutex_unlock(&load_mutex);
> >  		return -EINVAL;
> >  	}
> >  
> >  	if (sidtab_init(&newsidtab)) {
> > -		LOAD_UNLOCK;
> > +		mutex_unlock(&load_mutex);
> >  		policydb_destroy(&newpolicydb);
> >  		return -ENOMEM;
> >  	}
> > @@ -1552,7 +1549,7 @@ int security_load_policy(void *data, size_t len)
> >  	seqno = ++latest_granting;
> >  	policydb_loaded_version = policydb.policyvers;
> >  	write_unlock_irq(&policy_rwlock);
> > -	LOAD_UNLOCK;
> > +	mutex_unlock(&load_mutex);
> >  
> >  	/* Free the old policydb and SID table. */
> >  	policydb_destroy(&oldpolicydb);
> > @@ -1566,7 +1563,7 @@ int security_load_policy(void *data, size_t len)
> >  	return 0;
> >  
> >  err:
> > -	LOAD_UNLOCK;
> > +	mutex_unlock(&load_mutex);
> >  	sidtab_destroy(&newsidtab);
> >  	policydb_destroy(&newpolicydb);
> >  	return rc;
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
