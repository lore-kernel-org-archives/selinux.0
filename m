Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280262263.2788.27.camel@dhcp231-200.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
	 <1280255773.4789.83.camel@moss-pluto.epoch.ncsc.mil>
	 <1280256670.2788.14.camel@dhcp231-200.rdu.redhat.com>
	 <1280257773.4789.110.camel@moss-pluto.epoch.ncsc.mil>
	 <1280258214.2788.17.camel@dhcp231-200.rdu.redhat.com>
	 <1280258441.4789.113.camel@moss-pluto.epoch.ncsc.mil>
	 <1280258664.2788.20.camel@dhcp231-200.rdu.redhat.com>
	 <1280258892.4789.118.camel@moss-pluto.epoch.ncsc.mil>
	 <1280262263.2788.27.camel@dhcp231-200.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Jul 2010 08:50:07 -0400
Message-ID: <1280407807.3348.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 16:24 -0400, Eric Paris wrote:
> On Tue, 2010-07-27 at 15:28 -0400, Stephen Smalley wrote:
> > On Tue, 2010-07-27 at 15:24 -0400, Eric Paris wrote:
> > > On Tue, 2010-07-27 at 15:20 -0400, Stephen Smalley wrote:
> > > > On Tue, 2010-07-27 at 15:16 -0400, Eric Paris wrote:
> > > > > On Tue, 2010-07-27 at 15:09 -0400, Stephen Smalley wrote:
> > > > > > On Tue, 2010-07-27 at 14:51 -0400, Eric Paris wrote:
> > > > > 
> > > > > > > My fear was:
> > > > > > > 
> > > > > > > Process A			Process B
> > > > > > > ------------------------	-------------------------
> > > > > > > open("/selinux/policy");
> > > > > > >   plm->data = p1
> > > > > > >   plm->len = l1
> > > > > > >   i_size = l1
> > > > > > > 				load_policy
> > > > > > > 				open("/selinux/policy");
> > > > > > > 				  plm->data = p2;
> > > > > > > 				  plm->len = l2;
> > > > > > > 				  i_size = l2;
> > > > > > > 				stat("/selinux/policy");
> > > > > > > 				  we get i_size=l2
> > > > > > > stat("/selinux/policy");
> > > > > > >   we get i_size=l2  WHOOPS.
> > > > > > 
> > > > > > How is that different from corresponding situation for a regular file?
> > > > > > Doesn't seem like the sort of thing the kernel should worry about.
> > > > > > I thought the check was to prevent arbitrary allocation of kernel memory
> > > > > > by spinning in a loop opening /selinux/policy forever.  But that doesn't
> > > > > > require worrying about the inode size changing.
> > > > > 
> > > > > This is actually more the problem with files in /proc.  The difference
> > > > > is that the plm->data and plm->len are still p1 and l1.  It's just
> > > > > stat() that is going to lie to you.  So you will either mmap to much or
> > > > > too little space and you have no idea how long the data you are going to
> > > > > be reading is...
> > > > > 
> > > > > read() works ok, because it is going to go till the EOF, but you have no
> > > > > idea where that is with mmap.....
> > > > 
> > > > I see.  It appears that setools and coreutils use read() rather than
> > > > mmap() since I could run seinfo, sediff, and cp on /selinux/policy, so
> > > > maybe nothing other than checkpolicy -b would even use the mmap support?
> > > > And that can be worked around by first copying to a regular file.
> > > > checkpolicy -b isn't exactly a typical user command; most people don't
> > > > even know it exists.
> > > 
> > > Another horrific option would be to create a new inode for each open()
> > > so your fd would always have your i_size info....
> > 
> > That would indeed be horrific ;)
> > 
> > > I'm going to finish my second mmap implementation attempt just to learn,
> > > but maybe we want to just throw it all away?  If so, thoughts on
> > > addressing the memory usage issue?
> > 
> > I don't care about userspace getting confused by an interleaving of
> > policy load and policy read - that is a userspace problem IMO.  So I
> > wouldn't be opposed to having the mmap handler upstreamed, although I
> > don't feel qualified to review the implementation - might want some
> > -fsdevel or -kernel eyes on it.
> > 
> > Limiting /selinux/policy to one user at a time might be reasonable as a
> > way of limiting memory consumption.  But you don't need the i_size hacks
> > as part of that.
> 
> My new mmap implementation (a whole lot easier to review even by an
> idiot like me) gives:
> 
> # checkpolicy -M -b /selinux/policy
> checkpolicy:  loading policy configuration from /selinux/policy
> libsepol.policydb_index_others: security:  9 users, 13 roles, 3341 types, 170 bools
> libsepol.policydb_index_others: security: 1 sens, 1024 cats
> libsepol.policydb_index_others: security:  77 classes, 195841 rules, 236706 cond rules
> checkpolicy:  policy configuration loaded
> 
> -----
> 
> commit 7e9368a5d130e6caa9b914cc60da7bc3791e04a5
> Author: Eric Paris <eparis@redhat.com>
> Date:   Tue Jul 27 16:22:33 2010 -0400
> 
>     selinux: implement mmap on /selinux/policy
>     
>     /selinux/policy allows a user to copy the policy back out of the kernel.
>     This patch allows userspace to actually mmap that file and use it directly.
>     
>     Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 8f64eec..6562ecd 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -68,6 +68,8 @@ static int *bool_pending_values;
>  static struct dentry *class_dir;
>  static unsigned long last_class_ino;
>  
> +static char policy_opened;
> +
>  /* global data for policy capabilities */
>  static struct dentry *policycap_dir;
>  
> @@ -315,11 +317,23 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
>  	if (rc)
>  		goto err;
>  
> +	if (policy_opened) {
> +		mutex_unlock(&sel_mutex);
> +		return -EBUSY;
> +	}
> +	policy_opened = 1;

