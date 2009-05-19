Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4J2q96K005898
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 22:52:09 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4J2q459028979
	for <selinux@tycho.nsa.gov>; Tue, 19 May 2009 02:52:05 GMT
Message-ID: <4A121EAB.6040702@ak.jp.nec.com>
Date: Tue, 19 May 2009 11:51:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: dwalsh@redhat.com, method@manicmethod.com,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: daemons and MCS categories
References: <200605220930.05483.russell@coker.com.au> <1148910738.14262.67.camel@sgc.columbia.tresys.com> <49EC1F11.6040003@ak.jp.nec.com> <49ED29CC.6080507@ak.jp.nec.com> <49EED77F.5060407@ak.jp.nec.com> <4A07B36C.1080305@ak.jp.nec.com> <86170769-8CD9-4A99-9C14-624611280E55@nall.com> <4A111CD5.1000109@ak.jp.nec.com> <4CCE8C9B-DEA8-407B-A4A1-AE9CC2907197@nall.com>
In-Reply-To: <4CCE8C9B-DEA8-407B-A4A1-AE9CC2907197@nall.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> FWIW, we run apache 1.3 out of xinetd at multiple contexts using labeled
>>> networking. HTTP performance is surprisingly good. HTTPS performance is
>>> unacceptable, so we are using an HTTPS reverse proxy in a DMZ for single
>>> level network services to the 'enterprise'.
>>
>> Are you saying that xinetd can launch multiple apache/httpd daemon 
>> processes
>> with individual security context?
> 
> Yes
> 
>> If so, unfortunatelly, it is different from
>> what I would like to achieve. :(
>>
>> I guess the security context of the daemon process is determined prior to
>> receiving http-requests come from users, but the security context to be
>> assigned on web application depends on the authentication-header within
>> the http-request-headers, so we cannot know who connected to on xinetd 
>> time.
> 
> We are basing the context on the context of the connecting user, 
> delivered by either netlabel or labeled IPSec. We are not changing 
> context based on apache user authentication.

Understood.

>> Or, are we talking about topics in different layer?
> 
> Sounds like it. Just wanted to point out that you might not need to 
> trust apache to achieve some of your goals.

We need to trust the apache/httpd applies its authentication and
dropping privileges correctly. However, all the new domain is
bounded by httpd_t, so there are no fundamental differences outside
of the httpd_t.

The purpose of this effort is to associate a concept of web-user
and a security context while apache/httpd performs as an agent of
the human-user. So, I would like to restrict a part of privileges
within a set of them allowed to httpd_t.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
