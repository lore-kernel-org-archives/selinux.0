Subject: Re: [PATCH 3/3] libselinux: drop DISABLE_BOOL=y option
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
 <1475076369-13586-3-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b2f21a98-94ba-e986-fd90-fb718b91bd73@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 11:51:29 -0400
MIME-Version: 1.0
In-Reply-To: <1475076369-13586-3-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 11:26 AM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Build option DISABLE_BOOL=y is not being used, and is broken, drop it.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied all three.  At some point we might want to rename
EMFLAGS (presumably short for embedded flags) to DISABLE_FLAGS or similar.

> ---
>  libselinux/Makefile          | 6 +-----
>  libselinux/src/Makefile      | 6 +-----
>  libselinux/src/load_policy.c | 2 --
>  libselinux/utils/Makefile    | 5 -----
>  4 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index c96695d..bfeb4b8 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -2,17 +2,13 @@ SUBDIRS = src include utils man
>  
>  DISABLE_SETRANS ?= n
>  DISABLE_RPM ?= n
> -DISABLE_BOOL ?= n
> -ifeq ($(DISABLE_BOOL),y)
> -	EMFLAGS+= -DDISABLE_BOOL
> -endif
>  ifeq ($(DISABLE_RPM),y)
>  	EMFLAGS+= -DDISABLE_RPM
>  endif
>  ifeq ($(DISABLE_SETRANS),y)
>  	EMFLAGS+= -DDISABLE_SETRANS
>  endif
> -export DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
> +export DISABLE_SETRANS DISABLE_RPM EMFLAGS
>  
>  USE_PCRE2 ?= n
>  ifeq ($(USE_PCRE2),y)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 8cfdf34..d8a79b4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -41,12 +41,8 @@ LIBSO=$(TARGET).$(LIBVERSION)
>  AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
>  AUDIT2WHYSO=$(PYPREFIX)audit2why.so
>  
> -ifeq ($(DISABLE_BOOL),y)
> -	UNUSED_SRCS+=booleans.c
> -endif
> -
>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
> -SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
> +SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>  
>  MAX_STACK_SIZE=32768
>  
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 249f82f..b7e1a6f 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -256,7 +256,6 @@ checkbool:
>  			}
>  		}
>  		
> -#ifndef DISABLE_BOOL
>  		if (preservebools) {
>  			int *values, len, i;
>  			char **names;
> @@ -279,7 +278,6 @@ checkbool:
>  			(void)genbools(data, size,
>  				       (char *)selinux_booleans_path());
>  		}
> -#endif
>  	}
>  
>  
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 9ec928b..0708d6d 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -36,11 +36,6 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
>  
>  selinux_restorecon: LDLIBS += -lsepol
>  
> -ifeq ($(DISABLE_BOOL),y)
> -	UNUSED_TARGETS+=getsebool togglesebool
> -endif
> -TARGETS:= $(filter-out $(UNUSED_TARGETS), $(TARGETS))
> -
>  all: $(TARGETS)
>  
>  install: all
> 
