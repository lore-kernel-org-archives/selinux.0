Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280407807.3348.11.camel@moss-pluto.epoch.ncsc.mil>
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
	 <1280407807.3348.11.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Jul 2010 13:58:00 -0400
Message-ID: <1280426280.2734.123.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-29 at 08:50 -0400, Stephen Smalley wrote:
> On Tue, 2010-07-27 at 16:24 -0400, Eric Paris wrote:

> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 8f64eec..6562ecd 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c

> > @@ -315,11 +317,23 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
> >  	if (rc)
> >  		goto err;
> >  
> > +	if (policy_opened) {
> > +		mutex_unlock(&sel_mutex);
> > +		return -EBUSY;
> > +	}
> > +	policy_opened = 1;
> 
> I would take the policy_opened flag to the first patch to prevent
> arbitrary kernel memory allocation just by opening /selinux/policy
> repeatedly.  Note however my other comments on the first patch as well.

Done.

> > +	if (i_size_read(inode) != security_policydb_len()) {
> > +		mutex_lock(&inode->i_mutex);
> > +		i_size_write(inode, security_policydb_len());
> > +		mutex_unlock(&inode->i_mutex);
> > +	}
> 
> Do you really think this is necessary?  Does any other filesystem do
> this?  I'd drop it otherwise.

I think it is necessary.  Lets look at your strace:

# strace checkpolicy -b /selinux/policy
...
open("/selinux/policy", O_RDONLY)       = 3
fstat(3, {st_mode=S_IFREG|0400, st_size=5720516, ...}) = 0
mmap(NULL, 5720516, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = -1 EINVAL
(Invalid argument)

Notice that after the open we use fstat to find out the length and then
use that as the argument to mmap.  Without this set stat would return 0
length.  I stole the idea from fs/proc/kcore.c::open_kcore()

> > +static int sel_mmap_policy_fault(struct vm_area_struct *vma,
> > +				 struct vm_fault *vmf)
> > +{
> > +	struct policy_load_memory *plm = vma->vm_file->private_data;
> > +	unsigned long offset;
> > +	struct page *page;
> > +
> > +	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	offset = vmf->pgoff << PAGE_SHIFT;
> > +	if (offset >= roundup(plm->len, PAGE_SIZE))
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	page = vmalloc_to_page(plm->data + offset);
> > +	get_page(page);
> > +
> > +	vmf->page = page;
> > +
> > +	return 0;
> > +}
> 
> This looks fine to me but I can't say that I've written one of these
> handlers before.  Did you derive this from some example in an existing
> filesystem?

Looking at a bunch of them.  But it doesn't really work exactly the way
I thought it would.  I'm not getting a signal when I write to a page.
So I plan to poke it some more.

Unrelated note, I'm also afraid I'm possibly leaking some information.
I have no idea what information is on the last page of the vmalloc()
block after the end of the policy.  And I bet userspace could read that
bit of information.  I need to check on that too....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
