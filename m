Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KLMvFd016040
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 17:22:58 -0400
Received: by qgfa63 with SMTP id a63so10725101qgf.0
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 14:22:27 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
Date: Wed, 20 May 2015 17:22:25 -0400
Message-ID: <3147722.RboehMiu35@sifl>
In-Reply-To: <1430337372-7758-1-git-send-email-jeffv@google.com>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, April 29, 2015 12:56:12 PM Jeff Vander Stoep wrote:
> Extend the generic ioctl permission check with support for per-command
> filtering. Source/target/class sets including the ioctl permission may
> additionally include a set of commands. Example:
> 
> allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
> auditallow <source> <target>:<class> 0x892A
> 
> When ioctl commands are omitted only the permissions are checked. This
> feature is intended to provide finer granularity for the ioctl
> permission which may be too imprecise in some circumstances. For
> example, the same driver may use ioctls to provide important and
> benign functionality such as driver version or socket type as well as
> dangerous capabilities such as debugging features, read/write/execute
> to physical memory or access to sensitive data. Per-command filtering
> provides a mechanism to reduce the attack surface of the kernel, and
> limit applications to the subset of commands required.
> 
> The format of the policy binary has been modified to include ioctl
> commands, and the policy version number has been incremented to
> POLICYDB_VERSION_IOCTL_OPERATIONS=30 to account for the format change.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

If you haven't already, read my comments on patch 0/2; additional comments 
below ...

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 3c17dda..47918fa 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -22,6 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/skbuff.h>
>  #include <linux/percpu.h>
> +#include <linux/list.h>
>  #include <net/sock.h>
>  #include <linux/un.h>
>  #include <net/af_unix.h>
> @@ -48,6 +49,7 @@ struct avc_entry {
>  	u32			tsid;
>  	u16			tclass;
>  	struct av_decision	avd;
> +	struct avc_operation_node *ops_node;

As I said earlier, I would like to make this avc extension more general.  In 
avc_entry that probably will mean nothing, but I wanted to mention this soon 
in this patch's comments.

>  };
> 
>  struct avc_node {
> @@ -64,6 +66,16 @@ struct avc_cache {
>  	u32			latest_notif;	/* latest revocation notification */
>  };
> 
> +struct avc_operation_decision_node {
> +	struct operation_decision od;
> +	struct list_head od_list;
> +};

Making this more generic may mean adding an extra field here to specify the 
type of extension, e.g. ioctl commands.

> +struct avc_operation_node {
> +	struct operation ops;
> +	struct list_head od_head; /* list of operation_decision_node */
> +};

As mentioned earlier, I think "operation" needs a name change; I tend to like 
"extop" better, e.g. "avc_extop_decision_node" and "avc_extop_node".  Feel 
free to suggest others.

The "operation" struct is named poorly as well; even if we stick with 
"operation" elsewhere we really need to name this one better, it's way too 
generic.

> @@ -367,6 +655,7 @@ static int avc_latest_notif_update(int seqno, int
> is_insert) * @tsid: target security identifier
>   * @tclass: target security class
>   * @avd: resulting av decision
> + * @ops: resulting operation decisions

Parameter in the comment block doesn't match the actual function definition.

> +/*
> + * ioctl commands are comprised of four fields, direction, size, type, and
> + * number. The avc operation logic filters based on two of them:
> + *
> + * type: or code, typically unique to each driver
> + * number: or function
> + *
> + * For example, 0x89 is a socket type, and number 0x27 is the get hardware
> + * address function.
> + */
> +int avc_has_operation(u32 ssid, u32 tsid, u16 tclass, u32 requested,
> +			u16 cmd, struct common_audit_data *ad)
> +{
> +	struct avc_node *node;
> +	struct av_decision avd;
> +	u32 denied;
> +	struct operation_decision *od = NULL;
> +	struct operation_decision od_local;
> +	struct operation_perm allowed;
> +	struct operation_perm auditallow;
> +	struct operation_perm dontaudit;
> +	struct avc_operation_node local_ops_node;
> +	struct avc_operation_node *ops_node;
> +	u8 type = cmd >> 8;
> +	int rc = 0, rc2;
> +
> +	ops_node = &local_ops_node;
> +	BUG_ON(!requested);
> +
> +	rcu_read_lock();
> +
> +	node = avc_lookup(ssid, tsid, tclass);
> +	if (unlikely(!node)) {
> +		node = avc_compute_av(ssid, tsid, tclass, &avd, ops_node);
> +	} else {
> +		memcpy(&avd, &node->ae.avd, sizeof(avd));
> +		ops_node = node->ae.ops_node;
> +	}
> +	/* if operations are not defined, only consider av_decision */
> +	if (!ops_node || !ops_node->ops.len)
> +		goto decision;
> +
> +	od_local.allowed = &allowed;
> +	od_local.auditallow = &auditallow;
> +	od_local.dontaudit = &dontaudit;
> +
> +	/* lookup operation decision */
> +	od = avc_operation_lookup(type, ops_node);
> +	if (unlikely(!od)) {
> +		/* Compute operation decision if type is flagged */
> +		if (!security_operation_test(ops_node->ops.type, type)) {
> +			avd.allowed &= ~requested;
> +			goto decision;
> +		}
> +		rcu_read_unlock();
> +		security_compute_operation(ssid, tsid, tclass, type, &od_local);
> +		rcu_read_lock();
> +		avc_update_node(AVC_CALLBACK_ADD_OPERATION, requested, cmd,
> +				ssid, tsid, tclass, avd.seqno, &od_local, 0);
> +	} else {
> +		avc_quick_copy_operation_decision(cmd, &od_local, od);
> +	}
> +	od = &od_local;
> +
> +	if (!avc_operation_has_perm(od, cmd, OPERATION_ALLOWED))
> +		avd.allowed &= ~requested;
> +
> +decision:
> +	denied = requested & ~(avd.allowed);
> +	if (unlikely(denied))
> +		rc = avc_denied(ssid, tsid, tclass, requested, cmd,
> +				AVC_OPERATION_CMD, &avd);
> +
> +	rcu_read_unlock();
> +
> +	rc2 = avc_operation_audit(ssid, tsid, tclass, requested,
> +			&avd, od, cmd, rc, ad);
> +	if (rc2)
> +		return rc2;
> +	return rc;
> +}

The above function is a good example of what this patchset being very close to 
a general avc expansion with some minor tweaks.  With the exception of the 
ioctl cmd/type encoding/handling it really is generic function; splitting this 
single function into a generic version and an ioctl specific wrapper would be 
a good thing.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4d1a541..0fe64bb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,6 +3239,44 @@ static void selinux_file_free_security(struct file
> *file) file_free_security(file);
>  }
> 
> +/*
> + * Check whether a task has the ioctl permission and cmd
> + * operation to an inode.
> + */
> +int ioctl_has_perm(const struct cred *cred, struct file *file,
> +		u32 requested, u16 cmd)
> +{
> +	struct common_audit_data ad;
> +	struct file_security_struct *fsec = file->f_security;
> +	struct inode *inode = file_inode(file);
> +	struct inode_security_struct *isec = inode->i_security;
> +	struct lsm_ioctlop_audit ioctl;
> +	u32 ssid = cred_sid(cred);
> +	int rc;
> +
> +	ad.type = LSM_AUDIT_DATA_IOCTL_OP;
> +	ad.u.op = &ioctl;
> +	ad.u.op->cmd = cmd;
> +	ad.u.op->path = file->f_path;
> +
> +	if (ssid != fsec->sid) {
> +		rc = avc_has_perm(ssid, fsec->sid,
> +				SECCLASS_FD,
> +				FD__USE,
> +				&ad);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return 0;
> +
> +	rc = avc_has_operation(ssid, isec->sid, isec->sclass,
> +			requested, cmd, &ad);
> +out:
> +	return rc;
> +}

If we generalize things, I imagine we would replace the "avc_has_operation" 
call with something ioctl specific, or maybe an ioctl parameter ... let's see 
where the discussion/investigation takes us.

> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h index d1e0b23..9f4f7cb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -35,13 +35,14 @@
>  #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
>  #define POLICYDB_VERSION_DEFAULT_TYPE	28
>  #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
> +#define POLICYDB_VERSION_IOCTL_OPERATIONS	30
> 
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define
> POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CONSTRAINT_NAMES
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_IOCTL_OPERATIONS
>  #endif
> 
>  /* Mask for just the mount related flags */
> @@ -108,11 +109,40 @@ struct av_decision {
>  	u32 flags;
>  };
> 
> +#define security_operation_set(perms, x) (perms[x >> 5] |= 1 << (x & 0x1f))
> +#define security_operation_test(perms, x) (1 & (perms[x >> 5] >> (x &
> 0x1f)))

