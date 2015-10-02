MIME-Version: 1.0
Date: Fri, 2 Oct 2015 13:44:30 -0700
Message-ID: <CAFJ0LnGC1F8oRT0OCdWBwLp-xX_s4DWN_p9=GdoG=84ZEod9Fw@mail.gmail.com>
Subject: MAP_STACK and execstack
From: Nick Kralevich <nnk@google.com>
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently, SELinux implements the "execstack" capability using the
following code:

security/selinux/hooks.c
function: selinux_file_mprotect()

} else if (!vma->vm_file &&
              vma->vm_start <= vma->vm_mm->start_stack &&
              vma->vm_end >= vma->vm_mm->start_stack) {
    rc = current_has_perm(current, PROCESS__EXECSTACK);
}

However, at least on Android, this check doesn't work for pthread
allocated stacks. Those stacks are allocated in libc via mmap(), and
aren't accounted for in the kernel as stack pages. As a result,
attempting to mprotect(PROT_EXEC) a pthread stack page requires the
"execmem" permission, not the "execstack" permission.

"man mmap" defines MAP_STACK, which is currently a no-op in the kernel
indicating that the memory is intended to be used as a stack. In
theory, Android's libc could set this flag for memory intended to be
used as a stack, but doing so is useless if the kernel ignores it.

Is there any reason why SELinux shouldn't use MAP_STACK to determine
whether the execmem or execstack capability is checked? In Android,
this would be a net security win, since nobody is granted execstack
today.

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
