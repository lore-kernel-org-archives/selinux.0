Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAJKkLMJ007354
 for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2015 15:46:21 -0500
Received: by qkfo3 with SMTP id o3so30031768qkf.1
 for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2015 12:46:12 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [selinux-testsuite PATCH v2 3/4] mmap/mprotect_heap: make sure
 memory is allocated from heap
Date: Thu, 19 Nov 2015 15:46:10 -0500
Message-ID: <1825470.eZrmI3mDaB@sifl>
In-Reply-To: <e216aafa0f8ba1092e721c7c985385dc9a95f44a.1447666725.git.jstancek@redhat.com>
References: <53398a996e0230fa07c82955624a474524bee50b.1446805443.git.jstancek@redhat.com>
 <e216aafa0f8ba1092e721c7c985385dc9a95f44a.1447666725.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, November 16, 2015 10:46:26 AM Jan Stancek wrote:
> This test failed on ppc64 with 64k pagesize because memory
> allocation used mmap() instead of advancing heap.
> 
> Use mallopt(M_MMAP_THRESHOLD,..) with large enough value
> to discourage use of mmap().
> 
> Also set length in mprotect to pagesize, kernel silently aligns
> it to pagesize anyway.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/mmap/mprotect_heap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Merged.  This looks much better, thanks.

> diff --git a/tests/mmap/mprotect_heap.c b/tests/mmap/mprotect_heap.c
> index 691299493c3f..23de4de5be62 100644
> --- a/tests/mmap/mprotect_heap.c
> +++ b/tests/mmap/mprotect_heap.c
> @@ -3,6 +3,11 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <sys/mman.h>
> +#include <malloc.h>
> +
> +#ifndef DEFAULT_MMAP_THRESHOLD_MAX
> +#define DEFAULT_MMAP_THRESHOLD_MAX 512*1024
> +#endif
> 
>  int main(void)
>  {
> @@ -10,13 +15,19 @@ int main(void)
>  	int rc;
>  	int pagesize = getpagesize();
> 
> +	rc = mallopt(M_MMAP_THRESHOLD, DEFAULT_MMAP_THRESHOLD_MAX);
> +	if (rc != 1) {
> +		fprintf(stderr, "mallopt failed: %d\n", rc);
> +		exit(1);
> +	}
> +
>  	rc = posix_memalign(&ptr, pagesize, pagesize);
>  	if (rc) {
>  		fprintf(stderr, "posix_memalign failed: %d\n", rc);
>  		exit(1);
>  	}
> 
> -	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
> +	rc = mprotect(ptr, pagesize, PROT_READ | PROT_EXEC);
>  	if (rc < 0) {
>  		perror("mprotect");
>  		exit(1);

-- 
paul moore
www.paul-moore.com
