Subject: Re: PATCH: fix uninitialized use of handle in struct policy_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1204642335.23738.96.camel@moss-spartans.epoch.ncsc.mil>
References: <200803041436.m24EaVpO007913@cadmus.columbia.tresys.com>
	 <1204642335.23738.96.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 12:38:15 -0500
Message-Id: <1204652295.18928.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-04 at 09:52 -0500, Stephen Smalley wrote:
> On Tue, 2008-03-04 at 09:36 -0500, Todd C. Miller wrote:
> > Joshua Brindle wrote:
> > > I prefer it to memset or set the values to null explicitly, the
> > > caller can then set the members it wants to.
> > 
> > How about this then?
> > 
> > Signed-off-by: Todd C. Miller <tmiller@tresys.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> Merge at will.

Likely should be applied on stable too.

> > 
> >  checkpolicy/checkmodule.c                  |    2 ++
> >  checkpolicy/checkpolicy.c                  |    2 ++
> >  checkpolicy/test/dismod.c                  |    1 +
> >  checkpolicy/test/dispol.c                  |    1 +
> >  libsepol/include/sepol/policydb/policydb.h |    2 ++
> >  libsepol/src/genbools.c                    |    2 ++
> >  libsepol/src/module.c                      |    3 +--
> >  libsepol/src/policydb.c                    |    5 +++++
> >  libsepol/src/policydb_convert.c            |    4 ++--
> >  libsepol/src/services.c                    |   15 +++++++++------
> >  10 files changed, 27 insertions(+), 10 deletions(-)
> > 
> > Index: trunk/libsepol/include/sepol/policydb/policydb.h
> > ===================================================================
> > --- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 2828)
> > +++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
> > @@ -568,6 +568,8 @@
> >  	struct policy_file pf;
> >  };
> >  
> > +extern void policy_file_init(policy_file_t * x);
> > +
> >  extern int policydb_read(policydb_t * p, struct policy_file *fp,
> >  			 unsigned int verbose);
> >  extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
> > Index: trunk/libsepol/src/policydb.c
> > ===================================================================
> > --- trunk/libsepol/src/policydb.c	(revision 2828)
> > +++ trunk/libsepol/src/policydb.c	(working copy)
> > @@ -3290,3 +3290,8 @@
> >  
> >  	return 0;
> >  }
> > +
> > +void policy_file_init(policy_file_t *pf)
> > +{
> > +	memset(pf, 0, sizeof(policy_file_t));
> > +}
> > Index: trunk/libsepol/src/services.c
> > ===================================================================
> > --- trunk/libsepol/src/services.c	(revision 2828)
> > +++ trunk/libsepol/src/services.c	(working copy)
> > @@ -85,6 +85,8 @@
> >  int sepol_set_policydb_from_file(FILE * fp)
> >  {
> >  	struct policy_file pf;
> > +
> > +	policy_file_init(&pf);
> >  	pf.fp = fp;
> >  	pf.type = PF_USE_STDIO;
> >  	if (mypolicydb.policy_type)
> > @@ -1003,13 +1005,14 @@
> >  	convert_context_args_t args;
> >  	uint32_t seqno;
> >  	int rc = 0;
> > -	struct policy_file file = {
> > -		.type = PF_USE_MEMORY,
> > -		.data = data,
> > -		.len = len,
> > -		.fp = NULL
> > -	}, *fp = &file;
> > +	struct policy_file file, *fp;
> >  
> > +	policy_file_init(&file);
> > +	file.type = PF_USE_MEMORY;
> > +	file.data = data;
> > +	file.len = len;
> > +	fp = &file;
> > +
> >  	if (policydb_init(&newpolicydb))
> >  		return -ENOMEM;
> >  
> > Index: trunk/libsepol/src/policydb_convert.c
> > ===================================================================
> > --- trunk/libsepol/src/policydb_convert.c	(revision 2828)
> > +++ trunk/libsepol/src/policydb_convert.c	(working copy)
> > @@ -13,6 +13,7 @@
> >  
> >  	policy_file_t pf;
> >  
> > +	policy_file_init(&pf);
> >  	pf.type = PF_USE_MEMORY;
> >  	pf.data = data;
> >  	pf.len = len;
> > @@ -39,9 +40,8 @@
> >  	struct policydb tmp_policydb;
> >  
> >  	/* Compute the length for the new policy image. */
> > +	policy_file_init(&pf);
> >  	pf.type = PF_LEN;
> > -	pf.data = NULL;
> > -	pf.len = 0;
> >  	pf.handle = handle;
> >  	if (policydb_write(policydb, &pf)) {
> >  		ERR(handle, "could not compute policy length");
> > Index: trunk/libsepol/src/genbools.c
> > ===================================================================
> > --- trunk/libsepol/src/genbools.c	(revision 2828)
> > +++ trunk/libsepol/src/genbools.c	(working copy)
> > @@ -154,6 +154,7 @@
> >  		goto err_destroy;
> >  	}
> >  
> > +	policy_file_init(&pf);
> >  	pf.type = PF_USE_MEMORY;
> >  	pf.data = data;
> >  	pf.len = len;
> > @@ -225,6 +226,7 @@
> >  		goto err_destroy;
> >  	}
> >  
> > +	policy_file_init(&pf);
> >  	pf.type = PF_USE_MEMORY;
> >  	pf.data = data;
> >  	pf.len = len;
> > Index: trunk/libsepol/src/module.c
> > ===================================================================
> > --- trunk/libsepol/src/module.c	(revision 2828)
> > +++ trunk/libsepol/src/module.c	(working copy)
> > @@ -851,9 +851,8 @@
> >  
> >  	if (p->policy) {
> >  		/* compute policy length */
> > +		policy_file_init(&polfile);
> >  		polfile.type = PF_LEN;
> > -		polfile.data = NULL;
> > -		polfile.len = 0;
> >  		polfile.handle = file->handle;
> >  		if (policydb_write(&p->policy->p, &polfile))
> >  			return -1;
> > Index: trunk/checkpolicy/test/dismod.c
> > ===================================================================
> > --- trunk/checkpolicy/test/dismod.c	(revision 2828)
> > +++ trunk/checkpolicy/test/dismod.c	(working copy)
> > @@ -689,6 +689,7 @@
> >  			filename, strerror(errno));
> >  		exit(1);
> >  	}
> > +	policy_file_init(&f);
> >  	f.type = PF_USE_STDIO;
> >  	f.fp = in_fp;
> >  
> > Index: trunk/checkpolicy/test/dispol.c
> > ===================================================================
> > --- trunk/checkpolicy/test/dispol.c	(revision 2828)
> > +++ trunk/checkpolicy/test/dispol.c	(working copy)
> > @@ -373,6 +373,7 @@
> >  
> >  	/* read the binary policy */
> >  	fprintf(out_fp, "Reading policy...\n");
> > +	policy_file_init(&pf);
> >  	pf.type = PF_USE_MEMORY;
> >  	pf.data = map;
> >  	pf.len = sb.st_size;
> > Index: trunk/checkpolicy/checkmodule.c
> > ===================================================================
> > --- trunk/checkpolicy/checkmodule.c	(revision 2829)
> > +++ trunk/checkpolicy/checkmodule.c	(working copy)
> > @@ -71,6 +71,7 @@
> >  		fprintf(stderr, "Can't map '%s':  %s\n", file, strerror(errno));
> >  		return -1;
> >  	}
> > +	policy_file_init(&f);
> >  	f.type = PF_USE_MEMORY;
> >  	f.data = map;
> >  	f.len = sb.st_size;
> > @@ -124,6 +125,7 @@
> >  	p->policyvers = policyvers;
> >  	p->handle_unknown = handle_unknown;
> >  
> > +	policy_file_init(&pf);
> >  	pf.type = PF_USE_STDIO;
> >  	pf.fp = outfp;
> >  	ret = policydb_write(p, &pf);
> > Index: trunk/checkpolicy/checkpolicy.c
> > ===================================================================
> > --- trunk/checkpolicy/checkpolicy.c	(revision 2829)
> > +++ trunk/checkpolicy/checkpolicy.c	(working copy)
> > @@ -489,6 +489,7 @@
> >  				file, strerror(errno));
> >  			exit(1);
> >  		}
> > +		policy_file_init(&pf);
> >  		pf.type = PF_USE_MEMORY;
> >  		pf.data = map;
> >  		pf.len = sb.st_size;
> > @@ -577,6 +578,7 @@
> >  		policydb.policy_type = POLICY_KERN;
> >  		policydb.policyvers = policyvers;
> >  
> > +		policy_file_init(&pf);
> >  		pf.type = PF_USE_STDIO;
> >  		pf.fp = outfp;
> >  		ret = policydb_write(&policydb, &pf);
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
