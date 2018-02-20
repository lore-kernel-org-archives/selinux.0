Message-ID: <1519142313.14218.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Peter Enderborg <peter.enderborg@sony.com>, Paul Moore
 <paul@paul-moore.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Date: Tue, 20 Feb 2018 10:58:33 -0500
In-Reply-To: <1519135142.10331.12.camel@tycho.nsa.gov>
References: <20180219151800.14442-1-peter.enderborg@sony.com>
 <1519135142.10331.12.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH selinux-next] selinux: Annotate lockdep for services locks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2018-02-20 at 08:59 -0500, Stephen Smalley wrote:
> On Mon, 2018-02-19 at 16:18 +0100, Peter Enderborg wrote:
> > From: Peter <peter.enderborg@sony.com>
> > 
> > The locks are moved to dynamic allocation, we need to
> > help the lockdep system to classify the locks.
> > This adds to lockdep annotation for the page mutex and
> > for the ss lock.
> > 
> > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > ---
> > This is the rebase of suggested patches from selinuxns tree
> > and are intended to be applyed on top of:
> > selinux: wrap global selinux state
> > from Stephen Smalley
> > 
> >  security/selinux/ss/services.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c
> > index 3698352213d7..a741552e22b5 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -81,11 +81,15 @@ char
> > *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
> >  };
> >  
> >  static struct selinux_ss selinux_ss;
> > +static struct lock_class_key selinux_ss_class_key;
> > +static struct lock_class_key selinux_status_class_key;
> >  
> >  void selinux_ss_init(struct selinux_ss **ss)
> >  {
> >  	rwlock_init(&selinux_ss.policy_rwlock);
> > +	lockdep_set_class(&selinux_ss.policy_rwlock,
> > &selinux_ss_class_key);
> >  	mutex_init(&selinux_ss.status_lock);
> > +	lockdep_set_class(&selinux_ss.status_lock,
> > &selinux_status_class_key);
> >  	*ss = &selinux_ss;
> >  }
> 
> Pardon my ignorance, but can you explain why we need an explicit call
> to lockdep_set_class() here?  I see it used for e.g. the inode
> i_lock,
> but there the class is per-file_system_type.  It doesn't seem to be
> always be used for all locks when they are dynamically initialized or
> allocated, e.g. get_empty_filp does not call lockdep_set_class() for
> struct file's f_owner.lock or f_lock even though they are dynamically
> allocated and initialized.  What makes this case different?

Also, your explanation in the patch description was because the locks
are moved to dynamic allocation.  That was true of the original selinux
namespace patch.  But it isn't true for the wrap global selinux state
patch; selinux_ss is statically allocated and there is only one
instance of it in this patch.  So do we need this lockdep annotation
yet?
