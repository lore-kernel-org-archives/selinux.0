Subject: Re: [PATCH]: add boolmap argument to expand_module_avrules()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1176404597.9840.65.camel@sgc>
References: <1176404597.9840.65.camel@sgc>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 10:11:59 -0400
Message-Id: <1176473519.3986.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-12 at 19:03 +0000, Christopher J. PeBenito wrote:
> A recent change to libsepol's expander introduced the boolmap structure
> so that boolean values may be remapped properly.  In the special
> function expand_module_avrules(), which at the moment only SETools uses,
> this boolmap structure is never initialized.  As a result, the expander
> will segfault when remapping conditional expressions.  The following
> patch adds a paramater to expand_module_avrules() that allows users to
> specify that boolmap.  This function is never exported out of the
> library, so doesn't result in an ABI change to the library.
> 
> 
>  include/sepol/policydb/expand.h |   20 +++++++++++---------
>  src/expand.c                    |    4 +++-
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> Index: libsepol/include/sepol/policydb/expand.h
> ===================================================================
> --- libsepol/include/sepol/policydb/expand.h	(revision 224)
> +++ libsepol/include/sepol/policydb/expand.h	(working copy)
> @@ -30,17 +30,19 @@
>  #include <sepol/policydb/conditional.h>
>  
>  /*
> - * Expand only the avrules for a module. It is valid for this function to
> - * expand base into itself (i.e.  base == out); the typemap for this special
> - * case should map type[i] to i+1.  This function optionally expands neverallow
> - * rules. If neverallow rules are expanded, there is no need to copy them and
> - * doing so could cause duplicate entries when base == out. If the neverallow
> - * rules are not expanded, they are just copied to the destination policy so
> - * that assertion checking can be performed after expand. No assertion or
> - * hierarchy checking is performed by this function.
> + * Expand only the avrules for a module. It is valid for this function
> + * to expand base into itself (i.e.  base == out); the typemap for
> + * this special case should map type[i] to i+1.  Likewise the boolmap
> + * should map bool[i] to i + 1.  This function optionally expands
> + * neverallow rules. If neverallow rules are expanded, there is no
> + * need to copy them and doing so could cause duplicate entries when
> + * base == out.  If the neverallow rules are not expanded, they are
> + * just copied to the destination policy so that assertion checking
> + * can be performed after expand.  No assertion or hierarchy checking
> + * is performed by this function.
>   */
>  extern int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
> -				 policydb_t * out, uint32_t * typemap,
> +				 policydb_t * out, uint32_t * typemap, uint32_t * boolmap,
>  				 int verbose, int expand_neverallow);
>  /*
>   * Expand all parts of a module. Neverallow rules are not expanded (only
> Index: libsepol/src/expand.c
> ===================================================================
> --- libsepol/src/expand.c	(revision 224)
> +++ libsepol/src/expand.c	(working copy)
> @@ -2198,7 +2198,8 @@
>   * or expand into the same policy for analysis purposes.
>   */
>  int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
> -			  policydb_t * out, uint32_t * typemap, int verbose,
> +			  policydb_t * out, uint32_t * typemap,
> +			  uint32_t * boolmap, int verbose,
>  			  int expand_neverallow)
>  {
>  	expand_state_t state;
> @@ -2208,6 +2209,7 @@
>  	state.base = base;
>  	state.out = out;
>  	state.typemap = typemap;
> +	state.boolmap = boolmap;
>  	state.handle = handle;
>  	state.verbose = verbose;
>  	state.expand_neverallow = expand_neverallow;

Thanks, applied on trunk and stable branch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
