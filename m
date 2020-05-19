Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5E1C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415C7207C4
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhBHpP5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESJcn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgESJcn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 05:32:43 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C2C061A0C
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 02:32:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so3276497lfe.11
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbOGUKPtCpbmkQeBBho+cAXOMLB2mQxNIjD6bahlbQ4=;
        b=BhBHpP5opHY8U4m5E6AN07Fxm0LwbV6jFCM7IJTxFS+NsNWX7qIr64M4o+BJeOuH5/
         hbcV9pp32WyNAbaU/yb0bp+7XPCiyQsYXBW0cgR7lVcPt/G7uoMKEs9bBigWRQi0LoL0
         GXBF2K2vFIhwSjIdanMxktxjwr12jyip4lozHxTOimlhy+AB4efHVpi+TVE/qz0+79Yk
         Vt/xuCM914HO9CF5xbCdDwT/n5idK0g/LARgQaVLIC/Sl7vZWGH5VVPTP+R/YQifJ2eL
         nVq+ofmHFy6S7lD5kfooEPHcTHReMb5mFIHQSe9phQTKmRudVVSJ5roFl1EE+UoauFnx
         h/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbOGUKPtCpbmkQeBBho+cAXOMLB2mQxNIjD6bahlbQ4=;
        b=tWZsy0uZAPNh4GOddtRcGQLVn/gJYZM8yF9yGfBZO2815DRAwchsov4POKNZGWfALC
         7fKXW5sTjKZlt6hA4CyIYyvcXgouAk1qBD/ewreV5EmNi3S/ll6K8s7bQkVilJ0rn6Tp
         4efsMQJv45P3oEjzR6szkSfVauzWNDwYbCOkYu4uLa9PqEl9QelwhpYF28+zpeV6+SrH
         nlFA1p4cKqJABbH3WHt9sY1+sQLYFP7keSCoXtcFfD+P2p0+dKDKBnaxVtd+uEuSRc9L
         wB87aeoBNldber+eoTZCm1VW5NB0ouroLRXgXy291+a0miiqqA0tp7HtNM8yww4/NP19
         JEHg==
X-Gm-Message-State: AOAM533vB0IcVdsku10fk1T5GMBPdP4YoTfg0Db+HgrUvfxb0+8TITni
        JAKJy9S06Q9U+kbX9FdM/MxIanzE
X-Google-Smtp-Source: ABdhPJxJXCjZTTZ5Fw2nx4Ll+OCYXxBhEDrdDqLhJ/4qkJfqZXhBDv9u1/ad82QiXoXuslBBcJ+yZg==
X-Received: by 2002:a19:c714:: with SMTP id x20mr6770638lff.100.1589880760901;
        Tue, 19 May 2020 02:32:40 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id w144sm7272914lff.67.2020.05.19.02.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 02:32:40 -0700 (PDT)
Subject: Re: Semodule accepts bad modules every other time
To:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <85b4f600-a7f0-f017-0f54-74fe7de73bcc@gmail.com>
 <CAEjxPJ47hbNA6P0kke-6K3_RtG-TgTin+FF52Dm-KGc-knJOjA@mail.gmail.com>
 <CAP+JOzRr56cAH01Wr5xwcj7aT8C=ggT_4KiA2UKofxFPHpc34g@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <a3f916b8-a513-ac56-45f3-610f451b365c@gmail.com>
