Message-ID: <1518025709.16883.48.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Date: Wed, 07 Feb 2018 12:48:29 -0500
In-Reply-To: <CAHC9VhTGF6_zP46tP3JdWna2_7BJ+oD0eKccmAhy3xXdfeRZ_w@mail.gmail.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-2-sds@tycho.nsa.gov>
 <CAHC9VhTGF6_zP46tP3JdWna2_7BJ+oD0eKccmAhy3xXdfeRZ_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 01/10] selinux: introduce a selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2018-02-06 at 17:18 -0500, Paul Moore wrote:
> On Mon, Oct 2, 2017 at 11:58 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > Define a selinux namespace structure (struct selinux_ns)
> > for SELinux state and pass it explicitly to all security server
> > functions.  The public portion of the structure contains state
> > that is used throughout the SELinux code, such as the enforcing
> > mode.
> > The structure also contains a pointer to a selinux_ss structure
> > whose
> > definition is private to the security server and contains security
> > server specific state such as the policy database and SID table.
> > 
> > This change allocates a single selinux namespace, the
> > init_selinux_ns.
> > It defines and passes a symbol for the current selinux namespace
> > (current_selinux_ns) as a placeholder for future changes where
> > multiple selinux namespaces will be supported, but in this change
> > the current selinux namespace is always the init selinux namespace.
> > Note that passing the current selinux namespace is not correct for
> > all hooks; some hooks will need to be adjusted to pass the selinux
> > namespace associated with an open file, a network namespace or
> > socket,
> > etc, since not all hooks are invoked in process context and some
> > hooks operate in the context of a cred that may differ from
> > current's
> > cred.  Fixing all of these cases is left to future changes, once
> > we introduce the support for multiple selinux namespaces.
> > 
> > This change by itself should have no effect on SELinux behavior or
> > APIs (userspace or LSM).  It merely wraps SELinux state and passes
> > it
> > explicitly as needed.
> 
> To put things in context, I'm looking at this patch not really with
> namespacing in mind, but rather with the idea of encapsulating the
> SELinux global state.  Regardless of what we do with namespacing, I
> believe the encapsulation work still has value.
> 
> My comments are inline below.  I'm going to try and trim out a lot of
> this patch in my reply as most of are trivial changes needed to pass
> around the new state pointers.
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f5d3047..9eb48a1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -97,20 +97,24 @@
> >  #include "audit.h"
> >  #include "avc_ss.h"
> > 
> > +struct selinux_ns *init_selinux_ns;
> 
> This comment applies to more than just the particular line above, it
> really applies to the entire patch.
> 
> If we are going to merge this patch, and presumably a few others,
> independent of the namespacing work, I would strongly prefer if we
> used more general names instead of ones tied so closely to
> namespacing.  For example, something along the lines of "struct
> selinux_state" would be more desirable than "struct selinux_ns"; it
> doesn't have to be "selinux_state", that was just the first thing I
> could come up with.
> 
> > +static void selinux_ns_free(struct work_struct *work);
> > +
> > +int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns
> > **ns)
> > +{
> > +       struct selinux_ns *newns;
> > +       int rc;
> > +
> > +       newns = kzalloc(sizeof(*newns), GFP_KERNEL);
> > +       if (!newns)
> > +               return -ENOMEM;
> > +
> > +       refcount_set(&newns->count, 1);
> > +       INIT_WORK(&newns->work, selinux_ns_free);
> > +
> > +       rc = selinux_ss_create(&newns->ss);
> > +       if (rc)
> > +               goto err;
> > +
> > +       if (parent)
> > +               newns->parent = get_selinux_ns(parent);
> > +
> > +       *ns = newns;
> > +       return 0;
> > +err:
> > +       kfree(newns);
> > +       return rc;
> > +}
> > +
> > +static void selinux_ns_free(struct work_struct *work)
> > +{
> > +       struct selinux_ns *parent, *ns =
> > +               container_of(work, struct selinux_ns, work);
> > +
> > +       do {
> > +               parent = ns->parent;
> > +               selinux_ss_free(ns->ss);
> > +               kfree(ns);
> > +               ns = parent;
> > +       } while (ns && refcount_dec_and_test(&ns->count));
> > +}
> > +
> > +void __put_selinux_ns(struct selinux_ns *ns)
> > +{
> > +       schedule_work(&ns->work);
> > +}
> 
> While we would obviously need something like this for proper
> namespacing, with only a single state struct we don't need all the
> state/namespace management.
>
> However, I would still be willing to accept all the changes to pass
> around a reference to the global state struct, even if in this
> particular case it was always going to be single/init struct.
> 
> > @@ -6487,6 +6585,11 @@ static __init int selinux_init(void)
> > 
> >         printk(KERN_INFO "SELinux:  Initializing.\n");
> > 
> > +       if (selinux_ns_create(NULL, &init_selinux_ns))
> > +               panic("SELinux: Could not create initial
> > namespace\n");
> 
> Not yet :)  If we stick with selinux_ns_create(), see my comments
> above, at the very least we need to pick an error message that
> doesn't
> hint at namespacing.
> 
> > @@ -6629,23 +6738,32 @@ static void selinux_nf_ip_exit(void)
> >  #endif /* CONFIG_NETFILTER */
> > 
> >  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > -static int selinux_disabled;
> > -
> > -int selinux_disable(void)
> > +int selinux_disable(struct selinux_ns *ns)
> >  {
> > -       if (ss_initialized) {
> > +       if (ns->initialized) {
> >                 /* Not permitted after initial policy load. */
> >                 return -EINVAL;
> >         }
> > 
> > -       if (selinux_disabled) {
> > +       if (ns->disabled) {
> >                 /* Only do this once. */
> >                 return -EINVAL;
> >         }
> > 
> > +       ns->disabled = 1;
> > +
> > +       /*
> > +        * Disable of a non-init ns does not disable SELinux in the
> > host.
> > +        * We simply let the disable succeed, and init will then
> > +        * unmount its selinuxfs instance and subsequent userspace
> > +        * within the ns will interpret the absence of a selinuxfs
> > mount
> > +        * as SELinux being disabled.
> > +        */
> > +       if (ns != init_selinux_ns)
> > +               return 0;
> 
> Something else we don't really need at this point.
> 
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > index 28dfb2f..b70d1dd 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -97,13 +92,80 @@ extern int
> > selinux_policycap_nnp_nosuid_transition;
> >  /* limitation of boundary depth  */
> >  #define POLICYDB_BOUNDS_MAXDEPTH       4
> > 
> > -int security_mls_enabled(void);
> > +struct selinux_ss;
> > +
> > +struct selinux_ns {
> > +       refcount_t count;
> > +       struct work_struct work;
> > +       bool disabled;
> > +#ifdef CONFIG_SECURITY_SELINUX_DEVELOP
> > +       bool enforcing;
> > +#endif
> > +       bool checkreqprot;
> > +       bool initialized;
> > +       bool policycap[__POLICYDB_CAPABILITY_MAX];
> > +       struct selinux_ss *ss;
> 
> While I don't think we need to tackle this as part of the
> encapsulation work, this is another reminder that we should look into
> breaking the separation between the security server and the
> Linux/hooks code.  I understand there were historical reasons for
> this
> split, but I think all of those reasons are now gone, and further I
> think enough Linux'isms have crept into the security server that the
> separation is no longer as meaningful as it may have been in the
> past.

I think we want to retain some degree of encapsulation of the policy
logic and data structures, which is what the security server is
supposed to provide.  That allows us to evolve that logic and
structures without impacting the object label management and permission
enforcement code.  Separation of policy from mechanism.  I don't mind
nativizing the security server for Linux, and where appropriate,
allowing some optimization of the interfaces between it and the rest of
the SELinux code, but I wouldn't want to e.g. directly expose the
policydb to the rest of the code.  There has been some leakage of
policy awareness outside the security server in the past but I view
that as a mistake that ought to be corrected over time.

> 
> > +#define current_selinux_ns (init_selinux_ns)
> > 
> > +#define ss_initialized (current_selinux_ns->initialized)
> > +
> > +#ifdef CONFIG_SECURITY_SELINUX_DEVELOP
> > +#define selinux_enforcing (current_selinux_ns->enforcing)
> > +#define ns_enforcing(ns) ((ns)->enforcing)
> > +#define set_ns_enforcing(ns, value) ((ns)->enforcing = value)
> > +#else
> > +#define selinux_enforcing 1
> > +#define ns_enforcing(ns) 1
> > +#define set_ns_enforcing(ns, value)
> > +#endif
> > +
> > +#define selinux_checkreqprot (current_selinux_ns->checkreqprot)
> > +
> > +#define selinux_policycap_netpeer \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_NETPEER])
> > +#define selinux_policycap_openperm \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_OPENPERM])
> > +#define selinux_policycap_extsockclass \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_EXTSOCKCLASS])
> > +#define selinux_policycap_alwaysnetwork \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_ALWAYSNETWORK])
> > +#define selinux_policycap_cgroupseclabel \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_CGROUPSECLABEL])
> > +#define selinux_policycap_nnp_nosuid_transition \
> > +       (current_selinux_ns-
> > >policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION])
> 
> I realize this was likely the quickest solution, but I think I would
> prefer to see stuff like the above written as small static inline
> functions.
> 
