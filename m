Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF60C433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 14:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376979AbiDDOS3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDOS2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 10:18:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7BC3D1DB
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 07:16:31 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 39A1020DFD48;
        Mon,  4 Apr 2022 07:16:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39A1020DFD48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649081791;
        bh=YlTqWc/5FIve88guK7FJO+zOri7Y+PuvfuOh8pmV6o4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l/XVUbFjLWCXGfBGAV+yFFsvglTW6fg2r/ykc447JUtTJ2hUYcP+qPqDFr+mxtXxs
         LFTurcEOc/NuH3d4WA4C2YEuRUb/wv5aZNu373LC5HrMNVutPp5pdDNKHmzTBgRGto
         ZY3bQpwfFnpMwLbzt4FfdR9Gs13hdI24dFYSJHp8=
Message-ID: <d593edf2-8442-dc27-dce9-27b3b6363757@linux.microsoft.com>
Date:   Mon, 4 Apr 2022 10:16:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 Notebook] How to add a new policy capability
Content-Language: en-US
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20220404082947.5817-1-richard_c_haines@btinternet.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220404082947.5817-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/4/2022 4:29 AM, Richard Haines wrote:
> Describes the steps required to add a new policy capability to:
> kernel, libsepol, and policy.
> 
> Also add the ioctl_skip_cloexec capability description.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Clarify naming conventions.
> Change enums from POLICYDB_CAPABILITY to POLICYDB_CAP
> Add ioctl_skip_cloexec
> 
>   src/lsm_selinux.md              |   4 +
>   src/policy_config_statements.md | 139 ++++++++++++++++++++++++++++++++
>   2 files changed, 143 insertions(+)
> 
> diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
> index 560d89f..2fa34dd 100644
> --- a/src/lsm_selinux.md
> +++ b/src/lsm_selinux.md
> @@ -712,6 +712,10 @@ or *libsepol* library.
>   - Enables fine-grained labeling of symlinks in pseudo filesystems based
>     on *genfscon* rules.
>   
> +*policy_capabilities/ioctl_skip_cloexec*
> +
> +- If true always allow FIOCLEX and FIONCLEXE ioctl permissions (from kernel 5.18).
> +
>   *policy_capabilities/network_peer_controls*
>   
>   - If true the following *network_peer_controls* are enabled:
> diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
> index d4eee48..90bf440 100644
> --- a/src/policy_config_statements.md
> +++ b/src/policy_config_statements.md
> @@ -1,5 +1,12 @@
>   # Policy Configuration Statements
>   
> +- [*policycap*](#policycap)
> +  - [Adding A New Policy Capability](#adding-a-new-policy-capability)
> +    - [Kernel Updates](#kernel-updates)
> +    - [*libsepol* Library Updates](#libsepol-library-updates)
> +    - [Reference Policy Updates](#reference-policy-updates)
> +    - [CIL Policy Updates](#cil-policy-updates)
> +
>   ## *policycap*
>   
>   Policy version 22 introduced the *policycap* statement to allow new
> @@ -47,6 +54,138 @@ Conditional Policy Statements
>   policycap network_peer_controls;
>   ```
>   
> +## Adding A New Policy Capability
> +
> +The kernel, userspace libsepol library and policy must be updated to enable
> +the new capability as described below. For readability, the new capability
> +should follow a consistent naming convention, where:
> +
> +- policy capability identifier is a lower-case string.
> +- enum definition is ```POLICYDB_CAP_``` with the indentifier appended in
> +  upper-case.
> +- kernel function call is ```selinux_policycap_``` with the indentifier
> +  appended in lower-case.

Second and third bullets have a typo of "indentifier" instead of 
"identifier"

> +
> +### Kernel Updates
> +
> +In kernel source update the following three files with the new capability:
> +
> +***security/selinux/include/policycap_names.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capability names */
> +const char *selinux_policycap_names[__POLICYDB_CAP_MAX] = {
> +	...
> +	"genfs_seclabel_symlinks",
> +	"ioctl_skip_cloexec",
> +	"new_name"
> +};
> +```
> +
> +***security/selinux/include/policycap.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capabilities */
> +enum {
> +	...
> +	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> +	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> +	POLICYDB_CAP_NEW_NAME,
> +	__POLICYDB_CAP_MAX
> +};
> +```
> +
> +***security/selinux/include/security.h***
> +
> +Add a new call to retrieve the loaded policy capability state:
> +
> +```
> +static inline bool selinux_policycap_new_name(void)
> +{
> +	struct selinux_state *state = &selinux_state;
> +
> +	return READ_ONCE(state->policycap[POLICYDB_CAP_NEW_NAME]);
> +}
> +```
> +
> +Finally in the updated code that utilises the new policy capability do
> +something like:
> +
> +```
> +if (selinux_policycap_new_name())
> +	do this;
> +else
> +	do that;
> +```
> +
> +### *libsepol* Library Updates
> +
> +In selinux userspace source update the following two files with the new
> +capability:
> +
> +***selinux/libsepol/src/polcaps.c***
> +
> +Add new entry at end of this list:
> +
> +```
> +static const char * const polcap_names[] = {
> +	...
> +	"genfs_seclabel_symlinks",	/* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
> +	"ioctl_skip_cloexec",		/* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
> +	"new_name",			/* POLICYDB_CAP_NEW_NAME */
> +	NULL
> +};
> +```
> +
> +***selinux/libsepol/include/sepol/policydb/polcaps.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capabilities */
> +enum {
> +	...
> +	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> +	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> +	POLICYDB_CAP_NEW_NAME,
> +	__POLICYDB_CAP_MAX
> +};
> +```
> +
> +### Reference Policy Updates
> +
> +The new policy capability identifier is then added to the Reference Policy file:

This should probably be written as a directive to match the other 
instructions rather than in passive voice?

> +
> +***policy/policy_capabilities***
> +
> +To enable the capability in policy:
> +
> +```
> +# A description of the capability
> +policycap new_name;
> +```
> +
> +To disable the capability comment out the entry:

nit: I'd put a comma after capability

> +
> +```
> +# A description of the capability
> +#policycap new_name;
> +```
> +
> +### CIL Policy Updates
> +
> +To enable the capability in policy, add the following entry to a CIL
> +source file:
> +
> +```
> +; A description of the capability
> +(policycap new_name)
> +```
> +
>   <!-- %CUTHERE% -->
>   
>   ---

