Subject: Re: [PATCH] libselinux: string representation refactoring
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <46609A9C.7040709@tycho.nsa.gov>
References: <46609A9C.7040709@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 09:25:37 -0400
Message-Id: <1181049937.25769.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-01 at 18:15 -0400, Eamon Walsh wrote:
> This patch splits the string representation functions out of avc.c
> and refactors the AVC code to use the interface functions instead
> of the raw tables when building AVC messages.
> 
> These changes should make it easier to add the dynamic class and
> permission support (Chris, take note).
> 
> The "print_access_vector" function should probably be deprecated at
> some point.  IIRC it was used by some utility that now doesn't use
> it anymore.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
> ---
> 
>  avc.c       |  408 +-----------------------------------------------------------
>  stringrep.c |  328 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 341 insertions(+), 395 deletions(-)
> 
> Index: libselinux/src/avc.c
> ===================================================================
> --- libselinux/src/avc.c	(revision 2456)
> +++ libselinux/src/avc.c	(working copy)
> @@ -7,151 +7,13 @@
>   * Stephen Smalley <sds@epoch.ncsc.mil> and 
>   * James Morris <jmorris@redhat.com>.
>   */
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <stddef.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <stdint.h>
> -#include <selinux/flask.h>
> -#include "selinux_internal.h"
>  #include <selinux/avc.h>
> +#include "selinux_internal.h"
>  #include "avc_sidtab.h"
>  #include "avc_internal.h"
> -#include <selinux/av_permissions.h>
>  
> -/* The following code looks complicated, but it really is not.  What it
> -   does is to generate two variables.  The first is basically a struct
> -   of arrays.  The second is the real array of structures which would
> -   have used string pointers.  But instead it now uses an offset value
> -   into the first structure.  Strings are accessed indirectly by an
> -   explicit addition of the string index and the base address of the
> -   structure with the strings (all type safe).  The advantage is that
> -   there are no relocations necessary in the array with the data as it
> -   would be the case with string pointers.  This has advantages at
> -   load time, the data section is smaller, and it is read-only.  */
> -#define L1(line) L2(line)
> -#define L2(line) str##line
> -static const union av_perm_to_string_data {
> -	struct {
> -#define S_(c, v, s) char L1(__LINE__)[sizeof(s)];
> -#include "av_perm_to_string.h"
> -#undef  S_
> -	};
> -	char str[0];
> -} av_perm_to_string_data = {
> -	{
> -#define S_(c, v, s) s,
> -#include "av_perm_to_string.h"
> -#undef  S_
> -	}
> -};
> -static const struct av_perm_to_string {
> -	uint16_t tclass;
> -	uint16_t nameidx;
> -	uint32_t value;
> -} av_perm_to_string[] = {
> -#define S_(c, v, s) { c, offsetof(union av_perm_to_string_data, L1(__LINE__)), v },
> -#include "av_perm_to_string.h"
> -#undef  S_
> -};
> -
> -#undef L1
> -#undef L2
> -
> -#define L1(line) L2(line)
> -#define L2(line) str##line
> -static const union class_to_string_data {
> -	struct {
> -#define S_(s) char L1(__LINE__)[sizeof(s)];
> -#include "class_to_string.h"
> -#undef  S_
> -	};
> -	char str[0];
> -} class_to_string_data = {
> -	{
> -#define S_(s) s,
> -#include "class_to_string.h"
> -#undef  S_
> -	}
> -};
> -static const uint16_t class_to_string[] = {
> -#define S_(s) offsetof(union class_to_string_data, L1(__LINE__)),
> -#include "class_to_string.h"
> -#undef  S_
> -};
> -
> -#undef L1
> -#undef L2
> -
> -static const union common_perm_to_string_data {
> -	struct {
> -#define L1(line) L2(line)
> -#define L2(line) str##line
> -#define S_(s) char L1(__LINE__)[sizeof(s)];
> -#define TB_(s)
> -#define TE_(s)
> -#include "common_perm_to_string.h"
> -#undef  S_
> -#undef L1
> -#undef L2
> -	};
> -	char str[0];
> -} common_perm_to_string_data = {
> -	{
> -#define S_(s) s,
> -#include "common_perm_to_string.h"
> -#undef  S_
> -#undef TB_
> -#undef TE_
> -	}
> -};
> -static const union common_perm_to_string {
> -	struct {
> -#define TB_(s) struct {
> -#define TE_(s) } s##_part;
> -#define S_(s) uint16_t L1(__LINE__)
> -#define L1(l) L2(l)
> -#define L2(l) field_##l;
> -#include "common_perm_to_string.h"
> -#undef TB_
> -#undef TE_
> -#undef S_
> -#undef L1
> -#undef L2
> -	};
> -	uint16_t data[0];
> -} common_perm_to_string = {
> -	{
> -#define TB_(s) {
> -#define TE_(s) },
> -#define S_(s) offsetof(union common_perm_to_string_data, L1(__LINE__)),
> -#define L1(line) L2(line)
> -#define L2(line) str##line
> -#include "common_perm_to_string.h"
> -#undef TB_
> -#undef TE_
> -#undef S_
> -#undef L1
> -#undef L2
> -	}
> -};
> -
> -static const struct av_inherit {
> -	uint16_t tclass;
> -	uint16_t common_pts_idx;
> -	uint32_t common_base;
> -} av_inherit[] = {
> -#define S_(c, i, b) { c, offsetof(union common_perm_to_string, common_##i##_perm_to_string_part)/sizeof(uint16_t), b },
> -#include "av_inherit.h"
> -#undef S_
> -};
> -
>  #define AVC_CACHE_SLOTS		512
>  #define AVC_CACHE_MAXNODES	410
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
>  struct avc_entry {
>  	security_id_t ssid;
> @@ -812,56 +674,27 @@
>   */
>  static void avc_dump_av(security_class_t tclass, access_vector_t av)
>  {
> -	const uint16_t *common_pts_idx = 0;
> -	uint32_t common_base = 0, perm;
> -	unsigned int i, i2;
> +	const char *permstr;
> +	access_vector_t bit = 1;
>  
>  	if (av == 0) {
>  		log_append(avc_audit_buf, " null");
>  		return;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> -		if (av_inherit[i].tclass == tclass) {
> -			common_pts_idx =
> -			    &common_perm_to_string.data[av_inherit[i].
> -							common_pts_idx];
> -			common_base = av_inherit[i].common_base;
> -			break;
> -		}
> -	}
> -
>  	log_append(avc_audit_buf, " {");
> -	i = 0;
> -	perm = 1;
> -	while (perm < common_base) {
> -		if (perm & av) {
> -			log_append(avc_audit_buf, " %s",
> -				   common_perm_to_string_data.str +
> -				   common_pts_idx[i]);
> -			av &= ~perm;
> -		}
> -		i++;
> -		perm <<= 1;
> -	}
>  
> -	while (i < sizeof(av) * 8) {
> -		if (perm & av) {
> -			for (i2 = 0; i2 < ARRAY_SIZE(av_perm_to_string); i2++) {
> -				if ((av_perm_to_string[i2].tclass == tclass) &&
> -				    (av_perm_to_string[i2].value == perm))
> -					break;
> -			}
> -			if (i2 < ARRAY_SIZE(av_perm_to_string)) {
> -				log_append(avc_audit_buf, " %s",
> -					   av_perm_to_string_data.str +
> -					   av_perm_to_string[i2].nameidx);
> -				av &= ~perm;
> -			}
> +	while (av) {
> +		if (av & bit) {
> +			permstr = security_av_perm_to_string(tclass, bit);
> +			if (!permstr)
> +				break;
> +			log_append(avc_audit_buf, " %s", permstr);
> +			av &= ~bit;
>  		}
> -		i++;
> -		perm <<= 1;
> +		bit <<= 1;
>  	}
> +
>  	if (av)
>  		log_append(avc_audit_buf, " 0x%x", av);
>  	log_append(avc_audit_buf, " }");
> @@ -890,7 +723,7 @@
>  
>  	avc_release_lock(avc_lock);
>  	log_append(avc_audit_buf, " tclass=%s",
> -		   class_to_string_data.str + class_to_string[tclass]);
> +		   security_class_to_string(tclass));
>  }
>  
>  void avc_audit(security_id_t ssid, security_id_t tsid,
> @@ -1318,218 +1151,3 @@
>  		return avc_control(AVC_CALLBACK_AUDITDENY_DISABLE,
>  				   ssid, tsid, tclass, perms, seqno, 0);
>  }
> -
> -/* Other exported functions that use the string tables,
> -   formerly in helpers.c. */
> -
> -#include <ctype.h>
> -
> -#define NCLASSES ARRAY_SIZE(class_to_string)
> -#define NVECTORS ARRAY_SIZE(av_perm_to_string)
> -
> -security_class_t string_to_security_class(const char *s)
> -{
> -	unsigned int val;
> -
> -	if (isdigit(s[0])) {
> -		val = atoi(s);
> -		if (val > 0 && val < NCLASSES)
> -			return val;
> -	} else {
> -		for (val = 0; val < NCLASSES; val++) {
> -			if (strcmp(s, (class_to_string_data.str
> -				       + class_to_string[val])) == 0)
> -				return val;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
> -{
> -	const uint16_t *common_pts_idx = 0;
> -	access_vector_t perm, common_base = 0;
> -	unsigned int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> -		if (av_inherit[i].tclass == tclass) {
> -			common_pts_idx =
> -			    &common_perm_to_string.data[av_inherit[i].
> -							common_pts_idx];
> -			common_base = av_inherit[i].common_base;
> -			break;
> -		}
> -	}
> -
> -	i = 0;
> -	perm = 1;
> -	while (perm < common_base) {
> -		if (strcmp
> -		    (s,
> -		     common_perm_to_string_data.str + common_pts_idx[i]) == 0)
> -			return perm;
> -		perm <<= 1;
> -		i++;
> -	}
> -
> -	for (i = 0; i < NVECTORS; i++) {
> -		if ((av_perm_to_string[i].tclass == tclass) &&
> -		    (strcmp(s, (av_perm_to_string_data.str
> -				+ av_perm_to_string[i].nameidx)) == 0))
> -			return av_perm_to_string[i].value;
> -	}
> -
> -	return 0;
> -}
> -
> -const char *security_class_to_string(security_class_t tclass)
> -{
> -	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
> -	return class_to_string_data.str + class_to_string[tclass];
> -}
> -
> -const char *security_av_perm_to_string(security_class_t tclass,
> -				       access_vector_t av)
> -{
> -	const uint16_t *common_pts_idx = 0;
> -	access_vector_t common_base = 0;
> -	unsigned int i;
> -
> -	if (!av)
> -		return NULL;
> -
> -	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> -		if (av_inherit[i].tclass == tclass) {
> -			common_pts_idx =
> -			    &common_perm_to_string.data[av_inherit[i].
> -							common_pts_idx];
> -			common_base = av_inherit[i].common_base;
> -			break;
> -		}
> -	}
> -
> -	if (av < common_base) {
> -		i = 0;
> -		while (!(av & 1)) {
> -			av >>= 1;
> -			i++;
> -		}
> -		return common_perm_to_string_data.str + common_pts_idx[i];
> -	}
> -
> -	for (i = 0; i < NVECTORS; i++) {
> -		if (av_perm_to_string[i].tclass == tclass &&
> -		    av_perm_to_string[i].value == av)
> -			return av_perm_to_string_data.str
> -				+ av_perm_to_string[i].nameidx;
> -	}
> -
> -	return NULL;
> -}
> -
> -int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> -{
> -	unsigned int i = 0;
> -	size_t len = 5;
> -	access_vector_t tmp = av;
> -	int rc = 0;
> -	const char *str;
> -	char *ptr;
> -
> -	/* first pass computes the required length */
> -	while (tmp) {
> -		if (tmp & 1) {
> -			str = security_av_perm_to_string(tclass, av & (1<<i));
> -			if (str)
> -				len += strlen(str) + 1;
> -			else {
> -				rc = -1;
> -				errno = EINVAL;
> -				goto out;
> -			}
> -		}
> -		tmp >>= 1;
> -		i++;
> -	}
> -
> -	*res = malloc(len);
> -	if (!*res) {
> -		rc = -1;
> -		goto out;
> -	}
> -
> -	/* second pass constructs the string */
> -	i = 0;
> -	tmp = av;
> -	ptr = *res;
> -
> -	if (!av) {
> -		sprintf(ptr, "null");
> -		goto out;
> -	}
> -
> -	ptr += sprintf(ptr, "{ ");
> -	while (tmp) {
> -		if (tmp & 1)
> -			ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
> -					       tclass, av & (1<<i)));
> -		tmp >>= 1;
> -		i++;
> -	}
> -	sprintf(ptr, "}");
> -out:
> -	return rc;
> -}
> -
> -void print_access_vector(security_class_t tclass, access_vector_t av)
> -{
> -	const uint16_t *common_pts_idx = 0;
> -	access_vector_t common_base = 0;
> -	unsigned int i, i2, perm;
> -
> -	if (av == 0) {
> -		printf(" null");
> -		return;
> -	}
> -
> -	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> -		if (av_inherit[i].tclass == tclass) {
> -			common_pts_idx =
> -			    &common_perm_to_string.data[av_inherit[i].
> -							common_pts_idx];
> -			common_base = av_inherit[i].common_base;
> -			break;
> -		}
> -	}
> -
> -	printf(" {");
> -	i = 0;
> -	perm = 1;
> -	while (perm < common_base) {
> -		if (perm & av)
> -			printf(" %s",
> -			       common_perm_to_string_data.str +
> -			       common_pts_idx[i]);
> -		i++;
> -		perm <<= 1;
> -	}
> -
> -	while (i < sizeof(access_vector_t) * 8) {
> -		if (perm & av) {
> -			for (i2 = 0; i2 < NVECTORS; i2++) {
> -				if ((av_perm_to_string[i2].tclass == tclass) &&
> -				    (av_perm_to_string[i2].value == perm))
> -					break;
> -			}
> -			if (i2 < NVECTORS)
> -				printf(" %s",
> -				       av_perm_to_string_data.str
> -				       + av_perm_to_string[i2].nameidx);
> -		}
> -		i++;
> -		perm <<= 1;
> -	}
> -
> -	printf(" }");
> -}
> Index: libselinux/src/stringrep.c
> ===================================================================
> --- libselinux/src/stringrep.c	(revision 0)
> +++ libselinux/src/stringrep.c	(revision 0)
> @@ -0,0 +1,328 @@
> +/*
> + * String representation support for classes and permissions.
> + */
> +#include <errno.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <ctype.h>
> +#include <selinux/flask.h>
> +#include <selinux/av_permissions.h>
> +#include "selinux_internal.h"
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +/* The following code looks complicated, but it really is not.  What it
> +   does is to generate two variables.  The first is basically a struct
> +   of arrays.  The second is the real array of structures which would
> +   have used string pointers.  But instead it now uses an offset value
> +   into the first structure.  Strings are accessed indirectly by an
> +   explicit addition of the string index and the base address of the
> +   structure with the strings (all type safe).  The advantage is that
> +   there are no relocations necessary in the array with the data as it
> +   would be the case with string pointers.  This has advantages at
> +   load time, the data section is smaller, and it is read-only.  */
> +#define L1(line) L2(line)
> +#define L2(line) str##line
> +static const union av_perm_to_string_data {
> +	struct {
> +#define S_(c, v, s) char L1(__LINE__)[sizeof(s)];
> +#include "av_perm_to_string.h"
> +#undef  S_
> +	};
> +	char str[0];
> +} av_perm_to_string_data = {
> +	{
> +#define S_(c, v, s) s,
> +#include "av_perm_to_string.h"
> +#undef  S_
> +	}
> +};
> +static const struct av_perm_to_string {
> +	uint16_t tclass;
> +	uint16_t nameidx;
> +	uint32_t value;
> +} av_perm_to_string[] = {
> +#define S_(c, v, s) { c, offsetof(union av_perm_to_string_data, L1(__LINE__)), v },
> +#include "av_perm_to_string.h"
> +#undef  S_
> +};
> +
> +#undef L1
> +#undef L2
> +
> +#define L1(line) L2(line)
> +#define L2(line) str##line
> +static const union class_to_string_data {
> +	struct {
> +#define S_(s) char L1(__LINE__)[sizeof(s)];
> +#include "class_to_string.h"
> +#undef  S_
> +	};
> +	char str[0];
> +} class_to_string_data = {
> +	{
> +#define S_(s) s,
> +#include "class_to_string.h"
> +#undef  S_
> +	}
> +};
> +static const uint16_t class_to_string[] = {
> +#define S_(s) offsetof(union class_to_string_data, L1(__LINE__)),
> +#include "class_to_string.h"
> +#undef  S_
> +};
> +
> +#undef L1
> +#undef L2
> +
> +static const union common_perm_to_string_data {
> +	struct {
> +#define L1(line) L2(line)
> +#define L2(line) str##line
> +#define S_(s) char L1(__LINE__)[sizeof(s)];
> +#define TB_(s)
> +#define TE_(s)
> +#include "common_perm_to_string.h"
> +#undef  S_
> +#undef L1
> +#undef L2
> +	};
> +	char str[0];
> +} common_perm_to_string_data = {
> +	{
> +#define S_(s) s,
> +#include "common_perm_to_string.h"
> +#undef  S_
> +#undef TB_
> +#undef TE_
> +	}
> +};
> +static const union common_perm_to_string {
> +	struct {
> +#define TB_(s) struct {
> +#define TE_(s) } s##_part;
> +#define S_(s) uint16_t L1(__LINE__)
> +#define L1(l) L2(l)
> +#define L2(l) field_##l;
> +#include "common_perm_to_string.h"
> +#undef TB_
> +#undef TE_
> +#undef S_
> +#undef L1
> +#undef L2
> +	};
> +	uint16_t data[0];
> +} common_perm_to_string = {
> +	{
> +#define TB_(s) {
> +#define TE_(s) },
> +#define S_(s) offsetof(union common_perm_to_string_data, L1(__LINE__)),
> +#define L1(line) L2(line)
> +#define L2(line) str##line
> +#include "common_perm_to_string.h"
> +#undef TB_
> +#undef TE_
> +#undef S_
> +#undef L1
> +#undef L2
> +	}
> +};
> +
> +static const struct av_inherit {
> +	uint16_t tclass;
> +	uint16_t common_pts_idx;
> +	uint32_t common_base;
> +} av_inherit[] = {
> +#define S_(c, i, b) { c, offsetof(union common_perm_to_string, common_##i##_perm_to_string_part)/sizeof(uint16_t), b },
> +#include "av_inherit.h"
> +#undef S_
> +};
> +
> +#define NCLASSES ARRAY_SIZE(class_to_string)
> +#define NVECTORS ARRAY_SIZE(av_perm_to_string)
> +
> +security_class_t string_to_security_class(const char *s)
> +{
> +	unsigned int val;
> +
> +	if (isdigit(s[0])) {
> +		val = atoi(s);
> +		if (val > 0 && val < NCLASSES)
> +			return val;
> +	} else {
> +		for (val = 0; val < NCLASSES; val++) {
> +			if (strcmp(s, (class_to_string_data.str
> +				       + class_to_string[val])) == 0)
> +				return val;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
> +{
> +	const uint16_t *common_pts_idx = 0;
> +	access_vector_t perm, common_base = 0;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> +		if (av_inherit[i].tclass == tclass) {
> +			common_pts_idx =
> +			    &common_perm_to_string.data[av_inherit[i].
> +							common_pts_idx];
> +			common_base = av_inherit[i].common_base;
> +			break;
> +		}
> +	}
> +
> +	i = 0;
> +	perm = 1;
> +	while (perm < common_base) {
> +		if (strcmp
> +		    (s,
> +		     common_perm_to_string_data.str + common_pts_idx[i]) == 0)
> +			return perm;
> +		perm <<= 1;
> +		i++;
> +	}
> +
> +	for (i = 0; i < NVECTORS; i++) {
> +		if ((av_perm_to_string[i].tclass == tclass) &&
> +		    (strcmp(s, (av_perm_to_string_data.str
> +				+ av_perm_to_string[i].nameidx)) == 0))
> +			return av_perm_to_string[i].value;
> +	}
> +
> +	return 0;
> +}
> +
> +const char *security_class_to_string(security_class_t tclass)
> +{
> +	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
> +	return class_to_string_data.str + class_to_string[tclass];
> +}
> +
> +const char *security_av_perm_to_string(security_class_t tclass,
> +				       access_vector_t av)
> +{
> +	const uint16_t *common_pts_idx = 0;
> +	access_vector_t common_base = 0;
> +	unsigned int i;
> +
> +	if (!av)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
> +		if (av_inherit[i].tclass == tclass) {
> +			common_pts_idx =
> +			    &common_perm_to_string.data[av_inherit[i].
> +							common_pts_idx];
> +			common_base = av_inherit[i].common_base;
> +			break;
> +		}
> +	}
> +
> +	if (av < common_base) {
> +		i = 0;
> +		while (!(av & 1)) {
> +			av >>= 1;
> +			i++;
> +		}
> +		return common_perm_to_string_data.str + common_pts_idx[i];
> +	}
> +
> +	for (i = 0; i < NVECTORS; i++) {
> +		if (av_perm_to_string[i].tclass == tclass &&
> +		    av_perm_to_string[i].value == av)
> +			return av_perm_to_string_data.str
> +				+ av_perm_to_string[i].nameidx;
> +	}
> +
> +	return NULL;
> +}
> +
> +int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> +{
> +	unsigned int i = 0;
> +	size_t len = 5;
> +	access_vector_t tmp = av;
> +	int rc = 0;
> +	const char *str;
> +	char *ptr;
> +
> +	/* first pass computes the required length */
> +	while (tmp) {
> +		if (tmp & 1) {
> +			str = security_av_perm_to_string(tclass, av & (1<<i));
> +			if (str)
> +				len += strlen(str) + 1;
> +			else {
> +				rc = -1;
> +				errno = EINVAL;
> +				goto out;
> +			}
> +		}
> +		tmp >>= 1;
> +		i++;
> +	}
> +
> +	*res = malloc(len);
> +	if (!*res) {
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	/* second pass constructs the string */
> +	i = 0;
> +	tmp = av;
> +	ptr = *res;
> +
> +	if (!av) {
> +		sprintf(ptr, "null");
> +		goto out;
> +	}
> +
> +	ptr += sprintf(ptr, "{ ");
> +	while (tmp) {
> +		if (tmp & 1)
> +			ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
> +					       tclass, av & (1<<i)));
> +		tmp >>= 1;
> +		i++;
> +	}
> +	sprintf(ptr, "}");
> +out:
> +	return rc;
> +}
> +
> +void print_access_vector(security_class_t tclass, access_vector_t av)
> +{
> +	const char *permstr;
> +	access_vector_t bit = 1;
> +
> +	if (av == 0) {
> +		printf(" null");
> +		return;
> +	}
> +
> +	printf(" {");
> +
> +	while (av) {
> +		if (av & bit) {
> +			permstr = security_av_perm_to_string(tclass, bit);
> +			if (!permstr)
> +				break;
> +			printf(" %s", permstr);
> +			av &= ~bit;
> +		}
> +		bit <<= 1;
> +	}
> +
> +	if (av)
> +		printf(" 0x%x", av);
> +	printf(" }");
> +}
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
