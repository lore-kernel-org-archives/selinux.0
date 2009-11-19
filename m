Message-ID: <4B05C148.2080605@redhat.com>
Date: Thu, 19 Nov 2009 17:06:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: selinux@tycho.nsa.gov, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Subject: Re: [PATCH] kernel: Dynamic port labeling
References: <1258657635.2753.8.camel@moss-stripedbass.epoch.ncsc.mil>
In-Reply-To: <1258657635.2753.8.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/19/2009 02:07 PM, Paul Nuzzi wrote:
> Added a mechanism to add/delete/update port labels with an interface in 
> the selinuxfs filesystem.  This will give administrators the ability to
> update port labels faster than reloading the entire policy with
> semanage.  The administrator will also need less privilege since they
> don't have to be authorized to reload the full policy. Let me know what
> you think of the patch.  Not sure if the policy_rwlock semaphore needs
> to be taken before modifying the ocontext list. 
> 
> A listing of all port labels will be output if the file /selinux/rw_port
> is read.  Labels could be added or deleted with the following commands 
> 
> echo -n "del system_u:object_r:ssh_port_t:s0 6 22" > /selinux/rw_port
> echo -n "add system_u:object_r:telnetd_port_t:s0 6 22" > /selinux/rw_port
> 
> 
The problem with this type of interface is that it effects name_connect and name_bind.

If I had client policy written to allow ssh_t to connect to port ssh_port_t (22), but I wanted sshd_t to listen on port 23,
Your change blows up one or the other app.

What we really need is port labels based on direction.  Or label every port and allow me to define attributes that group ports.

inbount_ssh_port and outbound_ssh_port

> Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
> 
> ---
>  security/selinux/hooks.c            |    1
>  security/selinux/include/classmap.h |    2
>  security/selinux/include/security.h |    9 ++
>  security/selinux/selinuxfs.c        |   96 +++++++++++++++++++++
>  security/selinux/ss/services.c      |  159 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 265 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c96d63e..db40101 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1224,7 +1224,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  	struct inode_security_struct *isec = inode->i_security;
>  	u32 sid;
>  	struct dentry *dentry;
> -#define INITCONTEXTLEN 255
>  	char *context = NULL;
>  	unsigned len = 0;
>  	int rc = 0;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 8b32e95..41baed8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -16,7 +16,7 @@ struct security_class_mapping secclass_map[] = {
>  	  { "compute_av", "compute_create", "compute_member",
>  	    "check_context", "load_policy", "compute_relabel",
>  	    "compute_user", "setenforce", "setbool", "setsecparam",
> -	    "setcheckreqprot", NULL } },
> +	    "setcheckreqprot", "rw_port", NULL } },
>  	{ "process",
>  	  { "fork", "transition", "sigchld", "sigkill",
>  	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 2553266..ce8e8a6 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -169,6 +169,15 @@ int security_fs_use(const char *fstype, unsigned int *behavior,
>  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
>  
> +int security_ocon_port_add(u32 protocol, u32 low, u32 high, u32 sid,
> +			   char *scontext);
> +
> +int security_ocon_port_del(u32 protocol, u32 low, u32 high, u32 sid,
> +			   char *scontext);
> +
> +int security_ocon_port_read(char **buf);
> +#define INITCONTEXTLEN 255
> +
>  #ifdef CONFIG_NETLABEL
>  int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index fab36fd..e52d81e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -110,6 +110,7 @@ enum sel_inos {
>  	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
>  	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
>  	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
> +	SEL_OCON_PORT,  /* add OCON_PORT to the list */
>  	SEL_INO_NEXT,	/* The next inode number to use */
>  };
>  
> @@ -253,6 +254,100 @@ static const struct file_operations sel_disable_ops = {
>  	.write		= sel_write_disable,
>  };
>  
> +static ssize_t sel_write_ocon_port(struct file *file, const char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	ssize_t length;
> +	unsigned long low = 0, high = 0, protocol = 0;
> +	char *page, *scontext, *command;
> +	u32 sid;
> +#define OCONCOMMANDLEN 4
> +#define OCON_ADD_COMMAND "add"
> +#define OCON_DEL_COMMAND "del"
> +
> +	length = task_has_security(current, SECURITY__RW_PORT);
> +	if (length)
> +		return length;
> +
> +	if (count >= PAGE_SIZE)
> +		return -ENOMEM;
> +	if (*ppos != 0) {
> +		/* No partial writes. */
> +		return -EINVAL;
> +	}
> +	page = (char *)get_zeroed_page(GFP_KERNEL);
> +	if (!page)
> +		goto nomem;
> +	scontext = kzalloc(INITCONTEXTLEN, GFP_KERNEL);
> +	if (!scontext)
> +		goto nomem1;
> +	command = kzalloc(OCONCOMMANDLEN, GFP_KERNEL);
> +	if (!command)
> +		goto nomem2;
> +
> +	length = -EFAULT;
> +	if (copy_from_user(page, buf, count))
> +		goto out;
> +
> +	length = sscanf(page, "%3s %255s %lu %lu %lu", command, scontext,
> +			 &protocol, &low, &high);
> +	if (length < 5) {
> +		length = -EINVAL;
> +		goto out;
> +	}
> +	length = security_context_to_sid(scontext, strlen(scontext), &sid);
> +	if (length < 0) {
> +		length = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (strncmp(OCON_ADD_COMMAND, command, strlen(OCON_ADD_COMMAND)) == 0)
> +		length = security_ocon_port_add(protocol, low, high, sid,
> +						 scontext);
> +	else if (strncmp(OCON_DEL_COMMAND, command, strlen(OCON_DEL_COMMAND))
> +		 == 0)
> +		length = security_ocon_port_del(protocol, low, high, sid,
> +						scontext);
> +	else {
> +		length = -EINVAL;
> +		goto out;
> +	}
> +	if (length < 0)
> +		goto out;
> +	length = count;
> +out:
> +	kfree(command);
> +	kfree(scontext);
> +	free_page((unsigned long) page);
> +	return length;
> +
> +nomem2:
> +	kfree(scontext);
> +nomem1:
> +	free_page((unsigned long) page);
> +nomem:
> +	return -ENOMEM;
> +}
> +
> +static ssize_t sel_read_ocon_port(struct file *filp, char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	ssize_t length;
> +	char *buf_tmp = NULL;
> +
> +	length = task_has_security(current, SECURITY__RW_PORT);
> +	if (length)
> +		return length;
> +
> +	length = security_ocon_port_read(&buf_tmp);
> +	return simple_read_from_buffer(buf, count, ppos, buf_tmp, length);
> +}
> +
> +static const struct file_operations sel_ocon_port_ops = {
> +	.write		= sel_write_ocon_port,
> +	.read		= sel_read_ocon_port,
> +};
> +
>  static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
>  				   size_t count, loff_t *ppos)
>  {
> @@ -1596,6 +1691,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>  		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
>  		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
>  		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
> +		[SEL_OCON_PORT] = {"rw_port", &sel_ocon_port_ops, S_IRUSR|S_IWUSR},
>  		/* last one */ {""}
>  	};
>  	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 77f6e54..978a332 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1831,6 +1831,165 @@ err:
>  
>  }
>  
> +int security_ocon_port_add(u32 protocol, u32 low, u32 high, u32 sid,
> +							 char *scontext)
> +{
> +	int rc = 0;
> +	struct ocontext *c;
> +	struct context ctx;
> +	struct ocontext *add = kzalloc(sizeof(struct ocontext), GFP_KERNEL);
> +
> +	if (!add)
> +		return -ENOMEM;
> +	if (!high)
> +		high = low;
> +	else if (low > high) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	read_lock(&policy_rwlock);
> +	rc = string_to_context_struct(&policydb, &sidtab, scontext,
> +					 strlen(scontext), &ctx, sid);
> +	if (rc) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	add->u.port.protocol = protocol;
> +	add->u.port.low_port = low;
> +	add->u.port.high_port = high;
> +	add->sid[0] = sid;
> +	add->context[0] = ctx;
> +	for (c = policydb.ocontexts[OCON_PORT]; c; c = c->next) {
> +		if (add->u.port.protocol == c->u.port.protocol &&
> +		    add->u.port.low_port == c->u.port.low_port &&
> +		    add->u.port.high_port == c->u.port.high_port) {
> +			printk(KERN_DEBUG "Duplicate netport %d - %d.. "
> +					  "changing permissions\n",
> +			       add->u.port.low_port, add->u.port.high_port);
> +			c->sid[0] = add->sid[0];
> +			context_destroy(&c->context[0]);
> +			c->context[0] = add->context[0];
> +			context_destroy(&add->context[0]);
> +			kfree(add);
> +			avc_ss_reset(0);
> +			goto out;
> +		}
> +	}
> +
> +	add->next = policydb.ocontexts[OCON_PORT];
> +	policydb.ocontexts[OCON_PORT] = add;
> +	avc_ss_reset(0);
> +out:
> +	if (rc) {
> +		context_destroy(&add->context[0]);
> +		kfree(add);
> +	}
> +	read_unlock(&policy_rwlock);
> +	return rc;
> +}
> +
> +int security_ocon_port_del(u32 protocol, u32 low, u32 high, u32 sid,
> +							char *scontext)
> +{
> +	int rc = 0;
> +	struct ocontext *c, *before_c;
> +	struct context ctx;
> +
> +	if (!high)
> +		high = low;
> +	else if (low > high)
> +		return -EINVAL;
> +
> +	read_lock(&policy_rwlock);
> +	rc = string_to_context_struct(&policydb, &sidtab, scontext,
> +					 strlen(scontext), &ctx, sid);
> +	if (rc) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	for (before_c = NULL, c = policydb.ocontexts[OCON_PORT]; c;
> +	     before_c = c, c = c->next) {
> +		if (c->u.port.protocol == protocol &&
> +		    c->u.port.low_port == low &&
> +		    c->u.port.high_port == high &&
> +		    c->context[0].type == ctx.type &&
> +		    c->context[0].role == ctx.role &&
> +		    c->context[0].user == ctx.user) {
> +			if (before_c == NULL)
> +				policydb.ocontexts[OCON_PORT] = c->next;
> +			else
> +				before_c->next = c->next;
> +			context_destroy(&c->context[0]);
> +			kfree(c);
> +			avc_ss_reset(0);
> +			break;
> +		}
> +	}
> +	if (c == NULL) {
> +		printk(KERN_DEBUG "Netport not found %lu - %lu\n",
> +		       (unsigned long) low, (unsigned long) high);
> +		rc = -ENXIO;
> +	}
> +out:
> +	context_destroy(&ctx);
> +	read_unlock(&policy_rwlock);
> +	return rc;
> +}
> +
> +int security_ocon_port_read(char **buf)
> +{
> +	unsigned int buf_size = 0, old_size = 0, len;
> +	struct ocontext *c;
> +	char *scontext;
> +	char *buf_tmp = NULL;
> +	int rc = 0;
> +	int line_size = INITCONTEXTLEN + (sizeof(unsigned long) * 3) +
> +			 (sizeof(char) * 5);
> +	char addline[line_size];
> +
> +	/* protocol low-high scontext*/
> +	read_lock(&policy_rwlock);
> +	if (policydb.ocontexts[OCON_PORT] == NULL)
> +		goto out;
> +
> +	for (c = policydb.ocontexts[OCON_PORT]; c; c = c->next) {
> +		rc = context_struct_to_string(&(c->context[0]), &scontext,
> +					      &len);
> +		if (rc < 0) {
> +			kfree(buf_tmp);
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		if (len > INITCONTEXTLEN) {
> +			kfree(buf_tmp);
> +			kfree(scontext);
> +			rc = -EOVERFLOW;
> +			goto out;
> +		}
> +		snprintf(addline, line_size, "%u %u-%u %s\n",
> +			c->u.port.protocol, c->u.port.low_port,
> +			c->u.port.high_port, scontext);
> +		kfree(scontext);
> +		buf_size += strlen(addline);
> +		buf_tmp = krealloc(buf_tmp, buf_size, GFP_KERNEL);
> +		if (!buf_tmp) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		for (rc = old_size; rc < buf_size; rc++)
> +			buf_tmp[rc] = '\0';
> +		strncat(buf_tmp, addline, buf_size);
> +		old_size = buf_size;
> +	}
> +
> +	*buf = buf_tmp;
> +out:
> +	read_unlock(&policy_rwlock);
> +	return rc;
> +}
> +
>  /**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
> 
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
