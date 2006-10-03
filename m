Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93MxTfP029628
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 18:59:29 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93MwISJ009535
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 22:58:18 GMT
Message-ID: <4522EB42.9070502@hp.com>
Date: Tue, 03 Oct 2006 18:59:14 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joy Latten <latten@austin.ibm.com>, eparis@parisplace.org,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov, jmorris@namei.org,
        paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>	 <4522B79C.2060405@gentoo.org> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org> <4522D5C2.8060702@hp.com> <4522D667.5030401@mentalrootkit.com> <4522DA79.6080708@hp.com> <4522E6F7.1040207@gentoo.org>
In-Reply-To: <4522E6F7.1040207@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Linda Knippers wrote:
>> Karl MacMillan wrote:
>>> Linda Knippers wrote:
>>>> Joshua Brindle wrote:
>>>>> Linda Knippers wrote:
>>>>>
>>>
>>> <snip>
>>>
>>>    
>>>
>>>>>> If we go the auditallow route then we lose some audit record
>>>>>> management
>>>>>> features, like the ability to enable/disble/search for these records,
>>>>>> don't we?  Do we care?
>>>>>>           
>>>>>
>>>>> enable and disable with a boolean
>>>>>
>>>>> searching? surely you can search avc records..
>>>>>         
>>>>
>>>> I meant with the audit tools, so using auditctl to add/remove rules and
>>>> ausearch for looking for specific record types.
>>>>         
>>>
>>>  
>>> As I said in my other mail the searching should be fine. Why does the
>>> addition or removal need to be handled by auditctl?
>>>     
>>
>>
>> There was a discussion a long, long time about about how
>> administrators should
>> manage what gets into the audit logs, whether its with the audit
>> tools, the
>> policy or both.  There are explicit message types for alot of management
>> operations so that the admin can decide whether to get them and the tools
>> make it easy to search for.  If changing the ipsec label configuration
>> is just
>> an AVC message, it will be different from just about everything else. 
>> It might
>> be easy, but is it what we want?
>>
>>   
> 
> what about relabeling files? or setting secmark labels? or domain
> transitions? setexec(), etc. I'm very skeptical that lspp requires any
> kind of auditing of ipsec label change but none of these. 

It has a requirement to be able to audit all modifications of the
values of security attributes, so we can audit a bunch of syscalls
that do that (chmod, chown, setxattr, ...).  Relabeling files
would definitely count and be covered.  There's also a requirement about
auditing changes to the way data is imported/exported, so this is where
the networking stuff comes in.  I don't know about domain transitions.

> Further, all
> the others are in policy, you want to special case ipsec? and for that
> matter just the spd rules which is pretty much useless without
> accompanying polmatch rules. I'm very dubious about this entire thread.

I'm not trying to special case ipsec.  In fact, that was the point of
my comment.  In general, we have explicit message types for the things
that we care about auditing.  Paul added auditing for the netlabel
configuration changes because the only other way to know about the
changes would be watching the netlink messages.

I asked the question about using auditallow because its different from
how all the other things that lspp cares about are handled from an
audit administrator's perspective.  I personally don't care that much
either way but if its going to be different, folks ought to know,
especially the folks who have to document and test it.

-- ljk
> 
>> I wish sgrubb were reading mail today.  I think this is something that he
>> cares about, at least he did the last time we had this conversation.
>>   
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
