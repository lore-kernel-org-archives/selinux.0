Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C5CA0EC3
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 09:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjILJtt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjILJts (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 05:49:48 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F9E5F
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1694512181;
        bh=1iRVresMNVZjRMD2y38CGCxmcibrW4VxuiC4Qgv5O/A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EO9mmlLP3MOivk9eJBSlcLEA3+86KKTv3b7XyALlXYOqOXwVS9NrzadeQHlUBWi1P
         GAqEd0GBw8yy1/Fm+vcWBDsYlW4kyxzqlWEepawOeAugccaS5b6YrOmFGCAyXRaY5A
         Fqa6BmG7KrswLmtft0ySW71W9s3uwPbE0yM7BnyE=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
        by markus.defensec.nl (Postfix) with ESMTPSA id 86BDD19AD;
        Tue, 12 Sep 2023 11:49:41 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: generating new type name using CIL macro
In-Reply-To: <84e73105-41b7-22b6-2030-627e0e551684@redhat.com> (Vit Mojzis's
        message of "Tue, 12 Sep 2023 11:42:42 +0200")
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
        <87pm2ouk0s.fsf@defensec.nl>
        <84e73105-41b7-22b6-2030-627e0e551684@redhat.com>
Date:   Tue, 12 Sep 2023 11:49:40 +0200
Message-ID: <87ledbbu17.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> Hi Dominick,
> thank you for the suggestion. I know about block inheritance, but it
> produces type/role names that are not consistent with refpolicy ("."
> separating the new block name and it's content). My goal is to create
> new SELinux users and corresponding roles and it would be confusing
> for users to switch between roles with different naming schemes
> (e.g. "secadm_r" vs. "customuser.r"). Given that "typeinherit"
> statements don't seem to be supported, I'm trying my luck with macros
> to replicate interfaces.

I figured. You could alternatively create an abstraction c.q.
HLL. Depending on your requirements that does not have to be
complicated. Could be some shell, python or M4 that does the templating for
you. Essentially that is what refpolicy2 does with its M4 usage.


>
> Thank you,
> Vit
>
> On 9/12/23 05:50, Dominick Grift wrote:
>> Vit Mojzis <vmojzis@redhat.com> writes:
>>
>>> Hello all,
>>> while trying to recreate some selinux-policy templates using CIL
>>> macros I got stuck on creating new type/role/attribute names.
>>> For example consider ssh_role_template [1], which uses its first
>>> parameter to create a new type $1_ssh_agent_t.
>>>
>>> Is there a way to recreate such functionality in a CIL macro (or
>>> another CIL feature)?
>> CIL uses blocks for it implementation of templating. If you want to leve=
rage
>> native CIL then look into blocks.
>>
>> Example:
>>
>> cat > mytest.cil <<EOF
>> (typeattribute foo)
>>
>> (block t
>> (blockabstract t)
>> (type t)
>> (typeattributeset .foo t))
>>
>> (block bar
>> (blockinherit t))
>>
>> (block baz
>> (blockinherit t))
>>
>> (allow .foo .foo (process (signal)))
>> EOF
>>
>> sudo semodule -i mytest.cil
>>
>> seinfo -xafoo
>>
>> Type Attributes: 1
>>     attribute foo;
>>          bar.t
>>          baz.t
>>
>> sesearch -A -s foo -ds
>> allow foo foo:process signal;
>>
>>> Something along the lines of:
>>> (macro new_type_macro ((string type_prefix))
>>>  =C2=A0 (type (type_prefix)_t)
>>> )
>>> which when called (call new_type_macro ("yolo")) would produce
>>> (type yolo_t)
>>>
>>> I searched through CIL reference guide [2] and SELinuxProject CIL wiki
>>> on github, but didn't find anything close (maybe there is a better
>>> resource I don't know about).
>>> I'd appreciate any hints or links to other resources related to CIL mac=
ros.
>>>
>>> Thank you,
>>> Vit
>>>
>>> [1] -
>>> https://github.com/TresysTechnology/refpolicy/blob/master/policy/module=
s/services/ssh.if#L301
>>> [2] -
>>> https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/=
src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
>>> [3] - https://github.com/SELinuxProject/cil/wiki#macros
>>>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
