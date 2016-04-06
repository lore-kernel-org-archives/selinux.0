Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u36N4sf7018486
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 19:04:54 -0400
Received: by mail-yw0-f169.google.com with SMTP id g3so75963837ywa.3
 for <selinux@tycho.nsa.gov>; Wed, 06 Apr 2016 16:04:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459972627.5403.2.camel@gmail.com>
References: <1459972627.5403.2.camel@gmail.com>
Date: Wed, 6 Apr 2016 16:04:52 -0700
Message-ID: <CAFJ0LnEKrd9-n7gzZDx1mwuqFSx66+k-3bu0zym_CQ3k9rGz9Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: apply execstack check on thread stacks
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks!

On Wed, Apr 6, 2016 at 12:57 PM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> The execstack check was only being applied on the main
> process stack.  Thread stacks allocated via mmap were
> only subject to the execmem permission check.  Augment
> the check to apply to the current thread stack as well.
> Note that this does NOT prevent making a different thread's
> stack executable.
>
> Suggested-by: Nick Kralevich <nnk@google.com>

Acked-By: Nick Kralevich <nnk@google.com>

> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a9ca5ee..0271be4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3465,8 +3465,9 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>                     vma->vm_end <= vma->vm_mm->brk) {
>                         rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
>                 } else if (!vma->vm_file &&
> -                          vma->vm_start <= vma->vm_mm->start_stack &&
> -                          vma->vm_end >= vma->vm_mm->start_stack) {
> +                          ((vma->vm_start <= vma->vm_mm->start_stack &&
> +                            vma->vm_end >= vma->vm_mm->start_stack) ||
> +                           vma_is_stack_for_task(vma, current))) {
>                         rc = current_has_perm(current, PROCESS__EXECSTACK);
>                 } else if (vma->vm_file && vma->anon_vma) {
>                         /*
> --
> 2.8.0
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
