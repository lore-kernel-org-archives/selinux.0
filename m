MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1506140944380.11018@eggly.anvils>
References: <alpine.LSU.2.11.1506140944380.11018@eggly.anvils>
Date: Wed, 8 Jul 2015 09:13:08 -0400
Message-ID: <CAB9W1A2ekXaqHfcUxpmx_5rwxfP+wMHA17BdrA7f=Ey-rp0Lvw@mail.gmail.com>
Subject: Re: mm: shmem_zero_setup skip security check and lockdep conflict
 with XFS
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: Prarit Bhargava <prarit@redhat.com>,
 Morten Stevens <mstevens@fedoraproject.org>,
 Eric Sandeen <esandeen@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Dave Chinner <david@fromorbit.com>, Daniel Wagner <wagi@monom.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
 linux-mm@kvack.org, selinux <selinux@tycho.nsa.gov>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jun 14, 2015 at 12:48 PM, Hugh Dickins <hughd@google.com> wrote:
> It appears that, at some point last year, XFS made directory handling
> changes which bring it into lockdep conflict with shmem_zero_setup():
> it is surprising that mmap() can clone an inode while holding mmap_sem,
> but that has been so for many years.
>
> Since those few lockdep traces that I've seen all implicated selinux,
> I'm hoping that we can use the __shmem_file_setup(,,,S_PRIVATE) which
> v3.13's commit c7277090927a ("security: shmem: implement kernel private
> shmem inodes") introduced to avoid LSM checks on kernel-internal inodes:
> the mmap("/dev/zero") cloned inode is indeed a kernel-internal detail.
>
> This also covers the !CONFIG_SHMEM use of ramfs to support /dev/zero
> (and MAP_SHARED|MAP_ANONYMOUS).  I thought there were also drivers
> which cloned inode in mmap(), but if so, I cannot locate them now.

This causes a regression for SELinux (please, in the future, cc
selinux list and Paul Moore on SELinux-related changes).  In
particular, this change disables SELinux checking of mprotect
PROT_EXEC on shared anonymous mappings, so we lose the ability to
control executable mappings.  That said, we are only getting that
check today as a side effect of our file execute check on the tmpfs
inode, whereas it would be better (and more consistent with the
mmap-time checks) to apply an execmem check in that case, in which
case we wouldn't care about the inode-based check.  However, I am
unclear on how to correctly detect that situation from
selinux_file_mprotect() -> file_map_prot_check(), because we do have a
non-NULL vma->vm_file so we treat it as a file execute check.  In
contrast, if directly creating an anonymous shared mapping with
PROT_EXEC via mmap(...PROT_EXEC...),  selinux_mmap_file is called with
a NULL file and therefore we end up applying an execmem check.

>
> Reported-and-tested-by: Prarit Bhargava <prarit@redhat.com>
> Reported-by: Daniel Wagner <wagi@monom.org>
> Reported-by: Morten Stevens <mstevens@fedoraproject.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>
>  mm/shmem.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- 4.1-rc7/mm/shmem.c  2015-04-26 19:16:31.352191298 -0700
> +++ linux/mm/shmem.c    2015-06-14 09:26:49.461120166 -0700
> @@ -3401,7 +3401,13 @@ int shmem_zero_setup(struct vm_area_stru
>         struct file *file;
>         loff_t size = vma->vm_end - vma->vm_start;
>
> -       file = shmem_file_setup("dev/zero", size, vma->vm_flags);
> +       /*
> +        * Cloning a new file under mmap_sem leads to a lock ordering conflict
> +        * between XFS directory reading and selinux: since this file is only
> +        * accessible to the user through its mapping, use S_PRIVATE flag to
> +        * bypass file security, in the same way as shmem_kernel_file_setup().
> +        */
> +       file = __shmem_file_setup("dev/zero", size, vma->vm_flags, S_PRIVATE);
>         if (IS_ERR(file))
>                 return PTR_ERR(file);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
