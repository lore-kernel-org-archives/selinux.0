Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3830C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC6206B7
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfAIWD1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:03:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfAIWD1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Jan 2019 17:03:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51D9FC0C6C1D;
        Wed,  9 Jan 2019 22:03:26 +0000 (UTC)
Received: from workstation (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B19525D763;
        Wed,  9 Jan 2019 22:03:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@tycho.nsa.gov
Subject: Re: [PATCH v2] libsemanage: set selinux policy root around calls to selinux_boolean_sub
References: <20190108134822.13184-1-sds@tycho.nsa.gov>
Date:   Wed, 09 Jan 2019 23:03:22 +0100
In-Reply-To: <20190108134822.13184-1-sds@tycho.nsa.gov> (Stephen Smalley's
        message of "Tue, 8 Jan 2019 08:48:22 -0500")
Message-ID: <pjdo98pfpzp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 22:03:26 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
> tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
> it invokes the libselinux selinux_boolean_sub() interface, which uses
> the active/installed policy files rather than the libsemanage ones.
>
> Switch the selinux policy root around the selinux_boolean_sub() call
> to incorporate the semanage root as a prefix and to use the specified
> policy store as a suffix so that the correct booleans.subs_dist file
> (if any) is used.
>
> The underlying bug is that booleans.subs_dist is not itself managed
> via libsemanage. If it was managed and therefore lived within the
> policy store, then libsemanage could access the appropriate
> booleans.subs_dist file without using the libselinux interface at all,
> and thus would not need to modify the selinux policy root.  Moving
> booleans.subs_dist to a managed file is deferred to a future change.
>
> Test:
> dnf install selinux-policy-minimum selinux-policy-targeted
> cd / && tar cf - etc/selinux var/lib/selinux | (cd ~/policy-root; tar xvpf -)
> strace semodule -p ~/policy-root -s minimum -n -B
>
> Before:
> openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>
> After:
> openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>
> Fixes https://github.com/SELinuxProject/selinux/issues/109
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
> v2 skips setting of the policy root if they already match, introduces a
> hidden prototype and definition for internal callers of semanage_root(),
> and tests that selinux_policy_root() is non-NULL before strdup'ing it.
>  libsemanage/src/boolean_record.c  | 54 +++++++++++++++++++++++++++++--
>  libsemanage/src/handle.c          |  2 ++
>  libsemanage/src/handle_internal.h |  9 +++---
>  3 files changed, 59 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
> index 665c0223..c234094e 100644
> --- a/libsemanage/src/boolean_record.c
> +++ b/libsemanage/src/boolean_record.c
> @@ -6,7 +6,9 @@
>   * Implements: record_key_t (Database Record Key)
>   */
>  
> +#include <string.h>
>  #include <sepol/boolean_record.h>
> +#include "handle_internal.h"
>  
>  typedef sepol_bool_t semanage_bool_t;
>  typedef sepol_bool_key_t semanage_bool_key_t;
> @@ -84,10 +86,58 @@ hidden_def(semanage_bool_get_name)
>  int semanage_bool_set_name(semanage_handle_t * handle,
>  			   semanage_bool_t * boolean, const char *name)
>  {
> -	int rc;
> -	char *subname = selinux_boolean_sub(name);
> +	int rc = -1;
> +	const char *prefix = semanage_root();
> +	const char *storename = handle->conf->store_path;
> +	const char *selinux_root = selinux_policy_root();
> +	char *oldroot;
> +	char *olddir;
> +	char *subname = NULL;
> +	char *newroot = NULL;
> +	char *end;
> +
> +	if (!selinux_root)
> +		return -1;
> +
> +	oldroot = strdup(selinux_root);
> +	if (!oldroot)
> +		return -1;
> +	olddir = strdup(oldroot);
> +	if (!olddir)
> +		goto out;
> +	end = strrchr(olddir, '/');
> +	if (!end)
> +		goto out;
> +	end++;
> +	*end = '\0';
> +	rc = asprintf(&newroot, "%s%s%s", prefix, olddir, storename);
> +	if (rc < 0)
> +		goto out;
> +
> +	if (strcmp(oldroot, newroot)) {
> +		rc = selinux_set_policy_root(newroot);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	subname = selinux_boolean_sub(name);
> +	if (!subname) {
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	if (strcmp(oldroot, newroot)) {
> +		rc = selinux_set_policy_root(oldroot);
> +		if (rc)
> +			goto out;
> +	}
> +
>  	rc = sepol_bool_set_name(handle->sepolh, boolean, subname);
> +out:
>  	free(subname);
> +	free(oldroot);
> +	free(olddir);
> +	free(newroot);
>  	return rc;
>  }
>  
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index a6567bd4..e5109aef 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -58,6 +58,8 @@ const char * semanage_root(void)
>  	return private_semanage_root;
>  }
>  
> +hidden_def(semanage_root);
> +
>  semanage_handle_t *semanage_handle_create(void)
>  {
>  	semanage_handle_t *sh = NULL;
> diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
> index 66ce2708..d4b4d9c7 100644
> --- a/libsemanage/src/handle_internal.h
> +++ b/libsemanage/src/handle_internal.h
> @@ -5,8 +5,9 @@
>  #include "dso.h"
>  
>  hidden_proto(semanage_begin_transaction)
> -    hidden_proto(semanage_handle_destroy)
> -    hidden_proto(semanage_reload_policy)
> -    hidden_proto(semanage_access_check)
> -    hidden_proto(semanage_set_root)
> +hidden_proto(semanage_handle_destroy)
> +hidden_proto(semanage_reload_policy)
> +hidden_proto(semanage_access_check)
> +hidden_proto(semanage_set_root)
> +hidden_proto(semanage_root)
>  #endif
