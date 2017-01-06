Subject: Re: [PATCH 2/2] libsemanage: fix optimized compile errors
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1482506214.10020.8.camel@trentalancia.net>
 <1482506386.10020.10.camel@trentalancia.net>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <b0c1d43c-a3cc-7f37-5c2f-c8141051f66e@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:21:33 -0500
MIME-Version: 1.0
In-Reply-To: <1482506386.10020.10.camel@trentalancia.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/23/2016 10:19 AM, Guido Trentalancia wrote:
> Fix compile errors when using the "-O -Werror" flags on gcc6.
>
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>

Applied.

I changed the log message to the following:

     libsemanage: Fix unitialized variable compiler warnings

     Fix unitialized variable compiler warnings when using the
     "-O -Werror" flags on gcc6 by initializing the variables in
     question. It was possible for err_data_len to be used without
     initialization, but not cil_data_len.

Thanks,

> ---
>  src/direct_api.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -pru libsemanage-2.6-orig/src/direct_api.c libsemanage-2.6/src/direct_api.c
> --- libsemanage-2.6-orig/src/direct_api.c	2016-10-14 17:31:26.000000000 +0200
> +++ libsemanage-2.6/src/direct_api.c	2016-12-23 15:22:50.101297993 +0100
> @@ -955,8 +955,8 @@ static int semanage_compile_module(seman
>  	ssize_t bzip_status;
>  	int status = 0;
>  	int compressed;
> -	size_t cil_data_len;
> -	size_t err_data_len;
> +	size_t cil_data_len = 0;
> +	size_t err_data_len = 0;
>
>  	if (!strcasecmp(modinfo->lang_ext, "cil")) {
>  		goto cleanup;
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
