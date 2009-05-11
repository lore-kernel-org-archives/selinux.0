Subject: Re: [PATCH] Fix ltp selinux testsuite for rhel5
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1241552473.3023.370.camel@localhost.localdomain>
References: <1241552473.3023.370.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 May 2009 14:46:42 +0530
Message-Id: <1242033402.6102.98.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-05 at 15:41 -0400, Stephen Smalley wrote: 
> Some changes on top of the prior patches to enable the ltp selinux
> testsuite to run successfully on rhel5.  Changes:
> - Fix the extraction of the release version to exclude
> Client/Server/etc.
> - Make the ioctl test detect kernel version and adjust the test logic to
> match the expected selinux_file_ioctl() logic.
> - Prevent runcon from consuming the options to chcon in
> selinux_relabel.sh.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Thanks.

Regards--
Subrata

> 
> ---
> 
>  testcases/kernel/security/selinux-testsuite/refpolicy/Makefile               |    2 
>  testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c    |   28 +++++++---
>  testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh |    2 
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff -u testcases/kernel/security/selinux-testsuite/refpolicy/Makefile testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
> --- testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	5 May 2009 13:47:43 -0000
> +++ testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	5 May 2009 19:30:39 -0000
> @@ -1,5 +1,5 @@
>  REDHAT_RELEASE=$(shell rpm -q redhat-release)
> -REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-")
> +REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
>  POLICYDEVEL = /usr/share/selinux/devel
>  SEMODULE = /usr/sbin/semodule
>  CHECKPOLICY = /usr/bin/checkpolicy
> diff -u testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c
> --- testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c	1 May 2009 13:29:14 -0000
> +++ testcases/kernel/security/selinux-testsuite/tests/ioctl/selinux_noioctl.c	5 May 2009 19:30:39 -0000
> @@ -16,6 +16,7 @@
>  #include<sys/stat.h>
>  #include<linux/fs.h>
>  #include<linux/ext2_fs.h>
> +#include <sys/utsname.h>
> 
>  /*
>   * Test the ioctl() calls on a file whose name is given as the first
> @@ -25,11 +26,19 @@
>   * acess to the given file.
>   */
>  int main(int argc, char **argv) {
> -
> +  struct utsname uts;
>    int fd;
> -  int rc;
> +  int rc, oldkernel = 1;
>    int val;
> 
> +  if (uname(&uts) < 0) {
> +    perror("uname");
> +    exit(1);
> +  }
> +
> +  if (strverscmp(uts.release, "2.6.27") >= 0)
> +    oldkernel = 0;
> +
>    fd = open(argv[1], O_RDONLY, 0);
>   
>    if(fd == -1) {
> @@ -51,19 +60,24 @@
>      exit(1);
>    }
> 
> -  /* This one should hit the FILE__IOCTL test and fail. */
> +  /*
> +   * This one depends on kernel version:
> +   * New:  Should hit the FILE__IOCTL test and fail.
> +   * Old:  Should only check FD__USE and succeed.
> +   */
>    rc = ioctl(fd, FIONBIO, &val);
> -  if( rc == 0 ) {
> +  if( !rc == !oldkernel ) {
>      printf("test_noioctl:FIONBIO");
>      exit(1);
>    }
> 
>    /*
> -   * This one should hit the FILE__READ test and succeed since
> -   * read permission had to be granted in order to open the file.
> +   * This one depends on kernel version:
> +   * New:  Should hit the FILE__READ test and succeed.
> +   * Old:  Should hit the FILE__GETATTR test and fail.
>     */
>    rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
> -  if( rc != 0 ) {
> +  if( !rc != !oldkernel ) {
>      perror("test_noioctl:EXT2_IOC_GETVERSION");
>      exit(1);
>    }
> diff -u testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh
> --- testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh	30 Apr 2009 15:18:04 -0000
> +++ testcases/kernel/security/selinux-testsuite/tests/relabel/selinux_relabel.sh	5 May 2009 19:30:39 -0000
> @@ -31,7 +31,7 @@
>  	RC=0
> 
>  	# Verify that test_relabel_t can relabel the file.
> -	runcon -t test_relabel_t chcon -t test_relabel_newtype_t $SELINUXTMPDIR/test_file 2>&1
> +	runcon -t test_relabel_t -- chcon -t test_relabel_newtype_t $SELINUXTMPDIR/test_file 2>&1
>          RC=$?
>          if [ $RC -eq 0 ]
>          then
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
