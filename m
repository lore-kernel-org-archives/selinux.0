Subject: Re: [PATCH] libsepol: support the handle_unknown config flag
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1190145622.14037.110.camel@moss-spartans.epoch.ncsc.mil>
References: <1185983548.3673.21.camel@localhost.localdomain>
	 <1187900870.1451.650.camel@moss-spartans.epoch.ncsc.mil>
	 <1190145622.14037.110.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 16:11:20 -0400
Message-Id: <1190146280.3451.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 16:00 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-23 at 16:27 -0400, Stephen Smalley wrote:
> > On Wed, 2007-08-01 at 11:52 -0400, Eric Paris wrote:
> > > Update the policydb definition to contain a handle_unknown flag.  Change
> > > libsepol to copy the handle_unknown config flag from the base policy to
> > > the final binary policy.  Also makes libsepol properly read and write
> > > the flag which dealing with policy modules.
> > > 
> > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > Here is a patch on top of yours that allows you to override the base
> > module setting via semanage.conf, handle-unknown = [deny,reject,allow].
> 
> Need to make a final decision on this patch - benefit is that the end
> user can alter the allow/reject/deny behavior for unknown classes/perms
> without rebuilding their base module, which is also precisely what
> worries people about it ;)  Could be used by a user to select deny or
> reject if the distro defaults to allow (e.g. Fedora) for the purpose of
> "tightening" the system or to select allow if the distro defaults to
> deny or reject for the purpose of relaxing the system.

I vote 'yeah' and lets make sure the kernel audits the message
correctly.  If the certification types really feel we need an old and
new value (still this is at policy load time) I'm sure I can find some
way to do it.

