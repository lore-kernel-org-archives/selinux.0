Message-ID: <1508789827.24902.6.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Date: Mon, 23 Oct 2017 16:17:07 -0400
In-Reply-To: <20171019155647.26565-1-richard_c_haines@btinternet.com>
References: <20171019155647.26565-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux-testsuite: Stop Infiniband building if not enabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-10-19 at 16:56 +0100, Richard Haines wrote:
> The default is not to test, however it still tries to build
> create_modify_qp.c that requires a header and library that may not
> exist.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  tests/infiniband_pkey/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/infiniband_pkey/Makefile
> b/tests/infiniband_pkey/Makefile
> index 60f0d24..4fa6fb2 100644
> --- a/tests/infiniband_pkey/Makefile
> +++ b/tests/infiniband_pkey/Makefile
> @@ -2,6 +2,14 @@ TARGETS=create_modify_qp
>  
>  LDLIBS+= -libverbs
>  
> -all: $(TARGETS)
> +RESULT=$(shell grep "SELINUX_INFINIBAND_PKEY_TEST=0"
> ./ibpkey_test.conf)
> +
> +ifeq  ($(RESULT), )
> +    all: $(TARGETS)
> +else
> +    all:
> +	@echo "Infiniband test disabled"
> +endif
> +
>  clean:
>  	rm -f $(TARGETS)
