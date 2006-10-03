Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LlotS027686
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:47:50 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93Lkdqf028166
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:46:40 GMT
Message-ID: <4522DA79.6080708@hp.com>
Date: Tue, 03 Oct 2006 17:47:37 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <method@gentoo.org>, Joy Latten <latten@austin.ibm.com>,
        eparis@parisplace.org, redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        jmorris@namei.org, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>	 <4522B79C.2060405@gentoo.org> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org> <4522D5C2.8060702@hp.com> <4522D667.5030401@mentalrootkit.com>
In-Reply-To: <4522D667.5030401@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Linda Knippers wrote:
> 
>> Joshua Brindle wrote:
>>  
>>
>>> Linda Knippers wrote:
>>>
>>>     
> 
> <snip>
> 
>>>> If we go the auditallow route then we lose some audit record management
>>>> features, like the ability to enable/disble/search for these records,
>>>> don't we?  Do we care?
>>>
>>> enable and disable with a boolean
>>>
>>> searching? surely you can search avc records..
>>
>> I meant with the audit tools, so using auditctl to add/remove rules and
>> ausearch for looking for specific record types.
>>   
>  
> As I said in my other mail the searching should be fine. Why does the
> addition or removal need to be handled by auditctl?

There was a discussion a long, long time about about how administrators should
manage what gets into the audit logs, whether its with the audit tools, the
policy or both.  There are explicit message types for alot of management
operations so that the admin can decide whether to get them and the tools
make it easy to search for.  If changing the ipsec label configuration is just
an AVC message, it will be different from just about everything else.  It might
be easy, but is it what we want?

I wish sgrubb were reading mail today.  I think this is something that he
cares about, at least he did the last time we had this conversation.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
