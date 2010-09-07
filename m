Message-ID: <4C858160.3060804@ak.jp.nec.com>
Date: Tue, 07 Sep 2010 09:03:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov
Subject: Re: [PATCH] Fast status update interface (/selinux/status)
References: <4C76455E.6000504@ak.jp.nec.com>	<4C76FDD2.4070800@ak.jp.nec.com>	<4C777958.4060500@ak.jp.nec.com>	<AANLkTimX8uFSE_twBw9KrUQA9+U6zLCeTZN_P0N8mT_A@mail.gmail.com> <AANLkTi=SJEG45e2MZN2Cj0S4SrXqoTWtJdKXqkLKeLiV@mail.gmail.com> <4C78817F.9040909@kaigai.gr.jp> <4C7F5D45.4040901@ak.jp.nec.com>
In-Reply-To: <4C7F5D45.4040901@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do we have any issues to be revised about this patch?
If nothing to fix any more, please include this feature toward the next
merge window.

It shall provide a key feature to implement a security server in userspace
application as loadable module, without expensive system-calls and invasive
patches. At least, PostgreSQL and Memcached need it. :-)

Thanks,

(2010/09/02 17:16), KaiGai Kohei wrote:
> (2010/08/28 12:24), KaiGai Kohei wrote:
>> (2010/08/28 1:19), Eric Paris wrote:
>>> On Fri, Aug 27, 2010 at 11:48 AM, Eric Paris<eparis@parisplace.org>    wrote:
>>>> 2010/8/27 KaiGai Kohei<kaigai@ak.jp.nec.com>:
>>>>> I revised the /selinux/status implementation.
>>>>>
>>>>> * It becomes to report 'deny_unknown'. Userspace object manager
>>>>>     also reference this flag to decide its behavior when the loaded
>>>>>     policy does not support expected object classes.
>>>>> * It provided PAGE_READONLY to remap_pfn_range() as page protection
>>>>>     flag independent from argument of mmap(2), but it was uncommon.
>>>>>     I fixed to pass vma->vm_page_prot instead of the hardwired flag
>>>>>     according to any other implementation style.
>>>>>     Now it returns an error, if user tries to map /selinux/status as
>>>>>     writable pages.
>>>>
>>>> I really hate blowing 4k of memory on every system to show 40 bytes of
>>>> data on just a few systems.  Is there any change we could allocate the
>>>> page the first time it is needed rather that at boot?  I know compared
>>>> to the size of policy and other memory usage in SELinux it's odd for
>>>> me to complain, but I've decided to get on a reduction if possible
>>>> kick.
>>>>
>>>> Only other comment is that __initcall() is deprecated and we are
>>>> supposed to use device_initcall() now.
>>>>
>>>> If you plan to use it, I'll ack if you change both of those things....
>>>
>>> actually if you move to dynamic allocation of the status page and use
>>> static DEFINE_SPINLOCK instead of static spinlock_t you can get rid of
>>> the __init() code altogether....
>>>
>>
>> I revised the patch.
>> It was changed the selinux_kernel_page being allocated at the first time
>> when application tries to reference the /selinux/status.
>> At the same time, it declares selinux_status_lock using DEFINE_MUTEX(),
>> so whole of the __init section has gone.
>>
>> In addition, I changed first member of the selinux_kernel_status from
>> 'length' to 'version', because sizeof(struct ...) is aligned to 64bit
>> boundary (24bytes) on x86_64 system, although it is actually 20bytes.
>> If we want to add a 32bit member in the future, 'length' may not inform
>> applications enough.
>>
> How about getting the feature?
> Although I've not found out this idea for a long time, it is quite helpful
> feature to implement SE-PostgreSQL (and other upcoming userspace object
> managers) in less invasive way.
> 
> I fixed up two minor points in the patch, as follows:
> * The 4K of status page becomes allocated at the file_operations::open()
>    method, because it seems to me a bit unnatural that either read() or
>    mmap() fails due to memory allocation error.
> * I forgot to eliminate an unnecessary declaration of extern variable.
> 
>   Signed-off-by: KaiGai Kohei<kaigai@ak.jp.nec.com>
> --
>   security/selinux/include/security.h |   21 ++++++
>   security/selinux/selinuxfs.c        |   56 ++++++++++++++
>   security/selinux/ss/Makefile        |    2 +-
>   security/selinux/ss/services.c      |    3 +
>   security/selinux/ss/status.c        |  135 +++++++++++++++++++++++++++++++++++
>   5 files changed, 216 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 1f7c249..e390e31 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -191,5 +191,26 @@ static inline int security_netlbl_sid_to_secattr(u32 sid,
> 
>   const char *security_get_initial_sid_context(u32 sid);
> 
> +/*
> + * status notifier using mmap interface
> + */
> +extern struct page *selinux_kernel_status_page(void);
> +
> +#define SELINUX_KERNEL_STATUS_VERSION	1
> +struct selinux_kernel_status
> +{
> +	u32	version;	/* version number of thie structure */
> +	u32	sequence;	/* sequence number of seqlock logic */
> +	u32	enforcing;	/* current setting of enforcing mode */
> +	u32	policyload;	/* times of policy reloaded */
> +	u32	deny_unknown;	/* current setting of deny_unknown */
> +	/*
> +	 * The version>  0 supports above members.
> +	 */
> +} __attribute__((packed));
> +
> +extern void selinux_status_update_setenforce(int enforcing);
> +extern void selinux_status_update_policyload(int seqno);
> +
>   #endif /* _SELINUX_SECURITY_H_ */
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79a1bb6..a2e7a85 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -110,6 +110,7 @@ enum sel_inos {
>   	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
>   	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
>   	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
> +	SEL_STATUS,	/* export current status using mmap() */
>   	SEL_INO_NEXT,	/* The next inode number to use */
>   };
> 
> @@ -171,6 +172,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>   		if (selinux_enforcing)
>   			avc_ss_reset(0);
>   		selnl_notify_setenforce(selinux_enforcing);
> +		selinux_status_update_setenforce(selinux_enforcing);
>   	}
>   	length = count;
>   out:
> @@ -205,6 +207,59 @@ static const struct file_operations sel_handle_unknown_ops = {
>   	.llseek		= generic_file_llseek,
>   };
> 
> +static int sel_open_handle_status(struct inode *inode, struct file *filp)
> +{
> +	struct page    *status = selinux_kernel_status_page();
> +
> +	if (!status)
> +		return -ENOMEM;
> +
> +	filp->private_data = status;
> +
> +	return 0;
> +}
> +
> +static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct page    *status = filp->private_data;
> +
> +	BUG_ON(!status);
> +
> +	return simple_read_from_buffer(buf, count, ppos,
> +				       page_address(status),
> +				       sizeof(struct selinux_kernel_status));
> +}
> +
> +static int sel_mmap_handle_status(struct file *filp,
> +				  struct vm_area_struct *vma)
> +{
> +	struct page    *status = filp->private_data;
> +	unsigned long	size = vma->vm_end - vma->vm_start;
> +
> +	BUG_ON(!status);
> +
> +	/* only allows one page from the head */
> +	if (vma->vm_pgoff>  0 || size != PAGE_SIZE)
> +		return -EIO;
> +	/* disallow writable mapping */
> +	if (vma->vm_flags&  VM_WRITE)
> +		return -EPERM;
> +	/* disallow mprotect() turns it into writable */
> +	vma->vm_flags&= ~VM_MAYWRITE;
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(status),
> +			       size, vma->vm_page_prot);
> +}
> +
> +static const struct file_operations sel_handle_status_ops = {
> +	.open		= sel_open_handle_status,
> +	.read		= sel_read_handle_status,
> +	.mmap		= sel_mmap_handle_status,
> +	.llseek		= generic_file_llseek,
> +};
> +
>   #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>   static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>   				 size_t count, loff_t *ppos)
> @@ -1612,6 +1667,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>   		[SEL_CHECKREQPROT] = {"checkreqprot",&sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
>   		[SEL_REJECT_UNKNOWN] = {"reject_unknown",&sel_handle_unknown_ops, S_IRUGO},
>   		[SEL_DENY_UNKNOWN] = {"deny_unknown",&sel_handle_unknown_ops, S_IRUGO},
> +		[SEL_STATUS] = {"status",&sel_handle_status_ops, S_IRUGO},
>   		/* last one */ {""}
>   	};
>   	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> diff --git a/security/selinux/ss/Makefile b/security/selinux/ss/Makefile
> index 15d4e62..974e11c 100644
> --- a/security/selinux/ss/Makefile
> +++ b/security/selinux/ss/Makefile
> @@ -5,5 +5,5 @@
>   EXTRA_CFLAGS += -Isecurity/selinux -Isecurity/selinux/include
>   obj-y := ss.o
> 
> -ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o
> +ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o status.o
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 9ea2fec..494ff52 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1791,6 +1791,7 @@ int security_load_policy(void *data, size_t len)
>   		selinux_complete_init();
>   		avc_ss_reset(seqno);
>   		selnl_notify_policyload(seqno);
> +		selinux_status_update_policyload(seqno);
>   		selinux_netlbl_cache_invalidate();
>   		selinux_xfrm_notify_policyload();
>   		return 0;
> @@ -1870,6 +1871,7 @@ int security_load_policy(void *data, size_t len)
> 
>   	avc_ss_reset(seqno);
>   	selnl_notify_policyload(seqno);
> +	selinux_status_update_policyload(seqno);
>   	selinux_netlbl_cache_invalidate();
>   	selinux_xfrm_notify_policyload();
> 
> @@ -2374,6 +2376,7 @@ out:
>   	if (!rc) {
>   		avc_ss_reset(seqno);
>   		selnl_notify_policyload(seqno);
> +		selinux_status_update_policyload(seqno);
>   		selinux_xfrm_notify_policyload();
>   	}
>   	return rc;
> diff --git a/security/selinux/ss/status.c b/security/selinux/ss/status.c
> new file mode 100644
> index 0000000..eeab696
> --- /dev/null
> +++ b/security/selinux/ss/status.c
> @@ -0,0 +1,135 @@
> +/*
> + * mmap based event notifications for SELinux
> + *
> + * Author: KaiGai Kohei<kaigai@ak.jp.nec.com>
> + *
> + * Copyright (C) 2010 NEC corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2,
> + * as published by the Free Software Foundation.
> + */
> +#include<linux/kernel.h>
> +#include<linux/gfp.h>
> +#include<linux/mm.h>
> +#include<linux/mutex.h>
> +#include "avc.h"
> +#include "services.h"
> +
> +/*
> + * The selinux_status_page shall be exposed to userspace applications
> + * using mmap interface on /selinux/status.
> + * It enables to notify applications a few events that will cause reset
> + * of userspace access vector without context switching.
> + *
> + * The selinux_kernel_status structure on the head of status page is
> + * protected from concurrent accesses using seqlock logic, so userspace
> + * application should reference the status page according to the seqlock
> + * logic.
> + *
> + * Typically, application checks status->sequence at the head of access
> + * control routine. If it is odd-number, kernel is updating the status,
> + * so please wait for a moment. If it is changed from the last sequence
> + * number, it means something happen, so application will reset userspace
> + * avc, if needed.
> + * In addition, application should also checks the sequence number at
> + * tail of the access control routine. If it is changed from the value
> + * on the head, it means kernel status was changed under processing the
> + * routine. In this case, application should repeat to run the routine
> + * from head, but we expect it is much rare case.
> + * In most case, application can confirm the kernel status is not changed
> + * without any system call invocations.
> + * Hopefully, libselinux encapsulates this logic.
> + */
> +static struct page *selinux_status_page = NULL;
> +static DEFINE_MUTEX(selinux_status_lock);
> +
> +/*
> + * selinux_kernel_status_page
> + *
> + * It returns a reference to selinux_status_page. If the status page is
> + * not allocated yet, it also tries to allocate it at the first time.
> + */
> +struct page *selinux_kernel_status_page(void)
> +{
> +	struct selinux_kernel_status   *status;
> +	struct page		       *result = NULL;
> +
> +	mutex_lock(&selinux_status_lock);
> +	if (!selinux_status_page)
> +	{
> +		selinux_status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
> +		if (selinux_status_page)
> +		{
> +			status = page_address(selinux_status_page);
> +
> +			status->version = SELINUX_KERNEL_STATUS_VERSION;
> +			status->sequence = 0;
> +			status->enforcing = selinux_enforcing;
> +			/*
> +			 * NOTE: the next policyload event shall set
> +			 * a positive value on the status->policyload,
> +			 * although it may not be 1, but never zero.
> +			 * So, application can know it was updated.
> +			 */
> +			status->policyload = 0;
> +			status->deny_unknown = !security_get_allow_unknown();
> +		}
> +	}
> +	result = selinux_status_page;
> +	mutex_unlock(&selinux_status_lock);
> +
> +	return result;
> +}
> +
> +/*
> + * selinux_status_update_setenforce
> + *
> + * It updates status of the current enforcing/permissive mode.
> + */
> +void selinux_status_update_setenforce(int enforcing)
> +{
> +	struct selinux_kernel_status   *status;
> +
> +	mutex_lock(&selinux_status_lock);
> +	if (selinux_status_page)
> +	{
> +		status = page_address(selinux_status_page);
> +
> +		status->sequence++;
> +		smp_wmb();
> +
> +		status->enforcing = enforcing;
> +
> +		smp_wmb();
> +		status->sequence++;
> +	}
> +	mutex_unlock(&selinux_status_lock);
> +}
> +
> +/*
> + * selinux_status_update_policyload
> + *
> + * It updates status of the times of policy reloaded, and current
> + * setting of deny_unknown.
> + */
> +void selinux_status_update_policyload(int seqno)
> +{
> +	struct selinux_kernel_status   *status;
> +
> +	mutex_lock(&selinux_status_lock);
> +	if (selinux_status_page)
> +	{
> +		status = page_address(selinux_status_page);
> +
> +		status->sequence++;
> +		smp_wmb();
> +
> +		status->policyload = seqno;
> +		status->deny_unknown = !security_get_allow_unknown();
> +
> +		smp_wmb();
> +		status->sequence++;
> +	}
> +	mutex_unlock(&selinux_status_lock);
> +}
> 


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
