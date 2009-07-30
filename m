Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6U43tp4013465
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 00:03:55 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6U43S0p022539
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 04:03:29 GMT
Message-ID: <4A711BA7.6010308@redhat.com>
Date: Thu, 30 Jul 2009 00:03:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
CC: Christopher Pardy <cpardy@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is it safe to use ext4 for SELinux
References: <4A7083DB.4000003@gmail.com> <4A70894E.7000701@redhat.com> <4A708F41.2070902@gmail.com>
In-Reply-To: <4A708F41.2070902@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/29/2009 02:04 PM, Justin P. Mattock wrote:
> Christopher Pardy wrote:
>> On 07/29/2009 01:16 PM, Justin P. Mattock wrote:
>>   
>>> I've just downloaded the fedora 11 livecd and am installing it on an
>>> imac. during the partition scheme should I use ext4,
>>> or stick with ext3 for SELinux to function properly?
>>>
>>> Justin P. Mattock
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>      
>>
>> OMG wrong list!!!! send fedora related stuff to fedora-selinux please!
>> Also.... No, use ext4.
>>
>>    
> 
> I'll have to search for the lists to join.
> in the meantime it is possible to have
> SELinux on ext4
>
Yes SELinux should work on any file system that supports extended attributes.
 
> Justin P. Mattock
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
