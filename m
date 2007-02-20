Subject: Re: PATCH: libsemanage-1.10.0
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd.Miller@sparta.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702071709.l17H9rqk000601@tex.courtesan.com>
References: <200702071709.l17H9rqk000601@tex.courtesan.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:28:54 -0500
Message-Id: <1171985334.14363.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 12:09 -0500, Todd.Miller@sparta.com wrote:
> There is no advantage to using strnlen() over strlen() since buf is
> guaranteed to be a NUL-terminated string.
> 
>  - todd
> 
> --- libsemanage-1.10.0/src/semanage_store.c	2007-01-08 16:20:17.000000000 -0500
> +++ libsemanage-1.10.0/src/semanage_store.c	2007-02-06 17:04:41.000000000 -0500
> @@ -968,14 +968,14 @@
>  		if (!strncmp(buf, "HOME_DIR", 8) ||
>  		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE")) {
>  			/* This contains one of the template variables, write it to homedir.template */
> -			if (write(hd, buf, strnlen(buf, PATH_MAX)) == 0) {
> +			if (write(hd, buf, strlen(buf)) == 0) {
>  				ERR(sh, "Write to %s failed.",
>  				    semanage_path(SEMANAGE_TMP,
>  						  SEMANAGE_HOMEDIR_TMPL));
>  				goto cleanup;
>  			}
>  		} else {
> -			if (write(fc, buf, strnlen(buf, PATH_MAX)) == 0) {
> +			if (write(fc, buf, strlen(buf)) == 0) {
>  				ERR(sh, "Write to %s failed.",
>  				    semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
>  				goto cleanup;
> 

Merged to -stable and to -trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
