Message-ID: <5570AC04.3050709@tycho.nsa.gov>
Date: Thu, 04 Jun 2015 15:50:28 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/6] selinux-testsuite: add _GNU_SOURCE to tests/Makefile
References: <20150604194045.31270.58300.stgit@localhost>
 <20150604194149.31270.13124.stgit@localhost>
In-Reply-To: <20150604194149.31270.13124.stgit@localhost>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/04/2015 03:41 PM, Paul Moore wrote:
> As suggested by Stephen Smalley.  A couple of msgbuf struct
> definitions had to be removed as they were conflicting with system
> definitions.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/Makefile     |    3 +++
>  tests/msg/msgrcv.c |    5 -----
>  tests/msg/msgsnd.c |    5 -----
>  3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/Makefile b/tests/Makefile
> index e9d4646..8100b8f 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -1,3 +1,6 @@
> +
> +export CFLAGS+=-D_GNU_SOURCE
> +
>  DISTRO=$(shell ./os_detect)
>  
>  SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
> diff --git a/tests/msg/msgrcv.c b/tests/msg/msgrcv.c
> index b23c801..285dcad 100644
> --- a/tests/msg/msgrcv.c
> +++ b/tests/msg/msgrcv.c
> @@ -6,11 +6,6 @@
>  
>  #define MSGMAX 1024
>  
> -struct msgbuf {
> -  long mtype;     /* message type, must be > 0 */
> -  char mtext[1024];  /* message data */
> -};
> -

This doesn't seem right.  I see that the _GNU_SOURCE definition triggers
inclusion of a struct msgbuf definition from sys/msg.h, but that
definition doesn't allocate any space for the mtext buffer.  So then
when we try to msgsnd() or msgrcv() with MSGMAX, we'll be
reading/writing memory past the end of the structure?

Maybe you were right the first time, sorry.

>  int main(int argc, char **argv)
>  {
>  	int ch;
> diff --git a/tests/msg/msgsnd.c b/tests/msg/msgsnd.c
> index e200aef..7204ab6 100644
> --- a/tests/msg/msgsnd.c
> +++ b/tests/msg/msgsnd.c
> @@ -7,11 +7,6 @@
>  
>  #define MSGMAX 1024
>  
> -struct msgbuf {
> -  long mtype;     /* message type, must be > 0 */
> -  char mtext[1024];  /* message data */
> -};
> -
>  int main(int argc, char **argv)
>  {
>  	int ch;
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
