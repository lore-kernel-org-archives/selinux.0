Message-ID: <1494960582.21557.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH v1 4/9] checkpolicy: Add support for ibendportcon labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Tue, 16 May 2017 14:49:42 -0400
In-Reply-To: <1494880961-73481-5-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-5-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add checkpolicy support for scanning and parsing ibendportcon labels.
> Also create a new ocontext for IB end ports.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> 
> ---
> v1:
> Stephen Smalley:
> - Check IB device name length when parsing policy.
> - Use strcmp vs strncmp to compare device names.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>  checkpolicy/policy_define.c                | 75
> ++++++++++++++++++++++++++++++
>  checkpolicy/policy_define.h                |  1 +
>  checkpolicy/policy_parse.y                 | 14 +++++-
>  checkpolicy/policy_scan.l                  |  2 +
>  libsepol/include/sepol/policydb/policydb.h |  9 +++-
>  5 files changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c
> b/checkpolicy/policy_define.c
> index ffdc5f8..239ca37 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5162,6 +5162,81 @@ out:
>  	return rc;
>  }
>  
> +int define_ibendport_context(unsigned int port)
> +{
> +	ocontext_t *newc, *c, *l, *head;
> +	char *id;
> +	int rc = 0;
> +
> +	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
> +		yyerror("ibendportcon not supported for target");
> +		return -1;
> +	}
> +
> +	if (pass == 1) {
> +		id = (char *)queue_remove(id_queue);
> +		free(id);
> +		parse_security_context(NULL);
> +		return 0;
> +	}
> +
> +	newc = malloc(sizeof(*newc));
> +	if (!newc) {
> +		yyerror("out of memory");
> +		return -1;
> +	}
> +	memset(newc, 0, sizeof(*newc));
> +
> +	newc->u.ibendport.dev_name = queue_remove(id_queue);
> +	if (!newc->u.ibendport.dev_name) {
> +		yyerror("failed to read infiniband device name.");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	if (strlen(newc->u.ibendport.dev_name) > IB_DEVICE_NAME_MAX
> - 1) {
> +		yyerror("infiniband device name exceeds max length
> of 63.");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	newc->u.ibendport.port = port;

Kernel also treats it as an error if port > 0xff || port == 0.
