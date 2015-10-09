Subject: Re: [RFC PATCH v3 4/5] selinux: introduce kdbus names into the policy
To: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230842.7823.70790.stgit@localhost>
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5617ED9E.4030701@tycho.nsa.gov>
Date: Fri, 9 Oct 2015 12:38:54 -0400
MIME-Version: 1.0
In-Reply-To: <20151007230842.7823.70790.stgit@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/07/2015 07:08 PM, Paul Moore wrote:
> SELinux treats kdbus service names as objects and therefore needs a
> mechanism to map service names to security labels.  This patch adds
> support for loading kdbus name/label matches with the security policy.
>
> The patch supports service name prefix matching to lessen the burden
> on the policy developers and reduce the size of the resulting policy.
>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
>
> ---
> ChangeLog:
> - v3
>   * Ported to the 4.3-rc4 based kdbus tree, v2 hacks removed
> - v2
>   * Porting needed to work with ioctl xperms
> - v1
>   * Initial draft
> ---
>   security/selinux/include/security.h |    5 ++
>   security/selinux/ss/policydb.c      |   88 +++++++++++++++++++++++++++++------
>   security/selinux/ss/policydb.h      |    3 +
>   security/selinux/ss/services.c      |   38 +++++++++++++++
>   4 files changed, 116 insertions(+), 18 deletions(-)
>

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 992a315..9be2e6d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2111,7 +2116,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   	int i, j, rc;
>   	u32 nel, len;
>   	__le32 buf[3];
> -	struct ocontext *l, *c;
> +	struct ocontext *l, *l2, *c;
>   	u32 nodebuf[8];
>
>   	for (i = 0; i < info->ocon_num; i++) {
> @@ -2130,6 +2135,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				l->next = c;
>   			else
>   				p->ocontexts[i] = c;
> +			l2 = l;
>   			l = c;
>
>   			switch (i) {
> @@ -2219,6 +2225,43 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   					goto out;
>   				break;
>   			}
> +			case OCON_KDBUS: {
> +				struct ocontext *iter, *last;
> +				u32 len2;
> +
> +				rc = next_entry(buf, fp, sizeof(u32));
> +				if (rc)
> +					goto out;
> +				len = le32_to_cpu(buf[0]);
> +				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
> +				if (rc)
> +					goto out;
> +				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (rc) {
> +					kfree(c->u.name);
> +					goto out;
> +				}
> +
> +				/* sort by ->u.name length, longest first */
> +				last = NULL;
> +				iter = p->ocontexts[OCON_KDBUS];
> +				while (iter != c) {
> +					len2 = strlen(iter->u.name);
> +					if (len > len2) {
> +						if (l2)
> +							l2->next = NULL;
> +						c->next = iter;
> +						if (last == NULL)
> +							p->ocontexts[i] = c;
> +						else
> +							last->next = c;
> +						break;
> +					}
> +					last = iter;
> +					iter = iter->next;
> +				}
> +				break;

This seems complicated compared to genfs_read() due to the fact that 
ocontext_read() pre-inserts node into the list.  Maybe we should change 
ocontext_read() to defer insertion until after the switch statement, and 
then we don't have to un-link and re-link these entries?

> +			}
>   			}
>   		}
>   	}
> @@ -3147,6 +3190,19 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					return rc;
>   				break;
> +			case OCON_KDBUS:
> +				len = strlen(c->u.name);
> +				buf[0] = cpu_to_le32(len);
> +				rc = put_entry(buf, sizeof(u32), 1, fp);
> +				if (rc)
> +					return rc;
> +				rc = put_entry(c->u.name, len, 1, fp);
> +				if (rc)
> +					return rc;
> +				rc = context_write(p, &c->context[0], fp);
> +				if (rc)
> +					return rc;
> +				break;
>   			}
>   		}
>   	}
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 725d594..ee9c120 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -222,7 +222,8 @@ struct genfs {
>   #define OCON_NODE  4	/* nodes */
>   #define OCON_FSUSE 5	/* fs_use */
>   #define OCON_NODE6 6	/* IPv6 nodes */
> -#define OCON_NUM   7
> +#define OCON_KDBUS 7	/* kdbus names */
> +#define OCON_NUM   8
>
>   /* The policy database */
>   struct policydb {
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b7df12b..ada2d28 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2536,6 +2536,44 @@ int security_genfs_sid(const char *fstype,
>   }
>
>   /**
> + * security_kdbus_sid - Obtain a SID for a kdbus name
> + * @name: kdbus name
> + * @sid: SID for the kdbus name
> + *
> + * Obtain a SID for the given kdbus service name.  Returns zero on success,
> + * negative values on error.
> + */
> +int security_kdbus_sid(const char *name, u32 *sid)
> +{
> +	int rc = 0;
> +	struct ocontext *c;
> +
> +	read_lock(&policy_rwlock);
> +
> +	c = policydb.ocontexts[OCON_KDBUS];
> +	while (c) {
> +		if (strncmp(c->u.name, name, strlen(c->u.name)) == 0)
> +			break;
> +		c = c->next;
> +	}
> +
> +	if (c) {
> +		if (!c->sid[0]) {
> +			rc = sidtab_context_to_sid(&sidtab,
> +						   &c->context[0], &c->sid[0]);
> +			if (rc)
> +				goto out;
> +		}
> +		*sid = c->sid[0];
> +	} else
> +		*sid = SECINITSID_UNLABELED;
> +
> +out:
> +	read_unlock(&policy_rwlock);
> +	return rc;
> +}
> +
> +/**
>    * security_fs_use - Determine how to handle labeling for a filesystem.
>    * @sb: superblock in question
>    */
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
