Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CEXAfa021817
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 10:33:11 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CEYdjj023336
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 14:34:40 GMT
Message-ID: <20100712153242.10606virkn0rqeos@webmail.tuffmail.net>
Date: Mon, 12 Jul 2010 15:32:42 +0100
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
In-Reply-To: <20100712154528.47864541@debian>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon 12 Jul 13:45:28 2010, Török Edwin wrote:
> On Mon, 12 Jul 2010 22:08:12 +1000
> Russell Coker <russell@coker.com.au> wrote:
>> On Mon, 12 Jul 2010, Eric Paris <eparis@parisplace.org> wrote:
>> Now given that freshclam doesn't do any serious work with the data,
>> is interpreting it going to cause any problem that we will care
>> about?  If we are talking about 1 hour of CPU time vs 2 hours for jit
>> vs interpreted for run- time stuff then it makes a difference, but if
>> we are talking about 1 second vs 2 seconds for freshclam then maybe
>> there's not much point.
>>
>
> Well the purpose of loading the database with freshclam is to avoid
> causing problems to clamd. So it is important that they are either both
> JIT, or both non-JIT.

I configured clamd not to use the JIT by putting "Bytecode false" in  
clamd.conf.  I put the same thing in freshclam.conf, but it continues  
to try to allocate executable memory.

-- 
Martin Orr



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
