Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91607C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6348322B42
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UAR6LGd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgHDVFr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgHDVFq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 17:05:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76DDC06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 14:05:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so2986733wmc.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NGX4boI8Alzr2RE9m1T9HFIPfFP2ix045kKZ5ULasmw=;
        b=UAR6LGd2ra9JDOzoMn1rbxl170n7KYKaBTCZp9wihC5Y6VC136TouaRkYa5ncT9Eq2
         CcmWIcK4MsjZcsPcb2ZZqHoPV0UM8en0JqgcQ/VP+rdEIROX2DBxR0xBztMxFv5T+6Bn
         qu+qpN66V4iQ8Etaj4rNueZzZy4Omz9g//cYxQ6Ynp24ANcMB7k0GjnIhzxBdyyDxWlP
         Sn85yelg1j+07xBXZPTuILn4IouPPCsizmASRrbUnPgKcKw3Fq6AWgrfN1ikPbt9QdNK
         ikgF8Np1WW3v7dKW08SMVmkNvijqIGkAReaZWIrkXdJpcPD0A4U87TAl2lqfjqDCSaQf
         CLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NGX4boI8Alzr2RE9m1T9HFIPfFP2ix045kKZ5ULasmw=;
        b=D7df9K4zqF6ecibuo5iKo+iPm3nqxzzEkI+JZet6TyNEnUjJ03VQaOM92fZ04ie16G
         nTOUp1r9XHt/W5eNkkCDAa8INaqBPjjZnhknlUwpQVD7fqMW9+KtQI+bgAUEsS1gpk7s
         JVugcqSB7TKfaK6xwnfij26dUoDabR6JL7atJf0yRriXzeEV5c0o2TexvbWn4cP5sisp
         wFmc197SFXYZEowM35R86yKhPFtUbnEJOuV/eozWaEbVdMxQdaZvMLpgIhmhogrV8hTj
         yUhZcJuVGJ8UbBOJWVSXSrqpJQf/raEd0ZtIZjVJC2yh5dKQz+NkH3Y20lxU9bSp0BGz
         lhJA==
X-Gm-Message-State: AOAM532ZotwY9HU95OJ6iYWv2zrTiuckdEb8mjdjq+cinxH1kNmobF37
        IYRfeyv+lEdoWLSrV049qWFHI7wQ
X-Google-Smtp-Source: ABdhPJwheLeRsTf2cHSYj06NV1rhtQmRTqe1LwRJpRFd1o7qr048mw7IVLEp98G1AKBANo8Kup6DXA==
X-Received: by 2002:a05:600c:514:: with SMTP id i20mr290324wmc.102.1596575143872;
        Tue, 04 Aug 2020 14:05:43 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:8252:51b6:80cd:c2fd? ([2a02:810d:4bc0:8098:8252:51b6:80cd:c2fd])
        by smtp.gmail.com with ESMTPSA id g188sm79148wma.5.2020.08.04.14.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:05:42 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
References: <309a97d9-194b-a449-337c-bcbade76317d@gmail.com>
 <CAGB+Vh4ezWPAU1PY1jMuMxU34kVqhphgUNfN+Yn7sn3XEhTAug@mail.gmail.com>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Subject: Re: Label files under HOME_DIR with a range by default
Message-ID: <58076b92-5912-ea2f-f7c7-32717da324cc@gmail.com>
Date:   Tue, 4 Aug 2020 23:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGB+Vh4ezWPAU1PY1jMuMxU34kVqhphgUNfN+Yn7sn3XEhTAug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thank you for your input,

In my original email I wanted to explain my model a bit more but ultimately did not, since it would distract from the issue.

