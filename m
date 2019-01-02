Return-Path: <SRS0=NpCz=PK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FFC43387
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B8218E2
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfABONh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:13:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfABONh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 2 Jan 2019 09:13:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0C99653C8;
        Wed,  2 Jan 2019 14:13:36 +0000 (UTC)
Received: from workstation (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 274C51019632;
        Wed,  2 Jan 2019 14:13:35 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 3/4] python/sepolicy: Add sepolicy.load_store_policy(store)
References: <20181220151420.30878-1-plautrba@redhat.com>
        <20181220151420.30878-4-plautrba@redhat.com>
        <CAJfZ7==MHDK9HjB0o-BiMitED=8vGRqLyRZ=wu266pXi1muG_g@mail.gmail.com>
Date:   Wed, 02 Jan 2019 15:13:34 +0100
In-Reply-To: <CAJfZ7==MHDK9HjB0o-BiMitED=8vGRqLyRZ=wu266pXi1muG_g@mail.gmail.com>
        (Nicolas Iooss's message of "Thu, 20 Dec 2018 22:55:24 +0100")
Message-ID: <pjdzhsjtaep.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 02 Jan 2019 14:13:36 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Dec 20, 2018 at 4:14 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> load_store_policy() allows to (re)load SELinux policy based on a store name. It
>> is useful when SELinux is disabled and default policy is not installed; or when
>> a user wants to query or manipulate another policy.
>>
>> Related: https://bugzilla.redhat.com/show_bug.cgi?id=1558861
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  python/sepolicy/sepolicy/__init__.py | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index fbeb731d..b69a6b94 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -129,6 +129,13 @@ def get_installed_policy(root="/"):
>>          pass
>>      raise ValueError(_("No SELinux Policy installed"))
>>
>> +def get_store_policy(store, root="/"):
>> +    try:
>> +        policies = glob.glob("%s%s/policy/policy.*" % (selinux.selinux_path(), store))
>> +        policies.sort()
>> +        return policies[-1]
>> +    except:
>> +        return None
>
> Hi, I agree this function is useful. Nevertheless the sorting order
> seems to be fragile because '100' < '99', so the policy filename needs
> to be parsed in order to extract the version as an integer and sort
> according to it. Moreover its second parameter ("root") is not used
> and I would rather avoid adding new bare excepts to the code base.
>
> I suggest the following implementation of this function:
>
> def get_store_policy(store):
>     """Get the path to the policy file located in the given store name"""
>     def policy_sortkey(policy_path):
>         # Parse the extension of a policy path which looks like
> .../policy/policy.31
>         extension = policy_path.rsplit('/policy.', 1)[1]
>         try:
>             return int(extension), policy_path
>         except ValueError:
>             # Fallback with sorting on the full path
>             return 0, policy_path
>     policies = glob.glob("%s%s/policy/policy.*" %
> (selinux.selinux_path(), store))
>     if not policies:
>         return None
>     # Return the policy with the higher version number
>     policies.sort(key=policy_sortkey)
>     return policies[-1] if policies else None
>
> It is more complex but fixes the issues I have identified. If you want
> to keep "root", it may be possible to use it with both
> "glob.glob("%s/%s/%s/policy/policy.*" % (root, selinux.selinux_path(),
> store))" and "return os.path.realpath(policies[-1]) if policies else
> None" (in order to simplify double-slashes into a single "/"
> character). What do you think of this?
>

It looks good to me. I'll only move policy_sortkey out of this function
and use it in also get_installed_policy() as this function use the
original sort method.

Petr
