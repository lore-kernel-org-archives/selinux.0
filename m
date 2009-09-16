Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
From: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4AB0EF22.8070003@manicmethod.com>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AB0EF22.8070003@manicmethod.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 13:44:58 -0400
Message-Id: <1253123098.4348.221.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
> 
> pjnuzzi wrote:
> 
> <snip>
> > Signed-off-by: Paul Nuzzi<pjnuzzi@tycho.ncsc.mil>
> >
> > ---
> >   libsepol/include/sepol/policydb/policydb.h |   28 +++-
> >   libsepol/src/expand.c                      |   85 +++++++++++-
> >   libsepol/src/policydb.c                    |  197
> > ++++++++++++++++++++++++-----
> >   libsepol/src/policydb_internal.h           |    1
> >   libsepol/src/write.c                       |   90 ++++++++++++-
> >   5 files changed, 359 insertions(+), 42 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> > index 0105cf4..2013238 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -276,6 +276,16 @@ typedef struct ocontext {
> >   			uint32_t addr[4]; /* network order */
> >   			uint32_t mask[4]; /* network order */
> >   		} node6;	/* IPv6 node information */
> > +		uint32_t device;
> > +		uint16_t pirq;
> > +		struct {
> > +			uint32_t low_iomem;
> > +			uint32_t high_iomem;
> > +		} iomem;
> > +		struct {
> > +			uint32_t low_ioport;
> > +			uint32_t high_ioport;
> > +		} ioport;
> >    
> 
> I'd rather have separate ocontext structs for each system. That way it 
> is very easy to understand which ones apply to which system and you 
> don't get a crazy out of context ocontext struct.
> 

In the beginning I tried implementing a separate ocontext struct for
each system but I was having issues.  If we have a separate struct for
each platform a lot more code is going to have to be patched to decouple
SELinux from being the default ocontext target.  Just a quick search
with cscope shows there is 96 references to ocontext_t.  It might be
easier to have one big (and confusing) ocontext structure at the expense
of refactoring a lot of code.  

A good compromise might be to have an ocontext structure that nests Xen,
SELinux, Solaris, etc. structures to make it easier to see which ones
apply to the platform.  For example..

struct ocontext {
	struct xen_ocontexts {
		uint32_t device;
			struct {
				uint32_t low_iomem;
				uint32_t high_iomem;
			} iomem;
	} xen;
	struct selinux_ocontexts {
		uint32_t addr[4]; /* network order */
	} selinux;	
}

Let me know what would be better.