On 8/4/20 6:56 PM, Joshua Brindle wrote:
> On Sun, Aug 2, 2020 at 5:20 AM bauen1 <j2468h@googlemail.com> wrote:
>>
>> Hello,
>>
>> The user level is currently used as the range for files under HOME_DIR.
>> It appears that the Bell-LaPadula model makes the assumption that all objects are single leveled, this assumption is also made in libsepol. (I haven't really found a good source for this assumption)
>>
> 
> libsepol does not make any assumptions about policy. Everything is
> defined in the policy mls or mcs files in terms of constraints.

In my opinion libsepol should not make any assumptions about the policy, and usually it doesn't.
However currently the "user level" is used as the range component for file labels containing HOME_DIR (and similiar).
libsepol and the binary policy limits the "user level" to a level instead of a range, this makes it very hard to use ranges for home files by default.
I would like to change this, but I'm not really sure how backwards compatibility should be handled and if there would be a better term for "user level" that doesn't contain "level".

>> But in my own (MCS) policy objects are not single leveled.
> 
> Files are, by definition, single level objects because they cannot be
> decomposed. A file with U - TS data in it is a TS file.

My policy doesn't really follow the standard MLS / MCS model.
So far I have found using "confidentiality" for the low and "integrity" for the high level to be the most fitting.
For example a semi-secret file (low = s0:c1) was created by a subject with more access (high = s0:c1,c2).
The integrity level of a file can then be used to check if the subject that created it stands to gain something.
E.g. an admin with access to just category 1 edits a file that is read (and executed) by a daemon with access to category 1-3.

> The policy (not libsepol) handles enforcing single-level objects, for
> example in refpolicy:
> 
> # make sure these file classes are "single level"
> mlsconstrain { file lnk_file fifo_file } { create relabelto }
>         ( l2 eq h2 );
> 
> You cannot create or relabel a file with anything other than low = high.
> 
> Directories can be ranged, if they contain files of multiple levels,
> again, from refpolicy:
> # Directory "write" ops
> mlsconstrain dir { add_name remove_name reparent rmdir }
>         (( l1 eq l2 ) or
>          (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1
> domby h2 )) or
>          (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
>          ( t1 == mlsfilewrite ) or
>          ( t2 == mlstrustedobject ));
> 
> So the source low must equal the directory low or one of the mls
> exception attributes controls fine grained usage.

Thanks for pointing this out, I will need to look into this a bit more.

>> Read (and process communication) operations are allowed if a processes high level dominates an objects low level.
>> Write operations are allowed if a processes high level dominates an objects high level.
>>
>> Later I've found that someone else had also come up with this idea independently, see https://lore.kernel.org/selinux/20091103114530.GH1672@myhost.felk.cvut.cz/ and https://lore.kernel.org/selinux/20091125202727.GD1649@myhost.felk.cvut.cz/ .
>>
>> For this I want to label files under HOME_DIR with the range user_lowest-user_highest.
>> Ignoring process communication this would prevent a login with less than maximum clearance from escalating by writing to e.g. ~/.bashrc .
>>
>> For example a user with the range s0-s0:c0.c3 would have his home files labeled as s0-s0:c0.c3.
>> A local tty login with the maximum clearance s0-s0:c0.c3 would be able to edit ~/.bashrc .
>> But an ssh login from e.g. an insecure network with only the range s0-s0:c1 would be able to read but not write important files such as ~/.bashrc .
>>
>> Using user_highest-user_highest as user level would force the user to correct the context of potentially a lot of files required by whatever is run with less than user_highest high, so I want to avoid this.
>>
>> Would it make sense to change libsepol to accept a range as user level (and perhaps changing the name) ?
> 
> libsepol isn't really doing anything here. You can use semanage to set
> a file context, something like:

See above, libsepol is responsible for the limitation of the user level to a level, everything else doesn't have this limitation.

> # semanage fcontext -r s0-s0:c0.c3 /home/username
> # restorecon -R /home/username

Yes, but this doesn't really scale too well.

> But you do need to be careful of escalation as you've noted, you may
> need a number of these to set specific files to the user high level
-- 
bauen1
https://dn42.bauen1.xyz/
