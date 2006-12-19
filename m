Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
        Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1166562934.20187.87.camel@localhost.localdomain>
References: <1166562934.20187.87.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 16:34:56 -0500
Message-Id: <1166564096.30579.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-19 at 16:15 -0500, Eric Paris wrote:
> The following patch goes through SELinux code and demotes a number of
> printk from KERN_INFO to KERN_DEBUG.  This still leaves a number of
> KERN_INFO inside security/selinux which are listed below.  If anyone
> feels that any (all?) of those should be demoted as well just let me
> know and i'll post another patch.
> 
> hooks.c: printk(KERN_INFO "%s:  There is already a secondary security "

Possibly this should be KERN_ERR.  Or dropped.

> hooks.c: printk(KERN_INFO "%s:  Registering secondary module %s\n",

I'd keep this one as KERN_INFO or turn it into an audit message.

> hooks.c: printk(KERN_INFO "%s:  trying to unregister a security module "

KERN_ERR or drop.

> hooks.c: printk(KERN_INFO "SELinux:  Disabled at boot.\n");

Keep as KERN_INFO or turn it into an audit message.  Corresponds to
booting with selinux=0.

> hooks.c: printk(KERN_INFO "SELinux:  Initializing.\n");
> hooks.c: printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
> hooks.c: printk(KERN_INFO "SELinux:  Starting in permissive mode\n");

I'd turn the above three messages into KERN_DEBUG messages.

> hooks.c: printk(KERN_INFO "SELinux:  Disabled at runtime.\n");

Keep as KERN_INFO or turn into audit.  Corresponds to SELINUX=disabled
in /etc/selinux/config or equivalent (e.g. boot with init=/bin/bash and
write to /selinux/disable).

> ss/avtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- wrapped in DEBUG_HASHES
> ss/policydb.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, " <- wrapped in DEBUG_HASHES

KERN_DEBUG.

> ss/policydb.c: printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
> ss/policydb.c: printk(KERN_INFO "security:  %d classes, %d rules\n",

Not sure.  Possibly KERN_DEBUG.

> ss/services.c: printk(KERN_INFO <- missing class definitions in policy
> ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
> ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy

Possibly an audit message?

> ss/sidtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- inside #if 0

KERN_DEBUG or drop.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 65fb5e8..e7cc553 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -654,11 +654,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
>  	sbsec->initialized = 1;
>  
>  	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
> -		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), unknown behavior\n",
> +		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), unknown behavior\n",
>  		       sb->s_id, sb->s_type->name);

This one should actually be KERN_ERR, I suspect.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
