Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6EHCXfB001429
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 13:12:33 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6EHCW48009715
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 17:12:32 GMT
Message-ID: <44B7D0C5.7070304@redhat.com>
Date: Fri, 14 Jul 2006 13:13:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: role infrastructure
References: <1152106918.8907.28.camel@sgc>  <44B3A993.2070906@redhat.com> <1152883024.3299.79.camel@sgc.columbia.tresys.com>
In-Reply-To: <1152883024.3299.79.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-07-11 at 09:37 -0400, Daniel J Walsh wrote:
>   
>> Bringing this out for full discussion.
>>
>> Christopher J. PeBenito wrote:
>>     
>>> Dan, can you give me a run down of:
>>>
>>> 1. how you want to be able to configure user roles
>>> 2. things that fc/rhel users request for user role customization
>>>   
>>>       
>> Good question I think this is more a brain storming exercise, which I 
>> don't necessarily have the knowledge or
>> experience to answer.
>>
>> What I have heard is for Sarbanes Oxley, groups want to be allowed to 
>> have administrators that can get root privs in order to
>> configure certain facets of the system, but not full control.
>>
>> So you could imagine a webadmin, nameserveradmin, dhcpadmin as 
>> examples.  Then I believe they would like to use
>> dominance in some way to group them.  netadmin = { nameserveradmin 
>> dhcpadmin }.
>>
>> My idea is that we give these administrators full control over the types 
>> defined for these domains, and allow them to use all of the
>> standard tools for configuring (vi, emacs, basically anything labeled 
>> bin_t.)
>>
>> To make this useful in a Targeted policy system, we might do something 
>> to sudo to get a transition to happen.
>>
>> So dwalsh can run a root shell but only in the webadm_r  unconfined_t 
>> would transition to webadm_r.
>>     
>
> So this looks like the main goal of these examples is finer-grained
> admin users, which makes sense. 
exactly
>  What I'd like to do is go one step
> farther and make it possible to compose the roles more easily, making it
> possible to have unprivileged users that have less access than the
> current user_t.  
I agree. 

I would like to get to the point where in targeted policy we could allow 
people to turn on mozilla/thunderbird
policy via a boolean.  So someone building a kiosk could run a locked 
down version of thunderbird without requiring
the pain of strict policy.  But I digress.
> If you look at the userdomain.if in the role-infra
> branch, you can see that I started to break down the user domains into
> logical blocks so they can be more easily composed.  Note, the names on
> these templates are just temporary, and will be changed in the future.
>
>   

Yes that is a step in the right direction.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
