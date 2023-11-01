Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B4C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjKAJqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 05:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F2DB
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698831911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEs1NuwWoCGXhEH9sycbJ/MxWbFaFkgdZg/zjur4gx8=;
        b=DW9b/l2xoR6TRp8hSpEJNeeCtWxXdUgxOVI1e19u9/VZDXfCLDJi5ldvjht1CPlUNmkcwx
        8ZUfONPIBNMoSFwA1E4O1drfM3Z6tFFpwMihkdx4piA7pxWpVndqHse2K8vTzwJMACCJ4u
        phJmKTSTQfKGbJ0FWwTE/GYXMnj9anY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-NX046jhoOF-0RDmL32s84g-1; Wed, 01 Nov 2023 05:45:06 -0400
X-MC-Unique: NX046jhoOF-0RDmL32s84g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B834E85A58A;
        Wed,  1 Nov 2023 09:45:05 +0000 (UTC)
Received: from localhost (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2851C060BA;
        Wed,  1 Nov 2023 09:45:05 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
In-Reply-To: <2c0b5552-84b8-fe63-6d4c-0a42c7b8a753@linux.microsoft.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
 <20230927190021.1164278-2-jwcart2@gmail.com>
 <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
 <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
 <2c0b5552-84b8-fe63-6d4c-0a42c7b8a753@linux.microsoft.com>
Date:   Wed, 01 Nov 2023 10:45:04 +0100
Message-ID: <87a5rxhknz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Daniel Burgener <dburgener@linux.microsoft.com> writes:

> On 9/27/2023 4:41 PM, James Carter wrote:
>> On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Daniel Burgener
>> <dburgener@linux.microsoft.com> wrote:
>>>
>>>> @@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(struc=
t cil_tree_node *node)
>>>>        return rc;
>>>>    }
>>>>
>>>> -static int __cil_resolve_ast_node(struct cil_tree_node *node, void *e=
xtra_args)
>>>> +static int __cil_resolve_ast_node(struct cil_tree_node *node, struct =
cil_args_resolve *args)
>>>>    {
>>>>        int rc =3D SEPOL_OK;
>>>> -     struct cil_args_resolve *args =3D extra_args;
>>>> +     struct cil_db *db =3D args->db;
>>>>        enum cil_pass pass =3D 0;
>>>>
>>>> -     if (node =3D=3D NULL || args =3D=3D NULL) {
>>>> -             goto exit;
>>>> -     }
>>>> -
>>>
>>> Is deleting the "node =3D=3D NULL" part of this check intended here?  It
>>> seems unrelated to the rest of the commit, and it's not locally obvious
>>> that it's safe.
>>=20
>> You are right. It is not related to the rest of the commit. There are
>> a bunch of these sorts of checks that are useless and really annoy me.
>> The function __cil_resolve_ast_node() is called once from
>> __cil_resolve_ast_node_helper() and neither node nor args can be NULL.
>> Since I was changing something nearby, I guess I couldn't resist. I
>> can leave it in, if people prefer. It doesn't cause any harm, other
>> than annoying me.
>>=20
>
> As is is fine by me.  Your explanation makes sense.  I mostly wanted to=20
> make sure it was reasoned out rather than an accidental drop, but now=20
> that you point it out, it does look impossible for this to be NULL.
>
> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


Petr

