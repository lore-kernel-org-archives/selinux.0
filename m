Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAFCC433FE
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535B561AFE
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbhIMNpv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240298AbhIMNne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 09:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631540536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Qsu86+Cgy2AgclASO+ThEjfuTg38MT9+OIEQdMLt7U=;
        b=i60925PvgjUwcKhbRegOYfAS/fIldFwTr2zmJL0kTAo+2zw4HUNCRzEHeCVuuXMdhdc2qy
        MYasM25SPoU1H+LOlSZnZcRKQUyVeB/oJWtpWHGLqotIQCjWAPM53ZoETu6zJ9yNWzK2ee
        868h7Hv5U4VzzJi+q//56Lno6ryngVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-d-AB8HdcO7CajSqWZtwuvw-1; Mon, 13 Sep 2021 09:42:13 -0400
X-MC-Unique: d-AB8HdcO7CajSqWZtwuvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E9784A5E8;
        Mon, 13 Sep 2021 13:42:12 +0000 (UTC)
Received: from localhost (unknown [10.40.194.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E8D910013C1;
        Mon, 13 Sep 2021 13:42:12 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] libsepol: fix typo
In-Reply-To: <CAP+JOzSd28YWZdzFcJ9m33bWk6n9LdnYfjW=9Baz540G4Zt76g@mail.gmail.com>
References: <20210910121252.71710-1-toiwoton@gmail.com>
 <CAP+JOzSd28YWZdzFcJ9m33bWk6n9LdnYfjW=9Baz540G4Zt76g@mail.gmail.com>
Date:   Mon, 13 Sep 2021 15:42:11 +0200
Message-ID: <87tuioa8y4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Sep 10, 2021 at 8:13 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!



>> ---
>>  libsepol/src/module_to_cil.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index 9c7e3d3a..3c8ba10a 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -573,7 +573,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
>>                 rule = "auditallow";
>>                 break;
>>         case AVRULE_AUDITDENY:
>> -               rule = "auditdenty";
>> +               rule = "auditdeny";
>>                 break;
>>         case AVRULE_DONTAUDIT:
>>                 rule = "dontaudit";
>> --
>> 2.30.2
>>

