Message-ID: <4357D211.3090205@cornell.edu>
Date: Thu, 20 Oct 2005 13:21:21 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] More work on policy_components.c
References: <4356F1B3.3060000@cornell.edu> <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-19 at 21:24 -0400, Ivan Gyurdiev wrote:
>   
>> This patch makes the commit function shorter, and more intelligent, and 
>> implements a lot more of the "merge into base" function (but not all of 
>> it). It also adds comments in database.h about the behavior of the 
>> add(), modify(), and iterate() functions.
>>     
>
> Oops, this one causes memory errors on a semodule -b base.pp (per
> valgrind).
>   
That's not possible, because those patches don't touch that code path...

The problem is from earlier patches - you can comment out the init() and 
release() code in direct_api.c - should eliminate any bugs. I didn't 
think something as simple would be broken. I'll fix the problem a bit 
later today...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
