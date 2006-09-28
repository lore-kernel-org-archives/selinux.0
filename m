Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SK5965028431
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 16:05:09 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SK44bB018312
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 20:04:04 GMT
Message-ID: <451C2AEA.7050608@hp.com>
Date: Thu, 28 Sep 2006 16:04:58 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-audit@redhat.com, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] NetLabel: add audit support for configuration changes
References: <20060928180326.896170000@hp.com> <20060928180337.570612000@hp.com> <Pine.LNX.4.64.0609281547060.28120@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609281547060.28120@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
>>+struct audit_buffer *netlbl_audit_start_common(int type, u32 secid)
> 
> 
>>+	if (current->mm) {
>>+		down_read(&current->mm->mmap_sem);
>>+		vma = current->mm->mmap;
>>+		while (vma) {
>>+			if ((vma->vm_flags & VM_EXECUTABLE) &&
>>+			    vma->vm_file) {
>>+				audit_log_d_path(audit_buf,
>>+						 " exe=",
>>+						 vma->vm_file->f_dentry,
>>+						 vma->vm_file->f_vfsmnt);
>>+				break;
>>+			}
>>+			vma = vma->vm_next;
>>+		}
>>+		up_read(&current->mm->mmap_sem);
> 
> 
> 
> Suggestion for the future: I think it'd be wortwhile consolidating this 
> with the code in audit_log_task_info().

Agreed, in fact, as I suspect you have already noticed, this was ripped
right from that function.  It was private to kernel/auditsc.c making it
offlimits, but I would have gladly used it instead; making
audit_log_task_info() public seemed like something that was beyond this
NetLabel specific patch.

> In any case, the patch looks fine to me.
> 
> Acked-by: James Morris <jmorris@namei.org>

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
