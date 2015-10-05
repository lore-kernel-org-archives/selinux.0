Subject: Re: MAP_STACK and execstack
To: Nick Kralevich <nnk@google.com>, SELinux <Selinux@tycho.nsa.gov>
References: <CAFJ0LnGC1F8oRT0OCdWBwLp-xX_s4DWN_p9=GdoG=84ZEod9Fw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56128471.5050208@tycho.nsa.gov>
Date: Mon, 5 Oct 2015 10:08:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnGC1F8oRT0OCdWBwLp-xX_s4DWN_p9=GdoG=84ZEod9Fw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/02/2015 04:44 PM, Nick Kralevich wrote:
> Currently, SELinux implements the "execstack" capability using the
> following code:
>
> security/selinux/hooks.c
> function: selinux_file_mprotect()
>
> } else if (!vma->vm_file &&
>                vma->vm_start <= vma->vm_mm->start_stack &&
>                vma->vm_end >= vma->vm_mm->start_stack) {
>      rc = current_has_perm(current, PROCESS__EXECSTACK);
> }
>
> However, at least on Android, this check doesn't work for pthread
> allocated stacks. Those stacks are allocated in libc via mmap(), and
> aren't accounted for in the kernel as stack pages. As a result,
> attempting to mprotect(PROT_EXEC) a pthread stack page requires the
> "execmem" permission, not the "execstack" permission.
>
> "man mmap" defines MAP_STACK, which is currently a no-op in the kernel
> indicating that the memory is intended to be used as a stack. In
> theory, Android's libc could set this flag for memory intended to be
> used as a stack, but doing so is useless if the kernel ignores it.
>
> Is there any reason why SELinux shouldn't use MAP_STACK to determine
> whether the execmem or execstack capability is checked? In Android,
> this would be a net security win, since nobody is granted execstack
> today.

To clarify, execstack is a check on mprotect() in addition to (not 
instead of) execmem when the mapping is part of the stack.  execmem is 
always required.

At the time execstack was added, /proc/pid/maps / show_map_vma only 
identified the main process stack and the same logic was used to 
identify it for the execstack check.

Since that time, /proc/pid/maps has been augmented to also identify 
thread stacks, so the logic from show_map_vma could be reused for the 
execstack check as well.

Using MAP_STACK as the basis for the check seems less desirable, as it 
is entirely at the discretion of the program (so can be easily omitted, 
thereby making the check opt-in), is only passed on mmap() not 
mprotect() and doesn't appear to be saved anywhere, so it isn't 
available on mprotect() calls, and is ignored by the kernel.  The commit 
that added it said:

commit cd98a04a59e2f94fa64d5bf1e26498d27427d5e7
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Aug 13 18:02:18 2008 +0200

     x86: add MAP_STACK mmap flag

     as per this discussion:

        http://lkml.org/lkml/2008/8/12/423

     Pardo reported that 64-bit threaded apps, if their stacks exceed the
     combined size of ~4GB, slow down drastically in pthread_create() - 
because
     glibc uses MAP_32BIT to allocate the stacks. The use of MAP_32BIT is
     a legacy hack - to speed up context switching on certain early model
     64-bit P4 CPUs.

     So introduce a new flag to be used by glibc instead, to not constrain
     64-bit apps like this.

     glibc can switch to this new flag straight away - it will be ignored
     by the kernel. If those old CPUs ever matter to anyone, support for
     it can be implemented.
