Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1DC433F5
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA095615E1
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbhIMNwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244040AbhIMNsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 09:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631540854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=np3n3mF+T6YBhTM1xtesVgutAwEWYyLa7qoYH0h+gNI=;
        b=TttHka+9zh1wxXv0ktJYxNIgMxWg1JvolCMWH9Re/mdIoVDVgr2AZIwSK5tkKN5N/4ogKa
        jRHJfLzOxyARXOJ6JbGAvJh/iplg38FUzc3FtV1bGd6zsAKccYpq/Mr9AFPxb2WSDZpesd
        ZDQ+IeCBcWGj+JG6bTX3iJE8gOvrywA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-meCkvWMaMPiAAHG2Du0NmA-1; Mon, 13 Sep 2021 09:47:33 -0400
X-MC-Unique: meCkvWMaMPiAAHG2Du0NmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0116802923;
        Mon, 13 Sep 2021 13:47:32 +0000 (UTC)
Received: from localhost (unknown [10.40.194.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A91E19724;
        Mon, 13 Sep 2021 13:47:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
In-Reply-To: <CAP+JOzSPPvutC=U_zMpd_=VVLvmAcTkiGQ8Q99G_vscLPSazgQ@mail.gmail.com>
References: <20210909164441.354970-1-plautrba@redhat.com>
 <CAP+JOzSPPvutC=U_zMpd_=VVLvmAcTkiGQ8Q99G_vscLPSazgQ@mail.gmail.com>
Date:   Mon, 13 Sep 2021 15:47:31 +0200
Message-ID: <87r1dsa8p8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Sep 9, 2021 at 12:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> libsepol/cil/src/cil_binary.c:4823: alloc_arg: "bounds_check_type" allocates memory that is stored into "bad".
>> libsepol/cil/src/cil_binary.c:4840: var_assign: Assigning: "cur" = "bad".
>> libsepol/cil/src/cil_binary.c:4844: noescape: Resource "cur" is not freed or pointed-to in "cil_avrule_from_sepol".
>> libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "cur" going out of scope leaks the storage it points to.
>> libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "bad" going out of scope leaks the storage it points to.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.


>> ---
>>  libsepol/cil/src/cil_binary.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 43c37fc24686..4a80cb562424 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -4842,6 +4842,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>>                                 rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
>>                                 if (rc != SEPOL_OK) {
>>                                         cil_log(CIL_ERR, "Failed to convert sepol avrule to CIL\n");
>> +                                       bounds_destroy_bad(bad);
>>                                         goto exit;
>>                                 }
>>                                 __cil_print_rule("  ", "allow", &target);
>> --
>> 2.32.0
>>

