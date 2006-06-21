Subject: Re: I have redone the original patch for libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44985A88.809@redhat.com>
References: <4497FCCF.1030805@redhat.com>
	 <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>
	 <44981564.9020106@redhat.com>
	 <1150822180.17557.141.camel@moss-spartans.epoch.ncsc.mil>
	 <44982C2C.5050405@redhat.com>
	 <1150824833.17557.180.camel@moss-spartans.epoch.ncsc.mil>
	 <1150826101.17557.183.camel@moss-spartans.epoch.ncsc.mil>
	 <44985A88.809@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 13:50:37 -0400
Message-Id: <1150912237.27531.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-20 at 16:28 -0400, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.30.15/include/selinux/selinux.h
> --- nsalibselinux/include/selinux/selinux.h	2006-06-16 15:08:24.000000000 -0400
> +++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-20 15:48:14.000000000 -0400
> @@ -429,8 +429,20 @@
>     Caller must free the returned strings via free. */
>  extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
>  
> +/* This function allows you to compare two security context, it will ignore the 
> +user component */
> +int selinux_context_cmp(const security_context_t a, const security_context_t b);

I think I'd make this:
/* Compare two file security contexts.  Return 0 if equivalent. */
int selinux_file_context_cmp(const char *s1, const char *s2);

Rationale:  User identity does matter in process security contexts, so
we don't want people to use such a function on arbitrary contexts.  We
also don't want the user-specific aspect in the interface at all, even
in the comment; the caller just wants to know if the two file contexts
should be treated as equivalent.

> +/* This function looks at the file context on disk and compares it to the 
> +system defaults, it returns 1 on match non 0 on failure */
> +int selinux_verify_file_context(const char *path, mode_t mode);

Should that be return 0 on match?  

> +int selinux_verify_file_context(const char *path, mode_t mode)
> +{
> + 	security_context_t con = NULL;
> + 	security_context_t fcontext = NULL;
> +	int rc=0;
> +
> +	if (myflags & MATCHPATHCON_NOTRANS) 
> +		rc = lgetfilecon_raw(path, &con);
> +	else 
> +		rc = lgetfilecon(path, &con);

Why not just set MATCHPATHCON_NOTRANS as you do in
selinux_lsetfilecon_default, and then always use lgetfilecon_raw here?
Then the caller doesn't need to set it himself, and you always avoid
extraneous translations in this function.

> +	if (matchpathcon(path,mode,&fcontext) != 0)  {
> +		if (fcontext == NULL && errno != ENOENT) 
> +			rc = 1;
> +		else
> +			rc = 0;
> +	} 

fcontext == NULL test seems unnecessary; matchpathcon failed, so there
should be no result.

> +int selinux_lsetfilecon_default(const char *path) {
> +	struct stat st;
> +	int rc = -1;
> +	security_context_t scontext=NULL;
> +	unsigned int localflags=myflags;
> +	if (lstat(path, &st) != 0)
> +		return rc;
> +
> +	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
> +
> +	/* If there's an error determining the context, or it has none, 
> +	   return to allow default context */
> +	if (matchpathcon(path, st.st_mode, &scontext)) {
> +		if (scontext == NULL && errno != ENOENT) 
> +			rc =0;

scontext == NULL test seems unnecessary.  Shouldn't that be errno ==
ENOENT (i.e. if there was no matching entry in file_contexts, return
success).

> +	} else 	{
> +		rc = lsetfilecon_raw(path, scontext);
> +		freecon(scontext);
> +	}
> +	set_matchpathcon_flags(localflags);
> +	return rc;
> +}

Likely should make myflags per-thread for safety in case we have any
threaded callers.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
