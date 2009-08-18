Subject: Re: [PATCH] Security/SELinux: remove duplicated #include
From: Eric Paris <eparis@redhat.com>
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
In-Reply-To: <1250603833-3972-1-git-send-email-weiyi.huang@gmail.com>
References: <1250603833-3972-1-git-send-email-weiyi.huang@gmail.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 10:01:34 -0400
Message-Id: <1250604094.4829.17.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-18 at 21:57 +0800, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>   kernel/sysctl.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Sorry, my fault....

Acked-by: Eric Paris <eparis@redhat.com>



> ---
>  kernel/sysctl.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 58be760..71d8dc7 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -49,7 +49,6 @@
>  #include <linux/acpi.h>
>  #include <linux/reboot.h>
>  #include <linux/ftrace.h>
> -#include <linux/security.h>
>  #include <linux/slow-work.h>
>  #include <linux/perf_counter.h>
>  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
