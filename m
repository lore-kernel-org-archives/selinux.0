Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SJrwI8031714
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 15:53:58 -0400
Subject: Re: [PATCH] libsepol/cil: Add hexadecimal support for Xen ioportcon
 statements
To: selinux@tycho.nsa.gov
References: <1490209288-10691-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f7bb15c4-8cdb-f80c-9305-1036fe3f1260@tycho.nsa.gov>
Date: Tue, 28 Mar 2017 15:54:25 -0400
MIME-Version: 1.0
In-Reply-To: <1490209288-10691-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/22/2017 03:01 PM, James Carter wrote:
> Add hexadecimal support for Xen ioportcon statements which was
> left out of commit c408c70.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

This has been applied.

Jim

> ---
>  libsepol/cil/src/cil_build_ast.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 442f100..8a19df4 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4689,12 +4689,12 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
>  	if (parse_current->next->cl_head != NULL) {
>  		if (parse_current->next->cl_head->next != NULL &&
>  		    parse_current->next->cl_head->next->next == NULL) {
> -			rc = cil_fill_integer(parse_current->next->cl_head, &ioportcon->ioport_low, 10);
> +			rc = cil_fill_integer(parse_current->next->cl_head, &ioportcon->ioport_low, 0);
>  			if (rc != SEPOL_OK) {
>  				cil_log(CIL_ERR, "Improper ioport specified\n");
>  				goto exit;
>  			}
> -			rc = cil_fill_integer(parse_current->next->cl_head->next, &ioportcon->ioport_high, 10);
> +			rc = cil_fill_integer(parse_current->next->cl_head->next, &ioportcon->ioport_high, 0);
>  			if (rc != SEPOL_OK) {
>  				cil_log(CIL_ERR, "Improper ioport specified\n");
>  				goto exit;
> @@ -4705,7 +4705,7 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
>  			goto exit;
>  		}
>  	} else {
> -		rc = cil_fill_integer(parse_current->next, &ioportcon->ioport_low, 10);
> +		rc = cil_fill_integer(parse_current->next, &ioportcon->ioport_low, 0);
>  		if (rc != SEPOL_OK) {
>  			cil_log(CIL_ERR, "Improper ioport specified\n");
>  			goto exit;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
