Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DEC48BE8
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A0C611ED
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhFROwg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234698AbhFROwf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 10:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624027825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0un1DgKOmdxLZnkQoGVk84OjwoDlVnWdNa4v3eN7BI=;
        b=a8STILUrzcXgLH+8XsjOKVciKJUmqtKTNnEkcF2wQO9FZ0TvNe8q04VjGmlD1Z+uigkI3A
        USry3WLBG5maYwBPe3TEB30wed4EhHOMp9bAwG98wMaEUbU7QhLMOJJp+xnvh5MPjM+C21
        AB8d/4J1jp37d0PEnRBuxmIK7mlBGc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Ms5Yi1lCPZiXJXrwb_OTXg-1; Fri, 18 Jun 2021 10:50:22 -0400
X-MC-Unique: Ms5Yi1lCPZiXJXrwb_OTXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 344031084F54;
        Fri, 18 Jun 2021 14:50:20 +0000 (UTC)
Received: from localhost (unknown [10.40.195.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 902A161145;
        Fri, 18 Jun 2021 14:50:19 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>, HuaxinLu <luhuaxin1@foxmail.com>
Subject: Re: [PATCH] libsemanage: fix use-after-free in parse_module_store()
In-Reply-To: <CAP+JOzRjAoU2oRueyT6sPv9-xjVtjzhyxzXLuR6Pubd+-=R7jA@mail.gmail.com>
References: <tencent_90BF03402499B510C39EB8BC137D04294607@qq.com>
 <CAP+JOzRjAoU2oRueyT6sPv9-xjVtjzhyxzXLuR6Pubd+-=R7jA@mail.gmail.com>
Date:   Fri, 18 Jun 2021 16:50:18 +0200
Message-ID: <87sg1f1b2t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

EJames Carter <jwcart2@gmail.com> writes:

> On Mon, Jun 14, 2021 at 12:52 AM HuaxinLu <luhuaxin1@foxmail.com> wrote:
>>
>> The passing parameter "arg" of parse_module_store will be freed after
>> calling. A copy of parameter should be used instead of itself.
>>
>> Signed-off-by: HuaxinLu <luhuaxin1@foxmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!


>> ---
>>  libsemanage/src/conf-parse.y | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
>> index 9bf9364a..eac91344 100644
>> --- a/libsemanage/src/conf-parse.y
>> +++ b/libsemanage/src/conf-parse.y
>> @@ -516,12 +516,12 @@ static int parse_module_store(char *arg)
>>                 char *s;
>>                 current_conf->store_type = SEMANAGE_CON_POLSERV_REMOTE;
>>                 if ((s = strchr(arg, ':')) == NULL) {
>> -                       current_conf->store_path = arg;
>> +                       current_conf->store_path = strdup(arg);
>>                         current_conf->server_port = 4242;
>>                 } else {
>>                         char *endptr;
>>                         *s = '\0';
>> -                       current_conf->store_path = arg;
>> +                       current_conf->store_path = strdup(arg);
>>                         current_conf->server_port = strtol(s + 1, &endptr, 10);
>>                         if (*(s + 1) == '\0' || *endptr != '\0') {
>>                                 return -2;
>> --
>> 2.26.0
>>

