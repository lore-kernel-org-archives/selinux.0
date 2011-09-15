Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FEa3l1028071
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 10:36:03 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FEa27x023213
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 14:36:02 GMT
Message-ID: <4E720D50.1040504@tresys.com>
Date: Thu, 15 Sep 2011 10:36:00 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] CIL compiler - Generate initial SIDs correctly in
 binary policy.
References: <1315233555.55198.YahooMailClassic@web87015.mail.ird.yahoo.com>
In-Reply-To: <1315233555.55198.YahooMailClassic@web87015.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/05/2011 10:39 AM, Richard Haines wrote:
> When running the CIL compiler, only the first initial SID was added to each entry of the binary file. This patch adds a counter to increment the SID count when writing out the file. This patch may not be the best way to achieve this, so I recommend that the CIL team review.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/cil_binary.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/src/cil_binary.c b/src/cil_binary.c
> index ffe4f56..061a706 100644
> --- a/src/cil_binary.c
> +++ b/src/cil_binary.c
> @@ -42,6 +42,8 @@
>  #include "cil_mem.h"
>  #include "cil_tree.h"
>  
> +static int sid_counter = 1;
> +
>  struct cil_args_binary {
>  	const struct cil_db *db;
>  	policydb_t *pdb;
> @@ -1930,7 +1932,7 @@ int cil_sid_to_policydb(policydb_t *pdb, struct cil_tree_node *node)
>  	new_sepol_sidcon->next = pdb->ocontexts[OCON_ISID];
>  	pdb->ocontexts[OCON_ISID] = new_sepol_sidcon;
>  
> -	new_sepol_sidcon->sid[0] = pdb->ocontexts[OCON_ISID]->sid[0] + 1;
> +	new_sepol_sidcon->sid[0] = pdb->ocontexts[OCON_ISID]->sid[0] + sid_counter++;
>  	new_sepol_sidcon->u.name = cil_strdup(cil_sid->datum.name);
>  
>  	sepol_context = &new_sepol_sidcon->context[0];

Thanks for the patch/bug report. The problem was actually that we were
prepending the new sidcotext to the ocontexts linked list too early, so
we were using the new sidcontext instead of the previous sidcontext when
determining the new index. This should be fixed in the git repo in
commit 6909d32b23822490ebde13683088bf8f80c59ef1.

Thanks!
- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
