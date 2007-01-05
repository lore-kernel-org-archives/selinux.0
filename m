Subject: Re: [PATCH] semanage: optionally remove previous and linked
	to	reduce disck usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <459E7A96.9070909@mentalrootkit.com>
References: <459D31C2.2030409@mentalrootkit.com>
	 <1168009924.18961.131.camel@moss-spartans.epoch.ncsc.mil>
	 <459E7A96.9070909@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 13:40:12 -0500
Message-Id: <1168022412.18961.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-05 at 11:19 -0500, Karl MacMillan wrote:
> New version below:
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

> diff -r 5eec2dbb1b6c libsemanage/src/direct_api.c
> --- a/libsemanage/src/direct_api.c	Fri Jan 05 11:18:13 2007 -0500
> +++ b/libsemanage/src/direct_api.c	Fri Jan 05 11:19:01 2007 -0500
> @@ -509,18 +509,35 @@ static int semanage_direct_commit(semana
>   		if (retval < 0)
>   			goto cleanup;
> 
> -		/* write the linked base */
> +		/* write the linked base if we want to save or we have a
> +		 * verification program that wants it. */
>   		linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
>   		if (linked_filename == NULL) {
>   			retval = -1;
>   			goto cleanup;
>   		}
> -		retval = semanage_write_module(sh, linked_filename, base);
> -		if (retval < 0)
> -			goto cleanup;
> -		retval = semanage_verify_linked(sh);
> -		if (retval < 0)
> -			goto cleanup;
> +		if (sh->conf->save_linked || sh->conf->linked_prog) {
> +			retval = semanage_write_module(sh, linked_filename, base);
> +			if (retval < 0)
> +				goto cleanup;
> +			retval = semanage_verify_linked(sh);
> +			if (retval < 0)
> +				goto cleanup;
> +			/* remove the linked policy if we only wrote it for the
> +			 * verification program. */
> +			if (!sh->conf->save_linked) {
> +				retval = unlink(linked_filename);
> +				if (retval < 0)
> +					goto cleanup;

Likely need an error message here too.

> diff -r 5eec2dbb1b6c libsemanage/src/semanage_store.c
> --- a/libsemanage/src/semanage_store.c	Fri Jan 05 11:18:13 2007 -0500
> +++ b/libsemanage/src/semanage_store.c	Fri Jan 05 11:19:01 2007 -0500
> @@ -1224,6 +1224,12 @@ static int semanage_commit_sandbox(seman
>   		goto cleanup;
>   	}
> 
> +	if (!sh->conf->save_previous) {
> +		retval = semanage_remove_directory(backup);
> +		ERR(sh, "Could not delete previous directory %s.", backup);

That will be a little noisy (not conditional on retval) ;)

> +		goto cleanup;
> +	}
> +
>         cleanup:
>   	semanage_release_active_lock(sh);
>   	return retval;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
