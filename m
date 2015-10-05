Subject: Re: MAP_STACK and execstack
To: Nick Kralevich <nnk@google.com>
References: <CAFJ0LnGC1F8oRT0OCdWBwLp-xX_s4DWN_p9=GdoG=84ZEod9Fw@mail.gmail.com>
 <56128471.5050208@tycho.nsa.gov>
 <CAFJ0LnEvvZ3bQLRfqmTV_NdhsqXnXMRnwMUA6mLOZVCTPPXChA@mail.gmail.com>
Cc: SELinux <Selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5612C500.9040704@tycho.nsa.gov>
Date: Mon, 5 Oct 2015 14:44:16 -0400
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnEvvZ3bQLRfqmTV_NdhsqXnXMRnwMUA6mLOZVCTPPXChA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/05/2015 12:39 PM, Nick Kralevich wrote:
> On Mon, Oct 5, 2015 at 7:08 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> To clarify, execstack is a check on mprotect() in addition to (not instead
>> of) execmem when the mapping is part of the stack.  execmem is always
>> required.
> 
> Thank you for clarifying. This is good to know.
> 
>> Since that time, /proc/pid/maps has been augmented to also identify thread
>> stacks, so the logic from show_map_vma could be reused for the execstack
>> check as well.
> 
> This seems like a good idea.
> 
> One other related concern:
> 
> SELinux also has execheap. Like execstack, it's checked before parts
> of the heap are marked as executable.
> 
>   if (vma->vm_start >= vma->vm_mm->start_brk &&
>       vma->vm_end <= vma->vm_mm->brk) {
>           rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
> 
> This assumes that the heap memory was allocated using brk/sbrk.
> However, many modern malloc implementations, including some malloc
> versions used in Android, allocate heap memory using mmap() and not
> brk/sbrk. brk/sbrk allocated memory is subject to an execheap
> permission check, whereas mmap() allocated memory doesn't require an
> execheap check. This has caused at least one bug where an app relied
> on making malloc() allocated memory executable, failing on one Android
> device but succeeding on a different device.
> 
> I can see a few ways to solve this:
> 
> 1) Do nothing.
> 2) Have userspace mark the memory as being part of the heap
> ("MAP_HEAP"), and have SELinux enforce the execheap permission.
> 3) Force the malloc implementations to always use brk/sbrk.
> 4) Delete the execheap permission check from the kernel and always
> rely on execmem.
> 
> Do others view this as a bug? If so, are there better solutions?

I'm not convinced it is a bug (the kernel is enforcing the restriction
over the heap as the kernel defines it, i.e. the brk region).

Introducing yet another MAP_ flag that won't otherwise be used by
the kernel and would need to be propagated to the vma flags in order
to be used by SELinux for execheap doesn't seem viable, and again
would make it an opt-in behavior by the application so it doesn't
seem like the sort of thing we would do via SELinux.

Forcing malloc implementations to use brk/sbrk would be undesirable
and impractical for large allocations.

Deleting execheap would remove a protection for programs that
require execmem but do not need to make their heap executable
(for cases where brk is used).

If we were to introduce a new MAP_ flag, it would probably make more
sense to introduce a MAP_DENYEXEC flag that could be used by an
application to indicate that the mapping should never be made executable
(i.e. all subsequent mprotect PROT_EXEC calls on it should fail).
Then it could apply that to stack, heap, and whatever other regions it
doesn't want to be executable.  That wouldn't need to be SELinux-based at all.

So I guess I'd go with option #1 (do nothing), although MAP_DENYEXEC might
be an interesting thing to try.
