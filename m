Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57467C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A7820789
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 21:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIV7j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:59:39 -0500
Received: from smtp4.unipi.it ([131.114.21.141]:44216 "EHLO smtp.unipi.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgKIV7j (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 9 Nov 2020 16:59:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.unipi.it (Postfix) with ESMTP id 0A3328121E
        for <selinux@vger.kernel.org>; Mon,  9 Nov 2020 22:59:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from [192.168.1.100] (unknown [151.29.63.88])
        (Authenticated User)
        by smtp.unipi.it (Postfix) with ESMTPSA id 13FA580F9A
        for <selinux@vger.kernel.org>; Mon,  9 Nov 2020 22:59:36 +0100 (CET)
To:     selinux@vger.kernel.org
From:   Lorenzo Ceragioli <lorenzo.ceragioli@phd.unipi.it>
Subject: Bug (?) report for secilc and CIL semantics: some unexpected
 behaviours
Message-ID: <5ca2e18c-6395-a0af-fdee-b0ac5f1de714@phd.unipi.it>
Date:   Mon, 9 Nov 2020 22:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To Whom it may concern,

I am performing some tests to fully understand the semantics of CIL, and 
I have noticed some strange behaviours that may be erroneous.
Please note that I am currently using the version available on Ubuntu 
18.04.5 LTS via packet manager, hence some of the problems (if they are 
problems) may be already solved.
Moreover, I am focusing on policies that only use types, and the 
procedure I have used for testing is simply to compile the .cil file 
with secilc and check which allow rules are found by "sesearch --allow".

I decided to send this email instead of opening issues on github, please 
let me know if I was wrong.

The strange behaviours that I have observed follows:

############ Report ############

1) The manual says "Note that when resolving macros the callers 
namespace is not checked, only the following places:

     •Items defined inside the macro
     •Items passed into the macro as arguments
     •Items defined in the same namespace of the macro
     •Items defined in the global namespace"

like in the following

(type a)

(block B
      (type a)
      (macro m ()
                 (allow a a perms)))

(block A
       (type a)
       (call B.m))

Where you get "allow B.a B.a perms" instead of "allow A.a A.a perms"

BUT, according to my experiments this seems to work only if types are 
locally defined in the macro namespace, whereas the caller namespace is 
checked if they are defined in the global namespace or undefined. Two 
examples follows:

Ex 1.1

(block A
      (macro m1 ()
                (allow a a perms))
)

(block B
      (type a)
      (call A.m1)
)

Ideally this should not compile (because type a is not defined in A 
namespace nor in the global namespace), instead we get allow B.a B.a

Ex 1.2

(type a)

(macro m ()
     (allow a a perms))

(block A
       (type a)
       (call m))

Ideally the "a" inside the macro should refer to the "a" type in the 
global namespace, and we should get "allow .a .a", instead we get "allow 
A.a A.a"

Question:

Is this the intended behaviour?

For this point I see that there is already a report (in the mailing 
list) for asking to modify the manual, writing

"When resolving macros the following places are checked in this order:
     •Items defined inside the macro
     •Items passed into the macro as arguments
     •Items defined in the same namespace of the macro
     •Items defined in the callers namespace
     •Items defined in the global namespace"

As far as I can see, the CIL Reference Guide has not been updated. Have 
you decided to change the semantics of CIL (i.e. the behaviour of 
secilc) instead of the documentation?


2) The CIL Wiki says, regarding inheritance of multiple macros with the 
same name "Inheritance causes all of the macros to be merged into a 
single macro with the union of the access". I think this is not the 
case, like in the following example:

Ex 2.1

(type c)

(block A
         (type a)
         (macro m1 ()
                 (allow a c perms)))

(block B
         (type b)
         (macro m1 ()
                 (allow b c perms)))

(block C
         (blockinherit A)
         (blockinherit B)
         (call m1))

In theory I should get both "allow C.a .c perms" and "C.b .c perms", but 
I only get the first one.

According to my tests I get the one that is declared first (it is also 
inherited first, but this does not seem to be relevant).

Question:

Is this a bug?
If not (I see that CIL Wiki is not maintained since CIL is merged into 
SELinux repository), which is the criterion for choosing which macro to 
take (is it really "first defined wins")?



3) Types resulting from a macro call may be used inside a macro 
definition, like in the following

(type a)

(block A
      (macro m ()
           (allow a a perms))

      (call m1))

(macro m1()
      (type a))

(block B
      (call A.m))

Here the "a" in macro "m" is resolved to the local type "a" that is 
introduced because of a call to macro "m1", hence you get "allow A.a A.a 
Perms" instead of "allow .a .a Perms", as it would have been if names in 
"m" were resolved before calling "m1".

BUT, this lead to a strange behaviour when circular definitions are 
considered, as in the following example

Ex 3.1

(type a)
(type b)

(block A
      (macro m ()
          (type b)
          (allow a a perms))

      (call B.m1)
)

(block B
      (macro m1()
           (type a)
           (allow b b perms))

      (call A.m)
)

where you get "allow A.a A.a Perms" and "allow B.b B.b Perms" even if 
there is no evaluation order of the macros that transforms the code in 
such way (given that the names inside the macros are evaluated before 
copying the code, as stated in (1))
Depending on the evaluation order, the result should be one of the 
following:

a) if you evaluate "m" before "m1"


(type a)
(type b)

(block A
      (type a)
      (allow B.b B.b perms))
)
(block B
     (type b)
      (allow .a .a perms)
)

b) if you evaluate "m1" before "m"

(type a)
(type b)

(block A
      (type a)
      (allow .b .b perms))
)
(block B
     (type b)
      (allow A.a A.a perms)
)

Question:

I am not sure this is not exactly the behaviour you want, but in case I 
would like to have a confirmation.

4) I see that something like late binding is used for names in block 
inheritance, like in the following

(type a)
     (block A
            (type b)
        (allow a b perms))

     (block B
           (blockinherit A)
       (type a))

in which we get “allow B.a B.b perms” instead of “allow .a B.b perms”.

Question:

Given the static resolution of names in macros I wonder if this is 
intentional.

############ End of the report ############


Thank you for your time,
I am available for any questions.

Cheers,
     Lorenzo Ceragioli
