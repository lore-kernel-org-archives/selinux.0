Message-ID: <43E8B175.9080203@redhat.com>
Date: Tue, 07 Feb 2006 09:40:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why cron doesn't work in strict policy
References: <43E7C52E.601@cornell.edu> <43E7C804.3040507@cornell.edu>	 <43E8B013.8000000@redhat.com> <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-02-07 at 09:34 -0500, Daniel J Walsh wrote:
>   
>> Ivan Gyurdiev wrote:
>>     
>>>> cron ---> getseuserbyname(system_u)
>>>> selinux <--- (user_u, s0)
>>>> cron ---> get_default_context_with_level(user_u, s0)
>>>> selinux <--- (user_u:user_r:user_xserver_t) (????)
>>>> cron ---> security_compute_av(user_u:user_r:user_xserver_t, 
>>>> system_u:object_r:system_cron_spool_t)
>>>> selinux <-- not allowed
>>>>
>>>> The problem comes from system_u being mapped to __default__ in the 
>>>> seusers file, although I have no idea why (user_u, s0) would return 
>>>> default context of user_xserver_t either.
>>>>         
>>> So for using system cronfiles, the getseuserbyname() call needs to be 
>>> skilled (since you've already decided on the user - system_u, user.c: 
>>> line 87). Not sure about level. Alternatively you can query using root.
>>>       
>> Seems to me we have two choices.  One is to change cron to default to 
>> "root" when there is no username or to add system_u to the seusers file.
>>
>> Right now cron has the following code in it.
>>
>>     if (get_security_context(pw == NULL ? "system_u" : uname,
>>                  crontab_fd,
>>                  &u->scontext, tabname) != 0) {
>>         free_user(u);
>>         u = NULL;
>>         goto done;
>>     }
>>    
>>
>>
>> get_security_context()
>> ...
>>     if (getseuserbyname(name, &seuser, &level) == 0) {
>>         retval=get_default_context_with_level(seuser, level, NULL, 
>> &scontext);
>>         free(seuser);
>>         free(level);
>>         if (retval) {
>> ...
>>
>> Which causes cron jobs on strict policy and I would guess MLS to run at 
>> user_u since system_u is not defined and would run at level s0. 
>>     
>
> We should add system_u to seusers.
>
>   
system_u:system_u:s0-s0:c0.c255


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
