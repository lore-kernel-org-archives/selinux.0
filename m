Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6RGAnp4025552
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 12:10:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6RGAlaW020229
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 16:10:47 GMT
Message-ID: <44C8E580.2090105@mentalrootkit.com>
Date: Thu, 27 Jul 2006 12:10:40 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/6] netfilter integration
References: <20060727154701.12183.qmail@web36606.mail.mud.yahoo.com>
In-Reply-To: <20060727154701.12183.qmail@web36606.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- "Christopher J. PeBenito" <cpebenito@tresys.com>
> wrote:
>
>
>   
>>> Now, as far as inter-module priorities go,
>>> numbers just don't make sense.
>>>       
>> So after further discussion internally, we were
>> thinking that there
>> likely not going to be intermodule dependencies.
>>     
>
> I don't believe that for a minute.
>  
>   

The current policies suggest otherwise - use the new semodule_deps tool 
if you don't believe me.

>> Oracle netfilter
>> contexts aren't going to conflict with apache's. 
>> Modules are going to
>> want to override the contexts in the base module.
>>     
>
> Oracle may not conflict with apache, but what
> about MySQL or, heaven forbid, earlier versions
> of Oracle? You can bet on independent developers
> in the same problem space developing conflicting
> protection schemes.
>   
>   

Local overrides allow an administrator choose when there are conflicts. 
What's the alternative?

>> So we were thinking that we should do something
>> similar to how other
>> parts of the policy are manged, with having base
>> rules, module rules,
>> local rules, pre, and post rules.  The pre and post
>> rules would be
>> special rules that have to come at the beginning or
>> end of the
>> netfilter_contexts file (see the 1's and 9's in my
>> original 0/6 email).
>> Then base would be low priority, module would be
>> middle priority, and
>> local would be high priority.  Modules that are
>> packaged with an app
>> should have the module priority.
>>     
>
> There will be conflicts. You need a scheme
> for dealing with two modules at the same
> "priority" with different rules.
>
>   

One set of rules will win based on ordering. Unfortunately there is no 
good way for the toolchain to make a choice here and allowing the 
administrator to override both modules seems like the best alternative 
to me.

Karl

>
>
> Casey Schaufler
> casey@schaufler-ca.com
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
