Date: Mon, 23 Nov 2009 09:01:07 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: header generation may hit infinite loop
In-Reply-To: <20091120160012.9892.90998.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0911230901001.19108@tundra.namei.org>
References: <20091120160012.9892.90998.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Nov 2009, Eric Paris wrote:

> If a permission name is long enough the selinux class definition generation
> tool will go into a infinite loop.  This is because it's macro max() is
> fooled into thinking it is dealing with unsigned numbers.  This patch makes
> sure the macro always uses signed number so 1 > -1.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

> ---
> 
>  scripts/selinux/genheaders/genheaders.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index 771b86f..2462696 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -13,7 +13,7 @@ struct security_class_mapping {
>  #include "classmap.h"
>  #include "initial_sid_to_string.h"
>  
> -#define max(x, y) ((x > y) ? x : y)
> +#define max(x, y) (((int)(x) > (int)(y)) ? x : y)
>  
>  const char *progname;
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
