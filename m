Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03CRmZ6023688
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 07:27:48 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l03CSXDt024845
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 12:28:33 GMT
Message-ID: <459BA16D.8090300@tresys.com>
Date: Wed, 03 Jan 2007 07:28:29 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] correct return value handling in libsemanage
References: <458B10CE.6000201@mentalrootkit.com>
In-Reply-To: <458B10CE.6000201@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> The function semanage_direct_commit in libsemanage:direct_api.c does 
> not correctly propagate error codes. This patch fixes that.
>
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>
Acked-By: Joshua Brindle <jbrindle@tresys.com>
>
> diff -r 1ecfd5befe3f src/direct_api.c
> --- a/src/direct_api.c    Thu Dec 21 17:09:45 2006 -0500
> +++ b/src/direct_api.c    Thu Dec 21 17:47:06 2006 -0500
> @@ -603,7 +603,8 @@ static int semanage_direct_commit(semana
>
>          /* Create new policy object, then attach to policy databases
>           * that work with a policydb */
> -        if (semanage_expand_sandbox(sh, base, &out) < 0)
> +        retval = semanage_expand_sandbox(sh, base, &out);
> +        if (retval < 0)
>              goto cleanup;
>
>          dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
> @@ -615,13 +616,16 @@ static int semanage_direct_commit(semana
>
>          /* ============= Apply changes, and verify  =============== */
>
> -        if (semanage_base_merge_components(sh) < 0)
> -            goto cleanup;
> -
> -        if (semanage_write_policydb(sh, out) < 0)
> -            goto cleanup;
> -
> -        if (semanage_verify_kernel(sh) != 0)
> +        retval = semanage_base_merge_components(sh);
> +        if (retval < 0)
> +            goto cleanup;
> +
> +        retval = semanage_write_policydb(sh, out);
> +        if (retval < 0)
> +            goto cleanup;
> +
> +        retval = semanage_verify_kernel(sh);
> +        if (retval < 0)
>              goto cleanup;
>      }
>
> @@ -635,26 +639,30 @@ static int semanage_direct_commit(semana
>       * merged into the main file_contexts. We won't check the
>       * large file_contexts - checked at compile time */
>      if (sh->do_rebuild || modified || fcontexts_modified) {
> -        if (semanage_fcontext_validate_local(sh, out) < 0)
> +        retval = semanage_fcontext_validate_local(sh, out);
> +        if (retval < 0)
>              goto cleanup;
>      }
>
>      /* Validate local seusers against policy */
>      if (sh->do_rebuild || modified || seusers_modified) {
> -        if (semanage_seuser_validate_local(sh, out) < 0)
> +        retval = semanage_seuser_validate_local(sh, out);
> +        if (retval < 0)
>              goto cleanup;
>      }
>
>      /* Validate local ports for overlap */
>      if (sh->do_rebuild || ports_modified) {
> -        if (semanage_port_validate_local(sh) < 0)
> +        retval = semanage_port_validate_local(sh);
> +        if (retval < 0)
>              goto cleanup;
>      }
>
>      /* ================== Write non-policydb components ========= */
>
>      /* Commit changes to components */
> -    if (semanage_commit_components(sh) < 0)
> +    retval = semanage_commit_components(sh);
> +    if (retval < 0)
>          goto cleanup;
>
>      retval = semanage_install_sandbox(sh);
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
