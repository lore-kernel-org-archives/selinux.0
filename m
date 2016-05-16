Subject: Re: [PATCH] libsemanage: Support overriding Makefile RANLIB
To: Julien Pivotto <roidelapluie@inuits.eu>, selinux@tycho.nsa.gov
References: <1463083074-8550-1-git-send-email-roidelapluie@inuits.eu>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <275bef17-ad49-1880-5085-b7f2cae7bb17@tycho.nsa.gov>
Date: Mon, 16 May 2016 16:46:34 -0400
MIME-Version: 1.0
In-Reply-To: <1463083074-8550-1-git-send-email-roidelapluie@inuits.eu>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Applied.

On 05/12/2016 03:57 PM, Julien Pivotto wrote:
> ---
>  libsemanage/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index d1fcc0b..71eadd6 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -61,7 +61,7 @@ SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno
>  		-Wno-unused-parameter
>  
>  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
> -RANLIB=ranlib
> +RANLIB ?= ranlib
>  
>  SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
>  
> 