I would take the policy_opened flag to the first patch to prevent
arbitrary kernel memory allocation just by opening /selinux/policy
repeatedly.  Note however my other comments on the first patch as well.
 
> +
>  	rc = -ENOMEM;
>  	plm = kzalloc(sizeof(*plm), GFP_KERNEL);
>  	if (!plm)
>  		goto err;
>  
> +	if (i_size_read(inode) != security_policydb_len()) {
> +		mutex_lock(&inode->i_mutex);
> +		i_size_write(inode, security_policydb_len());
> +		mutex_unlock(&inode->i_mutex);
> +	}

Do you really think this is necessary?  Does any other filesystem do
this?  I'd drop it otherwise.

> +
>  	rc = security_read_policy(&plm->data, &plm->len);
>  	if (rc)
>  		goto err;
> @@ -344,6 +358,8 @@ static int sel_release_policy(struct inode *inode, struct file *filp)
>  
>  	BUG_ON(!plm);
>  
> +	policy_opened = 0;
> +
>  	vfree(plm->data);
>  	kfree(plm);
>  
> @@ -380,9 +396,44 @@ out:
>  	return ret;
>  }
>  
> +static int sel_mmap_policy_fault(struct vm_area_struct *vma,
> +				 struct vm_fault *vmf)
> +{
> +	struct policy_load_memory *plm = vma->vm_file->private_data;
> +	unsigned long offset;
> +	struct page *page;
> +
> +	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
> +		return VM_FAULT_SIGBUS;
> +
> +	offset = vmf->pgoff << PAGE_SHIFT;
> +	if (offset >= roundup(plm->len, PAGE_SIZE))
> +		return VM_FAULT_SIGBUS;
> +
> +	page = vmalloc_to_page(plm->data + offset);
> +	get_page(page);
> +
> +	vmf->page = page;
> +
> +	return 0;
> +}

This looks fine to me but I can't say that I've written one of these
handlers before.  Did you derive this from some example in an existing
filesystem?

> +
> +static struct vm_operations_struct sel_mmap_policy_ops = {
> +	.fault = sel_mmap_policy_fault,
> +};
> +
> +int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
> +{
> +	vma->vm_flags |= VM_RESERVED;
> +	vma->vm_ops = &sel_mmap_policy_ops;
> +
> +	return 0;
> +}
> +
>  static const struct file_operations sel_policy_ops = {
>  	.open		= sel_open_policy,
>  	.read		= sel_read_policy,
> +	.mmap		= sel_mmap_policy,
>  	.release	= sel_release_policy,
>  };
>  
> 
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
