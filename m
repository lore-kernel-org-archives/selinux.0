Message-ID: <55021D8B.5070806@citrix.com>
Date: Thu, 12 Mar 2015 23:13:15 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
To: Daniel De Graaf <dgdegra@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [Xen-devel] [PATCH 2/3] libsepol, checkpolicy: widen Xen IOMEM
 ocontext entries
References: <1426192832-991-1-git-send-email-dgdegra@tycho.nsa.gov>
 <1426192832-991-3-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426192832-991-3-git-send-email-dgdegra@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Sender: Andrew Cooper <amc96@hermes.cam.ac.uk>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/03/2015 20:40, Daniel De Graaf wrote:
> This expands IOMEMCON device context entries to 64 bits.  This change is
> required to support static I/O memory range labeling for systems with
> over 16TB of physical address space.  The policy version number change
> is shared with the next patch.
>
> While this makes no changes to SELinux policy, a new SELinux policy
> compatibility entry was added in order to avoid breaking compilation of
> an SELinux policy without explicitly specifying the policy version.
>
> Signed-off-by: Daniel De Graaf <dgdegra@tycho.nsa.gov>
> ---
>  checkpolicy/policy_define.c                |  6 +++---
>  checkpolicy/policy_define.h                |  2 +-
>  checkpolicy/policy_parse.y                 |  9 ++++++--
>  libsepol/cil/src/cil_build_ast.c           | 32 ++++++++++++++++++++++++++---
>  libsepol/cil/src/cil_build_ast.h           |  1 +
>  libsepol/cil/src/cil_internal.h            |  4 ++--
>  libsepol/cil/src/cil_policy.c              |  2 +-
>  libsepol/cil/src/cil_tree.c                |  2 +-
>  libsepol/include/sepol/policydb/policydb.h |  7 ++++---
>  libsepol/src/policydb.c                    | 33 +++++++++++++++++++++++++-----
>  libsepol/src/write.c                       | 32 ++++++++++++++++++++++-------
>  policycoreutils/hll/pp/pp.c                |  4 ++--
>  12 files changed, 104 insertions(+), 30 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index a6c5d65..f4c6fba 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3932,7 +3932,7 @@ bad:
>  	return -1;
>  }
>  
> -int define_iomem_context(unsigned long low, unsigned long high)
> +int define_iomem_context(uint64_t low, uint64_t high)
>  {
>  	ocontext_t *newc, *c, *l, *head;
>  	char *id;
> @@ -3972,13 +3972,13 @@ int define_iomem_context(unsigned long low, unsigned long high)
>  
>  	head = policydbp->ocontexts[OCON_XEN_IOMEM];
>  	for (l = NULL, c = head; c; l = c, c = c->next) {
> -		uint32_t low2, high2;
> +		uint64_t low2, high2;
>  
>  		low2 = c->u.iomem.low_iomem;
>  		high2 = c->u.iomem.high_iomem;
>  		if (low <= high2 && low2 <= high) {
>  			yyerror2("iomemcon entry for 0x%lx-0x%lx overlaps with "
> -				"earlier entry 0x%x-0x%x", low, high,
> +				"earlier entry 0x%lx-0x%lx", low, high,

This will break a 32bit build.  You must use PRIx64 from <inttypes.h>
instead of %lx for uint64_t's

~Andrew
