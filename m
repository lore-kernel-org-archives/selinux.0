Date: Wed, 14 Feb 2007 13:10:34 -0500
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Chad Sellers <csellers@tresys.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C1F8BACA.1D17E%csellers@tresys.com>
In-Reply-To: <1171395416.10871.37.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/13/07 2:36 PM, "Eric Paris" <eparis@redhat.com> wrote:

> On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
>> On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> [snip snip]
>>> This is a vestige of the original av padding where I had to be concerned
>>> that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
>>> only use the array when making permission checks I can assume that I
>>> will never get a class from the check greater than the number of kernel
>>> classes defined.  So all that can be simplified to just
>>> p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);
>> 
>> No - security_compute_av can also be called via selinuxfs to check
>> userland security classes (from libselinux for userspace object
>> managers).
> 
> I'm starting to wonder if the entire way I am constructing and using
> using my table might be wrong.  Right now I am finding the permissions
> which are defined in the kernel but are not defined in the policy,
> storing just those select permissions, and then adding those to the
> allow rules.  This works very well when I only consider the kernel and
> don't think about things in userspace.
> 
> But now I ask the question, do we/I want to extend this methodology to
> userspace classes and permissions?  Obviously I wouldn't be able to
> build the 'unknown perms' table for userspace since they are completely
> unknown!  Would it be better if I changed my approach to
> 
> Now:
> avd.allowed |= p->undefined_perms[tclass-1]
> 
> Possible
> avd.allowed |= (p->defined_perms[tclass-1]  ^ 0xffffffff)
> 
Don't you still have the same problem of needing to know what classes and
permissions are defined in the userspace object manager? You still have to
fill out defined_perms for these classes (or you'll just return 0xffffffff
for all userspace classes).

