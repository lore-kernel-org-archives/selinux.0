Subject: Re: [PATCH v1 5/9] libsepol: Add ibendport ocontext handling
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-6-git-send-email-danielj@mellanox.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <9a91f584-5ca4-9122-21fe-e395e8df4508@tycho.nsa.gov>
Date: Wed, 17 May 2017 09:54:22 -0400
MIME-Version: 1.0
In-Reply-To: <1494880961-73481-6-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2017 04:42 PM, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add support for reading, writing, and copying IB end port ocontext data.
> Also add support for querying a IB end port sid to checkpolicy.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> 
> ---
> v1:
> Stephen Smalley:
> - Removed unused domain and type params from sepol_ibendport_sid.
> - Remove ibendport initial sid from ocontext_selinux_isid_to_cil
> - Check the length provide for the device name in ocontext_read_selinux
> - Used strcmp for dev_name comparison.
> 
> James Carter:
> - Added ibendport handling to kernel_to_cil.c and kernel_to_conf.c
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>   checkpolicy/checkpolicy.c                  | 20 ++++++++++++++
>   libsepol/include/sepol/policydb/services.h |  8 ++++++
>   libsepol/src/expand.c                      |  8 ++++++
>   libsepol/src/kernel_to_cil.c               | 42 ++++++++++++++++++++++++++++++
>   libsepol/src/kernel_to_conf.c              | 41 +++++++++++++++++++++++++++++
>   libsepol/src/libsepol.map.in               |  1 +
>   libsepol/src/module_to_cil.c               | 14 ++++++++++
>   libsepol/src/policydb.c                    | 26 +++++++++++++++---
>   libsepol/src/services.c                    | 37 ++++++++++++++++++++++++++
>   libsepol/src/write.c                       | 14 ++++++++++
>   10 files changed, 208 insertions(+), 3 deletions(-)
> 
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index d0e46ba..94bf083 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -701,6 +701,7 @@ int main(int argc, char **argv)
>   	printf("i)  display constraint expressions\n");
>   	printf("j)  display validatetrans expressions\n");
>   	printf("k)  Call ibpkey_sid\n");
> +	printf("l)  Call ibendport_sid\n");
>   #ifdef EQUIVTYPES
>   	printf("z)  Show equivalent types\n");
>   #endif
> @@ -1245,6 +1246,25 @@ int main(int argc, char **argv)
>   				printf("sid %d\n", ssid);
>   			}
>   			break;
> +		case 'l':
> +			printf("device name (eg. mlx4_0)?  ");
> +			FGETS(ans, sizeof(ans), stdin);
> +			ans[strlen(ans) - 1] = 0;
> +
> +			name = malloc((strlen(ans) + 1) * sizeof(char));
> +			if (!name) {
> +				fprintf(stderr, "couldn't malloc string.\n");
> +				break;
> +			}
> +			strcpy(name, ans);
> +
> +			printf("port? ");
> +			FGETS(ans, sizeof(ans), stdin);
> +			port = atoi(ans);
> +			sepol_ibendport_sid(name, port, &ssid);
> +			printf("sid %d\n", ssid);
> +			free(name);
> +			break;
>   #ifdef EQUIVTYPES
>   		case 'z':
>   			identify_equiv_types();
> diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
> index 459254e..e4f2f11 100644
> --- a/libsepol/include/sepol/policydb/services.h
> +++ b/libsepol/include/sepol/policydb/services.h
> @@ -196,6 +196,14 @@ extern int sepol_ibpkey_sid(void *subnet_prefix_p,
>   			    sepol_security_id_t *out_sid);
>   
>   /*
> + * Return the SID of the ibendport specified by
> + * `dev_name', and `port'.
> + */
> +extern int sepol_ibendport_sid(char *dev_name,
> +			       uint8_t port,
> +			       sepol_security_id_t *out_sid);
> +
> +/*
>    * Return the SIDs to use for a network interface
>    * with the name `name'.  The `if_sid' SID is returned for
>    * the interface and the `msg_sid' SID is returned as
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index c45ecbe..061945e 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2226,6 +2226,14 @@ static int ocontext_copy_selinux(expand_state_t *state)
>   				n->u.ibpkey.low_pkey = c->u.ibpkey.low_pkey;
>   				n->u.ibpkey.high_pkey = c->u.ibpkey.high_pkey;
>   			break;
> +			case OCON_IBENDPORT:
> +				n->u.ibendport.dev_name = strdup(c->u.ibendport.dev_name);
> +				if (!n->u.ibendport.dev_name) {
> +					ERR(state->handle, "Out of memory!");
> +					return -1;
> +				}
> +				n->u.ibendport.port = c->u.ibendport.port;
> +				break;
>   			case OCON_PORT:
>   				n->u.port.protocol = c->u.port.protocol;
>   				n->u.port.low_port = c->u.port.low_port;
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index fcfd0e0..6587ff4 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2837,6 +2837,43 @@ exit:
>   	return rc;
>   }
>   
> +static int write_selinux_ibendport_rules_to_cil(FILE *out, struct policydb *pdb)
> +{
> +	struct ocontext *ibendportcon;
> +	char port_str[4];
> +	char *ctx;
> +	int rc = 0;
> +
> +	for (ibendportcon = pdb->ocontexts[OCON_IBENDPORT];
> +	     ibendportcon != NULL; ibendportcon = ibendportcon->next) {
> +		rc = snprintf(port_str, 4, "%u", ibendportcon->u.ibendport.port);
> +		if (rc < 0 || rc >= 4) {
> +			rc = -1;
> +			goto exit;
> +		}
> +
> +		ctx = context_to_str(pdb, &ibendportcon->context[0]);
> +		if (!ctx) {
> +			rc = -1;
> +			goto exit;
> +		}
> +
> +		sepol_printf(out, "(ibendportcon %s %s %s)\n",
> +			     ibendportcon->u.ibendport.dev_name, port_str, ctx);
> +
> +		free(ctx);
> +	}
> +
> +	rc = 0;
> +
> +exit:
> +	if (rc != 0) {
> +		sepol_log_err("Error writing ibendportcon rules to CIL\n");
> +	}
> +
> +	return rc;
> +}
> +

You need to have the ibendport rules sorted like I mentioned for ibpkey in patch 2.

Jim

>   static int write_xen_isid_rules_to_cil(FILE *out, struct policydb *pdb)
>   {
>   	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str);
> @@ -3238,6 +3275,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
>   		if (rc != 0) {
>   			goto exit;
>   		}
> +
> +		rc = write_selinux_ibendport_rules_to_cil(out, pdb);
> +		if (rc != 0) {
> +			goto exit;
> +		}
>   	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
>   		rc = write_xen_isid_rules_to_cil(out, pdb);
>   		if (rc != 0) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 795cf56..ba261cf 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2699,6 +2699,42 @@ exit:
>   	return rc;
>   }
>   
> +static int write_selinux_ibendport_rules_to_conf(FILE *out, struct policydb *pdb)
> +{
> +	struct ocontext *ibendportcon;
> +	char port_str[4];
> +	char *ctx;
> +	int rc = 0;
> +
> +	for (ibendportcon = pdb->ocontexts[OCON_IBENDPORT];
> +	     ibendportcon != NULL; ibendportcon = ibendportcon->next) {
> +		rc = snprintf(port_str, 4, "%u", ibendportcon->u.ibendport.port);
> +		if (rc < 0 || rc >= 4) {
> +			rc = -1;
> +			goto exit;
> +		}
> +
> +		ctx = context_to_str(pdb, &ibendportcon->context[0]);
> +		if (!ctx) {
> +			rc = -1;
> +			goto exit;
> +		}
> +
> +		sepol_printf(out, "ibendportcon %s %s %s\n", ibendportcon->u.ibendport.dev_name, port_str, ctx);
> +
> +		free(ctx);
> +	}
> +
> +	rc = 0;
> +
> +exit:
> +	if (rc != 0) {
> +		sepol_log_err("Error writing ibendportcon rules to policy.conf\n");
> +	}
> +
> +	return rc;
> +}
> +
>   static int write_xen_isid_rules_to_conf(FILE *out, struct policydb *pdb)
>   {
>   	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str);
> @@ -3104,6 +3140,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
>   		if (rc != 0) {
>   			goto exit;
>   		}
> +
> +		rc = write_selinux_ibendport_rules_to_conf(out, pdb);
> +		if (rc != 0) {
> +			goto exit;
> +		}
>   	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
>   		rc = write_xen_isid_rules_to_conf(out, pdb);
>   		if (rc != 0) {
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 36225d1..dd1fec2 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -7,6 +7,7 @@ LIBSEPOL_1.0 {
>   	sepol_iface_*;
>   	sepol_port_*;
>   	sepol_ibpkey_*;
> +	sepol_ibendport_*;
>   	sepol_node_*;
>   	sepol_user_*; sepol_genusers; sepol_set_delusers;
>   	sepol_msg_*; sepol_debug;
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index c97f453..04394f0 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2773,6 +2773,19 @@ exit:
>   	return rc;
>   }
>   
> +static int ocontext_selinux_ibendport_to_cil(struct policydb *pdb, struct ocontext *ibendports)
> +{
> +	struct ocontext *ibendport;
> +
> +	for (ibendport = ibendports; ibendport; ibendport = ibendport->next) {
> +		cil_printf("(ibendportcon %s %u ", ibendport->u.ibendport.dev_name, ibendport->u.ibendport.port);
> +		context_to_cil(pdb, &ibendport->context[0]);
> +
> +		cil_printf(")\n");
> +	}
> +
> +	return 0;
> +}
>   
>   static int ocontext_selinux_fsuse_to_cil(struct policydb *pdb, struct ocontext *fsuses)
>   {
> @@ -2927,6 +2940,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
>   		ocontext_selinux_fsuse_to_cil,
>   		ocontext_selinux_node6_to_cil,
>   		ocontext_selinux_ibpkey_to_cil,
> +		ocontext_selinux_ibendport_to_cil,
>   	};
>   	static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
>   		ocontext_xen_isid_to_cil,
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index d6e8e6f..9a11d45 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -190,7 +190,7 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .type = POLICY_KERN,
>   	 .version = POLICYDB_VERSION_INFINIBAND,
>   	 .sym_num = SYM_NUM,
> -	 .ocon_num = OCON_IBPKEY + 1,
> +	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
>   	{
> @@ -295,7 +295,7 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .type = POLICY_BASE,
>   	 .version = MOD_POLICYDB_VERSION_INFINIBAND,
>   	 .sym_num = SYM_NUM,
> -	 .ocon_num = OCON_IBPKEY + 1,
> +	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
>   	{
> @@ -2788,7 +2788,7 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   				if (rc < 0)
>   					return -1;
>   				len = le32_to_cpu(buf[0]);
> -				if (zero_or_saturated(len))
> +				if (zero_or_saturated(len) || len > 63)
>   					return -1;
>   				c->u.name = malloc(len + 1);
>   				if (!c->u.name)
> @@ -2819,6 +2819,26 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   				    (&c->context[0], p, fp))
>   					return -1;
>   				break;
> +			case OCON_IBENDPORT:
> +				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> +				if (rc < 0)
> +					return -1;
> +				len = le32_to_cpu(buf[0]);
> +				if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
> +					return -1;
> +
> +				c->u.ibendport.dev_name = malloc(len + 1);
> +				if (!c->u.ibendport.dev_name)
> +					return -1;
> +				rc = next_entry(c->u.ibendport.dev_name, fp, len);
> +				if (rc < 0)
> +					return -1;
> +				c->u.ibendport.dev_name[len] = 0;
> +				c->u.ibendport.port = le32_to_cpu(buf[1]);
> +				if (context_read_and_validate
> +				    (&c->context[0], p, fp))
> +					return -1;
> +				break;
>   			case OCON_PORT:
>   				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
>   				if (rc < 0)
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 4236aac..f444f10 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1962,6 +1962,43 @@ out:
>   }
>   
>   /*
> + * Return the SID of the subnet management interface specified by
> + * `device name', and `port'.
> + */
> +int hidden sepol_ibendport_sid(char *dev_name,
> +			       uint8_t port,
> +			       sepol_security_id_t *out_sid)
> +{
> +	ocontext_t *c;
> +	int rc = 0;
> +
> +	c = policydb->ocontexts[OCON_IBENDPORT];
> +	while (c) {
> +		if (c->u.ibendport.port == port &&
> +		    !strcmp(dev_name, c->u.ibendport.dev_name))
> +			break;
> +		c = c->next;
> +	}
> +
> +	if (c) {
> +		if (!c->sid[0]) {
> +			rc = sepol_sidtab_context_to_sid(sidtab,
> +							 &c->context[0],
> +							 &c->sid[0]);
> +			if (rc)
> +				goto out;
> +		}
> +		*out_sid = c->sid[0];
> +	} else {
> +		*out_sid = SECINITSID_UNLABELED;
> +	}
> +
> +out:
> +	return rc;
> +}
> +
> +
> +/*
>    * Return the SID of the port specified by
>    * `domain', `type', `protocol', and `port'.
>    */
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index fa1b7d1..e3ff389 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1426,6 +1426,20 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
>   				if (context_write(p, &c->context[0], fp))
>   					return POLICYDB_ERROR;
>   				break;
> +			case OCON_IBENDPORT:
> +				len = strlen(c->u.ibendport.dev_name);
> +				buf[0] = cpu_to_le32(len);
> +				buf[1] = cpu_to_le32(c->u.ibendport.port);
> +				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> +				if (items != 2)
> +					return POLICYDB_ERROR;
> +				items = put_entry(c->u.ibendport.dev_name, 1, len, fp);
> +				if (items != len)
> +					return POLICYDB_ERROR;
> +
> +				if (context_write(p, &c->context[0], fp))
> +					return POLICYDB_ERROR;
> +				break;
>   			case OCON_PORT:
>   				buf[0] = c->u.port.protocol;
>   				buf[1] = c->u.port.low_port;
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
