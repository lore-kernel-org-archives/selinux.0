Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68305C388F7
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED61A2076E
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujsVw0lK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJRcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRcC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Nov 2020 12:32:02 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F392C0613CF
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2020 09:32:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i18so13335479ots.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2020 09:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=be46LWw5WPekaLY1XGuXLUK7QEy4y9SLmzKSn3n99Sg=;
        b=ujsVw0lKtXx/Q2l7piCuE9TBFDQFHJer3XYOXen5dbmhE5qz1Q3x8FBmKN+DiPqdMK
         nf6iTA3zOkif+Ia7Jh3nitI5rl5qHLgFh17K3ba09G/q+0y7TN0TVFHkGdFieeGpqWxC
         qzJVnAkUzrCDL9V5YgdaKN3LPAPu2bHSKNxFMF5bYzkbsnCnRsClCrkv+8Zjdnq2Lmtv
         eZ9jl4VlFttbwuDyaP9bD31JqswSs3+tqR6V8ghHTVpvXjoa1rvTo9tng7I+RvGVJfyz
         H0X/SwB3YURvyUYxRakFBgc2t3RCqHNctPSNxgCuNJRPSgJe7JU4NiL1vm9R/n72ZKOa
         UIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=be46LWw5WPekaLY1XGuXLUK7QEy4y9SLmzKSn3n99Sg=;
        b=RVSYwtXD/Wp7nenBKB2YDwDwa18LyH8yZMHwphwS9C7r/x84XQX/eKRhTMZmTQOJBZ
         qu+pqYyrrHfKwaV6XviYD5fwrScmxKMPIF7bpVKhlvDDXlCA+iIgiXWOX8E8jZ09WKma
         ggjMDqo73XCwoFIM+nSvx8PClh8ciyRpXvyCd1Q5s2Mo4k9qdWVt4Ipz5iesmC+7LY76
         /MP67mmM5V79WhMsJb8vtPNKPgYkViIkzS1RCXZv/AQHjt6NuH1ctceW/wSaH9YjUa65
         N5nK/imKAo4M13xKKMtIEW7043SUD5m+PRHMyH6j1XWFctM0ZpDDQi6TAApA5RfcXfWo
         NBpg==
X-Gm-Message-State: AOAM533AH/nHSogHLCFMy3AbZRitWpnkfsqfvgc6JMc/iplQc0sTu6fE
        +1/RbrvlZ78kLBEGlEH1Ae+qpKQi7s/Q4q7ab6GDzVGN
X-Google-Smtp-Source: ABdhPJwsTBm6gZLE7r0lms5JXrLFpgBpFS32OekZY890/5ZvO/OiOzGd/rp+ob9J6uTQUwBF9l64rcN209XOSzgKK6E=
X-Received: by 2002:a05:6830:d7:: with SMTP id x23mr4821876oto.59.1605029520836;
 Tue, 10 Nov 2020 09:32:00 -0800 (PST)
MIME-Version: 1.0
References: <5ca2e18c-6395-a0af-fdee-b0ac5f1de714@phd.unipi.it>
In-Reply-To: <5ca2e18c-6395-a0af-fdee-b0ac5f1de714@phd.unipi.it>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Nov 2020 12:31:49 -0500
Message-ID: <CAP+JOzRH5YBAS-SuyN71-10T5=5G+aLY8K980bVwnwKPvJwcQg@mail.gmail.com>
Subject: Re: Bug (?) report for secilc and CIL semantics: some unexpected behaviours
To:     Lorenzo Ceragioli <lorenzo.ceragioli@phd.unipi.it>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 9, 2020 at 5:00 PM Lorenzo Ceragioli
<lorenzo.ceragioli@phd.unipi.it> wrote:
>
> To Whom it may concern,
>
> I am performing some tests to fully understand the semantics of CIL, and
> I have noticed some strange behaviours that may be erroneous.
> Please note that I am currently using the version available on Ubuntu
> 18.04.5 LTS via packet manager, hence some of the problems (if they are
> problems) may be already solved.
> Moreover, I am focusing on policies that only use types, and the
> procedure I have used for testing is simply to compile the .cil file
> with secilc and check which allow rules are found by "sesearch --allow".
>

You can also use checkpolicy to turn the binary back into a
policy.conf or CIL policy (although it won't be a valid CIL policy
because of "." in the names -- something I am hoping to correct in the
near future.)

> I decided to send this email instead of opening issues on github, please
> let me know if I was wrong.
>
> The strange behaviours that I have observed follows:
>
> ############ Report ############
>
> 1) The manual says "Note that when resolving macros the callers
> namespace is not checked, only the following places:
>
>      =E2=80=A2Items defined inside the macro
>      =E2=80=A2Items passed into the macro as arguments
>      =E2=80=A2Items defined in the same namespace of the macro
>      =E2=80=A2Items defined in the global namespace"
>
> like in the following
>
> (type a)
>
> (block B
>       (type a)
>       (macro m ()
>                  (allow a a perms)))
>
> (block A
>        (type a)
>        (call B.m))
>
> Where you get "allow B.a B.a perms" instead of "allow A.a A.a perms"
>
> BUT, according to my experiments this seems to work only if types are
> locally defined in the macro namespace, whereas the caller namespace is
> checked if they are defined in the global namespace or undefined. Two
> examples follows:
>
> Ex 1.1
>
> (block A
>       (macro m1 ()
>                 (allow a a perms))
> )
>
> (block B
>       (type a)
>       (call A.m1)
> )
>
> Ideally this should not compile (because type a is not defined in A
> namespace nor in the global namespace), instead we get allow B.a B.a
>
> Ex 1.2
>
> (type a)
>
> (macro m ()
>      (allow a a perms))
>
> (block A
>        (type a)
>        (call m))
>
> Ideally the "a" inside the macro should refer to the "a" type in the
> global namespace, and we should get "allow .a .a", instead we get "allow
> A.a A.a"
>
> Question:
>
> Is this the intended behaviour?
>
It is the intended behaviour. We have tried to make the behavior as
least surprising and as flexible as possible.

