Subject: Re: [patch] Bug in restorecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070605092055.53351659.ynakam@hitachisoft.jp>
References: <20070604031847.0ec6c158.ynakam@hitachisoft.jp>
	 <1180963724.14220.27.camel@moss-spartans.epoch.ncsc.mil>
	 <20070605092055.53351659.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 10:06:07 -0400
Message-Id: <1181052367.25769.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 09:20 +0900, Yuichi Nakamura wrote:
> On Mon, 04 Jun 2007 09:28:44 -0400
> Stephen Smalley wrote:
> > On Mon, 2007-06-04 at 03:18 +0900, Yuichi Nakamura wrote:
> > In that case, why have 'fullname' vs. 'name' at all?  Just directly
> > manipulate name and use it throughout.
> fullname is unnecessary, so removed.
> 
> > Make sure that setfiles -r /path/to/altroot
> > file_contexts /path/to/altroot still works as expected, e.g.
> > labels /path/to/altroot/etc/shadow with the label of /etc/shadow in
> > policy.
> I tested, 
> "touch /altroot/etc/shadow, setfiles -r /altroot"
> then /altroot/etc/shadow was labeled as same label for /etc/shadow.
> 
> Please see below patch.

Thanks, merged onto trunk.

> 
> Index: policycoreutils/setfiles/setfiles.c
> ===================================================================
> --- policycoreutils/setfiles/setfiles.c	(revision 2457)
> +++ policycoreutils/setfiles/setfiles.c	(working copy)
> @@ -146,20 +146,19 @@
>  int match(const char *name, struct stat *sb, char **con)
>  {
>  	int ret;
> -	const char *fullname = name;
>  	char path[PATH_MAX + 1];
>  
>  	if (excludeCtr > 0) {
> -		if (exclude(fullname)) {
> +		if (exclude(name)) {
>  			return -1;
>  		}
>  	}
> -	ret = lstat(fullname, sb);
> +	ret = lstat(name, sb);
>  	if (ret) {
>  		if (ignore_enoent && errno == ENOENT)
>  			return 0;
>  		fprintf(stderr, "%s:  unable to stat file %s: %s\n", progname,
> -			fullname, strerror(errno));
> +			name, strerror(errno));
>  		return -1;
>  	}
>  
> @@ -168,12 +167,12 @@
>  			if (verbose > 1)
>  				fprintf(stderr,
>  					"Warning! %s refers to a symbolic link, not following last component.\n",
> -					fullname);
> +					name);
>  			char *p = NULL, *file_sep;
> -			char *tmp_path = strdupa(fullname);
> +			char *tmp_path = strdupa(name);
>  			size_t len = 0;
>  			if (!tmp_path) {
> -				fprintf(stderr, "strdupa on %s failed:  %s\n", fullname,
> +				fprintf(stderr, "strdupa on %s failed:  %s\n", name,
>  					strerror(errno));
>  				return -1;
>  			}
> @@ -192,7 +191,7 @@
>  			if (p)
>  				len = strlen(p);
>  			if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
> -				fprintf(stderr, "realpath(%s) failed %s\n", fullname,
> +				fprintf(stderr, "realpath(%s) failed %s\n", name,
>  					strerror(errno));
>  				return -1;
>  			}
> @@ -203,25 +202,24 @@
>  				p++;
>  			}
>  			strcpy(p, file_sep);
> -			fullname = path;
> -			if (excludeCtr > 0 && exclude(fullname))
> +			name = path;
> +			if (excludeCtr > 0 && exclude(name))
>  				return -1;
>  		} else {
>  			char *p;
> -			p = realpath(fullname, path);
> +			p = realpath(name, path);
>  			if (!p) {
> -				fprintf(stderr, "realpath(%s) failed %s\n", fullname,
> +				fprintf(stderr, "realpath(%s) failed %s\n", name,
>  					strerror(errno));
>  				return -1;
>  			}
> -			fullname = p;
> -			if (excludeCtr > 0 && exclude(fullname))
> +			name = p;
> +			if (excludeCtr > 0 && exclude(name))
>  				return -1;
>  		}
>  	}
> -
> -	/* fullname will be the real file that gets labeled
> -	 * name will be what is matched in the policy */
> +	
> +	/* name will be what is matched in the policy */
> 
> 
> Regards,
> Yuichi Nakamura
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
