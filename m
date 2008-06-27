Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5RKp5bV011138
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2008 16:51:05 -0400
Received: from hrndva-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5RKp4WT006182
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2008 20:51:05 GMT
Received: from lanikea.austin.rr.com ([70.116.65.78])
          by hrndva-omta04.mail.rr.com with ESMTP
          id <20080627205054.LQP18182.hrndva-omta04.mail.rr.com@lanikea.austin.rr.com>
          for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2008 20:50:54 +0000
Message-Id: <43CBE7F1-902A-4B27-8EC1-4D03F6A2A05B@austin.rr.com>
From: Nick Gray <nick@austin.rr.com>
To: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <26BD11F7-FA5A-4D58-A62D-A040148278A7@austin.rr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: SELinux backups
Date: Fri, 27 Jun 2008 15:50:53 -0500
References: <905B4D2C-5075-465B-89D2-E320F3DAB85C@austin.rr.com> <4863F5FB.3040601@windriver.com> <26BD11F7-FA5A-4D58-A62D-A040148278A7@austin.rr.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 26, 2008, at 5:06 PM, Nick Gray wrote:

>
> On Jun 26, 2008, at 3:03 PM, Vikram Ambrose wrote:
>
>> Nick Gray wrote:
>>> All,
>>>
>>> I would like to speak to anyone who has worked on, has experience  
>>> with, or just has a general interest in system/database backups on  
>>> SELinux.
>>>
>> What do you mean exactly?
>> a) Backing up the SELinux policy store on the system?
>> b) Backing up a system that runs SELinux?
>> c) Backing up a database running in an SELinux environment?
>> d) Storing system backups on an SELinux enabled filesystem?
>
> Yes :-)
>
> Primarily 2 & 3, but certainly not to exclude 1 & 4. I am interested  
> in a encompassing DRP. The prior system could do something akin to  
> an LVM snapshot and produce a bootable copy. I would like to know if  
> there has been any experimentation with SELinux along those lines.  
> Once that has been accomplished, I would move on to database backups  
> and incrementals.
>
>>
>>
>>> I searched my mail folder going back to about 2003 and found very  
>>> little said about it.
>>>
>>> I have been assigned this by the company I am working for and  
>>> would like to get a little insight into what has been done so far,  
>>> methods and issues encountered.
>>>
>>> Nick G.
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing  
>>> list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>>>  with
>>> the words "unsubscribe selinux" without quotes as the message.
>>
>>
>> -- 
>> Vikram Ambrose | Linux Products Division | WindRiver Corporation
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing  
>> list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>>  with
>> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
