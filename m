Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8SKHSsX002708
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 16:17:28 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8SKGf7X025541
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 20:16:41 GMT
Message-ID: <4AC119D3.5070107@redhat.com>
Date: Mon, 28 Sep 2009 16:17:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Orion Poplawski <orion@cora.nwra.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SElinux troubles
References: <4AB10AC9.9020006@cora.nwra.com> <4AB1125E.3020402@redhat.com> <4AB119F1.4070600@cora.nwra.com> <4AB12199.5090901@redhat.com> <4AB7BC55.4060304@cora.nwra.com> <4AB83734.6090805@redhat.com> <4AB8DE44.3090907@cora.nwra.com> <4AB8E96D.50801@redhat.com> <4AB8F20A.5040409@cora.nwra.com> <4AC1087C.2090800@redhat.com> <4AC118EC.6090707@cora.nwra.com>
In-Reply-To: <4AC118EC.6090707@cora.nwra.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/28/2009 04:13 PM, Orion Poplawski wrote:
> On 09/28/2009 01:03 PM, Daniel J Walsh wrote:
>> On 09/22/2009 11:49 AM, Orion Poplawski wrote:
>>> On 09/22/2009 09:12 AM, Daniel J Walsh wrote:
>>>> On 09/22/2009 07:25 AM, Orion Poplawski wrote:
>>>>> On 09/21/2009 08:32 PM, Daniel J Walsh wrote:
>>>>>> Do you have labels on the rest of the system?  Do you have seedit
>>>>>> installed?
>>>>>
>>>>> Yes, e.g.:
>>>>>
>>>>> # ls -Za /etc/ssh
>>>>> drwxr-xr-x  root root system_u:object_r:etc_t          .
>>>>> drwxr-xr-x  root root system_u:object_r:etc_t          ..
>>>>> -rw-------  root root system_u:object_r:etc_t          moduli
>>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_config
>>>>> -rw-------  root root system_u:object_r:etc_t          sshd_config
>>>>> -rw-------  root root system_u:object_r:sshd_key_t    
>>>>> ssh_host_dsa_key
>>>>> -rw-r--r--  root root root:object_r:etc_t
>>>>> ssh_host_dsa_key.pub
>>>>> -rw-------  root root system_u:object_r:sshd_key_t     ssh_host_key
>>>>> -rw-r--r--  root root root:object_r:etc_t             
>>>>> ssh_host_key.pub
>>>>> -rw-------  root root system_u:object_r:sshd_key_t    
>>>>> ssh_host_rsa_key
>>>>> -rw-r--r--  root root root:object_r:etc_t
>>>>> ssh_host_rsa_key.pub
>>>>> -rw-r--r--  root root user_u:object_r:etc_t            ssh_known_hosts
>>>>>
>>>>> Don't appear to have seedit, never heard of it.
>>>>>
>>>> Right now as root you execute
>>>>
>>>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
>>>>
>>>> It gives you an error?
>>>
>>> yup.
>>>
>>> # chcon system_u:object_r:etc_t:s0 /etc/ssh
>>> chcon: failed to change context of /etc/ssh to
>>> system_u:object_r:etc_t:s0: Operation not permitted
>>>
>> Just back from linuxcon.  Can we bring this to the list?
>>
> 
> Definitely, which one?
> 
> 
SE Linux <selinux@tycho.nsa.gov>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
