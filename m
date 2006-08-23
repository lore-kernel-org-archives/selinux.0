Subject: Re: [PATCH 1/2 v3] Conditionally expand neverallows
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Jeremy A. Mowery" <jmowery@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156343737.8506.33.camel@moss-spartans.epoch.ncsc.mil>
References: <1155825190.2921.112.camel@Bishop.columbia.tresys.com>
	 <1156343737.8506.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 10:48:36 -0400
Message-Id: <1156344516.32272.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 10:35 -0400, Stephen Smalley wrote:
> On Thu, 2006-08-17 at 10:33 -0400, Jeremy A. Mowery wrote:
> > This patch allows neverallow rules to be expanded into the avtab for
> > analysis purposes. This option is added to the expand state structure
> > (and set to off by default).  When neverallows are expanded, the
> > unsupported_format flag is set for the policydb disabling writing 
> > the binary file. If expanded, neverallow rules are not copied; this is
> > documented above the relevant functions. (Previous versions of this
> > patch set also disabled checking on unsupported formats; this behavior 
> > has been dropped in this version of the patch set.) The read and write
> > functions now recognize this state and appropriate defines were added
> > for the return values.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Ached-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

> > Jeremy A. Mowery
> > Tresys Technology
> > 410-290-1411 x148
> > 
> > Index: trunk/libsepol/include/sepol/policydb/avtab.h
> > ===================================================================
> > --- trunk/libsepol/include/sepol/policydb/avtab.h	(revision 1109)
> > +++ trunk/libsepol/include/sepol/policydb/avtab.h	(working copy)
> > @@ -45,6 +45,7 @@
> >  #define AVTAB_ALLOWED     1
> >  #define AVTAB_AUDITALLOW  2
> >  #define AVTAB_AUDITDENY   4
> > +#define AVTAB_NEVERALLOW 128
> >  #define AVTAB_AV         (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
> >  #define AVTAB_TRANSITION 16
> >  #define AVTAB_MEMBER     32
> > Index: trunk/libsepol/include/sepol/policydb/policydb.h
> > ===================================================================
> > --- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 1109)
> > +++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
> > @@ -65,6 +65,10 @@
> >  
> >  #define ERRMSG_LEN 1024
> >  
> > +#define POLICYDB_SUCCESS      0
> > +#define POLICYDB_ERROR       -1
> > +#define POLICYDB_UNSUPPORTED -2
> > +
> >  /*
> >   * A datum type is defined for each kind of symbol 
> >   * in the configuration data:  individual permissions, 
> > @@ -194,12 +198,12 @@
> >  #define AVRULE_AUDITALLOW  2
> >  #define AVRULE_AUDITDENY   4
> >  #define AVRULE_DONTAUDIT   8
> > -#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT)
> > +#define AVRULE_NEVERALLOW 128
> > +#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
> >  #define AVRULE_TRANSITION 16
> >  #define AVRULE_MEMBER     32
> >  #define AVRULE_CHANGE     64
> >  #define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
> > -#define AVRULE_NEVERALLOW 128
> >  	uint32_t specified;
> >  #define RULE_SELF 1
> >  	uint32_t flags;
> > @@ -371,6 +375,9 @@
> >  	char *name;
> >  	char *version;
> >  
> > +	/* Set when the policydb is modified such that writing is unsupported */
> > +	int unsupported_format;
> > +
> >  	/* Whether this policydb is mls, should always be set */
> >  	int mls;
> >  
> > Index: trunk/libsepol/src/policydb.c
> > ===================================================================
> > --- trunk/libsepol/src/policydb.c	(revision 1109)
> > +++ trunk/libsepol/src/policydb.c	(working copy)
> > @@ -2618,7 +2618,7 @@
> >  	/* Read the magic number and string length. */
> >  	buf = next_entry(fp, sizeof(uint32_t) * 2);
> >  	if (!buf)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (i = 0; i < 2; i++)
> >  		buf[i] = le32_to_cpu(buf[i]);
> >  
> > @@ -2632,26 +2632,26 @@
> >  		ERR(fp->handle, "policydb magic number %#08x does not "
> >  		    "match expected magic number %#08x or %#08x",
> >  		    buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  
> >  	len = buf[1];
> >  	if (len != strlen(target_str)) {
> >  		ERR(fp->handle, "policydb string length %zu does not match "
> >  		    "expected length %zu", len, strlen(target_str));
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  
> >  	buf = next_entry(fp, len);
> >  	if (!buf) {
> >  		ERR(fp->handle, "truncated policydb string identifier");
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	policydb_str = malloc(len + 1);
> >  	if (!policydb_str) {
> >  		ERR(fp->handle, "unable to allocate memory for policydb "
> >  		    "string of length %zu", len);
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	memcpy(policydb_str, buf, len);
> >  	policydb_str[len] = 0;
> > @@ -2659,7 +2659,7 @@
> >  		ERR(fp->handle, "policydb string %s does not match "
> >  		    "my string %s", policydb_str, target_str);
> >  		free(policydb_str);
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	/* Done with policydb_str. */
> >  	free(policydb_str);
> > @@ -2673,7 +2673,7 @@
> >  
> >  	buf = next_entry(fp, sizeof(uint32_t) * nel);
> >  	if (!buf)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (i = 0; i < nel; i++)
> >  		buf[i] = le32_to_cpu(buf[i]);
> >  
> > @@ -2687,7 +2687,7 @@
> >  		if (policy_type != POLICY_MOD && policy_type != POLICY_BASE) {
> >  			ERR(fp->handle, "unknown module type: %#08x",
> >  			    policy_type);
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  		bufindex++;
> >  	}
> > @@ -2699,7 +2699,7 @@
> >  			ERR(fp->handle, "policydb version %d does not match "
> >  			    "my version range %d-%d", buf[bufindex],
> >  			    POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	} else if (policy_type == POLICY_BASE || policy_type == POLICY_MOD) {
> >  		if (r_policyvers < MOD_POLICYDB_VERSION_MIN ||
> > @@ -2708,7 +2708,7 @@
> >  			    "not match my version range %d-%d",
> >  			    buf[bufindex], MOD_POLICYDB_VERSION_MIN,
> >  			    MOD_POLICYDB_VERSION_MAX);
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	} else {
> >  		assert(0);
> > @@ -2870,9 +2870,9 @@
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >        bad:
> > -	return -1;
> > +	return POLICYDB_ERROR;
> >  }
> >  
> >  int policydb_reindex_users(policydb_t * p)
> > Index: trunk/libsepol/src/expand.c
> > ===================================================================
> > --- trunk/libsepol/src/expand.c	(revision 1109)
> > +++ trunk/libsepol/src/expand.c	(working copy)
> > @@ -41,8 +41,14 @@
> >  	policydb_t *base;
> >  	policydb_t *out;
> >  	sepol_handle_t *handle;
> > +	int expand_neverallow;
> >  } expand_state_t;
> >  
> > +static void expand_state_init(expand_state_t * state)
> > +{
> > +	memset(state, 0, sizeof(expand_state_t));
> > +}
> > +
> >  static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> >  			      void *data)
> >  {
> > @@ -1007,6 +1013,10 @@
> >  	return node;
> >  }
> >  
> > +#define EXPAND_RULE_SUCCESS   1
> > +#define EXPAND_RULE_CONFLICT  0
> > +#define EXPAND_RULE_ERROR    -1
> > +
> >  static int expand_terule_helper(sepol_handle_t * handle,
> >  				policydb_t * p, uint32_t * typemap,
> >  				uint32_t specified, cond_av_list_t ** cond,
> > @@ -1069,7 +1079,7 @@
> >  				 * or in same conditional then ignore it */
> >  				if ((conflict == 1 && cond == NULL)
> >  				    || node->parse_context == cond)
> > -					return 1;
> > +					return EXPAND_RULE_SUCCESS;
> >  				ERR(handle, "duplicate TE rule for %s %s:%s %s",
> >  				    p->p_type_val_to_name[avkey.source_type -
> >  							  1],
> > @@ -1078,7 +1088,7 @@
> >  				    p->p_class_val_to_name[avkey.target_class -
> >  							   1],
> >  				    p->p_type_val_to_name[oldtype - 1]);
> > -				return 0;
> > +				return EXPAND_RULE_CONFLICT;
> >  			}
> >  			ERR(handle,
> >  			    "conflicting TE rule for (%s, %s:%s):  old was %s, new is %s",
> > @@ -1087,7 +1097,7 @@
> >  			    p->p_class_val_to_name[avkey.target_class - 1],
> >  			    p->p_type_val_to_name[oldtype - 1],
> >  			    p->p_type_val_to_name[remapped_data - 1]);
> > -			return 0;
> > +			return EXPAND_RULE_CONFLICT;
> >  		}
> >  
> >  		node = find_avtab_node(handle, avtab, &avkey, cond);
> > @@ -1113,7 +1123,7 @@
> >  		cur = cur->next;
> >  	}
> >  
> > -	return 1;
> > +	return EXPAND_RULE_SUCCESS;
> >  }
> >  
> >  static int expand_avrule_helper(sepol_handle_t * handle,
> > @@ -1137,6 +1147,8 @@
> >  		spec = AVTAB_AUDITDENY;
> >  	} else if (specified & AVRULE_DONTAUDIT) {
> >  		spec = AVTAB_AUDITDENY;
> > +	} else if (specified & AVRULE_NEVERALLOW) {
> > +		spec = AVTAB_NEVERALLOW;
> >  	} else {
> >  		assert(0);	/* unreachable */
> >  	}
> > @@ -1150,7 +1162,7 @@
> >  
> >  		node = find_avtab_node(handle, avtab, &avkey, cond);
> >  		if (!node)
> > -			return -1;
> > +			return EXPAND_RULE_ERROR;
> >  		if (enabled) {
> >  			node->key.specified |= AVTAB_ENABLED;
> >  		} else {
> > @@ -1162,6 +1174,8 @@
> >  			avdatump->data |= cur->data;
> >  		} else if (specified & AVRULE_AUDITALLOW) {
> >  			avdatump->data |= cur->data;
> > +		} else if (specified & AVRULE_NEVERALLOW) {
> > +			avdatump->data |= cur->data;
> >  		} else if (specified & AVRULE_AUDITDENY) {
> >  			/* Since a '0' in an auditdeny mask represents
> >  			 * a permission we do NOT want to audit
> > @@ -1182,7 +1196,7 @@
> >  
> >  		cur = cur->next;
> >  	}
> > -	return 1;
> > +	return EXPAND_RULE_SUCCESS;
> >  }
> >  
> >  static int expand_rule_helper(sepol_handle_t * handle,
> > @@ -1207,7 +1221,8 @@
> >  							  specified, cond, i, i,
> >  							  source_rule->perms,
> >  							  dest_avtab,
> > -							  enabled)) != 1) {
> > +							  enabled)) !=
> > +				    EXPAND_RULE_SUCCESS) {
> >  					return retval;
> >  				}
> >  			} else {
> > @@ -1219,7 +1234,8 @@
> >  							  other, i, i,
> >  							  source_rule->perms,
> >  							  dest_avtab,
> > -							  enabled)) != 1) {
> > +							  enabled)) !=
> > +				    EXPAND_RULE_SUCCESS) {
> >  					return retval;
> >  				}
> >  			}
> > @@ -1234,7 +1250,8 @@
> >  							  specified, cond, i, j,
> >  							  source_rule->perms,
> >  							  dest_avtab,
> > -							  enabled)) != 1) {
> > +							  enabled)) !=
> > +				    EXPAND_RULE_SUCCESS) {
> >  					return retval;
> >  				}
> >  			} else {
> > @@ -1246,32 +1263,36 @@
> >  							  other, i, j,
> >  							  source_rule->perms,
> >  							  dest_avtab,
> > -							  enabled)) != 1) {
> > +							  enabled)) !=
> > +				    EXPAND_RULE_SUCCESS) {
> >  					return retval;
> >  				}
> >  			}
> >  		}
> >  	}
> >  
> > -	return 1;
> > +	return EXPAND_RULE_SUCCESS;
> >  }
> >  
> > -/* Expand a rule into a given avtab - checking for conflicting type
> > - * rules in the destination policy.  Return 1 on success, 0 if the
> > - * rule conflicts with something (and hence was not added), or -1 on
> > - * error. */
> > +/*
> > + * Expand a rule into a given avtab - checking for conflicting type
> > + * rules in the destination policy.  Return EXPAND_RULE_SUCCESS on 
> > + * success, EXPAND_RULE_CONFLICT if the rule conflicts with something
> > + * (and hence was not added), or EXPAND_RULE_ERROR on error.
> > + */
> >  static int convert_and_expand_rule(sepol_handle_t * handle,
> >  				   policydb_t * dest_pol, uint32_t * typemap,
> >  				   avrule_t * source_rule, avtab_t * dest_avtab,
> >  				   cond_av_list_t ** cond,
> > -				   cond_av_list_t ** other, int enabled)
> > +				   cond_av_list_t ** other, int enabled,
> > +				   int do_neverallow)
> >  {
> >  	int retval;
> >  	ebitmap_t stypes, ttypes;
> >  	unsigned char alwaysexpand;
> >  
> > -	if (source_rule->specified & AVRULE_NEVERALLOW)
> > -		return 1;
> > +	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
> > +		return EXPAND_RULE_SUCCESS;
> >  
> >  	ebitmap_init(&stypes);
> >  	ebitmap_init(&ttypes);
> > @@ -1282,10 +1303,10 @@
> >  
> >  	if (expand_convert_type_set
> >  	    (dest_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
> > -		return -1;
> > +		return EXPAND_RULE_ERROR;
> >  	if (expand_convert_type_set
> >  	    (dest_pol, typemap, &source_rule->ttypes, &ttypes, alwaysexpand))
> > -		return -1;
> > +		return EXPAND_RULE_ERROR;
> >  
> >  	retval = expand_rule_helper(handle, dest_pol, typemap,
> >  				    source_rule, dest_avtab,
> > @@ -1306,7 +1327,8 @@
> >  	while (cur) {
> >  		if (convert_and_expand_rule(state->handle, dest_pol,
> >  					    typemap, cur, dest_avtab,
> > -					    list, other, enabled) != 1) {
> > +					    list, other, enabled,
> > +					    0) != EXPAND_RULE_SUCCESS) {
> >  			return -1;
> >  		}
> >  
> > @@ -1897,6 +1919,8 @@
> >  	expand_state_t state;
> >  	avrule_block_t *curblock;
> >  
> > +	expand_state_init(&state);
> > +
> >  	state.verbose = verbose;
> >  	state.typemap = NULL;
> >  	state.base = base;
> > @@ -2033,7 +2057,8 @@
> >  		/* copy rules */
> >  		cur_avrule = decl->avrules;
> >  		while (cur_avrule != NULL) {
> > -			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> > +			if (!(state.expand_neverallow)
> > +			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
> >  				/* copy this over directly so that assertions are checked later */
> >  				if (copy_neverallow
> >  				    (out, state.typemap, cur_avrule))
> > @@ -2043,7 +2068,7 @@
> >  				if (convert_and_expand_rule
> >  				    (state.handle, out, state.typemap,
> >  				     cur_avrule, &out->te_avtab, NULL, NULL,
> > -				     0) != 1) {
> > +				     0, state.expand_neverallow) != EXPAND_RULE_SUCCESS) {
> >  					goto cleanup;
> >  				}
> >  			}
> > Index: trunk/libsepol/src/write.c
> > ===================================================================
> > --- trunk/libsepol/src/write.c	(revision 1109)
> > +++ trunk/libsepol/src/write.c	(working copy)
> > @@ -68,21 +68,21 @@
> >  
> >  	items = put_entry(buf, sizeof(uint32_t), 3, fp);
> >  	if (items != 3)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	for (n = e->node; n; n = n->next) {
> >  		bit = cpu_to_le32(n->startbit);
> >  		items = put_entry(&bit, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		map = cpu_to_le64(n->map);
> >  		items = put_entry(&map, sizeof(uint64_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /* Ordering of datums in the original avtab format in the policy file. */
> > @@ -113,7 +113,7 @@
> >  		   Requires merging similar entries if uncond avtab. */
> >  		if (merge) {
> >  			if (cur->merged)
> > -				return 0;	/* already merged by prior merge */
> > +				return POLICYDB_SUCCESS;	/* already merged by prior merge */
> >  		}
> >  
> >  		items = 1;	/* item 0 is used for the item count */
> > @@ -137,7 +137,7 @@
> >  			else if (val & AVTAB_TYPE)
> >  				lookup = AVTAB_TYPE;
> >  			else
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			for (node = avtab_search_node_next(cur, lookup);
> >  			     node;
> >  			     node = avtab_search_node_next(node, lookup)) {
> > @@ -150,12 +150,12 @@
> >  
> >  		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
> >  			ERR(fp->handle, "null entry");
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  		if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
> >  			ERR(fp->handle, "entry has both access "
> >  			    "vectors and types");
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  
> >  		buf32[items++] = cpu_to_le32(val);
> > @@ -180,7 +180,7 @@
> >  
> >  					if (!node) {
> >  						ERR(fp->handle, "missing node");
> > -						return -1;
> > +						return POLICYDB_ERROR;
> >  					}
> >  					buf32[items++] =
> >  					    cpu_to_le32(node->datum.data);
> > @@ -196,7 +196,7 @@
> >  
> >  		if (set) {
> >  			ERR(fp->handle, "data count wrong");
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  
> >  		buf32[0] = cpu_to_le32(items - 1);
> > @@ -205,10 +205,10 @@
> >  			/* Commit this item to the policy file. */
> >  			items2 = put_entry(buf32, sizeof(uint32_t), items, fp);
> >  			if (items != items2)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  		}
> >  
> > -		return 0;
> > +		return POLICYDB_SUCCESS;
> >  	}
> >  
> >  	/* Generate the new avtab format. */
> > @@ -218,12 +218,12 @@
> >  	buf16[3] = cpu_to_le16(cur->key.specified);
> >  	items = put_entry(buf16, sizeof(uint16_t), 4, fp);
> >  	if (items != 4)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	buf32[0] = cpu_to_le32(cur->datum.data);
> >  	items = put_entry(buf32, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > -	return 0;
> > +		return POLICYDB_ERROR;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static inline void avtab_reset_merged(avtab_t * a)
> > @@ -252,7 +252,7 @@
> >  		   merge similar entries, so we need to track merged nodes 
> >  		   and compute the final nel. */
> >  		if (avtab_init(&expa))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (expand_avtab(p, a, &expa)) {
> >  			rc = -1;
> >  			goto out;
> > @@ -265,7 +265,7 @@
> >  		nel = cpu_to_le32(a->nel);
> >  		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> >  	for (i = 0; i < AVTAB_SIZE; i++) {
> > @@ -318,12 +318,12 @@
> >  	sens = cpu_to_le32(l->sens);
> >  	items = put_entry(&sens, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (ebitmap_write(&l->cat, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /*
> > @@ -346,15 +346,15 @@
> >  
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items2 != items)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (ebitmap_write(&r->level[0].cat, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	if (!eq)
> >  		if (ebitmap_write(&r->level[1].cat, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -373,16 +373,16 @@
> >  	buf[items++] = cpu_to_le32(levdatum->isalias);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (mls_write_level(levdatum->level, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -402,13 +402,13 @@
> >  	buf[items++] = cpu_to_le32(catdatum->isalias);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_trans_write(role_trans_t * r, struct policy_file *fp)
> > @@ -423,17 +423,17 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (tr = r; tr; tr = tr->next) {
> >  		buf[0] = cpu_to_le32(tr->role);
> >  		buf[1] = cpu_to_le32(tr->type);
> >  		buf[2] = cpu_to_le32(tr->new_role);
> >  		items = put_entry(buf, sizeof(uint32_t), 3, fp);
> >  		if (items != 3)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_allow_write(role_allow_t * r, struct policy_file *fp)
> > @@ -448,15 +448,15 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (ra = r; ra; ra = ra->next) {
> >  		buf[0] = cpu_to_le32(ra->role);
> >  		buf[1] = cpu_to_le32(ra->new_role);
> >  		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  		if (items != 2)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_set_write(role_set_t * x, struct policy_file *fp)
> > @@ -465,14 +465,14 @@
> >  	uint32_t buf[1];
> >  
> >  	if (ebitmap_write(&x->roles, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	buf[0] = cpu_to_le32(x->flags);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int type_set_write(type_set_t * x, struct policy_file *fp)
> > @@ -481,16 +481,16 @@
> >  	uint32_t buf[1];
> >  
> >  	if (ebitmap_write(&x->types, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	if (ebitmap_write(&x->negset, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	buf[0] = cpu_to_le32(x->flags);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -510,11 +510,11 @@
> >  	buf[items++] = cpu_to_le32(len);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > -	return 0;
> > +		return POLICYDB_ERROR;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /*
> > @@ -539,7 +539,7 @@
> >  
> >  	if (oldvers) {
> >  		if (avtab_init(&expa))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (expand_cond_av_list(p, list, &new_list, &expa))
> >  			goto out;
> >  		list = new_list;
> > @@ -587,7 +587,7 @@
> >  	buf[0] = cpu_to_le32(node->cur_state);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	/* expr */
> >  	len = 0;
> > @@ -597,7 +597,7 @@
> >  	buf[0] = cpu_to_le32(len);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
> >  		items = 0;
> > @@ -605,22 +605,22 @@
> >  		buf[items++] = cpu_to_le32(cur_expr->bool);
> >  		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  		if (items2 != items)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> >  	if (p->policy_type == POLICY_KERN) {
> >  		if (cond_write_av_list(p, node->true_list, fp) != 0)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (cond_write_av_list(p, node->false_list, fp) != 0)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	} else {
> >  		if (avrule_write_list(node->avtrue_list, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (avrule_write_list(node->avfalse_list, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int cond_write_list(policydb_t * p, cond_list_t * list,
> > @@ -636,13 +636,13 @@
> >  	buf[0] = cpu_to_le32(len);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	for (cur = list; cur != NULL; cur = cur->next) {
> >  		if (cond_write_node(p, cur, fp) != 0)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /*
> > @@ -661,15 +661,15 @@
> >  	buf[items++] = cpu_to_le32(c->type);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items2 != items)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	if ((p->policyvers >= POLICYDB_VERSION_MLS
> >  	     && p->policy_type == POLICY_KERN)
> >  	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
> >  		&& p->policy_type == POLICY_BASE))
> >  		if (mls_write_range_helper(&c->range, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /*
> > @@ -694,13 +694,13 @@
> >  	buf[items++] = cpu_to_le32(perdatum->s.value);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int common_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -721,16 +721,16 @@
> >  	buf[items++] = cpu_to_le32(comdatum->permissions.table->nel);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (hashtab_map(comdatum->permissions.table, perm_write, pd))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int write_cons_helper(policydb_t * p,
> > @@ -751,7 +751,7 @@
> >  		buf[1] = cpu_to_le32(nexpr);
> >  		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  		if (items != 2)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		for (e = c->expr; e; e = e->next) {
> >  			items = 0;
> >  			buf[0] = cpu_to_le32(e->expr_type);
> > @@ -759,18 +759,18 @@
> >  			buf[2] = cpu_to_le32(e->op);
> >  			items = put_entry(buf, sizeof(uint32_t), 3, fp);
> >  			if (items != 3)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  
> >  			switch (e->expr_type) {
> >  			case CEXPR_NAMES:
> >  				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (ebitmap_write(&e->names, fp)) {
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				}
> >  				if (p->policy_type != POLICY_KERN &&
> >  				    type_set_write(e->type_names, fp)) {
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				}
> >  				break;
> >  			default:
> > @@ -779,7 +779,7 @@
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -817,22 +817,22 @@
> >  	buf[items++] = cpu_to_le32(ncons);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (cladatum->comkey) {
> >  		items = put_entry(cladatum->comkey, 1, len2, fp);
> >  		if (items != len2)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  	if (hashtab_map(cladatum->permissions.table, perm_write, pd))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (write_cons_helper(p, cladatum->constraints, 0, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if ((p->policy_type == POLICY_KERN
> >  	     && p->policyvers >= POLICYDB_VERSION_VALIDATETRANS)
> > @@ -846,12 +846,12 @@
> >  		buf[0] = cpu_to_le32(ncons);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (write_cons_helper(p, cladatum->validatetrans, 1, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -871,23 +871,23 @@
> >  	buf[items++] = cpu_to_le32(role->s.value);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (ebitmap_write(&role->dominates, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	if (p->policy_type == POLICY_KERN) {
> >  		if (ebitmap_write(&role->types.types, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	} else {
> >  		if (type_set_write(&role->types, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -911,18 +911,18 @@
> >  	}
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (p->policy_type != POLICY_KERN) {
> >  		if (ebitmap_write(&typdatum->types, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -942,18 +942,18 @@
> >  	buf[items++] = cpu_to_le32(usrdatum->s.value);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	items = put_entry(key, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (p->policy_type == POLICY_KERN) {
> >  		if (ebitmap_write(&usrdatum->roles.roles, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	} else {
> >  		if (role_set_write(&usrdatum->roles, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  	/* Users are allowed in non-mls modules, so the empty field will be present
> >  	   in modules with users >= MOD_POLICYDB_VERSION_MLS */
> > @@ -964,12 +964,12 @@
> >  	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
> >  		&& p->policy_type == POLICY_BASE)) {
> >  		if (mls_write_range_helper(&usrdatum->range, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (mls_write_level(&usrdatum->dfltlevel, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
> > @@ -991,16 +991,16 @@
> >  		buf[0] = cpu_to_le32(nel);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		for (c = p->ocontexts[i]; c; c = c->next) {
> >  			switch (i) {
> >  			case OCON_ISID:
> >  				buf[0] = cpu_to_le32(c->sid[0]);
> >  				items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  				if (items != 1)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			case OCON_FS:
> >  			case OCON_NETIF:
> > @@ -1008,14 +1008,14 @@
> >  				buf[0] = cpu_to_le32(len);
> >  				items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  				if (items != 1)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				items = put_entry(c->u.name, 1, len, fp);
> >  				if (items != len)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[1], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			case OCON_PORT:
> >  				buf[0] = c->u.port.protocol;
> > @@ -1026,18 +1026,18 @@
> >  				}
> >  				items = put_entry(buf, sizeof(uint32_t), 3, fp);
> >  				if (items != 3)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			case OCON_NODE:
> >  				buf[0] = cpu_to_le32(c->u.node.addr);
> >  				buf[1] = cpu_to_le32(c->u.node.mask);
> >  				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  				if (items != 2)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			case OCON_FSUSE:
> >  				buf[0] = cpu_to_le32(c->v.behavior);
> > @@ -1045,12 +1045,12 @@
> >  				buf[1] = cpu_to_le32(len);
> >  				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  				if (items != 2)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				items = put_entry(c->u.name, 1, len, fp);
> >  				if (items != len)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			case OCON_NODE6:
> >  				for (j = 0; j < 4; j++)
> > @@ -1061,14 +1061,14 @@
> >  					    cpu_to_le32(c->u.node6.mask[j]);
> >  				items = put_entry(buf, sizeof(uint32_t), 8, fp);
> >  				if (items != 8)
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				if (context_write(p, &c->context[0], fp))
> > -					return -1;
> > +					return POLICYDB_ERROR;
> >  				break;
> >  			}
> >  		}
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int genfs_write(policydb_t * p, struct policy_file *fp)
> > @@ -1083,41 +1083,41 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (genfs = p->genfs; genfs; genfs = genfs->next) {
> >  		len = strlen(genfs->fstype);
> >  		buf[0] = cpu_to_le32(len);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		items = put_entry(genfs->fstype, 1, len, fp);
> >  		if (items != len)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		nel = 0;
> >  		for (c = genfs->head; c; c = c->next)
> >  			nel++;
> >  		buf[0] = cpu_to_le32(nel);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		for (c = genfs->head; c; c = c->next) {
> >  			len = strlen(c->u.name);
> >  			buf[0] = cpu_to_le32(len);
> >  			items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  			if (items != 1)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			items = put_entry(c->u.name, 1, len, fp);
> >  			if (items != len)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			buf[0] = cpu_to_le32(c->v.sclass);
> >  			items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  			if (items != 1)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			if (context_write(p, &c->context[0], fp))
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  		}
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int range_write(policydb_t * p, struct policy_file *fp)
> > @@ -1131,17 +1131,17 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (rt = p->range_tr; rt; rt = rt->next) {
> >  		buf[0] = cpu_to_le32(rt->dom);
> >  		buf[1] = cpu_to_le32(rt->type);
> >  		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  		if (items != 2)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (mls_write_range_helper(&rt->range, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /************** module writing functions below **************/
> > @@ -1157,13 +1157,13 @@
> >  	buf[items++] = cpu_to_le32(avrule->flags);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items2 != items)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (type_set_write(&avrule->stypes, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (type_set_write(&avrule->ttypes, fp))
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	cur = avrule->perms;
> >  	len = 0;
> > @@ -1175,7 +1175,7 @@
> >  	buf[items++] = cpu_to_le32(len);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items2 != items)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	cur = avrule->perms;
> >  	while (cur) {
> >  		items = 0;
> > @@ -1183,12 +1183,12 @@
> >  		buf[items++] = cpu_to_le32(cur->data);
> >  		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  		if (items2 != items)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  
> >  		cur = cur->next;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
> > @@ -1205,7 +1205,7 @@
> >  
> >  	buf[0] = cpu_to_le32(len);
> >  	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	avrule = avrules;
> >  	while (avrule) {
> > @@ -1213,7 +1213,7 @@
> >  		avrule = avrule->next;
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
> > @@ -1228,18 +1228,18 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (tr = t; tr; tr = tr->next) {
> >  		if (role_set_write(&tr->roles, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (type_set_write(&tr->types, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		buf[0] = cpu_to_le32(tr->new_role);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
> > @@ -1254,14 +1254,14 @@
> >  	buf[0] = cpu_to_le32(nel);
> >  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  	if (items != 1)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	for (ra = r; ra; ra = ra->next) {
> >  		if (role_set_write(&ra->roles, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (role_set_write(&ra->new_roles, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int scope_index_write(scope_index_t * scope_index,
> > @@ -1272,19 +1272,19 @@
> >  	uint32_t buf[1];
> >  	for (i = 0; i < num_scope_syms; i++) {
> >  		if (ebitmap_write(scope_index->scope + i, fp) == -1) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	}
> >  	buf[0] = cpu_to_le32(scope_index->class_perms_len);
> >  	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	for (i = 0; i < scope_index->class_perms_len; i++) {
> >  		if (ebitmap_write(scope_index->class_perms_map + i, fp) == -1) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
> > @@ -1296,17 +1296,17 @@
> >  	buf[0] = cpu_to_le32(decl->decl_id);
> >  	buf[1] = cpu_to_le32(decl->enabled);
> >  	if (put_entry(buf, sizeof(uint32_t), 2, fp) != 2) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
> >  	    avrule_write_list(decl->avrules, fp) == -1 ||
> >  	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
> >  	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	if (scope_index_write(&decl->required, num_scope_syms, fp) == -1 ||
> >  	    scope_index_write(&decl->declared, num_scope_syms, fp) == -1) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	pd.fp = fp;
> >  	pd.p = p;
> > @@ -1314,13 +1314,13 @@
> >  		buf[0] = cpu_to_le32(decl->symtab[i].nprim);
> >  		buf[1] = cpu_to_le32(decl->symtab[i].table->nel);
> >  		if (put_entry(buf, sizeof(uint32_t), 2, fp) != 2) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  		if (hashtab_map(decl->symtab[i].table, write_f[i], &pd)) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int avrule_block_write(avrule_block_t * block, int num_scope_syms,
> > @@ -1334,7 +1334,7 @@
> >  	}
> >  	buf[0] = cpu_to_le32(num_blocks);
> >  	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  
> >  	/* now write each block */
> > @@ -1347,16 +1347,16 @@
> >  		}
> >  		buf[0] = cpu_to_le32(num_decls);
> >  		if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  		for (decl = cur->branch_list; decl != NULL; decl = decl->next) {
> >  			if (avrule_decl_write(decl, num_scope_syms, p, fp) ==
> >  			    -1) {
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			}
> >  		}
> >  	}
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  static int scope_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> > @@ -1373,7 +1373,7 @@
> >  		 * buffer.  this would have been easier with C99's
> >  		 * dynamic arrays... */
> >  		if ((dyn_buf = malloc(items * sizeof(*dyn_buf))) == NULL) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  		buf = dyn_buf;
> >  	} else {
> > @@ -1382,7 +1382,7 @@
> >  	buf[0] = cpu_to_le32(key_len);
> >  	if (put_entry(buf, sizeof(*buf), 1, fp) != 1 ||
> >  	    put_entry(key, 1, key_len, fp) != key_len) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	buf[0] = cpu_to_le32(scope->scope);
> >  	buf[1] = cpu_to_le32(scope->decl_ids_len);
> > @@ -1391,10 +1391,10 @@
> >  	}
> >  	if (put_entry(buf, sizeof(*buf), items, fp) != items) {
> >  		free(dyn_buf);
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  	free(dyn_buf);
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> >  
> >  /*
> > @@ -1411,6 +1411,9 @@
> >  	struct policy_data pd;
> >  	char *policydb_str;
> >  
> > +	if (p->unsupported_format)
> > +		return POLICYDB_UNSUPPORTED;
> > +
> >  	pd.fp = fp;
> >  	pd.p = p;
> >  
> > @@ -1432,10 +1435,10 @@
> >  	buf[items++] = cpu_to_le32(len);
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	items = put_entry(policydb_str, 1, len, fp);
> >  	if (items != len)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	/* Write the version, config, and table sizes. */
> >  	items = 0;
> > @@ -1443,7 +1446,7 @@
> >  	if (!info) {
> >  		ERR(fp->handle, "compatibility lookup failed for policy "
> >  		    "version %d", p->policyvers);
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  
> >  	if (p->policy_type != POLICY_KERN) {
> > @@ -1456,7 +1459,7 @@
> >  
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  
> >  	if (p->policy_type == POLICY_MOD) {
> >  		/* Write module name and version */
> > @@ -1464,18 +1467,18 @@
> >  		buf[0] = cpu_to_le32(len);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		items = put_entry(p->name, 1, len, fp);
> >  		if (items != len)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		len = strlen(p->version);
> >  		buf[0] = cpu_to_le32(len);
> >  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >  		if (items != 1)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		items = put_entry(p->version, 1, len, fp);
> >  		if (items != len)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  	num_syms = info->sym_num;
> >  	for (i = 0; i < num_syms; i++) {
> > @@ -1483,43 +1486,43 @@
> >  		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
> >  		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> >  		if (items != 2)
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (hashtab_map(p->symtab[i].table, write_f[i], &pd))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	}
> >  
> >  	if (p->policy_type == POLICY_KERN) {
> >  		if (avtab_write(p, &p->te_avtab, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (p->policyvers < POLICYDB_VERSION_BOOL) {
> >  			if (p->p_bools.nprim)
> >  				WARN(fp->handle, "Discarding "
> >  				     "booleans and conditional rules");
> >  		} else {
> >  			if (cond_write_list(p, p->cond_list, fp))
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  		}
> >  		if (role_trans_write(p->role_tr, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		if (role_allow_write(p->role_allow, fp))
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  	} else {
> >  		if (avrule_block_write(p->global, num_syms, p, fp) == -1) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  
> >  		for (i = 0; i < num_syms; i++) {
> >  			buf[0] = cpu_to_le32(p->scope[i].table->nel);
> >  			if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  			}
> >  			if (hashtab_map(p->scope[i].table, scope_write, &pd))
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  		}
> >  	}
> >  
> >  	if (ocontext_write(info, p, fp) == -1 || genfs_write(p, fp) == -1) {
> > -		return -1;
> > +		return POLICYDB_ERROR;
> >  	}
> >  
> >  	if ((p->policyvers >= POLICYDB_VERSION_MLS
> > @@ -1527,7 +1530,7 @@
> >  	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
> >  		&& p->policy_type == POLICY_BASE)) {
> >  		if (range_write(p, fp)) {
> > -			return -1;
> > +			return POLICYDB_ERROR;
> >  		}
> >  	}
> >  
> > @@ -1535,9 +1538,9 @@
> >  	    && p->policyvers >= POLICYDB_VERSION_AVTAB) {
> >  		for (i = 0; i < p->p_types.nprim; i++) {
> >  			if (ebitmap_write(&p->type_attr_map[i], fp) == -1)
> > -				return -1;
> > +				return POLICYDB_ERROR;
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	return POLICYDB_SUCCESS;
> >  }
> > Index: trunk/libsepol/src/link.c
> > ===================================================================
> > --- trunk/libsepol/src/link.c	(revision 1109)
> > +++ trunk/libsepol/src/link.c	(working copy)
> > @@ -964,8 +964,7 @@
> >  			    module->map[SYM_CLASSES][cur_perm->class - 1];
> >  			assert(new_perm->class);
> >  
> > -			if (new_rule->
> > -			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
> > +			if (new_rule->specified & AVRULE_AV) {
> >  				for (i = 0;
> >  				     i <
> >  				     module->perm_map_len[cur_perm->class - 1];
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
