Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93JJ2AK022567
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:19:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k93JHqqf029104
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 19:17:52 GMT
Message-ID: <4522B79C.2060405@gentoo.org>
Date: Tue, 03 Oct 2006 15:18:52 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Joy Latten <latten@austin.ibm.com>
CC: eparis@parisplace.org, redhat-lssp@redhat.com, selinux@tycho.nsa.gov,
        jmorris@namei.org, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>
In-Reply-To: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joy Latten wrote:
>> Before network labeling is completed we still need some work
>> implementing how we plan to audit configuration changes in ipsec
>> labeling decisions.  I believe we agreed today that this auditing must
>> be done in kernelspace since we do not have fine grained enough controls
>> on netlink messages to allow for all of the auditing in userspace.
>>
>>     
>
> I've talked to Klaus about what needs to be audited for ipsec and
> lspp compliance. I will begin work on a patch and get this out
> to the list as soon as I can. We will audit everytime a policy is 
> added/removed to/from the ipsec policy database.
>
>   
why not just auditallow all association setcontext?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
