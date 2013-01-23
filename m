Message-ID: <510004B2.5020703@tycho.nsa.gov>
Date: Wed, 23 Jan 2013 10:41:38 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jan Stancek <jstancek@redhat.com>
CC: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running
 on ext[234]
References: <6012e6d654ddc5defd9e283745ff7d10a2fa20b5.1358947507.git.jstancek@redhat.com>
In-Reply-To: <6012e6d654ddc5defd9e283745ff7d10a2fa20b5.1358947507.git.jstancek@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/23/2013 08:27 AM, Jan Stancek wrote:
> EXT2_* ioctls are likely to fail on other filesystems,
> for example: xfs.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   tests/ioctl/Makefile       |    6 ++++++
>   tests/ioctl/test_ioctl.c   |    2 ++
>   tests/ioctl/test_noioctl.c |    2 ++
>   3 files changed, 10 insertions(+), 0 deletions(-)

Shouldn't really be a compile-time flag but rather a runtime test of the 
filesystem type, right?  Otherwise it presumes you built it on the same 
system and in the same filesystem where you will run it.

I thought however that your earlier patch to switch it to using FS_IOC_ 
command values would have
addressed the issue of other filesystem types already?  What error are 
you getting from xfs?  The code already checks for one errno value to 
distinguish the not-supported case.

> diff --git a/tests/ioctl/Makefile b/tests/ioctl/Makefile
> index 8dce555..def5267 100644
> --- a/tests/ioctl/Makefile
> +++ b/tests/ioctl/Makefile
> @@ -1,4 +1,10 @@
>   TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> +
> +DIR_FS=$(shell df -TP . | awk '{print $2}' | grep 'ext[234]')
> +ifneq (x$(DIR_FS),x)
> +    CFLAGS += -DUSE_EXTFS_IOCTLS
> +endif
> +
>   all: $(TARGETS)
>   clean:
>   	rm -f $(TARGETS)
> diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
> index 0852f41..fa5d021 100644
> --- a/tests/ioctl/test_ioctl.c
> +++ b/tests/ioctl/test_ioctl.c
> @@ -49,6 +49,7 @@ int main(int argc, char **argv) {
>       exit(1);
>     }
>
> +#ifdef USE_EXTFS_IOCTLS
>     /* This one should hit the FILE__GETATTR or FILE__READ test */
>     rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
>     if( rc != 0 ) {
> @@ -63,6 +64,7 @@ int main(int argc, char **argv) {
>       perror("test_ioctl:EXT2_IOC_SETVERSION");
>       exit(1);
>     }
> +#endif
>
>     close(fd);
>     exit(0);
> diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
> index ef3fac5..b0ca660 100644
> --- a/tests/ioctl/test_noioctl.c
> +++ b/tests/ioctl/test_noioctl.c
> @@ -68,6 +68,7 @@ int main(int argc, char **argv) {
>       exit(1);
>     }
>
> +#ifdef USE_EXTFS_IOCTLS
>     /*
>      * This one depends on kernel version:
>      * New:  Should hit the FILE__READ test and succeed.
> @@ -86,6 +87,7 @@ int main(int argc, char **argv) {
>       perror("test_noioctl:EXT2_IOC_SETVERSION");
>       exit(1);
>     }
> +#endif
>
>     close(fd);
>     exit(0);
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
