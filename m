Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D7C433E1
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFCA20717
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 14:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bds+fgX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgGUOsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:48:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbgGUOst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595342927;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/IZPHxBeOhKgGRERGViYELhQemr3Tb2+NED/sFHzzGU=;
        b=Bds+fgX1uSrXnRRRT4gZIzXx1C+UE/1dBeE/QNyg7ky7aIu9fZGqSJgffp2obZpvlob8td
        xwQRxn+38R2wwdhvMoSPN0gpXTLQEt4Glbu+VW3uqez2TUOPOz3OgRcsR+Zrkq6BFgcMxl
        JHqdVc2NN8jUbbPF5G0VjYLUWuIRakI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-Ln_yanVNN3GtpyeCWUA3sA-1; Tue, 21 Jul 2020 10:48:42 -0400
X-MC-Unique: Ln_yanVNN3GtpyeCWUA3sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC0F58;
        Tue, 21 Jul 2020 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-113-79.phx2.redhat.com [10.3.113.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9A861983;
        Tue, 21 Jul 2020 14:48:37 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC] Porting glibc away from deprecated libselinux APIs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Arjun Shankar <arjun.is@lostca.se>,
        SElinux list <selinux@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Carlos O'Donell <carlos@redhat.com>,
        Ulrich Drepper <drepper@redhat.com>
References: <20200721115734.GA43979@aloka.lostca.se>
 <CAEjxPJ5wZ6HE0hA7+RAPfJkzL_W3LTLop9gNb8GxkHxMkLEAcA@mail.gmail.com>
 <87365lqarb.fsf@oldenburg2.str.redhat.com>
 <CAEjxPJ4UTfRA7jigEE3+LWfXBqa3OSiOe11o+rH2KyafRvnfaQ@mail.gmail.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <39f23208-c9df-c16d-6513-49b3fd234fc7@redhat.com>
Date:   Tue, 21 Jul 2020 10:48:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4UTfRA7jigEE3+LWfXBqa3OSiOe11o+rH2KyafRvnfaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/21/20 09:13, Stephen Smalley wrote:
> On Tue, Jul 21, 2020 at 9:05 AM Florian Weimer <fweimer@redhat.com> wrote:
>> * Stephen Smalley:
>>
>>> On Tue, Jul 21, 2020 at 8:07 AM Arjun Shankar <arjun.is@lostca.se> wrote:
>>>> Hi,
>>>>
>>>> glibc currently uses several recently deprecated libselinux APIs:
>>>>
>>>> 1. makedb uses matchpathcon:
>>>>
>>>> https://sourceware.org/git/?p=glibc.git;a=blob;f=nss/makedb.c;h=8e389a1683747cf1047f4de8fe603f2b5ccc5f3f;hb=HEAD
>>> Should migrate to selabel_open/lookup/close.
>>>
>>>> 2. nscd uses avc_init and multiple old style callbacks:
>>>>
>>>> https://sourceware.org/git/?p=glibc.git;a=blob;f=nscd/selinux.c;h=a4ea8008e201b9397aa4274bb558de471b0573af;hb=HEAD
>>> Wondering if nscd can migrate to using the higher level
>>> selinux_check_access() interface instead of direct usage of the
>>> avc_*() interfaces.
>> Somewhat related:
>>
>> I do not know the reason *why* we have SELinux-specific code in glibc,
>> and in this places in particular.  What makes nscd and makedb special?
>> ldconfig also writes a file used across trust boundaries
>> (/etc/ld.so.cache), and yet we don't label it explicitly.
>>
>> (nscd is a daemon that runs under its own user and loads NSS service
>> modules.  makedb is similar to ldconfig.)
>>
>> Do you have an idea why we need this code in glibc in the first place?
>> Could it be that it is simply there to work around an incomplete system
>> policy?
> It could be that at the time we didn't have restorecond or support for
> name-based type transitions and therefore they needed the makedb
> changes to keep its file in the proper security context.  WRT nscd,
> using SELinux to provide the policy decisions is both more flexible
> and more robust than a DAC-based scheme, and allows central management
> of the overall system policy.  Dan Walsh and/or prior glibc
> maintainers might recall more of the specifics.
>
Going way back, this was added I recall by Uli Drepper, for speed of
some httpd transactions?


