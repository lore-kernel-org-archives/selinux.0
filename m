Subject: Re: PATCH: use yyerror2() in checkpolicy parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <200802272142.m1RLg501005973@cadmus.columbia.tresys.com>
References: <200802272142.m1RLg501005973@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 08:22:08 -0500
Message-Id: <1204204928.31790.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-27 at 16:42 -0500, Todd C. Miller wrote:
> policy_parse.y defines a yyerror2() which takes a variables number
> of arguments, but much of the code does not take advantage of it.
> This diff just replaces sprintf() + yyerror() with yyerror2().
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
>  policy_parse.y |  274 ++++++++++++++++++---------------------------------------
>  1 file changed, 90 insertions(+), 184 deletions(-)
> 
> Index: trunk/checkpolicy/policy_parse.y
> ===================================================================
> --- trunk/checkpolicy/policy_parse.y	(revision 2811)
> +++ trunk/checkpolicy/policy_parse.y	(working copy)
> @@ -1035,8 +1035,7 @@
>  
>  	for (c = head; c; c = c->next) {
>  		if (!strcmp(newc->u.name, c->u.name)) {
> -			sprintf(errormsg, "duplicate initial SID %s", id);
> -			yyerror(errormsg);
> +			yyerror2("duplicate initial SID %s", id);
>  			goto bad;
>  		}
>  	}
> @@ -1079,9 +1078,7 @@
>  	}
>  	comdatum = hashtab_search(policydbp->p_commons.table, id);
>  	if (comdatum) {
> -		snprintf(errormsg, ERRORMSG_LEN,
> -			 "duplicate declaration for common %s\n", id);
> -		yyerror(errormsg);
> +		yyerror2("duplicate declaration for common %s\n", id);
>  		return -1;
>  	}
>  	comdatum = (common_datum_t *) malloc(sizeof(common_datum_t));
> @@ -1126,10 +1123,8 @@
>  				     (hashtab_datum_t) perdatum);
>  
>  		if (ret == SEPOL_EEXIST) {
> -			sprintf(errormsg,
> -				"duplicate permission %s in common %s", perm,
> -				id);
> -			yyerror(errormsg);
> +			yyerror2("duplicate permission %s in common %s", perm,
> +				 id);
>  			goto bad_perm;
>  		}
>  		if (ret == SEPOL_ENOMEM) {
> @@ -1178,8 +1173,7 @@
>  	cladatum = (class_datum_t *) hashtab_search(policydbp->p_classes.table,
>  						    (hashtab_key_t) id);
>  	if (!cladatum) {
> -		sprintf(errormsg, "class %s is not defined", id);
> -		yyerror(errormsg);
> +		yyerror2("class %s is not defined", id);
>  		goto bad;
>  	}
>  	free(id);
> @@ -1205,8 +1199,7 @@
>  						      (hashtab_key_t) id);
>  
>  		if (!comdatum) {
> -			sprintf(errormsg, "common %s is not defined", id);
> -			yyerror(errormsg);
> +			yyerror2("common %s is not defined", id);
>  			goto bad;
>  		}
>  		cladatum->comkey = id;
> @@ -1243,10 +1236,8 @@
>  							    permissions.table,
>  							    (hashtab_key_t) id);
>  			if (perdatum2) {
> -				sprintf(errormsg,
> -					"permission %s conflicts with an inherited permission",
> -					id);
> -				yyerror(errormsg);
> +				yyerror2("permission %s conflicts with an "
> +					 "inherited permission", id);
>  				goto bad;
>  			}
>  		}
> @@ -1255,8 +1246,7 @@
>  				     (hashtab_datum_t) perdatum);
>  
>  		if (ret == SEPOL_EEXIST) {
> -			sprintf(errormsg, "duplicate permission %s", id);
> -			yyerror(errormsg);
> +			yyerror2("duplicate permission %s", id);
>  			goto bad;
>  		}
>  		if (ret == SEPOL_ENOMEM) {
> @@ -1434,18 +1424,14 @@
>  		    (level_datum_t *) hashtab_search(policydbp->p_levels.table,
>  						     (hashtab_key_t) id);
>  		if (!datum) {
> -			sprintf(errormsg,
> -				"unknown sensitivity %s used in dominance definition",
> -				id);
> -			yyerror(errormsg);
> +			yyerror2("unknown sensitivity %s used in dominance "
> +				 "definition", id);
>  			free(id);
>  			return -1;
>  		}
>  		if (datum->level->sens != 0) {
> -			sprintf(errormsg,
> -				"sensitivity %s occurs multiply in dominance definition",
> -				id);
> -			yyerror(errormsg);
> +			yyerror2("sensitivity %s occurs multiply in dominance "
> +				 "definition", id);
>  			free(id);
>  			return -1;
>  		}
> @@ -1630,17 +1616,13 @@
>  	levdatum = (level_datum_t *) hashtab_search(policydbp->p_levels.table,
>  						    (hashtab_key_t) id);
>  	if (!levdatum) {
> -		sprintf(errormsg,
> -			"unknown sensitivity %s used in level definition", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown sensitivity %s used in level definition", id);
>  		free(id);
>  		return -1;
>  	}
>  	if (ebitmap_length(&levdatum->level->cat)) {
> -		sprintf(errormsg,
> -			"sensitivity %s used in multiple level definitions",
> -			id);
> -		yyerror(errormsg);
> +		yyerror2("sensitivity %s used in multiple level definitions",
> +			 id);
>  		free(id);
>  		return -1;
>  	}
> @@ -1664,9 +1646,7 @@
>  							   (hashtab_key_t)
>  							   id_start);
>  			if (!cdatum) {
> -				sprintf(errormsg, "unknown category %s",
> -					id_start);
> -				yyerror(errormsg);
> +				yyerror2("unknown category %s", id_start);
>  				free(id);
>  				return -1;
>  			}
> @@ -1677,17 +1657,14 @@
>  							   (hashtab_key_t)
>  							   id_end);
>  			if (!cdatum) {
> -				sprintf(errormsg, "unknown category %s",
> -					id_end);
> -				yyerror(errormsg);
> +				yyerror2("unknown category %s", id_end);
>  				free(id);
>  				return -1;
>  			}
>  			range_end = cdatum->s.value - 1;
>  
>  			if (range_end < range_start) {
> -				sprintf(errormsg, "category range is invalid");
> -				yyerror(errormsg);
> +				yyerror2("category range is invalid");
>  				free(id);
>  				return -1;
>  			}
> @@ -1810,10 +1787,8 @@
>  	}
>  	t = hashtab_search(policydbp->p_types.table, id);
>  	if (!t || t->flavor == TYPE_ATTRIB) {
> -		sprintf(errormsg,
> -			"unknown type %s, or it was already declared as an attribute",
> -			id);
> -		yyerror(errormsg);
> +		yyerror2("unknown type %s, or it was already declared as an "
> +			 "attribute", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -1844,8 +1819,7 @@
>  	}
>  	t = hashtab_search(policydbp->p_types.table, id);
>  	if (!t || t->flavor == TYPE_ATTRIB) {
> -		sprintf(errormsg, "unknown type %s", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown type %s", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -1858,16 +1832,14 @@
>  		}
>  		attr = hashtab_search(policydbp->p_types.table, id);
>  		if (!attr) {
> -			sprintf(errormsg, "attribute %s is not declared", id);
>  			/* treat it as a fatal error */
> -			yyerror(errormsg);
> +			yyerror2("attribute %s is not declared", id);
>  			free(id);
>  			return -1;
>  		}
>  
>  		if (attr->flavor != TYPE_ATTRIB) {
> -			sprintf(errormsg, "%s is a type, not an attribute", id);
> -			yyerror(errormsg);
> +			yyerror2("%s is a type, not an attribute", id);
>  			free(id);
>  			return -1;
>  		}
> @@ -1920,18 +1892,15 @@
>  		}
>  		attr = hashtab_search(policydbp->p_types.table, id);
>  		if (!attr) {
> -			sprintf(errormsg, "attribute %s is not declared", id);
> -
>  			/* treat it as a fatal error */
> -			yyerror(errormsg);
> +			yyerror2("attribute %s is not declared", id);
>  			return -1;
>  		} else {
>  			newattr = 0;
>  		}
>  
>  		if (attr->flavor != TYPE_ATTRIB) {
> -			sprintf(errormsg, "%s is a type, not an attribute", id);
> -			yyerror(errormsg);
> +			yyerror2("%s is a type, not an attribute", id);
>  			return -1;
>  		}
>  
> @@ -1998,8 +1967,7 @@
>  	}
>  	t = hashtab_search(policydbp->p_types.table, id);
>  	if (!t) {
> -		snprintf(errormsg, ERRORMSG_LEN, "unknown type %s", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown type %s", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -2059,8 +2027,7 @@
>  		}
>  		cladatum = hashtab_search(policydbp->p_classes.table, id);
>  		if (!cladatum) {
> -			sprintf(errormsg, "unknown class %s", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown class %s", id);
>  			goto bad;
>  		}
>  		if (ebitmap_set_bit(&tclasses, cladatum->s.value - 1, TRUE)) {
> @@ -2083,8 +2050,7 @@
>  	datum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
>  						(hashtab_key_t) id);
>  	if (!datum || datum->flavor == TYPE_ATTRIB) {
> -		sprintf(errormsg, "unknown type %s", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown type %s", id);
>  		goto bad;
>  	}
>  
> @@ -2300,8 +2266,7 @@
>  		}
>  		cladatum = hashtab_search(policydbp->p_classes.table, id);
>  		if (!cladatum) {
> -			sprintf(errormsg, "unknown class %s used in rule", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown class %s used in rule", id);
>  			ret = -1;
>  			goto out;
>  		}
> @@ -2365,19 +2330,17 @@
>  				}
>  			}
>  			if (!perdatum) {
> -				sprintf(errormsg,
> -					"permission %s is not defined for class %s",
> -					id, policydbp->p_class_val_to_name[i]);
>  				if (!suppress)
> -					yyerror(errormsg);
> +					yyerror2("permission %s is not defined"
> +					     " for class %s", id,
> +					     policydbp->p_class_val_to_name[i]);
>  				continue;
>  			} else
>  			    if (!is_perm_in_scope
>  				(id, policydbp->p_class_val_to_name[i])) {
>  				if (!suppress) {
> -					yyerror2
> -					    ("permission %s of class %s is not within scope",
> -					     id,
> +					yyerror2("permission %s of class %s is"
> +					     " not within scope", id,
>  					     policydbp->p_class_val_to_name[i]);
>  				}
>  				continue;
> @@ -2769,9 +2732,7 @@
>  	}
>  	role = hashtab_search(policydbp->p_roles.table, id);
>  	if (!role) {
> -		sprintf(errormsg,
> -			"unknown role %s used in transition definition", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown role %s used in transition definition", id);
>  		goto bad;
>  	}
>  
> @@ -2791,12 +2752,9 @@
>  
>  			for (tr = policydbp->role_tr; tr; tr = tr->next) {
>  				if (tr->role == (i + 1) && tr->type == (j + 1)) {
> -					sprintf(errormsg,
> -						"duplicate role transition for (%s,%s)",
> -						role_val_to_name(i + 1),
> -						policydbp->
> -						p_type_val_to_name[j]);
> -					yyerror(errormsg);
> +					yyerror2("duplicate role transition for (%s,%s)",
> +					      role_val_to_name(i + 1),
> +					      policydbp->p_type_val_to_name[j]);
>  					goto bad;
>  				}
>  			}
> @@ -2983,9 +2941,8 @@
>  		    (class_datum_t *) hashtab_search(policydbp->p_classes.table,
>  						     (hashtab_key_t) id);
>  		if (!cladatum) {
> -			sprintf(errormsg, "class %s is not defined", id);
> +			yyerror2("class %s is not defined", id);
>  			ebitmap_destroy(&classmap);
> -			yyerror(errormsg);
>  			free(id);
>  			return -1;
>  		}
> @@ -3043,10 +3000,8 @@
>  								   id);
>  					}
>  					if (!perdatum) {
> -						sprintf(errormsg,
> -							"permission %s is not defined",
> -							id);
> -						yyerror(errormsg);
> +						yyerror2("permission %s is not"
> +							 " defined", id);
>  						free(id);
>  						ebitmap_destroy(&classmap);
>  						return -1;
> @@ -3126,9 +3081,8 @@
>  		    (class_datum_t *) hashtab_search(policydbp->p_classes.table,
>  						     (hashtab_key_t) id);
>  		if (!cladatum) {
> -			sprintf(errormsg, "class %s is not defined", id);
> +			yyerror2("class %s is not defined", id);
>  			ebitmap_destroy(&classmap);
> -			yyerror(errormsg);
>  			free(id);
>  			return -1;
>  		}
> @@ -3258,9 +3212,7 @@
>  								    (hashtab_key_t)
>  								    id);
>  				if (!user) {
> -					sprintf(errormsg, "unknown user %s",
> -						id);
> -					yyerror(errormsg);
> +					yyerror2("unknown user %s", id);
>  					constraint_expr_destroy(expr);
>  					return 0;
>  				}
> @@ -3279,9 +3231,7 @@
>  								    (hashtab_key_t)
>  								    id);
>  				if (!role) {
> -					sprintf(errormsg, "unknown role %s",
> -						id);
> -					yyerror(errormsg);
> +					yyerror2("unknown role %s", id);
>  					constraint_expr_destroy(expr);
>  					return 0;
>  				}
> @@ -3510,10 +3460,8 @@
>  							 table,
>  							 (hashtab_key_t) id);
>  		if (!bool_var) {
> -			sprintf(errormsg,
> -				"unknown boolean %s in conditional expression",
> -				id);
> -			yyerror(errormsg);
> +			yyerror2("unknown boolean %s in conditional expression",
> +				 id);
>  			free(expr);
>  			free(id);
>  			return NULL;
> @@ -3552,8 +3500,7 @@
>  	}
>  	r = hashtab_search(policydbp->p_roles.table, id);
>  	if (!r) {
> -		sprintf(errormsg, "unknown role %s", id);
> -		yyerror(errormsg);
> +		yyerror2("unknown role %s", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -3587,31 +3534,27 @@
>  							(hashtab_key_t)
>  							id_start);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id_start);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id_start);
>  			return -1;
>  		}
>  		range_start = cdatum->s.value - 1;
>  		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
>  							(hashtab_key_t) id_end);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id_end);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id_end);
>  			return -1;
>  		}
>  		range_end = cdatum->s.value - 1;
>  
>  		if (range_end < range_start) {
> -			sprintf(errormsg, "category range is invalid");
> -			yyerror(errormsg);
> +			yyerror2("category range is invalid");
>  			return -1;
>  		}
>  	} else {
>  		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
>  							(hashtab_key_t) id);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id);
>  			return -1;
>  		}
>  		range_start = range_end = cdatum->s.value - 1;
> @@ -3621,11 +3564,10 @@
>  		if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
>  			uint32_t level_value = levdatum->level->sens - 1;
>  			policydb_index_others(NULL, policydbp, 0);
> -			sprintf(errormsg, "category %s can not be associated "
> -				"with level %s",
> -				policydbp->p_cat_val_to_name[i],
> -				policydbp->p_sens_val_to_name[level_value]);
> -			yyerror(errormsg);
> +			yyerror2("category %s can not be associated "
> +				 "with level %s",
> +				 policydbp->p_cat_val_to_name[i],
> +				 policydbp->p_sens_val_to_name[level_value]);
>  			return -1;
>  		}
>  		if (ebitmap_set_bit(cats, i, TRUE)) {
> @@ -3655,8 +3597,7 @@
>  							(hashtab_key_t)
>  							id_start);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id_start);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id_start);
>  			return -1;
>  		}
>  		range_start = cdatum->s.value;
> @@ -3664,8 +3605,7 @@
>  		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
>  							(hashtab_key_t) id_end);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id_end);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id_end);
>  			return -1;
>  		}
>  		range_end = cdatum->s.value;
> @@ -3673,8 +3613,7 @@
>  		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
>  							(hashtab_key_t) id);
>  		if (!cdatum) {
> -			sprintf(errormsg, "unknown category %s", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown category %s", id);
>  			return -1;
>  		}
>  		range_start = range_end = cdatum->s.value;
> @@ -3744,9 +3683,8 @@
>  		    hashtab_search(policydbp->p_levels.table,
>  				   (hashtab_key_t) id);
>  		if (!levdatum) {
> -			sprintf(errormsg, "unknown sensitivity %s used in user"
> -				" level definition", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown sensitivity %s used in user"
> +				 " level definition", id);
>  			free(id);
>  			return -1;
>  		}
> @@ -3770,10 +3708,8 @@
>  			    hashtab_search(policydbp->p_levels.table,
>  					   (hashtab_key_t) id);
>  			if (!levdatum) {
> -				sprintf(errormsg,
> -					"unknown sensitivity %s used in user range definition",
> -					id);
> -				yyerror(errormsg);
> +				yyerror2("unknown sensitivity %s used in user"
> +					 " range definition", id);
>  				free(id);
>  				return -1;
>  			}
> @@ -3854,8 +3790,7 @@
>  	usrdatum = (user_datum_t *) hashtab_search(policydbp->p_users.table,
>  						   (hashtab_key_t) id);
>  	if (!usrdatum) {
> -		sprintf(errormsg, "user %s is not defined", id);
> -		yyerror(errormsg);
> +		yyerror2("user %s is not defined", id);
>  		free(id);
>  		goto bad;
>  	}
> @@ -3878,8 +3813,7 @@
>  	role = (role_datum_t *) hashtab_search(policydbp->p_roles.table,
>  					       (hashtab_key_t) id);
>  	if (!role) {
> -		sprintf(errormsg, "role %s is not defined", id);
> -		yyerror(errormsg);
> +		yyerror2("role %s is not defined", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -3902,9 +3836,7 @@
>  	typdatum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
>  						   (hashtab_key_t) id);
>  	if (!typdatum || typdatum->flavor == TYPE_ATTRIB) {
> -		sprintf(errormsg, "type %s is not defined or is an attribute",
> -			id);
> -		yyerror(errormsg);
> +		yyerror2("type %s is not defined or is an attribute", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -3928,9 +3860,7 @@
>  			    hashtab_search(policydbp->p_levels.table,
>  					   (hashtab_key_t) id);
>  			if (!levdatum) {
> -				sprintf(errormsg, "Sensitivity %s is not "
> -					"defined", id);
> -				yyerror(errormsg);
> +				yyerror2("Sensitivity %s is not defined", id);
>  				free(id);
>  				return -1;
>  			}
> @@ -4000,15 +3930,12 @@
>  	}
>  
>  	if (!c) {
> -		sprintf(errormsg, "SID %s is not defined", id);
> -		yyerror(errormsg);
> +		yyerror2("SID %s is not defined", id);
>  		free(id);
>  		return -1;
>  	}
>  	if (c->context[0].user) {
> -		sprintf(errormsg, "The context for SID %s is multiply defined",
> -			id);
> -		yyerror(errormsg);
> +		yyerror2("The context for SID %s is multiply defined", id);
>  		free(id);
>  		return -1;
>  	}
> @@ -4061,9 +3988,8 @@
>  
>  	for (c = head; c; c = c->next) {
>  		if (!strcmp(newc->u.name, c->u.name)) {
> -			sprintf(errormsg, "duplicate entry for file system %s",
> -				newc->u.name);
> -			yyerror(errormsg);
> +			yyerror2("duplicate entry for file system %s",
> +				 newc->u.name);
>  			context_destroy(&newc->context[0]);
>  			context_destroy(&newc->context[1]);
>  			free(newc->u.name);
> @@ -4108,8 +4034,7 @@
>  	} else if ((strcmp(id, "udp") == 0) || (strcmp(id, "UDP") == 0)) {
>  		protocol = IPPROTO_UDP;
>  	} else {
> -		sprintf(errormsg, "unrecognized protocol %s", id);
> -		yyerror(errormsg);
> +		yyerror2("unrecognized protocol %s", id);
>  		free(newc);
>  		return -1;
>  	}
> @@ -4119,9 +4044,7 @@
>  	newc->u.port.high_port = high;
>  
>  	if (low > high) {
> -		sprintf(errormsg, "low port %d exceeds high port %d", low,
> -			high);
> -		yyerror(errormsg);
> +		yyerror2("low port %d exceeds high port %d", low, high);
>  		free(newc);
>  		return -1;
>  	}
> @@ -4142,15 +4065,13 @@
>  		if (protocol != prot2)
>  			continue;
>  		if (low == low2 && high == high2) {
> -			sprintf(errormsg,
> -				"duplicate portcon entry for %s %d-%d ", id,
> -				low, high);
> +			yyerror2("duplicate portcon entry for %s %d-%d ", id,
> +				 low, high);
>  			goto bad;
>  		}
>  		if (low2 <= low && high2 >= high) {
> -			sprintf(errormsg,
> -				"portcon entry for %s %d-%d hidden by earlier entry for %d-%d",
> -				id, low, high, low2, high2);
> +			yyerror2("portcon entry for %s %d-%d hidden by earlier "
> +				 "entry for %d-%d", id, low, high, low2, high2);
>  			goto bad;
>  		}
>  	}
> @@ -4163,7 +4084,6 @@
>  	return 0;
>  
>        bad:
> -	yyerror(errormsg);
>  	free(newc);
>  	return -1;
>  }
> @@ -4206,10 +4126,8 @@
>  
>  	for (c = head; c; c = c->next) {
>  		if (!strcmp(newc->u.name, c->u.name)) {
> -			sprintf(errormsg,
> -				"duplicate entry for network interface %s",
> -				newc->u.name);
> -			yyerror(errormsg);
> +			yyerror2("duplicate entry for network interface %s",
> +				 newc->u.name);
>  			context_destroy(&newc->context[0]);
>  			context_destroy(&newc->context[1]);
>  			free(newc->u.name);
> @@ -4420,10 +4338,8 @@
>  
>  	for (c = head; c; c = c->next) {
>  		if (!strcmp(newc->u.name, c->u.name)) {
> -			sprintf(errormsg,
> -				"duplicate fs_use entry for filesystem type %s",
> -				newc->u.name);
> -			yyerror(errormsg);
> +			yyerror2("duplicate fs_use entry for filesystem type %s",
> +				 newc->u.name);
>  			context_destroy(&newc->context[0]);
>  			free(newc->u.name);
>  			free(newc);
> @@ -4489,8 +4405,7 @@
>  		if (!type)
>  			goto fail;
>  		if (type[1] != 0) {
> -			sprintf(errormsg, "invalid type %s", type);
> -			yyerror(errormsg);
> +			yyerror2("invalid type %s", type);
>  			goto fail;
>  		}
>  		switch (type[0]) {
> @@ -4516,8 +4431,7 @@
>  			newc->v.sclass = SECCLASS_FILE;
>  			break;
>  		default:
> -			sprintf(errormsg, "invalid type %s", type);
> -			yyerror(errormsg);
> +			yyerror2("invalid type %s", type);
>  			goto fail;
>  		}
>  	}
> @@ -4530,10 +4444,8 @@
>  		if (!strcmp(newc->u.name, c->u.name) &&
>  		    (!newc->v.sclass || !c->v.sclass
>  		     || newc->v.sclass == c->v.sclass)) {
> -			sprintf(errormsg,
> -				"duplicate entry for genfs entry (%s, %s)",
> -				fstype, newc->u.name);
> -			yyerror(errormsg);
> +			yyerror2("duplicate entry for genfs entry (%s, %s)",
> +				 fstype, newc->u.name);
>  			goto fail;
>  		}
>  		len = strlen(newc->u.name);
> @@ -4627,8 +4539,7 @@
>  			cladatum = hashtab_search(policydbp->p_classes.table,
>  			                          id);
>  			if (!cladatum) {
> -				sprintf(errormsg, "unknown class %s", id);
> -				yyerror(errormsg);
> +				yyerror2("unknown class %s", id);
>  				goto out;
>  			}
>  
> @@ -4640,9 +4551,8 @@
>  		cladatum = hashtab_search(policydbp->p_classes.table,
>  		                          "process");
>  		if (!cladatum) {
> -			sprintf(errormsg, "could not find process class for "
> -			        "legacy range_transition statement\n");
> -			yyerror(errormsg);
> +			yyerror2("could not find process class for "
> +			         "legacy range_transition statement");
>  			goto out;
>  		}
>  
> @@ -4657,10 +4567,8 @@
>  	for (l = 0; l < 2; l++) {
>  		levdatum = hashtab_search(policydbp->p_levels.table, id);
>  		if (!levdatum) {
> -			sprintf(errormsg,
> -				"unknown level %s used in range_transition "
> -			        "definition", id);
> -			yyerror(errormsg);
> +			yyerror2("unknown level %s used in range_transition "
> +			         "definition", id);
>  			free(id);
>  			goto out;
>  		}
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
