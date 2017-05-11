Subject: Re: [PATCH 5/9] libsepol: Add ibendport ocontext handling
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-6-git-send-email-danielj@mellanox.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <fa60c70b-9be4-ceb5-4ce6-61deaf022889@tycho.nsa.gov>
Date: Thu, 11 May 2017 11:20:40 -0400
MIME-Version: 1.0
In-Reply-To: <1494363042-121766-6-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Like I mentioned for patch 2, kernel_to_cil.c and kernel_to_conf.c need to be 
updated.

Jim

On 05/09/2017 04:50 PM, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add support for reading, writing, and copying IB end port ocontext data.
> Also add support for querying a IB end port sid to checkpolicy.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>   checkpolicy/checkpolicy.c                  |   20 ++++++++++++++
>   libsepol/include/sepol/policydb/services.h |   10 +++++++
>   libsepol/src/expand.c                      |    8 +++++
>   libsepol/src/libsepol.map.in               |    1 +
>   libsepol/src/module_to_cil.c               |   15 ++++++++++
>   libsepol/src/policydb.c                    |   21 +++++++++++++-
>   libsepol/src/services.c                    |   39 ++++++++++++++++++++++++++++
>   libsepol/src/write.c                       |   14 ++++++++++
>   8 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 0f12347..72431d6 100644
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
> @@ -1247,6 +1248,25 @@ int main(int argc, char **argv)
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
> +			sepol_ibendport_sid(0, 0, name, port, &ssid);
> +			printf("sid %d\n", ssid);
> +			free(name);
> +			break;
>   #ifdef EQUIVTYPES
>   		case 'z':
>   			identify_equiv_types();
> diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
> index 2d7aed1..aa8d718 100644
> --- a/libsepol/include/sepol/policydb/services.h
> +++ b/libsepol/include/sepol/policydb/services.h
> @@ -199,6 +199,16 @@ extern int sepol_ibpkey_sid(uint16_t domain,
>   			  sepol_security_id_t *out_sid);
>   
>   /*
> + * Return the SID of the ibendport specified by
> + * `domain', `type', `dev_name', and `port'.
> + */
> +extern int sepol_ibendport_sid(uint16_t domain,
> +			       uint16_t type,
> +			       char *dev_name,
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
> index db3f9c8..4b9f2c8 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2585,6 +2585,7 @@ static int ocontext_selinux_isid_to_cil(struct policydb *pdb, struct ocontext *i
>   		"scmp_packet",
>   		"devnull",
>   		"ibpkey",
> +		"ibendport",
>   		NULL
>   	};
>   
> @@ -2763,6 +2764,19 @@ exit:
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
> @@ -2917,6 +2931,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
>   		ocontext_selinux_fsuse_to_cil,
>   		ocontext_selinux_node6_to_cil,
>   		ocontext_selinux_ibpkey_to_cil,
> +		ocontext_selinux_ibendport_to_cil,
>   	};
>   	static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
>   		ocontext_xen_isid_to_cil,
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 8b76c6a..6c9f2f9 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -198,7 +198,7 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .type = POLICY_KERN,
>   	 .version = POLICYDB_VERSION_INFINIBAND,
>   	 .sym_num = SYM_NUM,
> -	 .ocon_num = OCON_IBPKEY + 1,
> +	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
>   	{
> @@ -303,7 +303,7 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .type = POLICY_BASE,
>   	 .version = MOD_POLICYDB_VERSION_INFINIBAND,
>   	 .sym_num = SYM_NUM,
> -	 .ocon_num = OCON_IBPKEY + 1,
> +	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
>   	{
> @@ -2829,6 +2829,23 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   				    (&c->context[0], p, fp))
>   					return -1;
>   				break;
> +			case OCON_IBENDPORT:
> +				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> +				if (rc < 0)
> +					return -1;
> +				len = le32_to_cpu(buf[0]);
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
> index 39903d1..d4a068a 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1970,6 +1970,45 @@ out:
>   }
>   
>   /*
> + * Return the SID of the subnet management interface specified by
> + * `domain', `type', `device name', and `port'.
> + */
> +int hidden sepol_ibendport_sid(uint16_t domain __attribute__ ((unused)),
> +			       uint16_t type __attribute__ ((unused)),
> +			       char *dev_name,
> +			       uint8_t port,
> +			       sepol_security_id_t *out_sid)
> +{
> +	ocontext_t *c;
> +	int rc = 0;
> +
> +	c = policydb->ocontexts[OCON_IBENDPORT];
> +	while (c) {
> +		if (c->u.ibendport.port == port &&
> +		    !strncmp(dev_name, c->u.ibendport.dev_name, 64))
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
