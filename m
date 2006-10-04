Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GXv15021198
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:33:57 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94GWj5l018960
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:32:46 GMT
Message-ID: <4523E13F.9080906@mentalrootkit.com>
Date: Wed, 04 Oct 2006 12:28:47 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: redhat-lspp@redhat.com, Linda Knippers <linda.knippers@hp.com>,
        Joy Latten <latten@austin.ibm.com>, paul.moore@hp.com,
        vyekkirala@TrustedCS.com, jmorris@namei.org, selinux@tycho.nsa.gov,
        Joshua Brindle <method@gentoo.org>, eparis@parisplace.org
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <200610041213.03223.sgrubb@redhat.com>
In-Reply-To: <200610041213.03223.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Tuesday 03 October 2006 16:40, Linda Knippers wrote:
>   
>>> Dang! Why didn't I think of that! :-)
>>> Such a good idea. I will do a quick test and
>>> show Klaus and see if it all looks ok to him.
>>> Thanks!!!
>>>       
>> If we go the auditallow route then we lose some audit record management
>> features, like the ability to enable/disble/search for these records,
>> don't we?  Do we care?
>>     
>
> Yes we care! And we should not do it with auditallow rules. The problem is 
> that to SE linux, EVERYTHING is an AVC. There is no separation of meaning by 
> using the message type. If an admin wants to query to see all the config 
> changes made during a range of time, using AVC's will not be considered in 
> the results.
>
>   

I don't understand - the object class and / or permissions will allow 
filtering and separating out the various types of AVC messages.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
