Subject: Re: [PATCH] semanage: optionally remove previous and linked to
	reduce disck usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <459D31C2.2030409@mentalrootkit.com>
References: <459D31C2.2030409@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 10:12:04 -0500
Message-Id: <1168009924.18961.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-04 at 11:56 -0500, Karl MacMillan wrote:
> This patch adds two options to the semanage config file to control 
> whether the previous module directory and linked module are saved after 
> a successful commit to the policy store. The default is to delete both.
> 
> On my system this reduces the size of the module directory from 78mb to 
> 22mb.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

A couple of minor suggestions...

> diff -r 5a199c52a29c libsemanage/src/conf-parse.y
> --- a/libsemanage/src/conf-parse.y	Wed Jan 03 22:27:17 2007 -0500
> +++ b/libsemanage/src/conf-parse.y	Thu Jan 04 11:48:29 2007 -0500
> @@ -112,6 +114,24 @@ file_mode:   FILE_MODE '=' ARG  {
>                   }
>           ;
> 
> +save_previous:    SAVE_PREVIOUS '=' ARG {
> +	                if (strcmp($3, "true") == 0)

Use strcasecmp() here

> +		                current_conf->save_previous = 1;
> +			else

Explicitly check for "false" here.

> +				current_conf->save_previous = 0;

Add another else clause to report an error otherwise.

> 		
> +                }
> +        ;
> +
> +
> +save_linked:    SAVE_LINKED '=' ARG {
> +	                if (strcmp($3, "true") == 0)
> +		                current_conf->save_linked = 1;
> +			else
> +				current_conf->save_linked = 0;

Ditto.

> @@ -284,6 +307,7 @@ void semanage_conf_destroy(semanage_conf
> 
>   int semanage_error(char *msg)
>   {
> +	fprintf(stderr, "error parsing semanage configuration file: %s\n", msg);
>   	parse_errors++;
>   	return 0;
>   }

Offhand, this seems inconsistent with the standard error reporting
mechanism in libsemanage, but naturally we don't have a handle here, and
the generated parser/scanner will use stderr too.  No change required
here I suppose, but not ideal for a library.

> diff -r 5a199c52a29c libsemanage/src/semanage_store.c
> --- a/libsemanage/src/semanage_store.c	Wed Jan 03 22:27:17 2007 -0500
> +++ b/libsemanage/src/semanage_store.c	Thu Jan 04 11:48:29 2007 -0500
> @@ -1224,6 +1224,10 @@ static int semanage_commit_sandbox(seman
>   		goto cleanup;
>   	}
> 
> +	if (sh->conf->save_previous != 1) {

Simplify as if (!sh->conf->save_previous)

> +		retval = semanage_remove_directory(backup);

Needs an ERR() statement to report the error?
And should it be an error or just a warning, as the actual commit did
succeed?

> +	}
> +
>         cleanup:
>   	semanage_release_active_lock(sh);
>   	return retval;
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
