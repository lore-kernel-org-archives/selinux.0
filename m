Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D4C433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 20:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5837420684
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 20:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="A+DZ23/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGUUOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUOX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 16:14:23 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 957B7C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 13:14:23 -0700 (PDT)
Received: from brutus (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 7F7A42A06FB
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 22:14:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 7F7A42A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595362461;
        bh=uRGRIkQGg8SK7zYSpOI6TiKCMtZfIRdqIWnrlR+oh7A=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=A+DZ23/qr4sGjJKD8oBDm07/28ubBneKeaySAByXiZygKf/2SaeJkb3GkLK1zmz3E
         k9S8wG+E7VXPyPQBfrKYUD1o88mEChln3czsxVvGKuLDVsRErrIQk2HZP3O/t3qh7o
         B3oUzDwpwcfUq6FhUFbhKaEfgoAG22wLKpCqXOR8=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
        <20200721200230.1976501-1-dominick.grift@defensec.nl>
Date:   Tue, 21 Jul 2020 22:14:16 +0200
In-Reply-To: <20200721200230.1976501-1-dominick.grift@defensec.nl> (Dominick
        Grift's message of "Tue, 21 Jul 2020 22:02:30 +0200")
Message-ID: <ypjl365kzkvb.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> Elaborate on labeling. Touch on the significance of the default statement, on various av permissions related to labeling using the libselinux API, and on how the kernel and unlabeled initial security identifiers are used to address labeling challenges in special cases such as initialization and failover respectively.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>
> v2: fixes patch description
> v3: adding patch description, s/policies/policy's/, split unlabeled and kernel descriptions for clarity
> v4: fixes another typo in description and emphasize system initialization a bit
> v5: emphasize kernel threads with kernel isid description
> v6: forgot to mention defaultuser, can only associate one label with isids
> v7: copied and pasted feedback from Stephen Smalley
> v8: missed a s/access vectors/permissions/ instance
>
>  src/objects.md | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/src/objects.md b/src/objects.md
> index 58664ef..1907316 100644
> --- a/src/objects.md
> +++ b/src/objects.md
> @@ -110,14 +110,20 @@ objects is managed by the system and generally unseen by the users
>  (until labeling goes wrong !!). As processes and objects are created and
>  destroyed, they either:
>  
> -1.  Inherit their labels from the parent process or object.
> +1.  Inherit their labels from the parent process or object. The policy
> +    default user, type, role and range statements can be used to
> +	change the behavior as discussed in the [**Default Rules**](default_rules.md#default-object-rules)
> +    section.
>  2.  The policy type, role and range transition statements allow a
>      different label to be assigned as discussed in the
>      [**Domain and Object Transitions**](domain_object_transitions.md#domain-and-object-transitions)
>      section.
> -3.  SELinux-aware applications can enforce a new label (with the
> -    policies approval of course) using the **libselinux** API
> -    functions.
> +3.  SELinux-aware applications can assign a new label (with the
> +    policy's approval of course) using the **libselinux** API
> +    functions. The `process setfscreate` permission can be used to
> +    allow subjects to create files with a new label programmatically
> +    using the ***setfscreatecon**(3)* function, overriding default
> +    rules and transition statements.
>  4.  An object manager (OM) can enforce a default label that can either
>      be built into the OM or obtained via a configuration file (such as
>      those used by
> @@ -269,6 +275,39 @@ and manage their transition:
>  
>  `type_transition`, `role_transition` and `range_transition`
>  
> +SELinux-aware applications can assign a new label (with the policy's
> +approval of course) using the **libselinux** API functions. The
> +`process setexec`, `process setkeycreate` and `process setsockcreate`
> +permissions can be used to allow subjects to label processes,
> +kernel keyrings, and sockets programmatically using the
> +***setexec**(3)*, ***setkeycreatecon**(3)* and
> +***setsockcreatecon**(3)* functions respectively, overriding
> +transition statements.
> +
> +The `kernel` **initial security identifier** is used to associate
> +a specified label with kernel objects, including kernel threads
> +(both those that are created during initialization but also kernel
> +threads created later), kernel-private sockets, synthetic objects
> +representing kernel resources (e.g. the "system" class).
> +
> +It is true that processes created prior to initial policy load will
> +also be in the kernel SID until/unless there is a policy loaded and
> +either a policy-defined transition or an explicit setcon or
> +setexeccon+execve, but that's just the typical default inheritance
> +from creating task behavior for processes.
> +
> +The `unlabeled` **initial security identifier** is used
> +to associate a specified label with subjects that had their label
> +invalidated due to policy changes at runtime.
> +
> +It is also assigned as the initial state for various objects e.g.
> +inodes, superblocks, etc until they reach a point where a more
> +specific label can be determined e.g. from an xattr or from policy.
> +The context associated with the unlabeled SID is used as the fallback
> +context for both subjects and objects when their label is invalidated
> +by a policy reload (their SID is unchanged but the SID is
> +transparently remapped to the unlabeled context).

I will note here that I suspect there is currently something broken
with libselinux / unlabeled sids

libselinux consumers still use *invalidated* contexts associated with
inodes to compute access vectors.

for example rpm will not consistently work until the filesystems are
relabeled after a new policy is loaded that invalidates contexts
currently associated with /bin/sh (entrypoint for setfscreatecon to
"rpm_script_t")

systemd will not consistently work until the filesystems are relabeled
after a new policy loaded that invalidates contexts currently associated
with (i suspect) parent directories for socket activated sock files
(maybe setfscreatecon?)

> +
>  ### Object Reuse
>  
>  As GNU / Linux runs it creates instances of objects and manages the

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
