Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E0C43334
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiF2Nwi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiF2Nwg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 09:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACFB4192B2
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656510754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPPKULBITEHPM/2tHOc4zO504NY3ahZrQ6nHe93Gvds=;
        b=XDi/MA0zJgwxEB4TFx20OZFijMeYvoJtmWRFzjUwhw2Wors66Y2aMxmW8oKoDu6sq4MEIy
        MKRN+9vfxwJlT3QYLLJ585JPAJ594QlO0VZVS2wp1RaAbIieWipDildTHuyxdjy3Ql54CQ
        1u+yj5mwwJyWi76Eh2pEqK74cR34/40=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-mNV9j8TZNCGjVuQ-4fsu5Q-1; Wed, 29 Jun 2022 09:52:33 -0400
X-MC-Unique: mNV9j8TZNCGjVuQ-4fsu5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22AB83804532;
        Wed, 29 Jun 2022 13:52:33 +0000 (UTC)
Received: from localhost (unknown [10.40.193.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE41B1121314;
        Wed, 29 Jun 2022 13:52:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] gettext: handle unsupported languages properly
In-Reply-To: <871qvasere.fsf@redhat.com>
References: <20220624142425.3836193-1-vmojzis@redhat.com>
 <bea122a5-5a68-2c81-25c1-ec9d3a3aa7e5@linux.microsoft.com>
 <a85f9664-aa08-fcc9-aa69-f944479eb0fd@redhat.com>
 <7563a56c-5527-abaf-f33b-ab9d9f1487dc@linux.microsoft.com>
 <871qvasere.fsf@redhat.com>
Date:   Wed, 29 Jun 2022 15:52:31 +0200
Message-ID: <87tu83r2zk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>
>> On 6/24/2022 1:27 PM, Vit Mojzis wrote:
>>>=20
>>>=20
>>> On 6/24/22 18:37, Daniel Burgener wrote:
>>>> On 6/24/2022 10:24 AM, Vit Mojzis wrote:
>>>>> With "fallback=3DTrue" gettext.translation behaves the same as
>>>>> gettext.install and uses NullTranslations in case the
>>>>> translation file for given language was not found (as opposed to
>>>>> throwing an exception).
>>>>>
>>>>> Fixes:
>>>>> =C2=A0=C2=A0 # LANG is set to any "unsupported" language, e.g. en_US.=
UTF-8
>>>>> =C2=A0=C2=A0 $ chcat --help
>>>>> =C2=A0=C2=A0 Traceback (most recent call last):
>>>>> =C2=A0=C2=A0 File "/usr/bin/chcat", line 39, in <module>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 t =3D gettext.translation(PROGNAME,
>>>>> =C2=A0=C2=A0 File "/usr/lib64/python3.9/gettext.py", line 592, in tra=
nslation
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 raise FileNotFoundError(ENOENT,
>>>>> =C2=A0=C2=A0 FileNotFoundError: [Errno 2] No translation file found f=
or domain:=20
>>>>> 'selinux-python'
>>>>>
>>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>>>> ---
[...]
>>>>
>>>> Isn't the point of the overall change that gettext.translation()=20
>>>> doesn't throw an exception anymore?=C2=A0 So we don't need to handle=20
>>>> OSError/IOError here once fallback=3DTrue.=C2=A0 I see that this stand=
ardizes=20
>>>> with the other call sites, but I wonder if standardizing on the more=20
>>>> specific exceptions (or just leaving as is) wouldn't be better?
>>>=20
>>> Yes, we do not need to handle OSError/IOError exceptions any more.
>>> I agree that standardizing on the more specific exception handling woul=
d=20
>>> be more proper. However, translation handling is probably the least=20
>>> important feature of this tool (most people probably use it in English=
=20
>>> and those who don't wish they did) -- we don't want people to be unable=
=20
>>> to use the tool at all because of some translation issue and "catch all=
"=20
>>> exception handling is the easiest way to avoid that.
>>> As this bug showed, not settling on a single approach is probably the=20
>>> worst alternative (I tested the previous patch with multiple tools, but=
=20
>>> apparently missed the one that was different).
>>>=20
>>> That being said, either approach is fine by me. Please let me know if I=
=20
>>> should change the patch.
>>> Vit
>>
>> Well, I'll leave questions of what you *should* do up to the=20
>> maintainers, but I think as far as I'm concerned your point that we=20
>> really don't want to fail hard on translations makes a lot of sense (and=
=20
>> I definitely agree that inconsistency is a pretty bad alternative.  So=20
>> I'm on board with this approach.  I was initially worried about "what if=
=20
>> in some future version gettext adds an exception?", but to your point,=20
>> we want the same fallback logic in that case, so the general except=20
>> seems reasonable.
>>
>> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
>>
>
> Thanks!
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
>


Merged.

