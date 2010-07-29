Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6TBgHI1017881
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2010 07:42:21 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6TBgPmb025647
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2010 11:42:25 GMT
Message-ID: <20100729124218.593488qmqxjahkpk@webmail.tuffmail.net>
Date: Thu, 29 Jul 2010 12:42:18 +0100
From: Martin Orr <martin@martinorr.name>
To: =?utf-8?b?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
Cc: russell@coker.com.au, Eric Paris <eparis@parisplace.org>,
        SE-Linux
	<selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
References: <201007121922.48247.russell@coker.com.au>
	<20100712140130.468b7b42@debian>
	<AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
	<201007122208.13078.russell@coker.com.au> <20100712154528.47864541@debian>
	<20100712153242.10606virkn0rqeos@webmail.tuffmail.net>
	<20100712173521.1c436f94@debian>
In-Reply-To: <20100712173521.1c436f94@debian>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon 12 Jul 15:35:21 2010, Török Edwin wrote:

> On Mon, 12 Jul 2010 15:32:42 +0100
> Martin Orr <martin@martinorr.name> wrote:
>
>> On Mon 12 Jul 13:45:28 2010, Török Edwin wrote:
>> > Well the purpose of loading the database with freshclam is to avoid
>> > causing problems to clamd. So it is important that they are either
>> > both JIT, or both non-JIT.
>>
>> I configured clamd not to use the JIT by putting "Bytecode false" in
>> clamd.conf.  I put the same thing in freshclam.conf, but it
>> continues to try to allocate executable memory.
>>
>
> That sounds like a bug, please open a bugreport at bugs.clamav.net, and
> attach the output of strace freshclam.

I just realised that "Bytecode false" doesn't do what I thought it  
does: for some reason I had thought it just disabled the JIT, but in  
fact it disables bytecode altogether.

Nevertheless it still seems that freshclam shouldn't need RWX memory  
if bytecode is disabled, so I reported this as bug 2149.

-- 
Martin Orr



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