See the other comments about "operation" vs. "extop" or similar.

> +
> +struct operation_perm {
> +	u32 perms[8];
> +};

It might be nice to put "8" in a #define somewhere.  Ideally it would be nice 
to make this variable, but likely not worth the effort at this point in time; 
256 bits is fine for ioctls and it makes the code a bit more tidy.

> +struct operation_decision {
> +	u8 type;
> +	u8 specified;
> +	struct operation_perm *allowed;
> +	struct operation_perm *auditallow;
> +	struct operation_perm *dontaudit;
> +};

Beyond the "operation" name discussion, we *need* to find another name for the 
"type" field; it simply carries too many meanings and has special meaning 
within the context of SELinux.

It would also be nice to have some comments here explaining the fields.

> +#define OPERATION_ALLOWED 1
> +#define OPERATION_AUDITALLOW 2
> +#define OPERATION_DONTAUDIT 4
> +#define OPERATION_ALL (OPERATION_ALLOWED | OPERATION_AUDITALLOW |\
> +			OPERATION_DONTAUDIT)
> +struct operation {
> +	u16 len;	/* length of operation decision chain */
> +	u32 type[8];	/* 256 types */
> +};

Name.  Also, I expect this struct will change if we generalize things.

> @@ -429,11 +456,15 @@ int avtab_read_item(struct avtab *a, void *fp, struct
> policydb *pol, printk(KERN_ERR "SELinux: avtab: entry has both access
> vectors and types\n"); return -EINVAL;
>  		}
> +		if (val & AVTAB_OP) {
> +			printk(KERN_ERR "SELinux: avtab: entry has operations\n");
> +			return -EINVAL;
> +		}

Another "operations" vs. "extop" or similar.  If we generalize, it would also 
be nice to know what kind of extended operations, e.g. ioctl commands.

Further, beyond the extension type (ioctl), I think it would be nice to 
include a size value in the binary policy.  With the current ioctl code it 
would be 8/256, but we might want to make this variable in the future and it 
would be nice not to have to bump the policy format again.

-- 
paul moore
www.paul-moore.com
