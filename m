Subject: Re: [PATCH] checkpolicy: implement handling of unknown classes
	andpermissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1190395644.15178.5.camel@gorn.columbia.tresys.com>
References: <1189103186.3418.35.camel@localhost.localdomain>
	 <1190144886.14037.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1190395644.15178.5.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 15:08:56 -0400
Message-Id: <1190401736.17518.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-21 at 13:27 -0400, Christopher J. PeBenito wrote:
> On Tue, 2007-09-18 at 15:48 -0400, Stephen Smalley wrote:
> > On Thu, 2007-09-06 at 14:26 -0400, Eric Paris wrote:
> > > Add a new command line options, -U (allow,reject,deny), to
> > checkmodule
> > > and checkpolicy which sets the handle_unknown config flag.  Default
> > to
> > > deny unknowns which is how things have been in the past.  Also add
> > > dismod and dispol support.
> > >
> > > -Eric
> > 
> > Thanks, merged as of checkpolicy 2.0.4.
> > 
> > Chris/Dan:  we need some way to select the flag setting for the policy
> > build.  The -U {allow,reject,deny} setting needs to be passed to
> > checkmodule _only_ when building the base module, or to checkpolicy
> > when
> > building a monolithic policy.
> 
> Here is a patch for this, I haven't committed this to trunk yet, as I'd
> prefer to wait for the next stable release of the toolchain (when its
> that, btw?).

I was planning to do it early next week.

However, I only committed this change to the trunk version of
checkpolicy/libsepol, not the stable branch, as it certainly isn't a bug
fix or trivial cleanup.  So by "stable release", do you just mean a
release, or do you mean a release of the stable branch that includes
this change?

> 
> Index: build.conf
> ===================================================================
> --- build.conf	(revision 2423)
> +++ build.conf	(working copy)
> @@ -31,6 +31,14 @@
>  # Fedora users should enable redhat.
>  #DISTRO = redhat
>  
> +# Unknown Permissions Handling
> +# The behavior for handling permissions defined in the
> +# kernel but missing from the policy.  The permissions
> +# can either be allowed, denied, or the policy loading
> +# can be rejected.
> +# allow, deny, and reject are current options.
> +UNK_PERMS = deny
> +
>  # Direct admin init
>  # Setting this will allow sysadm to directly
>  # run init scripts, instead of requring run_init.
> Index: Rules.modular
> ===================================================================
> --- Rules.modular	(revision 2425)
> +++ Rules.modular	(working copy)
> @@ -98,7 +98,7 @@
>  
>  $(base_mod): $(base_conf)
>  	@echo "Compiling $(NAME) base module"
> -	$(verbose) $(CHECKMODULE) $^ -o $@
> +	$(verbose) $(CHECKMODULE) -U $(UNK_PERMS) $^ -o $@
>  
>  $(tmpdir)/seusers: $(seusers)
>  	@mkdir -p $(tmpdir)
> Index: Makefile
> ===================================================================
> --- Makefile	(revision 2425)
> +++ Makefile	(working copy)
> @@ -201,6 +201,9 @@
>  # if not set, use the type as the name.
>  NAME ?= $(TYPE)
>  
> +# default unknown permissions setting
> +UNK_PERMS ?= deny
> +
>  ifeq ($(DIRECT_INITRC),y)
>  	M4PARAM += -D direct_sysadm_daemon
>  endif
> Index: Rules.monolithic
> ===================================================================
> --- Rules.monolithic	(revision 2425)
> +++ Rules.monolithic	(working copy)
> @@ -70,7 +70,7 @@
>  	@echo "WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?"
>  	@echo
>  endif
> -	$(verbose) $(CHECKPOLICY) $^ -o $@
> +	$(verbose) $(CHECKPOLICY) -U $(UNK_PERMS) $^ -o $@
>  
>  ########################################
>  #
> @@ -84,7 +84,7 @@
>  	@echo "WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?"
>  	@echo
>  endif
> -	$(verbose) $(CHECKPOLICY) $^ -o $@
> +	$(verbose) $(CHECKPOLICY) -U $(UNK_PERMS) $^ -o $@
>  
>  ########################################
>  #
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
