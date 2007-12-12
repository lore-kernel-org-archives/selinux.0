Message-ID: <475FF9B9.20005@manicmethod.com>
Date: Wed, 12 Dec 2007 10:09:45 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] [STABLE] Makefile change to disable restorecond
References: <475EED72.3090607@manicmethod.com>	 <475EEF4D.4000807@manicmethod.com> <1197404396.28006.111.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197404396.28006.111.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-12-11 at 15:13 -0500, Joshua Brindle wrote:
>   
>> Joshua Brindle wrote:
>>     
>>> This patch is necessary to build stable on RHEL4. CLIP uses the 
>>> current stable toolchain and supports RHEL4 as a target so we are 
>>> trying to upstream any magic that is necessary to build on that platform.
>>>
>>>       
>> Ignore last patch, this one is actually against stable :)
>>     
>
> What about just checking for the presence of /usr/include/sys/inotify.h
> and disabling restorecond in its absence, similar to handling of PAMH
> and AUDITH in newrole's Makefile?  Then that could go into trunk too.
>   

The next problem is that libselinux won't build on RHEL4 without 
building the .lo files with --ftls-model=initial-exec. Do you have an 
opinion on how to switch this on/off for building there?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
