Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEC8C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E0E2083E
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfCALxM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbfCALxM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Mar 2019 06:53:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D550AD7A56;
        Fri,  1 Mar 2019 11:53:10 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CACBD5D9C5;
        Fri,  1 Mar 2019 11:53:08 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     paul@paul-moore.com, dominick.grift@defensec.nl,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3] libselinux: selinux_set_mapping: fix handling of unknown classes/perms
References: <20190225154902.31602-1-sds@tycho.nsa.gov>
Date:   Fri, 01 Mar 2019 12:53:07 +0100
In-Reply-To: <20190225154902.31602-1-sds@tycho.nsa.gov> (Stephen Smalley's
        message of "Mon, 25 Feb 2019 10:49:02 -0500")
Message-ID: <pjda7ielskc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 01 Mar 2019 11:53:11 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> The libselinux selinux_set_mapping() implementation was never updated
> to handle unknown classes/permissions based on the policy handle_unknown
> flag.  Update it and the internal mapping functions to gracefully
> handle unknown classes/permissions.  Add a security_reject_unknown()
> interface to expose the corresponding selinuxfs node and use it when
> creating a mapping to decide whether to fail immediately or proceed.
>
> This enables dbus-daemon and XSELinux, which use selinux_set_mapping(),
> to continue working with the dummy policy or other policies that lack
> their userspace class/permission definitions as long as the policy
> was built with -U allow.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged.



