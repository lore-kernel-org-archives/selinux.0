Subject: Re: [PATCH 1/1] libsepol/tests: fix mispelling of optimization option
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20160925143040.31378-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <49bc96ec-31e4-8155-3322-14d5efe6be97@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 11:10:44 -0400
MIME-Version: 1.0
In-Reply-To: <20160925143040.31378-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2016 10:30 AM, Nicolas Iooss wrote:
> In CFLAGS, -o0 means "output in file 0", not "compile at optimization
> level 0".
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  libsepol/tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> index dd7bd333c58c..60b3e836cc94 100644
> --- a/libsepol/tests/Makefile
> +++ b/libsepol/tests/Makefile
> @@ -2,7 +2,7 @@ M4 ?= m4
>  MKDIR ?= mkdir
>  EXE ?= libsepol-tests
>  
> -CFLAGS += -g3 -gdwarf-2 -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
> +CFLAGS += -g3 -gdwarf-2 -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
>  
>  # Statically link libsepol on the assumption that we are going to
>  # be testing internal functions.
> 