Date:   Tue, 19 May 2020 12:32:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP+JOzRr56cAH01Wr5xwcj7aT8C=ggT_4KiA2UKofxFPHpc34g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 18.5.2020 17.41, James Carter wrote:
> On Mon, May 18, 2020 at 9:56 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Mon, May 18, 2020 at 5:43 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> I have a module, which can be compiled without problems but it can still
>>> generate errors during load. However, every other time the load succeeds.
>>>
>>> Here's the example:
>>> # cat foo.te
>>> module foo 1.0;
>>>
>>> type file_type;
>>>
>>> require {
>>>           type user_t; # dummy require statement to keep checkmodule happy
>>> }
>>> # make
>>> Compiling default foo module
>>> Creating default foo.pp policy package
>>> rm tmp/foo.mod.fc tmp/foo.mod
>>> # make QUIET=n load
>>> Loading default modules: foo
>>> /usr/sbin/semodule -i foo.pp
>>> Re-declaration of type file_type
>>> Failed to create node
>>> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
>>> /usr/sbin/semodule:  Failed!
>>> make: *** [/usr/share/selinux/devel/include/Makefile:148: tmp/loaded]
>>> Error 1
>>> # make QUIET=n load
>>> Loading default modules: foo
>>> /usr/sbin/semodule -i foo.pp
>>> (no error)
>>>
>>> Running semodule directly:
>>> # semodule -i foo.pp
>>> Re-declaration of type file_type
>>> Failed to create node
>>> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
>>> semodule:  Failed!
>>> # semodule -i foo.pp
>>> # semodule -i foo.pp
>>> Re-declaration of type file_type
>>> Failed to create node
>>> Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
>>> semodule:  Failed!
>>> # semodule -i foo.pp
>>>
>>> Maybe the failing transaction is not reverted properly and then the
>>> failed module changes the system somehow? Some problem with detecting
>>> redeclarations?
>>
>> Looks like a bug in libsepol to me:
>> # valgrind semodule -i foo.pp
>> ==5989== Memcheck, a memory error detector
>> ==5989== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
>> ==5989== Using Valgrind-3.16.0.GIT and LibVEX; rerun with -h for copyright info
>> ==5989== Command: semodule -i foo.pp
>> ==5989==
>> ==5989== Conditional jump or move depends on uninitialised value(s)
>> ==5989==    at 0x48E02F5: cil_gen_node (cil_build_ast.c:129)
>> ==5989==    by 0x48E3FD3: cil_gen_type (cil_build_ast.c:2315)
>> ==5989==    by 0x48EBDC0: __cil_build_ast_node_helper (cil_build_ast.c:6261)
>> ==5989==    by 0x490AF1D: cil_tree_walk_core (cil_tree.c:272)
>> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
>> ==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
>> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
>> ==5989==    by 0x490AF8F: cil_tree_walk_core (cil_tree.c:284)
>> ==5989==    by 0x490B06C: cil_tree_walk (cil_tree.c:316)
>> ==5989==    by 0x48ED269: cil_build_ast (cil_build_ast.c:6571)
>> ==5989==    by 0x48D019F: cil_compile@@LIBSEPOL_1.1 (cil.c:564)
>> ==5989==    by 0x498A646: semanage_direct_commit (direct_api.c:1419)
>> ==5989==
>> Re-declaration of type file_type
>> Failed to create node
>> Bad type declaration at /var/lib/selinux/targeted/tmp/modules/400/foo/cil:1
>> semodule:  Failed!
>>
>> Without valgrind, I get a segfault.  This is with make DEBUG=1.
> 
> I didn't try valgrind with semodule -i (it only segfaults for me when
> running under valgrind), but I did notice a segault every other time I
> did semodule -vB (with or without valgrind).
> 
> Since file_type is declared as an attribute, there definitely should
> be an error when you try to declare it as a type.

Replacing 'type' with 'attribute':
module foo 1.0;

#type file_type;
attribute file_type;

require {
         type user_t; # dummy require statement to keep checkmodule happy
}

Compiling default foo module
Creating default foo.pp policy package
rm tmp/foo.mod.fc tmp/foo.mod
# make load
Loading default modules: foo
Re-declaration of typeattribute file_type
Failed to create node
Bad typeattribute declaration at 
/var/lib/selinux/default/tmp/modules/400/foo/cil:1
/usr/sbin/semodule:  Failed!
make: *** [/usr/share/selinux/devel/include/Makefile:148: tmp/loaded] 
Error 1
# semodule -i foo.pp
# semodule -i foo.pp
Re-declaration of typeattribute file_type
Failed to create node
Bad typeattribute declaration at 
/var/lib/selinux/default/tmp/modules/400/foo/cil:1
semodule:  Failed!

-Topi
