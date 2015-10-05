MIME-Version: 1.0
In-Reply-To: <56128471.5050208@tycho.nsa.gov>
References: <CAFJ0LnGC1F8oRT0OCdWBwLp-xX_s4DWN_p9=GdoG=84ZEod9Fw@mail.gmail.com>
 <56128471.5050208@tycho.nsa.gov>
Date: Mon, 5 Oct 2015 09:39:19 -0700
Message-ID: <CAFJ0LnEvvZ3bQLRfqmTV_NdhsqXnXMRnwMUA6mLOZVCTPPXChA@mail.gmail.com>
Subject: Re: MAP_STACK and execstack
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 5, 2015 at 7:08 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> To clarify, execstack is a check on mprotect() in addition to (not instead
> of) execmem when the mapping is part of the stack.  execmem is always
> required.

Thank you for clarifying. This is good to know.

> Since that time, /proc/pid/maps has been augmented to also identify thread
> stacks, so the logic from show_map_vma could be reused for the execstack
> check as well.

This seems like a good idea.

One other related concern:

SELinux also has execheap. Like execstack, it's checked before parts
of the heap are marked as executable.

  if (vma->vm_start >= vma->vm_mm->start_brk &&
      vma->vm_end <= vma->vm_mm->brk) {
          rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);

This assumes that the heap memory was allocated using brk/sbrk.
However, many modern malloc implementations, including some malloc
versions used in Android, allocate heap memory using mmap() and not
brk/sbrk. brk/sbrk allocated memory is subject to an execheap
permission check, whereas mmap() allocated memory doesn't require an
execheap check. This has caused at least one bug where an app relied
on making malloc() allocated memory executable, failing on one Android
device but succeeding on a different device.

I can see a few ways to solve this:

1) Do nothing.
2) Have userspace mark the memory as being part of the heap
("MAP_HEAP"), and have SELinux enforce the execheap permission.
3) Force the malloc implementations to always use brk/sbrk.
4) Delete the execheap permission check from the kernel and always
rely on execmem.

Do others view this as a bug? If so, are there better solutions?

-- Nick
