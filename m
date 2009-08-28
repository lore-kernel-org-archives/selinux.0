Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SEHNwG008151
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 10:17:23 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7SEIXSF024105
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 14:18:36 GMT
Message-ID: <4A97E6D9.8010306@manicmethod.com>
Date: Fri, 28 Aug 2009 10:16:57 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: selinux@tycho.nsa.gov, dwalsh@redhat.com, jbrindle@tresys.com
Subject: Re: [PATCH] Fix semanage_direct_commit() to notice disable_dontaudit
References: <1250792957-20920-1-git-send-email-csellers@tresys.com>
In-Reply-To: <1250792957-20920-1-git-send-email-csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> Add code to semanage_direct_commit() to notice that the disable_dontaudit
> flag has been changed and rebuild the policy if so.
>
> Currently, libsemanage doesn't notice that the disable_dontaudit flag is
> set so it does not rebuild the policy. semodule got around this by calling
> semanage_set_rebuild() explicitly, but libsemanage should really notice
> that this has changed and rebuild appropriately.
> ---

nit: I'd rather have a flag in memory that says it changed than probing the 
filesystem over and over, but that is just my personal preference.

Acked-By: Joshua Brindle <method@manicmethod.com>

>   libsemanage/src/direct_api.c |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index d563841..0eab399 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -675,7 +675,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>
>   	/* Declare some variables */
>   	int modified = 0, fcontexts_modified, ports_modified,
> -	    seusers_modified, users_extra_modified;
> +	    seusers_modified, users_extra_modified, dontaudit_modified;
>   	dbase_config_t *users = semanage_user_dbase_local(sh);
>   	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
>   	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
> @@ -694,6 +694,10 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>
>   	/* Create or remove the disable_dontaudit flag file. */
>   	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
> +	if (access(path, F_OK) == 0)
> +		dontaudit_modified = !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
> +	else
> +		dontaudit_modified = (sepol_get_disable_dontaudit(sh->sepolh) == 1);
>   	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
>   		FILE *touch;
>   		touch = fopen(path, "w");
> @@ -734,6 +738,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>   	modified |= bools->dtable->is_modified(bools->dbase);
>   	modified |= ifaces->dtable->is_modified(ifaces->dbase);
>   	modified |= nodes->dtable->is_modified(nodes->dbase);
> +	modified |= dontaudit_modified;
>
>   	/* If there were policy changes, or explicitly requested, rebuild the policy */
>   	if (sh->do_rebuild || modified) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
