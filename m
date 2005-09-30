Message-ID: <433D34DD.7080100@redhat.com>
Date: Fri, 30 Sep 2005 08:51:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   SELinux-dev@tresys.com
Subject: Re: [RFC][PATCH] New interface for loading policy
References: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil> <433CB578.6070303@cornell.edu>
In-Reply-To: <433CB578.6070303@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>
>> Comments?
>>
>>  
>>
> It doesn't belong in libselinux. I've had an implementation of this 
> for a long time, but I haven't submitted it, because we're changing 
> the plan (right). Boolean and user components will be handled by 
> semanage, using the dbase thing which I'm adding there. 
> Genbools/genusers will be deprecated. Semanage will compile a module, 
> and put users/booleans into that. Then it will re-link modules upon 
> change, and load_policy will ... load the policy.
>
> OTOH this may be a good way to get rid of this code from things like 
> init, which needs to happen anyway...
>
I agree this is a step toward the final solution.  But needs to happen now.

> P.S. Dan - please take a look at my mail that says that (1) gdm is 
> broken, because it doesn't pay attention to enforcing mode, 

This is fixed in rawhide. gdm-2.8.0.4-3

> and (2) MCS is not transparent upon install if you have defined users 
> in local.users (those are rejected post-mcs). Combined those two 
> things prevent you from logging in in *permissive* mode.
>
I will need to look into this.




-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
