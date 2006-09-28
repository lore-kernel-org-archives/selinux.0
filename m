Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SJoiIb027989
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 15:50:44 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SJoBQW022879
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 19:50:11 GMT
Date: Thu, 28 Sep 2006 15:50:42 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>, "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] NetLabel: add audit support for configuration changes
In-Reply-To: <20060928180337.570612000@hp.com>
Message-ID: <Pine.LNX.4.64.0609281547060.28120@d.namei>
References: <20060928180326.896170000@hp.com> <20060928180337.570612000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> +struct audit_buffer *netlbl_audit_start_common(int type, u32 secid)

> +	if (current->mm) {
> +		down_read(&current->mm->mmap_sem);
> +		vma = current->mm->mmap;
> +		while (vma) {
> +			if ((vma->vm_flags & VM_EXECUTABLE) &&
> +			    vma->vm_file) {
> +				audit_log_d_path(audit_buf,
> +						 " exe=",
> +						 vma->vm_file->f_dentry,
> +						 vma->vm_file->f_vfsmnt);
> +				break;
> +			}
> +			vma = vma->vm_next;
> +		}
> +		up_read(&current->mm->mmap_sem);


Suggestion for the future: I think it'd be wortwhile consolidating this 
with the code in audit_log_task_info().

In any case, the patch looks fine to me.

Acked-by: James Morris <jmorris@namei.org>



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
