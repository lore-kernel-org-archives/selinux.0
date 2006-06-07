Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k57HjdjQ014329
	for <selinux@tycho.nsa.gov>; Wed, 7 Jun 2006 13:45:41 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k57Hjd5V016793
	for <selinux@tycho.nsa.gov>; Wed, 7 Jun 2006 17:45:39 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44863F06.90206@comcast.net>
References: <44863F06.90206@comcast.net>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 13:46:24 -0400
Message-Id: <1149702384.13094.68.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-06 at 22:50 -0400, Daniel J Walsh wrote:
> A change to the glibc interface is causing lots of domains to want to 
> read the routing database.

We should figure out what this is related to, in case it fits better in
an existing interface (my wild guess is sysnet_dns_name_resolve()).

> Add wine definition in picasa

Then we can get Google to stop suggesting that FC users switch to
permissive to use it :)

> Add oprofilefs_t

moved to filesystem

> More changes to get bluetooth to work with startx

Merged the write socket interface into the stream connect interface.

> Lots of changes for nss_ldap + Reading of certs

Perhaps these domains should be using auth_use_nsswitch(), and reading
of certs should be added to that interface?

> pegasus_domtrans added for uncofined_domain

Why is this needed?  Its a service, and the transition to initrc should
take care of restarts.  Related comment farther down.

> Lots of pegasus fixes to make it work correctly and pass self test.

See comments below.

> -init_domain(consoletype_t,consoletype_exec_t)
> +#dont transition from initrc
> +#init_domain(consoletype_t,consoletype_exec_t)
> +domain_type(consoletype_t)
> +domain_entry_file(consoletype_t,consoletype_exec_t)
> +role system_r types consoletype_t;

>From the comment you have here, this is wrong since init_domain() is for
running it from init itself, not initrc.

> +       ifdef(`targeted_policy',`
> +               if(pegasus_disable_trans) {
> +                       can_exec($1,pegasus_exec_t)
> +               } else {
> +                       domain_auto_trans($1,pegasus_exec_t,pegasus_t)
> +               }
> +       ', `
> +               domain_auto_trans($1,pegasus_exec_t,pegasus_t)
> +       ')

Why is this conditional?

> @@ -97,13 +99,12 @@
>  
>  auth_use_nsswitch(pegasus_t)
>  auth_domtrans_chk_passwd(pegasus_t)
> +auth_read_shadow(pegasus_t)
>  
>  domain_use_interactive_fds(pegasus_t)
>  domain_read_all_domains_state(pegasus_t)
>  
> -files_read_etc_files(pegasus_t)
> -files_list_var_lib(pegasus_t)
> -files_read_var_lib_files(pegasus_t)
> +files_read_all_files(pegasus_t)
>  files_read_var_lib_symlinks(pegasus_t)


The above added lines seem way too privileged.

>  type auditd_etc_t;
> +ifdef(`enable_mls',`', `
>  files_security_file(auditd_etc_t)
> +')
>  
>  type auditd_log_t;
> +ifdef(`enable_mls',`', `
>  files_security_file(auditd_log_t)
> +')

This is not an acceptable way of excluding access to these files.  My
feeling is that the better way would be to change sysadm's (and any
other domain that has this concern) access to "all files but shadow" to
"all files but security files" for mls policies.

> +/usr/bin/mplayer 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)

It would be cleaner if we made mplayer_exec_t an alias of
unconfined_execmem_exec_t in the targeted policy, and the other two exec
files in the mplayer module aliases of bin, and just include that
module.  Then if someone happens to have the mplayer module included
too, there won't be conflicting fc specifications.

The alias interface that needs to be added can be modeled after
corecmd_bin_alias().

> +interface(`unconfined_execmem_domtrans',`
> +	ifdef(`targeted_policy',`
> +		gen_require(`
> +			type unconfined_execmem_t, unconfined_execmem_exec_t;
> +		')
> +
> +		corecmd_search_bin($1)
> +		domain_auto_trans($1, unconfined_execmem_exec_t, unconfined_execmem_t)
> +
> +		allow $1 unconfined_execmem_t:fd use;
> +		allow unconfined_execmem_t $1:fd use;
> +		allow unconfined_execmem_t $1:fifo_file rw_file_perms;
> +		allow unconfined_execmem_t $1:process sigchld;
> +	',`
> +		errprint(`Warning: $0($1) has no effect in strict policy.'__endline__)
> +	')
> +')

I believe this should just be moved into unconfined_domtrans().  If
you're transitioning from a confined domain to either of the unconfined
domains, all bets are pretty much off already.  Differentiating them
just seems like it will cause headaches, so it would be best to be as
transparent as possible.

The remainder should be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
