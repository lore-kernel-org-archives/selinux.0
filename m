Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19GD5jh021759
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 11:13:05 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so27811064wev.8
 for <selinux@tycho.nsa.gov>; Mon, 09 Feb 2015 08:13:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150206223424.13392.21940.stgit@localhost>
References: <20150206223424.13392.21940.stgit@localhost>
Date: Mon, 9 Feb 2015 11:13:02 -0500
Message-ID: <CAB9W1A3-D9yBxEXkGV-QOP0z7Pnd0xz3-sghDaPg1iCCbsMqvA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix RHEL detection
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Doesn't RHEL have variants other than Server?

On Fri, Feb 6, 2015 at 5:34 PM, Paul Moore <pmoore@redhat.com> wrote:
> The redhat-release package is not consistently named across RHEL
> releases, use the /etc/redhat-release instead to detect the RHEL
> version.
>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  tests/Makefile |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 3838e14..7c27787 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -1,18 +1,19 @@
> -REDHAT_RELEASE=$(shell rpm -q redhat-release)
> +RHEL_VER=$(shell cat /etc/redhat-release)
> +RHEL_VER_PREFIX=Red Hat Enterprise Linux Server release
>
>  SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
>
>  SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
>
> -ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
> +ifeq ($(RHEL_VER_PREFIX)4, $(findstring $(RHEL_VER_PREFIX)4, $(RHEL_VER)))
>      SUBDIRS:=$(SUBDIRS_COMMON)
>  endif
>
> -ifeq (redhat-release-5, $(findstring redhat-release-5, $(REDHAT_RELEASE)))
> +ifeq ($(RHEL_VER_PREFIX)5, $(findstring $(RHEL_VER_PREFIX)5, $(RHEL_VER)))
>      SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans
>  endif
>
> -ifeq (redhat-release-6, $(findstring redhat-release-6, $(REDHAT_RELEASE)))
> +ifeq ($(RHEL_VER_PREFIX)6, $(findstring $(RHEL_VER_PREFIX)6, $(RHEL_VER)))
>      SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds
>  endif
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
