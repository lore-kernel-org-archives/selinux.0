Date: Fri, 6 Jun 2008 00:49:56 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        John Weeks <John.Weeks@sun.com>
Subject: Re: [patch] selinux:  fix endianness bug in network node address
 handling
In-Reply-To: <1212673731.2763.54.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0806060049500.1677@us.intercode.com.au>
References: <1212673731.2763.54.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Jun 2008, Stephen Smalley wrote:

> Fix an endianness bug in the handling of network node addresses by
> SELinux.  This yields no change on little endian hardware but fixes
> the incorrect handling on big endian hardware.  The network node
> addresses are stored in network order in memory by checkpolicy, not in
> cpu/host order, and thus should not have cpu_to_le32/le32_to_cpu
> conversions applied upon policy write/read unlike other data in the
> policy.
> 
> Bug reported by John Weeks of Sun, who noticed that binary policy
> files built from the same policy source on x86 and sparc differed and
> tracked it down to the ipv4 address handling in checkpolicy.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied.

> 
> ---
> 
>  security/selinux/ss/policydb.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 84f8cc7..2391761 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1478,7 +1478,8 @@ int policydb_read(struct policydb *p, void *fp)
>  	struct ocontext *l, *c, *newc;
>  	struct genfs *genfs_p, *genfs, *newgenfs;
>  	int i, j, rc;
> -	__le32 buf[8];
> +	__le32 buf[4];
> +	u32 nodebuf[8];
>  	u32 len, len2, config, nprim, nel, nel2;
>  	char *policydb_str;
>  	struct policydb_compat_info *info;
> @@ -1749,11 +1750,11 @@ int policydb_read(struct policydb *p, void *fp)
>  					goto bad;
>  				break;
>  			case OCON_NODE:
> -				rc = next_entry(buf, fp, sizeof(u32) * 2);
> +				rc = next_entry(nodebuf, fp, sizeof(u32) * 2);
>  				if (rc < 0)
>  					goto bad;
> -				c->u.node.addr = le32_to_cpu(buf[0]);
> -				c->u.node.mask = le32_to_cpu(buf[1]);
> +				c->u.node.addr = nodebuf[0]; /* network order */
> +				c->u.node.mask = nodebuf[1]; /* network order */
>  				rc = context_read_and_validate(&c->context[0], p, fp);
>  				if (rc)
>  					goto bad;
> @@ -1782,13 +1783,13 @@ int policydb_read(struct policydb *p, void *fp)
>  			case OCON_NODE6: {
>  				int k;
>  
> -				rc = next_entry(buf, fp, sizeof(u32) * 8);
> +				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
>  				if (rc < 0)
>  					goto bad;
>  				for (k = 0; k < 4; k++)
> -					c->u.node6.addr[k] = le32_to_cpu(buf[k]);
> +					c->u.node6.addr[k] = nodebuf[k];
>  				for (k = 0; k < 4; k++)
> -					c->u.node6.mask[k] = le32_to_cpu(buf[k+4]);
> +					c->u.node6.mask[k] = nodebuf[k+4];
>  				if (context_read_and_validate(&c->context[0], p, fp))
>  					goto bad;
>  				break;
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
