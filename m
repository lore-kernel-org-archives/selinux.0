Date: Fri, 10 Jul 2015 12:19:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix mprotect PROT_EXEC regression caused by mm
 change
Message-Id: <20150710121921.e02eb9f1041432ff2dca4667@linux-foundation.org>
In-Reply-To: <1436535659-13124-1-git-send-email-sds@tycho.nsa.gov>
References: <1436535659-13124-1-git-send-email-sds@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: prarit@redhat.com, mstevens@fedoraproject.org, hughd@google.com,
 david@fromorbit.com, linux-kernel@vger.kernel.org, eparis@redhat.com,
 linux-mm@kvack.org, wagi@monom.org, stable@vger.kernel.org,
 selinux@tycho.nsa.gov, torvalds@linux-foundation.org, esandeen@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 10 Jul 2015 09:40:59 -0400 Stephen Smalley <sds@tycho.nsa.gov> wrote:

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

Cc: <stable@vger.kernel.org>	[4.1.x]
