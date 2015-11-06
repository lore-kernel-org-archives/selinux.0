Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6IPoHb028820
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 13:25:50 -0500
Received: by qgad10 with SMTP id d10so98002708qga.3
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 10:25:39 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [selinux-testsuite PATCH 4/4] mmap/mprotect_file_private_execmod:
 clear READ_IMPLIES_EXEC
Date: Fri, 06 Nov 2015 13:25:38 -0500
Message-ID: <2549427.kUCr3OJkjq@sifl>
In-Reply-To: <c1be558e303328e7d4cc3d592789588da7de2f4a.1446805443.git.jstancek@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
 <c1be558e303328e7d4cc3d592789588da7de2f4a.1446805443.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 06, 2015 02:07:24 PM Jan Stancek wrote:
> If READ_IMPLIES_EXEC personality is set, mmap-ed area will have
> VM_EXEC vm_flag set, which causes selinux_file_mprotect() to
> skip check for FILE__EXECMOD.
> 
> This caused that older (2.6.32) kernels on s390x always allowed
> mprotect to succeed.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/mmap/mprotect_file_private_execmod.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Merged, thanks.

> diff --git a/tests/mmap/mprotect_file_private_execmod.c
> b/tests/mmap/mprotect_file_private_execmod.c index
> ade19811290a..6d6b995fc03c 100644
> --- a/tests/mmap/mprotect_file_private_execmod.c
> +++ b/tests/mmap/mprotect_file_private_execmod.c
> @@ -4,6 +4,11 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <sys/mman.h>
> +#include <sys/personality.h>
> +
> +#ifndef READ_IMPLIES_EXEC
> +#define READ_IMPLIES_EXEC 0x0400000
> +#endif
> 
>  int main(int argc, char **argv)
>  {
> @@ -16,6 +21,14 @@ int main(int argc, char **argv)
>  		exit(1);
>  	}
> 
> +	/* clear READ_IMPLIES_EXEC if present, because it skips
> +	 * check for FILE__EXECMOD in selinux_file_mprotect() */
> +	rc = personality(0xffffffff);
> +	if ((rc != -1) && (rc & READ_IMPLIES_EXEC)) {
> +		rc &= ~READ_IMPLIES_EXEC;
> +		personality(rc);
> +	}
> +
>  	fd = open(argv[1], O_RDONLY);
>  	if (fd < 0) {
>  		perror(argv[1]);

-- 
paul moore
www.paul-moore.com
