Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1146C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A13A21744
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="IgPYr63Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGQEi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:04:38 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:57262 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGQEh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Aug 2020 12:04:37 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id C309F2A151B;
        Fri,  7 Aug 2020 18:04:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl C309F2A151B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596816275;
        bh=2RGE5LAnTkdoPiwsclnJ/y26or/uHMWA346tctre7AQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IgPYr63ZryQyRuWNa936tR/hyrXnlHx3YmusKfx+5QguWP3HHHbBTgAwkOQwsf3pO
         qLZDfh2UR6/QYLczDYt2AP8Me5iKyhfHLU7WlyK1g5GsB81kNrNEEllQOZe9XkIYEZ
         LSfcVhrPq2qY92RZv95/ttUmjaor3hKRguZyfhFk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        paul@paul-moore.com, selinux@vger.kernel.org
Subject: Re: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
        <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com>
Date:   Fri, 07 Aug 2020 18:04:30 +0200
In-Reply-To: <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com> (Stephen
        Smalley's message of "Fri, 7 Aug 2020 11:27:00 -0400")
Message-ID: <ypjl364y8msx.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On 8/7/20 10:40 AM, Richard Haines wrote:
>
>> This is an RFC patch to get some feedback as:
>> 1) Table 1 is now a pipe table, however it still has <br> codes to
>>     break up the text. Also updated styles.html.css to match the pdf ver=
sion
>>     to allow correct HTML rendering.
>> 2) Table 2 is now a pipe table with updated text.
>>
>> Add a TOC to aid navigation
>> Add text to clarify MCS/MLS
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>
>> @@ -48,6 +56,18 @@ The sections that follow discuss the format of a secu=
rity level and
>>   range, and how these are managed by the constraints mechanism within
>>   SELinux using dominance rules.
>>   +### MLS or MCS Policy
>> +
>> +From an SELinux perspective:
>> +
>> +-   An MLS policy has more than one security level with zero or more ca=
tegories.
>> +    It is generally used in systems that require the 'Read Down' and 'W=
rite Up'
>> +    services, whether it be for files, network services etc..
>> +-   An MCS policy has a single security level with zero or more categor=
ies.
>> +    Example uses are virtualization (see the
>> +    [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine=
-support)
>> +    section) and container security.
>> +
>
> To be clear, SELinux (i.e. the code/mechanism) only knows of MLS,
> i.e. it has a MLS engine in the security server and a MLS portion of
> the policy configuration that drives that engine.=C2=A0 That MLS engine h=
as
> been leveraged by two different types of policies, the original MLS
> configuration modeled after Bell-LaPadula and the later-introduced MCS
> configuration (which underwent a fundamental transformation from being
> user-facing and somewhat discretionary to being a transparent
> isolation mechanism for sandbox, container, and virtualization
> runtimes). The number of sensitivities, number of categories, and the
> set of MLS constraints used to determine whether a permission is
> allowed are entirely up to the policy author. A level in SELinux is a
> combination of a hierarchical sensitivity and a non-hierarchical
> (potentially empty) category set. In practice MCS is used for simple
> isolation and therefore doesn't employ sensitivities since there is no
> hierarchical relationship to be enforced.
>
>

Compartments might not be hierarcical in the sense of dominance but if
there was no hierarchy then I would argue the there would not be a need
for categoryorder.

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