> It's not quite as directed.  Instead of only allowing the select
> permissions which we know are missing from policy we instead shotgun
> approach and allow everything not explicitly defined.  Maybe this allows
> buggy code to get allows which would have been caught and things like
> that, but at least it could work for userspace classes and perms.  Seems
> to me like this undefined perms problem will be worse in userspace than
> it is in the kernel.
> 
> Thoughts?  Or should I just stick with the ideas behind the patch below?
> 
> -Eric
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index cd79c63..364d872 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -670,6 +670,8 @@ void policydb_destroy(struct policydb *p)
> }
> kfree(p->type_attr_map);
>  
> + kfree(p->undefined_perms);
> +
> return;
>  }
>  
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 8319d5f..257b836 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -242,6 +242,8 @@ struct policydb {
> struct ebitmap *type_attr_map;
>  
> unsigned int policyvers;
> +
> + u32 *undefined_perms;
>  };
>  
>  extern void policydb_destroy(struct policydb *p);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ca9154d..a511d75 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -306,22 +306,26 @@ static int context_struct_compute_av(struct context
> *scontext,
>    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> tclass = SECCLASS_NETLINK_SOCKET;
>  
> - if (!tclass || tclass > policydb.p_classes.nprim) {
> -  printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> -         tclass);
> -  return -EINVAL;
> - }
> - tclass_datum = policydb.class_val_to_struct[tclass - 1];
> -
> /*
> * Initialize the access vectors to the default values.
> +  * This will pad the allow for undefined perms if appropriete.
> */
> - avd->allowed = 0;
> avd->decided = 0xffffffff;
> avd->auditallow = 0;
> avd->auditdeny = 0xffffffff;
> avd->seqno = latest_granting;
>  
> + if (tclass > policydb.p_classes.nprim && selinux_allow_unknwon) {
> +  avd->allowed = 0xffffffff;
> +  return 0;
> + } else if (!tclass || tclass > policydb.p_classes.nprim)
> +  return -EINVAL;
> + else if (selinux_allow_unknown)
> +  avd->allowed = policydb.undefined_perms[tclass - 1];
> + else
> +  avd->allowed = 0;
> + tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
> /*
> * If a specific type enforcement rule was defined for
> * this permission check, then use it.
> @@ -1045,6 +1049,17 @@ static int validate_classes(struct policydb *p)
> const char *def_class, *def_perm, *pol_class;
> struct symtab *perms;
>  
> + if (selinux_allow_unknown) {
> +  u32 num_classes;
> +  if (kdefs->cts_len > p->p_classes.nprim)
> +   num_classes = kdefs->cts_len;
> +  else
> +   num_classes = p->p_classes.nprim;
> +  p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);
> +  if (!p->undefined_perms)
> +   return -ENOMEM;
> + }
> +
> for (i = 1; i < kdefs->cts_len; i++) {
> def_class = kdefs->class_to_string[i];
> if (i > p->p_classes.nprim) {
> @@ -1076,14 +1091,18 @@ static int validate_classes(struct policydb *p)
> printk(KERN_INFO
>       "security:  permission %s in class %s not defined in policy\n",
>       def_perm, pol_class);
> +   if (selinux_allow_unknown)
> +    p->undefined_perms[class_val-1] |= perm_val;
> continue;
> }
> perdatum = hashtab_search(perms->table, def_perm);
> if (perdatum == NULL) {
> -   printk(KERN_ERR
> +   printk(KERN_INFO
>       "security:  permission %s in class %s not found in policy\n",
>       def_perm, pol_class);
> -   return -EINVAL;
> +   if (selinux_allow_unknown)
> +    p->undefined_perms[class_val-1] |= perm_val;
> +   continue;
> }
> pol_val = 1 << (perdatum->value - 1);
> if (pol_val != perm_val) {
> @@ -1119,14 +1138,18 @@ static int validate_classes(struct policydb *p)
> printk(KERN_INFO
>       "security:  permission %s in class %s not defined in policy\n",
>       def_perm, pol_class);
> +    if (selinux_allow_unknown)
> +     p->undefined_perms[class_val-1] |= (1 << j);
> continue;
> }
> perdatum = hashtab_search(perms->table, def_perm);
> if (perdatum == NULL) {
> -    printk(KERN_ERR
> +    printk(KERN_INFO
>       "security:  permission %s in class %s not found in policy\n",
>       def_perm, pol_class);
> -    return -EINVAL;
> +    if (selinux_allow_unknown)
> +     p->undefined_perms[class_val-1] |= (1 << j);
> +    continue;
> }
> if (perdatum->value != j + 1) {
> printk(KERN_ERR
> @@ -1268,6 +1291,9 @@ int security_load_policy(void *data, size_t len)
>  
> LOAD_LOCK;
>  
> + /* pay not attention to me as I am part of the /selinux madness!! */
> + selinux_allow_unknown = selinux_allow_unknown_sysctl_value;
> +
> if (!ss_initialized) {
> avtab_cache_init();
> if (policydb_read(&policydb, fp)) {
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 65fb5e8..10af3d0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -86,6 +86,9 @@ extern unsigned int policydb_loaded_version;
>  extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
>  extern int selinux_compat_net;
>  
> +int selinux_allow_unknown = 0;
> +int selinux_allow_unknown_sysctl_value = 0;
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  int selinux_enforcing = 0;
>  
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 6ed10c3..1b02289 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -18,6 +18,9 @@
>  #include "av_permissions.h"
>  #include "security.h"
>  
> +extern int selinux_allow_unknown;
> +extern int selinux_allow_unknown_sysctl_value;
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  extern int selinux_enforcing;
>  #else
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c8bf6e1..67c7810 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -100,6 +100,7 @@ enum sel_inos {
> SEL_MEMBER, /* compute polyinstantiation membership decision */
> SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
> SEL_COMPAT_NET, /* whether to use old compat network packet controls */
> + SEL_UNKNOWN, /* allows unknown perms and classes */
>  };
>  
>  #define TMPBUFLEN 12
> @@ -113,6 +114,16 @@ static ssize_t sel_read_enforce(struct file *filp, char
> __user *buf,
> return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>  }
>  
> +static ssize_t sel_read_unknown(struct file *filp, char __user *buf,
> +    size_t count, loff_t *ppos)
> +{
> + char tmpbuf[TMPBUFLEN];
> + ssize_t length;
> +
> + length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
> selinux_allow_unknown_sysctl_value);
> + return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> +}
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
> size_t count, loff_t *ppos)
> @@ -161,11 +172,55 @@ out:
>  #define sel_write_enforce NULL
>  #endif
>  
> +static ssize_t sel_write_unknown(struct file * file, const char __user * buf,
> +     size_t count, loff_t *ppos)
> +
> +{
> + char *page;
> + ssize_t length;
> + int new_value;
> +
> + if (count >= PAGE_SIZE)
> +  return -ENOMEM;
> + if (*ppos != 0) {
> +  /* No partial writes. */
> +  return -EINVAL;
> + }
> + page = (char*)get_zeroed_page(GFP_KERNEL);
> + if (!page)
> +  return -ENOMEM;
> + length = -EFAULT;
> + if (copy_from_user(page, buf, count))
> +  goto out;
> +
> + length = -EINVAL;
> + if (sscanf(page, "%d", &new_value) != 1)
> +  goto out;
> +
> + if (new_value != selinux_allow_unknown_sysctl_value) {
> +  length = 0;
> +  audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
> +   "allow_unknown=%d old_allow_unknown%d auid=%u", new_value,
> +   selinux_allow_unknown_sysctl_value,
> +   audit_get_loginuid(current->audit_context));
> +  selinux_allow_unknown_sysctl_value = new_value;
> + }
> + length = count;
> +out:
> + free_page((unsigned long) page);
> + return length;
> +}
> +
>  static struct file_operations sel_enforce_ops = {
> .read  = sel_read_enforce,
> .write  = sel_write_enforce,
>  };
>  
> +static struct file_operations sel_unknown_ops = {
> + .read  = sel_read_unknown,
> + .write  = sel_write_unknown,
> +};
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static ssize_t sel_write_disable(struct file * file, const char __user * buf,
> size_t count, loff_t *ppos)
> @@ -1283,6 +1338,7 @@ static int sel_fill_super(struct super_block * sb, void
> * data, int silent)
> [SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
> [SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
> [SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
> +  [SEL_UNKNOWN] = {"allow_unknown", &sel_unknown_ops, S_IRUGO|S_IWUSR},
> /* last one */ {""}
> };
> ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
