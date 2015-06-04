Message-ID: <55707CF4.4050807@tycho.nsa.gov>
Date: Thu, 04 Jun 2015 12:29:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] selinux-testsuite: fix compile warnings in
 tests/execshare
References: <20150604161454.4124.77310.stgit@localhost>
 <20150604161538.4124.38211.stgit@localhost>
In-Reply-To: <20150604161538.4124.38211.stgit@localhost>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/04/2015 12:15 PM, Paul Moore wrote:
> Correct the following:
> 
> make[2]: Entering directory '/root/sources/selinux-testsuite/tests/execshare'
> cc     parent.c  -lselinux -o parent
> parent.c: In function 'main':
> parent.c:83:8: warning: implicit declaration of function 'clone'
>   pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
>         ^
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Although maybe we should just add -D_GNU_SOURCE to CFLAGS in the
tests/Makefile...

> ---
>  tests/execshare/parent.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
> index 86f6ae9..343c35f 100644
> --- a/tests/execshare/parent.c
> +++ b/tests/execshare/parent.c
> @@ -1,3 +1,6 @@
> +
> +#define _GNU_SOURCE
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> 
