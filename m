Message-ID: <4357D44F.5080000@cornell.edu>
Date: Thu, 20 Oct 2005 13:30:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] More work on policy_components.c
References: <4356F1B3.3060000@cornell.edu>	 <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>	 <4357D211.3090205@cornell.edu> <1129828287.2375.435.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129828287.2375.435.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-10-20 at 13:21 -0400, Ivan Gyurdiev wrote:
>   
>> The problem is from earlier patches - you can comment out the init() and 
>> release() code in direct_api.c - should eliminate any bugs. I didn't 
>> think something as simple would be broken. I'll fix the problem a bit 
>> later today...
>>     
>
> I think that this may help...
>   
doh...

Like I was saying :)
With that last patch I just sent, I can begin to test functionality, add 
error messages, fix bugs, and implement stubs.

The first thing I need to do is to figure out whether my 
dbase_policydb_cache function will work on policy.kern (but this is 
challenging, as I can't seem to get a policy.kern in the first place - 
commit keeps failing, and it's definitely not my fault that it does so...).

I should also focus a bit on sepol, where the interfaces need to be 
stabilized...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
