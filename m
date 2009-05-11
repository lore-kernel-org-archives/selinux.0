Subject: Re: [PATCH] Update selinux ioctl test
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1241533772.3023.324.camel@localhost.localdomain>
References: <1241533772.3023.324.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 May 2009 14:46:32 +0530
Message-Id: <1242033392.6102.97.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-05 at 10:29 -0400, Stephen Smalley wrote: 
> Update the selinux ioctl test in ltp to reflect the revised
> selinux_file_ioctl() logic in the kernel.  Also requires the
> corresponding ltp selinux test policy update.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Thanks.

Regards--
Subrata

> 
> ---
> 
>  testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.c   |   13 +++
>  testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c |   33 ++++++----
>  2 files changed, 33 insertions(+), 13 deletions(-)
> 
> 
> Index: testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.c,v
> retrieving revision 1.2
> diff -u -r1.2 selinux_ioctl.c
> --- testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.c	26 Feb 2009 12:02:31 -0000	1.2
> +++ testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_ioctl.c	1 May 2009 13:29:14 -0000
> @@ -35,7 +35,7 @@
>      exit(1);
>    }
> 
> -  /* This one should hit the FILE__GETATTR test */
> +  /* This one should hit the FILE__IOCTL test */
>    rc = ioctl(fd, FIGETBSZ, &val);
>    if( rc != 0 ) {
>      perror("test_ioctl:FIGETBSZ");
> @@ -49,15 +49,22 @@
>      exit(1);
>    }
> 
> -  /* This one should hit the normal file descriptor use test */
> +  /* This one should hit the FILE__IOCTL test */
>    rc = ioctl(fd, FIONBIO, &val);
>    if( rc != 0 ) {
>      perror("test_ioctl:FIONBIO");
>      exit(1);
>    }
> 
> +  /* This one should hit the FILE__READ test */
> +  rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
> +  if( rc != 0 ) {
> +    perror("test_ioctl:EXT2_IOC_GETVERSION");
> +    exit(1);
> +  }
> +
> +  /* This one should hit the FILE__WRITE test */
>    val = 0;
> -  /* This one should hit the FILE__SETATTR test */
>    rc = ioctl(fd, EXT2_IOC_SETVERSION, &val);
>    if( rc != 0 ) {
>      perror("test_ioctl:EXT2_IOC_SETVERSION");
> Index: testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c,v
> retrieving revision 1.2
> diff -u -r1.2 selinux_noioctl.c
> --- testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c	26 Feb 2009 12:02:31 -0000	1.2
> +++ testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c	1 May 2009 13:29:14 -0000
> @@ -37,29 +37,42 @@
>      exit(1);
>    }
> 
> -  /* This one should hit the normal file descriptor use test; expect success */
> -  rc = ioctl(fd, FIONBIO, &val);
> -  if( rc != 0 ) {
> -    perror("test_noioctl:FIONBIO");
> -    exit(1);
> +  /* This one should hit the FILE__IOCTL test and fail. */
> +  rc = ioctl(fd, FIGETBSZ, &val);
> +  if( rc == 0 ) {
> +      printf("test_noioctl:FIGETBSZ");
> +      exit(1);
>    }
> 
> -  /* This one should hit the FILE__GETATTR test; expect failure */
> -  rc = ioctl(fd, FIGETBSZ, &val);
> +  /* This one should hit the FILE__IOCTL test and fail. */
> +  rc = ioctl(fd, FIOCLEX);
>    if( rc == 0 ) {
> +    printf("test_noioctl:FIOCLEX");
>      exit(1);
>    }
> 
> -  /* This one should hit the FILE__IOCTL test */
> -  rc = ioctl(fd, FIOCLEX);
> +  /* This one should hit the FILE__IOCTL test and fail. */
> +  rc = ioctl(fd, FIONBIO, &val);
>    if( rc == 0 ) {
> +    printf("test_noioctl:FIONBIO");
> +    exit(1);
> +  }
> +
> +  /*
> +   * This one should hit the FILE__READ test and succeed since
> +   * read permission had to be granted in order to open the file.
> +   */
> +  rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
> +  if( rc != 0 ) {
> +    perror("test_noioctl:EXT2_IOC_GETVERSION");
>      exit(1);
>    }
> 
> +  /* This one should hit the FILE__WRITE test and fail. */
>    val = 0;
> -  /* This one should hit the FILE__SETATTR test; expect failure */
>    rc = ioctl(fd, EXT2_IOC_SETVERSION, &val);
>    if( rc == 0 ) {
> +    perror("test_noioctl:EXT2_IOC_SETVERSION");
>      exit(1);
>    }
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
