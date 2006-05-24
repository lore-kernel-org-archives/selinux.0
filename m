Subject: Re: [PATCH] keys: Kernel access key retention support for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael D Lemay <mdlemay2@cs.uiuc.edu>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov, jmorris@redhat.com
In-Reply-To: <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
References: 
	 <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
Content-Type: text/plain
Date: Wed, 24 May 2006 08:24:52 -0400
Message-Id: <1148473492.24463.318.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-23 at 15:23 -0500, Michael D Lemay wrote:
> The patch below provides SELinux support for the access key retention subsystem of the kernel.  It includes headers from a modified version of the SELinux reference policy, defining a new security class for retained keys.  I haven't modified the securiy hooks that the key subsystem already uses, and I simply introduced the permissions already defined within the key retention subsystem into SELinux: view, read, write, search, link, setattr.  More discussion may be necessary to determine if these permissions and hooks are actually sufficient to provide acceptable security.
> 
> I've tested these changes using the keyutils package distributed by David Howells at http://people.redhat.com/dhowells/keyutils/.  I created a policy module for the refpolicy that will permit sysadm_r to execute the keyctl utility that is provided by keyutils.  If anyone else is interested in that module, just send me a message.
> 
> The first part of the patch introduces a new function for translating
> a binary key permission mask into an explanatory character string.

I don't understand the purpose of this part of the patch, as the
auto-generated headers already map the SELinux permissions to strings
that are displayed by avc_audit() upon a denial (unless suppressed via
dontaudit rule) or upon a granting (if enabled via an auditallow rule).
Why do we need to replicate that functionality?  If there is some valid
reason for it, just display it as a hex value, and don't worry about
mapping it there.

>   The next change is located in the central function that the key
> system uses to perform discretionary and mandatory access control
> authorizations.  It simply bypasses LSM if no permissions have been
> requested.

The first question here is why is that function called at all if the
permission mask is 0?  Some kind of existence test?  Regardless, let
this be handled by the security modules so that they can take different
action if desired, even imposing some kind of check on this trivial
case.  The SELinux hook function itself may immediately return 0 if
there is no information flow involved, but don't put this into the core
kernel.

> From: Michael LeMay <mdlemay2@cs.uiuc.edu>
> 
> Introduce SELinux hooks to support the access key retention subsystem within the kernel.  Extend the key subsystem with a function for translating binary key permissions into an explanatory character string.  Incorporate new flask headers from a modified version of the SELinux reference policy, with support for the new security class representing retained keys.  Fix a minor typing mistake in one comment.
> 
> Signed-off-by: Michael LeMay <mdlemay2@cs.uiuc.edu>

Missing diffstat -p1 output.

> +extern void key_perm_expn (key_perm_t pm, char * buf);

This interface seems prone to overflow (no size argument for bounds
checking).  But I think you can drop it altogether, as the AVC will
already generate a permission string upon any denials as part of the
base avc message, so you don't need to replicate it in the syscall audit
record.

> diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/keys/permission.c linux-2.6.17-rc4-mm1/security/keys/permission.c
> --- linux-2.6.16/security/keys/permission.c	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm1/security/keys/permission.c	2006-05-23 13:51:46.000000000 -0400
> @@ -67,6 +67,10 @@ use_these_perms:
>  	if (kperm != perm)
>  		return -EACCES;
>  
> +	/* no permissions requested, don't need to consult LSM */
> +	if (perm == 0)
> +	  return 0;

As above, do this in the SELinux hook if it is truly valid, not here.
But make sure that no information flow is occurring in this case,
please.

