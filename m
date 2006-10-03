Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LRhZZ027049
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:27:43 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93LQWqf024765
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:26:33 GMT
Message-ID: <4522D5C2.8060702@hp.com>
Date: Tue, 03 Oct 2006 17:27:30 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
Cc: Joy Latten <latten@austin.ibm.com>, eparis@parisplace.org,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov, jmorris@namei.org,
        paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>	 <4522B79C.2060405@gentoo.org> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org>
In-Reply-To: <4522D554.7080708@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Linda Knippers wrote:
> 
>> Joy Latten wrote:
>>  
>>
>>> On Tue, 2006-10-03 at 15:18 -0400, Joshua Brindle wrote:
>>>
>>>    
>>>
>>>> Joy Latten wrote:
>>>>
>>>>      
>>>>
>>>>>> Before network labeling is completed we still need some work
>>>>>> implementing how we plan to audit configuration changes in ipsec
>>>>>> labeling decisions.  I believe we agreed today that this auditing
>>>>>> must
>>>>>> be done in kernelspace since we do not have fine grained enough
>>>>>> controls
>>>>>> on netlink messages to allow for all of the auditing in userspace.
>>>>>>
>>>>>>              
>>>>>
>>>>> I've talked to Klaus about what needs to be audited for ipsec and
>>>>> lspp compliance. I will begin work on a patch and get this out
>>>>> to the list as soon as I can. We will audit everytime a policy is
>>>>> added/removed to/from the ipsec policy database.
>>>>>
>>>>>  
>>>>>         
>>>>
>>>> why not just auditallow all association setcontext?
>>>>       
>>>
>>> Dang! Why didn't I think of that! :-) Such a good idea. I will do a
>>> quick test and
>>> show Klaus and see if it all looks ok to him.
>>> Thanks!!!
>>>     
>>
>>
>> If we go the auditallow route then we lose some audit record management
>> features, like the ability to enable/disble/search for these records,
>> don't we?  Do we care?
>>
>>   
> 
> enable and disable with a boolean
> 
> searching? surely you can search avc records..

I meant with the audit tools, so using auditctl to add/remove rules and
ausearch for looking for specific record types.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
