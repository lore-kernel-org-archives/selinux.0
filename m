Message-ID: <1507148872.1491.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Corentin Labbe <clabbe.montjoie@gmail.com>, paul@paul-moore.com,
 eparis@parisplace.org, james.l.morris@oracle.com, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Date: Wed, 04 Oct 2017 16:27:52 -0400
In-Reply-To: <20171004183218.4786-2-clabbe.montjoie@gmail.com>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
 <20171004183218.4786-2-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] selinux: fix build warning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-10-04 at 20:32 +0200, Corentin Labbe wrote:
> This patch make selinux_task_prlimit() static since it is not used
> anywhere else.
> This fix the following build warning:
> security/selinux/hooks.c:3981:5: warning: no previous prototype for
> 'selinux_task_prlimit' [-Wmissing-prototypes]
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8507a56f85e4..b8a022f4b4a7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3977,8 +3977,8 @@ static int selinux_task_getioprio(struct
> task_struct *p)
>  			    PROCESS__GETSCHED, NULL);
>  }
>  
> -int selinux_task_prlimit(const struct cred *cred, const struct cred
> *tcred,
> -			 unsigned int flags)
> +static int selinux_task_prlimit(const struct cred *cred, const
> struct cred *tcred,
> +				unsigned int flags)
>  {
>  	u32 av = 0;
>  
