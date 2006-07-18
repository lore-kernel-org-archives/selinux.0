Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6IF8YCi012864
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 11:08:34 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6IF8Xt3004210
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 15:08:33 GMT
Subject: Re: [PATCH 3/6] netfilter integration: module store support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153168354.10090.48.camel@sgc>
References: <1153168354.10090.48.camel@sgc>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 11:08:31 -0400
Message-Id: <1153235311.10744.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
> Adds support for committing the netfilter_contexts file, and copying it
> out to the running system.
> 
>  libsemanage/src/direct_api.c     |   25 ++++++++++++++++++-------
>  libsemanage/src/semanage_store.c |   11 +++++++++++
>  libsemanage/src/semanage_store.h |    1 +
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff -purN trunk/libsemanage/src/direct_api.c newtrunk/libsemanage/src/direct_api.c
> --- trunk/libsemanage/src/direct_api.c	2006-07-03 10:42:01.031370000 -0400
> +++ newtrunk/libsemanage/src/direct_api.c	2006-07-14 11:39:21.272701250 -0400
> @@ -438,8 +438,8 @@ static int semanage_write_module(semanag
>  static int semanage_direct_commit(semanage_handle_t * sh)
>  {
>  	char **mod_filenames = NULL;
> -	char *sorted_buffer = NULL;
> -	size_t sorted_buffer_len = 0;
> +	char *sorted_fc_buffer = NULL, *sorted_nc_buffer = NULL;
> +	size_t sorted_fc_buffer_len = 0, sorted_nc_buffer_len = 0;
>  	const char *linked_filename = NULL, *ofilename = NULL;
>  	sepol_module_package_t *base = NULL;
>  	int retval = -1, num_modfiles = 0, i;
> @@ -521,17 +521,17 @@ static int semanage_direct_commit(semana
>  		if (semanage_fc_sort
>  		    (sh, sepol_module_package_get_file_contexts(base),
>  		     sepol_module_package_get_file_contexts_len(base),
> -		     &sorted_buffer, &sorted_buffer_len) == -1) {
> +		     &sorted_fc_buffer, &sorted_fc_buffer_len) == -1) {
>  			goto cleanup;
>  		}
>  
>  		/* Write the contexts (including template contexts) to a single file.  
>  		 * The buffer returned by the sort function has a trailing \0 character,
> -		 * which we do NOT want to write out to disk, so we pass sorted_buffer_len-1. */
> +		 * which we do NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
>  		if ((ofilename =
>  		     semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL
> -		    || write_file(sh, ofilename, sorted_buffer,
> -				  sorted_buffer_len - 1) == -1) {
> +		    || write_file(sh, ofilename, sorted_fc_buffer,
> +				  sorted_fc_buffer_len - 1) == -1) {
>  			goto cleanup;
>  		}
>  

Both of those if blocks are very difficult to parse and adding even more
expressions to them just makes it worse. I don't know what Steve thinks,
but blindly continuing poor coding practices will just make the code
base worse over time (which I think has happened). I would prefer to see
cleanups happen when the code is being changed.

> @@ -580,6 +580,16 @@ static int semanage_direct_commit(semana
>  				goto cleanup;
>  		}
>  
> +		/* Write the contexts to a single file.  The buffer returned by
> +		 * the sort function has a trailing \0 character, which we do
> +		 * NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
> +		if ((ofilename =
> +		     semanage_path(SEMANAGE_TMP, SEMANAGE_NC)) == NULL
> +		    || write_file(sh, ofilename, sorted_nc_buffer,
> +				  sorted_nc_buffer_len - 1) == -1) {
> +			goto cleanup;
> +		}
> +

Same here. This could be made much clearer - for example:

ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_NC);

if (ofilename == NULL) {
	goto cleanup;
}

ret = write_file(sh, ofilename, sorted_nc_buffer,
                 sorted_nc_buffer_len -  1);
if (ret < 0) {
	goto cleanup.
}

To me that makes the intent much clearer. It may be longer, but it is
faster to read and understand.

Also, you are continuing to only check for -1 as error and provide no
opportunity for other error codes to propagate.

>  		/* ==================== Policydb-backed ================ */
>  
>  		/* Create new policy object, then attach to policy databases
> @@ -657,7 +667,8 @@ static int semanage_direct_commit(semana
>  	sepol_policydb_free(out);
>  	semanage_release_trans_lock(sh);
>  
> -	free(sorted_buffer);
> +	free(sorted_fc_buffer);
> +	free(sorted_nc_buffer);
>  
>  	/* regardless if the commit was successful or not, remove the
>  	   sandbox if it is still there */
> diff -purN trunk/libsemanage/src/semanage_store.c newtrunk/libsemanage/src/semanage_store.c
> --- trunk/libsemanage/src/semanage_store.c	2006-07-11 11:53:29.388406000 -0400
> +++ newtrunk/libsemanage/src/semanage_store.c	2006-07-14 11:40:48.898177500 -0400
> @@ -108,6 +108,7 @@ static const char *semanage_sandbox_path
>  	"/users_extra.local",
>  	"/seusers.final",
>  	"/users_extra",
> +	"/netfilter_contexts",
>  };
>  
>  /* A node used in a linked list of file contexts; used for sorting.
> @@ -1000,11 +1001,13 @@ static int semanage_install_active(seman
>  	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
>  	const char *active_seusers =
>  	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
> +	const char *active_nc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NC);
>  
>  	const char *running_fc = selinux_file_context_path();
>  	const char *running_hd = selinux_homedir_context_path();
>  	const char *running_policy = selinux_binary_policy_path();
>  	const char *running_seusers = selinux_usersconf_path();
> +	const char *running_nc = selinux_netfilter_context_path();
>  	const char *really_active_store = selinux_policy_root();
>  
>  	/* This is very unelegant, the right thing to do is export the path 
> @@ -1014,12 +1017,14 @@ static int semanage_install_active(seman
>  	char store_hd[PATH_MAX];
>  	char store_pol[PATH_MAX];
>  	char store_seusers[PATH_MAX];
> +	char store_nc[PATH_MAX];
>  
>  	len = strlen(really_active_store);
>  	running_fc += len;
>  	running_hd += len;
>  	running_policy += len;
>  	running_seusers += len;
> +	running_nc += len;
>  
>  	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
>  	storepath = (char *)malloc(len);
> @@ -1056,6 +1061,12 @@ static int semanage_install_active(seman
>  		/* Non-fatal; fall through */
>  	}
>  
> +	snprintf(store_nc, PATH_MAX, "%s%s", storepath, running_nc);
> +	if (semanage_copy_file(active_nc, store_nc, sh->conf->file_mode) == -1) {
> +		ERR(sh, "Could not copy %s to %s.", active_nc, store_nc);
> +		goto cleanup;
> +	}
> +
>  	if (!sh->do_reload)
>  		goto skip_reload;
>  
> diff -purN trunk/libsemanage/src/semanage_store.h newtrunk/libsemanage/src/semanage_store.h
> --- trunk/libsemanage/src/semanage_store.h	2006-07-03 10:42:01.031370000 -0400
> +++ newtrunk/libsemanage/src/semanage_store.h	2006-07-14 11:39:34.561531750 -0400
> @@ -56,6 +56,7 @@ enum semanage_sandbox_defs {
>  	SEMANAGE_USERS_EXTRA_LOCAL,
>  	SEMANAGE_SEUSERS,
>  	SEMANAGE_USERS_EXTRA,
> +	SEMANAGE_NC,
>  	SEMANAGE_STORE_NUM_PATHS
>  };
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
