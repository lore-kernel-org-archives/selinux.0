Message-ID: <436FCC19.6020700@tresys.com>
Date: Mon, 07 Nov 2005 16:50:17 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] semanage - rename instead of copy
References: <1131398734.21419.3.camel@twoface.columbia.tresys.com> <1131399305.20591.151.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131399305.20591.151.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2005-11-07 at 16:25 -0500, Joshua Brindle wrote:
> 
>>Attached patch makes libsemanage copy file to a temporary file and then
>>rename() instead of copying directly to the target. This is necessary so
>>that an install failure doesn't leave a corrupt binary policy on the
>>system.
> 
> 
> diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
> --- libsemanage/src/semanage_store.c	2005-11-07 11:52:28.000000000 -0500
> +++ libsemanage/src/semanage_store.c	2005-11-07 16:06:04.000000000 -0500
> @@ -305,12 +305,18 @@ static int semanage_filename_select(cons
>   * overwrite it.  Returns 0 on success, -1 on error. */
>  static int semanage_copy_file(const char *src, const char *dst) {
>  	int in, out, retval = 0, amount_read;
> +	char tmp[PATH_MAX] = {};
>  	char buf[4192];
>  
>  	if ((in = open(src, O_RDONLY)) == -1) {
>  		return -1;
>  	}
> -	if ((out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
> +	
> +	snprintf(tmp, PATH_MAX, "%s.tmp", dst);
> +	if (!tmp)
> +		return -1;
> +
> 
> If you want to check for failure on the snprintf, you need something like:
> 	int n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
> 	if (n < 0 || n >= PATH_MAX)
> 		return -1;
> 
good point, also strlen(dst) can't be PATH_MAX or the filename will be 
truncated and you'll end up with rename(dst,dst). Do you want a new 
patch or are you going to fix this before commiting?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
