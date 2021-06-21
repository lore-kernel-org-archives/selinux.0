Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127FC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25976120D
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUOLr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUOLq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 10:11:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1EC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:09:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gn32so1623132ejc.2
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZV3oWs08nbjzQeq3Ar1ERx8YX5O0oSA1z8+45qJWqc=;
        b=q7+/C8S9281i0hVLI/IJdUavaCXflq2B+tFIGHXiNmBDZdtge/Jds69kPtow34SSgY
         5G60p5khU8E4ua83tG5/fD5temeSMkNbJgcFRVQSjJOoSau2+LJgBJ5oijxw1jVYK0ZF
         3K5SuPBerVaEmA3Z93LdGl9QmEhItVHXzx48BmTUbEWqyFKjq/scm7MVA/cESK5E5Nkq
         cswwnBYnrgJ0cKy91QSa9WBdRObaTD/cQ6l0y+e+fZgy5OMOAn+ki5LrLUqNwDmWH5tG
         e0ozeDgYRI/pk3nr0agpU+qrG95+Fbz6kL2TyNofof10/WDNKL49LSwxsyqK9Ly6NbGV
         Sp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZV3oWs08nbjzQeq3Ar1ERx8YX5O0oSA1z8+45qJWqc=;
        b=Vh7kUObfQeQTzGhWK8Qk8KY0d3S2R2p0Ha4FN6u9OnZD1KmU2N7I2cGWyQtLTbuRCU
         DU5Sj6oBbH4a3+TDlr30MWqIUC1UxuF6Yr/8it4fBefXAz6zGQa2ReNswyR1Ue6XwKtU
         4Uqri6K3IKjI714JLjnp1c0JJ00aT2V3Nsm7mHQPpGuRAMcEbv6OKrRJe5RS5xyDJpwE
         zngbvxi6izXFo4sjm/VAnH3j8WfcS26DnfywqX/++06xNY8nMeJA7x4XM3RzegnnZk5A
         3Y2LE6nicqPaAq8HucRPMeCcdtIb2jVZE/LnksfwRt4CipqxRhIYIcOX7o6w8T9jnu22
         Nqrw==
X-Gm-Message-State: AOAM53345RNFwUeEs+yg+u2cbUftqdeyfjayZAioF1mWf3cp3rhNSCLZ
        1HeQdi3vLNIkzdZOPRiD+Ki701/yAgPXBIH7iUOJ
X-Google-Smtp-Source: ABdhPJx98v5GQ+ZNPp6dxosbscRFQpyF6tphhMOWZJn2vSVxI1bvyLGLyYjPrN0e5nJ/l0F8nQUVFVQuj4ufXtx23Ws=
X-Received: by 2002:a17:907:d0c:: with SMTP id gn12mr22394589ejc.431.1624284569684;
 Mon, 21 Jun 2021 07:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210612081403.16732-1-toiwoton@gmail.com> <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
 <44734663-73fe-5870-f39a-e3d876efbc45@gmail.com> <CAHC9VhQfVqRCuR4Gn7vAOrqVeZQtzE6GjuqvFhQHKVufCk_N3w@mail.gmail.com>
 <7d638d58-386f-b0e9-7a3d-e626fc8ba108@gmail.com>
In-Reply-To: <7d638d58-386f-b0e9-7a3d-e626fc8ba108@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Jun 2021 10:09:18 -0400
Message-ID: <CAHC9VhSs2XosF5WzN-t76G7N_WnXctV5opV+Xd63En3i_F3z8w@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 18, 2021 at 4:37 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 18.6.2021 22.32, Paul Moore wrote:
> > On Fri, Jun 18, 2021 at 2:09 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> >> On 18.6.2021 6.50, Paul Moore wrote:
> >>> On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >>>>
> >>>> Describe cases where nosuid_transition or nnp_transition are needed.
> >>>>
> >>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> >>>> ---
> >>>>    src/computing_security_contexts.md | 9 ++++++++-
> >>>>    1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
> >>>> index bb946b5..7bd1d87 100644
> >>>> --- a/src/computing_security_contexts.md
> >>>> +++ b/src/computing_security_contexts.md
> >>>> @@ -84,7 +84,14 @@ Processes inherit their security context as follows:
> >>>>       *default_type* (policy version 28) or if a security-aware process,
> >>>>       by calling ***setexeccon**(3)* if permitted by policy prior to
> >>>>       invoking exec.
> >>>> -3. At any time, a security-aware process may invoke ***setcon**(3)* to
> >>>> +3. If the file system is mounted with *nosuid* flag, type transitions
> >>>> +   require permission *nosuid_transition*. If the thread has
> >>>> +   *no_new_privs* attribute set, the transition requires
> >>>> +   *nnp_transition*. For both transitions, policy capability
> >>>> +   *nnp_nosuid_transition* is also required. See also
> >>>> +   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
> >>>> +   section.
> >>>
> >>> Thanks for adding this text, however I might suggest the following changes:
> >>>
> >>> "If the loaded SELinux policy has the nnp_nosuid_transition policy
> >>> capability enabled there are potentially two additional permissions
> >>> that are required to permit a domain transition: nosuid_transition for
> >>> nosuid mounted filesystems, and nnp_transition for for threads with
> >>> the no_new_privs flag."
> >>>
> >>> ... does that make sense?
> >>
> >> Yes. I'd then add:
> >>
> >> "If nnp_nosuid_transition policy capability is disabled, such domain
> >> transitions are denied."
> >
> > In most cases, yes that is correct, but bounded domain transitions are
> > still allowed in the case where the nnp_nosuid_transition policy
> > capability is not enabled.
>
> I see. May I propose then:
>
> "If nnp_nosuid_transition policy capability is disabled, such domain
> transitions are denied but bounded domain transitions are still allowed.
> In bounded transitions, target domain is only allowed a subset of the
> permissions of the source domain."

That sounds good to me.

-- 
paul moore
www.paul-moore.com
