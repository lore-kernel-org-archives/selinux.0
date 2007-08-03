Subject: Re: [PATCH][RFC] V1 Remove SELinux dependencies from linux-audit
	via LSM
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
In-Reply-To: <600616.50420.qm@web36614.mail.mud.yahoo.com>
References: <600616.50420.qm@web36614.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 09:09:03 -0400
Message-Id: <1186146543.2434.220.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 20:33 -0700, Casey Schaufler wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> This patch removes SELinux specific code from the kernel auditing
> system, replacing it with LSM hook invocations that perform the
> functions appropriate to those behaviors.

(patch was whitespace damaged)

> The LSM interface is extended to provide interfaces for a module
> to add audit filters. Interfaces are added to get secids from
> inodes and ipcs.
> 
> The audit code is revised to call these hooks instead of the SELinux
> functions. This requires some structure definitions to change header
> files.
> 
> The SELinux code is changed to export the old interfaces as LSM hooks
> instead of doing so directly. The SELinux specific audit filter code
> has been moved into the SELinux module.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> ---

Missing diffstat -p1 output.

> I hope for some suggestions regarding how appropriate the header file
> changes I've made are. My confidence level in them is fairly low. Also,
> in my haste to get some feedback the testing has been limited. There
> are three projects (SELinux, audit, and LSM) whose code I've changed,
> and I expect there may be differences of opinion about what's right,
> what's wrong, and how to go about reconciling the differences. I see
> this as the start.
> 
> Thank you.
> 

> diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> linux-2.6.22-base/include/linux/security.h
> linux-2.6.22-audit/include/linux/security.h
> --- linux-2.6.22-base/include/linux/security.h	2007-07-08 16:32:17.000000000
> -0700
> +++ linux-2.6.22-audit/include/linux/security.h	2007-08-01 20:14:18.000000000
> -0700
> @@ -35,6 +35,8 @@
>  #include <net/flow.h>
>  
>  struct ctl_table;
> +struct audit_krule;
> +struct selinux_audit_rule;

selinux_audit_rule in LSM interface?
 
>  /*
>   * These functions are in security/capability.c and are used
> @@ -1328,6 +1330,16 @@ struct security_operations {
>   	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t
> size);
>  	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
>  	void (*release_secctx)(char *secdata, u32 seclen);
> +	void (*inode_getsecid) (const struct inode *inode, u32 *secid);
> +	void (*ipc_getsecid) (struct kern_ipc_perm *p, u32 *secid);
> +	int (*audit_rule_supplied) (struct audit_krule *rule);
> +	int (*audit_rule_match) (u32 sid, u32 field, u32 op,
> +                          	 struct selinux_audit_rule *rule,

Ditto.

> +                      	         struct audit_context *actx);
> +	int (*audit_rule_init) (u32 field, u32 op, char *rulestr,
> +                                struct selinux_audit_rule **rule);
> +	void (*audit_rule_free) (struct selinux_audit_rule *rule);
> +
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect) (struct socket * sock,

> diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> linux-2.6.22-base/kernel/audit.c linux-2.6.22-audit/kernel/audit.c
> --- linux-2.6.22-base/kernel/audit.c	2007-07-08 16:32:17.000000000 -0700
> +++ linux-2.6.22-audit/kernel/audit.c	2007-08-01 12:16:36.000000000 -0700
> @@ -252,7 +252,7 @@ static int audit_set_rate_limit(int limi
>  	if (sid) {
>  		char *ctx = NULL;
>  		u32 len;
> -		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
> +		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
>  			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
>  				"audit_rate_limit=%d old=%d by auid=%u"
>  				" subj=%s res=%d",

If you do that, then you also need to use security_secctx_release() to
free ctx rather than direct kfree.

Also, the sid passed to this (and other functions) came from
NETLINK_CB(skb).sid, which was set by netlink_sendmsg() with a direct
call to selinux_get_task_sid.  So if you convert these calls to using
LSM hooks w/o changing netlink to do likewise, you could end up with a
mismatch (sid provided by selinux, defaulting to 0 when selinux
disabled; secid_to_secctx hook provided by your module).

> diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> linux-2.6.22-base/kernel/auditfilter.c linux-2.6.22-audit/kernel/auditfilter.c
> --- linux-2.6.22-base/kernel/auditfilter.c	2007-07-08 16:32:17.000000000 -0700
> +++ linux-2.6.22-audit/kernel/auditfilter.c	2007-08-01 20:22:36.000000000 -0700
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/inotify.h>
>  #include <linux/selinux.h>
> +#include <linux/security.h>

Shouldn't you be removing #include <linux/selinux.h> from all of the
audit code?  That will help you catch all lingering references to
selinux-specific references as well.

> @@ -1210,7 +1211,8 @@ static inline int audit_add_rule(struct 
>  	struct audit_entry *e;
>  	struct audit_field *inode_f = entry->rule.inode_f;
>  	struct audit_watch *watch = entry->rule.watch;
> -	struct nameidata *ndp, *ndw;
> +	struct nameidata *ndp = NULL;
> +	struct nameidata *ndw = NULL;

Not related to your changes, and seems to already be present in git (but
without splitting into two lines).

> diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> linux-2.6.22-base/security/selinux/hooks.c
> linux-2.6.22-audit/security/selinux/hooks.c
> --- linux-2.6.22-base/security/selinux/hooks.c	2007-07-08 16:32:17.000000000
> -0700
> +++ linux-2.6.22-audit/security/selinux/hooks.c	2007-08-01 21:42:32.000000000
> -0700
> @@ -4838,6 +4862,12 @@ static struct security_operations selinu
>  
>  	.secid_to_secctx =		selinux_secid_to_secctx,
>  	.release_secctx =		selinux_release_secctx,
> +	.inode_getsecid =		selinux_get_inode_sid,
> +	.ipc_getsecid = 		selinux_get_ipc_sid,
> +	.audit_rule_supplied = 		selinux_audit_rule_supplied,
> +	.audit_rule_match = 		selinux_audit_rule_match,
> +	.audit_rule_init = 		selinux_audit_rule_init,
> +	.audit_rule_free = 		selinux_audit_rule_free,

So I'd then expect you to also remove the function prototypes from
include/linux/selinux.h unless there is some other caller, and move the
functions from selinux/exports.c to selinux/hooks.c and make them
static.  And drop the selinux_enabled check from them, as the hook
function will only be registered if SELinux is enabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
