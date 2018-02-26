To: Yuli Khodorkovskiy <ykhodo@gmail.com>, selinux@tycho.nsa.gov
References: <20180224045733.12509-1-ykhodo@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ce2e0966-31da-333d-403c-875ee1db004e@tycho.nsa.gov>
Date: Mon, 26 Feb 2018 09:56:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180224045733.12509-1-ykhodo@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] secilc: Fix documentation build for OS X systems
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/23/2018 11:57 PM, Yuli Khodorkovskiy wrote:
> Since Darwin systems do not have GNU sed installed, the Darwin sed is
> missing the "regexp-extended" flag needed to modify the secilc markdown
> files before processing with pandoc.
> 
> A quick fix for Mac users is to `brew install gnu-sed` and to use gsed.
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>

Thanks, applied.

> ---
>  secilc/docs/Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index c0fa6b7f..6b07ce7f 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -31,6 +31,12 @@ PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
>  PDF_OUT=CIL_Reference_Guide.pdf
>  HTML_OUT=CIL_Reference_Guide.html
>  PANDOC = pandoc
> +SED ?= sed
> +
> +OS := $(shell uname)
> +ifeq ($(OS), Darwin)
> +	SED := gsed
> +endif
>  
>  all: html pdf
>  
> @@ -40,12 +46,12 @@ $(TMPDIR):
>  $(TMPDIR)/%.md: %.md | $(TMPDIR)
>  	cp -f $< $(TMPDIR)/
>  	@# Substitute markdown links for conversion into PDF links
> -	sed -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
> +	$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
>  
>  $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
>  	cp -f $< $@
>  	@# add a title for the TOC to policy.cil. This is needed to play nicely with the PDF conversion.
> -	sed -i '1i Example Policy\n=========\n```' $@
> +	$(SED) -i '1i Example Policy\n=========\n```' $@
>  	echo '```' >> $@
>  
>  html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> 
