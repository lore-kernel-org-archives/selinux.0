Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1175632367.9109.22.camel@moss-lions.epoch.ncsc.mil>
References: <1175632367.9109.22.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 08:42:59 -0400
Message-Id: <1175690579.23072.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-03 at 16:32 -0400, James Carter wrote:
> Make the initial SID contexts accessible to userspace via selinuxfs.
> An initial use of this support will be to make the unlabeled context
> available to libselinux for use for invalidated userspace SIDs.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> ---
> 
>  security/selinux/include/security.h |    2 +
>  security/selinux/selinuxfs.c        |   67 ++++++++++++++++++++++++++++++++++++
>  security/selinux/ss/services.c      |    7 +++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 210eec7..505e558 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -102,5 +102,7 @@ int security_fs_use(const char *fstype, unsigned int *behavior,
>  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
>  
> +const char* security_get_initial_sid_context(u32 sid);
> +
>  #endif /* _SELINUX_SECURITY_H_ */
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 93b3177..89d246f 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -102,6 +102,9 @@ enum sel_inos {
>  	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
>  };
>  
> +#define SEL_INITCON_INO_OFFSET 	0x01000000
> +#define SEL_INO_MASK		0x00ffffff
> +
>  #define TMPBUFLEN	12
>  static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
>  				size_t count, loff_t *ppos)
> @@ -1240,6 +1243,55 @@ out:
>  	return ret;
>  }
>  
> +static ssize_t sel_read_initcon(struct file * file, char __user *buf, 
> +				size_t count, loff_t *ppos)
> +{
> +	struct inode *inode;
> +	char *con;
> +	u32 sid, len;
> +	ssize_t ret;
> +
> +	inode = file->f_path.dentry->d_inode;
> +	sid = inode->i_ino&SEL_INO_MASK;
> +	ret = security_sid_to_context(sid, &con, &len);
> +	if (ret < 0)
> +		return ret;
> +	
> +	ret = simple_read_from_buffer(buf, count, ppos, con, len);
> +	kfree(con);
> +	return ret;
> +}
> +
> +static const struct file_operations sel_initcon_ops = {
> +	.read		= sel_read_initcon,
> +};
> +
> +static int sel_make_initcon_files(struct dentry *dir)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i <= SECINITSID_NUM; i++) {

This should be:
	for (i = 1; i <= SECINITSID_NUM; i++) {

because SID 0 (SECSID_NULL) is not an initial SID and has no definition
in policy (would map to unlabeled by default like any other undefined
SID, but has no real separate definition).

Otherwise, looks sane.

> +		struct inode *inode;
> +		struct dentry *dentry;
> +		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
> +		if (!dentry) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> +		if (!inode) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		inode->i_fop = &sel_initcon_ops;
> +		inode->i_ino = i|SEL_INITCON_INO_OFFSET;
> +		d_add(dentry, inode);
> +	}
> +out:
> +	return ret;
> +}
> +
>  static int sel_make_dir(struct inode *dir, struct dentry *dentry)
>  {
>  	int ret = 0;
> @@ -1336,6 +1388,21 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
>  	ret = sel_make_avc_files(dentry);
>  	if (ret)
>  		goto err;
> +
> +	dentry = d_alloc_name(sb->s_root, "initial_contexts");
> +	if (!dentry) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = sel_make_dir(root_inode, dentry);
> +	if (ret)
> +		goto err;
> +
> +	ret = sel_make_initcon_files(dentry);
> +	if (ret)
> +		goto err;
> +
>  out:
>  	return ret;
>  err:
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1e52356..ef6affd 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -594,6 +594,13 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>  
>  #include "initial_sid_to_string.h"
>  
> +const char* security_get_initial_sid_context(u32 sid)
> +{
> +	if (sid <= SECINITSID_NUM)
> +		return initial_sid_to_string[sid];
> +	return NULL;
> +}
> +
>  /**
>   * security_sid_to_context - Obtain a context for a given SID.
>   * @sid: security identifier, SID
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
