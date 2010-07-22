Subject: Re: [PATCH 2/2] SELinux: break ocontext reading into a separate
 function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100721165103.5820.1380.stgit@paris.rdu.redhat.com>
References: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com>
	 <20100721165103.5820.1380.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:46:15 -0400
Message-ID: <1279809975.11197.37.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-07-21 at 12:51 -0400, Eric Paris wrote:
> Move the reading of ocontext type data out of policydb_read() in a separate
> function ocontext_read()
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/ss/policydb.c |  244 ++++++++++++++++++++++------------------
>  1 files changed, 133 insertions(+), 111 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4ea073e..674ddfe 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1901,6 +1901,136 @@ out:
>  	return rc;
>  }
>  
> +static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> +			 void *fp)
> +{
> +	int i, j, rc;
> +	u32 nel, len;
> +	__le32 buf[3];
> +	struct ocontext *l, *c;
> +	u32 nodebuf[8];
> +
> +	for (i = 0; i < info->ocon_num; i++) {
> +		rc = next_entry(buf, fp, sizeof(u32));
> +		if (rc)
> +			goto out;
> +		nel = le32_to_cpu(buf[0]);
> +
> +		l = NULL;
> +		for (j = 0; j < nel; j++) {
> +			rc = -ENOMEM;
> +			c = kzalloc(sizeof(*c), GFP_KERNEL);
> +			if (!c)
> +				goto out;
> +			if (l)
> +				l->next = c;
> +			else
> +				p->ocontexts[i] = c;
> +			l = c;
> +
> +			switch (i) {
> +			case OCON_ISID:
> +				rc = next_entry(buf, fp, sizeof(u32));
> +				if (rc)
> +					goto out;
> +
> +				c->sid[0] = le32_to_cpu(buf[0]);
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			case OCON_FS:
> +			case OCON_NETIF:
> +				rc = next_entry(buf, fp, sizeof(u32));
> +				if (rc)
> +					goto out;
> +				len = le32_to_cpu(buf[0]);
> +
> +				rc = -ENOMEM;
> +				c->u.name = kmalloc(len + 1, GFP_KERNEL);
> +				if (!c->u.name)
> +					goto out;
> +
> +				rc = next_entry(c->u.name, fp, len);
> +				if (rc)
> +					goto out;
> +
> +				c->u.name[len] = 0;
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				rc = context_read_and_validate(&c->context[1], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			case OCON_PORT:
> +				rc = next_entry(buf, fp, sizeof(u32)*3);
> +				if (rc)
> +					goto out;
> +				c->u.port.protocol = le32_to_cpu(buf[0]);
> +				c->u.port.low_port = le32_to_cpu(buf[1]);
> +				c->u.port.high_port = le32_to_cpu(buf[2]);
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			case OCON_NODE:
> +				rc = next_entry(nodebuf, fp, sizeof(u32) * 2);
> +				if (rc)
> +					goto out;
> +				c->u.node.addr = nodebuf[0]; /* network order */
> +				c->u.node.mask = nodebuf[1]; /* network order */
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			case OCON_FSUSE:
> +				rc = next_entry(buf, fp, sizeof(u32)*2);
> +				if (rc)
> +					goto out;
> +
> +				rc = -EINVAL;
> +				c->v.behavior = le32_to_cpu(buf[0]);
> +				if (c->v.behavior > SECURITY_FS_USE_NONE)
> +					goto out;
> +
> +				rc = -ENOMEM;
> +				len = le32_to_cpu(buf[1]);
> +				c->u.name = kmalloc(len + 1, GFP_KERNEL);
> +				if (!c->u.name)
> +					goto out;
> +
> +				rc = next_entry(c->u.name, fp, len);
> +				if (rc)
> +					goto out;
> +				c->u.name[len] = 0;
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			case OCON_NODE6: {
> +				int k;
> +
> +				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
> +				if (rc)
> +					goto out;
> +				for (k = 0; k < 4; k++)
> +					c->u.node6.addr[k] = nodebuf[k];
> +				for (k = 0; k < 4; k++)
> +					c->u.node6.mask[k] = nodebuf[k+4];
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc)
> +					goto out;
> +				break;
> +			}
> +			}
> +		}
> +	}
> +	rc = 0;
> +out:
> +	return rc;
> +}
> +
>  /*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
> @@ -1909,10 +2039,8 @@ int policydb_read(struct policydb *p, void *fp)
>  {
>  	struct role_allow *ra, *lra;
>  	struct role_trans *tr, *ltr;
> -	struct ocontext *l, *c;
>  	int i, j, rc;
>  	__le32 buf[4];
> -	u32 nodebuf[8];
>  	u32 len, nprim, nel;
>  
>  	char *policydb_str;
> @@ -2117,115 +2245,9 @@ int policydb_read(struct policydb *p, void *fp)
>  	if (!p->process_trans_perms)
>  		goto bad;
>  
> -	for (i = 0; i < info->ocon_num; i++) {
> -		rc = next_entry(buf, fp, sizeof(u32));
> -		if (rc < 0)
> -			goto bad;
> -		nel = le32_to_cpu(buf[0]);
> -		l = NULL;
> -		for (j = 0; j < nel; j++) {
> -			c = kzalloc(sizeof(*c), GFP_KERNEL);
> -			if (!c) {
> -				rc = -ENOMEM;
> -				goto bad;
> -			}
> -			if (l)
> -				l->next = c;
> -			else
> -				p->ocontexts[i] = c;
> -			l = c;
> -			rc = -EINVAL;
> -			switch (i) {
> -			case OCON_ISID:
> -				rc = next_entry(buf, fp, sizeof(u32));
> -				if (rc < 0)
> -					goto bad;
> -				c->sid[0] = le32_to_cpu(buf[0]);
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> -				if (rc)
> -					goto bad;
> -				break;
> -			case OCON_FS:
> -			case OCON_NETIF:
> -				rc = next_entry(buf, fp, sizeof(u32));
> -				if (rc < 0)
> -					goto bad;
> -				len = le32_to_cpu(buf[0]);
> -				c->u.name = kmalloc(len + 1, GFP_KERNEL);
> -				if (!c->u.name) {
> -					rc = -ENOMEM;
> -					goto bad;
> -				}
> -				rc = next_entry(c->u.name, fp, len);
> -				if (rc < 0)
> -					goto bad;
> -				c->u.name[len] = 0;
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> -				if (rc)
> -					goto bad;
> -				rc = context_read_and_validate(&c->context[1], p, fp);
> -				if (rc)
> -					goto bad;
> -				break;
> -			case OCON_PORT:
> -				rc = next_entry(buf, fp, sizeof(u32)*3);
> -				if (rc < 0)
> -					goto bad;
> -				c->u.port.protocol = le32_to_cpu(buf[0]);
> -				c->u.port.low_port = le32_to_cpu(buf[1]);
> -				c->u.port.high_port = le32_to_cpu(buf[2]);
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> -				if (rc)
> -					goto bad;
> -				break;
> -			case OCON_NODE:
> -				rc = next_entry(nodebuf, fp, sizeof(u32) * 2);
> -				if (rc < 0)
> -					goto bad;
> -				c->u.node.addr = nodebuf[0]; /* network order */
> -				c->u.node.mask = nodebuf[1]; /* network order */
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> -				if (rc)
> -					goto bad;
> -				break;
> -			case OCON_FSUSE:
> -				rc = next_entry(buf, fp, sizeof(u32)*2);
> -				if (rc < 0)
> -					goto bad;
> -				c->v.behavior = le32_to_cpu(buf[0]);
> -				if (c->v.behavior > SECURITY_FS_USE_NONE)
> -					goto bad;
> -				len = le32_to_cpu(buf[1]);
> -				c->u.name = kmalloc(len + 1, GFP_KERNEL);
> -				if (!c->u.name) {
> -					rc = -ENOMEM;
> -					goto bad;
> -				}
> -				rc = next_entry(c->u.name, fp, len);
> -				if (rc < 0)
> -					goto bad;
> -				c->u.name[len] = 0;
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> -				if (rc)
> -					goto bad;
> -				break;
> -			case OCON_NODE6: {
> -				int k;
> -
> -				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
> -				if (rc < 0)
> -					goto bad;
> -				for (k = 0; k < 4; k++)
> -					c->u.node6.addr[k] = nodebuf[k];
> -				for (k = 0; k < 4; k++)
> -					c->u.node6.mask[k] = nodebuf[k+4];
> -				if (context_read_and_validate(&c->context[0], p, fp))
> -					goto bad;
> -				break;
> -			}
> -			}
> -		}
> -	}
> +	rc = ocontext_read(p, info, fp);
> +	if (rc)
> +		goto bad;
>  
>  	rc = genfs_read(p, fp);
>  	if (rc)
> 
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