-Eric
> 
> > 
> > ---
> > 
> >  libsemanage/src/conf-parse.y               |   35 ++++++++++++++++++++---------
> >  libsemanage/src/conf-scan.l                |    1 
> >  libsemanage/src/semanage_conf.h            |    1 
> >  libsemanage/src/semanage_store.c           |    2 +
> >  libsepol/include/sepol/policydb.h          |    7 +++++
> >  libsepol/include/sepol/policydb/policydb.h |    6 ++--
> >  libsepol/src/policydb_public.c             |   18 ++++++++++++++
> >  7 files changed, 57 insertions(+), 13 deletions(-)
> > 
> > diff -X /home/sds/dontdiff -ru eric/libsemanage/src/conf-parse.y trunk/libsemanage/src/conf-parse.y
> > --- eric/libsemanage/src/conf-parse.y	2007-08-23 16:11:02.000000000 -0400
> > +++ trunk/libsemanage/src/conf-parse.y	2007-08-23 16:03:20.000000000 -0400
> > @@ -57,7 +57,7 @@
> >  }
> >  
> >  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
> > -%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON
> > +%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN
> >  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
> >  %token PROG_PATH PROG_ARGS
> >  %token <s> ARG
> > @@ -81,6 +81,7 @@
> >          |       save_previous
> >          |       save_linked
> >          |       disable_genhomedircon
> > +        |       handle_unknown
> >          ;
> >  
> >  module_store:   MODULE_STORE '=' ARG {
> > @@ -139,15 +140,28 @@
> >          ;
> >  
> >  disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
> > -								if (strcasecmp($3, "false") == 0) {
> > -										current_conf->disable_genhomedircon = 0;
> > -									} else if (strcasecmp($3, "true") == 0) {
> > -										current_conf->disable_genhomedircon = 1;
> > -									} else {
> > -										yyerror("disable-genhomedircon can only be 'true' or 'false'");
> > -									}
> > -									free($3);
> > -					  }
> > +	if (strcasecmp($3, "false") == 0) {
> > +		current_conf->disable_genhomedircon = 0;
> > +	} else if (strcasecmp($3, "true") == 0) {
> > +		current_conf->disable_genhomedircon = 1;
> > +	} else {
> > +		yyerror("disable-genhomedircon can only be 'true' or 'false'");
> > +	}
> > +	free($3);
> > + }
> > +
> > +handle_unknown: HANDLE_UNKNOWN '=' ARG {
> > +	if (strcasecmp($3, "deny") == 0) {
> > +		current_conf->handle_unknown = SEPOL_DENY_UNKNOWN;
> > +	} else if (strcasecmp($3, "reject") == 0) {
> > +		current_conf->handle_unknown = SEPOL_REJECT_UNKNOWN;
> > +	} else if (strcasecmp($3, "allow") == 0) {
> > +		current_conf->handle_unknown = SEPOL_ALLOW_UNKNOWN;
> > +	} else {
> > +		yyerror("handle-unknown can only be 'deny', 'reject' or 'allow'");
> > +	}
> > +	free($3);
> > + }
> >  
> >  command_block: 
> >                  command_start external_opts BLOCK_END  {
> > @@ -214,6 +228,7 @@
> >  	conf->store_path = strdup(basename(selinux_policy_root()));
> >  	conf->policyvers = sepol_policy_kern_vers_max();
> >  	conf->expand_check = 1;
> > +	conf->handle_unknown = -1;
> >  	conf->file_mode = 0644;
> >  
> >  	conf->save_previous = 0;
> > diff -X /home/sds/dontdiff -ru eric/libsemanage/src/conf-scan.l trunk/libsemanage/src/conf-scan.l
> > --- eric/libsemanage/src/conf-scan.l	2007-08-23 16:11:02.000000000 -0400
> > +++ trunk/libsemanage/src/conf-scan.l	2007-08-23 15:53:28.000000000 -0400
> > @@ -45,6 +45,7 @@
> >  save-previous     return SAVE_PREVIOUS;
> >  save-linked       return SAVE_LINKED;
> >  disable-genhomedircon return DISABLE_GENHOMEDIRCON;
> > +handle-unknown    return HANDLE_UNKNOWN;
> >  "[load_policy]"   return LOAD_POLICY_START;
> >  "[setfiles]"      return SETFILES_START;
> >  "[verify module]" return VERIFY_MOD_START;
> > diff -X /home/sds/dontdiff -ru eric/libsemanage/src/semanage_conf.h trunk/libsemanage/src/semanage_conf.h
> > --- eric/libsemanage/src/semanage_conf.h	2007-08-23 16:11:02.000000000 -0400
> > +++ trunk/libsemanage/src/semanage_conf.h	2007-08-23 15:53:53.000000000 -0400
> > @@ -38,6 +38,7 @@
> >  	int save_previous;
> >  	int save_linked;
> >  	int disable_genhomedircon;
> > +	int handle_unknown;
> >  	mode_t file_mode;
> >  	struct external_prog *load_policy;
> >  	struct external_prog *setfiles;
> > diff -X /home/sds/dontdiff -ru eric/libsemanage/src/semanage_store.c trunk/libsemanage/src/semanage_store.c
> > --- eric/libsemanage/src/semanage_store.c	2007-08-23 16:11:02.000000000 -0400
> > +++ trunk/libsemanage/src/semanage_store.c	2007-08-23 16:21:53.000000000 -0400
> > @@ -1619,6 +1619,8 @@
> >  		ERR(sh, "Unknown/Invalid policy version %d.", policyvers);
> >  		goto err;
> >  	}
> > +	if (sh->conf->handle_unknown >= 0)
> > +		sepol_policydb_set_handle_unknown(out, sh->conf->handle_unknown);
> >  
> >  	*policydb = out;
> >  	return STATUS_SUCCESS;
> > diff -X /home/sds/dontdiff -ru eric/libsepol/include/sepol/policydb/policydb.h trunk/libsepol/include/sepol/policydb/policydb.h
> > --- eric/libsepol/include/sepol/policydb/policydb.h	2007-08-23 16:11:32.000000000 -0400
> > +++ trunk/libsepol/include/sepol/policydb/policydb.h	2007-08-23 15:36:06.000000000 -0400
> > @@ -602,9 +602,9 @@
> >  #define POLICYDB_CONFIG_MLS    1
> >  
> >  /* the config flags related to unknown classes/perms are bits 2 and 3 */
> > -#define DENY_UNKNOWN	0x00000000
> > -#define REJECT_UNKNOWN	0x00000002
> > -#define ALLOW_UNKNOWN 	0x00000004
> > +#define DENY_UNKNOWN	SEPOL_DENY_UNKNOWN
> > +#define REJECT_UNKNOWN	SEPOL_REJECT_UNKNOWN
> > +#define ALLOW_UNKNOWN 	SEPOL_ALLOW_UNKNOWN
> >  
> >  #define POLICYDB_CONFIG_UNKNOWN_MASK	(DENY_UNKNOWN | REJECT_UNKNOWN | ALLOW_UNKNOWN)
> >  
> > diff -X /home/sds/dontdiff -ru eric/libsepol/include/sepol/policydb.h trunk/libsepol/include/sepol/policydb.h
> > --- eric/libsepol/include/sepol/policydb.h	2007-08-23 16:11:04.000000000 -0400
> > +++ trunk/libsepol/include/sepol/policydb.h	2007-08-23 16:27:02.000000000 -0400
> > @@ -83,6 +83,13 @@
> >   */
> >  extern int sepol_policydb_set_vers(sepol_policydb_t * p, unsigned int vers);
> >  
> > +/* Set how to handle unknown class/perms. */
> > +#define SEPOL_DENY_UNKNOWN	    0
> > +#define SEPOL_REJECT_UNKNOWN	    2
> > +#define SEPOL_ALLOW_UNKNOWN	    4
> > +extern int sepol_policydb_set_handle_unknown(sepol_policydb_t * p,
> > +					     unsigned int handle_unknown);
> > +
> >  /* 
> >   * Read a policydb from a policy file.
> >   * This automatically sets the type and version based on the 
> > diff -X /home/sds/dontdiff -ru eric/libsepol/src/policydb_public.c trunk/libsepol/src/policydb_public.c
> > --- eric/libsepol/src/policydb_public.c	2007-08-23 16:11:04.000000000 -0400
> > +++ trunk/libsepol/src/policydb_public.c	2007-08-23 16:27:40.000000000 -0400
> > @@ -134,6 +134,24 @@
> >  	return 0;
> >  }
> >  
> > +int sepol_policydb_set_handle_unknown(sepol_policydb_t * sp,
> > +				      unsigned int handle_unknown)
> > +{
> > +	struct policydb *p = &sp->p;
> > +
> > +	switch (handle_unknown) {
> > +	case SEPOL_DENY_UNKNOWN:
> > +	case SEPOL_REJECT_UNKNOWN:
> > +	case SEPOL_ALLOW_UNKNOWN:
> > +		break;
> > +	default:
> > +		return -1;
> > +	}
> > +
> > +	p->handle_unknown = handle_unknown;		
> > +	return 0;
> > +}
> > +
> >  int sepol_policydb_read(sepol_policydb_t * p, sepol_policy_file_t * pf)
> >  {
> >  	return policydb_read(&p->p, &pf->pf, 0);
> > 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
