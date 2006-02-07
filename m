Message-ID: <43E8B145.4090907@cornell.edu>
Date: Tue, 07 Feb 2006 09:40:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why cron doesn't work in strict policy
References: <43E7C52E.601@cornell.edu> <43E7C804.3040507@cornell.edu> <43E8B013.8000000@redhat.com>
In-Reply-To: <43E8B013.8000000@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> cron ---> getseuserbyname(system_u)
>>> selinux <--- (user_u, s0)
>>> cron ---> get_default_context_with_level(user_u, s0)
>>> selinux <--- (user_u:user_r:user_xserver_t) (????)
>>> cron ---> security_compute_av(user_u:user_r:user_xserver_t, 
>>> system_u:object_r:system_cron_spool_t)
>>> selinux <-- not allowed
>>>
>>> The problem comes from system_u being mapped to __default__ in the 
>>> seusers file, although I have no idea why (user_u, s0) would return 
>>> default context of user_xserver_t either.
>> So for using system cronfiles, the getseuserbyname() call needs to be 
>> skilled (since you've already decided on the user - system_u, user.c: 
>> line 87). Not sure about level. Alternatively you can query using root.
> Seems to me we have two choices.  One is to change cron to default to 
> "root" when there is no username or to add system_u to the seusers file.
Well, on second thought querying root is not going to get you system_u 
in any way...
I think the seuser  query just needs to be skipped if you've decided to 
use system_u.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
