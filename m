Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QJpdFI016213
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:51:39 -0400
Received: by mail-qk0-f170.google.com with SMTP id n63so10081421qkf.0
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 12:51:38 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, nnk@google.com
Subject: Re: [PATCH] selinux: apply execstack check on thread stacks
Date: Tue, 26 Apr 2016 15:51:36 -0400
Message-ID: <7865607.7xfMNbCtOp@sifl>
In-Reply-To: <1460138103-17507-1-git-send-email-sds@tycho.nsa.gov>
References: <1460138103-17507-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, April 08, 2016 01:55:03 PM Stephen Smalley wrote:
> The execstack check was only being applied on the main
> process stack.  Thread stacks allocated via mmap were
> only subject to the execmem permission check.  Augment
> the check to apply to the current thread stack as well.
> Note that this does NOT prevent making a different thread's
> stack executable.
> 
> Suggested-by: Nick Kralevich <nnk@google.com>
> Acked-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fce7dc8..d495dac 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3465,8 +3465,9 @@ static int selinux_file_mprotect(struct vm_area_struct
> *vma, vma->vm_end <= vma->vm_mm->brk) {
>  			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
>  		} else if (!vma->vm_file &&
> -			   vma->vm_start <= vma->vm_mm->start_stack &&
> -			   vma->vm_end >= vma->vm_mm->start_stack) {
> +			   ((vma->vm_start <= vma->vm_mm->start_stack &&
> +			     vma->vm_end >= vma->vm_mm->start_stack) ||
> +			    vma_is_stack_for_task(vma, current))) {
>  			rc = current_has_perm(current, PROCESS__EXECSTACK);
>  		} else if (vma->vm_file && vma->anon_vma) {
>  			/*

-- 
paul moore
www.paul-moore.com