> @@ -567,6 +568,12 @@ void avc_audit(u32 ssid, u32 tsid,
>  		case AVC_AUDIT_DATA_CAP:
>  			audit_log_format(ab, " capability=%d", a->u.cap);
>  			break;
> +		case AVC_AUDIT_DATA_RET_KEY:
> +		  {
> +		        char expn[MAX_KEY_PERM_EXPN_LEN];
> +			key_perm_expn(a->u.ret_key, expn);
> +		        audit_log_format(ab, " key_perm=%s (%08x)", expn, a->u.ret_key);
> +		  } break;

Not clear that this is useful since the AVC itself will log the
permissions that were denied (if not dontaudit) or granted (if
auditallow).

> @@ -4228,6 +4228,55 @@ static int selinux_setprocattr(struct ta
>  	return size;
>  }
>  
> +#ifdef CONFIG_KEYS
> +
> +int selinux_key_alloc (struct key * k) {

Coding style.

> +        struct task_security_struct *tsec = current->security;
> +	struct key_security_struct *ksec;
> +
> +	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
> +	if (!ksec)
> +		return -ENOMEM;
> +
> +	ksec->obj = k;
> +	ksec->sid = tsec->sid;
> +	k->security = ksec;

Is this sufficient, or should we compute a transition SID here (via
security_transition_sid) so that we can apply a derived type to keys
rather than just inheriting the creator's type?  Is a single class
sufficient for all keys, or should we introduce separate key classes per
key type in some manner?

> +	return 0;
> +}
> +
> +void selinux_key_free (struct key * k) {

Coding style.

> +int selinux_key_permission (key_ref_t key_ref,
> +			    struct task_struct *ctx,
> +			    key_perm_t perm) {

Coding style.

> +	int rc;
> +	struct task_security_struct *tsec;
> +	struct avc_audit_data ad;
> +
> +	tsec = ctx->security;
> +
> +	rc = secondary_ops->key_permission(key_ref, ctx, perm);
> +	if (rc)
> +		return rc;

Since there is no capability implementation and the dummy function does
nothing, you can omit this.  I'd actually like to purge the secondary
calls except for the ones that are truly required for capability and
possibly replace those with direct calls to the cap_ functions.

> +	AVC_AUDIT_DATA_INIT(&ad, RET_KEY);
> +	ad.tsk = ctx;
> +	ad.u.ret_key = perm;

Not clear we need to save perm here, as the AVC will audit the denied or
granted permissions for us.

> +	rc = avc_has_perm(tsec->sid, tsec->sid,
> +			    SECCLASS_RETAINED_KEY, perm, &ad);

Wait - you are checking between the task and itself.  But what about the
key SID itself?  We can't assume they are identical, as the key may have
been created by another task.  It seems odd that security_key_permission
is passing a key_ref rather than the key struct itself; at the least, it
should be passing the key->security field to the hook function.

> diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/avc.h linux-2.6.17-rc4-mm1/security/selinux/include/avc.h
> --- linux-2.6.16/security/selinux/include/avc.h	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm1/security/selinux/include/avc.h	2006-05-19 10:14:38.000000000 -0400
> @@ -13,6 +13,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/init.h>
>  #include <linux/in6.h>
> +#include <linux/key.h>
>  #include <asm/system.h>
>  #include "flask.h"
>  #include "av_permissions.h"
> @@ -43,6 +44,7 @@ struct avc_audit_data {
>  #define AVC_AUDIT_DATA_NET  2
>  #define AVC_AUDIT_DATA_CAP  3
>  #define AVC_AUDIT_DATA_IPC  4
> +#define AVC_AUDIT_DATA_RET_KEY  5
>  	struct task_struct *tsk;
>  	union 	{
>  		struct {
> @@ -69,6 +71,7 @@ struct avc_audit_data {
>  		} net;
>  		int cap;
>  		int ipc_id;
> +	        key_perm_t ret_key;
>  	} u;
>  };

Seems like we can drop this altogether.
 
> diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/av_permissions.h linux-2.6.17-rc4-mm1/security/selinux/include/av_permissions.h
> --- linux-2.6.16/security/selinux/include/av_permissions.h	2006-05-23 10:01:55.000000000 -0400
> +++ linux-2.6.17-rc4-mm1/security/selinux/include/av_permissions.h	2006-05-23 13:09:24.000000000 -0400
> @@ -956,3 +956,14 @@
>  #define APPLETALK_SOCKET__SEND_MSG                0x00100000UL
>  #define APPLETALK_SOCKET__NAME_BIND               0x00200000UL
>  
> +#define PACKET__SEND                              0x00000001UL
> +#define PACKET__RECV                              0x00000002UL
> +#define PACKET__RELABELTO                         0x00000004UL

These are already in 2.6.17-rc4-mm3, so you don't need to re-add them.
Just re-base your patch to the latest -mm patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
