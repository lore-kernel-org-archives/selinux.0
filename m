To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
 <20180305225820.23610-2-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <99940932-dcfc-f080-66a3-7254f40a64aa@tycho.nsa.gov>
Date: Wed, 7 Mar 2018 09:53:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180305225820.23610-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 2/3] libsepol: cil: show an error when
 cil_expr_to_string() fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/05/2018 05:58 PM, Nicolas Iooss wrote:
> cil_tree_print_expr() calls cil_expr_to_string() in order to compute a
> string expression into expr_str. If this function fails, expr_str is
> left unitialized but its value is dereferenced with:
> 
>      cil_log(CIL_INFO, "%s)", expr_str);
> 
> Prevent such an issue by checking cil_expr_to_string()'s return value
> before using expr_str.
> 
> This issue has been found with clang's static analyzer.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
>   libsepol/cil/src/cil_tree.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index d36401b41dba..b394a9d849df 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -503,15 +503,19 @@ exit:
>   void cil_tree_print_expr(struct cil_list *datum_expr, struct cil_list *str_expr)
>   {
>   	char *expr_str;
> +	int rc;
>   
>   	cil_log(CIL_INFO, "(");
>   
>   	if (datum_expr != NULL) {
> -		cil_expr_to_string(datum_expr, &expr_str);
> +		rc = cil_expr_to_string(datum_expr, &expr_str);
>   	} else {
> -		cil_expr_to_string(str_expr, &expr_str);
> +		rc = cil_expr_to_string(str_expr, &expr_str);
> +	}
> +	if (rc < 0) {
> +		cil_log(CIL_INFO, "ERROR)");
> +		return;
>   	}
> -
>   	cil_log(CIL_INFO, "%s)", expr_str);
>   	free(expr_str);
>   }
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
