Message-ID: <41F91742.5090300@redhat.com>
Date: Thu, 27 Jan 2005 11:30:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Updated policy
References: <41F6A47E.9010407@redhat.com> <1106841450.28623.132.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106841450.28623.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-25 at 14:56, Daniel J Walsh wrote:
>  
>
>>Fixes for targeted crond to run as unconfined and still have transitions 
>>work.
>>    
>>
>
>I'm a little unclear on the current direction of the targeted policy.  I
>see that you are putting more programs like login and crond into
>domains, but then adding unconfined_domain() to them and allowing them
>to transition to unconfined_t.  What is the purpose of such domains?
>
>  
>
Two separate problems.

crond aliases as unconfined_t was causing transitions to not  work 
correctly.  IE in targeted
policy we do not want applications to transition unless they are started 
via init scripts.  So certain
apps had a rule domain_auto_trans(crond_t, XYZ_exec_t, XYZ_t) which was 
causing unconfined_t running XYZ_exec_t to transition.
So we needed a small crond to stop this.  system_crond_t and crond_t 
probably should be aliased so
confined apps that are started by either system_crond_t or crond_t will 
transition.

The login program was brought in because we were trying to get rlogind, 
telnetd, rshd policy to work. 
After working on it a couple of days we found that we ended up with 
little (none) added security in targeted policy, so
they should be pulled from targeted.  They all should work better in 
strict now.

>As a side note, do you truly want crond to run directly in
>system_crond_t (normally only used for system cron jobs in the strict
>policy, vs. crond_t for the daemon itself).
>
>  
>
I think they should be aliased, to make sure crond_t and system_crond_t 
transitions happen.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
