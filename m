To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Casey Schaufler
 <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-8-keescook@chromium.org>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <bec8663b-ef33-769d-fe7f-10fb1a6eda35@canonical.com>
Date: Mon, 1 Oct 2018 14:12:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-8-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH security-next v3 07/29] LSM: Convert
 security_initcall() into DEFINE_LSM()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Instead of using argument-based initializers, switch to defining the
> contents of struct lsm_info on a per-LSM basis. This also drops
> the final use of the now inaccurate "initcall" naming.
> 
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@tycho.nsa.gov
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/lsm_hooks.h  | 6 ++++--
>  security/apparmor/lsm.c    | 4 +++-
>  security/integrity/iint.c  | 4 +++-
>  security/selinux/hooks.c   | 4 +++-
>  security/smack/smack_lsm.c | 4 +++-
>  security/tomoyo/tomoyo.c   | 4 +++-
>  6 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ad04761e5587..02ec717189f9 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2045,11 +2045,13 @@ struct lsm_info {
>  
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  
> -#define security_initcall(lsm)						\
> +#define DEFINE_LSM(lsm)							\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(.lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))			\
> -		= { .init = lsm, }
> +		= {							\
> +
> +#define END_LSM	  }
>  

I am with Tetsuo on this one, I really don't like the END_LSM thing.
