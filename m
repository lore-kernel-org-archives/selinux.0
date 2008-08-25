Message-ID: <48B2B8FE.7030603@manicmethod.com>
Date: Mon, 25 Aug 2008 09:51:58 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Yuichi Nakamura <ynakam@hitachisoft.jp>
Subject: Re: [patch] libselinux:  fix EMBEDDED=y build
References: <1219671784.2721.83.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219671784.2721.83.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Fix EMBEDDED=y build for libselinux.
> 
> Before:
> $ make EMBEDDED=y > out
> cc1: warnings being treated as errors
> load_policy.c: In function ‘selinux_mkload_policy’:
> load_policy.c:59: warning: unused variable ‘i’
> load_policy.c:59: warning: unused variable ‘len’
> load_policy.c:59: warning: unused variable ‘values’
> load_policy.c:54: warning: unused variable ‘names’
> make[1]: *** [load_policy.o] Error 1
> 
> After:
> $ make EMBEDDED=y > out
> $ make clean all > out
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

trivial, acked-by: Joshua Brindle <method@manicmethod.com>

> 
> ---
> 
>  libselinux/src/load_policy.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 63f6609..affe37b 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -51,12 +51,12 @@ int selinux_mkload_policy(int preservebools)
>  	int kernvers = security_policyvers();
>  	int maxvers = kernvers, minvers = DEFAULT_POLICY_VERSION, vers;
>  	int setlocaldefs = load_setlocaldefs;
> -	char path[PATH_MAX], **names;
> +	char path[PATH_MAX];
>  	struct stat sb;
>  	struct utsname uts;
>  	size_t size;
>  	void *map, *data;
> -	int fd, rc = -1, *values, len, i, prot;
> +	int fd, rc = -1, prot;
>  	sepol_policydb_t *policydb;
>  	sepol_policy_file_t *pf;
>  	int usesepol = 0;
> @@ -251,6 +251,8 @@ checkbool:
>  		
>  #ifndef DISABLE_BOOL
>  		if (preservebools) {
> +			int *values, len, i;
> +			char **names;
>  			rc = security_get_boolean_names(&names, &len);
>  			if (!rc) {
>  				values = malloc(sizeof(int) * len);
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
