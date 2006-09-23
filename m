Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8O002v3029205
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 20:00:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8NNx2a3011358
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 23:59:02 GMT
Message-ID: <4515CA12.3050107@gentoo.org>
Date: Sat, 23 Sep 2006 19:58:10 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: Re: FC5 policy
References: <200609240034.08217.russell@coker.com.au> <45154AC3.6040109@gentoo.org> <200609240813.56907.russell@coker.com.au>
In-Reply-To: <200609240813.56907.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Sunday 24 September 2006 00:54, Joshua Brindle <method@gentoo.org> wrote:
>   
>> Russell Coker wrote:
>>     
>>> http://www.coker.com.au/selinux/fc5/
>>>
>>> At the above URL I have my latest packages of FC5 policy with patch and
>>> source.  They compile the policy with amavis and clamav policy in base
>>> (which can't be included in an FC5 update as the tools are broken and
>>> don't support policy moving from a module to base), they have Postgrey
>>> policy compiled in, and they have a few other policy changes (such as
>>> allowing unconfined_t to kill unlabeled_t processes).
>>>       
>> um? in what way are the tools broken? It is quite easy to move a module
>> to base:
>>
>> semodule -r clamav -i base-with-clamav.pp
>>     
>
> The package installation process can't do it.
>   
sounds like a problem with the package manager rather than the selinux 
tools.
> Ideally we would have some way for semodule to automatically figure out that 
> base-with-clamav.pp has the clamav module and do the right thing.
>
>   
doubtful. What if they have different rules? How about slightly 
different type spaces? Is it ok if some types are invalided as long as 
some aren't? This is certainly not something semodule should do.
>>> Also my patch removes some unnecessary and inappropriate access from some
>>> domains.  I know that most people don't like removing access from
>>> processes, but I think we need to use the principle of least-privilege
>>> more seriously.
>>>       
>> Who doesn't like removing access from processes? I think we are all on
>> the same side here..
>>     
>
> Then why do I keep sending this patch to the list and it doesn't get applied?
>
> Why hasn't the pre-fedora /boot sym-links thing been cleaned up?
>   
i didn't see you send any patch to the list. you sent a link to some 
packages and some backhanded remarks about the policy, certainly not a 
good way to get something merged..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
