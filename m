Message-ID: <4242B32D.9050109@ak.jp.nec.com>
Date: Thu, 24 Mar 2005 21:31:41 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <20050322001439.GB8444@lkcl.net> <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com> <20050324110438.GC13372@lkcl.net>
In-Reply-To: <20050324110438.GC13372@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

 >  and your original question was: when you use A "extends" B and C
 >  "extends" B, and B contains "@"s, how do you potentially make A
 >  ignore the "@" but C _not_ ignore the "@"?

That means as follows, doesn't it ?
<type B>
  + <type A>
  + <type C>

"allow foo_t @B - @C:file getattr ;" is rolled out to
"allow foo_t {B A}:file getattr ;" as you want.


 >  if that was your original question, then that's easy: you use a syntax
 >  @(A) or @(A,Z,Y,X)

I also thought such statements, but don't implement it.
Indeed, implementing "@{A B C D}" is easy.
But "{A B @{C D}}" will be desired next, if we can represent such statement.
It's difficult to handle the nested statement in current checkpolicy implementation.
(we need much efforts to this, if my understanding is not mistake.)

Please look the implementation of '~', is similar to '@' processing.

Thanks,
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
