Message-ID: <5571A20B.6080809@tycho.nsa.gov>
Date: Fri, 05 Jun 2015 09:20:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v3 6/6] selinux-testsuite: fix compile problems in
 tests/capable_file
References: <20150604205708.19614.64746.stgit@localhost>
 <20150604205830.19614.68299.stgit@localhost>
In-Reply-To: <20150604205830.19614.68299.stgit@localhost>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/04/2015 04:58 PM, Paul Moore wrote:
> Fix the following warnings:
> 
> make[2]: Entering directory '/home/pmoore/sources/selinux-testsuite/selinux_testsuite-upstream/tests/capable_file'
> cc -g -O0 -Wall -D_GNU_SOURCE    test_lease.c   -o test_lease
> test_lease.c: In function 'main':
> test_lease.c:22:3: warning: implicit declaration of function 'open'
>    fd = open(argv[1], O_RDONLY, 0);
>    ^
> test_lease.c:29:3: warning: implicit declaration of function 'fcntl'
>    rc = fcntl(fd, F_SETLEASE, 0);
>    ^
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
for all 6 patches.

> ---
>  tests/capable_file/test_lease.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/capable_file/test_lease.c b/tests/capable_file/test_lease.c
> index 606d75c..e8f29eb 100644
> --- a/tests/capable_file/test_lease.c
> +++ b/tests/capable_file/test_lease.c
> @@ -1,9 +1,10 @@
> -#include<stdio.h>
> -#include<stdlib.h>
> -#include<sys/types.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
>  #include <linux/posix_types.h>
> -#include<linux/fcntl.h>
>  #include <unistd.h>
> +#include <fcntl.h>
>  
>  /*
>   * Test the fcntl F_SETLEASE operation on a file whose name is given as 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
