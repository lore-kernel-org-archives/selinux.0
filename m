Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6BJi2BZ002697
 for <selinux@tycho.nsa.gov>; Sat, 11 Jul 2015 15:44:02 -0400
Received: by pachj5 with SMTP id hj5so9807641pac.3
 for <selinux@tycho.nsa.gov>; Sat, 11 Jul 2015 12:43:41 -0700 (PDT)
Date: Sat, 11 Jul 2015 12:43:31 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix mprotect PROT_EXEC regression caused by mm
 change
In-Reply-To: <1436535659-13124-1-git-send-email-sds@tycho.nsa.gov>
Message-ID: <alpine.LSU.2.11.1507111233001.2032@eggly.anvils>
References: <1436535659-13124-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: prarit@redhat.com, mstevens@fedoraproject.org, hughd@google.com,
 david@fromorbit.com, linux-kernel@vger.kernel.org, eparis@redhat.com,
 linux-mm@kvack.org, wagi@monom.org, selinux@tycho.nsa.gov,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, esandeen@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 10 Jul 2015, Stephen Smalley wrote:

> commit 66fc13039422ba7df2d01a8ee0873e4ef965b50b ("mm: shmem_zero_setup skip
> security check and lockdep conflict with XFS") caused a regression for
> SELinux by disabling any SELinux checking of mprotect PROT_EXEC on
> shared anonymous mappings.  However, even before that regression, the
> checking on such mprotect PROT_EXEC calls was inconsistent with the
> checking on a mmap PROT_EXEC call for a shared anonymous mapping.  On a
> mmap, the security hook is passed a NULL file and knows it is dealing with
> an anonymous mapping and therefore applies an execmem check and no file
> checks.  On a mprotect, the security hook is passed a vma with a
> non-NULL vm_file (as this was set from the internally-created shmem
> file during mmap) and therefore applies the file-based execute check and
> no execmem check.  Since the aforementioned commit now marks the shmem
> zero inode with the S_PRIVATE flag, the file checks are disabled and
> we have no checking at all on mprotect PROT_EXEC.  Add a test to
> the mprotect hook logic for such private inodes, and apply an execmem
> check in that case.  This makes the mmap and mprotect checking consistent
> for shared anonymous mappings, as well as for /dev/zero and ashmem.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Thank you for correcting that, Stephen (and for the nicely detailed
commit description): it looks right to me so I'll say

Acked-by: Hugh Dickins <hughd@google.com>

but I know far too little of SElinux, and its defaults, to confirm
whether it actually does all you need - I'll trust you on that.

(There being various other references to the file in file_map_prot_check()
and selinux_file_mprotect(), and I couldn't tell if they should or should
not be modified by IS_PRIVATE(file_inode(file) checks too: my best guess
was that they wouldn't matter.)

> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6231081..564079c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3283,7 +3283,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
>  	int rc = 0;
>  
>  	if (default_noexec &&
> -	    (prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
> +	    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
> +				   (!shared && (prot & PROT_WRITE)))) {
>  		/*
>  		 * We are making executable an anonymous mapping or a
>  		 * private file mapping that will also be writable.
> -- 
> 2.1.0
