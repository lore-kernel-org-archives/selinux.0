Subject: Re: [PATCH 1/2] libselinux: fix optimized compile errors
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1482506214.10020.8.camel@trentalancia.net>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <ac0250fc-9527-b27a-868a-1e5feaa2387a@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:20:30 -0500
MIME-Version: 1.0
In-Reply-To: <1482506214.10020.8.camel@trentalancia.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/23/2016 10:16 AM, Guido Trentalancia wrote:
> Fix compile errors when using the "-O3 -Werror" flags on gcc6.
>
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>

Applied.

I changed the log message to the following:

     libselinux: Fix unitialized variable compiler warnings

     Fix unitialized variable compiler warnings when using the
     "-O3 -Werror" flags on gcc6 by initializing the variables in
     question. The variables were never used before being initialized.


Thanks,

> ---
>  src/fgetfilecon.c |    2 +-
>  src/getfilecon.c  |    2 +-
>  src/lgetfilecon.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff -pru libselinux-2.6-orig/src/fgetfilecon.c libselinux-2.6/src/fgetfilecon.c
> --- libselinux-2.6-orig/src/fgetfilecon.c	2016-10-14 17:31:26.000000000 +0200
> +++ libselinux-2.6/src/fgetfilecon.c	2016-12-23 15:19:23.642205413 +0100
> @@ -53,7 +53,7 @@ hidden_def(fgetfilecon_raw)
>
>  int fgetfilecon(int fd, char ** context)
>  {
> -	char * rcontext;
> +	char * rcontext = NULL;
>  	int ret;
>
>  	*context = NULL;
> diff -pru libselinux-2.6-orig/src/getfilecon.c libselinux-2.6/src/getfilecon.c
> --- libselinux-2.6-orig/src/getfilecon.c	2016-10-14 17:31:26.000000000 +0200
> +++ libselinux-2.6/src/getfilecon.c	2016-12-23 15:19:39.849448184 +0100
> @@ -54,7 +54,7 @@ hidden_def(getfilecon_raw)
>  int getfilecon(const char *path, char ** context)
>  {
>  	int ret;
> -	char * rcontext;
> +	char * rcontext = NULL;
>
>  	*context = NULL;
>
> diff -pru libselinux-2.6-orig/src/lgetfilecon.c libselinux-2.6/src/lgetfilecon.c
> --- libselinux-2.6-orig/src/lgetfilecon.c	2016-10-14 17:31:26.000000000 +0200
> +++ libselinux-2.6/src/lgetfilecon.c	2016-12-23 15:19:52.489637524 +0100
> @@ -54,7 +54,7 @@ hidden_def(lgetfilecon_raw)
>  int lgetfilecon(const char *path, char ** context)
>  {
>  	int ret;
> -	char * rcontext;
> +	char * rcontext = NULL;
>
>  	*context = NULL;
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