> >   	} u;
> >   	union {
> >   		uint32_t sclass;	/* security class for genfs */
> > @@ -313,6 +323,17 @@ typedef struct genfs {
> >   #define OCON_NODE6 6		/* IPv6 nodes */
> >   #define OCON_NUM   7
> >
> > +/* object context array indices for Xen */
> > +#define OCON_ISID    0    /* initial SIDs */
> > +#define OCON_PIRQ    1    /* physical irqs */
> > +#define OCON_IOPORT  2    /* io ports */
> > +#define OCON_IOMEM   3    /* io memory */
> > +#define OCON_DEVICE  4    /* pci devices */
> > +#define OCON_DUMMY1  5    /* reserved */
> > +#define OCON_DUMMY2  6    /* reserved */
> > +#define OCON_NUM     7
> > +
> > +
> >    
> 
> Should these be namespaced? What if <random other system> has io port 
> objects? You'd have to align them with each other and you have a mess of 
> keeping the numbers the same (you already do this with OCON_ISID)
> 
> Also we are relying on having the same number of OCON's which isn't good 
> I don't think. As much as I hate the policydb_compat_info (read: alot) 
> why aren't we using that to say how many ocons a xen policy really has?
> 

These should probably be namespaced then.  I will check into
policydb_compat_info.  

> >   /* section: module information */
> >
> >   /* scope_index_t holds all of the symbols that are in scope in a
> > @@ -400,6 +421,7 @@ typedef struct policydb {
> >   	uint32_t policy_type;
> >   	char *name;
> >   	char *version;
> > +	uint32_t target_type;
> >
> >    
> 
> Really bad variable name. how about target_platform or something?

Sounds good. Easy fix.

> 
> >   	/* Set when the policydb is modified such that writing is unsupported */
> >   	int unsupported_format;
> > @@ -593,6 +615,7 @@ extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
> >   			    struct policy_file *fp);
> >
> >   extern int policydb_write(struct policydb *p, struct policy_file *pf);
> > +extern int policydb_set_target_platform(policydb_t *p, int platform);
> >
> >   #define PERM_SYMTAB_SIZE 32
> >
> > @@ -651,9 +674,12 @@ extern int policydb_write(struct policydb *p, struct policy_file *pf);
> >
> >   #define POLICYDB_MAGIC SELINUX_MAGIC
> >   #define POLICYDB_STRING "SE Linux"
> > -#define POLICYDB_ALT_STRING "Flask"
> > +#define POLICYDB_XEN_STRING "XenFlask"
> >   #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
> >   #define POLICYDB_MOD_STRING "SE Linux Module"
> > +#define SEPOL_TARGET_SELINUX 0
> > +#define SEPOL_TARGET_XEN     1
> > +
> >
> >   #endif				/* _POLICYDB_H_ */
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index e9cd986..38e2481 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1819,9 +1819,9 @@ static int context_copy(context_struct_t * dst, context_struct_t * src,
> >   	return mls_context_cpy(dst, src);
> >   }
> >
> > -static int ocontext_copy(expand_state_t * state)
> > +static int ocontext_copy_xen(expand_state_t *state)
> >   {
> > -	unsigned int i, j;
> > +	unsigned int i;
> >   	ocontext_t *c, *n, *l;
> >
> >   	for (i = 0; i<  OCON_NUM; i++) {
> > @@ -1833,11 +1833,63 @@ static int ocontext_copy(expand_state_t * state)
> >   				return -1;
> >   			}
> >   			memset(n, 0, sizeof(ocontext_t));
> > -			if (l) {
> > +			if (l)
> >   				l->next = n;
> > -			} else {
> > +			else
> >    
> 
> whitespace changes.

It looks like whitespace changes but this is where ocontext_read is
expanded to ocontext_read_xen.  ocontext_read becomes a switch statement
on target_platform.  Checkpatch was giving errors about the style which
is why the brackets were deleted.  

> 
> >   				state->out->ocontexts[i] = n;
> > +			l = n;
> > +			if (context_copy(&n->context[0],&c->context[0],
> > +				state)) {
> > +				ERR(state->handle, "Out of memory!");
> > +				return -1;
> > +			}
> > +			switch (i) {
> > +			case OCON_ISID:
> > +				n->sid[0] = c->sid[0];
> > +				break;
> > +			case OCON_PIRQ:
> > +				n->u.pirq = c->u.pirq;
> > +				break;
> > +			case OCON_IOPORT:
> > +				n->u.ioport.low_ioport = c->u.ioport.low_ioport;
> > +				n->u.ioport.high_ioport =
> > +					c->u.ioport.high_ioport;
> > +				break;
> > +			case OCON_IOMEM:
> > +				n->u.iomem.low_iomem  = c->u.iomem.low_iomem;
> > +				n->u.iomem.high_iomem = c->u.iomem.high_iomem;
> > +				break;
> > +			case OCON_DEVICE:
> > +				n->u.device = c->u.device;
> > +				break;
> > +			default:
> > +				/* shouldn't get here */
> > +				ERR(state->handle, "Unknown ocontext");
> > +				return -1;
> >    
> 
> How do you not get here if you are going through to OCON_NUM which 
> includes OCON_DUMMY{1,2} ?
> 

The ocontext is not copied because there are no rules attached to the
OCON_DUMMY{1,2} linked list. The default case should never be reached.

> > +			}
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int ocontext_copy_selinux(expand_state_t *state)
> > +{
> > +	unsigned int i, j;
> > +	ocontext_t *c, *n, *l;
> > +
> > +	for (i = 0; i<  OCON_NUM; i++) {
> > +		l = NULL;
> > +		for (c = state->base->ocontexts[i]; c; c = c->next) {
> > +			n = malloc(sizeof(ocontext_t));
> > +			if (!n) {
> > +				ERR(state->handle, "Out of memory!");
> > +				return -1;
> >   			}
> > +			memset(n, 0, sizeof(ocontext_t));
> > +			if (l)
> > +				l->next = n;
> > +			else
> > +				state->out->ocontexts[i] = n;
> >   			l = n;
> >   			if (context_copy(&n->context[0],&c->context[0], state)) {
> >   				ERR(state->handle, "Out of memory!");
> > @@ -1885,13 +1937,31 @@ static int ocontext_copy(expand_state_t * state)
> >   				break;
> >   			default:
> >   				/* shouldn't get here */
> > -				assert(0);
> > +				ERR(state->handle, "Unknown ocontext");
> > +				return -1;
> >   			}
> >   		}
> >   	}
> >   	return 0;
> >   }
> >
> > +static int ocontext_copy(expand_state_t *state, uint32_t target)
> > +{
> > +	int rc = -1;
> > +	switch (target) {
> > +	case SEPOL_TARGET_SELINUX:
> > +		rc = ocontext_copy_selinux(state);
> > +		break;
> > +	case SEPOL_TARGET_XEN:
> > +		rc = ocontext_copy_xen(state);
> > +		break;
> > +	default:
> > +		ERR(state->handle, "Unknown target");
> > +		return -1;
> > +	}
> > +	return rc;
> > +}
> > +
> >   static int genfs_copy(expand_state_t * state)
> >   {
> >   	ocontext_t *c, *newc, *l;
> > @@ -2418,6 +2488,9 @@ int expand_module(sepol_handle_t * handle,
> >   	out->mls = base->mls;
> >   	out->handle_unknown = base->handle_unknown;
> >
> > +	/* Copy target from base to out */
> > +	out->target_type = base->target_type;
> > +
> >   	/* Copy policy capabilities */
> >   	if (ebitmap_cpy(&out->policycaps,&base->policycaps)) {
> >   		ERR(handle, "Out of memory!");
> > @@ -2576,7 +2649,7 @@ int expand_module(sepol_handle_t * handle,
> >   	evaluate_conds(state.out);
> >
> >   	/* copy ocontexts */
> > -	if (ocontext_copy(&state))
> > +	if (ocontext_copy(&state, out->target_type))
> >   		goto cleanup;
> >
> >   	/* copy genfs */
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 85ddefc..3d9bfe0 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -54,6 +54,9 @@
> >   #include "debug.h"
> >   #include "mls.h"
> >
> > +#define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
> > +char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
> > +
> >   /* These need to be updated if SYM_NUM or OCON_NUM changes */
> >   static struct policydb_compat_info policydb_compat[] = {
> >   	{
> > @@ -1079,9 +1082,13 @@ void policydb_destroy(policydb_t * p)
> >   			c = c->next;
> >   			context_destroy(&ctmp->context[0]);
> >   			context_destroy(&ctmp->context[1]);
> > -			if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF
> > -			    || i == OCON_FSUSE)
> > +			if (i == OCON_ISID)
> > +				free(ctmp->u.name);
> > +			if (p->target_type == SEPOL_TARGET_SELINUX&&
> > +				(i == OCON_FS || i == OCON_NETIF ||
> > +				i == OCON_FSUSE))
> >   				free(ctmp->u.name);
> >    
> 
> This is messy, why not an ocontext_selinux_free() and 
> ocontext_xen_free() (note: I realize the xen_free() one won't do 
> anything except freep the ocontext_t)

Sounds good.  

> > +
> >   			free(ctmp);
> >   		}
> >   	}
> > @@ -2102,7 +2109,88 @@ int role_allow_read(role_allow_t ** r, struct policy_file *fp)
> >   	return 0;
> >   }
> >
> > -static int ocontext_read(struct policydb_compat_info *info,
> > +static int ocontext_read_xen(struct policydb_compat_info *info,
> > +	policydb_t *p, struct policy_file *fp)
> > +{
> > +	unsigned int i, j;
> > +	size_t nel;
> > +	ocontext_t *l, *c;
> > +	uint32_t buf[8];
> > +	int rc;
> > +
> > +	for (i = 0; i<  info->ocon_num; i++) {
> > +		rc = next_entry(buf, fp, sizeof(uint32_t));
> > +		if (rc<  0)
> > +			return -1;
> > +		nel = le32_to_cpu(buf[0]);
> > +		l = NULL;
> > +		for (j = 0; j<  nel; j++) {
> > +			c = calloc(1, sizeof(ocontext_t));
> > +			if (!c)
> > +				return -1;
> > +			if (l)
> > +				l->next = c;
> > +			else
> > +				p->ocontexts[i] = c;
> > +			l = c;
> > +			switch (i) {
> > +			case OCON_ISID:
> > +				rc = next_entry(buf, fp, sizeof(uint32_t));
> > +				if (rc<  0)
> > +					return -1;
> > +				c->sid[0] = le32_to_cpu(buf[0]);
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> > +			case OCON_PIRQ:
> > +				rc = next_entry(buf, fp, sizeof(uint32_t));
> > +				if (rc<  0)
> > +					return -1;
> > +				c->u.pirq = le32_to_cpu(buf[0]);
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> > +			case OCON_IOPORT:
> > +				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> > +				if (rc<  0)
> > +					return -1;
> > +				c->u.ioport.low_ioport = le32_to_cpu(buf[0]);
> > +				c->u.ioport.high_ioport = le32_to_cpu(buf[1]);
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> > +			case OCON_IOMEM:
> > +				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> > +				if (rc<  0)
> > +					return -1;
> > +				c->u.iomem.low_iomem = le32_to_cpu(buf[0]);
> > +				c->u.iomem.high_iomem = le32_to_cpu(buf[1]);
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> > +			case OCON_DEVICE:
> > +				rc = next_entry(buf, fp, sizeof(uint32_t));
> > +				if (rc<  0)
> > +					return -1;
> > +				c->u.device = le32_to_cpu(buf[0]);
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> > +			default:
> > +				/* should never get here */
> > +				ERR(fp->handle, "Unknown Xen ocontext");
> > +				return -1;
> >    
> 
> Same as above with OCON_DUMMY{1,2}

This check is correct.  It will only error if there is an OCON_DUMMY being read 
from the policy.  

> > +			}
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +static int ocontext_read_selinux(struct policydb_compat_info *info,
> >   			 policydb_t * p, struct policy_file *fp)
> >   {
> >   	unsigned int i, j;
> > @@ -2197,23 +2285,25 @@ static int ocontext_read(struct policydb_compat_info *info,
> >   					return -1;
> >   				break;
> >   			case OCON_NODE6:{
> > -					int k;
> > -
> > -					rc = next_entry(buf, fp,
> > -							sizeof(uint32_t) * 8);
> > -					if (rc<  0)
> > -						return -1;
> > -					for (k = 0; k<  4; k++)
> > -						c->u.node6.addr[k] = buf[k]; /* network order */
> > -					for (k = 0; k<  4; k++)
> > -						c->u.node6.mask[k] = buf[k + 4]; /* network order */
> > -					if (context_read_and_validate
> > -					    (&c->context[0], p, fp))
> > -						return -1;
> > -					break;
> > +				int k;
> > +
> > +				rc = next_entry(buf, fp, sizeof(uint32_t) * 8);
> > +				if (rc<  0)
> > +					return -1;
> > +				for (k = 0; k<  4; k++)
> > +					 /* network order */
> > +					c->u.node6.addr[k] = buf[k];
> > +				for (k = 0; k<  4; k++)
> > +					/* network order */
> > +					c->u.node6.mask[k] = buf[k + 4];
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> >    
> 
> Was this only a whitespace change?

The above is whitespace change.  The addition of ERR and return below is
where the change is.  Checkpatch was giving errors on indentation.  

> 
> >   				}
> >   			default:{
> > -					assert(0);	/* should never get here */
> > +				ERR(fp->handle, "Unknown SELinux ocontext");
> > +				return -1;
> >   				}
> >   			}
> >   		}
> > @@ -2221,6 +2311,23 @@ static int ocontext_read(struct policydb_compat_info *info,
> >   	return 0;
> >   }
> >
> > +static int ocontext_read(struct policydb_compat_info *info,
> > +	policydb_t *p, struct policy_file *fp)
> > +{
> > +	int rc = -1;
> > +	switch (p->target_type) {
> > +	case SEPOL_TARGET_SELINUX:
> > +		rc = ocontext_read_selinux(info, p, fp);
> > +		break;
> > +	case SEPOL_TARGET_XEN:
> > +		rc = ocontext_read_xen(info, p, fp);
> > +		break;
> > +	default:
> > +		ERR(fp->handle, "Unknown target");
> > +	}
> > +	return rc;
> > +}
> > +
> >   static int genfs_read(policydb_t * p, struct policy_file *fp)
> >   {
> >   	uint32_t buf[1];
> > @@ -3070,7 +3177,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
> >   	unsigned int i, j, r_policyvers;
> >   	uint32_t buf[5], config;
> >   	size_t len, nprim, nel;
> > -	char *policydb_str, *target_str = NULL, *alt_target_str = NULL;
> > +	char *policydb_str;
> >   	struct policydb_compat_info *info;
> >   	unsigned int policy_type, bufindex;
> >   	ebitmap_node_t *tnode;
> > @@ -3087,11 +3194,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
> >
> >   	if (buf[0] == POLICYDB_MAGIC) {
> >   		policy_type = POLICY_KERN;
> > -		target_str = POLICYDB_STRING;
> > -		alt_target_str = POLICYDB_ALT_STRING;
> >   	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
> >   		policy_type = POLICY_MOD;
> > -		target_str = POLICYDB_MOD_STRING;
> >   	} else {
> >   		ERR(fp->handle, "policydb magic number %#08x does not "
> >   		    "match expected magic number %#08x or %#08x",
> > @@ -3100,10 +3204,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
> >   	}
> >
> >   	len = buf[1];
> > -	if (len != strlen(target_str)&&
> > -	    (!alt_target_str || len != strlen(alt_target_str))) {
> > -		ERR(fp->handle, "policydb string length %zu does not match "
> > -		    "expected length %zu", len, strlen(target_str));
> > +	if (len>  32) {
> >    
> 
> magic number 32?
> 

Will change to #define

> > +		ERR(fp->handle, "policydb string length too long ");
> >   		return POLICYDB_ERROR;
> >   	}
> >
> > @@ -3120,13 +3222,31 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
> >   		return POLICYDB_ERROR;
> >   	}
> >   	policydb_str[len] = 0;
> > -	if (strcmp(policydb_str, target_str)&&
> > -	    (!alt_target_str || strcmp(policydb_str, alt_target_str))) {
> > -		ERR(fp->handle, "policydb string %s does not match "
> > -		    "my string %s", policydb_str, target_str);
> > -		free(policydb_str);
> > -		return POLICYDB_ERROR;
> > +
> > +	if (policy_type == POLICY_KERN) {
> > +		for (i = 0; i<  POLICYDB_TARGET_SZ; i++) {
> > +			if ((strcmp(policydb_str, policydb_target_strings[i])
> > +				== 0)) {
> > +				policydb_set_target_platform(p, i);
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (i == POLICYDB_TARGET_SZ) {
> >    
> 
> That is a strange way to check if it was invalid but I suppose it works..
> 
> > +			ERR(fp->handle, "cannot find a valid target for policy "
> > +				"string %s", policydb_str);
> > +			free(policydb_str);
> > +			return POLICYDB_ERROR;
> > +		}
> > +	} else {
> > +		if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
> > +			ERR(fp->handle, "invalid string identifier %s",
> > +				policydb_str);
> > +			free(policydb_str);
> > +			return POLICYDB_ERROR;
> > +		}
> >   	}
> > +
> >   	/* Done with policydb_str. */
> >   	free(policydb_str);
> >   	policydb_str = NULL;
> > @@ -3391,3 +3511,16 @@ void policy_file_init(policy_file_t *pf)
> >   {
> >   	memset(pf, 0, sizeof(policy_file_t));
> >   }
> > +
> > +int policydb_set_target_platform(policydb_t *p, int platform)
> > +{
> > +	if (platform == SEPOL_TARGET_SELINUX)
> > +		p->target_type = SEPOL_TARGET_SELINUX;
> > +	else if (platform == SEPOL_TARGET_XEN)
> > +		p->target_type = SEPOL_TARGET_XEN;
> > +	else
> > +		return -1;
> >    
> 
> > +
> > +	return 0;
> > +}
> > +
> > diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_internal.h
> > index 1eb99e5..8a31506 100644
> > --- a/libsepol/src/policydb_internal.h
> > +++ b/libsepol/src/policydb_internal.h
> > @@ -6,4 +6,5 @@
> >
> >   hidden_proto(sepol_policydb_create)
> >       hidden_proto(sepol_policydb_free)
> > +extern char *policydb_target_strings[];
> >   #endif
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 66b35ec..a557c2e 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1084,10 +1084,79 @@ static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
> >   common_write, class_write, role_write, type_write, user_write,
> >   	    cond_write_bool, sens_write, cat_write,};
> >
> > -static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
> > +static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
> >   			  struct policy_file *fp)
> >   {
> >   	unsigned int i, j;
> > +	size_t nel, items;
> > +	uint32_t buf[32];
> > +	ocontext_t *c;
> > +	for (i = 0; i<  info->ocon_num; i++) {
> > +		nel = 0;
> > +		for (c = p->ocontexts[i]; c; c = c->next)
> > +			nel++;
> > +		buf[0] = cpu_to_le32(nel);
> > +		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +		if (items != 1)
> > +			return POLICYDB_ERROR;
> > +		for (c = p->ocontexts[i]; c; c = c->next) {
> > +			switch (i) {
> > +			case OCON_ISID:
> > +				buf[0] = cpu_to_le32(c->sid[0]);
> > +				items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +				if (items != 1)
> > +					return POLICYDB_ERROR;
> > +				if (context_write(p,&c->context[0], fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> > +			case OCON_PIRQ:
> > +				buf[0] = cpu_to_le32(c->u.pirq);
> > +				items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +				if (items != 1)
> > +					return POLICYDB_ERROR;
> > +				if (context_write(p,&c->context[0], fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> > +			case OCON_IOPORT:
> > +				buf[0] = c->u.ioport.low_ioport;
> > +				buf[1] = c->u.ioport.high_ioport;
> > +				for (j = 0; j<  2; j++)
> > +					buf[j] = cpu_to_le32(buf[j]);
> > +				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> > +				if (items != 2)
> > +					return POLICYDB_ERROR;
> > +				if (context_write(p,&c->context[0], fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> > +			case OCON_IOMEM:
> > +				buf[0] = c->u.iomem.low_iomem;
> > +				buf[1] = c->u.iomem.high_iomem;
> > +				for (j = 0; j<  2; j++)
> > +					buf[j] = cpu_to_le32(buf[j]);
> > +				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> > +				if (items != 2)
> > +					return POLICYDB_ERROR;
> > +				if (context_write(p,&c->context[0], fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> > +			case OCON_DEVICE:
> > +				buf[0] = cpu_to_le32(c->u.device);
> > +				items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +				if (items != 1)
> > +					return POLICYDB_ERROR;
> > +				if (context_write(p,&c->context[0], fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +	return POLICYDB_SUCCESS;
> > +}
> > +
> > +static int ocontext_write_selinux(struct policydb_compat_info *info,
> > +	policydb_t *p, struct policy_file *fp)
> > +{
> > +	unsigned int i, j;
> >   	size_t nel, items, len;
> >   	uint32_t buf[32];
> >   	ocontext_t *c;
> > @@ -1176,6 +1245,21 @@ static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
> >   	return POLICYDB_SUCCESS;
> >   }
> >
> > +static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
> > +	struct policy_file *fp)
> > +{
> > +	int rc = POLICYDB_ERROR;
> > +	switch (p->target_type) {
> > +	case SEPOL_TARGET_SELINUX:
> > +		rc = ocontext_write_selinux(info, p, fp);
> > +		break;
> > +	case SEPOL_TARGET_XEN:
> > +		rc = ocontext_write_xen(info, p, fp);
> > +		break;
> > +	}
> > +	return rc;
> > +}
> > +
> >   static int genfs_write(policydb_t * p, struct policy_file *fp)
> >   {
> >   	genfs_t *genfs;
> > @@ -1610,8 +1694,8 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
> >   	items = 0;
> >   	if (p->policy_type == POLICY_KERN) {
> >   		buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
> > -		len = strlen(POLICYDB_STRING);
> > -		policydb_str = POLICYDB_STRING;
> > +		len = strlen(policydb_target_strings[p->target_type]);
> > +		policydb_str = policydb_target_strings[p->target_type];
> >   	} else {
> >   		buf[items++] = cpu_to_le32(POLICYDB_MOD_MAGIC);
> >   		len = strlen(POLICYDB_MOD_STRING);
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> >    
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
