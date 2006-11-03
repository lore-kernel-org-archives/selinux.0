Subject: Re: [PATCH 2/4] SELinux: export object class and permission
	definitions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061103203430.147110691@tresys.com>>
References: <20061103203354.331494899@tresys.com> >
	  <20061103203430.147110691@tresys.com>>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 16:14:35 -0500
Message-Id: <1162588475.5519.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-03 at 15:33 -0500, Chad Sellers wrote:
> plain text document attachment (export_classes_perms.diff)
> Moves the definition of the 3 structs containing object class and permission definitions from avc.c to avc_ss.h so that the security server can access them for validation on policy load. This also adds a new struct type, defined_classes_perms_t, suitable for allowing the security server to access these data structures from the avc.
> 
> Signed-off-by: Chad Sellers <csellers@tresys.com>
> 
> ---
>  security/selinux/avc.c            |   23 +++++++++++------------
>  security/selinux/include/avc_ss.h |   24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 12 deletions(-)
> 
> Index: linux-2.6-discovery/security/selinux/avc.c
> ===================================================================
> --- linux-2.6-discovery.orig/security/selinux/avc.c
> +++ linux-2.6-discovery/security/selinux/avc.c
> @@ -32,12 +32,7 @@
>  #include "avc.h"
>  #include "avc_ss.h"
>  
> -static const struct av_perm_to_string
> -{
> -  u16 tclass;
> -  u32 value;
> -  const char *name;
> -} av_perm_to_string[] = {
> +static const struct av_perm_to_string_t av_perm_to_string[] = {
>  #define S_(c, v, s) { c, v, s },
>  #include "av_perm_to_string.h"
>  #undef S_
> @@ -57,17 +52,21 @@ static const char *class_to_string[] = {
>  #undef TE_
>  #undef S_
>  
> -static const struct av_inherit
> -{
> -    u16 tclass;
> -    const char **common_pts;
> -    u32 common_base;
> -} av_inherit[] = {
> +static const struct av_inherit_t av_inherit[] = {
>  #define S_(c, i, b) { c, common_##i##_perm_to_string, b },
>  #include "av_inherit.h"
>  #undef S_
>  };
>  
> +const struct defined_classes_perms_t defined_classes_perms = {

- Don't use _t in struct names.
- Use a name for the variable that provides good namespacing (e.g.
selinux_) but isn't so long as to induce RSI.
- 
> +	av_perm_to_string,
> +	ARRAY_SIZE(av_perm_to_string),
> +	class_to_string,
> +	ARRAY_SIZE(class_to_string),
> +	av_inherit,
> +	ARRAY_SIZE(av_inherit)
> +};
> +
>  #define AVC_CACHE_SLOTS			512
>  #define AVC_DEF_CACHE_THRESHOLD		512
>  #define AVC_CACHE_RECLAIM		16
> Index: linux-2.6-discovery/security/selinux/include/avc_ss.h
> ===================================================================
> --- linux-2.6-discovery.orig/security/selinux/include/avc_ss.h
> +++ linux-2.6-discovery/security/selinux/include/avc_ss.h
> @@ -10,5 +10,29 @@
>  
>  int avc_ss_reset(u32 seqno);
>  
> +struct av_perm_to_string_t

Don't rename these structs.

> +{
> +	u16 tclass;
> +	u32 value;
> +	const char *name;
> +};
> +
> +struct av_inherit_t
> +{
> +	u16 tclass;
> +	const char **common_pts;
> +	u32 common_base;
> +};
> +
> +struct defined_classes_perms_t
> +{
> +	const struct av_perm_to_string_t *av_perm_to_string;
> +	u32 av_perm_to_string_len;

Don't go overkill on field name length.

> +	const char **class_to_string;
> +	u32 class_to_string_len;
> +	const struct av_inherit_t *av_inherit;
> +	u32 av_inherit_len;
> +};
> +
>  #endif /* _SELINUX_AVC_SS_H_ */
>  
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
