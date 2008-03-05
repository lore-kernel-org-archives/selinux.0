Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25GGZg4024886
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 11:16:35 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m25GGYxh024258
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 16:16:34 GMT
Cc: selinux@tycho.nsa.gov
Message-Id: <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>
From: Ronald van den Blink <selinux@a61.nl>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1204733123.14217.48.camel@gorn>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Unreserved portnumbers in corenetwork
Date: Wed, 5 Mar 2008 17:16:31 +0100
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl> <1204730645.14217.39.camel@gorn> <51324.80.95.164.250.1204732077.squirrel@www.a61.nl> <1204733123.14217.48.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 5, 2008, at 5:05 PM, Christopher J. PeBenito wrote:

> On Wed, 2008-03-05 at 16:47 +0100, selinux@a61.nl wrote:
>>> Unfortunately there are 3 forces at work.  The first is that for the
>>> most part, ports should always be labeled, because, for example,  
>>> port 80
>>> is always going to be regarded as the http port.  The second is that
>>> thats not always the case for non well-defined ports (your  
>>> situation).
>>> The third is that portcons (the port labeling statements) only  
>>> work in
>>> the base module.  So, though we want to make a happy medium  
>>> between the
>>> first two, we can't overcome the final one within the constraints  
>>> of the
>>> current toolchain.
>>>
>>
>> Agree with that. But wouldn't the situation be a little less  
>> complicated
>> if you decide not to define any ports above 1024 in the reference  
>> policy?
>
> That breaks people that just want to use reference policy.
>
Does this mean that any module in the refpol that needs (for instance)  
port 8080 but isn't a http-cache-daemon uses corenetwork_httpd_cache  
and get's all the other ports defined there as well? Isn't that  
breaking the least priviliges idea? Because you're opening up more  
ports then needed?

>> If you decide to do that, you could create a portcon that allows a  
>> single
>> active module to claim a port above 1024 on a per module basis. A  
>> second
>> module could claim another one, as long as it's not equal to the  
>> first
>> (active) one.
>>
>> In this way you create a generic handler for modules that need  
>> ports above
>> 1024 and can create a reference policy with modules with the same  
>> ports.
>> As long as they are not both active, you wouldn't have any problem.
>
> If I understand what your suggesting, then I don't see how thats
> implementable with the current toolchain.
>
No it's not possible in the current toolchain, that's true. What we're  
suggesting is to make the reference policy more modulair by making  
ports <1024  available in corenetworks and providing ports > 1024 with  
a different handler.

Right now the reference policy is forcing module makers to give to  
much privileges (i.e. open up more ports then needed) or to edit the  
reference policy if they want to give exactly perfect privileges. This  
will in the end provide a security risk (if jboss get's exploited  
there are much to many ports open).

The ideal situation is that no port higher then 1024 is defined in  
corenetwork (in my opinion off course).


> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
