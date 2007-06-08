Subject: Re: [PATCH 3/3] libselinux: class and permission mapping support
	(try 3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, jwcart2@epoch.ncsc.mil,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <46699231.4030704@tycho.nsa.gov>
References: <4666D5E6.508@tycho.nsa.gov>
	 <1181148038.17617.25.camel@moss-lions.epoch.ncsc.mil>
	 <4666FE38.4060401@tycho.nsa.gov>
	 <1181225909.7049.15.camel@localhost.localdomain>
	 <46699231.4030704@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:00:31 -0400
Message-Id: <1181332831.23351.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-08 at 13:30 -0400, Eamon Walsh wrote:
> This patch includes the internal map and unmap functions and
> the changes to the selinuxfs interfaces to make it work.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

All three patches:
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> ---
> 
> 
>  compute_av.c      |    8 ++++++--
>  compute_create.c  |    5 +++--
>  compute_member.c  |    5 +++--
>  compute_relabel.c |    5 +++--
>  mapping.h         |   34 ++++++++++++++++++++++++++++++++++
>  stringrep.c       |   29 ++++++++++++++++++++---------
>  6 files changed, 69 insertions(+), 17 deletions(-)
> 
> 
> Index: libselinux/src/mapping.h
> ===================================================================
> --- libselinux/src/mapping.h	(revision 0)
> +++ libselinux/src/mapping.h	(revision 0)
> @@ -0,0 +1,34 @@
> +/*
> + * This file describes the class and permission mappings used to 
> + * hide the kernel numbers from userspace by allowing userspace object
> + * managers to specify a list of classes and permissions.
> + */
> +#ifndef _SELINUX_MAPPING_H_
> +#define _SELINUX_MAPPING_H_
> +
> +#include <selinux/selinux.h>
> +
> +/*
> + * Get real, kernel values from mapped values
> + */
> +
> +extern security_class_t
> +unmap_class(security_class_t tclass);
> +
> +extern access_vector_t
> +unmap_perm(security_class_t tclass, access_vector_t tperm);
> +
> +/*
> + * Get mapped values from real, kernel values
> + */
> +
> +extern security_class_t
> +map_class(security_class_t kclass);
> +
> +extern access_vector_t
> +map_perm(security_class_t tclass, access_vector_t kperm);
> +
> +extern void
> +map_decision(security_class_t tclass, struct av_decision *avd);
> +
> +#endif				/* _SELINUX_MAPPING_H_ */
> Index: libselinux/src/stringrep.c
> ===================================================================
> --- libselinux/src/stringrep.c	(revision 2470)
> +++ libselinux/src/stringrep.c	(working copy)
> @@ -17,6 +17,7 @@
>  #include <selinux/av_permissions.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
> +#include "mapping.h"
>  
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
> @@ -315,12 +316,12 @@
>  	if (isdigit(s[0])) {
>  		val = atoi(s);
>  		if (val > 0 && val < NCLASSES)
> -			return val;
> +			return map_class(val);
>  	} else {
>  		for (val = 0; val < NCLASSES; val++) {
>  			if (strcmp(s, (class_to_string_data.str
>  				       + class_to_string[val])) == 0)
> -				return val;
> +				return map_class(val);
>  		}
>  	}
>  
> @@ -333,9 +334,10 @@
>  	const uint16_t *common_pts_idx = 0;
>  	access_vector_t perm, common_base = 0;
>  	unsigned int i;
> +	security_class_t kclass = unmap_class(tclass);
>  
>  	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> -		if (av_inherit[i].tclass == tclass) {
> +		if (av_inherit[i].tclass == kclass) {
>  			common_pts_idx =
>  			    &common_perm_to_string.data[av_inherit[i].
>  							common_pts_idx];
> @@ -350,16 +352,16 @@
>  		if (strcmp
>  		    (s,
>  		     common_perm_to_string_data.str + common_pts_idx[i]) == 0)
> -			return perm;
> +			return map_perm(tclass, perm);
>  		perm <<= 1;
>  		i++;
>  	}
>  
>  	for (i = 0; i < NVECTORS; i++) {
> -		if ((av_perm_to_string[i].tclass == tclass) &&
> +		if ((av_perm_to_string[i].tclass == kclass) &&
>  		    (strcmp(s, (av_perm_to_string_data.str
>  				+ av_perm_to_string[i].nameidx)) == 0))
> -			return av_perm_to_string[i].value;
> +			return map_perm(tclass, av_perm_to_string[i].value);
>  	}
>  
>  	errno = EINVAL;
> @@ -368,6 +370,8 @@
>  
>  static const char *security_class_to_string_compat(security_class_t tclass)
>  {
> +	tclass = unmap_class(tclass);
> +
>  	if (tclass > 0 && tclass < NCLASSES)
>  		return class_to_string_data.str + class_to_string[tclass];
>  
> @@ -382,6 +386,9 @@
>  	access_vector_t common_base = 0;
>  	unsigned int i;
>  
> +	av = unmap_perm(tclass, av);
> +	tclass = unmap_class(tclass);
> +
>  	if (!av)
>  		return NULL;
>  
> @@ -432,22 +439,23 @@
>  		}
>  	}
>  
> -	return node->value;
> +	return map_class(node->value);
>  }
>  
>  access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
>  {
>  	struct discover_class_node *node;
> +	security_class_t kclass = unmap_class(tclass);
>  
>  	if (obj_class_compat)
>  		return string_to_av_perm_compat(tclass,s);
>  
> -	node = get_class_cache_entry_value(tclass);
> +	node = get_class_cache_entry_value(kclass);
>  	if (node != NULL) {
>  		size_t i;
>  		for (i=0; i<MAXVECTORS && node->perms[i] != NULL; i++)
>  			if (strcmp(node->perms[i],s) == 0)
> -				return (1<<i);
> +				return map_perm(tclass, 1<<i);
>  	}
>  
>  	errno = EINVAL;
> @@ -461,6 +469,7 @@
>  	if (obj_class_compat)
>  		return security_class_to_string_compat(tclass);
>  
> +	tclass = unmap_class(tclass);
>  	node = get_class_cache_entry_value(tclass);
>  	if (node == NULL) {
>  		errno = EINVAL;
> @@ -478,6 +487,8 @@
>  	if (obj_class_compat)
>  		return security_av_perm_to_string_compat(tclass,av);
>  
> +	av = unmap_perm(tclass, av);
> +	tclass = unmap_class(tclass);
>  	node = get_class_cache_entry_value(tclass);
>  	if (av && node)
>  		for (i = 0; i<MAXVECTORS; i++)
> Index: libselinux/src/compute_av.c
> ===================================================================
> --- libselinux/src/compute_av.c	(revision 2470)
> +++ libselinux/src/compute_av.c	(working copy)
> @@ -5,9 +5,10 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <limits.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
> -#include <limits.h>
> +#include "mapping.h"
>  
>  int security_compute_av_raw(security_context_t scon,
>  			    security_context_t tcon,
> @@ -36,7 +37,8 @@
>  		goto out;
>  	}
>  
> -	snprintf(buf, len, "%s %s %hu %x", scon, tcon, tclass, requested);
> +	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
> +		 unmap_class(tclass), unmap_perm(tclass, requested));
>  
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> @@ -54,6 +56,8 @@
>  		goto out2;
>  	}
>  
> +	map_decision(tclass, avd);
> +
>  	ret = 0;
>        out2:
>  	free(buf);
> Index: libselinux/src/compute_create.c
> ===================================================================
> --- libselinux/src/compute_create.c	(revision 2470)
> +++ libselinux/src/compute_create.c	(working copy)
> @@ -5,9 +5,10 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <limits.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
> -#include <limits.h>
> +#include "mapping.h"
>  
>  int security_compute_create_raw(security_context_t scon,
>  				security_context_t tcon,
> @@ -35,7 +36,7 @@
>  		ret = -1;
>  		goto out;
>  	}
> -	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
> +	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
>  
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> Index: libselinux/src/compute_member.c
> ===================================================================
> --- libselinux/src/compute_member.c	(revision 2470)
> +++ libselinux/src/compute_member.c	(working copy)
> @@ -5,9 +5,10 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <limits.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
> -#include <limits.h>
> +#include "mapping.h"
>  
>  int security_compute_member_raw(security_context_t scon,
>  				security_context_t tcon,
> @@ -35,7 +36,7 @@
>  		ret = -1;
>  		goto out;
>  	}
> -	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
> +	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
>  
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> Index: libselinux/src/compute_relabel.c
> ===================================================================
> --- libselinux/src/compute_relabel.c	(revision 2470)
> +++ libselinux/src/compute_relabel.c	(working copy)
> @@ -5,9 +5,10 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <limits.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
> -#include <limits.h>
> +#include "mapping.h"
>  
>  int security_compute_relabel_raw(security_context_t scon,
>  				 security_context_t tcon,
> @@ -35,7 +36,7 @@
>  		ret = -1;
>  		goto out;
>  	}
> -	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
> +	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
>  
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
