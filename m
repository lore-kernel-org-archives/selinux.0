Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o21Go8kn031952
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 11:50:08 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o21GnpFG010062
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 16:49:51 GMT
Message-ID: <4B8BF03A.1030709@redhat.com>
Date: Mon, 01 Mar 2010 11:50:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ulrich Althaus <ulrich.althaus@triagnosys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: RHEL4 Selinux mailinglist
References: <4B8BDE81.7020800@triagnosys.com> <4B8BE693.8090304@redhat.com> <4B8BEB95.3070509@triagnosys.com>
In-Reply-To: <4B8BEB95.3070509@triagnosys.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/01/2010 11:30 AM, Ulrich Althaus wrote:
>
> Am 01.03.2010 17:08, schrieb Daniel J Walsh:
>    
>> On 03/01/2010 10:34 AM, Ulrich Althaus wrote:
>>      
>>> Hi,
>>>
>>> if I have problems with telnet in RHEL4, which mailing list should I
>>> write to?
>>>
>>> Regards
>>> Ulrich
>>>
>>>        
>> Depends on what the problem is.  The official response probably would be
>> open a bugzilla.  Or talk to your support person.
>>
>> What is the problem you are seeing?
>>
>>      
> I have a RHEL4 Server on which I cannot execute telnet when being in
> enforcing mode, while in permissive mode it works without any problems.
> Plus I don't get any avc denies.
>
>
>
>    
id -Z


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
