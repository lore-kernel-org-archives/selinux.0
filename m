Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6165CC433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1769961151
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhD1QIL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhD1QIL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 12:08:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0CCC061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 09:07:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso7724165ott.1
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/qufn+EIhoepSV3JsQcxMoC1hV/hpT7mV/NpPeoUMMY=;
        b=TLmbtYvWl47b5Atx1Muk4aLnzwCXswBa0m1w3iF4sKLbzG5m7pdYTuE59uVjyGez6T
         hmjFNIgAWjaRDeJHjGP3tFv6hqGXRRFnr0sP7ZAZI7kfQfr9L8g8UqMvgvkpCboZV7Ly
         syj32AXuoRadVbYkLSxcehHsZtoAnKWOcmMc9k65rZIDIAgTx1Tl22QYpvAKdAdZgFkW
         axBU1Jh4aTpgPtNDA1UX+KTJ3M8RjLyu3nPcySqWGmGjcPd71WnHINBpqhGDmigatcM7
         LE5cF0lup5ulmjv329FKBtsQZj80+7GzUu8iDL43M3xCTvqCSrOhC80MDeVJpWSA7Wqj
         mMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/qufn+EIhoepSV3JsQcxMoC1hV/hpT7mV/NpPeoUMMY=;
        b=ixputTfP/s5AVkgenPgJJwPiSiqCAIomQK5PJry74yWb5CQjnIsQU4typNDz4JUKeI
         QCnUSTmmf4GVO7Z1rmsqzOKvZlXjJK8oO5X16hh6m3zGmJDbVw6Y55+M+RZ8xHDe5P34
         9UaaY1msivGxP+B6A1+fHlX3EZKlEfFB3z0rFJyEbqwUFIWqHkd80HEYJR7KfU8ZRBer
         +duIAERv+akkJDKXkvb9x6URrnIAaFoHgTsQyaEgYwJfviKdNpAayhzO09/P4liTYy/9
         /NLNeAjiBCxJ9AF2XiPqv4xTGUpnZOqzTKpgALFW4R3Z7SAd6aaPtSTO0jUnxT2wCldV
         d/+w==
X-Gm-Message-State: AOAM530B83z55a06lWwiAEBAHTMc4CJzpMeyO7vW1+KwQRkNXs+wpluF
        NY//q014WPH81MIhoM7RLkQXHeUG5gPPGK+tCM8bXgzaTLQ=
X-Google-Smtp-Source: ABdhPJwK7UksoroBbLKc21jAbpuqko7l2oAgc4B0Zrae17NJv2xx9h5srIU30765ipahjszpjPhAsFxndgCFjw1njVk=
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr17014860otc.196.1619626044205;
 Wed, 28 Apr 2021 09:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <86d254dd-fd82-e25c-915b-16615b341457@phd.unipi.it>
