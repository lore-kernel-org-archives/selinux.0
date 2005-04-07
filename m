Message-ID: <42558933.7050605@redhat.com>
Date: Thu, 07 Apr 2005 15:25:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am attempting to add a secadm_r
References: <425553ED.1040703@redhat.com>	 <1112892841.27110.52.camel@moss-spartans.epoch.ncsc.mil> <1112893854.27110.66.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1112893854.27110.66.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-04-07 at 12:54 -0400, Stephen Smalley wrote:
>  
>
>>Normally, to add a new user role, you would add the following lines to
>>domains/user.te:
>>	full_user_role(secadm)
>>This will define both a secadm_r role and a secadm_t domain, along with
>>associated types.  Then you can replace role and domain transitions for
>>sysadm with corresponding ones in the specific program domains like
>>checkpolicy, load_policy, setfiles, restorecon, etc so that secadm can
>>enter those domains but sysadm cannot.
>>    
>>
>
>Note that this will mean that you want to add a "secadm_r:secadm_t" line
>to the default_type file.   Then, if you add role_type_tty_change rules
>from whatever starting role you use for the user, then you should be
>able to newrole -r secadm_r to get to secadm_r:secadm_t.  Defining a new
>role without defining a new initial domain is pointless; you haven't
>achieved any real separation.
>
>  
>
Ok, this is the point I was trying to understand.  I was hoping I could 
define a role without defining
an initial type.  I was hoping for secadm_r:sysadm_t or 
secadm_r:staff_t.  Forcing a new initial type,
seems a little touch.  This causes the creation of new roles to be more 
difficult. 

I would have thought you could define a staff_t and then depending on 
which roles they were currently
under, which domains they could reach.

So staff_r:staff_t can not add users.
But useradd_r:staff_t can.

I would want to eliminate the su transition to sysadm_r:sysadm_t and 
force say a staff user to
newrole -r secadm_r

and become secadm_r:staff_t and then su and be able to do the 
checkpolicy/load_policy type stuff.

If I do full_user_role I get alot more privs then I necessarily want.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
