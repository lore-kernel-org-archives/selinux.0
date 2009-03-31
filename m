Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VKYuac015666
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 16:34:57 -0400
Received: from mail2.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VKYtgc028775
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 20:34:56 GMT
Message-ID: <49D27E6C.5000106@kaigai.gr.jp>
Date: Wed, 01 Apr 2009 05:34:52 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        method@manicmethod.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp> <49D23288.2030807@rubix.com>
In-Reply-To: <49D23288.2030807@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I am referring to things like:
> 
> mlsconstrain { db_tuple } { use select }
>     (( l1 dom l2 ) or
>      (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
>      ( t1 == mlsdbread ) or
>      ( t2 == mlstrustedobject ));

I noticed the db_xxx:{use} permission remained here. :-)

> where t1 == mlsdbread seems to imply an object is trusted to read 
> strictly dominating objects. Unless I am missing the meaning here, I 
> would call this a MAC override. I realize there is no concept of a TE 
> override, but MLS is part of MAC, no? And, this violates B&L rules. This 
> is something we would control with a Security Administrator "role". Or, 
> is this mlsdbread something that is impossible to give to a domain in a 
> DBMS policy?

It is different from my usage of terms.
Some of domains are allowed to access the tuple, and others are
disallowed as the result of access controls using the security
policy.

I understood the term of "MAC override" to express what actions
are allowed without any checks based on security policy, as if
root stuff can ignore DAC checks.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
