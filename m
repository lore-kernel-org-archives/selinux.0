Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t89KG0ME002723
 for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2015 16:16:00 -0400
Subject: Re: secilc: in segfault
To: selinux@tycho.nsa.gov
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903132041.GD2118@x250>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F093C9.2080508@tycho.nsa.gov>
Date: Wed, 9 Sep 2015 16:17:13 -0400
MIME-Version: 1.0
In-Reply-To: <20150903132041.GD2118@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/03/2015 09:20 AM, Dominick Grift wrote:
> On Thu, Sep 03, 2015 at 08:18:17AM -0400, James Carter wrote:
>> On 09/03/2015 05:48 AM, Dominick Grift wrote:
>>> Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
>>>
>>> $ secilc test/in_test.cil
>>> Segmentation fault (core dumped)
>>>
>>>
>>
>> It works for me for the current master branch of SELinux userspace installed
>> locally. What version are you using?
>>
>> Jim
>>
>
> Ok so that turns out to be a bug in Fedora. However.
>
> I can still get secilc to segfault on "in". I wonder if the following is
> or should be supported:
>
> The scenario is: I want to simplify my macros by using
> blockabstracts/inherits to provide a single point of failure
>
> As a matter of test i made these two changes:
>
> https://github.com/DefenSec/dssp/commit/85ba6f1848118e16b5544052dc5764663b272262
> https://github.com/DefenSec/dssp-contrib/commit/77442e1e4658df99d1ce74732338a9c4ad80a6a3
>
> However this makes secilc segfault, and i do not see why.
>

This doesn't appear to be ONLY because of the "in" block. It still segfaults 
even with moving everything inside the block and removing the "in" block.

It looks like one problem is with the use of a blockinherit inside a macro. 
Blocks and blockinherits are not allowed to be used in macros. As we were fixing 
CIL's name resolution last Fall we came to the conclusion that allowing both of 
these would provide little benefit while causing a lot of potential problems. 
But we are open to a discussion if you can provide a compelling use case.

Why not use something like this:

(block exec_blk
	(blockabstract exec_blk)
	(macro exec ((type ARG1))
	       (call can_exec (ARG1 cmd_file))))

(block auditctl
	(blockinherit exec_blk))

(call auditctl.exec (some_type))

instead of:

(block exec_blk
	(blockabstract exec_blk)
	(call can_exec (ARG1 cmd_file)))

(block auditctl
   	(macro exec ((type ARG1))
		(blockinherit exec_blk)))

(call auditctl.exec (some_type))


Jim

> I first thought it was because i was using "ARG1" in the blockabstract
> (see first commit). However that seems to not be the case.
>
> I am left wondering: what am i doing wrong here (obviously secilc should
> not segfault nevertheless)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
