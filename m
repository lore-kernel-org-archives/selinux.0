Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB9C433E0
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E78207AE
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhADMwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhADMwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 07:52:04 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60AABC061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 04:51:24 -0800 (PST)
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A79022A12B1;
        Mon,  4 Jan 2021 13:51:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl A79022A12B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609764683;
        bh=Gum2/S49EAbxzn8vkc5bxCX9IxmZEN1ja+g4Pq5IQDQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AH95wGak7sUX176SxyUWa3RyNAvLSa6fwObYP/vAgOWCZ3vgSPh0+IWLBCRjKTs0n
         uPodn+OUshIuCwI3fkW/4sHIDzq1D3K25j0q0XkDN22yRMwFuZZvZ4Hfo9ooR/g9bj
         JP3RHQY6cFJomO61tiTrzDhnjQJnGeitAbUn6DmY=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        <ypjlzh1o523g.fsf@defensec.nl>
        <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
Date:   Mon, 04 Jan 2021 13:51:20 +0100
In-Reply-To: <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
        (Ashish Mishra's message of "Mon, 4 Jan 2021 18:09:26 +0530")
Message-ID: <ypjlv9cc50hj.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Dominick ,
>
> Thanks for inputs .
>
> a) This is an embedded board which logs in by default as a ROOT user.
>      Any pointers as to where can i look to debug the cause due to
> which context is "system_u"

Lack of PAM support or misconfigurated PAM config (pam_selinux needs to
be present in the appropriate PAM stacks)

>
> b) Apologies , but can you please help method / approach / debug
> points by which
>     -> I can evaluate the expected contexts for root & testuser
>     -> I can see that the labels are created using ls -alZ .
>         Is there any other method / debug point to check filesystems
> are labeled according to the policy.
>         ( as i am using standard refpolicy to create an default policy
> on board )

You start by determining the current context of the login user (id -Z
will print the context of the current shell). Then you determine the
context of the directory in which the file is created (ls -dZ)

With this information you can query:

sesearch -T -s "type returned by id -Z" | grep "type returned by ls -dZ"

That should return any existing "type_transition" rules where the type
of the user is the source and the type of the destination directory is a target

>
>
> Thanks ,
> Ashish

The question is whether you want/need IBAC/RBAC on an embedded device
with only one user (root)

In my policy for OpenWrt (which is a embedded wireless router firmare) i
do not use IBAC/RBAC either and i just add a rule that say's when the
login program (sshd) executes a shell then assume that this is a login
user shell and automatically transition from the sshd context to a specified
user context)

On embedded devices "modular reference policy" does not make sense to
use (these devices generally do not have the resources to compile/link
policy at runtime) IMHO and the "monolithic reference policy" does not work well with
PAM and users.

But, yes, if you want modular refpolicy on a multi-user system then you
probably want PAM

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