> ---
> v3 adjusts the map_decision() logic to use else if for the
> allow_unknown test since we do not need to set the permission
> more than once.
>
>  libselinux/include/selinux/selinux.h |  5 +-
>  libselinux/src/compute_av.c          | 14 ++++--
>  libselinux/src/mapping.c             | 70 ++++++++++++++++++++++------
>  libselinux/src/reject_unknown.c      | 40 ++++++++++++++++
>  libselinux/src/selinux_internal.h    |  1 +
>  5 files changed, 113 insertions(+), 17 deletions(-)
>  create mode 100644 libselinux/src/reject_unknown.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 01201eee..a34d54fc 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -328,7 +328,10 @@ extern int security_getenforce(void);
>  /* Set the enforce flag value. */
>  extern int security_setenforce(int value);
>  
> -/* Get the behavior for undefined classes/permissions */
> +/* Get the load-time behavior for undefined classes/permissions */
> +extern int security_reject_unknown(void);
> +
> +/* Get the runtime behavior for undefined classes/permissions */
>  extern int security_deny_unknown(void);
>  
>  /* Get the checkreqprot value */
> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
> index 1d05e7b6..a47cffe9 100644
> --- a/libselinux/src/compute_av.c
> +++ b/libselinux/src/compute_av.c
> @@ -20,6 +20,7 @@ int security_compute_av_flags_raw(const char * scon,
>  	char *buf;
>  	size_t len;
>  	int fd, ret;
> +	security_class_t kclass;
>  
>  	if (!selinux_mnt) {
>  		errno = ENOENT;
> @@ -38,8 +39,9 @@ int security_compute_av_flags_raw(const char * scon,
>  		goto out;
>  	}
>  
> +	kclass = unmap_class(tclass);
>  	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
> -		 unmap_class(tclass), unmap_perm(tclass, requested));
> +		 kclass, unmap_perm(tclass, requested));
>  
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> @@ -60,8 +62,14 @@ int security_compute_av_flags_raw(const char * scon,
>  	} else if (ret < 6)
>  		avd->flags = 0;
>  
> -	/* If tclass invalid, kernel sets avd according to deny_unknown flag */
> -	if (tclass != 0)
> +	/*
> +	 * If the tclass could not be mapped to a kernel class at all, the
> +	 * kernel will have already set avd according to the
> +	 * handle_unknown flag and we do not need to do anything further.
> +	 * Otherwise, we must map the permissions within the returned
> +	 * avd to the userspace permission values.
> +	 */
> +	if (kclass != 0)
>  		map_decision(tclass, avd);
>  
>  	ret = 0;
> diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
> index f205804b..33cea5ae 100644
> --- a/libselinux/src/mapping.c
> +++ b/libselinux/src/mapping.c
> @@ -6,9 +6,12 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <selinux/selinux.h>
>  #include <selinux/avc.h>
> +#include "callbacks.h"
>  #include "mapping.h"
> +#include "selinux_internal.h"
>  
>  /*
>   * Class and permission mappings
> @@ -33,6 +36,9 @@ selinux_set_mapping(struct security_class_mapping *map)
>  	size_t size = sizeof(struct selinux_mapping);
>  	security_class_t i, j;
>  	unsigned k;
> +	bool print_unknown_handle = false;
> +	bool reject = (security_reject_unknown() == 1);
> +	bool deny = (security_deny_unknown() == 1);
>  
>  	free(current_mapping);
>  	current_mapping = NULL;
> @@ -62,8 +68,16 @@ selinux_set_mapping(struct security_class_mapping *map)
>  		struct selinux_mapping *p_out = current_mapping + j;
>  
>  		p_out->value = string_to_security_class(p_in->name);
> -		if (!p_out->value)
> -			goto err2;
> +		if (!p_out->value) {
> +			selinux_log(SELINUX_INFO,
> +				    "SELinux: Class %s not defined in policy.\n",
> +				    p_in->name);
> +			if (reject)
> +				goto err2;
> +			p_out->num_perms = 0;
> +			print_unknown_handle = true;
> +			continue;
> +		}
>  
>  		k = 0;
>  		while (p_in->perms[k]) {
> @@ -74,13 +88,24 @@ selinux_set_mapping(struct security_class_mapping *map)
>  			}
>  			p_out->perms[k] = string_to_av_perm(p_out->value,
>  							    p_in->perms[k]);
> -			if (!p_out->perms[k])
> -				goto err2;
> +			if (!p_out->perms[k]) {
> +				selinux_log(SELINUX_INFO,
> +					    "SELinux:  Permission %s in class %s not defined in policy.\n",
> +					    p_in->perms[k], p_in->name);
> +				if (reject)
> +					goto err2;
> +				print_unknown_handle = true;
> +			}
>  			k++;
>  		}
>  		p_out->num_perms = k;
>  	}
>  
> +	if (print_unknown_handle)
> +		selinux_log(SELINUX_INFO,
> +			    "SELinux: the above unknown classes and permissions will be %s\n",
> +			    deny ? "denied" : "allowed");
> +
>  	/* Set the mapping size here so the above lookups are "raw" */
>  	current_mapping_size = i;
>  	return 0;
> @@ -184,27 +209,46 @@ void
>  map_decision(security_class_t tclass, struct av_decision *avd)
>  {
>  	if (tclass < current_mapping_size) {
> -		unsigned i;
> +		bool allow_unknown = (security_deny_unknown() == 0);
> +		struct selinux_mapping *mapping = &current_mapping[tclass];
> +		unsigned int i, n = mapping->num_perms;
>  		access_vector_t result;
>  
> -		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
> -			if (avd->allowed & current_mapping[tclass].perms[i])
> +		for (i = 0, result = 0; i < n; i++) {
> +			if (avd->allowed & mapping->perms[i])
> +				result |= 1<<i;
> +			else if (allow_unknown && !mapping->perms[i])
>  				result |= 1<<i;
> +		}
>  		avd->allowed = result;
>  
> -		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
> -			if (avd->decided & current_mapping[tclass].perms[i])
> +		for (i = 0, result = 0; i < n; i++) {
> +			if (avd->decided & mapping->perms[i])
> +				result |= 1<<i;
> +			else if (allow_unknown && !mapping->perms[i])
>  				result |= 1<<i;
> +		}
>  		avd->decided = result;
>  
> -		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
> -			if (avd->auditallow & current_mapping[tclass].perms[i])
> +		for (i = 0, result = 0; i < n; i++)
> +			if (avd->auditallow & mapping->perms[i])
>  				result |= 1<<i;
>  		avd->auditallow = result;
>  
> -		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
> -			if (avd->auditdeny & current_mapping[tclass].perms[i])
> +		for (i = 0, result = 0; i < n; i++) {
> +			if (avd->auditdeny & mapping->perms[i])
>  				result |= 1<<i;
> +			else if (!allow_unknown && !mapping->perms[i])
> +				result |= 1<<i;
> +		}
> +
> +		/*
> +		 * Make sure we audit denials for any permission check
> +		 * beyond the mapping->num_perms since this indicates
> +		 * a bug in the object manager.
> +		 */
> +		for (; i < (sizeof(result)*8); i++)
> +			result |= 1<<i;
>  		avd->auditdeny = result;
>  	}
>  }
> diff --git a/libselinux/src/reject_unknown.c b/libselinux/src/reject_unknown.c
> new file mode 100644
> index 00000000..5c1d3605
> --- /dev/null
> +++ b/libselinux/src/reject_unknown.c
> @@ -0,0 +1,40 @@
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include "selinux_internal.h"
> +#include "policy.h"
> +#include <stdio.h>
> +#include <limits.h>
> +
> +int security_reject_unknown(void)
> +{
> +	int fd, ret, reject_unknown = 0;
> +	char path[PATH_MAX];
> +	char buf[20];
> +
> +	if (!selinux_mnt) {
> +		errno = ENOENT;
> +		return -1;
> +	}
> +
> +	snprintf(path, sizeof(path), "%s/reject_unknown", selinux_mnt);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return -1;
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (ret < 0)
> +		return -1;
> +
> +	if (sscanf(buf, "%d", &reject_unknown) != 1)
> +		return -1;
> +
> +	return reject_unknown;
> +}
> +
> +hidden_def(security_reject_unknown);
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index dfc421cc..70b5025d 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(security_getenforce)
>      hidden_proto(security_setenforce)
>      hidden_proto(security_deny_unknown)
> +    hidden_proto(security_reject_unknown)
>      hidden_proto(security_get_checkreqprot)
>      hidden_proto(selinux_boolean_sub)
>      hidden_proto(selinux_current_policy_path)
