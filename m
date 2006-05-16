Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4GEik30018043
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 10:44:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4GEiif8005689
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 14:44:44 GMT
Message-ID: <4469E561.9070306@redhat.com>
Date: Tue, 16 May 2006 10:44:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs in policy
References: <4468A509.50207@redhat.com> <1147719382.31984.11.camel@sgc>	 <4468EA7C.5050708@redhat.com> <1147786502.31984.22.camel@sgc>
In-Reply-To: <1147786502.31984.22.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2006-05-15 at 16:54 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>>> Separation of the auditadm from secadm and sysadm changes for auditd files.
>>>>     
>>>>         
>>> Filesystem association is missing.  This also brings along more problems
>>> like labeling.  There isn't much real separation between auditadm from
>>> the other admin roles, so this doesn't seem to have real benefits.
>>>   
>>>       
>> Required for LSPP.  auditadm is not allowed to do anything but manage 
>> audit subsystem.
>> secadmin can only manage selinux stuff.  sysadmin can only do everything 
>> not done by auditadm
>> and secadm.
>>     
>
> I don't see how we're accomplishing this if secadm, auditadm, and sysadm
> are using the admin_user_template().  It gives a lot of access including
> raw disk access, signalling all domains, managing the source and binary
> policies (explicitly given), and managing all files in general except
> shadow, and running insmod.  The current implementation doesn't allow
> for fine grained role definition yet (it is a planned improvement).
>
>   
Yes I am about to remove secadm and auditadm from admin_user_template to 
remove these privs.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