> For this point I see that there is already a report (in the mailing
> list) for asking to modify the manual, writing
>
> "When resolving macros the following places are checked in this order:
>      =E2=80=A2Items defined inside the macro
>      =E2=80=A2Items passed into the macro as arguments
>      =E2=80=A2Items defined in the same namespace of the macro
>      =E2=80=A2Items defined in the callers namespace
>      =E2=80=A2Items defined in the global namespace"
>
> As far as I can see, the CIL Reference Guide has not been updated. Have
> you decided to change the semantics of CIL (i.e. the behaviour of
> secilc) instead of the documentation?
>

It is not a change as much as the documentation is wrong and needs to
be fixed. Again, this ordering seemed to us as the least surprising.
Obviously, this was our opinion and good arguments can be made for
different behavior.

Really, this behavior does not come up very often. Unless blocks are
being used there is little reason to put a declaration in a macro,
since the type should only be declared once.


>
> 2) The CIL Wiki says, regarding inheritance of multiple macros with the
> same name "Inheritance causes all of the macros to be merged into a
> single macro with the union of the access". I think this is not the
> case, like in the following example:
>

The CIL Wiki is out of date and should not be considered as CIL
documentation at this point.

> Ex 2.1
>
> (type c)
>
> (block A
>          (type a)
>          (macro m1 ()
>                  (allow a c perms)))
>
> (block B
>          (type b)
>          (macro m1 ()
>                  (allow b c perms)))
>
> (block C
>          (blockinherit A)
>          (blockinherit B)
>          (call m1))
>
> In theory I should get both "allow C.a .c perms" and "C.b .c perms", but
> I only get the first one.
>

Merging macros was an idea during development, but it seemed to cause
more problems than it could solve.

What should happen is that either a warning or an error is given about
duplicate macro names. This is something that I plan on tackling soon.
It is also a problem for blocks and optionals.


> According to my tests I get the one that is declared first (it is also
> inherited first, but this does not seem to be relevant).
>
> Question:
>
> Is this a bug?
> If not (I see that CIL Wiki is not maintained since CIL is merged into
> SELinux repository), which is the criterion for choosing which macro to
> take (is it really "first defined wins")?
>

As I mentioned above, the CIL Wiki should not be used and I consider
the lack of at least a warning to be a bug.

>
>
> 3) Types resulting from a macro call may be used inside a macro
> definition, like in the following
>
> (type a)
>
> (block A
>       (macro m ()
>            (allow a a perms))
>
>       (call m1))
>
> (macro m1()
>       (type a))
>
> (block B
>       (call A.m))
>
> Here the "a" in macro "m" is resolved to the local type "a" that is
> introduced because of a call to macro "m1", hence you get "allow A.a A.a
> Perms" instead of "allow .a .a Perms", as it would have been if names in
> "m" were resolved before calling "m1".
>
> BUT, this lead to a strange behaviour when circular definitions are
> considered, as in the following example
>
> Ex 3.1
>
> (type a)
> (type b)
>
> (block A
>       (macro m ()
>           (type b)
>           (allow a a perms))
>
>       (call B.m1)
> )
>
> (block B
>       (macro m1()
>            (type a)
>            (allow b b perms))
>
>       (call A.m)
> )
>
> where you get "allow A.a A.a Perms" and "allow B.b B.b Perms" even if
> there is no evaluation order of the macros that transforms the code in
> such way (given that the names inside the macros are evaluated before
> copying the code, as stated in (1))
> Depending on the evaluation order, the result should be one of the
> following:
>

All macro calls are expanded before any name resolution occurs. By
expanded I mean all the rules from the macro are copied into a block
under the call.

The ordering of processing: tunableif, in, blockinherit, macro calls,
aliases, ordering statements, and then name resolution in rules.

> a) if you evaluate "m" before "m1"
>
>
> (type a)
> (type b)
>
> (block A
>       (type a)
>       (allow B.b B.b perms))
> )
> (block B
>      (type b)
>       (allow .a .a perms)
> )
>
> b) if you evaluate "m1" before "m"
>
> (type a)
> (type b)
>
> (block A
>       (type a)
>       (allow .b .b perms))
> )
> (block B
>      (type b)
>       (allow A.a A.a perms)
> )
>
> Question:
>
> I am not sure this is not exactly the behaviour you want, but in case I
> would like to have a confirmation.
>

This is the behavior that is intended. For a long time, macros in
SELinux were just m4 macros, so we did not want to completely get away
from macros acting just as text expansion.

> 4) I see that something like late binding is used for names in block
> inheritance, like in the following
>
> (type a)
>      (block A
>             (type b)
>         (allow a b perms))
>
>      (block B
>            (blockinherit A)
>        (type a))
>
> in which we get =E2=80=9Callow B.a B.b perms=E2=80=9D instead of =E2=80=
=9Callow .a B.b perms=E2=80=9D.
>
> Question:
>
> Given the static resolution of names in macros I wonder if this is
> intentional.
>

This is intentional, but I cannot remember why we went that way and I
am not sure that I like the behavior at all.

> ############ End of the report ############
>
>
> Thank you for your time,
> I am available for any questions.
>
> Cheers,
>      Lorenzo Ceragioli

Thanks for your questions. I mostly want the behavior to be consistent
and as unsurprising as possible. Not many people have explored how all
of this works, so I would not be surprised if there were some strange
behaviors.

Jim