In-Reply-To: <86d254dd-fd82-e25c-915b-16615b341457@phd.unipi.it>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 28 Apr 2021 12:07:13 -0400
Message-ID: <CAP+JOzRsukCmP3v_W8SQ27Q17fMMUPemOX3wzo87PRciiYNJpA@mail.gmail.com>
Subject: Re: [bug report?] other unexpected behaviours in secilc and CIL semantics
To:     lorenzo ceragioli <lorenzo.ceragioli@phd.unipi.it>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 8:42 AM lorenzo ceragioli
<lorenzo.ceragioli@phd.unipi.it> wrote:
>
> Hello,
>
>
> I am still performing tests to fully understand the semantics of CIL,
> here are three strange behaviours I have noticed, I would really
> appreciate it if you can say if I am wrong and, in case I am not, if
> they are coherent with the intended meaning of CIL constructs.
>
> Please note again that I am currently using the version available on
> Ubuntu 18.04.5 LTS via packet manager.
>
>
> ########################## Report ##########################
>
>
> 1)
>
>
> Names defined inside the body of a macro are not checked before names
> defined in the namespace in which the macro is defined. For example, in
> the following
>
> (block A
>
> (type a)
>
> (macro m ()
>
> (type a)
>
> (allow a a (file (read)))))
>
>
> (block B
>
> (call A.m))
>
>
> I would expect "a" to be resolved as the type "a" in the body of the
> macro, hence to "B.a" as the allow statement and type definition are
> copied into block "B". Instead it is resolved as "A.a" (I get =E2=80=9Cal=
low A.a
> A.a=E2=80=9D).
>
> Basically, it behaves like
>
>
> (block A
>
> (type a)
>
> (macro m ()
>
> (allow a a (file (read)))))
>
> (block B
>
> (call A.m))
>
> and not like
>
> (block A(macro m ()(type a)
>
> (allow a a (file (read)))))
>
> (block B
>
> (call A.m))
>
> as I expected.
>
> I know that the documentation saying:
>
> =E2=80=9CNote that when resolving macros the callers namespace is not che=
cked,
> only the following places: - Items defined inside the macro
>
>      -Items passed into the macro as arguments- Items defined in the
> same namespace of the macro- Items defined in the global namespace=E2=80=
=9D
>
> is outdated, and that it has been proposed to change it with:
>
> "When resolving macros the following places are checked in this order:
>
>      - Items defined inside the macro
>
> - Items passed into the macro as arguments
>
> - Items defined in the same namespace of the macro
>
> - Items defined in the callers namespace
>
> - Items defined in the global namespace"
>
>
> But the observed behaviour is not coherent with none of these description=
s.
>
> Maybe this could work:
>
> "When resolving macros the following places are checked in this order:
>
> - Items passed into the macro as arguments
>
> - Items defined in the same namespace of the macro
>
> - Items defined inside the macro - Items defined in the callers namespace
>
> - Items defined in the global namespace"
>

You are correct, the observed behavior is not consistent with the
documentation. I might have an idea on how to make it work as
documented, but, otherwise, the documentation should be changed to
reflect what actually happens.

> But I think it is not an intuitive way of resolving names.
>

I will admit that it is somewhat arbitrary. I think that what was in
mind was policy like:
(block service1
  (type t)
  (macro run ((type x))
    (allow t x (CLASS1 (PERM1)))
  )
)
(block service2
  (type t)
  (allow t self (CLASS2 (PERM2)))
  (call service1.run(t))
)
With the resulting policy being:
(allow service2.t self (CLASS2 (PERM2)))
(allow service1.t service2.t (CLASS1 (PERM1)))

>
> 2)
>
> Usually, names inside a macro are resolved using the definitions in the
> namespace in which the macro is defined before the ones in the caller
> namespace.
>
> I noticed that, in the following
>
>
> (type a)
>
>
> (macro m ()
>
> (allow a a (file (read))))
>
>
> (block A
>
> (type a)
>
> (call m))
>
>
> the name "a" is resolved in "A", not as ".a" in the global namespace,
> which is the namespace where "m" is defined.
>
> Hence I assumed that the rule does not apply to macros defined in the
> global namespace, can you confirm?
>

That is as intended. I could make arguments for doing it different,
but that is how it is.
You can make sure the allow rule in the macro refers to the global a
by using (allow .a .a (file (read))).

>
> 3)
>
> I noticed that the types declared in a macro, being copied into the
> caller namespace, can be used as parameters for the macro itself.
>
> For example, in the following
>
>
> (type a)
>
>
> (block A
>
> (macro m ((type x))
>
>    (type a)
>
> (allow x x (file (read))))
>
> )
>
>
> (block B
>
> (call A.m(a))
>
> )
>
>
> the resulting allow rule is (allow B.a B.a (file(read))), which in my
> opinion is unexpected.
>

That is weird. I would have expected the global a. I will have to take
a look at this.

Thanks for your questions!
Jim

>
> #############################################################
>
>
> Thank you for your time.
>
>
> Cheers,
>
> Lorenzo Ceragioli
