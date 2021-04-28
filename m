Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B3C433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FBA613DC
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 12:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhD1Mmo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:42:44 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:50268 "EHLO smtp.unipi.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239416AbhD1Mmo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 28 Apr 2021 08:42:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.unipi.it (Postfix) with ESMTP id 4702B8137D
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 14:41:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from [192.168.1.8] (net-5-89-197-160.cust.vodafonedsl.it [5.89.197.160])
        (Authenticated User)
        by smtp.unipi.it (Postfix) with ESMTPSA id 72B848101A
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 14:41:52 +0200 (CEST)
To:     selinux@vger.kernel.org
From:   lorenzo ceragioli <lorenzo.ceragioli@phd.unipi.it>
Subject: [bug report?] other unexpected behaviours in secilc and CIL semantics
Message-ID: <86d254dd-fd82-e25c-915b-16615b341457@phd.unipi.it>
Date:   Wed, 28 Apr 2021 14:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,


I am still performing tests to fully understand the semantics of CIL, 
here are three strange behaviours I have noticed, I would really 
appreciate it if you can say if I am wrong and, in case I am not, if 
they are coherent with the intended meaning of CIL constructs.

Please note again that I am currently using the version available on 
Ubuntu 18.04.5 LTS via packet manager.


########################## Report ##########################


1)


Names defined inside the body of a macro are not checked before names 
defined in the namespace in which the macro is defined. For example, in 
the following

(block A

(type a)

(macro m ()

(type a)

(allow a a (file (read)))))


(block B

(call A.m))


I would expect "a" to be resolved as the type "a" in the body of the 
macro, hence to "B.a" as the allow statement and type definition are 
copied into block "B". Instead it is resolved as "A.a" (I get “allow A.a 
A.a”).

Basically, it behaves like


(block A

(type a)

(macro m ()

(allow a a (file (read)))))

(block B

(call A.m))

and not like

(block A(macro m ()(type a)

(allow a a (file (read)))))

(block B

(call A.m))

as I expected.

I know that the documentation saying:

“Note that when resolving macros the callers namespace is not checked, 
only the following places: - Items defined inside the macro

     -Items passed into the macro as arguments- Items defined in the 
same namespace of the macro- Items defined in the global namespace”

is outdated, and that it has been proposed to change it with:

"When resolving macros the following places are checked in this order:

     - Items defined inside the macro

- Items passed into the macro as arguments

- Items defined in the same namespace of the macro

- Items defined in the callers namespace

- Items defined in the global namespace"


But the observed behaviour is not coherent with none of these descriptions.

Maybe this could work:

"When resolving macros the following places are checked in this order:

- Items passed into the macro as arguments

- Items defined in the same namespace of the macro

- Items defined inside the macro - Items defined in the callers namespace

- Items defined in the global namespace"

But I think it is not an intuitive way of resolving names.


2)

Usually, names inside a macro are resolved using the definitions in the 
namespace in which the macro is defined before the ones in the caller 
namespace.

I noticed that, in the following


(type a)


(macro m ()

(allow a a (file (read))))


(block A

(type a)

(call m))


the name "a" is resolved in "A", not as ".a" in the global namespace, 
which is the namespace where "m" is defined.

Hence I assumed that the rule does not apply to macros defined in the 
global namespace, can you confirm?


3)

I noticed that the types declared in a macro, being copied into the 
caller namespace, can be used as parameters for the macro itself.

For example, in the following


(type a)


(block A

(macro m ((type x))

   (type a)

(allow x x (file (read))))

)


(block B

(call A.m(a))

)


the resulting allow rule is (allow B.a B.a (file(read))), which in my 
opinion is unexpected.


#############################################################


Thank you for your time.


Cheers,

Lorenzo Ceragioli
