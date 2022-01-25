Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914FC433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 15:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiAYPUH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344409AbiAYPSF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 10:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643123883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tuAW0aT+FSwxcierndXKVF+GrrRYmePgYHS78WP3YRs=;
        b=M0tn6gLz0UOt1+/xyFmIjlN3F1ZfjNf+TF4dC4/G0rD90DkccbSHZl9KO31Q9i18a6kEJ6
        fCseaRijpjjZaTZBD8W7l2j7mViD7skTnwDlyrHpVLGqjQrkuhyB8t7RlCKNs5XeTBlFWc
        rTbNOhGf5QBNDNAux1bD5yeAufjkeLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-pVwk1JgmM9Wlptql3IPYzQ-1; Tue, 25 Jan 2022 10:18:01 -0500
X-MC-Unique: pVwk1JgmM9Wlptql3IPYzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50B8D835E1B;
        Tue, 25 Jan 2022 15:18:00 +0000 (UTC)
Received: from localhost (unknown [10.40.195.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9CFC7E5A8;
        Tue, 25 Jan 2022 15:17:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH userspace 2/5] semodule,libsemanage: move module
 hashing into libsemanage
In-Reply-To: <CAFqZXNsw_i_rarut8kciLVKJiOM1e4e6cizpVk8bZSTZEjgdiw@mail.gmail.com>
References: <20220113143935.195125-1-omosnace@redhat.com>
 <20220113143935.195125-3-omosnace@redhat.com>
 <CAP+JOzSnr2xrZ=2_B2XVVtvb4fiz4dW1JBEhDfKZrjwbjzEA4w@mail.gmail.com>
 <CAFqZXNsw_i_rarut8kciLVKJiOM1e4e6cizpVk8bZSTZEjgdiw@mail.gmail.com>
Date:   Tue, 25 Jan 2022 16:17:58 +0100
Message-ID: <874k5ru9nd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Jan 20, 2022 at 10:52 PM James Carter <jwcart2@gmail.com> wrote:
>> On Thu, Jan 13, 2022 at 6:36 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> >
>> > The main goal of this move is to have the SHA-256 implementation under
>> > libsemanage, since upcoming patches will make use of SHA-256 for a
>> > different (but similar) purpose in libsemanage. Having the hashing code
>> > in libsemanage will reduce code duplication and allow for easier hash
>> > algorithm upgrade in the future.
>> >
>> > Note that libselinux currently also contains a hash function
>> > implementation (for yet another different purpose). This patch doesn't
>> > make any effort to address that duplicity yet.
>> >
>> > The changes here are only refactoring, no functional change is done
>> > here. A new libsemanage API function semanage_module_compute_checksum()
>> > is provided and semodule is made to use it for implementing its
>> > hash_module_data() function.
>> >
>> > Note that the API function also returns a string representation of the
>> > hash algorithm used, which is currently unused by semodule. The intent
>> > is to avoid ambiguity and potential collisions when the algorithm is
>> > potentially changed in the future. I could add the hash algorithm to the
>> > semodule output, but doing so might break tools parsing the exisiting
>> > format. (RFC: Should I change it anyway?)
>> >
>>
>> So that it would be a part of the hash string returned by
>> hash_module_data() in semodule.c?
>
> Yes. I imagine something like
> "sha256:0123456789abcfdef0123456789abcfdef0123456789abcfdef0123456789abcfdef"
> as used in the checksum file for the module changes detection.
>
>> I would want to hear from people who use the hashes before I would
>> want to change anything.
>
> Yep, I guess this is mainly a question for Petr, who was in contact
> with the team requesting this feature. Petr?
>

Given that it's used as a string and just compared whether it's same, I
guess it would be ok to change it. ssh uses a similar format for
fingerprint - SHA256:vEJndgoJKp27dZKD/R1i34ViA6Fn3VfOB6UjmWIQD5g - so it
makes sense.

To make it simple for users, it would be great if `semodule` provides
posibility to show a checksum also for module files, e.g. users would just
compare output of `semodule --checksum --show ./module.pp` and `semodule
--checksum --show module.pp` Some time ago I started to work `--show`
but haven't finished it yet.


Petr






